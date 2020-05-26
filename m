Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B13C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413CA2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HKVR2q9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390675AbgEZUOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389641AbgEZUN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:13:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B3FC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:13:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h21so25219961ejq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yS1DoO/K1G+meTRAQqLkUWF4N4+Wqw/IwFwkXLkuTd8=;
        b=HKVR2q9JAXogkKSM9GCjIMO45dD/mqr+8Qm4/bhisxoqsjyY1VCl3gTKI+zI2MR+g6
         zNeE+aaTEDjb1GAWD0JxMAtB1o9ZlT4+edenoQNwE/NxJScGPJHWzyQpnU+PKPaUddic
         b8g7RoKAEL4Qwt3xUnps/M8ts30bRF1Qo4n8YjzgtHa48pSQO+Q0berSafuUNJEPIylJ
         VYYLnbVcy+Rj+0tkyzOyVbyb9woutUyic3Gd7f7bYhoOiz3+I6zFquEz3rEAPewBTjXs
         RhFoGU7VfdQIfL9sf7VDWNqt85P/xt2tc8B8Cv6EYADszYvM0wt2AL+YaobhMHEH+1lY
         fpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yS1DoO/K1G+meTRAQqLkUWF4N4+Wqw/IwFwkXLkuTd8=;
        b=ZJ7lBSc0Eel6BuSr1QzTxpMhDRxuDHDGuvsOLH0EAFW6zMgc8dvdhrRgpDD0L8icw7
         A3isJ/EO408BeHNxYY07yPoXVzuNko+2lnPF4IiWDlTt6ec+kJgusr8eKWMZs3ZAAIwQ
         hwieLgFcHldGqhKdnINOBcpEw1VEJ6UrAIgqvgbscEzDt4BUSM+BwWC/32STq7g/hG3h
         +erGj+15I7wZ5vvkGguzjjRik8bitj/3v5rvwaZPJMNREOxEIxUY6gpiATW+MOeNPyRD
         5R1g8FBd+/+Dns0FxRLUr/dCq5FK3o1u8pr5y3IuGHY93yxOFP95x3/oN/18bLO4bPkp
         3uDg==
X-Gm-Message-State: AOAM530sL73qysXwchKa8oTLFgH50lnuOGNQCXK0/BkcWoSACNxC07uS
        uBZCErQcW08N1l5gIr4YWeOaydKWHTqsH5bF2mcci3+H
X-Google-Smtp-Source: ABdhPJzpzWLcOzK/mcamYh7hMdwPFJxWohAZZvqCy13eksOwUBACePxXGwAuK6thRgZsyhCoJQ8SNUlw7i+8nB9iXR4=
X-Received: by 2002:a17:906:abce:: with SMTP id kq14mr2513446ejb.187.1590524037659;
 Tue, 26 May 2020 13:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
 <CAFBinCD8-tr97GCVhBi5R1nzxLhy=_6VuLY8ubUO1SDTFjiELw@mail.gmail.com>
 <22af498b-44a0-ced3-86f3-114427a73910@o2online.de> <CAFBinCCGAkhPCwOW=mAvsV2qdixq8Gf8yQw1gYErHpz7KmuAZg@mail.gmail.com>
 <5de6db87-a71f-d14c-390d-b0caeab5d650@o2online.de> <CAFBinCDB9c2uMRXO9DKSX4hC7EBgnRfBa+BM5-VdEPZeieKn_w@mail.gmail.com>
 <813dfc08-f13a-dcac-0bd9-821d188bba08@o2online.de> <CAFBinCCgZF5Pu944q-_+V0yQ-nc6q82xDjJHjsnj6=uOQL+DEw@mail.gmail.com>
 <8cbbf90c-54ba-8fa3-3386-022c9c997a20@o2online.de> <CAFBinCBukGbzgO-Y1dCRYXZHhX2PcSEQQ_XvhHqLcnw0fGDP8w@mail.gmail.com>
 <a95f5fe1-4376-f872-961a-c2237c36811c@o2online.de> <CAFBinCCgFtv=u4ZKW3rdoDPZ_jh3jU03MDxHoDk=pbi+4pxB_w@mail.gmail.com>
 <c244b34f-8958-0cbd-38e6-a786aef56e7c@o2online.de> <CAFBinCDvwy7xCYdJzRHV0ACJ=CF+A5efD-WpPvyE62gfUribUw@mail.gmail.com>
 <fb9d8d57-2958-4023-2a95-af240714d5df@o2online.de>
In-Reply-To: <fb9d8d57-2958-4023-2a95-af240714d5df@o2online.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 26 May 2020 22:13:46 +0200
Message-ID: <CAFBinCCpVCLHQ6TPegKjy+32nKGbJKKeQyjCSgnCNBMDgs2kpg@mail.gmail.com>
Subject: Re: RTL8723BS driver doesn't work for,me but I can help testing
To:     Tobias Baumann <017623705678@o2online.de>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,


On Thu, May 21, 2020 at 1:17 PM Tobias Baumann <017623705678@o2online.de> w=
rote:
[...]
>>> with my patch and oleg RC5 hotstart(shutdown now)  do not work with my
>>> box ( wlan goes back to sleep mode always)
>>
>> I'm not sure what you mean here.
>> if you run "shutdown now" then the system does not shut down and only
>> wifi goes to sleep mode?
>
> i meant  that after a reboot with "shutdown now" my box restart but the w=
ifi chip is back in sleep mode ,  while the wifi chip was online befor the =
restart .
I don't know how sleep mode is controlled (some GPIO or through SDIO
communication) so I can't comment on that

[...]
>  i read also the AP6330 and BCM4330 Datasheet  for both of them is a star=
t order inside the datashet ( i think that RTL8723BS should have same timmi=
ng) . the time between 32k clock and WLAN_dis should be more than minimum 2=
 clock cycle (1/32kHZ * 2cycle =3D 0.06ms )
>
> also that AP6330 has most identical  pinout as RTL8723BS ( i did not get =
the pinout of BCM4330 because datasheet only has information to the chip an=
d not the small extra pcb where the chip is mount)
I don't have any additional comments on this one

> on Android 4.4 my box told me that GPIOAO_6 ist chip enable and GPIOX_11 =
ist wlan enable
>
> mybe a clue is that in the HArdkernel S805 Datasheet the GPIOAO_6 is also=
 a 32k clock  output (site 42 table 10 Func1 maybe  (but i also found some =
Dts file from old S805 RTL8723bs box they use only GPIOX_11 and powerPin2 w=
as comment out )
do you have an oscilloscope or does your multimeter support frequency
measurements (based on what I understand it would only have to be
capable of measuring 32kHz)?
then you can prove or refute this :-)

> i have another question , do we use the same wifi.c file for the meson8m2=
 boxes as for endless mini ? i have taken a closer look at the file and the=
 two delay information you are mention are not  in the wifi. c is neither a=
 function nor an instance, it just takes two fixed values "mdelay(200)" lin=
e 156 , furthermore we ignore the output level of wifi_power_gpio2 and auto=
matically set it to "1" line 378 , so it is important which of the two pins=
 is passed to the header file first (translate with DEEPL)
Endless Mini has the CHIP_EN signal hard-wired to 3.3V
This is the .dts from the Endless Mini:
https://github.com/endlessm/linux-meson/blob/d628bf1242928927a41f7482ba5ef7=
295e01a9ff/arch/arm/boot/dts/meson8b-ec100.dts

[...]
> You are right the chip has only wifi wake host and that should be GPIOX_2=
1 as input ; maybe on your box the pin is alway high  on the board  ( direk=
t an 3.3V verdrahtet)
on the Endless Mini GPIOX_21 is also WIFI_WAKE_HOST
I haven't tested any reboot / shutdown / etc. cycles with RTL8723BS
there yet because I typically use the sdio controller to access the
internal SD card (and at the time of writing the MMC subsystem in
Linux doesn't support two different cards with one MMC controller). So
only because of your email I did a quick test on the Endless Mini.


Best regards,
Martin
