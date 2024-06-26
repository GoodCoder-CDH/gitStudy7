package movie.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import utility.Paging;

@Service("myMovieDao")
public class MovieDao {

private String namespace = "movie.MovieBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public MovieDao() {
		System.out.println("MovieDao 생성자");
	}
	
	
	public List<MovieBean> getMovieList(Map<String, String> map, Paging pageInfo) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<MovieBean> lists = new ArrayList<MovieBean>();
		lists = sqlSessionTemplate.selectList(namespace + ".getMovieList", map, rowBounds);
		System.out.println("lists.size():" + lists.size());
		
		return lists;
	}
	
	public int getTotalCount(Map<String, String> map) {
		int count = -1;
		count = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		System.out.println("totalCount: " + count);
		return count;
	}
	
	public int insertMovie(MovieBean movie) {
		int cnt = -1;
		try {
		cnt = sqlSessionTemplate.insert(namespace + ".insertMovie", movie);
		}catch(DataAccessException e){
			System.out.println("insert 에러 발생");
			System.out.println("cnt : " + cnt);
		}
		return cnt;
	}
	
	public int searchTitle(String inputtitle) {
		int count = -1;
		count = sqlSessionTemplate.selectOne(namespace + ".searchTitle", inputtitle);
		return count;
	}
	
	public MovieBean getMovieContent(int num) {
		MovieBean mb = null;
		mb = sqlSessionTemplate.selectOne(namespace + ".getMovieContent", num);
		return mb;
	}
	
	public int deleteMovie(int num) {
		int count = -1;
		count = sqlSessionTemplate.delete(namespace + ".deleteMovie", num);
		return count;
	}

	public int updateMovie(MovieBean movie) {
		int count = -1;
		count = sqlSessionTemplate.update(namespace + ".updateMovie", movie);
		return count;
	}
	
}
