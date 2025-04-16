% initialized the cosmetics products

cosmetics(day_cream, green_mineral_water,men, one_thousand_three_hundred_rupees).
cosmetics(night_cream, green_mineral_water, men, one_thousand_five_hundred_rupees).

cosmetics(day_cream, green_mineral_water, women, one_thousand_three_hundred_rupees).
cosmetics(night_cream, green_mineral_water, women, one_thousand_five_hundred_rupees).

cosmetics(body_lotion, alovera, men, two_thousand_one_hundred_rupees).
cosmetics(body_lotion, cucumber, men, two_thousand_rupees).
cosmetics(body_lotion, papaya, men, one_thousand_nine_hundred_rupees).

cosmetics(body_lotion, alovera, women, two_thousand_one_hundred_rupees).
cosmetics(body_lotion, cucumber, women, two_thousand_rupees).
cosmetics(body_lotion, papaya, women, one_thousand_nine_hundred_rupees).

cosmetics(goldern_beauty_face_cream, mineral_oil_and_cocova, unisex, three_thousand_seven_hundred_rupees).

cosmetics(shampoo, hair_fall_rescue, women, one_thousand_eight_hundred_rupees).
cosmetics(shampoo, intense_repaire, women, one_thousand_seven_hundred_fity_rupees).
cosmetics(shampoo, straight_and_silky, women, eight_hundred_rupees).
cosmetics(shampoo, nourshine_oil_care, women, one_thousand_hundred_rupees).

cosmetics(shampoo, men_care_fresh_and_clean_fortifying, men, six_hundred_rupees).
cosmetics(shampoo, men_care_anti_dandruff, men, five_hundred_rupees).
cosmetics(shampoo, men_thick_and_strong_fortify, men, one_thousand_eight_hundred_rupees).
cosmetics(shampoo, acqua_impact_fortify, men, six_hundred_fifty_rupees).

beauty_products(a):-cosmetics(a, b, men, c).

%cream types base on customer request
display(Cream, Ingrediant, Sex, Price) :-
	cosmetics(Cream, Ingrediant, Sex, Price).

%show cream type if they belong to either day cream or night cream
display(Cream, Ingrediant, Sex, Price) :-
	cosmetics(Cream, Ingrediant, Sex, Price),
	(Cream=night_cream; Cream=day_cream).

ask_customer_request :-
	write('Enter Your preferred cream(day_cream, night_cream): '),
	read(Cream),
	write('Enter your Gender : '),
	read(Sex),
	display(Cream, Ingrediant, Sex, Price),nl,
	write('You can buy Velora '), write(Cream),nl,
	write('Ingrediant : '), write(Ingrediant),nl,
	write('Price : '),write(Price).

discount(yes) :-
	buy_full_package(Item),
	buy_day_cream(true),
	buy_body_lotion(true),
	buy_shampoo(true),
	Item==3.
	
discount(no).

start_one:-
	nl,
	write('===Velora Product & Service ==='),nl,

	write('Enter number of item which you buy : '),
	read(Item),
	assertz(buy_full_pacakage(Item)),

	write('Will you buy Day Cream? (yes/no)'),
	read(DayCreamInput),
	(DayCreamInput == yes -> DayCream = true ; DayCream = false),
	assertz(buy_day_cream(DayCream)),

	write('Will you buy Body Lotion? (yes/no)'),
	read(BodyLotionInput),
	(BodyLotionInput == yes -> BodyLotion = true ; BodyLotion = false),
	assertz(buy_body_lotion(BodyLotion)),

	write('Will you buy Shampoo? (yes/no)'),
	read(ShampooInput),
	(ShampooInput == yes -> Shampoo = true ; Shampoo = false),
	assertz(buy_shampoo(Shampoo)),nl,

	%is full fill the requirement?
	(Item==3, DayCream, BodyLotion, Shampoo ->
		write('You got thousand rupees discount. '), nl
	;
		write('You are not eligible for our discount benifits. ')).
	

body_lotion(yes) :-
	gender(Gender),
	dry_skin(true),
	normal_skin(true),
	oily_skin(true),
	Gender==men,
	Gender == women.
	
body_lotion(no).
	
body_lotion_dry:-
		nl,
		write('===Velora Product & Service ==='),nl,
		
		write('Enter your Gender : '),
		read(Gender),
		assertz(gender(Gender)),
	
		write('Do you have dry skin(yes/no)'),
		read(DrySkinInput),
		(DrySkinInput == yes -> Dry =true ; Dry =false),
		assertz(dry_skin(Dry)),nl,

		(Gender == women, Dry ->
			write('You can go with our Alovera Body Lotion of Velora Brand for women. '),nl
		;
			write('If you like you can buy our other products of Velora Brand. ')),nl,

		(Gender == men, Dry ->
			write('Addition to that Body Lotion.'),
			write('You can go with our Alovera Body Lotion of Velora Brand for men. ')).
		
body_lotion_normal:-
		nl,
		write('===Velora Product & Service ==='),nl,
		
		write('Enter your Gender : '),
		read(Gender),
		assertz(gender(Gender)),


		write('Do you have normal skin(yes/no)'),
		read(NormalSkinInput),
		(NormalSkinInput == yes -> Normal =true ; Normal =false),
		assertz(normal_skin(Normal)),nl,


		(Gender == women, Normal ->
			write('You can go with our Papaya Body Lotion of Velora Brand for women. '),nl
		;
			write('You can go with our Papaya Body Lotion of Velora Brand for men. ')),nl,

		(Gender == men, Normal ->
			write('Addition to that Body Lotion.'),
			write('You can go with our Papaya Body Lotion of Velora Brand for women. ')).


body_lotion_oily:-
		nl,
		write('===Velora Product & Service ==='),nl,
		
		write('Enter your Gender : '),
		read(Gender),
		assertz(gender(Gender)),



		write('Do you have oily skin(yes/no)'),
		read(OilySkinInput),
		(OilySkinInput == yes -> Oily =true ; Oily =false),
		assertz(oily_skin(Oily)),nl,
					
		(Gender == women, Oily ->
			write('You can go with our Cucumber Body Lotion of Velora Brand for women. '),nl
		;
			write('You can go with our Cucumber Body Lotion of Velora Brand for women. ')),nl,
	
		(Gender == men, Oily ->
			write('Addition to that Body Lotion.'),
			write('You can go with our Cucumber Body Lotion of Velora Brand for women. ')).

%Reccomend shampoo base on their hair type.
recommend(Cleaner, Type, Sex, Price):-
	cosmetics(Cleaner, Type, Sex, Price).

%Recommend shampoo it they belong either Female or Male hair type
recommend_shampoo(Cleaner, Type, Sex, Price):-
	cosmetics(Cleaner, Type, Sex, Price),
	(Type = hair_fall_rescue; Type = intense_repaire; Type = straight_and_silky; Type = nourshine_oil_care; Type = men_care_fresh_and_clean_fortifying; Type = men_care_anti_dandruff; Type = men_thick_and_strong_fortify; Type = acqua_impact_fortify).

ask_customer_preferencess_one:-
	write('Enter your prefered Shampoo (hair_fall_rescue, intense_repaire):'),
	read(Type),
	recommend(Cleaner, Type, Sex, Price),
	write('Your might like '), write(Type),write(' '),write(Cleaner),write(' for '),write(Sex),write(' of Velora Brand.'),nl,
	write('Price : '), write(Price).

	
ask_customer_preferencess_two:-
	write('Enter your prefered Shampoo(straight_and_silky, nourshine_oil_care):'),
	read(Type),
	recommend(Cleaner, Type, Sex, Price),
	write('Your might like '), write(Type),write(' '),write(Cleaner),write(' for '),write(Sex),write(' of Velora Brand.'),nl,
	write('Price : '), write(Price).


ask_customer_choice_one:-
	write('Enter your prefered Shampoo(men_care_fresh_&_clean_fortifying, men_care_anti_dandruff) : '),
	read(Type),
	recommend(Cleaner, Type, Sex, Price),
	write('Your might like '), write(Type),write(' '),write(Cleaner),write(' for '),write(Sex),write(' of Velora Brand.'),nl,
	write('Price : '), write(Price).


ask_customer_choice_two:-
	write('Enter your prefered Shampoo(men_thick_and_strong_fortify, acqua_impact_fortify):'),
	read(Type),
	recommend(Cleaner, Type, Sex, Price),
	write('Your might like '), write(Type),write(' '),write(Cleaner),write(' for '),write(Sex),write(' of Velora Brand.'),nl,
	write('Price : '), write(Price).



