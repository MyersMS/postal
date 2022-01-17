SELECT					
	--DISTINCT pc.delivery_zone,  				
	pc.country,				
	pc.code as postal_code,				
	pc.can_ship_to,				
	pc.can_self_schedule,				
	--'FALSE' AS can_self_schedule,				
	w.code AS warehouse_code,				
	pc.delivery_zone,				
	--CASE				
		--WHEN pc.time_zone = 'America/Phoenix' THEN CONCAT(w.code,'_phx')			
		--WHEN pc.time_zone = 'America/New_York' THEN CONCAT(w.code,'_et')			
		--WHEN pc.time_zone = 'America/Chicago' THEN CONCAT(w.code,'_ct')			
		--WHEN pc.time_zone = 'America/Los_Angeles' THEN CONCAT(w.code,'_pt')			
		--WHEN pc.time_zone = 'America/Toronto' THEN CONCAT(w.code,'_et')			
		--WHEN pc.time_zone = 'America/Denver' THEN CONCAT(w.code,'_mt')			
	--END "delivery_zone",  				
					
	CASE				
		WHEN sw.code IS NOT NULL THEN sw.code			
	ELSE w.code END AS service_warehouse_code,'whiteglove' AS standard_level_of_service,				
					
	pc.service_zone,				
	sqp.currency,				
	sqp.default_parcel_rate_in_cents,				
	sqp.first_bike_price_in_cents,				
	sqp.extra_bike_price_in_cents,				
	sqp.first_tread_price_in_cents,				
	sqp.extra_tread_pice_in_cents as extra_tread_price_in_cents,				
	sqp.is_less_than_load_delivery,				
	pc.ups_hub_code,				
	time_zone,				
	w.partner_flag --AS delivery_provider,				
	--w.can_ship_accessories delivery_accessories,				
	--w.can_ship_spare_parts delivery_spare_parts,				
	--sw.partner_flag AS service_provider,				
	--sw.can_ship_accessories service_accessories,				
	--sw.can_ship_spare_parts service_spare_parts				
FROM					
	postalcode pc				
					
	LEFT JOIN 				
		shipmentquoteprices sqp ON pc.shipment_quote_prices_id = sqp.pk			
	LEFT JOIN 				
		warehouse w ON pc.warehouse_id = w.pk			
	LEFT JOIN 				
		warehouse sw ON pc.service_warehouse_id = sw.pk			
					
	--LEFT JOIN peloton_order o ON o.shipping_postal_code = pc.code AND o.shipping_country = pc.country				
	--LEFT JOIN shipment s ON o.pk = s.order_id				
					
WHERE 					
	pc.can_ship_to = 'True'				
					
	--AND w.shipping_country != 'Germany'				
	--WHERE pc.country IN ('CA','GB','DE')				
	--AND pc.country IN ('US','CA')				
	--AND sqp.default_parcel_rate_in_cents IS NULL				
	--AND pc.can_ship_to = 'true'				
					
	AND 				
		pc.country = 'CA'			
					
	----AND (w.can_ship_accessories = 'FALSE' OR w.can_ship_spare_parts = 'FALSE' OR sw.can_ship_accessories = 'FALSE' OR sw.can_ship_spare_parts = 'FALSE')				
	--AND sqp.default_parcel_rate_in_cents > 0				
	--AND pc.code IN ('81632')				
	--AND pc.can_self_schedule = 'TRUE'				
	--AND w.code IN ('peloton_warehouse_syosset', 'peloton_warehouse_carteret', 'peloton_warehouse_secaucus', 'peloton_warehouse_farmingdale', 'peloton_warehouse_boston', 'peloton_warehouse_alexandria', 'peloton_warehouse_washington_dc', 'peloton_warehouse_montebello', 'peloton_warehouse_mt_vernon')				
	--------country codes DE, US, GB, CA				
	--AND sqp.is_less_than_load_delivery = 'TRUE'				
					
	AND 				
		w.code IN ('amj_warehouse_halifax')			
	--AND w.partner_flag IN ('jbhunt')--,'xpo-clm')				
	--AND sw.partner_flag  LIKE 'SELECT%'				
	--AND sqp.is_less_than_load_delivery = 'FALSE'				
	--AND sw.code = 'peloton_warehouse_lakeland'				
	--AND sw.partner_flag != 'peloton-fsl'				
	--AND pc.delivery_zone IN ('dz_billerica_gorham', 'dz_mt_vernon_new_haven', 'dz_franklin_park_antioch', 'dz_franklin_park_munster', 'dz_detroit_adrian', 'dz_detroit_burton')				
	--AND pc.service_zone NOT LIKE 'sz_%'				
	--AND pc.delivery_zone LIKE 'xlm-den_dist_weekof%'				
	--AND pc.code IN ()				
	--AND pc.country = 'CA'				
	--AND sqp.standard_level_of_service = 'Curbside'				
	--AND pc.country = 'GB'				
	--AND pc.country != 'DE'				
	--AND sqp.first_bike_price_in_cents != '0'				
	--AND pc.delivery_zone = 'dz_franklin_park_chicago_north'				
	--AND pc.time_zone = 'America/Puerto_Rico'				
	--AND pc.can_ship_to = 'true'				
	--AND w.code LIKE 'winnings%'				
	--AND sqp.first_bike_price_in_cents = '0'				
	--AND pc.can_self_schedule = 'false'				
	--AND pc.delivery_zone IN ('dz_mt_vernon_oxford', 'dz_mt_vernon_new_haven')				
	--AND (pc.service_zone LIKE '%unknown%' or pc.delivery_zone LIKE '%unknown%')				
	--AND pc.delivery_zone LIKE lower('XLM-BHM_0-75%')				
	--AND pc.code = 'L5P'				
	--AND pc.service_zone NOT LIKE 'sz_%'				
	--AND pc.service_zone = 'sz_sandiego'				
	--AND (pc.service_zone = 'sz_neumunster' OR pc.delivery_zone = 'dz_neumunster' OR w.code = 'peloton_warehouse_neumunster' OR sw.code = 'peloton_warehouse_neumunster')				
	--AND pc.delivery_zone IS NULL				
	--AND pc.code LIKE 'B%'		Check if postal code is present or not		
	--AND pc.service_zone LIKE 'dz_%AND (sqp.is_less_than_load_delivery = TRUE or pc.can_ship_to = 'FALSE')				
--ORDER BY pc.code ASC					
					
ORDER BY 					
	pc.can_ship_to DESC,pc.country DESC, w.partner_flag ASC, w.code DESC				
