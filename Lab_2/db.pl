%%---------------------------               
%% Meros 1
%%---------------------------

%% 1) Find movies with very common theme:
common_theme_1(M1,M2) :- id(M2,_),M1\=M2,check_themes_1(M1,M2).
check_themes_1(M1,M2) :- genre(M1,A), genre(M1,B), genre(M1,C), genre(M1,D),
    genre(M2,A), genre(M2,B), genre(M2,C), genre(M2,D),
    A\=B, A\=C, A\=D,B\=C, B\=D, C\=D,M1\=M2,!.

%% 2) Find movies with relatively common theme:
common_theme_2(M1,M2) :- id(M2,_),M1\=M2,check_themes_2(M1,M2).
check_themes_2(M1,M2) :- genre(M1,A), genre(M1,B), genre(M1,C),genre(M2,A), 
    genre(M2,B), genre(M2,C), A\=B, A\=C, B\=C,  M1\=M2,!.

%% 3) Find movies with less common theme:
common_theme_3(M1,M2) :- id(M2,_),M1\=M2,check_themes_3(M1,M2).
check_themes_3(M1,M2) :- genre(M1,A), genre(M2,A), M1\=M2,!.

%% 4) Find movies with the same director:
same_director(M1,M2) :- id(M2,_),M1\=M2,check_director(M1,M2).
check_director(M1,M2) :- director(M1,Z), director(M2, Z),M1\=M2,!.

%% 5) Find movies with the same plot (4 same keywords):
same_plot_1(M1,M2) :- id(M2,_),M1\=M2,check_plot_1(M1,M2).
check_plot_1(M1,M2) :- plot_keywords(M1,A),plot_keywords(M2,A), plot_keywords(M1,B), 
    plot_keywords(M2,B),A\=B, plot_keywords(M1,C), plot_keywords(M2,C),
    A\=C,B\=C,plot_keywords(M1,D), plot_keywords(M2,D), A\=D, B\=D,C\=D,M1\=M2 ,!.

%% 6) Find movies with the relatively same plot (2 same keywords):
same_plot_2(M1,M2) :- id(M2,_),M1\=M2,check_plot_2(M1,M2).
check_plot_2(M1,M2) :- plot_keywords(M1,A), plot_keywords(M1,B),
    plot_keywords(M2,A), plot_keywords(M2,B),A\=B,M1\=M2,!.

%% 7) Find movies with the 3 main actors common:
same_main_actors_1(M1,M2) :- id(M2,_),M1\=M2,check_actors_1(M1,M2).            
actor(M1,A) :- actor_1_name(M1,A);actor_2_name(M1,A);actor_3_name(M1,A).
check_actors_1(M1,M2) :- actor(M1,A), actor(M1,B), actor(M1,C),
    actor(M2,A), actor(M2,B), actor(M2,C), A\=B, A\=C,B\=C, M1\=M2,!.

%% 8) Find movies with only 2 actors common:
same_main_actors_2(M1,M2) :- id(M2,_),M1\=M2,check_actors_2(M1,M2).
check_actors_2(M1,M2) :- actor(M1,A), actor(M1,B),actor(M2,A), actor(M2,B),A\=B, M1\=M2,!.

%% 9) Find movies with only 1 actor common:
same_main_actors_3(M1,M2) :- id(M2,_),M1\=M2,check_actors_3(M1,M2).
check_actors_3(M1,M2) :- actor(M1,A), actor(M2,A),M1\=M2,!.

%% 10) Find movies with the same language:
same_language(M1,M2) :- id(M2,_),M1\=M2,check_language(M1,M2).
check_language(M1,M2) :- spoken_languages(M1,_,L), spoken_languages(M2,_,L), M1\=M2,!.

%% 11) Find movies that have the same color:
same_color(M1,M2) :- plot_keywords(M1, 'black and white'), plot_keywords(M2, 'black and white'), M1\=M2.

%% 12) Find movies with a joint production studio:
same_production_company(M1,M2) :- id(M2,_),M1\=M2,check_same_production_company(M1,M2).
check_same_production_company(M1,M2) :- production_companies(M1,N,I), production_companies(M2,N,I), M1\=M2,!.

%% 13) Find movies with the same production country:
same_production_country(M1,M2) :- id(M2,_),M1\=M2,check_same_production_country(M1,M2).
check_same_production_country(M1,M2) :- production_countries(M1,N,I), production_countries(M2,N,I), M1\=M2,!.

%% 14) Find movies with the same production decade:
same_decade(M1,M2):-title_year(M1,Y1),title_year(M2,Y2),string_to_list_of_characters(Y1,[N1,N2,N3|_]),
    string_to_list_of_characters(Y2,[N1,N2,N3|_]).
string_to_list_of_characters(String, Characters) :- name(String, Xs), maplist( number_to_character, Xs, Characters ).
number_to_character(Number, Character) :-name(Character, [Number]).

%%---------------------------               
%% Meros 2
%%---------------------------

%%Gets value for each of the fields bellow and adds them all to form Nout

find_simmilar_movies_5(M1, M2):-get_all_sum(M1,M2,Nout),Nout>=50.
find_simmilar_movies_4(M1, M2):-get_all_sum(M1,M2,Nout),Nout>=40,Nout<50.
find_simmilar_movies_3(M1, M2):-get_all_sum(M1,M2,Nout),Nout>=30,Nout<40.
find_simmilar_movies_2(M1, M2):-get_all_sum(M1,M2,Nout),Nout>=20,Nout<30.
find_simmilar_movies_1(M1, M2):-get_all_sum(M1,M2,Nout),Nout<20.

get_all_sum(M1,M2,Nout):-id(M2,_),get_sum(M1,M2,Nout).

get_Value(1,15).
get_Value(2,10).
get_Value(3,5).
abs2(X,Y) :- X < 0 -> Y is -X ; Y = X.

get_sum(M1,M2,Nout):-get_theme_sum(M1,M2,0,N1),get_plot_sum(M1,M2,N1,N2),get_actor_sum(M1,M2,N2,N3),
    get_country_sum(M1,M2,N3,N4),get_director_sum(M1,M2,N4,N5),get_language_sum(M1,M2,N5,N6),
    get_production_sum(M1,M2,N6,N7),get_decade_sum(M1,M2,N7,Nout).


get_theme_sum(M1,M2,Nin,Nout):-common_theme_1(M1,M2)->(get_Value(1,V),Nout is Nin+V,!);
    (common_theme_2(M1,M2)->(get_Value(2,V),Nout is Nin+V,!);
    (common_theme_3(M1,M2)->(get_Value(3,V),Nout is Nin+V,!);Nout is Nin,!)).

get_plot_sum(M1,M2,Nin,Nout):-same_plot_1(M1,M2)->(get_Value(1,V),Nout is Nin+V,!);
    same_plot_2(M1,M2)->(get_Value(2,V),Nout is Nin+V,!);Nout is Nin,!.

get_actor_sum(M1,M2,Nin,Nout):-same_main_actors_1(M1,M2)->(get_Value(1,V),Nout is Nin+V,!);
    (same_main_actors_2(M1,M2)->(get_Value(2,V),Nout is Nin+V,!);
    (same_main_actors_3(M1,M2)->(get_Value(3,V),Nout is Nin+V,!);Nout is Nin,!)).

get_country_sum(M1,M2,Nin,Nout):-same_production_country(M1,M2)->(get_Value(1,V), Nout is V+Nin,!); (Nout is Nin,!).

get_director_sum(M1,M2,Nin,Nout):-same_director(M1,M2)-> (get_Value(1,V), Nout is V+Nin,!); Nout is Nin,!.

get_language_sum(M1,M2,Nin,Nout):-same_language(M1,M2)-> (get_Value(1,V), Nout is V+Nin,!); Nout is Nin,!.

get_production_sum(M1,M2,Nin,Nout):-same_production_company(M1,M2)->(get_Value(1,V), Nout is V+Nin,!); Nout is Nin,!.

get_decade_sum(M1,M2,Nin,Nout):-same_decade(M1,M2)-> (get_Value(1,V), Nout is V+Nin,!); Nout is Nin,!.


