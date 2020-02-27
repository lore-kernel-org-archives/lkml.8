Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE85C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DBA20714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="B8I1xkOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgB0IHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:07:37 -0500
Received: from smtp1.axis.com ([195.60.68.17]:32369 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0IHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=3202; q=dns/txt; s=axis-central1;
  t=1582790855; x=1614326855;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-transfer-encoding;
  bh=IUblToJWSxBgFlhnLquBrYBi+CsSdc+WRI3/2kSysr0=;
  b=B8I1xkOiXgYOL4CVK3PMLOPBSboplU9P7lpNi/Fr5MOjcYWrFeefd4cb
   MeYv1R6lbw6RpQvYVac5rAsALif2L3NUkWZX+UtVDf1EfjJbRJ0UrOY0V
   yyRU0J6SlaH6bge5e0HkgSKRSXPdWZyLHCjxZD/RQOsF5Ln2C8svgKcjD
   SXX5diybXgthZJTXtaK4xCn30AVRfrZD3KpuXeN4zjUnlc4IB+0YL2urI
   K4RPjz+oZxamRULwQlRh4UbRN4CjhTlXzWTx46NQ0F8Au69/K616NIChF
   GV6lA4hbe22VcZ8qsectCoajURMkK81wv9feNitQHTK9rRrYpH7rERSJ1
   w==;
IronPort-SDR: 4mylBMR7HB74vnqaSyqPRFX40dEnpjOoMnBlVuNPGIW7qs7HF5ObxIbo4N0k/fUcNr+n7UJGRt
 RKx5NPXkF12ol2jEG3zjRlIB/WmUQLgzH5+Fxn5H2AAVQUgOQ+UUcpMEPMn7FoPW3+IQfw+gRM
 805besfOypi/tJWnMVHMfbND3++c2GZ6MI6V+l+vAIletvAux0ZksEFgnRu833nloHg5CGV8yG
 ShkWLPAO6coCrsOzClChCelpYvdUthQjbxVgrGwF5DK7Pq07YgVEhwv6AW31pMADyCZSRDX4H9
 7bo=
X-IronPort-AV: E=Sophos;i="5.70,491,1574118000"; 
   d="scan'208";a="5877651"
Date:   Thu, 27 Feb 2020 09:07:28 +0100
From:   Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To:     Dan Murphy <dmurphy@ti.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Ricard_Wanderl=F6f?= <Ricard.Wanderlof@axis.com>
Subject: Re: [PATCH for-next] ASoC: tlv320adcx140: Fix MIC_BIAS defines for
 ADC full scale
In-Reply-To: <20200226133439.15837-1-dmurphy@ti.com>
Message-ID: <alpine.DEB.2.20.2002270906590.29598@lnxricardw1.se.axis.com>
References: <20200226133439.15837-1-dmurphy@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX03.axis.com (10.0.5.17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Feb 2020, Dan Murphy wrote:

> Change the #defines for the ADC full scale bits from MIC_BIAS to
> ADC_FSCALE.  This also changes the error message to incidate ADC full
> scale value error as opposed to the Mic bias.
> 
> Reported-by: Ricard Wanderlof <ricardw@axis.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  sound/soc/codecs/tlv320adcx140.c | 12 ++++++------
>  sound/soc/codecs/tlv320adcx140.h |  8 ++++----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320adcx140.c
> b/sound/soc/codecs/tlv320adcx140.c
> index 93a0cb8e662c..825ace9b5fa7 100644
> --- a/sound/soc/codecs/tlv320adcx140.c
> +++ b/sound/soc/codecs/tlv320adcx140.c
> @@ -758,12 +758,12 @@ static int adcx140_codec_probe(struct
> snd_soc_component *component)
>          ret = device_property_read_u8(adcx140->dev, "ti,vref-source",
>                                        &vref_source);
>          if (ret)
> -               vref_source = ADCX140_MIC_BIAS_VREF_275V;
> +               vref_source = ADCX140_ADC_FSCALE_VREF_275V;
>  
> -       if (vref_source != ADCX140_MIC_BIAS_VREF_275V &&
> -           vref_source != ADCX140_MIC_BIAS_VREF_25V &&
> -           vref_source != ADCX140_MIC_BIAS_VREF_1375V) {
> -               dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
> +       if (vref_source != ADCX140_ADC_FSCALE_VREF_275V &&
> +           vref_source != ADCX140_ADC_FSCALE_VREF_25V &&
> +           vref_source != ADCX140_ADC_FSCALE_VREF_1375V) {
> +               dev_err(adcx140->dev, "ADC full scale setting is
> invalid\n");
>                  return -EINVAL;
>          }
>  
> @@ -787,7 +787,7 @@ static int adcx140_codec_probe(struct snd_soc_component
> *component)
>  
>          ret = regmap_update_bits(adcx140->regmap, ADCX140_BIAS_CFG,
>                                  ADCX140_MIC_BIAS_VAL_MSK |
> -                               ADCX140_MIC_BIAS_VREF_MSK, bias_source);
> +                               ADCX140_ADC_FSCALE_VREF_MSK, bias_source);
>          if (ret)
>                  dev_err(adcx140->dev, "setting MIC bias failed %d\n", ret);
>  out:
> diff --git a/sound/soc/codecs/tlv320adcx140.h
> b/sound/soc/codecs/tlv320adcx140.h
> index 6d055e55909e..adb9513900b1 100644
> --- a/sound/soc/codecs/tlv320adcx140.h
> +++ b/sound/soc/codecs/tlv320adcx140.h
> @@ -117,10 +117,10 @@
>  #define ADCX140_MIC_BIAS_VAL_AVDD       6
>  #define ADCX140_MIC_BIAS_VAL_MSK GENMASK(6, 4)
>  
> -#define ADCX140_MIC_BIAS_VREF_275V     0
> -#define ADCX140_MIC_BIAS_VREF_25V      1
> -#define ADCX140_MIC_BIAS_VREF_1375V    2
> -#define ADCX140_MIC_BIAS_VREF_MSK GENMASK(1, 0)
> +#define ADCX140_ADC_FSCALE_VREF_275V   0
> +#define ADCX140_ADC_FSCALE_VREF_25V    1
> +#define ADCX140_ADC_FSCALE_VREF_1375V  2
> +#define ADCX140_ADC_FSCALE_VREF_MSK GENMASK(1, 0)
>  
>  #define ADCX140_PWR_CFG_BIAS_PDZ        BIT(7)
>  #define ADCX140_PWR_CFG_ADC_PDZ         BIT(6)
> --
> 2.25.0
> 
> 
> 

Looks good to me!

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
