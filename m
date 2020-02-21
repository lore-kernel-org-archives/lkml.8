Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A75C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69E520722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oztzjCZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBUKne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:43:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45131 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgBUKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:43:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so1433211wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 02:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=y17j3JfMjOhBp3bg0o/t76XeKtZ2b+e9QhazcUZ/DV0=;
        b=oztzjCZyuKPCwe5jorKjqpGVUCsUh45QaV8hnlC1/6Ol0GqAWOEkRXfELn2BdK0wG3
         qgXRuaXEt6mFUfdXJtCiTsSSpE619tWAHLuApmFtmpBhmjuJrnyz/gGZj1ZOEmv6CGPe
         xFo/kVwsxny1VsK32QrRl+22bNULIFDEKfOYo5p4ksYHHIbAJFNDhgzb7Qz1GNzXTvQx
         gQdbh9tr7v+Xskj2ffaldUHzSpqW7HsJWb6Id/rvlmrYiWjSSX70gijwaG0xMLRmlBCn
         roLxbhhURKF6XR4OYdfLf2WxIDb9HshFovZCkB0Fh8uPwYUeccqsfX5SkZA+KdP+E05U
         D8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=y17j3JfMjOhBp3bg0o/t76XeKtZ2b+e9QhazcUZ/DV0=;
        b=XlVjNj7rgZQuTHsCxQWpQhBu6YdNgWzNVW2hoVsHlFhtsyAnMvJacfvaEf3+oNNXwW
         LW0lNg5xFKlUCLpRo6DA1htdL5Q0JFfY3ZUF9MJg7XBQ4D7g/S/95Cf5JnA2rQY7qGfJ
         yFecdSk/NuytcHPVMcQFlpymWWMv+EidzTHizdWvV+Hbto6T8f5asWGbmD50jaPxBGNm
         Q6dGJtpIR4Jes64fjLKXcxR9789AhHT6bo9jYJgLJQmWJ2Wpt53Xxw15Sk1fd35dV6wD
         DdiTPty3UPNQCT97Hd9elJCeEO1BQX+SH2zKUse8zfchOVaNj73QfQ1I7zI/RQ1ZZILy
         LuyA==
X-Gm-Message-State: APjAAAXzkBS4fF9wFgugUY9IrxpndOghVBL6yxODaj2LgXmS2fM7q470
        ADM4g92evOHogEQL9at5ctj69Q==
X-Google-Smtp-Source: APXvYqwQ6mtepZYIPlcj/NAAw+eWDJa/MMOiK0l4maoi5chkWidP9g3E3ZCQ0dYFbQuvk4hE+DhiSw==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr49810404wrj.357.1582281811037;
        Fri, 21 Feb 2020 02:43:31 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c15sm3403521wrt.1.2020.02.21.02.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:43:30 -0800 (PST)
References: <20200220205711.77953-1-martin.blumenstingl@googlemail.com> <20200220205711.77953-4-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ASoC: meson: aiu: add support for the Meson8 and Meson8b SoC families
In-reply-to: <20200220205711.77953-4-martin.blumenstingl@googlemail.com>
Date:   Fri, 21 Feb 2020 11:43:29 +0100
Message-ID: <1jr1yo2pbi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 20 Feb 2020 at 21:57, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The AIU audio controller on the Meson8 and Meson8b SoC families is
> compatible with the one found in the later GXBB family. Add compatible
> strings for these two older SoC families so the driver can be loaded for
> them.
>
> Instead of using the I2S divider from the AIU_CLK_CTRL_MORE register we
> need to use the I2S divider from the AIU_CLK_CTRL register. This older
> register is less flexible because it only supports four divider settings
> (1, 2, 4, 8) compared to the AIU_CLK_CTRL_MORE register (which supports
> dividers in the range 0..64).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  sound/soc/meson/Kconfig           |  2 +-
>  sound/soc/meson/aiu-encoder-i2s.c | 92 +++++++++++++++++++++++--------
>  sound/soc/meson/aiu.c             |  9 +++
>  sound/soc/meson/aiu.h             |  1 +
>  4 files changed, 81 insertions(+), 23 deletions(-)
>
> diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
> index 897a706dcda0..d27e9180b453 100644
> --- a/sound/soc/meson/Kconfig
> +++ b/sound/soc/meson/Kconfig
> @@ -10,7 +10,7 @@ config SND_MESON_AIU
>  	imply SND_SOC_HDMI_CODEC if DRM_MESON_DW_HDMI
>  	help
>  	  Select Y or M to add support for the Audio output subsystem found
> -	  in the Amlogic GX SoC family
> +	  in the Amlogic Meson8, Meson8b and GX SoC families
>  
>  config SND_MESON_AXG_FIFO
>  	tristate
> diff --git a/sound/soc/meson/aiu-encoder-i2s.c b/sound/soc/meson/aiu-encoder-i2s.c
> index 4900e38e7e49..cc73b5d5c2b7 100644
> --- a/sound/soc/meson/aiu-encoder-i2s.c
> +++ b/sound/soc/meson/aiu-encoder-i2s.c
> @@ -111,34 +111,40 @@ static int aiu_encoder_i2s_setup_desc(struct snd_soc_component *component,
>  	return 0;
>  }
>  
> -static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
> -				      struct snd_pcm_hw_params *params)
> +static int aiu_encoder_i2s_set_legacy_div(struct snd_soc_component *component,
> +					  struct snd_pcm_hw_params *params,
> +					  unsigned int bs)
>  {
> -	struct aiu *aiu = snd_soc_component_get_drvdata(component);
> -	unsigned int srate = params_rate(params);
> -	unsigned int fs, bs;
> -
> -	/* Get the oversampling factor */
> -	fs = DIV_ROUND_CLOSEST(clk_get_rate(aiu->i2s.clks[MCLK].clk), srate);
> +	switch (bs) {
> +	case 1:
> +	case 2:
> +	case 4:
> +	case 8:
> +		/* These are the only valid legacy dividers */
> +		break;

I wonder how it will work with the 8ch mode and 16bits but we can deal
with this later on.

>  
> -	if (fs % 64)
> +	default:
> +		dev_err(component->dev, "Unsupported i2s divider: %u\n", bs);
>  		return -EINVAL;
> +	};
>  
> -	/* Send data MSB first */
> -	snd_soc_component_update_bits(component, AIU_I2S_DAC_CFG,
> -				      AIU_I2S_DAC_CFG_MSB_FIRST,
> -				      AIU_I2S_DAC_CFG_MSB_FIRST);
> +	snd_soc_component_update_bits(component, AIU_CLK_CTRL,
> +				      AIU_CLK_CTRL_I2S_DIV,
> +				      FIELD_PREP(AIU_CLK_CTRL_I2S_DIV,
> +						 __ffs(bs)));
>  
> -	/* Set bclk to lrlck ratio */
> -	snd_soc_component_update_bits(component, AIU_CODEC_DAC_LRCLK_CTRL,
> -				      AIU_CODEC_DAC_LRCLK_CTRL_DIV,
> -				      FIELD_PREP(AIU_CODEC_DAC_LRCLK_CTRL_DIV,
> -						 64 - 1));
> +	snd_soc_component_update_bits(component, AIU_CLK_CTRL_MORE,
> +				      AIU_CLK_CTRL_MORE_I2S_DIV,
> +				      FIELD_PREP(AIU_CLK_CTRL_MORE_I2S_DIV,
> +						 0));
>  
> -	/* Use CLK_MORE for mclk to bclk divider */
> -	snd_soc_component_update_bits(component, AIU_CLK_CTRL,
> -				      AIU_CLK_CTRL_I2S_DIV, 0);
> +	return 0;
> +}
>  
> +static int aiu_encoder_i2s_set_more_div(struct snd_soc_component *component,
> +					struct snd_pcm_hw_params *params,
> +					unsigned int bs)
> +{
>  	/*
>  	 * NOTE: this HW is odd.
>  	 * In most configuration, the i2s divider is 'mclk / blck'.
> @@ -146,7 +152,6 @@ static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
>  	 * increased by 50% to get the correct output rate.
>  	 * No idea why !
>  	 */
> -	bs = fs / 64;
>  	if (params_width(params) == 16 && params_channels(params) == 8) {
>  		if (bs % 2) {
>  			dev_err(component->dev,
> @@ -156,11 +161,54 @@ static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
>  		bs += bs / 2;
>  	}
>  
> +	/* Use CLK_MORE for mclk to bclk divider */
> +	snd_soc_component_update_bits(component, AIU_CLK_CTRL,
> +				      AIU_CLK_CTRL_I2S_DIV,
> +				      FIELD_PREP(AIU_CLK_CTRL_I2S_DIV, 0));
> +
>  	snd_soc_component_update_bits(component, AIU_CLK_CTRL_MORE,
>  				      AIU_CLK_CTRL_MORE_I2S_DIV,
>  				      FIELD_PREP(AIU_CLK_CTRL_MORE_I2S_DIV,
>  						 bs - 1));
>  
> +	return 0;
> +}
> +
> +static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
> +				      struct snd_pcm_hw_params *params)
> +{
> +	struct aiu *aiu = snd_soc_component_get_drvdata(component);
> +	unsigned int srate = params_rate(params);
> +	unsigned int fs, bs;
> +	int ret;
> +
> +	/* Get the oversampling factor */
> +	fs = DIV_ROUND_CLOSEST(clk_get_rate(aiu->i2s.clks[MCLK].clk), srate);
> +
> +	if (fs % 64)
> +		return -EINVAL;
> +
> +	/* Send data MSB first */
> +	snd_soc_component_update_bits(component, AIU_I2S_DAC_CFG,
> +				      AIU_I2S_DAC_CFG_MSB_FIRST,
> +				      AIU_I2S_DAC_CFG_MSB_FIRST);
> +
> +	/* Set bclk to lrlck ratio */
> +	snd_soc_component_update_bits(component, AIU_CODEC_DAC_LRCLK_CTRL,
> +				      AIU_CODEC_DAC_LRCLK_CTRL_DIV,
> +				      FIELD_PREP(AIU_CODEC_DAC_LRCLK_CTRL_DIV,
> +						 64 - 1));
> +
> +	bs = fs / 64;
> +
> +	if (aiu->platform->has_clk_ctrl_more_i2s_div)
> +		ret = aiu_encoder_i2s_set_more_div(component, params, bs);
> +	else
> +		ret = aiu_encoder_i2s_set_legacy_div(component, params, bs);
> +
> +	if (ret)
> +		return ret;
> +
>  	/* Make sure amclk is used for HDMI i2s as well */
>  	snd_soc_component_update_bits(component, AIU_CLK_CTRL_MORE,
>  				      AIU_CLK_CTRL_MORE_HDMI_AMCLK,
> diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
> index 38209312a8c3..dc35ca79021c 100644
> --- a/sound/soc/meson/aiu.c
> +++ b/sound/soc/meson/aiu.c
> @@ -351,15 +351,24 @@ static int aiu_remove(struct platform_device *pdev)
>  
>  static const struct aiu_platform_data aiu_gxbb_pdata = {
>  	.has_acodec = false,
> +	.has_clk_ctrl_more_i2s_div = true,
>  };
>  
>  static const struct aiu_platform_data aiu_gxl_pdata = {
>  	.has_acodec = true,
> +	.has_clk_ctrl_more_i2s_div = true,
> +};
> +
> +static const struct aiu_platform_data aiu_meson8_pdata = {
> +	.has_acodec = false,
> +	.has_clk_ctrl_more_i2s_div = false,
>  };
>  
>  static const struct of_device_id aiu_of_match[] = {
>  	{ .compatible = "amlogic,aiu-gxbb", .data = &aiu_gxbb_pdata },
>  	{ .compatible = "amlogic,aiu-gxl", .data = &aiu_gxl_pdata },
> +	{ .compatible = "amlogic,aiu-meson8", .data = &aiu_meson8_pdata },
> +	{ .compatible = "amlogic,aiu-meson8b", .data = &aiu_meson8_pdata },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, aiu_of_match);
> diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
> index ab003638d5e5..87aa19ac4af3 100644
> --- a/sound/soc/meson/aiu.h
> +++ b/sound/soc/meson/aiu.h
> @@ -29,6 +29,7 @@ struct aiu_interface {
>  
>  struct aiu_platform_data {
>  	bool has_acodec;
> +	bool has_clk_ctrl_more_i2s_div;
>  };
>  
>  struct aiu {

