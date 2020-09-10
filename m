Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5273BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FB120882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="V26TF9RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgIJTkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731376AbgIJPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:38:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A54C06138E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:37:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so491360wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zOv4Yx7m8nr1wvMGpIto7eo/RQlcFF6HnuE7bwkiImk=;
        b=V26TF9RU0H8cqirlOmhma1qZPwsk3YxxchuEmGY/8twdnEK1YS2MnwDIeU1daMBFjs
         k/DEqCZBPo+G3W8UJ3nwpjPLtJjQbu2fLnXWV3q6NvmLqgrkj/4oIPhIC96AyL4vEACU
         oLwgH5LsRkqY4EuIRR6v6oz0RQ8G5aBWM23n856vUQLnoO/xuVXDgswv8J6xhwi2kpKl
         QVgcffQn+sVZAA4xX3KYJNFGZRyJnC17+7gRQa4MkfGLw3j8aSq5N/ApJ9NL5VR7z/sd
         H/YDNse7EeeDDIlEDMJvfuMEZPAbrWqQXds7sG8j235L5cFAWeaEMHAXfFnQEeUJC5Wo
         2kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zOv4Yx7m8nr1wvMGpIto7eo/RQlcFF6HnuE7bwkiImk=;
        b=DFo04yAx7kG6vjuN/VMFiIOkKPOmk4IY+PTxOdJgkaMW14R2wp/l34m0o5FvmcOyMI
         uxFssxMAHkU2ov/IOCXCn5q5mIn8RoYprHMR/FOhRt6bFJhN4L5z+PYm25eXwKKbYsZG
         gQGOEM3bQY+KN3dkPPcctePDkHE47/whi9RKwxImUkLUJv0o0a0YQXE1RexB9ddVg+no
         udwa459X/El6x9R3TWhWniRM2DStMOq6GEI8MEOucafN6tO+QehKL7xpvOAPOD/UxXPO
         lEyX0UPHbX8mJL0I8zGBDJ+0aRlOOfbxl4XZgYm6ZpRbluzIJpW1Pl+ci5ZZTwTvcazg
         GJMQ==
X-Gm-Message-State: AOAM533xyEX8pHeskgjOdDqxEKdUEkCzLgv7xRs20OyqkKaoBrcpYhpQ
        KPVtrELz38TiBaUr0YsNsQ5R7EFNQ7z3Nlb36u6XRQ==
X-Google-Smtp-Source: ABdhPJyIDFrKOnnP30G4eKbpPJvXcHHi4rzlnfXVwO1u6UWNESErT1eGx5zOz+KoNtJPUTNu7uY0AyPiHI2z0b5arVY=
X-Received: by 2002:a1c:6346:: with SMTP id x67mr607078wmb.42.1599752269789;
 Thu, 10 Sep 2020 08:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200908200314.22771-1-rad@semihalf.com> <50db252a-1274-f681-d5e7-e7fba839c0ee@linux.intel.com>
In-Reply-To: <50db252a-1274-f681-d5e7-e7fba839c0ee@linux.intel.com>
From:   =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Date:   Thu, 10 Sep 2020 17:37:34 +0200
Message-ID: <CAOs-w0+2uk56-R6RVhno=uTbK4m5UH+tmeiOfcTVgydUdPuXog@mail.gmail.com>
Subject: Re: [PATCH V3] ASoC: Intel: boards: Use FS as nau8825 sysclk in
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Pierre.
All your comments are addressed in V4.
skylake_nau8825_resume_post() is in fact unnecessary as my test shows
no difference if we do the FLL setup in skylake_nau8825_trigger().
patch is coming...

wt., 8 wrz 2020 o 22:59 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):


>
> Sorry, I couldn't resist adding three more comments to improve further:
>
> > -static int skylake_nau8825_hw_params(struct snd_pcm_substream *substre=
am,
> > -     struct snd_pcm_hw_params *params)
> > +static int skylake_nau8825_trigger(struct snd_pcm_substream *substream=
, int cmd)
> >   {
> >       struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > +     struct snd_pcm_runtime *runtime =3D substream->runtime;
> >       struct snd_soc_dai *codec_dai =3D asoc_rtd_to_codec(rtd, 0);
> > -     int ret;
> > -
> > -     ret =3D snd_soc_dai_set_sysclk(codec_dai,
> > -                     NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
> > +     int ret =3D 0;
> >
> > -     if (ret < 0)
> > -             dev_err(rtd->dev, "snd_soc_dai_set_sysclk err =3D %d\n", =
ret);
> > +     switch (cmd) {
> > +     case SNDRV_PCM_TRIGGER_START:
> > +             ret =3D snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL=
_FS, 0,
> > +                                          SND_SOC_CLOCK_IN);
>
> Maybe a simple comment to explain what this does?
>
> > +             if (ret < 0) {
> > +                     dev_err(codec_dai->dev, "can't set FS clock %d\n"=
, ret);
> > +                     break;
> > +             }
> > +             ret =3D snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rat=
e,
> > +                                       runtime->rate * 256);
> > +             if (ret < 0)
> > +                     dev_err(codec_dai->dev, "can't set FLL: %d\n", re=
t);
> > +             break;
>
> You could replace this by a /* fallthrough */ statement?
>
> > +     case SNDRV_PCM_TRIGGER_RESUME:
> > +             ret =3D snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rat=
e,
> > +                                       runtime->rate * 256);
> > +             if (ret < 0)
> > +                     dev_err(codec_dai->dev, "can't set FLL: %d\n", re=
t);
> > +             break;
> > +     }
>
> > +static int __maybe_unused skylake_nau8825_resume_post(struct snd_soc_c=
ard *card)
> > +{
> > +     struct snd_soc_dai *codec_dai;
> > +
> > +     codec_dai =3D snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_=
DAI);
> > +     if (!codec_dai) {
> > +             dev_err(card->dev, "Codec dai not found\n");
> > +             return -EIO;
> > +     }
> > +
> > +     dev_dbg(codec_dai->dev, "playback_active:%d playback_widget->acti=
ve:%d codec_dai->rate:%d\n",
> > +             codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK],
> > +             codec_dai->playback_widget->active,
> > +             codec_dai->rate);
> > +
> > +     if (codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK] &&
> > +         codec_dai->playback_widget->active)
> > +             snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
> > +                                    SND_SOC_CLOCK_IN);
>
> And that part is also worthy of a comment, e.g. why not do this as part
> of the TRIGGER_RESUME and why only for playback?
>
>
> > --- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> > +++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
>
> same comments for this other machine driver.
>
