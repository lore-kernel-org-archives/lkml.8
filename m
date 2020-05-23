Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2635C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 07:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4502073B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 07:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="nsrsABSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbgEWHsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 03:48:15 -0400
Received: from mail231c50.megamailservers.eu ([91.136.10.241]:54926 "EHLO
        mail37c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387500AbgEWHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 03:48:15 -0400
X-Authenticated-User: 017623705678@o2online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1590220080;
        bh=DN0ROQEaCqnxRVKpv6MDhbIDUAf3VFRkVOIz1J1AS0k=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=nsrsABSSaE0fo+k0jVDxjNT6nI+3CoBDBOjSNkdUo/C4cacluzPT0xD/qPWvj9v4k
         sTGpDydDkOLTAQwqSAWbIX/dCPWqhWWxTNk84AArFc43juMefa9Ca7UPtsJ5Oi4KI5
         VPHtFmI88pxkruw9T9cPZWLi1AXxodnV0pCX/T8M=
Feedback-ID: 017623705678@o2
Received: from [192.168.2.2] (dslb-178-011-017-047.178.011.pools.vodafone-ip.de [178.11.17.47])
        (authenticated bits=0)
        by mail37c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 04N7lvdn004739;
        Sat, 23 May 2020 07:47:58 +0000
Subject: Re: RTL8723BS driver doesn't work for,me but I can help testing
From:   Tobias Baumann <017623705678@o2online.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
 <CAFBinCD8-tr97GCVhBi5R1nzxLhy=_6VuLY8ubUO1SDTFjiELw@mail.gmail.com>
 <22af498b-44a0-ced3-86f3-114427a73910@o2online.de>
 <CAFBinCCGAkhPCwOW=mAvsV2qdixq8Gf8yQw1gYErHpz7KmuAZg@mail.gmail.com>
 <5de6db87-a71f-d14c-390d-b0caeab5d650@o2online.de>
 <CAFBinCDB9c2uMRXO9DKSX4hC7EBgnRfBa+BM5-VdEPZeieKn_w@mail.gmail.com>
 <813dfc08-f13a-dcac-0bd9-821d188bba08@o2online.de>
 <CAFBinCCgZF5Pu944q-_+V0yQ-nc6q82xDjJHjsnj6=uOQL+DEw@mail.gmail.com>
 <8cbbf90c-54ba-8fa3-3386-022c9c997a20@o2online.de>
 <CAFBinCBukGbzgO-Y1dCRYXZHhX2PcSEQQ_XvhHqLcnw0fGDP8w@mail.gmail.com>
 <a95f5fe1-4376-f872-961a-c2237c36811c@o2online.de>
 <CAFBinCCgFtv=u4ZKW3rdoDPZ_jh3jU03MDxHoDk=pbi+4pxB_w@mail.gmail.com>
 <c244b34f-8958-0cbd-38e6-a786aef56e7c@o2online.de>
 <CAFBinCDvwy7xCYdJzRHV0ACJ=CF+A5efD-WpPvyE62gfUribUw@mail.gmail.com>
 <fb9d8d57-2958-4023-2a95-af240714d5df@o2online.de>
Message-ID: <5e576561-f119-e9cc-688b-085d84d78b34@o2online.de>
Date:   Sat, 23 May 2020 09:47:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <fb9d8d57-2958-4023-2a95-af240714d5df@o2online.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-Antivirus: AVG (VPS 200522-0, 22.05.2020), Outbound message
X-Antivirus-Status: Clean
X-CTCH-RefID: str=0001.0A782F18.5EC8D4C2.000D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=bJNo382Z c=1 sm=1 tr=0 a=cfXdPu6Ul6OsnrHrce2WRQ==:117
        a=cfXdPu6Ul6OsnrHrce2WRQ==:17 a=IkcTkHD0fZMA:10 a=9AdMxfjQAAAA:20
        a=tRq-XDIbAAAA:20 a=oCcaPWc0AAAA:8 a=ZtR4bvJMnFn1KTMmwqEA:9
        a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend html-format was inside email

Am 21.05.2020 um 13:17 schrieb Tobias Baumann:
>
> Hi Martin
>
> first of all sorry for my short english writing
>
>
> Am 19.05.2020 um 22:16 schrieb Martin Blumenstingl:
>> Hi Tobias,
>>
>> On Tue, May 19, 2020 at 8:21 AM Tobias Baumann<017623705678@o2online.de>  wrote:
>>> good morning
>>>
>>> i got the new image from oleg(balbes150) 20200518 RC5  and some more
>>> feedback
>>>
>>> with my patch and oleg RC5 hotstart(shutdown now)  do not work with my
>>> box ( wlan goes back to sleep mode always)
>> I'm not sure what you mean here.
>> if you run "shutdown now" then the system does not shut down and only
>> wifi goes to sleep mode?
>
> i meant  that after a reboot with "shutdown now" my box restart but 
> the wifi chip is back in sleep mode ,  while the wifi chip was online 
> befor the restart .
>
>
>>> with my patch chance  1 of 5 till 1 of 3 that my wlan is up and not
>>> sleep from cold start
>>>
>>> with oleg chance 1 of 2 till 1of 3 from cold start that wlan is up  .
>>> (maybe because of phandle order?)
>>>
>>> i thing there is maybe a timming problem between  wlan dis , sdio  data
>>> and  host wake up wlan .
>> the power sequence driver supports the following two properties, see [0]:
>> - post-power-on-delay-ms
>> - power-off-delay-us
>>
>> Those are not set, meaning no delay is applied.
>> For reference, these are the delays which are used on the Endless Mini
>> (which also has a RTL8723BS module): [1]
>> Do you know more about these delays (whether they are needed and how
>> long they are supposed to be)?
>
>  i read also the AP6330 and BCM4330 Datasheet  for both of them is a 
> start order inside the datashet ( i think that RTL8723BS should have 
> same timming) . the time between 32k clock and WLAN_dis should be more 
> than minimum 2 clock cycle (1/32kHZ * 2cycle = 0.06ms )
>
> also that AP6330 has most identical  pinout as RTL8723BS ( i did not 
> get the pinout of BCM4330 because datasheet only has information to 
> the chip and not the small extra pcb where the chip is mount)
>
> on Android 4.4 my box told me that GPIOAO_6 ist chip enable and 
> GPIOX_11 ist wlan enable
>
> mybe a clue is that in the HArdkernel S805 Datasheet the GPIOAO_6 is 
> also a 32k clock  output (site 42 table 10 Func1 maybe  (but i also 
> found some Dts file from old S805 RTL8723bs box they use only GPIOX_11 
> and powerPin2 was comment out )
>
> ->
>
> i have another question , do we use the same wifi.c file for the 
> meson8m2 boxes as for endless mini ? i have taken a closer look at the 
> file and the two delay information you are mention are not  in the 
> wifi. c is neither a function nor an instance, it just takes two fixed 
> values "mdelay(200)" line 156 , furthermore we ignore the output level 
> of wifi_power_gpio2 and automatically set it to "1" line 378 , so it 
> is important which of the two pins is passed to the header file first 
> (translate with DEEPL)
>
> <-
>
>
>
>
>>> it could be that GPIOAO_6 is the host wake up wlan ? is it possible to
>>> change the activation order for the gpio pins by change it in dts ?
>> please check my previous mails. I think that GPIOX_21 is the wifi host
>> wakeup pin because it is marked as "input" on the 3.10 kernel.
>> you can change the order of the GPIOs inside the sdio_pwrseq node, but
>> all GPIOs are managed together (meaning there's virtually no delay
>> between enabling the first and the second one).
>> I am not sure if using an MMC power sequence is the right thing to do,
>> because the card is detected for me regardless of whether GPIOX_11 is
>> HIGH or LOW. The RTL8723BS driver currently does not manage any GPIOs.
>>
>>
>> Martin
>>
>>
>> [0]https://github.com/torvalds/linux/blob/c477ebe21fabe0010a2ed324ce3a1762c757d867/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> [1]https://github.com/endlessm/linux-meson/blob/4c76999c5c707fba9c390466efca093c3befa908/drivers/amlogic/wifi/wifi_dt.c#L153
>
> You are right the chip has only wifi wake host and that should be 
> GPIOX_21 as input ; maybe on your box the pin is alway high on the 
> board  ( direkt an 3.3V verdrahtet)
>
>
> thanks for the information
>
>
> Tobias
>

-- 
Diese E-Mail wurde von AVG auf Viren geprüft.
http://www.avg.com

