Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFF0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FD42075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn3TRd1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbgEYFJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEYFJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:09:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4955C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:09:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so8231796pgg.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YRJ/uOHwZy2ewPR+X9jA1rwhfgU5ND1HSwCyer+uJtE=;
        b=kn3TRd1Ful72W4WI09lPbmOCFr0cc8jgn/UQsM8xyEHuv8XRoTCZ59qmXXiaJBYdoa
         dF8Tv4JnSYd5PhsKJTrKoICFXCjSlY+YIKoDpi2QAOLNDCqzDQEtS1UZX8GztwRd2dbL
         g6heL6VZWCf46y76J1lh8DWJYvCsWLZMV2AeLcr4UVpkTHgncjJbjnXezE67plJYDmJM
         oBCaj405nHTpfZIa/Wnd8188OR8SSLVyQTWoNjr3xX4v5nqTUQC60PyDpgC/33A5yg3P
         6sZxeN6t3t2rsso7zauGnonIyue2jEA2Yp0zYhZNMYU53O4gGdSqdnKcZOe71a1ICc1T
         WNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YRJ/uOHwZy2ewPR+X9jA1rwhfgU5ND1HSwCyer+uJtE=;
        b=gEJdK6e/VcDoKdaYLxjhCi4SOJFgWDuMAJlHW+j2Dzh9EZ/k/STj0vqHhGN2VazjBG
         0ZkC3MQteJRiJB68G0sFNQXUDFvwj3jpBhNg14r+qpHAXu5zAXLvL68y+Tc0Ehy5wlwI
         poyOQH1pLPDWuSE3iIq3/E4hh3g4UdMQJCh258FVF4Ce7zn8yI1eRVEbb/YpHeqKXJ0s
         dbcqpjYwsPF0jeux2YGFNWbDpSTbIbymD4ML+IGt67kgbTWQCqTcwAjWizkYit4NiAgY
         FWQiSk1DpSmBMK0YLCwQr6SbQkKPcPd7TDqO8lUWDjTRuyPk4qUSaJeRv+o43xemk2a9
         PZEA==
X-Gm-Message-State: AOAM533XQKnGP1W1JYeDO7lyBvkl5Zz2pB2k6wxDaVwt7AusKwAw22IY
        6BkdKyGJEvnQaDP1o55gk9c=
X-Google-Smtp-Source: ABdhPJzQCUPRj8DgbPosLYa7RFU4MdgVjnRbidmCGmop2YwNzGzhcWemC1QhhiQMgnYiykuu8Rio6A==
X-Received: by 2002:a62:be18:: with SMTP id l24mr3743697pff.12.1590383398285;
        Sun, 24 May 2020 22:09:58 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id 7sm12153013pfc.203.2020.05.24.22.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 22:09:58 -0700 (PDT)
Date:   Sun, 24 May 2020 22:09:51 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc: Merge suspend/resume function to
 runtime_suspend/resume
Message-ID: <20200525050950.GA1244@Asurada>
References: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 05:57:24PM +0800, Shengjiu Wang wrote:
> With dedicated power domain for asrc, power can be disabled after
> probe and pm runtime suspend, then the value of all registers need to
> be restored in pm runtime resume. So we can merge suspend/resume function
> to runtime_suspend/resume function and enable regcache only in end of
> probe.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 70 ++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 43 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 432936039de4..3ebbe15ac378 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -1100,6 +1100,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, asrc);
>  	pm_runtime_enable(&pdev->dev);
>  	spin_lock_init(&asrc->lock);
> +	regcache_cache_only(asrc->regmap, true);
>  
>  	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
>  					      &fsl_asrc_dai, 1);
> @@ -1117,6 +1118,7 @@ static int fsl_asrc_runtime_resume(struct device *dev)
>  	struct fsl_asrc *asrc = dev_get_drvdata(dev);
>  	struct fsl_asrc_priv *asrc_priv = asrc->private;
>  	int i, ret;
> +	u32 asrctr;
>  
>  	ret = clk_prepare_enable(asrc->mem_clk);
>  	if (ret)
> @@ -1135,6 +1137,24 @@ static int fsl_asrc_runtime_resume(struct device *dev)
>  			goto disable_asrck_clk;
>  	}
>  
> +	/* Stop all pairs provisionally */
> +	regmap_read(asrc->regmap, REG_ASRCTR, &asrctr);
> +	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> +			   ASRCTR_ASRCEi_ALL_MASK, 0);
> +
> +	/* Restore all registers */
> +	regcache_cache_only(asrc->regmap, false);
> +	regcache_mark_dirty(asrc->regmap);


I see you doing regcache_mark_dirty() in the resume() now,
being different from previously doing in suspend()?

Thanks
Nic


> +	regcache_sync(asrc->regmap);
> +
> +	regmap_update_bits(asrc->regmap, REG_ASRCFG,
> +			   ASRCFG_NDPRi_ALL_MASK | ASRCFG_POSTMODi_ALL_MASK |
> +			   ASRCFG_PREMODi_ALL_MASK, asrc_priv->regcache_cfg);
> +
> +	/* Restart enabled pairs */
> +	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> +			   ASRCTR_ASRCEi_ALL_MASK, asrctr);
> +
>  	return 0;
>  
>  disable_asrck_clk:
> @@ -1155,6 +1175,11 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
>  	struct fsl_asrc_priv *asrc_priv = asrc->private;
>  	int i;
>  
> +	regmap_read(asrc->regmap, REG_ASRCFG,
> +		    &asrc_priv->regcache_cfg);
> +
> +	regcache_cache_only(asrc->regmap, true);
> +
>  	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
>  		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
>  	if (!IS_ERR(asrc->spba_clk))
> @@ -1166,51 +1191,10 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
>  }
>  #endif /* CONFIG_PM */
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int fsl_asrc_suspend(struct device *dev)
> -{
> -	struct fsl_asrc *asrc = dev_get_drvdata(dev);
> -	struct fsl_asrc_priv *asrc_priv = asrc->private;
> -
> -	regmap_read(asrc->regmap, REG_ASRCFG,
> -		    &asrc_priv->regcache_cfg);
> -
> -	regcache_cache_only(asrc->regmap, true);
> -	regcache_mark_dirty(asrc->regmap);
> -
> -	return 0;
> -}
> -
> -static int fsl_asrc_resume(struct device *dev)
> -{
> -	struct fsl_asrc *asrc = dev_get_drvdata(dev);
> -	struct fsl_asrc_priv *asrc_priv = asrc->private;
> -	u32 asrctr;
> -
> -	/* Stop all pairs provisionally */
> -	regmap_read(asrc->regmap, REG_ASRCTR, &asrctr);
> -	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> -			   ASRCTR_ASRCEi_ALL_MASK, 0);
> -
> -	/* Restore all registers */
> -	regcache_cache_only(asrc->regmap, false);
> -	regcache_sync(asrc->regmap);
> -
> -	regmap_update_bits(asrc->regmap, REG_ASRCFG,
> -			   ASRCFG_NDPRi_ALL_MASK | ASRCFG_POSTMODi_ALL_MASK |
> -			   ASRCFG_PREMODi_ALL_MASK, asrc_priv->regcache_cfg);
> -
> -	/* Restart enabled pairs */
> -	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> -			   ASRCTR_ASRCEi_ALL_MASK, asrctr);
> -
> -	return 0;
> -}
> -#endif /* CONFIG_PM_SLEEP */
> -
>  static const struct dev_pm_ops fsl_asrc_pm = {
>  	SET_RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
> -	SET_SYSTEM_SLEEP_PM_OPS(fsl_asrc_suspend, fsl_asrc_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  };
>  
>  static const struct fsl_asrc_soc_data fsl_asrc_imx35_data = {
> -- 
> 2.21.0
> 
