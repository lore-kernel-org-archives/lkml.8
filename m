Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102F7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37342078D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6gwvDdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgFPX2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgFPX2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 19:28:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0518DC061573;
        Tue, 16 Jun 2020 16:28:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so36882plo.12;
        Tue, 16 Jun 2020 16:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nokaqO/7ikLY/CaZfj8RUoWXt7iRv0GsTFng8UE3qCw=;
        b=e6gwvDdVsFAYgNKppHkmPneIamMoxYKb+W8s99Afmhxm/8zE417O3gj6Fzg1PDGboS
         xWiqlnxIQTI3upPI0UHHS6mWgN7nJBr01/atAzaO7z4KWBo/iZVWgAfrTHDWt03gc88A
         wmmCNj9DhLunFnQjlyo+OPRItLYaHz/Xn6FWfd5bNfAw6LaYen9/0w0E+B4VY33cLY+8
         P0R4wMuKjyxOZ7IG1XCcDhfPBbCrW7kcpF9Hw6Y4kkUCxW0ybg885R88J2XovyyCGUS4
         2CEApyQqeu7SO77ui569hu6N5IyIbbUvNmkx0ZGgZH8aJ1DeUJOuA0crga3hn7rJHQzl
         Sh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nokaqO/7ikLY/CaZfj8RUoWXt7iRv0GsTFng8UE3qCw=;
        b=kzC2Dy4UGn5zl/ren7xWWUqtCNUzFjZSXMQ/4wX5iOEgOJhhH8Oem7UccEBepkSVbN
         FIwOpYPQhM7dP1+FKfokYTxmV6DJyrev2TedaVlTUz56ncb9kd2HinMNzqgTkyBovkYu
         LPmgXUGHdHl7AsqEwex4hVcIyOiisUH9QMoTX8b70Xja4+nRzYHfR5QLuzmO5z6mpiho
         ofU2shenqX37Hv8KsQTnHXMveJZNcwXLwFJ1ip8CpGj7EheCkPVjuTJm6dJne9K1Gxqv
         IXg1QsLTactDvj3vNryV2/BbYLW1yi6LhWlRR9tV0HpM+bbD2P0iLIPPoDpQlPjROk62
         GmYg==
X-Gm-Message-State: AOAM533UdYdO2KKLxA4s0hRaSq9ELH0IEakaNEr7hKySPmtvUQZ1q3bY
        yO3ZbrNuBrcOZx6KIIZZ1VY=
X-Google-Smtp-Source: ABdhPJyewwpFThwB7lVfDvCFj438Fo7Ix52QUxyvLW3sT2CUftR5ocnuBGDk+n7WlQXuxAkGZHplNg==
X-Received: by 2002:a17:902:ed14:: with SMTP id b20mr4118681pld.173.1592350108783;
        Tue, 16 Jun 2020 16:28:28 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b1sm3547523pjc.33.2020.06.16.16.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2020 16:28:28 -0700 (PDT)
Date:   Tue, 16 Jun 2020 16:28:11 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl_spdif: Add support for imx6sx platform
Message-ID: <20200616232810.GA19896@Asurada-Nvidia>
References: <1592289761-29118-1-git-send-email-shengjiu.wang@nxp.com>
 <1592289761-29118-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592289761-29118-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 02:42:41PM +0800, Shengjiu Wang wrote:
> The one difference on imx6sx platform is that the root clock
> is shared with ASRC module, so we add a new flags "ind_root_clk"
> which means the root clock is independent, then we will not
> do the clk_set_rate and clk_round_rate to avoid impact ASRC
> module usage.
> 
> As add a new flags, we include the soc specific data struct.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_spdif.c | 43 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 1b2e516f9162..00e06803d32f 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -42,6 +42,17 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
>  
>  #define DEFAULT_RXCLK_SRC	1
>  
> +/**
> + * struct fsl_spdif_soc_data: soc specific data
> + *
> + * @imx: for imx platform
> + * @ind_root_clk: flag for round clk rate
> + */
> +struct fsl_spdif_soc_data {
> +	bool imx;
> +	bool ind_root_clk;

"ind" doesn't look very straightforward; maybe "shared_root_clock"?

And for its comments:
	* @shared_root_clock: flag of sharing a clock source with others;
	*		      so the driver shouldn't set root clock rate

> +};
> +
>  /*
>   * SPDIF control structure
>   * Defines channel status, subcode and Q sub
> @@ -93,6 +104,7 @@ struct fsl_spdif_priv {
>  	struct snd_soc_dai_driver cpu_dai_drv;
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
> +	const struct fsl_spdif_soc_data *soc;

Looks better if we move it to the top of the list :)

> @@ -421,7 +448,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
>  	sysclk_df = spdif_priv->sysclk_df[rate];
>  
>  	/* Don't mess up the clocks from other modules */
> -	if (clk != STC_TXCLK_SPDIF_ROOT)
> +	if (clk != STC_TXCLK_SPDIF_ROOT || !spdif_priv->soc->ind_root_clk)
>  		goto clk_set_bypass;
>  
>  	/* The S/PDIF block needs a clock of 64 * fs * txclk_df */
> @@ -1186,7 +1213,8 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
>  			continue;
>  
>  		ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index,
> -					     i == STC_TXCLK_SPDIF_ROOT);
> +					     i == STC_TXCLK_SPDIF_ROOT &&
> +					     spdif_priv->soc->ind_root_clk);

Having more than one place that checks the condition, we can add:

/* Check if clk is a root clock that does not share clock source with others */
static inline bool fsl_spdif_can_set_clk_rate(struct fsl_spdif_priv *spdif, int clk)
{
	return (clk == STC_TXCLK_SPDIF_ROOT) && !spdif->soc->shared_root_clock;
}
