Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91EEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D843206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RER59LuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgIHRwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731624AbgIHQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208CC0612A3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:04:36 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 919001234;
        Tue,  8 Sep 2020 14:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599569961;
        bh=GDMaaknSuM/l5R2bNi1lvtcCye+AKH88XR9vhap1/7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RER59LuXTiblOv2vSyDxvZpT+Ed7gQ+POuX8WyqY88MvZXDj3Y50WMKCNegqg5to5
         K0fGTPm/wCJATwzOQEk2vCENEnxIF4UkJNBzKwxKuy+KFqt99DQEKAb/CxaK4reQ4D
         pGJqx5590eRkfuBSB+fie6ZxVTRbPj7s2eGEE6zk=
Date:   Tue, 8 Sep 2020 15:58:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     marex@denx.de, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, tomi.valkeinen@ti.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: mxsfb: check framebuffer pitch
Message-ID: <20200908125855.GL6047@pendragon.ideasonboard.com>
References: <20200908125558.256843-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908125558.256843-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch.

On Tue, Sep 08, 2020 at 02:55:58PM +0200, Stefan Agner wrote:
> The lcdif IP does not support a framebuffer pitch (stride) other than
> framebuffer width. Check for equality and reject the framebuffer
> otherwise.
> 
> This prevents a distorted picture when using 640x800 and running the
> Mesa graphics stack. Mesa tires to use a cache aligned stride, which

Still s/tires/tries/ :-)

> leads at that particular resolution to width != stride. Currently
> Mesa has no fallback behavior, but rejecting this configuration allows
> userspace to handle the issue correctly.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 8c549c3931af..fa6798d21029 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -21,6 +21,7 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_irq.h>
> @@ -81,8 +82,26 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
>  		clk_disable_unprepare(mxsfb->clk_axi);
>  }
>  
> +static struct drm_framebuffer *
> +mxsfb_fb_create(struct drm_device *dev, struct drm_file *file_priv,
> +		  const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	const struct drm_format_info *info;
> +
> +	info = drm_get_format_info(dev, mode_cmd);
> +	if (!info)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {
> +		dev_dbg(dev->dev, "Invalid pitch: fb width must match pitch\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return drm_gem_fb_create(dev, file_priv, mode_cmd);
> +}
> +
>  static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
> -	.fb_create		= drm_gem_fb_create,
> +	.fb_create		= mxsfb_fb_create,
>  	.atomic_check		= drm_atomic_helper_check,
>  	.atomic_commit		= drm_atomic_helper_commit,
>  };

-- 
Regards,

Laurent Pinchart
