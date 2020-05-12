Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FB0C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A7E20674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDXMwwMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgELJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgELJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:17:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D795C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:17:58 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so12750330lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ogr2lxeowgYbZEMLXWm3SAB7ITNzM8QGV6+p/HpOjTc=;
        b=tDXMwwMTkaPstTlMdWw85/vflUnOQMtIdmp2NWu5H+qPftBJLUYj+uk0a07HM9Uj6Z
         6CUe20QcvfTfopNPvK0MYJew0c1l7s1Qn13UR0CCaKF3E5ZnJFyLC++n7ttyy+MeyvKj
         ikuqwpQ1sjp/81lqSu5e8FQum56OySXcq1yx2NfFLeZZrIO7tRKO8SqmOLAIi9xz5dic
         mOg0u2Tap515V81qy/kf9ckbkNtPMWtrKNFYCT1fhwEeBwLX+xuLvuUebv0VlT+6TRia
         LOp+DPtOxw//eH17v+UzV0WaM+4XFIXxO0XV8gOxzNkzZvMSJ5OMGGPh3pgZauhDKlDS
         Ru7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ogr2lxeowgYbZEMLXWm3SAB7ITNzM8QGV6+p/HpOjTc=;
        b=Jcw8K4wWb8OCyn37Xz960RM0uYSsXnHE0fBtNL1O0J1ArcKjG1s2M0UEl2JYmIE1H2
         bXvnufFGNUFpnXXjkR6LBaLPTZio0e6rJfeskmh66OD22i5tJQ/eTUB4Aw7KmfVtbLBo
         FjqyuNZqIW0BgDrWYv1FPyusv59zgz+OBoVHlm6K4p8ig2f6GQLWgvRhbPVScK1B4uxV
         yFRMYxynyBfEk+TSQG3CAm//24hRiYZ6RVlAiIXJnPHc3kxw+dDiTaUtQ2mMyHYtL90s
         umSVUZryYCnV1Etx7TkxbfjFh7jI0hNtnSKwKVEUJipdwXQPK+UEdWqh+5oNa+LBAnDZ
         irhw==
X-Gm-Message-State: AOAM531aEk3GaV4h5TPOfuONJvc97KAeh3PcFMjZvOeTcVM10K17QH/X
        Jg0lXiUQQM4jzg/c61q0wRkUV1gong4CDChEZhs=
X-Google-Smtp-Source: ABdhPJyDtO3ZVYVz/n+4aVI6zGvBg9WaC/2epTL5to0F/1UvdX0rqVzQXDuuYOv36BeyxdrHiHC5GFKc0Aju4yH52fs=
X-Received: by 2002:a2e:3a0a:: with SMTP id h10mr12229738lja.54.1589275076502;
 Tue, 12 May 2020 02:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200509031919.9006-1-steves.lee@maximintegrated.com> <CA+Px+wUdavr-qqEEng86ZAuwx++J-qB3va7p28EjOx-K9SyBtg@mail.gmail.com>
In-Reply-To: <CA+Px+wUdavr-qqEEng86ZAuwx++J-qB3va7p28EjOx-K9SyBtg@mail.gmail.com>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Tue, 12 May 2020 18:17:44 +0900
Message-ID: <CABff4NS7L4EsqNALMOmyTY-Q=ZyDct9JXP1C2Y-XcnhXf48+=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 8:16 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> (The patch passed 2 round review in https://crrev.com/c/2083354)
>
> On Sun, May 10, 2020 at 4:23 PM Steve Lee <steves.lee.maxim@gmail.com> wrote:
> > +static int max98390_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> > +{
> > +       struct snd_soc_component *component = codec_dai->component;
> > +       struct max98390_priv *max98390 =
> > +               snd_soc_component_get_drvdata(component);
> > +       unsigned int mode;
> > +       unsigned int format;
> > +       unsigned int invert;
> > +
> > +       dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
> > +
> > +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > +       case SND_SOC_DAIFMT_CBS_CFS:
> > +               mode = MAX98390_PCM_MASTER_MODE_SLAVE;
> > +               break;
> > +       case SND_SOC_DAIFMT_CBM_CFM:
> > +               max98390->master = true;
> > +               mode = MAX98390_PCM_MASTER_MODE_MASTER;
> > +               break;
> > +       default:
> > +               dev_err(component->dev, "DAI clock mode unsupported\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       regmap_update_bits(max98390->regmap,
> > +               MAX98390_PCM_MASTER_MODE,
> > +               MAX98390_PCM_MASTER_MODE_MASK,
> > +               mode);
> > +
> > +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > +       case SND_SOC_DAIFMT_NB_NF:
> > +               break;
> > +       case SND_SOC_DAIFMT_IB_NF:
> > +               invert = MAX98390_PCM_MODE_CFG_PCM_BCLKEDGE;
> > +               break;
> > +       default:
> > +               dev_err(component->dev, "DAI invert mode unsupported\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       regmap_update_bits(max98390->regmap,
> > +               MAX98390_PCM_MODE_CFG,
> > +               MAX98390_PCM_MODE_CFG_PCM_BCLKEDGE,
> > +               invert);
> invert will be uninitialized in the SND_SOC_DAIFMT_NB_NF case.
Thank you for feedback.
I've add initial value for invert.
>
> > +static int max98390_dai_hw_params(struct snd_pcm_substream *substream,
> > +               struct snd_pcm_hw_params *params,
> > +       struct snd_soc_dai *dai)
> Lack of 1 tab indent.
Done as requested.
>
> > +static int max98390_adaptive_rdc_get(struct snd_kcontrol *kcontrol,
> > +               struct snd_ctl_elem_value *ucontrol)
> > +{
> > +       int rdc, rdc0;
> > +       struct snd_soc_component *component =
> > +               snd_soc_kcontrol_component(kcontrol);
> > +       struct max98390_priv *max98390 =
> > +               snd_soc_component_get_drvdata(component);
> > +
> > +       regmap_read(max98390->regmap, THERMAL_RDC_RD_BACK_BYTE1, &rdc);
> > +       regmap_read(max98390->regmap, THERMAL_RDC_RD_BACK_BYTE0, &rdc0);
> > +       rdc0 |= rdc << 8;
> > +       ucontrol->value.integer.value[0] = rdc0;
> ucontrol->value.integer.value[0] = rdc0 | (rdc << 8);
Done as requested.
>
> > +static int max98390_dsm_init(struct snd_soc_component *component)
> > +{
> > +       int ret;
> > +       const char *filename;
> > +       struct max98390_priv *max98390 =
> > +               snd_soc_component_get_drvdata(component);
> > +       const struct firmware *fw = NULL;
> > +       char *dsm_param = NULL;
> Don't need to initialize fw and dsm_param in the case.
Done as requested.
>
> > +
> > +       filename = "dsm_param.bin";
> Either:
> - initialize when declaring the variable
> - remove the variable and inline into request_firmware() call
I've added initialized at declare.
>
> > +       ret = request_firmware(&fw, filename, component->dev);
> > +       if (ret) {
> > +               dev_err(component->dev,
> > +                       "Failed to acquire dsm params: %d\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       dev_info(component->dev,
> > +               "max98390: param fw size %d\n",
> > +               fw->size);
> > +       dsm_param = (char *)fw->data;
> > +       dsm_param += MAX98390_DSM_PAYLOAD_OFFSET;
> > +       regmap_bulk_write(max98390->regmap, DSM_EQ_BQ1_B0_BYTE0,
> > +               dsm_param,
> > +               fw->size - MAX98390_DSM_PAYLOAD_OFFSET);
> > +       release_firmware(fw);
> > +       regmap_write(max98390->regmap, MAX98390_R23E1_DSP_GLOBAL_EN, 0x01);
> > +
> > +err:
> > +       return ret;
> > +}
>
> > +static int max98390_probe(struct snd_soc_component *component)
> > +{
> > +       struct max98390_priv *max98390 =
> > +               snd_soc_component_get_drvdata(component);
> > +
> > +       /* Update dsm bin param */
> This comment makes more sense if before max98390_dsm_init().
Done as requested.
>
> > +       regmap_write(max98390->regmap, MAX98390_SOFTWARE_RESET, 0x01);
> > +       /* Sleep reset settle time */
> > +       msleep(20);
> > +       max98390_dsm_init(component);
>
> > +       /* Check Revision ID */
> > +       ret = regmap_read(max98390->regmap,
> > +               MAX98390_R24FF_REV_ID, &reg);
> > +       if (ret < 0) {
> if (ret)
Done as requested.
