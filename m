Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D53C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC322076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aXAmvMC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411365AbgDOReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411315AbgDORd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:33:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B21FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:33:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so566756wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rkck/HArmjgepuHn4NJVu+OJYGwshBlSqBTd3E9eO9s=;
        b=aXAmvMC38ItFa/I/ODNZFZ8Nrx7rhomjxXCK4J5+GBQd1yCzGiDpI4dIGYKTYh2tJN
         VgaKRL1AocDuGGpa+VM0K6CIIoL7tYRLv7yvbYFf+kfSv+MtKPOJkdAv3gmwpi8cCspn
         A/2EOdtw7HqI2BzdJb3cX7WC5xqxOjIvuzdDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Rkck/HArmjgepuHn4NJVu+OJYGwshBlSqBTd3E9eO9s=;
        b=lYrEPuUVJYW9pDavv1gpBEBxPXp3vI7og+g6i8497pX/tKVlMwLWGU2fWVtGY+Gx09
         uI2luNdZrbcvD3h1ol3l/GKjqYGz0/sH1zhaa8AhTHJJFMTIeroghSPQGdYGKZRPmXeD
         GnClezJKE6wi2r3NW9/9xDXVtIgL1jjUi63fM/rUIcejl3zRh60F/+hQmj5pRafWAdIZ
         157rU8Vz5xI2PTdraIQtdW3mhFUmf1ExVXpIFFXr7AaqHA+qHqka91+BYbaW/pIYRvxD
         zNsECmPQz+VHry4brj9RbPjy56K2rSlu32XpUT19Vq1hz1xcABIfsX95DHy325ZrZiGG
         gXVg==
X-Gm-Message-State: AGi0PuaCnfMQVXEnT+HisbMSvd58sbu6IP4HalITxwfn2pa3XLBXDWCw
        iL6hE3xNW5rYfEUlajUMFgsafA==
X-Google-Smtp-Source: APiQypIdl3rsjfv/Is2Bm6qZeSmQZagNruwgJ+J30Wx3YvhKi8ugAsblhQ2s/uQ8MCyGKbgMoJvuIQ==
X-Received: by 2002:a1c:1f96:: with SMTP id f144mr297157wmf.114.1586972003719;
        Wed, 15 Apr 2020 10:33:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z8sm3996060wrr.40.2020.04.15.10.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 10:33:23 -0700 (PDT)
Date:   Wed, 15 Apr 2020 19:33:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 1/2] DRM: ARC: add HDMI 2.0 TX encoder support
Message-ID: <20200415173320.GG3456981@phenom.ffwll.local>
Mail-Followup-To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
References: <20200414232929.22788-1-Eugeniy.Paltsev@synopsys.com>
 <20200414232929.22788-2-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414232929.22788-2-Eugeniy.Paltsev@synopsys.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:29:28AM +0300, Eugeniy Paltsev wrote:
> The Synopsys ARC SoCs (like HSDK4xD) include on-chip DesignWare HDMI
> encoders. Support them with a platform driver to provide platform glue
> data to the dw-hdmi driver.
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  MAINTAINERS                       |   6 ++
>  drivers/gpu/drm/Makefile          |   2 +-
>  drivers/gpu/drm/arc/Kconfig       |   7 ++
>  drivers/gpu/drm/arc/Makefile      |   1 +
>  drivers/gpu/drm/arc/arc-dw-hdmi.c | 116 ++++++++++++++++++++++++++++++
>  5 files changed, 131 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/arc/arc-dw-hdmi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6fbdf354d34..2aaed1190370 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1258,6 +1258,12 @@ S:	Supported
>  F:	drivers/gpu/drm/arc/
>  F:	Documentation/devicetree/bindings/display/snps,arcpgu.txt
>  
> +ARC DW HDMI DRIVER
> +M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> +S:	Supported
> +F:	drivers/gpu/drm/arc/arc-dw-hdmi.c
> +F:	Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
> +
>  ARCNET NETWORK LAYER
>  M:	Michael Grzeschik <m.grzeschik@pengutronix.de>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 6493088a0fdd..5b0bcf7f45cd 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -109,7 +109,7 @@ obj-y			+= panel/
>  obj-y			+= bridge/
>  obj-$(CONFIG_DRM_FSL_DCU) += fsl-dcu/
>  obj-$(CONFIG_DRM_ETNAVIV) += etnaviv/
> -obj-$(CONFIG_DRM_ARCPGU)+= arc/
> +obj-y			+= arc/
>  obj-y			+= hisilicon/
>  obj-$(CONFIG_DRM_ZTE)	+= zte/
>  obj-$(CONFIG_DRM_MXSFB)	+= mxsfb/
> diff --git a/drivers/gpu/drm/arc/Kconfig b/drivers/gpu/drm/arc/Kconfig
> index e8f3d63e0b91..baec9d2a4fba 100644
> --- a/drivers/gpu/drm/arc/Kconfig
> +++ b/drivers/gpu/drm/arc/Kconfig
> @@ -8,3 +8,10 @@ config DRM_ARCPGU
>  	  Choose this option if you have an ARC PGU controller.
>  
>  	  If M is selected the module will be called arcpgu.
> +
> +config DRM_ARC_DW_HDMI
> +	tristate "ARC DW HDMI"
> +	depends on DRM && OF
> +	select DRM_DW_HDMI
> +	help
> +	  Synopsys DW HDMI driver for various ARC development boards
> diff --git a/drivers/gpu/drm/arc/Makefile b/drivers/gpu/drm/arc/Makefile
> index c7028b7427b3..7a156d8c2c3c 100644
> --- a/drivers/gpu/drm/arc/Makefile
> +++ b/drivers/gpu/drm/arc/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  arcpgu-y := arcpgu_crtc.o arcpgu_hdmi.o arcpgu_sim.o arcpgu_drv.o
>  obj-$(CONFIG_DRM_ARCPGU) += arcpgu.o
> +obj-$(CONFIG_DRM_ARC_DW_HDMI) += arc-dw-hdmi.o
> diff --git a/drivers/gpu/drm/arc/arc-dw-hdmi.c b/drivers/gpu/drm/arc/arc-dw-hdmi.c
> new file mode 100644
> index 000000000000..46a6ee09b302
> --- /dev/null
> +++ b/drivers/gpu/drm/arc/arc-dw-hdmi.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Synopsys DW HDMI driver for various ARC development boards
> +//
> +// Copyright (C) 2020 Synopsys
> +// Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> +
> +#include <linux/component.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <drm/bridge/dw_hdmi.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_encoder_slave.h>
> +#include <drm/drm_of.h>
> +
> +static const struct dw_hdmi_mpll_config snps_hdmi_mpll_cfg[] = {
> +	{
> +		27000000, {
> +			{ 0x00B3, 0x0000 },
> +			{ 0x00B3, 0x0000 },
> +			{ 0x00B3, 0x0000 }
> +		},
> +	}, {
> +		74250000, {
> +			{ 0x0072, 0x0001},
> +			{ 0x0072, 0x0001},
> +			{ 0x0072, 0x0001}
> +		},
> +	}, {
> +		148500000, {
> +			{ 0x0051, 0x0002},
> +			{ 0x0051, 0x0002},
> +			{ 0x0051, 0x0002}
> +		},
> +	}, {
> +		~0UL, {
> +			{ 0x00B3, 0x0000 },
> +			{ 0x00B3, 0x0000 },
> +			{ 0x00B3, 0x0000 },
> +		},
> +	}
> +};
> +
> +static const struct dw_hdmi_curr_ctrl snps_hdmi_cur_ctr[] = {
> +	/* pixelclk    bpp8    bpp10   bpp12 */
> +	{ 27000000,  { 0x0000, 0x0000, 0x0000 }, },
> +	{ 74250000,  { 0x0008, 0x0008, 0x0008 }, },
> +	{ 148500000, { 0x001b, 0x001b, 0x001b }, },
> +	{ ~0UL,      { 0x0000, 0x0000, 0x0000 }, }
> +};
> +
> +
> +static const struct dw_hdmi_phy_config snps_hdmi_phy_config[] = {
> +	/* pixelclk   symbol  term    vlev */
> +	{ 27000000,   0x8009, 0x0004, 0x0232},
> +	{ 74250000,   0x8009, 0x0004, 0x0232},
> +	{ 148500000,  0x8009, 0x0004, 0x0232},
> +	{ ~0UL,       0x8009, 0x0004, 0x0232}
> +};
> +
> +static struct dw_hdmi_plat_data snps_dw_hdmi_drv_data = {
> +	.mpll_cfg   = snps_hdmi_mpll_cfg,
> +	.cur_ctr    = snps_hdmi_cur_ctr,
> +	.phy_config = snps_hdmi_phy_config,
> +};
> +
> +static const struct of_device_id snps_dw_hdmi_dt_ids[] = {
> +	{ .compatible = "snps,arc-dw-hdmi-hsdk", .data = &snps_dw_hdmi_drv_data },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, snps_dw_hdmi_dt_ids);
> +
> +static int snps_dw_hdmi_probe(struct platform_device *pdev)
> +{
> +	const struct dw_hdmi_plat_data *plat_data;
> +	const struct of_device_id *match;
> +	struct dw_hdmi *hdmi;
> +
> +	if (!pdev->dev.of_node)
> +		return -ENODEV;
> +
> +	match = of_match_node(snps_dw_hdmi_dt_ids, pdev->dev.of_node);
> +	plat_data = match->data;
> +
> +	hdmi = dw_hdmi_probe(pdev, plat_data);

So this is kinda not how bridge drivers are supposed to be done nowadays,
direct calling into the driver was the old way, and dw-hdmi still works
like that. Modern way is roughly
- bridge drivers bind automatically to any bridge they support
- bridge drivers publish a bridge with drm_bridge_add()
- the driver using the bridge fishes out with dt magic using
  of_drm_find_bridge() or another of the related of_ functions

I know a bit late, just spotted this because you brought your series here
up in my arc cleanup series, but can you pls look into adjusting
accordingly?

I shouldn't take more than moving this binding here into the dw-hdmi
driver, and switching arc itself over to the of_drm_find_bridge() call.
That way we could slowly work to transform old bridge drivers like dw-hdmi
to the new way, instead of adding more cases that will never get
converted.

Other upside is that arc stays a neat&tiny driver :-)

Thanks, Daniel

> +	if (IS_ERR(hdmi))
> +		return PTR_ERR(hdmi);
> +
> +	platform_set_drvdata(pdev, hdmi);
> +
> +	return 0;
> +}
> +
> +static int snps_dw_hdmi_remove(struct platform_device *pdev)
> +{
> +	struct dw_hdmi *hdmi = platform_get_drvdata(pdev);
> +
> +	dw_hdmi_remove(hdmi);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver snps_dw_hdmi_platform_driver = {
> +	.probe  = snps_dw_hdmi_probe,
> +	.remove = snps_dw_hdmi_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = snps_dw_hdmi_dt_ids,
> +	},
> +};
> +module_platform_driver(snps_dw_hdmi_platform_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ARC specific DW-HDMI driver extension");
> +MODULE_AUTHOR("Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>");
> -- 
> 2.21.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
