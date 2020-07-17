Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE06C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E015D20691
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByVp6Wt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGQXFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQXFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:05:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583CC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:05:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so6073226pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3H0Vh00IRKzCqaSJWt5u8CYfkWTwsm78qHc8X28mKmc=;
        b=ByVp6Wt5m/FeQUoUFlfMLR1rwwN6YgIRsuPzcRru2QEwKI8UBS5HKM+/CBU8MvUzRs
         UPeOmEMN3veeGhpgplkMswkEmXua57k3BVDoKgiE7m8xEW3aZDmc4Ux+d1dpEzExQjC9
         UoHbdraS05REdNWuylTFdGmd3it5FEmQDw1U4ByNrZubRrTTBcbhHusqn8PF92g8rMM5
         bqwwqwg9ZRG26fTSju4/DKEiVWuPp6o+NNeC6qhpNMrvszg9EukXypLChoUQXB9lCnTo
         ldJuh1boWO2Iud6v7S78gk2mlNUf7Vt1ndFmWmTVRnXlvytOraKnwwEIRGCC4yOkwDrw
         RKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3H0Vh00IRKzCqaSJWt5u8CYfkWTwsm78qHc8X28mKmc=;
        b=W+p73jy0x3JZCumAbXNawf/xNT9gJn+0qhIIpSAllY1LiMP5vNUD2H23kp7bz28QIP
         M/aamicQg1aFuabMFOJpHNA94lFfweiAQi1nKpTp/rFN9m6tYqSESzXAdbF1N2LplUA3
         OI4uMJLJH4tm6EB2NbGDxl8FN4kL7oDqsPHyEROBIJ5cKJLUQ8EgCijVLVlUlQYJAOta
         Yzk8CTyrEAegAjUeiti80b9V6cdKHBvFbHz6TS8dhFkqNWR804vP4dLvAAf2+P4J2IQH
         53MLG/rFeMa91npIiN8KtViQhJ87Qwzo/8ADx64gmosNJaALXOwwmd/UNTRu33ha7Ye6
         VNew==
X-Gm-Message-State: AOAM532n6hsG24+9KJS5tTsjnbkMErBlwHGi8qsFdnEl0STIZwLWp+fx
        g7RrSBtjD+k8WgLbQniWlWM=
X-Google-Smtp-Source: ABdhPJyKgCSrMLmiluhbf331goesNHl+jb4YRWG/2E7K5OCBCavw+EXkU0fOpqtvaaCAuUheyerpzw==
X-Received: by 2002:a65:60ce:: with SMTP id r14mr10914462pgv.85.1595027140212;
        Fri, 17 Jul 2020 16:05:40 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id h3sm3724821pjz.23.2020.07.17.16.05.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jul 2020 16:05:39 -0700 (PDT)
Date:   Fri, 17 Jul 2020 16:05:12 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 1/1] ASoC: fsl_asrc: make sure the input and output
 clocks are different
Message-ID: <20200717230511.GA8495@Asurada-Nvidia>
References: <20200716232000.GA27246@Asurada-Nvidia>
 <20200717103857.31877-1-arnaud.ferraris@collabora.com>
 <20200717103857.31877-2-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717103857.31877-2-arnaud.ferraris@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:38:58PM +0200, Arnaud Ferraris wrote:
> The current clock selection algorithm might select the same clock for
> both input and output when, for instance, the output sample rate is a
> multiple of the input rate.
> 
> In that case, both selectable clocks will be multiples of both the input
> and output sample rates, and therefore the first of these clocks will be
> selected for both input and output, leading to miscalculation of the
> dividers for either the input or output side.
> 
> Example:
>   Input uses clock A (512kHz) and has a sample rate of 8kHz
>   Output uses clock B (1024kHz) and has a sample rate of 16kHz
> 
>   In this case, the algorithm will select clock A for both input and
>   output: the input divider will therefore be calculated properly
>   (512 / 8 => 64), but the output divider's value will be only half
>   the expected value (512 / 16 => 32 instead of 1024 / 16 => 64).
> 
> This patch makes sure it always selects distinct input and output
> clocks.

Please allow me to take some time to review the use case and
the changes. And I'd love to wait for a review from Shengjiu
also, as he introduced this auto-selection function and he's
more familiar with internal ratio mode.

Thanks

> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 02c81d2e34ad..de10c208d3c8 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -608,8 +608,8 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
>  {
>  	struct fsl_asrc_pair_priv *pair_priv = pair->private;
>  	struct asrc_config *config = pair_priv->config;
> -	int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
> -	int clk_rate, clk_index;
> +	int rate[2], select_clk[2], clk_index[2]; /* Array size 2 means IN and OUT */
> +	int clk_rate;
>  	int i = 0, j = 0;
>  
>  	rate[IN] = in_rate;
> @@ -618,11 +618,15 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
>  	/* Select proper clock source for internal ratio mode */
>  	for (j = 0; j < 2; j++) {
>  		for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
> -			clk_index = asrc_priv->clk_map[j][i];
> -			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
> -			/* Only match a perfect clock source with no remainder */
> +			clk_index[j] = asrc_priv->clk_map[j][i];
> +			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index[j]]);
> +			/*
> +			 * Only match a perfect clock source with no remainder
> +			 * and make sure the input & output clocks are different
> +			 */
>  			if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
> -			    (clk_rate % rate[j]) == 0)
> +			    (clk_rate % rate[j]) == 0 &&
> +			    (j == 0 || clk_index[j] != clk_index[j - 1]))
>  				break;
>  		}
>  
> -- 
> 2.27.0
> 
