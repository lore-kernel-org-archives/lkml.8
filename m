Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7263207CD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au1fFnyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGEAbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 20:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgGEAbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 20:31:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BF5C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 17:31:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o8so35549082wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 17:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=DSh/Jwvy65gqNgEUvzillgjncz9/zO3XiLAWGc8Crwg=;
        b=au1fFnyI+/hEHdy0F3zh4Y8MY2NyTolhs2uCMpU+e1nLSOmewGGstp9+nJX+PZNPrY
         /sKHbdT8YnDNBQxWK9zzP5cz/obiT2iWn68ediWdyu7dy8QDn5jYIyz/O6TZ3OFjIv7S
         MRPskFUrUd4CNYrU/rdccW/fREqMwjPTp6Dpe0i+s7ZieZ9778p3x5pkWJBtbaYYJ7/w
         llv1+sX4PIyBQX3oxY1IGE3XzwETRdRXX0DepB7xJ1W4yNQIuNqL3IwgmPGu16mXgnM2
         BxDx/AfuO2j71csyapFnS3a9n+NfceSN/a2S30H7aM1GuCDhGHIxbzmdJUb56gMfDIiN
         qDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=DSh/Jwvy65gqNgEUvzillgjncz9/zO3XiLAWGc8Crwg=;
        b=OdQ5Ewr7PEUWHb0au0V/BpOJtcktql0lQayloF34iqttUv3+mEegJTSMHx/zSYr+69
         763jAJsGV95JdpRR4LYmnTKi78BQqsl8Mthp2gYDDe8G1ccKK3h4YttCorRyV4dm+uhs
         8eKRscaQKO1dXauC0hR7XNqQUq1sbS7g1Hb7VJLr55T17uf/d1DHVLJt+lQdPbt275tB
         PRZk0pfmk6eo81TMuL6grPOkpH9u2bVqMEKpZzAxb2TW7AzP3AxqefeA3XWvOBXbI8gB
         LWvdN2jSS+LHBwYDTE30lo38+ZWvVMpZyXsvBp6gg1BLJsLq8chkUAYfSkpERtkSJE24
         qWJg==
X-Gm-Message-State: AOAM530M8EcZ9R1gcXK+zsUa/DQBHZvpA4SJ0+ajPL0s9O2efYSiwHQX
        wwnOf9Y089eemJCo8xBEI6W3WdgE
X-Google-Smtp-Source: ABdhPJxwbywwydoRP4xr3ysOKoYZh+PZemPotlJbOcQ6YQ0THMYFivVZYMGHqO88+PKh2PNkcmUp9w==
X-Received: by 2002:a1c:bb43:: with SMTP id l64mr44183919wmf.151.1593909099954;
        Sat, 04 Jul 2020 17:31:39 -0700 (PDT)
Received: from [192.168.1.64] (bl8-158-27.dsl.telepac.pt. [85.241.158.27])
        by smtp.gmail.com with ESMTPSA id v12sm5952959wrt.31.2020.07.04.17.31.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 17:31:39 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Andre Coelho <andrealbergaria@gmail.com>
Subject: fast binary calculator
Message-ID: <2199f3d5-cac9-99d8-3b69-55f0d8b245a0@gmail.com>
Date:   Sun, 5 Jul 2020 01:31:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------192E6EDDE2BA7E8FAF798DA4"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------192E6EDDE2BA7E8FAF798DA4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

ey


Ive made a program, that uses bit flips to quickly represent binary numbers

for instance, if i use a 128bit number than the algorithm uses

128+128+128 (and not 128*128)

for each bit.

Basically, it assigns slots to bits, so for instance

pos 1    pos 2 pos 3

0             0       0

1            1      1

so that reduces the time it takes to scan them. I also use bit flips to 
change the bit on a particular slot.


i wrote both c and java files.


later


Here is the code in c

#include <stdio.h>


char flipBit(char c);

char flipBit(char c) {
     if (c == '0')
         return '1';
     else
         return '0';



}


int main() {





                         char binaryNumber[] = { '0','0','0','0',0 };
                         int slot1,slot2,slot3,slot4;


                         for (slot1=0 ; slot1 < 2 ; slot1++) {
                             printf("\n%s",binaryNumber);
                             for (slot2 =1 ; slot2 < 2 ; slot2++) {
                                 binaryNumber[slot2] = 
flipBit(binaryNumber[slot2]);

                                 printf("\n%s",binaryNumber);

                                 for (slot3=2 ; slot3 < 3 ; slot3++) {
                                     binaryNumber[slot3] = 
flipBit(binaryNumber[slot3]);
                                     printf("\n%s",binaryNumber);


                                     for (slot4=3 ; slot4 < 4 ; slot4++) {
                                         binaryNumber[slot4] = 
flipBit(binaryNumber[slot4]);
printf("\n%s",binaryNumber);
                                     }
                                 }

                             }
                             binaryNumber[slot1] = 
flipBit(binaryNumber[slot1]);
                             printf("\n");
                         }



}

-- 
André Albergaria Coelho
andrealbergaria@gmail.com


--------------192E6EDDE2BA7E8FAF798DA4
Content-Type: text/x-csrc; charset=UTF-8;
 name="binPath.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="binPath.c"

#include <stdio.h>

char flipBit(char c);

char flipBit(char c) {
    if (c == '0')
        return '1';
    else 
        return '0';
}
    
int main() {
                        
						char binaryNumber[] = { '0','0','0','0',0 };
						int slot1,slot2,slot3,slot4;


						for (slot1=0 ; slot1 < 2 ; slot1++) {
							printf("\n%s",binaryNumber);
							for (slot2 =1 ; slot2 < 2 ; slot2++) {
								binaryNumber[slot2] = flipBit(binaryNumber[slot2]);
								
								printf("\n%s",binaryNumber);

								for (slot3=2 ; slot3 < 3 ; slot3++) {
									binaryNumber[slot3] = flipBit(binaryNumber[slot3]);
                                    printf("\n%s",binaryNumber);


									for (slot4=3 ; slot4 < 4 ; slot4++) {
										binaryNumber[slot4] = flipBit(binaryNumber[slot4]);
										printf("\n%s",binaryNumber);
									}
								}

							}
							binaryNumber[slot1] = flipBit(binaryNumber[slot1]);
                            printf("\n");
						}
}

--------------192E6EDDE2BA7E8FAF798DA4
Content-Type: text/x-java; charset=UTF-8;
 name="binPath.java"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="binPath.java"

import java.io.UnsupportedEncodingException;
import java.util.Arrays;


public class binPath {

	// ao inves de se usar o numero , usas a posicao dele na posicao do  numero (na array)
	// ao inves de se usar o sistema de numeros (cada posicao ocupa um elemento vezes a base)
	
	 
		
		public static void main(String[] args) {
		 
					byte[] plaintext = {0,0,0,1,1,1,0,1};
					
					
					
					// prints bits and positions
					/*byte[] b = {0,0,0,0,0,0,0,0};
					byte[] b2 = {1,1,1,1,1,1,1,1};
					
				
					for (int pos=0; pos < 8; pos++) {
						System.out.println("position "+pos+" "+b[pos]);
						System.out.println("position "+pos+" "+b2[pos]);
					}
					*/
					byte[] t = { 0,0,0,0 };
					
					
					
					for (int slot1 = 0 ; slot1 < 2 ; slot1++) {
						System.out.println();
						System.out.print(Arrays.toString(t));
						for (int slot2 = 1; slot2 < 2 ; slot2++) {
							t[slot2] = bitFlip(t[slot2]);
							System.out.println();
							System.out.print(Arrays.toString(t));
							
							for (int slot3 = 2; slot3 < 3 ; slot3++) {
								t[slot3] = bitFlip(t[slot3]);
								System.out.println();
								System.out.print(Arrays.toString(t));
								
								for (int slot4=3; slot4 < 4 ; slot4++) {
									t[slot4] = bitFlip(t[slot4]);
									System.out.println();
									System.out.print(Arrays.toString(t));
								}
							}
							
						}
						t[slot1] = bitFlip(t[slot1]);
					}
					
						
		}		
												
			
					
					
	
	// Flips bits
	public static byte bitFlip(byte b) {
		if (b == 0)
			return 1;
		else
			return 0;
		
	}
	
}

--------------192E6EDDE2BA7E8FAF798DA4--
