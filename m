Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A9C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFBB2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+k7ayqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgBUV4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:56:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38225 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:56:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6so1435311plj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4R75gLHGBZqI7rZdCrlVgn8bgkA+VU53aPQUf73iw7U=;
        b=I+k7ayqyClm2D7rCoFnih/D2ZbHNrdAKdYMiZsgvr3/8YQ/PswRNV+Ag8sRHA13Fl8
         5GG8QlXX8xyyeg5ZjML/PN3ZnZkcLGTfRc/qeTqLurZJVoPF9IvmFmBJjKScrnuS1Zmg
         Hu9BLmU8x4oXbNU9LW3fVSWW2PSr2sv8KWZRRwkrq0WsIuz8/eHaMACRA9dYAeoldwrV
         QbfLzPGYYw37ekbgDnKPEDSezIlGU0+4XzToj6Be+f0qtzwzMxZvnjLwVQS8sh9Osuoq
         eE7m4SGh5fiyElgoHNhVF1/uU3j79QFd6L0vzHwZjGLSRbvCdZz6xHq1invHhlCy+Nsj
         vpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4R75gLHGBZqI7rZdCrlVgn8bgkA+VU53aPQUf73iw7U=;
        b=RNmieUtFtDgDzzWj4CPI/oXhGsktoIn/suRNzz9KmF8gVzkbQrkOfc+3pyzLaP/XCs
         EhsGlsduO9pVVUClNoS4hiqHOt29+f3KUJR2udjdVDvqovrcEiIBJqas0yDZzbXRBOGQ
         z6sjtcPwW1sFhWrZ5FHlQt9SsmQpCu5KUrtHY3Vm9646c4hm3kHLzU3He2bYLkRSAXwt
         zC50CYi+kAq9zOrjFh6nrMdQKLJNFLHZjFGrEQed4kJgww61RDMc2gMfJTe0FGSjMy8y
         8ih0rPdNxQn45vXfurR4dPCxh30rkfDmTQe+lhXWUkz8RRWr1aagWLSe6EL0VZOXIOSy
         k6dw==
X-Gm-Message-State: APjAAAVFrVQTOLMYiv3b7qPck3oy5J4lGHs7R/Sq+UxT+6/Mu3wgkXEE
        EWL+PmKKXV+3qhX/7SFC393gow==
X-Google-Smtp-Source: APXvYqzBIUmw7IC4MYwzkgRvIoSRfaSA2ePp8ibxXugv7bCVL8F2ywUMJumZw5ngey7+HU21z3EjsA==
X-Received: by 2002:a17:902:8545:: with SMTP id d5mr36651230plo.116.1582322167908;
        Fri, 21 Feb 2020 13:56:07 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h26sm3931993pfr.9.2020.02.21.13.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:56:07 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:56:05 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] remoteproc: imx_rproc: parse early-booted property
Message-ID: <20200221215605.GC10368@xps15>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-6-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582097265-20170-6-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:27:41PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> If early-property exists, there is no need to check syscon.
> Just mark early_boot as true.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index b9fabe269fd2..e31ea1090cf3 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -483,7 +483,9 @@ static int imx_rproc_configure_mode(struct imx_rproc *priv)
>  	int ret;
>  	u32 val;
>  
> -	if (of_get_property(dev->of_node, "early-booted", NULL)) {
> +	if (dcfg->variants == IMX7ULP) {

Where does dcfg->variants comes from?  

This patch doesn't compile, nor does the one before it.  I will not review
another patchset like that. 

> +		priv->early_boot = true;
> +	} else if (of_get_property(dev->of_node, "early-booted", NULL)) {
>  		priv->early_boot = true;
>  	} else {
>  		ret = regmap_read(priv->regmap, dcfg->src_reg, &val);
> @@ -509,15 +511,17 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  	struct rproc *rproc;
>  	struct regmap_config config = { .name = "imx-rproc" };
>  	const struct imx_rproc_dcfg *dcfg;
> -	struct regmap *regmap;
> +	struct regmap *regmap = NULL;
>  	int ret;
>  
> -	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
> -	if (IS_ERR(regmap)) {
> -		dev_err(dev, "failed to find syscon\n");
> -		return PTR_ERR(regmap);
> +	if (!of_get_property(np, "early-booted", NULL)) {
> +		regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
> +		if (IS_ERR(regmap)) {
> +			dev_err(dev, "failed to find syscon\n");
> +			return PTR_ERR(regmap);
> +		}
> +		regmap_attach_dev(dev, regmap, &config);
>  	}
> -	regmap_attach_dev(dev, regmap, &config);
>  
>  	/* set some other name then imx */
>  	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
> -- 
> 2.16.4
> 
