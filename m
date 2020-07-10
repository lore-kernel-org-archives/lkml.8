Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A66C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68892075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGJSBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:01:33 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:52172 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGJSBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:01:33 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 58B4320037;
        Fri, 10 Jul 2020 20:01:31 +0200 (CEST)
Date:   Fri, 10 Jul 2020 20:01:30 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     srrj.967@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/4] drm: mipi-dsi: Convert logging to drm_* functions.
Message-ID: <20200710180130.GG17565@ravnborg.org>
References: <cover.1594136880.git.usuraj35@gmail.com>
 <feeec2816debcf4105ac22af1661fd2d491d02b9.1594136880.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feeec2816debcf4105ac22af1661fd2d491d02b9.1594136880.git.usuraj35@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=fBM2Ot2CnEKu5YVA4yIA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 09:58:48PM +0530, Suraj Upadhyay wrote:
> Convert logging errors from dev_err() to drm_err().
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>

Thanks. Applied to drm-misc-next as there was no more logging conversion
to do in this file.

	Sam

> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 07102d8da58f..5dd475e82995 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -34,6 +34,7 @@
>  #include <linux/slab.h>
>  
>  #include <drm/drm_dsc.h>
> +#include <drm/drm_print.h>
>  #include <video/mipi_display.h>
>  
>  /**
> @@ -155,19 +156,18 @@ static int mipi_dsi_device_add(struct mipi_dsi_device *dsi)
>  static struct mipi_dsi_device *
>  of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
>  {
> -	struct device *dev = host->dev;
>  	struct mipi_dsi_device_info info = { };
>  	int ret;
>  	u32 reg;
>  
>  	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
> -		dev_err(dev, "modalias failure on %pOF\n", node);
> +		drm_err(host, "modalias failure on %pOF\n", node);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	ret = of_property_read_u32(node, "reg", &reg);
>  	if (ret) {
> -		dev_err(dev, "device node %pOF has no valid reg property: %d\n",
> +		drm_err(host, "device node %pOF has no valid reg property: %d\n",
>  			node, ret);
>  		return ERR_PTR(-EINVAL);
>  	}
> @@ -202,22 +202,21 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>  			      const struct mipi_dsi_device_info *info)
>  {
>  	struct mipi_dsi_device *dsi;
> -	struct device *dev = host->dev;
>  	int ret;
>  
>  	if (!info) {
> -		dev_err(dev, "invalid mipi_dsi_device_info pointer\n");
> +		drm_err(host, "invalid mipi_dsi_device_info pointer\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	if (info->channel > 3) {
> -		dev_err(dev, "invalid virtual channel: %u\n", info->channel);
> +		drm_err(host, "invalid virtual channel: %u\n", info->channel);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	dsi = mipi_dsi_device_alloc(host);
>  	if (IS_ERR(dsi)) {
> -		dev_err(dev, "failed to allocate DSI device %ld\n",
> +		drm_err(host, "failed to allocate DSI device %ld\n",
>  			PTR_ERR(dsi));
>  		return dsi;
>  	}
> @@ -228,7 +227,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>  
>  	ret = mipi_dsi_device_add(dsi);
>  	if (ret) {
> -		dev_err(dev, "failed to add DSI device %d\n", ret);
> +		drm_err(host, "failed to add DSI device %d\n", ret);
>  		kfree(dsi);
>  		return ERR_PTR(ret);
>  	}
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
