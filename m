Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F6FC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670F720753
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584472855;
	bh=HfdeKzKf8iAj9re4wGORdBPF20jUw2IniTJ4HTwrkXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LYrv8WAdNYjzBFaXHqy2U5LHKCjuF658rb4pGKR4quXJYRO3mnGjzrVXntaK1uPEm
	 AOtVpLJAMwsQAE2ZFKqFH3TpOAWSV+Q4PqW9zutb1K6Kuvj5P9CMrxm3AVUJTeGdnZ
	 Uksod+2EvG3PHc6BqyKc6u3CEpMuHOJ+gS/PxwJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCQTUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgCQTUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:20:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AAB220752;
        Tue, 17 Mar 2020 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584472853;
        bh=HfdeKzKf8iAj9re4wGORdBPF20jUw2IniTJ4HTwrkXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r93DEXPj2+/m+a6jGwOn7QaEgc3tXMtLN4BQlH9nrlxvrhGRuNx+hsg5vKg9hktQO
         stvemR/K5xKmcBI2D87B/wRxICdZoBCpYUZjy/o5NoDDbTDwidnDuZ5oTkDC+MlFum
         mOsb47DTJU0VYZELICenHBmwz767Uuqq1ZjGm9rg=
Date:   Tue, 17 Mar 2020 20:20:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     rafael@kernel.org, hminas@synopsys.com, mathias.nyman@intel.com,
        bgolaszewski@baylibre.com, arnd@arndb.de,
        jeffrey.t.kirsher@intel.com, hdegoede@redhat.com,
        treding@nvidia.com, tglx@linutronix.de, tomas.winkler@intel.com,
        suzuki.poulose@arm.com, sergei.shtylyov@cogentembedded.com,
        geert@linux-m68k.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] drivers: provide
 devm_platform_get_and_ioremap_resource()
Message-ID: <20200317192051.GA1520272@kroah.com>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
 <20200315140525.21780-2-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315140525.21780-2-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 10:05:21PM +0800, Dejin Zheng wrote:
> Since commit "drivers: provide devm_platform_ioremap_resource()",
> it was wrap platform_get_resource() and devm_ioremap_resource() as
> single helper devm_platform_ioremap_resource(). but now, many drivers
> still used platform_get_resource() and devm_ioremap_resource()
> together in the kernel tree. The reason can not be replaced is they
> still need use the resource variables obtained by platform_get_resource().
> so provide this helper.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v2 -> v3:
> 	- rename the function to
> 	  devm_platform_get_and_ioremap_resource() by Sergei's suggestion.
> 	- make the last parameter res as optional by Geert's suggestion.
> 
> v1 -> v2:
> 	- No change.
> 
>  drivers/base/platform.c         | 22 ++++++++++++++++++++++
>  include/linux/platform_device.h |  3 +++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7fa654f1288b..9f6a78f79235 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -62,6 +62,28 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>  
>  #ifdef CONFIG_HAS_IOMEM
> +/**
> + * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
> + *					    platform device and get resource
> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource management
> + * @index: resource index
> + * @res: get the resource
> + */
> +void __iomem *
> +devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
> +				unsigned int index, struct resource **res)
> +{
> +	struct resource *r;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	if (res)
> +		*res = r;

What happens if that call fails?  Shouldn't that be checked?

thanks,

greg k-h
