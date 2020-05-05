Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C024CC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D8C20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="x1AlWCzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgEEOYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730134AbgEEOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:24:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6548C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:23:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so2999813wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y70Nah3FzhZidtus6gd4+NBEFZJBCSZiFmzmK0CZes=;
        b=x1AlWCzm3i+12zcO6l4aukwQ6Aaof5MzjJECcmVMkipsGWsE3LSKZMf9m9jgofhDqk
         JEP67rHJ/3IuCTnaK93uk3OOdXP03ypzlV3f7xKJPsGyOkFJxvTT6CFAOU0AX3bfS0vV
         luvzHQ5DXTLwgApmTca8dEUYyqZFiqDGqhmQlkjjvRI97PPi4ru79qs3fCKOpSGNjzvM
         T/AWvaVizbhmtLgUNVM+9P74+/nfqBOHSjtU77MMzNdwkJcYDJ2IRgX/HOksz7ybaQ5j
         AgXz02KGCDDTyh+art+q9aNX9mTlNZ5lkOUxQWfKF4ZO6hvUjC9vUOldHWGNFS2LbZZg
         zI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y70Nah3FzhZidtus6gd4+NBEFZJBCSZiFmzmK0CZes=;
        b=AdGMAVpbpQkHfaeMzWQsu0rFRrLyzkr2y/0gPVrZr6NTo+TQKd9dAzfBJHGmNsbX7F
         rNbtEWGUnhaaLH+uOH73xK375gCkK8JgQ/Fjw45HXqxPSdm0SEirSUJDStjxKbUhZ/Hg
         7trfyy7JgLqJxURpe7Zl9TNkwHwbdZCW/7cuxttvUHb/LS4G/pzkmvo9qg0Zun5BCBRd
         rukP4XH6qZsm5PEvshkUMuQoCS0DAit+tjXQP5ePvn7YI+vMyJBC8ZCcD5syjgrxEidi
         ubJFZQ4dexr1h/BNulu8Maw8wRtVoiBnqNQB2Uf4aOkKVuM2KhQVHTazEhFjERkJQmAQ
         I3Jw==
X-Gm-Message-State: AGi0PuaKQrkb16yz0d/eaRhpgS3B4FETj13s83szyAHzDm8ClATYCiDp
        8fVdRhgJuVReCOXnlusuTX/pi3nOjM10yB+8MfielQ==
X-Google-Smtp-Source: APiQypJJPTp1iDbmTwDsHL2WATyBtkqzx/L9mbhVjiLMShrO4SVgQQefa0T7Yi1gDN3MOa9ZBDvgUxE2/X3IZk4O0zs=
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr4004676wro.361.1588688638314;
 Tue, 05 May 2020 07:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200501193141.30293-1-rad@semihalf.com> <3ad44b75-387f-da75-d7b2-3a16ed00550c@linux.intel.com>
In-Reply-To: <3ad44b75-387f-da75-d7b2-3a16ed00550c@linux.intel.com>
From:   =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Date:   Tue, 5 May 2020 16:23:41 +0200
Message-ID: <CAOs-w0LPeKgooa_98x_Jkzus-Y5Kad7pDby0CriDGb6nTp_6sA@mail.gmail.com>
Subject: Re: [PATCH V2] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lech Betlej <Lech.Betlej@intel.com>,
        alsa-devel@alsa-project.org, Todd Broch <tbroch@google.com>,
        Harshapriya <harshapriya.n@intel.com>,
        John Hsu <KCHSU0@nuvoton.com>, linux-kernel@vger.kernel.org,
        "Sienkiewicz, Michal" <michal.sienkiewicz@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Marcin Wojtas <mw@semihalf.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Alex Levin <levinale@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Pierre for the review!
answers inline

pt., 1 maj 2020 o 22:16 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 5/1/20 2:31 PM, Radoslaw Biernacki wrote:
> > This single fix address two issues on machines with nau88125:
> > 1) Audio distortion, due to lack of required clock rate on MCLK line
> > 2) Loud audible "pops" on headphones if there is no sysclk during nau8825
> >     playback power up sequence
> >
> > Explanation for:
> > 1) Due to Skylake HW limitation, MCLK pin can only output 24MHz clk
> >     rate (it can be only connected to XTAL parent clk). The BCLK pin
> >     can be driven by dividers and therefore FW is able to set it to rate
> >     required by chosen audio format. According to nau8825 datasheet, 256*FS
> >     sysclk gives the best audio quality and the only way to achieve this
> >     (taking into account the above limitations) its to regenerate the MCLK
> >     from BCLK on nau8825 side by FFL. Without required clk rate, audio is
> >     distorted by added harmonics.
>
> The BCLK is going to be a multiple of 50 * Fs due to clocking
> restrictions. Can the codec regenerate a good-enough sysclk from this?

According to Intel, silicon has a limitation, on SKL/KBL only clk_id =
SKL_XTAL, .name = "xtal" is available for IO domain.
As mentioned in the commit:
MCLK is generated by using 24MHz Xtal directly or applying a divider
(so no way of achieving the rate required by audio format).
BCLK/FS is generated from 24MHz and uses dividers and additional
padding bits are used to match the clock source.
Next gen silicon has the possibility of using additional clock sources.

Summing up, using MCLK from SKL to NAU88L25 is not an option.
The only option we found is to use BCLK and regen the required clock
rate by FLL on the NAU88l25 side.

> >
> > 2) Currently Skylake does not output MCLK/FS when the back-end DAI op
> >     hw_param is called, so we cannot switch to MCLK/FS in hw_param.  This
> >     patch reduces pop by letting nau8825 keep using its internal VCO clock
> >     during widget power up sequence, until SNDRV_PCM_TRIGGER_START when
> >     MCLK/FS is available. Once device resumes, the system will only enable
> >     power sequence for playback without doing hardware parameter, audio
> >     format, and PLL configure. In the mean time, the jack detecion sequence
> >     has changed PLL parameters and switched to internal clock. Thus, the
> >     playback signal distorted without correct PLL parameters.  That is why
> >     we need to configure the PLL again in SNDRV_PCM_TRIGGER_RESUME case.
>
> IIRC the FS can be controlled with the clk_ api with the Skylake driver,
> as done for some KBL platforms. Or is this not supported by the firmware
> used by this machine?

According to Ben, SKL had limitations in FW for managing the clk's
back in the days.
Can you point to the other driver you mention so we can cross check?

>
> > -static int skylake_nau8825_hw_params(struct snd_pcm_substream *substream,
> > -     struct snd_pcm_hw_params *params)
> > +static int skylake_nau8825_trigger(struct snd_pcm_substream *substream, int cmd)
> >   {
> >       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +     struct snd_pcm_runtime *runtime = substream->runtime;
> >       struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> > -     int ret;
> > -
> > -     ret = snd_soc_dai_set_sysclk(codec_dai,
> > -                     NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
> > +     int ret = 0;
> >
> > -     if (ret < 0)
> > -             dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
> > +     switch (cmd) {
> > +     case SNDRV_PCM_TRIGGER_START:
> > +             ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
> > +                                          SND_SOC_CLOCK_IN);
> > +             if (ret < 0) {
> > +                     dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
> > +                     break;
> > +             }
> > +             ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> > +                                       runtime->rate * 256);
> > +             if (ret < 0)
> > +                     dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> > +             break;
> > +     case SNDRV_PCM_TRIGGER_RESUME:
> > +             ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> > +                                       runtime->rate * 256);
> > +             if (ret < 0)
> > +                     dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> > +             msleep(20);
>
> is there a reason why you'd need a msleep for resume and not for start?

No. I think we missed this.
msleep() is needed to stabilize FLL.
Will fix in next rev.
