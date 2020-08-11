Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE1C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC04E2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+Mr4NjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgHKWkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgHKWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:40:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F8C061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:40:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so1138pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oHyQTUvTUFNtPnfXB354eAFfqwmcdKEgh8qUciOM6ac=;
        b=Q+Mr4NjN6PyImpPTNKKWFG/Z5AoMhj9JWM8jtgqV/wwe3AMGAtvjfyZBX6qbvMR4gS
         jEE2gjM7SLo/oV7nYKYoE7s3SXRHNKUYSy71EhTAdC4vlNHYTXhjzxm8D16lKWy/9VP0
         6GxhrytItisbuM1vsjS+C6vACracgq2Lu0gS5ePRWJayQXP8eBWqh4JOwgm/HnHHIoZs
         adEqh/yuqxIdRaMkkMYVlk26ATTJQogmOkk3f2Jo0i+1j/1ewgf1n84x6ace81t5P2ks
         D1v20OwnPrvV+L/Yunwv3j/HGI1tXyUYeNGTmircrYjn6G3f0UI70CIc57DEjbCFxUHL
         YJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHyQTUvTUFNtPnfXB354eAFfqwmcdKEgh8qUciOM6ac=;
        b=lXJ1aEsxzaqWTV16eg6luDJfYeZZmcwzZ2GXFdWUXwLgH32ftEQhZ9bDec3B1uZJsj
         VyyN8WWC3kwxitiffrYMm70VvpH5Gi4DG0oQ+b9bBDASU7HDCaBKSFybe9Ab3YbQXuo0
         x+Y2SDFta9+8l96C7K6iyG1ENuyqA30rUMIDHU48m0zlNXSQdu3H8BiHuTVh2KzWhX1d
         VakPSSQk0LIoZfKadNAvMKgfuQsH3sNzW+vkj9cDgsvBGO4eSxcXRMajytapZ5vCk1kr
         iS9lVlpFp47oKWjuN78qbjA48yBhTOEYCLl5jwqzGjK7TxcYsSfgcFS4c91vkIISxHam
         TIHg==
X-Gm-Message-State: AOAM533upq0C7TQBWTfMGC94LqY1K80ftuaKUjBH5x9ZwLuQsvgF6cU1
        Tzy2jvrtB52YFpsVgB5tHYIwOg==
X-Google-Smtp-Source: ABdhPJxZbnhyHXEuAi6bn+/WtHF0uq2xziDKvJZWF/LkfqD8tkRi5PWfAoTWSGeKiZbvWFHQfirOrA==
X-Received: by 2002:a62:6186:: with SMTP id v128mr8416919pfb.211.1597185632526;
        Tue, 11 Aug 2020 15:40:32 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x136sm115500pfc.28.2020.08.11.15.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 15:40:31 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:40:29 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     bjorn.andersson@linaro.org, o.rempel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
Message-ID: <20200811224029.GE3370567@xps15>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-5-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724080813.24884-5-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 04:08:07PM +0800, Peng Fan wrote:
> Make syscon optional, since i.MX8QM/QXP/7ULP not have SRC to control M4.
> But currently i.MX8QM/QXP/7ULP not added, so still check regmap
> when start/stop to avoid unhappy things.
> 
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 82594a800a1b..4fad5c0b1c05 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -162,6 +162,9 @@ static int imx_rproc_start(struct rproc *rproc)
>  	struct device *dev = priv->dev;
>  	int ret;
>  
> +	if (!priv->regmap)
> +		return -EOPNOTSUPP;

Proceeding this way is hard to maintain.  I would perfer to add specific
operations based on the scenario or coprocessor we are working with.

> +
>  	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
>  				 dcfg->src_mask, dcfg->src_start);
>  	if (ret)
> @@ -177,6 +180,9 @@ static int imx_rproc_stop(struct rproc *rproc)
>  	struct device *dev = priv->dev;
>  	int ret;
>  
> +	if (!priv->regmap)
> +		return -EOPNOTSUPP;
> +
>  	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
>  				 dcfg->src_mask, dcfg->src_stop);
>  	if (ret)
> @@ -325,9 +331,10 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
>  	if (IS_ERR(regmap)) {
>  		dev_err(dev, "failed to find syscon\n");
> -		return PTR_ERR(regmap);
> +		regmap = NULL;
> +	} else {
> +		regmap_attach_dev(dev, regmap, &config);

Here you are altering how all the existing implemenation are currently working.
Add a new field to imx_rproc_dcfg and based on that, determine if a regmap is
mandatory or not.

>  	}
> -	regmap_attach_dev(dev, regmap, &config);
>  
>  	/* set some other name then imx */
>  	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
> -- 
> 2.16.4
> 
