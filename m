Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C014AC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E24E2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGicKJpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgEKLQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgEKLQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:16:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:16:31 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w11so9171404iov.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbytLfV4nmOtT0WgpBXIzwMsuo72DJMmTPcAhYekQ0U=;
        b=GGicKJpNPw7jAN/rD2qfcGoBsewTM9yTpWHwOSs1ydICyaOkGevGh7f6hMspssZYWk
         GuGzM2V/S+FhT4YqGnPVXyEC/XVlZnvOQup/ahmdBd8dk4Brcf5P2J/9RQBlISadaFTr
         2tblRXp+0oLHkJHn24qCIJYgNQTnRUA5+ni6HjmrsMaU+Uex9KKc1mHPHJjS5KxvKKKz
         Y+jOBzYrbZlZXe/vUlW3EyrHRxMxlc0V666g4NLrseIiBHdiDClcA7RdBDjWbENeVjLD
         xY9KyCk1lkihyPppzLyiae6u3UNTXm4u/o4G5UX2RilFW0ei1t8U5Lc7brfLQ3HXQPtD
         DTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbytLfV4nmOtT0WgpBXIzwMsuo72DJMmTPcAhYekQ0U=;
        b=OXy3DjGBUS6ynMiNWuHsy5z9xP9MDSLO//F/5pSZaMqj5ve8BaSM0+VkGcQqnT1e/2
         JavPECiuhOvQftAUiDdMuaUtN8mbo3GDjvB1lBVYgYnn7agrVTTmZxreFbMzDhLxjVjw
         J18mpWPQLrLJSPB+mIPhTBRjmnSqhCC0ZUr1yqCqLRzOccIYe8My0AWZduErKXhl6Eco
         GcXgeFLIr96ntXwhAXgd8XaLiAu32hvh2fvfNRg+bkJMic5g59gOLaAiqTP+xbp6+zCv
         o2rCfbCcnf+KdjuGn0MGXdtSWIx6AYJGgQU2HUpjpsFkCblzI+Zdko8vLjY46kljH298
         zkIA==
X-Gm-Message-State: AGi0PuZipRozkmPoS7Y1QK7cYAYcEMMnw9pm1OeXc8C4F3FLEHxN8WBk
        jE3qPAl55gicAasR4aeFQKbBaBkOEuup5j/HxShaQVMn
X-Google-Smtp-Source: APiQypKBE93oJ/QzEILEEGG3u1vcqebBiJg/mZkuW2yYf35ojFi2IQ3SxLCoeZ7UmK43yS0JteXo8EYe8o/AWjacEZU=
X-Received: by 2002:a05:6638:a47:: with SMTP id 7mr14399062jap.12.1589195790247;
 Mon, 11 May 2020 04:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200509031919.9006-1-steves.lee@maximintegrated.com>
In-Reply-To: <20200509031919.9006-1-steves.lee@maximintegrated.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 11 May 2020 19:16:19 +0800
Message-ID: <CA+Px+wUdavr-qqEEng86ZAuwx++J-qB3va7p28EjOx-K9SyBtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Steve Lee <steves.lee.maxim@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        srinivas.kandagatla@linaro.org,
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

(The patch passed 2 round review in https://crrev.com/c/2083354)

On Sun, May 10, 2020 at 4:23 PM Steve Lee <steves.lee.maxim@gmail.com> wrote:
> +static int max98390_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +       struct snd_soc_component *component = codec_dai->component;
> +       struct max98390_priv *max98390 =
> +               snd_soc_component_get_drvdata(component);
> +       unsigned int mode;
> +       unsigned int format;
> +       unsigned int invert;
> +
> +       dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
> +
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               mode = MAX98390_PCM_MASTER_MODE_SLAVE;
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +               max98390->master = true;
> +               mode = MAX98390_PCM_MASTER_MODE_MASTER;
> +               break;
> +       default:
> +               dev_err(component->dev, "DAI clock mode unsupported\n");
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(max98390->regmap,
> +               MAX98390_PCM_MASTER_MODE,
> +               MAX98390_PCM_MASTER_MODE_MASK,
> +               mode);
> +
> +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +       case SND_SOC_DAIFMT_NB_NF:
> +               break;
> +       case SND_SOC_DAIFMT_IB_NF:
> +               invert = MAX98390_PCM_MODE_CFG_PCM_BCLKEDGE;
> +               break;
> +       default:
> +               dev_err(component->dev, "DAI invert mode unsupported\n");
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(max98390->regmap,
> +               MAX98390_PCM_MODE_CFG,
> +               MAX98390_PCM_MODE_CFG_PCM_BCLKEDGE,
> +               invert);
invert will be uninitialized in the SND_SOC_DAIFMT_NB_NF case.

> +static int max98390_dai_hw_params(struct snd_pcm_substream *substream,
> +               struct snd_pcm_hw_params *params,
> +       struct snd_soc_dai *dai)
Lack of 1 tab indent.

> +static int max98390_adaptive_rdc_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       int rdc, rdc0;
> +       struct snd_soc_component *component =
> +               snd_soc_kcontrol_component(kcontrol);
> +       struct max98390_priv *max98390 =
> +               snd_soc_component_get_drvdata(component);
> +
> +       regmap_read(max98390->regmap, THERMAL_RDC_RD_BACK_BYTE1, &rdc);
> +       regmap_read(max98390->regmap, THERMAL_RDC_RD_BACK_BYTE0, &rdc0);
> +       rdc0 |= rdc << 8;
> +       ucontrol->value.integer.value[0] = rdc0;
ucontrol->value.integer.value[0] = rdc0 | (rdc << 8);

> +static int max98390_dsm_init(struct snd_soc_component *component)
> +{
> +       int ret;
> +       const char *filename;
> +       struct max98390_priv *max98390 =
> +               snd_soc_component_get_drvdata(component);
> +       const struct firmware *fw = NULL;
> +       char *dsm_param = NULL;
Don't need to initialize fw and dsm_param in the case.

> +
> +       filename = "dsm_param.bin";
Either:
- initialize when declaring the variable
- remove the variable and inline into request_firmware() call

> +       ret = request_firmware(&fw, filename, component->dev);
> +       if (ret) {
> +               dev_err(component->dev,
> +                       "Failed to acquire dsm params: %d\n", ret);
> +               goto err;
> +       }
> +
> +       dev_info(component->dev,
> +               "max98390: param fw size %d\n",
> +               fw->size);
> +       dsm_param = (char *)fw->data;
> +       dsm_param += MAX98390_DSM_PAYLOAD_OFFSET;
> +       regmap_bulk_write(max98390->regmap, DSM_EQ_BQ1_B0_BYTE0,
> +               dsm_param,
> +               fw->size - MAX98390_DSM_PAYLOAD_OFFSET);
> +       release_firmware(fw);
> +       regmap_write(max98390->regmap, MAX98390_R23E1_DSP_GLOBAL_EN, 0x01);
> +
> +err:
> +       return ret;
> +}

> +static int max98390_probe(struct snd_soc_component *component)
> +{
> +       struct max98390_priv *max98390 =
> +               snd_soc_component_get_drvdata(component);
> +
> +       /* Update dsm bin param */
This comment makes more sense if before max98390_dsm_init().

> +       regmap_write(max98390->regmap, MAX98390_SOFTWARE_RESET, 0x01);
> +       /* Sleep reset settle time */
> +       msleep(20);
> +       max98390_dsm_init(component);

> +       /* Check Revision ID */
> +       ret = regmap_read(max98390->regmap,
> +               MAX98390_R24FF_REV_ID, &reg);
> +       if (ret < 0) {
if (ret)
