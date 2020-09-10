Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE24C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECFB20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="yQxa1uFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgIJR2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIJR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:26:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6195FC061796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:25:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so955377wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q2MB5IT0bikMUn6c3zdS8TDwnoNX5JcV8nLKLxukdHs=;
        b=yQxa1uFqI6MzIP4AqqSAIuyvo6uBBV3k3Ss9wgQa87lkdUj0po3ZTMLz7EHRG0Jt1E
         nQyxpy+RWU0GKPNGZJ13/9XO82+cWeiegUHAVHtJdnorgiw3xMK0/UeDcGH+2HpURtPK
         SSr4RXgK5/2eoYffF+/5MKW3gtwziDrrUkU0G2KF3tz2RHZHDrJ2IWLagey+akhm4a26
         XT53QpIydi7x+cDDwuJlSso35BtJGfhwbr/QWpmFpL0YlZO15AzgQi1ozpNcWhwO1SNt
         9ekevTze2NsqpUpE5dN3bA/tJUhiyifOoTeRdxcVfwyMnd/sf+MRS1P/4c5BtxPiuTOo
         9grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q2MB5IT0bikMUn6c3zdS8TDwnoNX5JcV8nLKLxukdHs=;
        b=IjhQS6Gbt0LIqrPc1h1wD2G8iCV9rlsZ6IpRM3VhNbvV2Jt7Ex/AGtWfonw/L5X9AW
         tLUKlOXVieEYnDv+tmaz4vIX2WxyapdMvlb8Ywhr5KQKYwFdTWGCUGUtwd0LJuxqqw9H
         EkAehhre90NGE4D9ViuBr4WL4l0skb1M7bstt7TOPH/W4sxOeaitW4ZmWK7k/q74SbPD
         V2ngSEQfwhMPCAmLuA40hjt6kA/zOEzvDu49LdKS9GgbzqJU+5zHZF2JRr8cNs5SwLt/
         olPxYyRgMmrOga1gwg6Y+an2m3fA5g2JSdxmaX20A6AJIwlECRnE9qdFIY2jimP5MB+9
         o3zw==
X-Gm-Message-State: AOAM531KGWhHwdwI7E8ZNf+tWU9Zgn1jf6ln+m8ySauCN3RcRZP4MeYv
        y7B3ysUdeEg0bcUzd0/Jj1B2YGPtNMIgFf1nzDjw8w==
X-Google-Smtp-Source: ABdhPJzmdh6qHKOv2bhof65lb3HDGws/sZ2pyZiT/DiZwR9e/Xtzl6vG3Np4bTQPLhFZANFWZVuX6qxarL8zi1z1eyQ=
X-Received: by 2002:a1c:6346:: with SMTP id x67mr1078770wmb.42.1599758748908;
 Thu, 10 Sep 2020 10:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200910154056.30962-1-rad@semihalf.com> <333f3365-1ef4-068a-5845-feb01bf46d03@linux.intel.com>
In-Reply-To: <333f3365-1ef4-068a-5845-feb01bf46d03@linux.intel.com>
From:   =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Date:   Thu, 10 Sep 2020 19:25:33 +0200
Message-ID: <CAOs-w0+knBPoE0vcvHRgjjNumQ_2CL6uhrEBQTpe0khWtNMb2g@mail.gmail.com>
Subject: Re: [PATCH V4] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Harshapriya <harshapriya.n@intel.com>,
        "Sienkiewicz, Michal" <michal.sienkiewicz@intel.com>,
        Lech Betlej <Lech.Betlej@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        John Hsu <KCHSU0@nuvoton.com>, Yong Zhi <yong.zhi@intel.com>,
        Mac Chiang <mac.chiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Pierre.
Sending V6.

czw., 10 wrz 2020 o 17:58 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
>
> almost there, only couple of typos below. The comments are really good no=
w!
>
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
> > -
> > -     if (ret < 0)
> > -             dev_err(rtd->dev, "snd_soc_dai_set_sysclk err =3D %d\n", =
ret);
> > +     int ret =3D 0;
> > +
> > +     switch (cmd) {
> > +     case SNDRV_PCM_TRIGGER_START:
> > +             /* Since 256xFS clocks cannot be generated by SKL, the NA=
U8825
> > +              * is configured to re-generate its system clock from the=
 BCLK
> > +              * using the FLL.
> > +              * We must switch system clock (FLL to use BCLK) here as =
it is
> > +              * not given eariler by FW (like in hw_param). We let nau=
8825 to
>
> typo: earlier
>
> > +              * use internal VCO clock till now which reduces the audi=
able
>
> type: audible
>
> > +              * pop's. */
> > +
> > +             /* fall through */
>
> I don't think it's required if there's no code?
>
> > +
> > +     case SNDRV_PCM_TRIGGER_RESUME:
> > +             /* Once device resumes, the system will only enable power
> > +              * sequence for playback without doing hardware parameter=
, audio
> > +              * format, and PLL configure. In the mean time, the jack
> > +              * detecion sequence has changed PLL parameters and switc=
hed to
>
> typo: detection
>
> > +              * internal clock. Thus, the playback signal distorted wi=
thout
> > +              * correct PLL parameters. Therefore we need to configure=
 PLL
> > +              * again */
> > +             ret =3D snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL=
_FS, 0,
> > +                                          SND_SOC_CLOCK_IN);
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
> > +     }
>
> same comments for the other machine driver.
> >
> >       return ret;
> >   }
> >
> > -static const struct snd_soc_ops skylake_nau8825_ops =3D {
> > -     .hw_params =3D skylake_nau8825_hw_params,
> > +static struct snd_soc_ops skylake_nau8825_ops =3D {
> > +     .trigger =3D skylake_nau8825_trigger,
> >   };
> >
> >   static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
> > diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/=
intel/boards/skl_nau88l25_ssm4567.c
> > index 4b317bcf6ea0..d076f19f9b78 100644
> > --- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> > +++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> > @@ -12,6 +12,7 @@
> >
> >   #include <linux/module.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/delay.h>
> >   #include <sound/core.h>
> >   #include <sound/pcm.h>
> >   #include <sound/soc.h>
> > @@ -57,12 +58,12 @@ static const struct snd_kcontrol_new skylake_contro=
ls[] =3D {
> >   };
> >
> >   static int platform_clock_control(struct snd_soc_dapm_widget *w,
> > -             struct snd_kcontrol *k, int  event)
> > +             struct snd_kcontrol *k, int event)
> >   {
> >       struct snd_soc_dapm_context *dapm =3D w->dapm;
> >       struct snd_soc_card *card =3D dapm->card;
> >       struct snd_soc_dai *codec_dai;
> > -     int ret;
> > +     int ret =3D 0;
> >
> >       codec_dai =3D snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_=
DAI);
> >       if (!codec_dai) {
> > @@ -70,14 +71,7 @@ static int platform_clock_control(struct snd_soc_dap=
m_widget *w,
> >               return -EIO;
> >       }
> >
> > -     if (SND_SOC_DAPM_EVENT_ON(event)) {
> > -             ret =3D snd_soc_dai_set_sysclk(codec_dai,
> > -                             NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK=
_IN);
> > -             if (ret < 0) {
> > -                     dev_err(card->dev, "set sysclk err =3D %d\n", ret=
);
> > -                     return -EIO;
> > -             }
> > -     } else {
> > +     if (!SND_SOC_DAPM_EVENT_ON(event)) {
> >               ret =3D snd_soc_dai_set_sysclk(codec_dai,
> >                               NAU8825_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN=
);
> >               if (ret < 0) {
> > @@ -85,6 +79,7 @@ static int platform_clock_control(struct snd_soc_dapm=
_widget *w,
> >                       return -EIO;
> >               }
> >       }
> > +
> >       return ret;
> >   }
> >
> > @@ -344,24 +339,51 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_=
runtime *rtd,
> >       return 0;
> >   }
> >
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
> > -
> > -     if (ret < 0)
> > -             dev_err(rtd->dev, "snd_soc_dai_set_sysclk err =3D %d\n", =
ret);
> > +     int ret =3D 0;
> > +
> > +     switch (cmd) {
> > +     case SNDRV_PCM_TRIGGER_START:
> > +             /* Since 256xFS clocks cannot be generated by SKL, the NA=
U8825
> > +              * is configured to re-generate its system clock from the=
 BCLK
> > +              * using the FLL.
> > +              * We must switch system clock (FLL to use BCLK) here as =
it is
> > +              * not given eariler by FW (like in hw_param). We let nau=
8825 to
> > +              * use internal VCO clock till now which reduces the audi=
able
> > +              * pop's. */
> > +
> > +             /* fall through */
> > +
> > +     case SNDRV_PCM_TRIGGER_RESUME:
> > +             /* Once device resumes, the system will only enable power
> > +              * sequence for playback without doing hardware parameter=
, audio
> > +              * format, and PLL configure. In the mean time, the jack
> > +              * detecion sequence has changed PLL parameters and switc=
hed to
> > +              * internal clock. Thus, the playback signal distorted wi=
thout
> > +              * correct PLL parameters. Therefore we need to configure=
 PLL
> > +              * again */
> > +             ret =3D snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL=
_FS, 0,
> > +                                          SND_SOC_CLOCK_IN);
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
> > +     }
> >
> >       return ret;
> >   }
> >
> > -static const struct snd_soc_ops skylake_nau8825_ops =3D {
> > -     .hw_params =3D skylake_nau8825_hw_params,
> > +static struct snd_soc_ops skylake_nau8825_ops =3D {
> > +     .trigger =3D skylake_nau8825_trigger,
> >   };
> >
> >   static const unsigned int channels_dmic[] =3D {
> > @@ -582,6 +604,7 @@ static struct snd_soc_dai_link skylake_dais[] =3D {
> >               .init =3D skylake_ssm4567_codec_init,
> >               .ignore_pmdown_time =3D 1,
> >               .be_hw_params_fixup =3D skylake_ssp_fixup,
> > +             .ops =3D &skylake_nau8825_ops,
> >               .dpcm_playback =3D 1,
> >               .dpcm_capture =3D 1,
> >               SND_SOC_DAILINK_REG(ssp0_pin, ssp0_codec, platform),
> >
