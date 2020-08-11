Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE52C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4320772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHKHDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:03:13 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35078 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHKHDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:03:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5ECC3FB03;
        Tue, 11 Aug 2020 09:03:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 76SNf614j2F1; Tue, 11 Aug 2020 09:03:08 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 42C0445637; Tue, 11 Aug 2020 09:03:08 +0200 (CEST)
Date:   Tue, 11 Aug 2020 09:03:08 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, daniel.baluta@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] soc: imx: gpcv2: Use dev_err_probe() to simplify error
 handling
Message-ID: <20200811070308.GB2904@bogon.m.sigxcpu.org>
References: <1597115082-20328-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597115082-20328-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Aug 11, 2020 at 11:04:42AM +0800, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/soc/imx/gpcv2.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 6cf8a7a..db7e7fc 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -487,22 +487,17 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>  
>  	domain->regulator = devm_regulator_get_optional(domain->dev, "power");
>  	if (IS_ERR(domain->regulator)) {
> -		if (PTR_ERR(domain->regulator) != -ENODEV) {
> -			if (PTR_ERR(domain->regulator) != -EPROBE_DEFER)
> -				dev_err(domain->dev, "Failed to get domain's regulator\n");
> -			return PTR_ERR(domain->regulator);
> -		}
> +		if (PTR_ERR(domain->regulator) != -ENODEV)
> +			return dev_err_probe(domain->dev, PTR_ERR(domain->regulator),
> +					     "Failed to get domain's regulator\n");
>  	} else if (domain->voltage) {
>  		regulator_set_voltage(domain->regulator,
>  				      domain->voltage, domain->voltage);
>  	}
>  
>  	ret = imx_pgc_get_clocks(domain);
> -	if (ret) {
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(domain->dev, "Failed to get domain's clocks\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(domain->dev, ret, "Failed to get domain's clocks\n");
>  
>  	ret = pm_genpd_init(&domain->genpd, NULL, true);
>  	if (ret) {

Reviewed-by: Guido Günther <agx@sigxcpu.org>
 -- Guido

> -- 
> 2.7.4
> 
