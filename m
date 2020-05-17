Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D4AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE7A206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="JPmXLT5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgEQVKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:10:53 -0400
Received: from mail79c50.megamailservers.eu ([91.136.10.89]:49510 "EHLO
        mail70c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726288AbgEQVKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:10:53 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 May 2020 17:10:49 EDT
X-Authenticated-User: 017623705678@o2online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1589749491;
        bh=p4sG9cN5zzgpQ4HhTY3LyZsWnVF2yYTFVyqzXOHaD2c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JPmXLT5FtTEh3Pfi5M5LQ6jawFODqwCTvkgCxvniD8XtzfUEGI4nx7rzO/7nuok6/
         PDF01ikBuyfWCVfHo8P62KPu78ubReWRiK/jKXUAYL1IgBITPjRl9jWxugdG8jIg5B
         kJW+2zXQ2iARwqji15hc+sULYqk18+mnvVRF72p8=
Feedback-ID: 017623705678@o2
Received: from [192.168.2.2] (dslb-178-011-017-047.178.011.pools.vodafone-ip.de [178.11.17.47])
        (authenticated bits=0)
        by mail70c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 04HL4nHX028791;
        Sun, 17 May 2020 21:04:50 +0000
Subject: Re: RTL8723BS driver doesn't work for,me but I can help testing
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
From:   Tobias Baumann <017623705678@o2online.de>
Message-ID: <8cbbf90c-54ba-8fa3-3386-022c9c997a20@o2online.de>
Date:   Sun, 17 May 2020 23:04:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCgZF5Pu944q-_+V0yQ-nc6q82xDjJHjsnj6=uOQL+DEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-Antivirus: AVG (VPS 200517-0, 17.05.2020), Outbound message
X-Antivirus-Status: Clean
X-CTCH-RefID: str=0001.0A782F1D.5EC1A69D.005A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=OKBZIhSB c=1 sm=1 tr=0 a=cfXdPu6Ul6OsnrHrce2WRQ==:117
        a=cfXdPu6Ul6OsnrHrce2WRQ==:17 a=IkcTkHD0fZMA:10 a=oCcaPWc0AAAA:8
        a=hbnA-Jtt2x6C5LeqMAYA:9 a=jDO3NsJ6IUqjoHgf:21 a=NzB4BBNG6loES4P3:21
        a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi martin

sorry for cc -problem it was my fault in thunderbird

thanks for dtb file but this file has problem kernel stop with

[    6.122092] mmc0: new high speed SDIO card at address 0001
[   35.804258] VCCK: disabling
[   35.808781] platform pwmleds: deferred probe pending
[   35.812625] platform sound: deferred probe pending

[  215.804295] random: crng init done

(last time deferred probe was gcc problem )

please can you provide me with dts file and i complile at my linux box 
or maybe only the change line and i use the dtb from image and edit the 
lines like the usb patch

thanks

Tobias

Am 17.05.2020 um 22:28 schrieb Martin Blumenstingl:
> Hi Tobias,
>
> (adding back the original Cc list since that got lost at some point.
> please keep them included)
>
> On Sun, May 17, 2020 at 9:57 PM Tobias Baumann <017623705678@o2online.de> wrote:
>> hi Martin
>>
>>
>> i know what you mean with many modules from Arduino sensor modules not
>> all datasheet are correct
>>
>> ok i got into uboot env
>>
>> i could not get GPIOA0 write because of unknowm pin number
> GPIOAO_0 should work though (the underscore is important)
>
>> but GPIOX works
>>
>> now my measurmant show that out high = signal high (3.3V) and out low
>> =singnal low (0.0V)
>>
>> without any instruction the S812 pins show something betwen 0.2V and 0.8v
>>
>> and that GPIOX_11 (old gpio-123 ; new gpio-402) the one to PIN12
>> WLAN-DIS of r8723bs modul
>>
>> and like you saw on my kernel cat print it is set to low
> I have updated the GPIOs polarity of GPIOAO_6 and GPIOX_11 (since both
> are showing inverse polarity compared to the Android kernel).
> since I don't know if you build mainline yourself or if you use builds
> from other people: I attached the updated .dtb so you can use that if
> you want to
>
> Please let me know if that fixes wifi for you.
>
>
>> thanks for you uboot gset instruction thats helps
>>
>> Am 17.05.2020 um 20:09 schrieb Martin Blumenstingl:
>>> Hi Tobias,
>>>
>>> On Sun, May 17, 2020 at 8:53 AM Tobias Baumann <017623705678@o2online.de> wrote:
>>>> hi Martin
>>>>
>>>>
>>>> yes i mean rtw_antsel=1 or rtw_ansel=2 with cold start
>>>>
>>>> i got hands on pine64 rtl8723bs pdf file with datasheet i attached it there i found the pinout and found a hint that maybe help !!!
>>> it *may* help. beware that there are *many* RTL8723BS modules out
>>> there, which may or may not follow the same pattern.
>>>
>>> Realtek only sells the RTL8723BS chip on it's own. But it needs some
>>> extra components (crystals, resistors, capacitors, ...)
>>> When changing some of these components you need to certify (FCC / CE /
>>> some other regulatory) the wifi card again (to ensure it follows the
>>> specification and does not interfere with other devices).
>>> Thus there are manufacturers (for example FN-LINK) that sell certified
>>> RTL8723BS modules.
>>>
>>> Also one datasheet can describe the signal as "active low".
>>> However, if there is a small transistor circuit on the module PCB (or
>>> the main SoC PCB) then that can "flip" the signal, meaning: the SoC
>>> outputs HIGH but the module gets LOW - or vice versa.
>>> Thus we describe the GPIOs from the GPIO controller (in this case:
>>> Amlogic SoC) perspective.
>>>
>>>> GPIOs 0-135:(from 3.10.99 Kernel )
>>>>    gpio-3   (gpio_key            ) in  hi
>>>>    gpio-6   (sdio_wifi           ) out hi ->
>>> this one is GPIOAO_6 and called "gpio-382" in your 5.7 kernel GPIO dump
>>>
>>>>    gpio-14  (amlsd               ) in  lo
>>>>    gpio-15  (DWC_OTG             ) out hi
>>>>    gpio-64  (amlsd               ) in  lo
>>>>    gpio-122 (sdio_wifi           ) out hi
>>> this one is GPIOX_10. I don't know why the vendor kernel requests this as GPIO
>>> because actually it is using the xtal_32k_out mux on the pin controller.
>>> I assume this is what you have for pin24 below (32k/RTC clock/WLAN
>>> clock), because it's output is 32.768kHz (or rounded: 32kHz)
>>>
>>>>    gpio-123 (sdio_wifi           ) out hi
>>> this one is GPIOX_11 and called "gpio-402" in your 5.7 kernel GPIO dump
>>>
>>>>    gpio-132 (bt_rfkill           ) out hi -> pin 34 Bt_dis (Bluetooth disable)
>>> this one is GPIOX_20 and not part of your 5.7 kernel GPIO dump
>>> Linux 5.8 will gain RTL8723BS Bluetooth support -> with that the GPIO
>>> will show up as well
>>>
>>> do you know if this is related to the wifi part somehow?
>>>
>>>>    gpio-133 (sdio_wifi           ) in  hi
>>> this one is GPIOX_21 and not part of your 5.7 kernel GPIO dump either.
>>> It is the "wifi host wake" and should not be related to your issue.
>>> the SDIO wifi card uses it to let the host know that data is available
>>> and the host should resume from suspend.
>>>
>>> [...]
>>>> GPIO Kernel 5.7
>>>>
>>>> gpiochip1: GPIOs 376-390, parent: platform/c8100084.pinctrl, ao-bank:
>>>>    gpio-382 (                    |reset               ) out lo
>>>>
>>>> gpiochip0: GPIOs 391-511, parent: platform/c1109880.pinctrl, cbus-banks:
>>>>    gpio-402 (                    |reset               ) out lo
>>>>    gpio-484 (                    |snps,reset          ) out hi ACTIVE LOW
>>> you can ignore gpio-484 (snps,reset) for the current issue.
>>> This is for the Ethernet PHY and has nothing to do with wifi.
>>>
>>>>    gpio-491 (                    |cd                  ) in  lo ACTIVE LOW
>>>>
>>>>
>>>> i think i do not have a pull down gpio pin i need the pins high state
>>> which one do you mean exactly?
>>>
>>> since you are measuring with a multimeter anyways: can you please find
>>> out the pin from the Amlogic SoC which is routed to the WLAN_DIS pin
>>> of the WIFI module along with the polarity (high/low)?
>>> in Amlogic's vendor u-boot you can use:
>>>     gset GPIO_NAME out high/low
>>> for example:
>>>     gset GPIOX_11 out low
>>>
>>>
>>> Best regards,
>>> Martin
>>>
>> --
>> Diese E-Mail wurde von AVG auf Viren geprüft.
>> http://www.avg.com
>>
>
> Best regards,
> Martin

-- 
Diese E-Mail wurde von AVG auf Viren geprüft.
http://www.avg.com

