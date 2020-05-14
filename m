Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9689D2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCvY9KI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgENN4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:56:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFCAC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:56:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l3so2410287edq.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+xHuZjo6KNAs+z1Fg1etYI0ZDPjZlGNVfRX79r5Asc=;
        b=cCvY9KI1FbDobXpMhhwl2WwnN+EsPPvgYyEiMrAD4glHm4KzFVHDgnlpwH37j9MbtK
         gsz+qcsUAu91xC+geISjhtgZCIITvJyxIKBcGKcQVJ6Prl/fFp/FbXWswxx02m7W+csz
         MgUq4qq4DY+8xNKuJ9jUCctr9J3PgoS/G2Xp1OrUYl5zn0Qlk6zcNjmQct511eDI4jUT
         VTY7VOEovgUg+2H1srBFRhwLrVwDN0ZEuAdUzpToBpUnbOEgh4xfp5CCiUURCb8jldco
         Gv+Ep+w8U2OBvonD0rlxnLdQaZl48WqN9Jx8G0EvYnSF7hRSu9QihEAasn2+QNyaRX/2
         tK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+xHuZjo6KNAs+z1Fg1etYI0ZDPjZlGNVfRX79r5Asc=;
        b=QfQr+COAFFeh+76wL9JW49Pc1FDVGQNrlQRxohfEbRAPXPJ1WW2TLVByreIT/diEH0
         dKrXAKfoI4VIjttxmShEPFH4kfqlSuQapcmMhKN4YgdEoavOMfXDv08CxoOQZ9C0GMOl
         Z6oz+4oOIEWOciI4+E1cX0qyEx+PbUzAwTFeyD5kaQg+xs4OdvXHGrC6blKcUQRGAzzz
         JQIGKoxoa+lRaBkjCTTFUzDDP7zVl0CN0Ths6G8S2GbZZYmll29y+Y8WurSCwzlfjbT9
         j3lGmobp6xuXktMaxOUBo3L2MGvXZdtrX0iVA0deBfzMeUqF/pV/4q5FP3iY2IkvdbaS
         p+rA==
X-Gm-Message-State: AOAM530YD6fVMGD6jiplI6/38k5f/6EtvaOLPxRSXhaOdCh7uMST1WNV
        R2wNc6oNXVpiFpxt+eDL1fTaJF6AbXwR19AqH7cgag==
X-Google-Smtp-Source: ABdhPJzLytZIaO6j2t1SQtOpGH2XKnaKhB4wQijwQhHx46ZVuOyc8LUGd/+MDixW4mNEUlzsubRKAWvH6kxi4Uogno8=
X-Received: by 2002:aa7:d90f:: with SMTP id a15mr342636edr.52.1589464608820;
 Thu, 14 May 2020 06:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200513192020.544928-1-lma@semihalf.com> <52ab4557-e551-ce20-247c-681c2a0d1ad1@linux.intel.com>
In-Reply-To: <52ab4557-e551-ce20-247c-681c2a0d1ad1@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 14 May 2020 06:56:37 -0700
Message-ID: <CABXOdTeqjRh7st_fWYCZD0d8iuVJV+g+4ukoVHKEkOL4RmqQhg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 5:47 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 5/13/20 2:20 PM, Lukasz Majczak wrote:
> > Split be_hw_params_fixup function for different codecs as current common
> > function, leads to crash while trying to get snd_soc_dpcm with
> > container_of() macro in kabylake_ssp_fixup().
> > The crash call path looks as below:
> > soc_pcm_hw_params()
> > snd_soc_dai_hw_params(codec_dai, substream, &codec_params);
> > rtd->dai_link->be_hw_params_fixup(rtd, params)
> > kabylake_ssp_fixup()
> > In this case, codec_params is just a copy of an internal structure and is
> > not embedded into struct snd_soc_dpcm thus we cannot use
> > container_of() on it.
>
> This looks like a nice/welcome change, we've had these unexplained
> crashes on KBL since 4.19 (reported by Guenter and me). I thought they
> were topology related.
>

Not entirely unexplained. See
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1600868,
which fixes the problem for all three affected drivers.

Someone had told me, though, that the problem is no longer seen. Guess
that was wrong.

Guenter

> If indeed this fixes the issue, it might be worth applying in to all
> stable releases?
>
> Since we have the same code structure for the other kbl drivers, would
> it also make sense to apply the same fixes there:
>
> kbl_da7219_max98927.c:  struct snd_soc_dpcm *dpcm = container_of(
> kbl_rt5663_max98927.c:  struct snd_soc_dpcm *dpcm = container_of(
>
>
> >
> > Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> > ---
> >   .../intel/boards/kbl_rt5663_rt5514_max98927.c | 68 +++++++++++--------
> >   1 file changed, 39 insertions(+), 29 deletions(-)
> >
> > diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > index 1b1f8d7a4ea3..2e0ae724122c 100644
> > --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > @@ -328,46 +328,55 @@ static const struct snd_soc_ops kabylake_rt5663_fe_ops = {
> >       .startup = kbl_fe_startup,
> >   };
> >
> > -static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
> > -                                     struct snd_pcm_hw_params *params)
> > +static void kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
> > +     struct snd_pcm_hw_params *params, snd_pcm_format_t pcm_fmt)
> >   {
> >       struct snd_interval *rate = hw_param_interval(params,
> >                       SNDRV_PCM_HW_PARAM_RATE);
> > -     struct snd_interval *chan = hw_param_interval(params,
> > +     struct snd_interval *channels = hw_param_interval(params,
> >                       SNDRV_PCM_HW_PARAM_CHANNELS);
> >       struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
> > -     struct snd_soc_dpcm *dpcm = container_of(
> > -                     params, struct snd_soc_dpcm, hw_params);
> > -     struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
> > -     struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
> >
> >       /*
> >        * The ADSP will convert the FE rate to 48k, stereo, 24 bit
> >        */
> > -     if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
> > -         !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
> > -         !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
> > -             rate->min = rate->max = 48000;
> > -             chan->min = chan->max = 2;
> > -             snd_mask_none(fmt);
> > -             snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
> > -     } else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
> > -             if (params_channels(params) == 2 ||
> > -                             DMIC_CH(dmic_constraints) == 2)
> > -                     chan->min = chan->max = 2;
> > -             else
> > -                     chan->min = chan->max = 4;
> > -     }
> > -     /*
> > -      * The speaker on the SSP0 supports S16_LE and not S24_LE.
> > -      * thus changing the mask here
> > -      */
> > -     if (!strcmp(be_dai_link->name, "SSP0-Codec"))
> > -             snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
> >
> > +     rate->min = rate->max = 48000;
> > +     channels->min = channels->max = 2;
> > +
> > +     snd_mask_none(fmt);
> > +     snd_mask_set_format(fmt, pcm_fmt);
> > +}
> > +
> > +static int kabylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
> > +     struct snd_pcm_hw_params *params)
> > +{
> > +     kabylake_ssp_fixup(rtd, params, SNDRV_PCM_FORMAT_S16_LE);
> >       return 0;
> >   }
> >
> > +static int kabylake_ssp1_fixup(struct snd_soc_pcm_runtime *rtd,
> > +     struct snd_pcm_hw_params *params)
> > +{
> > +
> > +     kabylake_ssp_fixup(rtd, params, SNDRV_PCM_FORMAT_S24_LE);
> > +     return 0;
> > +}
> > +
> > +static int kabylake_dmic_cap_fixup(struct snd_soc_pcm_runtime *rtd,
> > +     struct snd_pcm_hw_params *params)
> > +{
> > +     struct snd_interval *channels = hw_param_interval(params,
> > +                     SNDRV_PCM_HW_PARAM_CHANNELS);
> > +
> > +     if (params_channels(params) == 2 ||
> > +                     DMIC_CH(dmic_constraints) == 2)
> > +             channels->min = channels->max = 2;
> > +     else
> > +             channels->min = channels->max = 4;
> > +
> > +     return 0;
> > +}
> >   static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
> >       struct snd_pcm_hw_params *params)
> >   {
> > @@ -582,6 +591,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
> >               .dpcm_capture = 1,
> >               .nonatomic = 1,
> >               .dynamic = 1,
> > +             .be_hw_params_fixup = kabylake_dmic_cap_fixup,
> >               .ops = &kabylake_dmic_ops,
> >               SND_SOC_DAILINK_REG(dmic, dummy, platform),
> >       },
> > @@ -618,7 +628,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
> >                       SND_SOC_DAIFMT_NB_NF |
> >                       SND_SOC_DAIFMT_CBS_CFS,
> >               .ignore_pmdown_time = 1,
> > -             .be_hw_params_fixup = kabylake_ssp_fixup,
> > +             .be_hw_params_fixup = kabylake_ssp0_fixup,
> >               .dpcm_playback = 1,
> >               .dpcm_capture = 1,
> >               .ops = &kabylake_ssp0_ops,
> > @@ -632,7 +642,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
> >               .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> >                       SND_SOC_DAIFMT_CBS_CFS,
> >               .ignore_pmdown_time = 1,
> > -             .be_hw_params_fixup = kabylake_ssp_fixup,
> > +             .be_hw_params_fixup = kabylake_ssp1_fixup,
> >               .ops = &kabylake_rt5663_ops,
> >               .dpcm_playback = 1,
> >               .dpcm_capture = 1,
> >
