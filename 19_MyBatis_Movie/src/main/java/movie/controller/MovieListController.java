package movie.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;
import utility.Paging;

@Controller
public class MovieListController {
	private final String command = "/list.mv";
	private final String getPage = "movieList";
	
	@Autowired
	MovieDao movieDao; 
	
	@RequestMapping(value = command)
	private ModelAndView list(
						 HttpServletRequest request,
						 @RequestParam(value = "whatColumn", required = false) String whatColumn,
						 @RequestParam(value = "keyword", required = false) String keyword,
						 @RequestParam(value = "pageNumber", required = false) String pageNumber
						) {
		//검색 설정 
		System.out.println("검색조건: " + whatColumn +"/"+ keyword);
		Map<String, String> map = new HashMap<String, String>(); 
		map.put("whatColumn", whatColumn); map.put("keyword", "%"+keyword+"%");
		
		 // 페이지 번호 링크 설정
			int totalCount = movieDao.getTotalCount(map);
			String url = request.getContextPath() + this.command;
			Paging pageInfo = new Paging(pageNumber,null,totalCount,url,whatColumn,keyword);
				 
		//영화 목록
		ModelAndView mav = new ModelAndView();
		
		List<MovieBean> movieList = movieDao.getMovieList(map, pageInfo);
		mav.addObject("movieList",movieList);
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("whatColumn",whatColumn);
		mav.addObject("keyword",keyword);
		mav.setViewName(getPage);
		
		return mav;
	}
}
