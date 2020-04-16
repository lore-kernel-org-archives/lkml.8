Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC6BC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0661520644
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljCN0Eh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392054AbgDPJQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441113AbgDPIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:06:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384BFC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:05:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h2so3530313wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uV16bW5Qou5HX/ecLg8k6CUH6HA5iJ8FFoob8YYamBs=;
        b=ljCN0Eh8i0yJ4+SXVeS8uWjAW7ZFvAZJwKpZ6fLDVwjGW0e0Ehfcf1AEfaWthyab7o
         2FDZt6F/h9cJMPeHORes/2aQElMBh/q6ri1YKBxOuaZcX+Gj9Q/8WHIqWYXdYS1qLTQx
         bfFGjpPm98kDJjPq3KAYPa56+q4LakqovsK8WZzKFPdTr/L94OjT9/7rH1OAW6E9gR+W
         JFQiEv+r7VIOHA2qEJiL73R6mhtpsawbtsAlYHk/f3uSifyTm3cGDY6Vf6ciRpGEH3pz
         JT3yNCMwEOkIjG61/Qk/vBqLyhd29BBp0TC+MT7XEcbpLelji96T5FAdiQUEMvigVGEZ
         B4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uV16bW5Qou5HX/ecLg8k6CUH6HA5iJ8FFoob8YYamBs=;
        b=EJz2LYz6mKz0FlSrJh0lamIFP0NDot/cRAeKs6DedlRVyVaGo3mz017gGnz4Bv1yiz
         hOh0R7XpAORaaT1qzpMtcj6kgKzqg0XS2z60ZGel2G7pL1bsyiXGEb8wkjKB/AwJUy40
         SFoSKL3qKKCQwJGc3/obdI5Z7s24XBXgud0idJ51XjkoNq0AFSKOtojhZlJwOcnMsP+R
         j1UIUIpl77bktPmS+Btjegl1BdN1B273sLLKbHdXOAF9v6dvU+c4e5zKV1+wnHSaA6Df
         PMiKdHetZRBVKqHmXaDWg8ABQRhH7PNkuHNqbl7RaOmZEfIu04b8jXr9mExJQj2wJERk
         PbPA==
X-Gm-Message-State: AGi0Puaq4PCGCeapeqSEMPo843F5CZe8/Wm0bPWWEuzdHp0k3TZWThiy
        XLfvxbchRwcQNoJG07NCPSAsdQ==
X-Google-Smtp-Source: APiQypIRGcjIwp1s+fOs+F0CzIqeFfO2L62PN8lr+ClPBiAGKeNKI2rZAgQCnriNtLAp60EQECv19Q==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr3296204wmg.167.1587024356884;
        Thu, 16 Apr 2020 01:05:56 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t67sm2687859wmg.40.2020.04.16.01.05.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 01:05:56 -0700 (PDT)
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: support full duplex operation
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takahide Higuchi <takahidehiguchi@gmail.com>
References: <20200306130147.27452-1-srinivas.kandagatla@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <841cb73b-82d3-9fb9-0ed3-547882872085@linaro.org>
Date:   Thu, 16 Apr 2020 09:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200306130147.27452-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,


On 06/03/2020 13:01, Srinivas Kandagatla wrote:
> From: Takahide Higuchi <takahidehiguchi@gmail.com>
> 
> This patch fixes a bug where playback on bidirectional I2S interface stops
> when we start recording on the same interface.
> 
> We use regmap_update_bits instead of regmap_write so that we will not clear
> SPKEN and SPKMODE bits when we start/stop recording.
> 
> Signed-off-by: Takahide Higuchi <takahidehiguchi@gmail.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Looks like this patch was missed in last cycle, Should I resend this one 
or are you okay to apply this. This patch is required to get full duplex 
on msm8916 based platforms.


thanks,
srini

> ---
>   sound/soc/qcom/lpass-apq8016.c   |  2 ++
>   sound/soc/qcom/lpass-cpu.c       | 24 ++++++++++++++++++------
>   sound/soc/qcom/lpass-lpaif-reg.h |  2 +-
>   3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
> index 6575da549237..85079c697faa 100644
> --- a/sound/soc/qcom/lpass-apq8016.c
> +++ b/sound/soc/qcom/lpass-apq8016.c
> @@ -121,6 +121,8 @@ static struct snd_soc_dai_driver apq8016_lpass_cpu_dai_driver[] = {
>   		},
>   		.probe	= &asoc_qcom_lpass_cpu_dai_probe,
>   		.ops    = &asoc_qcom_lpass_cpu_dai_ops,
> +		.symmetric_samplebits   = 1,
> +		.symmetric_rates        = 1,
>   	},
>   };
>   
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index dbce7e92baf3..dc8acb380b6f 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -72,6 +72,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   	snd_pcm_format_t format = params_format(params);
>   	unsigned int channels = params_channels(params);
>   	unsigned int rate = params_rate(params);
> +	unsigned int mask;
>   	unsigned int regval;
>   	int bitwidth, ret;
>   
> @@ -81,6 +82,9 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   		return bitwidth;
>   	}
>   
> +	mask   = LPAIF_I2SCTL_LOOPBACK_MASK |
> +			LPAIF_I2SCTL_WSSRC_MASK |
> +			LPAIF_I2SCTL_BITWIDTH_MASK;
>   	regval = LPAIF_I2SCTL_LOOPBACK_DISABLE |
>   			LPAIF_I2SCTL_WSSRC_INTERNAL;
>   
> @@ -100,6 +104,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   	}
>   
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		mask   |= LPAIF_I2SCTL_SPKMODE_MASK | LPAIF_I2SCTL_SPKMONO_MASK;
>   		switch (channels) {
>   		case 1:
>   			regval |= LPAIF_I2SCTL_SPKMODE_SD0;
> @@ -127,6 +132,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   			return -EINVAL;
>   		}
>   	} else {
> +		mask   |= LPAIF_I2SCTL_MICMODE_MASK | LPAIF_I2SCTL_MICMONO_MASK;
>   		switch (channels) {
>   		case 1:
>   			regval |= LPAIF_I2SCTL_MICMODE_SD0;
> @@ -155,9 +161,9 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   		}
>   	}
>   
> -	ret = regmap_write(drvdata->lpaif_map,
> -			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> -			   regval);
> +	ret = regmap_update_bits(drvdata->lpaif_map,
> +			 LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> +			 mask, regval);
>   	if (ret) {
>   		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
>   		return ret;
> @@ -178,11 +184,17 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
>   		struct snd_soc_dai *dai)
>   {
>   	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	unsigned int mask;
>   	int ret;
>   
> -	ret = regmap_write(drvdata->lpaif_map,
> -			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> -			   0);
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		mask   = LPAIF_I2SCTL_SPKMODE_MASK;
> +	else
> +		mask   = LPAIF_I2SCTL_MICMODE_MASK;
> +
> +	ret = regmap_update_bits(drvdata->lpaif_map,
> +			 LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
> +			 mask, 0);
>   	if (ret)
>   		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
>   
> diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
> index 3d74ae123e9d..7a2b9cf99976 100644
> --- a/sound/soc/qcom/lpass-lpaif-reg.h
> +++ b/sound/soc/qcom/lpass-lpaif-reg.h
> @@ -56,7 +56,7 @@
>   #define LPAIF_I2SCTL_MICMODE_6CH	(7 << LPAIF_I2SCTL_MICMODE_SHIFT)
>   #define LPAIF_I2SCTL_MICMODE_8CH	(8 << LPAIF_I2SCTL_MICMODE_SHIFT)
>   
> -#define LPAIF_I2SCTL_MIMONO_MASK	GENMASK(3, 3)
> +#define LPAIF_I2SCTL_MICMONO_MASK	GENMASK(3, 3)
>   #define LPAIF_I2SCTL_MICMONO_SHIFT	3
>   #define LPAIF_I2SCTL_MICMONO_STEREO	(0 << LPAIF_I2SCTL_MICMONO_SHIFT)
>   #define LPAIF_I2SCTL_MICMONO_MONO	(1 << LPAIF_I2SCTL_MICMONO_SHIFT)
> 
