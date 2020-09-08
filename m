Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C89A21D42
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="Nip8LBTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbgIHRn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbgIHRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:42:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAA8C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:42:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so180465wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OEf+BGjF/t1JSSdnc1xyf+TDXOi/Xxv0WukkmnIdvak=;
        b=Nip8LBTJIwyVryN3G1TC6CvDmzGXzZLtpIWyp4oLnyJg756Yi/T1XrlRX5l4q10pq5
         KPXGPSSkxpDZO2ofu+3llwSUCrdutCjsmjJhF874adxIVK/TixD/rUgcb3wtev6fJEDg
         hQHhNPAqej0ccihmGc52Lsd3cLHMg5TjYKW6J7pQ+VAEajE+BqqayRXzdY1UEu/CbIQl
         dRZKrnvJJFH1ZIQoQ/N0E/haKrRpS8/VY1hHZhT5kgYf1iCa6tHpQazmOgtD6yy/XGBv
         VwPiBf5aSdPIhj6PRaAi5PIZHtQM++hnRAdo1Unw1f2FT6sN5vs/FOZLq273pmHDhxbs
         8wPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OEf+BGjF/t1JSSdnc1xyf+TDXOi/Xxv0WukkmnIdvak=;
        b=fZsvRABr13l67gC30FRA8QoPHiNS3AqM8M3mSbD/84Lv/D1c2/dDUQWSb4r3nRahNn
         oS9xbavUnE9O3b9w94tfnecTydycDArA3JMcqkNshfwAXFhYwH6cQwqpAR8v7blkUJc+
         NlKlzxyuGLz+qntOtoTuHMJniYcfRMhuQNMp3KzBBakrjCiS/r89dqbiNwMlLZj2BQyh
         GFnlCgLtDYC9gdkWkP89HEhvBl/JdaQa53rgb2j/oPbDjogH3eLCsPHbYQljPJ8g89Kt
         lQAncPmNdUAzPXHEexj8pte5mAJecnhHRrxkz3XHcuCXOZSFv4Iz3AYOO59E6jllzqeW
         7sgg==
X-Gm-Message-State: AOAM531M8m7XL1P8kO+TemGX8AFjG7Kkp9fgp+wDMpUecFMasdfw/qgX
        PN3gCw6bLd5uXrTCHFADMOF/GtcUcQ5aexMhQFKzOw==
X-Google-Smtp-Source: ABdhPJwdAhCHkjes0xF1vFytq4iFsXQyYNDN0A43hixRh6hsuZrP+Tcfw609dCp9J8cPhB1mHHbGKxY9funQbMQmKE4=
X-Received: by 2002:a1c:7314:: with SMTP id d20mr249187wmb.76.1599586968746;
 Tue, 08 Sep 2020 10:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200501193141.30293-1-rad@semihalf.com> <3ad44b75-387f-da75-d7b2-3a16ed00550c@linux.intel.com>
 <CAOs-w0LPeKgooa_98x_Jkzus-Y5Kad7pDby0CriDGb6nTp_6sA@mail.gmail.com> <8b97bf43-ddd8-df81-90e7-9e87c19af1ab@linux.intel.com>
In-Reply-To: <8b97bf43-ddd8-df81-90e7-9e87c19af1ab@linux.intel.com>
From:   =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Date:   Tue, 8 Sep 2020 19:42:33 +0200
Message-ID: <CAOs-w0KvKcRnDkMtdAV2n_3XLfwk9KgM65QEO=6+qNshobJx3g@mail.gmail.com>
Subject: Re: [PATCH V2] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Lech Betlej <Lech.Betlej@intel.com>, alsa-devel@alsa-project.org,
        Todd Broch <tbroch@google.com>,
        Harshapriya <harshapriya.n@intel.com>,
        John Hsu <KCHSU0@nuvoton.com>,
        Alex Levin <levinale@google.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Sienkiewicz, Michal" <michal.sienkiewicz@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Marcin Wojtas <mw@semihalf.com>, linux-kernel@vger.kernel.org,
        Yong Zhi <yong.zhi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for missing the response for so long.
Somehow lost this thread in my mailbox.

=C5=9Br., 6 maj 2020 o 00:04 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
>
>
> >>> This single fix address two issues on machines with nau88125:
> >>> 1) Audio distortion, due to lack of required clock rate on MCLK line
> >>> 2) Loud audible "pops" on headphones if there is no sysclk during nau=
8825
> >>>      playback power up sequence
> >>>
> >>> Explanation for:
> >>> 1) Due to Skylake HW limitation, MCLK pin can only output 24MHz clk
> >>>      rate (it can be only connected to XTAL parent clk). The BCLK pin
> >>>      can be driven by dividers and therefore FW is able to set it to =
rate
> >>>      required by chosen audio format. According to nau8825 datasheet,=
 256*FS
> >>>      sysclk gives the best audio quality and the only way to achieve =
this
> >>>      (taking into account the above limitations) its to regenerate th=
e MCLK
> >>>      from BCLK on nau8825 side by FFL. Without required clk rate, aud=
io is
> >>>      distorted by added harmonics.
> >>
> >> The BCLK is going to be a multiple of 50 * Fs due to clocking
> >> restrictions. Can the codec regenerate a good-enough sysclk from this?
> >
> > According to Intel, silicon has a limitation, on SKL/KBL only clk_id =
=3D
> > SKL_XTAL, .name =3D "xtal" is available for IO domain.
> > As mentioned in the commit:
> > MCLK is generated by using 24MHz Xtal directly or applying a divider
> > (so no way of achieving the rate required by audio format).
> > BCLK/FS is generated from 24MHz and uses dividers and additional
> > padding bits are used to match the clock source.
> > Next gen silicon has the possibility of using additional clock sources.
> >
> > Summing up, using MCLK from SKL to NAU88L25 is not an option.
> > The only option we found is to use BCLK and regen the required clock
> > rate by FLL on the NAU88l25 side.
>
> Right, this 24 MHz is a recurring problem.
> But what I was asking was if the NAU8825 is fine working with e.g. a
> 2.4MHz bit clock. i.e. with 25 bit slots or padding at the end of the fra=
me?

From our tests NAU8825 is working fine with these parameters.
Also the output audio signal looks fine on the scope and FFT and there
are no audible glitches.

>
> >
> >>>
> >>> 2) Currently Skylake does not output MCLK/FS when the back-end DAI op
> >>>      hw_param is called, so we cannot switch to MCLK/FS in hw_param. =
 This
> >>>      patch reduces pop by letting nau8825 keep using its internal VCO=
 clock
> >>>      during widget power up sequence, until SNDRV_PCM_TRIGGER_START w=
hen
> >>>      MCLK/FS is available. Once device resumes, the system will only =
enable
> >>>      power sequence for playback without doing hardware parameter, au=
dio
> >>>      format, and PLL configure. In the mean time, the jack detecion s=
equence
> >>>      has changed PLL parameters and switched to internal clock. Thus,=
 the
> >>>      playback signal distorted without correct PLL parameters.  That =
is why
> >>>      we need to configure the PLL again in SNDRV_PCM_TRIGGER_RESUME c=
ase.
> >>
> >> IIRC the FS can be controlled with the clk_ api with the Skylake drive=
r,
> >> as done for some KBL platforms. Or is this not supported by the firmwa=
re
> >> used by this machine?
> >
> > According to Ben, SKL had limitations in FW for managing the clk's
> > back in the days.
> > Can you point to the other driver you mention so we can cross check?
>
> There are two KBL drivers that control the SSP clocks from the machine
> driver, but indeed I don't know if this would work on Firmware, it'd be
> a question for Lech/Cezary.
>
> kbl_rt5663_max98927.c:          ret =3D clk_prepare_enable(priv->mclk);
> kbl_rt5663_max98927.c:          ret =3D clk_prepare_enable(priv->sclk);
> kbl_rt5663_rt5514_max98927.c:           ret =3D
> clk_prepare_enable(priv->mclk);
> kbl_rt5663_rt5514_max98927.c:           ret =3D
> clk_prepare_enable(priv->sclk);
> kbl_rt5663_rt5514_max98927.c:                   ret =3D
> clk_prepare_enable(priv->mclk);
>

Czarek answered this and we got the same response from other Intel
devs while consulting this change:
FW cannot request a chosen rate (48k) for MCLK pin as it does not
"align with what's present on SKL hw".

The only way we found out for NAU8825 to cooperate at chosen rate with
SKL HW is to regen the MCLK from BCLK by FLL as mentioned above.
NHTL is used to set SSP0 (48k, 24/25 bit on 24MHz crystal).
If I get all of this right, use of NHTL and HW "abilities" would
explain why there is no call to change SSP from a machine driver.


If all of this is ok I will send V3 with msleep() removed.
