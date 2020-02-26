Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449F9C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15024685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="ZLSvvco2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgBZLSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:18:38 -0500
Received: from smtp2.axis.com ([195.60.68.18]:31005 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgBZLSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=3583; q=dns/txt; s=axis-central1;
  t=1582715916; x=1614251916;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-transfer-encoding;
  bh=Hv403MB3fJ/nudFxpKI8mhxgcwJ2vMWrIa/zuMIGGwQ=;
  b=ZLSvvco2ULTf10kshrs5pdnLQy39p4REh9rG7WPUIU/iUNhpbHjPD9fm
   ofelPUeVlkr2pgIZILF6ZywcgZM/4RPbNTZi1p+7VXdKkysu53198CmZW
   HZCNumb3F/uFzH35w2Fii8TSF2Mbs+6gAk7hdPHPUVUkxYPWkO0jAsu6N
   +QO7SqEHyd1Ju09+oMO/lb6eD6g+18Q8CMCEx1lVL/zYL6ps6xPo97VG+
   w6DURvauBdBoWA6ahRBfYAKi8ktsPS36H757IilDf7TIQMU8ibB0FDX42
   Oa8o0yDtNDgo2ZTjRUoSAoTfmYM8+yMMMoRx/f1ZXTIIQzkl3m8Dw4M42
   A==;
IronPort-SDR: xNdLtj/Y/Zx3jbKBFF2d3A3R47JOypJ8M83BBv6Q9VLihj3+LMJOEhD/UN9Cj1efQMcpEgvUde
 DuhCA4VfSOoVk4G3yy/SMaEI0kWPvHaSasS+yaCt30UJFACCWfCcYlqscgK1VfTGbnQsyCFqME
 XXmqEqad0PyAqXjmQvzucku77Z7FqdkE3nP404btD1qxtt53E/Mco/Gm+pcCx0CyYxIbtU8xvQ
 IEPUVo8hQY9cRlJvBFi5m9PCaTC8lGnnFMH5QSecqwpukYq8G/MJ85gSEr6MRI3GvjtIjU99zD
 xEg=
X-IronPort-AV: E=Sophos;i="5.70,487,1574118000"; 
   d="scan'208";a="5677792"
Date:   Wed, 26 Feb 2020 12:18:29 +0100
From:   Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To:     Dan Murphy <dmurphy@ti.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
In-Reply-To: <20200219125942.22013-3-dmurphy@ti.com>
Message-ID: <alpine.DEB.2.20.2002261138040.19469@lnxricardw1.se.axis.com>
References: <20200219125942.22013-1-dmurphy@ti.com> <20200219125942.22013-3-dmurphy@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX02.axis.com (10.0.5.16) To XBOX03.axis.com (10.0.5.17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Feb 2020, Dan Murphy wrote:

> Add the tlv320adcx140 codec driver family.
>

...

> +
> +static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
> +                              unsigned int fmt)
> +{
> +       struct snd_soc_component *component = codec_dai->component;
> +       struct adcx140_priv *adcx140 =
> snd_soc_component_get_drvdata(component);
> +       u8 iface_reg1 = 0;
> +       u8 iface_reg2 = 0;
> +
> +       /* set master/slave audio interface */
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +               iface_reg2 |= ADCX140_BCLK_FSYNC_MASTER;

Although this sets up the codec to be I2S master, there doesn't seem to be 
a way of actually configuring the master clock frequency in master mode, 
as there is no .set_sysclk member in adcx140_dai_ops (and the 
corresponding register field appears never to be touched by the driver).

> +               break;
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               break;
> +       case SND_SOC_DAIFMT_CBS_CFM:
> +       case SND_SOC_DAIFMT_CBM_CFS:
> +       default:
> +               dev_err(component->dev, "Invalid DAI master/slave interface\n");
> +               return -EINVAL;
> +       }

...

> +
> +static int adcx140_codec_probe(struct snd_soc_component *component)
> +{
> +       struct adcx140_priv *adcx140 =
> snd_soc_component_get_drvdata(component);
> +       int sleep_cfg_val = ADCX140_WAKE_DEV;
> +       u8 bias_source;
> +       u8 vref_source;
> +       int ret;
> +
> +       ret = device_property_read_u8(adcx140->dev, "ti,mic-bias-source",
> +                                     &bias_source);
> +       if (ret)
> +               bias_source = ADCX140_MIC_BIAS_VAL_VREF;
> +
> +       if (bias_source != ADCX140_MIC_BIAS_VAL_VREF &&
> +           bias_source != ADCX140_MIC_BIAS_VAL_VREF_1096 &&
> +           bias_source != ADCX140_MIC_BIAS_VAL_AVDD) {
> +               dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = device_property_read_u8(adcx140->dev, "ti,vref-source",
> +                                     &vref_source);
> +       if (ret)
> +               vref_source = ADCX140_MIC_BIAS_VREF_275V;
> +
> +       if (vref_source != ADCX140_MIC_BIAS_VREF_275V &&
> +           vref_source != ADCX140_MIC_BIAS_VREF_25V &&
> +           vref_source != ADCX140_MIC_BIAS_VREF_1375V) {

According to the data sheet, this setting controls the ADC full scale 
setting and has nothing to do with the mic bias voltage, hence using 
MIC_BIAS as part of the macro name is misleaading.

> +               dev_err(adcx140->dev, "Mic Bias source value is invalid\n");

Error text does not reflect the actual error, suggest "VREF value is 
invalid".

> +               return -EINVAL;
> +       }
> +
> +       bias_source |= vref_source;
> +
> +       ret = adcx140_reset(adcx140);
> +       if (ret)
> +               goto out;
> +
> +       if(adcx140->supply_areg == NULL)
> +               sleep_cfg_val |= ADCX140_AREG_INTERNAL;
> +
> +       ret = regmap_write(adcx140->regmap, ADCX140_SLEEP_CFG,
> sleep_cfg_val);
> +       if (ret) {
> +               dev_err(adcx140->dev, "setting sleep config failed %d\n",
> ret);
> +               goto out;
> +       }
> --
> 2.25.0
> 
> 
> 

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
