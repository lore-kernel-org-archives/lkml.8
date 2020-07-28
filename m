Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DFFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342D82070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SHdzSv+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgG1Tzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:55:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42536 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgG1Tzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:55:52 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9E261563;
        Tue, 28 Jul 2020 21:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595966150;
        bh=Ek9PDCjtDrljLj9dX2Nv2p7+BZc0pNCNzsykgmIhh14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHdzSv+RS6Rx1i2emjSFFawcZviRPFisZXSuYNoXgKuy4kcBmw+i8+S4P0bq7D2cH
         0t0KxB4KPdIpSLbB7JfUTRVsoTmSMXf2kQWQnQGLIfi+LgP939wuXaQEPUw5q01RxW
         62xWDNmwMMyTU1qAmcbe6ZCmGRao5i3+4iqvqGGQ=
Date:   Tue, 28 Jul 2020 22:55:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200728195541.GN13753@pendragon.ideasonboard.com>
References: <20200728170939.28278-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728170939.28278-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Tue, Jul 28, 2020 at 07:09:39PM +0200, Krzysztof Kozlowski wrote:
> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:
> 
>     drivers/dma/ti/omap-dma.c:1892:34: warning: 'omap_dma_match' defined but not used [-Wunused-const-variable=]
>      1892 | static const struct of_device_id omap_dma_match[] = {
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/ti/omap-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 918301e17552..c9fe5e3a6b55 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1904,7 +1904,7 @@ static struct platform_driver omap_dma_driver = {
>  	.remove	= omap_dma_remove,
>  	.driver = {
>  		.name = "omap-dma-engine",
> -		.of_match_table = of_match_ptr(omap_dma_match),
> +		.of_match_table = omap_dma_match,
>  	},
>  };
>  

-- 
Regards,

Laurent Pinchart
