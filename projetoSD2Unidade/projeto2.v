module projeto2(data,A,CLK,B,RS,RW,EN,Soma,Multi,igual,led,Sub,result_sinal,sinalA,sinalB);

input Soma,Sub,Multi,igual,CLK,sinalA,sinalB;
input [7:0] A,B;
output reg RS,RW,EN, result_sinal,led=1; //result_end = sinal(caracter) do resultado final
integer contador=0,cont=0,cont2=0,contNum=0,contadorPularLinha=0;
reg [4:0]iniciou;
output reg [7:0] data;
reg [7:0] centenaA,dezenaA,unidadeA,resultDezenaMilhar,resultUnidadeMilhar,resultCentena,resultDezena,resultUnidade;
reg[15:0] result;
reg flagSoma=0,flagSub=0,flagIgual=0,flagMulti=0,limpou=0,escreverResult=0;
	always @(posedge CLK) begin
		contador=contador+1;
		if(contador==2250000)begin
			contador=0;
			iniciou<=5'b00001;
		end
		case(iniciou) 
				1: begin 
						contador=0;
						RS=0;
						RW=0;
						EN=1;
						data<=8'b00111000;
						cont2=cont2+1;
						if(cont2==125000)begin
							iniciou <= 5'b00010;
							cont2=0;
						end
						else begin
							iniciou<=5'b00001;
						end
				end
				2:begin
					contador=0;
					cont2=cont2+1;
					EN=0;
					if(cont2==250000)begin
						cont=cont+1;
						cont2=0;
						if(cont==4)begin
							iniciou<=5'b00011;
						end
						else begin
							iniciou<=5'b00001;
						end
					end
					else begin 
						iniciou<=5'b00010;
					end
				end
				3:begin
					contador=0;
					RS=0;
					RW=0;
					EN=1;
					data<=8'b00001111;
					cont2=cont2+1;
					if(cont2==125000)begin
						cont2=0;
						iniciou<=5'b00100;
					end
					else begin
						iniciou<=5'b00011;
					end
				end
				4:begin
					contador=0;
					cont2=cont2+1;
					EN=0;
					if(cont2==250000)begin
						cont2=0;
						iniciou<=5'b00101;
					end
					else begin
						iniciou<=5'b00100;
					end
				end
				5:begin
					led=0;
					contador=0;
					if(cont2==125000)begin
						cont2=0;
						iniciou<=5'b00110;
					end
					else begin
						RS=0;
						RW=0;
						EN=1;
						data<=8'b00000001;
					end
					cont2=cont2+1;
				end
				6:begin
					contador=0;
					EN=0;
					cont2=cont2+1;
					if(cont2==250000)begin
						cont2=0;
						iniciou<=5'b00111;
					end
					else begin
						iniciou<=5'b00110;
					end
				end
				7:begin
					contador=0;
					RS=0;
					RW=0;
					EN=1;
					data<=8'b00000110;
					cont2=cont2+1;
					if(cont2==125000)begin
						cont2=0;
						iniciou<=5'b01000;
					end
					else begin
						iniciou<=5'b00111;
					end
				end
				8:begin
					contador=0;
					EN=0;
					cont2=cont2+1;
					if(cont2==250000)begin
						cont2=0;
						iniciou<=5'b01101;
					end
					else begin
						iniciou<=5'b01000;
					end
				end
				10:begin 
					contador=0;
					EN=0;
					cont2=cont2+1;
					if(cont2==250000)begin
						cont2=0;
                        iniciou<=5'b01101;
					end
					else begin
						iniciou<=5'b01010;
					end
				end
				13:begin
					contador=0;
					if(flagSoma==0 && Soma==0)begin
						flagSoma=1;
					end
					if(flagSoma==1 && Soma==1)begin
						if(limpou==1)begin
							iniciou<=5'b01011;//estado 11
						end
						else begin
							iniciou<=5'b01110;
						end
					end
					if(flagSub==0 && Sub==0)begin
						flagSub=1;
					end
					if(flagSub==1 && Sub==1)begin
						if(limpou==1)begin
							iniciou<=5'b01001;//estado 9
						end
						else begin
							iniciou<=5'b01110;
						end
					end
					if(flagMulti==0 && Multi==0)begin
						flagMulti=1;
					end
					if(flagMulti==1 && Multi==1)begin
						if(limpou==1)begin
							iniciou<=5'b01100;//estado 12
						end
						else begin
							iniciou<=5'b01110;
						end
					end
					if(flagIgual==0 && igual==0)begin
						flagIgual=1;
					end
					if(flagIgual==1 && igual==1)begin
						iniciou<=5'b01111;
					end
					if(escreverResult==1)begin
						iniciou<=5'b10000;
					end
				end
                11:begin 
					RS=1;
                    RW=0;
                    EN=1;
                    contador=0;
                     if(contNum==0)begin
                        if(sinalA==1)begin
                            data<=8'b00101101;
                        end
                        else begin
                            data<=8'b00100000;
                        end
						cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==1)begin
                        centenaA<=(A/100);
                        data<=centenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==2)begin
                        dezenaA<=((A%100)/10);
                        data<=dezenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==3)begin
                        unidadeA<=((A%100)%10);
                        data<=unidadeA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==4)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==5)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==6)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==7)begin
                        data<=8'b00101011;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==8)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==9)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==10)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                     else if(contNum==11)begin
                        if(sinalB==1)begin
                            data<=8'b00101101;
                        end
                        else begin
                            data<=8'b00100000;
                        end
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==12)begin
                        centenaA<=(B/100);
                        data<=centenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==13)begin
                        dezenaA<=((B%100)/10);
                        data<=dezenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==14)begin
                        unidadeA<=((B%100)%10);
                        data<=unidadeA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==15)begin
						data<=8'b00100000;
						cont2=cont2+1;
						if(cont2==125000)begin
							flagSoma=0;
							contNum=0;
							cont2=0;
							iniciou<=5'b01010;
							limpou=0;
						end
                    end
                    if(sinalA == 1 && sinalB == 1)begin // - -
                            result <= A + B;
                            result_sinal = 1; 
                    end
                    else if(sinalA == 1 && sinalB == 0)begin // - + 
                        if(A>B)begin
                            result <= A-B;
                            result_sinal = 1;
                        end
						if(B>A)begin
                            result <= B-A;
                            result_sinal = 0; 
                        end
                    	if(A==B)begin
                        	result <= A-B;
                        	result_sinal = 0;
                    	end                           
                	end
                    else if(sinalA == 0 && sinalB == 1)begin // + -
                            if(A>B)begin
                            	result <= A-B;
                            	result_sinal = 0;
                            end
                            if(B>A)begin
                                result <= B-A;
                                result_sinal = 1; 
                            end
                            if(A==B)begin
                                result <= A-B;
                                result_sinal = 0;
                            end
                    end
                    else  if(sinalA == 0  && sinalB == 0)begin // + +
                        result <= A + B;
                        result_sinal = 0;
                    end
            	end
				9:begin
					RS=1;
					RW=0;
					EN=1;
					contador=0;
					if(contNum==0)begin
                    	if(sinalA==1)begin
                            data<=8'b00101101;
                        end
                        else begin
                            data<=8'b00100000;
                        end
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==1)begin
                        centenaA<=(A/100);
                        data<=centenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==2)begin
                        dezenaA<=((A%100)/10);
                        data<=dezenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==3)begin
                        unidadeA<=((A%100)%10);
                        data<=unidadeA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==4)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==5)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==6)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==7)begin
                        data<=8'b00101101;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==8)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==9)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==10)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                     else if(contNum==11)begin
                        if(sinalB==1)begin
                            data<=8'b00101101;
                        end
                        else begin
                            data<=8'b00100000;
                        end
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==12)begin
                        centenaA<=(B/100);
                        data<=centenaA+8'b00110000;
                       	cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==13)begin
                        dezenaA<=((B%100)/10);
                        data<=dezenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==14)begin
                        unidadeA<=((B%100)%10);
                        data<=unidadeA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
					end
					else if(contNum==15)begin
						data<=8'b00100000;
						cont2=cont2+1;
						if(cont2==125000)begin
							flagSub=0;
							contNum=0;
							cont2=0;
							iniciou<=5'b01010;
							limpou=0;
						end
                    end
                        if(sinalA == 1 && sinalB == 1)begin // - -
                            if(A>B)begin
                              result <= A-B;
                              result_sinal = 1;
                            end
                            if(B>A)begin
                                result <= B-A;
                                result_sinal = 0; 
                            end
                            if(A==B)begin
                                result <= A-B;
                                result_sinal = 0;
                            end                            
                        end
                        if(sinalA == 1 && sinalB == 0)begin // - + 
                            if(A>B)begin
                              result <= A+B;
                              result_sinal = 1;
                            end
                            if(B>A)begin
                                result <= A+B;
                                result_sinal = 1; 
                            end
                            if(A==B)begin
                                result <= A+B;
                                result_sinal = 1;
                            end                           
                        end
                        if(sinalA == 0 && sinalB == 1)begin // + -
                            if(A>B)begin
                              result <= A+B;
                              result_sinal = 0;
                            end
                            if(B>A)begin
                                result <= A+B;
                                result_sinal = 0; 
                            end
                            if(A==B)begin
                                result <= A+B;
                                result_sinal = 0;
                            end
                        end
                        if(sinalA == 0  && sinalB == 0)begin // + +
                             if(A>B)begin
                              result <= A-B;
                              result_sinal = 0;
                            end
                            if(B>A)begin
                                result <= B-A;
                                result_sinal = 1; 
                            end
                            if(A==B)begin
                                result <= A-B;
                                result_sinal = 0;
                            end        
                        end           
				end
				12:begin
					RS=1;
                    RW=0;
                    EN=1;
					contador=0;
					if(contNum==0)begin
                        if(sinalA==1)begin
                            data<=8'b00101101;
                        end
                        else begin
                            data<=8'b00100000;
                        end
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==1)begin
                        centenaA<=(A/100);
                        data<=centenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==2)begin
                        dezenaA<=((A%100)/10);
                        data<=dezenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==3)begin
                        unidadeA<=((A%100)%10);
                        data<=unidadeA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==4)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==5)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==6)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==7)begin
                        data<=8'b00101010;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==8)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==9)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==10)begin
                        data<=8'b00100000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                     else if(contNum==11)begin
                        if(sinalB==1)begin
                            data<=8'b00101101;
                        end
                        else begin
                            data<=8'b00100000;
                        end
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==12)begin
                        centenaA<=(B/100);
                        data<=centenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==13)begin
                        dezenaA<=((B%100)/10);
                        data<=dezenaA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else  if(contNum==14)begin
                        unidadeA<=((B%100)%10);
                        data<=unidadeA+8'b00110000;
                        cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
                    else if(contNum==15)begin
						data<=8'b00100000;
						cont2=cont2+1;
						if(cont2==125000)begin
							flagMulti=0;
							contNum=0;
							cont2=0;
							iniciou<=5'b01010;
							limpou=0;
						end
                    end
                   if(sinalA == sinalB)begin
                      result <= A * B;
                      result_sinal = 0;
                   end
                   if(sinalA != sinalB)begin
                      result <= A * B;
                      result_sinal = 1;  
                   end
			end
			14:begin
					contador=0;
					cont2=cont2+1;
					if(cont2==125000)begin
						cont2=0;
						iniciou<=5'b01010;
						limpou=1;
					end
					else begin
						RS=0;
						RW=0;
						EN=1;
						data<=8'b00000001;
					end
			end
			15:begin
				RS=1;
                RW=0;
                EN=1;
                if(contadorPularLinha==23)begin
					contadorPularLinha=0;
					flagIgual=0;
					escreverResult=1;
				end
				else begin
                	data<=8'b00100000;
                end
                cont2=cont2+1;
                if(cont2==125000)begin
					contadorPularLinha=contadorPularLinha+1;
					cont2=0;
					iniciou<=5'b01010;	
				end    
			end
			16:begin
				RS=1;
                RW=0;
                EN=1;
                if(contNum==0)begin
                    if(result_sinal==1)begin
                        data<=8'b00101101;
                    end
                    else begin
                        data<=8'b00100000;
                    end 
					cont2=cont2+1;
                    if(cont2==125000)begin
						cont2=0;
						contNum=contNum+1;
						iniciou<=5'b01010;
					end
                end
                else if(contNum==1)begin
                    resultDezenaMilhar<=(result/10000);
                    data<=resultDezenaMilhar+8'b00110000;
                    cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                end
                else if(contNum==2)begin
                    resultUnidadeMilhar<=((result%10000)/1000);
                    data<=resultUnidadeMilhar+8'b00110000;
                    cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                    end
            	else  if(contNum==3)begin
                    resultCentena<=(((result%10000)%1000))/100;
                    data<=resultCentena+8'b00110000;
                    cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                end
                else  if(contNum==4)begin
					resultDezena<=((((result%10000)%1000))%100)/10;
                    data<=resultDezena+8'b00110000;
                    cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                end
                else  if(contNum==5)begin
                    resultUnidade<=((((result%10000)%1000))%100)%10;
                    data<=resultUnidade+8'b00110000;
                    cont2=cont2+1;
                        if(cont2==125000)begin
							cont2=0;
							contNum=contNum+1;
							iniciou<=5'b01010;
						end
                end
                else  if(contNum==6)begin
                    data<=8'b00100000;
					cont2=cont2+1;
                    if(cont2==125000)begin
						cont2=0;
						contNum=0;
						iniciou<=5'b01010;
						flagIgual=0;
						limpou=0;
						escreverResult=0;
					end
                end
			end
		endcase	
	end
endmodule 
