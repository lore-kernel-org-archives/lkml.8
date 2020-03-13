Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9123C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A704820724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584122172;
	bh=AAEHbdTZnL6d7Gr3nuqbX2Ida62RwmUvzgcJbhcDcZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tQeOGlr/aNbqmrSu+1RUps82zZkumOW3hYDQPUobb21qV5X1PBWKhLCnp+5PwPWMU
	 T85mvvw+kPyn0qmaE9opaqjbEzvKy1XDKIVvGKqVgWQJwHFmSzKjiigGTa5/aeMm20
	 kJfEDlpqhCFL+0bkc/sflvJ7+MRykzsmaRGt4U+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCMR4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgCMR4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:56:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A57320746;
        Fri, 13 Mar 2020 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584122170;
        bh=AAEHbdTZnL6d7Gr3nuqbX2Ida62RwmUvzgcJbhcDcZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLoGD2BLHuWnmuwR3FCgqZMnqxYZ0X2OEV6TzKJA/wugGHSexcEQs6q00affCU/37
         kzERWpO9BMPm0/E+H28LUYKY1l5WV5VeMf5cxAVYzZY33jq9g8DkvxDIHAVAJN2XhM
         cmCusoj2BI6gVXH0z0fyi+bOFKoCAHiQBxyDYYYg=
Date:   Fri, 13 Mar 2020 18:56:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: provide devm_platform_ioremap_and_get_resource()
Message-ID: <20200313175608.GA2306127@kroah.com>
References: <20200313171902.31836-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313171902.31836-1-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 01:19:02AM +0800, Dejin Zheng wrote:
> Since commit "drivers: provide devm_platform_ioremap_resource()",
> It was wrap platform_get_resource() and devm_ioremap_resource() as
> single helper devm_platform_ioremap_resource(). but now, many drivers
> still used platform_get_resource() and devm_ioremap_resource()
> together in the kernel tree. The reason can not be replaced is they
> still need use the resource variables obtained by platform_get_resource().
> so provide this helper.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/base/platform.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7fa654f1288b..b3e2409effae 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -62,6 +62,24 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>  
>  #ifdef CONFIG_HAS_IOMEM
> +/**
> + * devm_platform_ioremap_and_get_resource - call devm_ioremap_resource() for a
> + *					    platform device and get resource
> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource management
> + * @index: resource index
> + * @res: get the resource
> + */
> +void __iomem *
> +devm_platform_ioremap_and_get_resource(struct platform_device *pdev,
> +				unsigned int index, struct resource **res)
> +{
> +	*res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	return devm_ioremap_resource(&pdev->dev, *res);
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_ioremap_and_get_resource);
> +
>  /**
>   * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
>   *				    device
> -- 
> 2.25.0
> 

I can not take new api functions without some real users of the function
at the same time.

Please make a patch series modifing drivers to use this new function and
I will be glad to review it then.

thanks,

greg k-h
