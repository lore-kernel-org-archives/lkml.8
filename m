Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41CCC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FB82076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="LoFTSdWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgDPRQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728997AbgDPRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:16:33 -0400
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B30C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1587057391;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=gQAshWE/P5d+q8GSxfuiqFoIRojHnDC1rboPu/Wp8h8=;
        b=LoFTSdWjDH8Qt31gsOX3HSf2Vw5mfp97SBXmjFwknjkUieH1BvfcAmNIK87T4UgiGK
        gFAYt/Wy1u0dmkusYglGXS4fj+MXy7rFzfv2GIOJNYI1Bu3qY7dmdl5+cfjdK2Vd9C6Y
        RodgUpaCVjz7NbHsh42JuEWwJnYiJeTrt6BNyeHgDBnZnyT3a4JplvjDtWT9+xyDq67M
        CPx/6YkVyErQD7O+bLYtUYdnAtrnBY2WUTd6+wnH4yp4nm2GXYs5T1JaImMLmRohuPq9
        UzdypdWxgnqkhbXCWoGslViFj43TkO4i2o89Udx4kMhkY45XSQlVyvkfL+T4gpcdfMgY
        xS3w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IczFaoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.4.0 DYNA|AUTH)
        with ESMTPSA id k074e0w3GHGVBm9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 16 Apr 2020 19:16:31 +0200 (CEST)
Date:   Thu, 16 Apr 2020 19:16:24 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Takahide Higuchi <takahidehiguchi@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: support full duplex operation
Message-ID: <20200416171624.GA174353@gerhold.net>
References: <20200306130147.27452-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130147.27452-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 01:01:47PM +0000, Srinivas Kandagatla wrote:
> From: Takahide Higuchi <takahidehiguchi@gmail.com>
> 
> This patch fixes a bug where playback on bidirectional I2S interface stops
> when we start recording on the same interface.
> 
> We use regmap_update_bits instead of regmap_write so that we will not clear
> SPKEN and SPKMODE bits when we start/stop recording.
> 

Thanks for the patch! I don't have suitable hardware to test this
feature, but I checked if playback-only is still working correctly:

With this patch I can only play audio once. Further playback
never starts, it gets stuck immediately. Suggested fix below.
(Also a minor code style suggestion...)

> Signed-off-by: Takahide Higuchi <takahidehiguchi@gmail.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/lpass-apq8016.c   |  2 ++
>  sound/soc/qcom/lpass-cpu.c       | 24 ++++++++++++++++++------
>  sound/soc/qcom/lpass-lpaif-reg.h |  2 +-
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
> index 6575da549237..85079c697faa 100644
> --- a/sound/soc/qcom/lpass-apq8016.c
> +++ b/sound/soc/qcom/lpass-apq8016.c
> @@ -121,6 +121,8 @@ static struct snd_soc_dai_driver apq8016_lpass_cpu_dai_driver[] = {
>  		},
>  		.probe	= &asoc_qcom_lpass_cpu_dai_probe,
>  		.ops    = &asoc_qcom_lpass_cpu_dai_ops,
> +		.symmetric_samplebits   = 1,
> +		.symmetric_rates        = 1,
>  	},
>  };
>  
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index dbce7e92baf3..dc8acb380b6f 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -72,6 +72,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>  	snd_pcm_format_t format = params_format(params);
>  	unsigned int channels = params_channels(params);
>  	unsigned int rate = params_rate(params);
> +	unsigned int mask;
>  	unsigned int regval;
>  	int bitwidth, ret;
>  
> @@ -81,6 +82,9 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>  		return bitwidth;
>  	}
>  
> +	mask   = LPAIF_I2SCTL_LOOPBACK_MASK |
> +			LPAIF_I2SCTL_WSSRC_MASK |
> +			LPAIF_I2SCTL_BITWIDTH_MASK;
>  	regval = LPAIF_I2SCTL_LOOPBACK_DISABLE |
>  			LPAIF_I2SCTL_WSSRC_INTERNAL;
>  

I understand the space after "mask" here (to align the =) ...

> @@ -100,6 +104,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>  	}
>  
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		mask   |= LPAIF_I2SCTL_SPKMODE_MASK | LPAIF_I2SCTL_SPKMONO_MASK;
>  		switch (channels) {
>  		case 1:
>  			regval |= LPAIF_I2SCTL_SPKMODE_SD0;
> @@ -127,6 +132,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>  			return -EINVAL;
>  		}
>  	} else {
> +		mask   |= LPAIF_I2SCTL_MICMODE_MASK | LPAIF_I2SCTL_MICMONO_MASK;
>  		switch (channels) {
>  		case 1:
>  			regval |= LPAIF_I2SCTL_MICMODE_SD0;

... but they don't make much sense to me in these two cases.
It looks a bit weird in my opinion :)

> @@ -155,9 +161,9 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>  		}
>  	}
>  
> -	ret = regmap_write(drvdata->lpaif_map,
> -			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> -			   regval);
> +	ret = regmap_update_bits(drvdata->lpaif_map,
> +			 LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> +			 mask, regval);
>  	if (ret) {
>  		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
>  		return ret;
> @@ -178,11 +184,17 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
>  		struct snd_soc_dai *dai)
>  {
>  	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	unsigned int mask;
>  	int ret;
>  
> -	ret = regmap_write(drvdata->lpaif_map,
> -			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> -			   0);
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		mask   = LPAIF_I2SCTL_SPKMODE_MASK;
> +	else
> +		mask   = LPAIF_I2SCTL_MICMODE_MASK;

Same here with the spaces after "mask", but more importantly:

This changes the behavior slightly. Previously we reset the entire
register, now only the SPKMODE/MICMODE. This means that SPKEN/MICEN
does not get reset to 0 when this function is called.

Everything seems to work fine again for me if I reset SPKEN/MICEN too:

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index dc8acb380b6f..49a36c1f5640 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -188,9 +188,9 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
 	int ret;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		mask   = LPAIF_I2SCTL_SPKMODE_MASK;
+		mask   = LPAIF_I2SCTL_SPKEN_MASK | LPAIF_I2SCTL_SPKMODE_MASK;
 	else
-		mask   = LPAIF_I2SCTL_MICMODE_MASK;
+		mask   = LPAIF_I2SCTL_MICEN_MASK | LPAIF_I2SCTL_MICMODE_MASK;
 
 	ret = regmap_update_bits(drvdata->lpaif_map,
 			 LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),

After looking at the code a bit more I wonder why SPKEN/MICEN is set in
prepare() at all? It is already set/un-set in trigger() on
SNDRV_PCM_TRIGGER_START and SNDRV_PCM_TRIGGER_STOP.

In fact, my problem only happens because prepare() is called again
after the stream was stopped (and therefore sets SPKEN again):

[   32.809915] lpass_cpu_daiops_hw_params
[   32.810598] lpass_cpu_daiops_prepare
[   32.823092] lpass_cpu_daiops_prepare
[   32.837901] lpass_cpu_daiops_trigger: SNDRV_PCM_TRIGGER_START
[   37.565261] lpass_cpu_daiops_trigger: SNDRV_PCM_TRIGGER_STOP
[   37.565402] lpass_cpu_daiops_prepare
[   37.565854] lpass_cpu_daiops_hw_free

In other words, a much better fix in my opinion would be to
simply remove(!) the entire lpass_cpu_daiops_prepare() method.

I tested it and that also fixes the problem, without my diff above to
unset SPKEN/MICEN in lpass_cpu_daiops_hw_free().

Thanks,
Stephan

> +
> +	ret = regmap_update_bits(drvdata->lpaif_map,
> +			 LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> +			 mask, 0);
>  	if (ret)
>  		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
>  
> diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
> index 3d74ae123e9d..7a2b9cf99976 100644
> --- a/sound/soc/qcom/lpass-lpaif-reg.h
> +++ b/sound/soc/qcom/lpass-lpaif-reg.h
> @@ -56,7 +56,7 @@
>  #define LPAIF_I2SCTL_MICMODE_6CH	(7 << LPAIF_I2SCTL_MICMODE_SHIFT)
>  #define LPAIF_I2SCTL_MICMODE_8CH	(8 << LPAIF_I2SCTL_MICMODE_SHIFT)
>  
> -#define LPAIF_I2SCTL_MIMONO_MASK	GENMASK(3, 3)
> +#define LPAIF_I2SCTL_MICMONO_MASK	GENMASK(3, 3)
>  #define LPAIF_I2SCTL_MICMONO_SHIFT	3
>  #define LPAIF_I2SCTL_MICMONO_STEREO	(0 << LPAIF_I2SCTL_MICMONO_SHIFT)
>  #define LPAIF_I2SCTL_MICMONO_MONO	(1 << LPAIF_I2SCTL_MICMONO_SHIFT)
> -- 
> 2.21.0
> 
