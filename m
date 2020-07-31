Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575ABC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41080208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgGaIq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:46:29 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58706 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbgGaIq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:46:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B3116FB03;
        Fri, 31 Jul 2020 10:46:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vohb_geD2LhT; Fri, 31 Jul 2020 10:46:25 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4408F4537D; Fri, 31 Jul 2020 10:46:25 +0200 (CEST)
Date:   Fri, 31 Jul 2020 10:46:25 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, l.stach@pengutronix.de,
        lukas@mntmn.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v9 1/5] drm/imx: compile imx directory by default
Message-ID: <20200731084625.GA12560@bogon.m.sigxcpu.org>
References: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
 <20200731081836.3048-2-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731081836.3048-2-laurentiu.palcu@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Jul 31, 2020 at 11:18:29AM +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> Currently the drm/imx/ directory is compiled only if DRM_IMX is set. Adding a
> new IMX related IP in the same directory would need DRM_IMX to be set, which would
> bring in also IPUv3 core driver...
> 
> The current patch would allow adding new IPs in the imx/ directory without needing
> to set DRM_IMX.

Reviewed-by: Guido Günther <agx@sigxcpu.org> 

> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/gpu/drm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 2f31579f91d4..81569009f884 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -100,7 +100,7 @@ obj-$(CONFIG_DRM_MSM) += msm/
>  obj-$(CONFIG_DRM_TEGRA) += tegra/
>  obj-$(CONFIG_DRM_STM) += stm/
>  obj-$(CONFIG_DRM_STI) += sti/
> -obj-$(CONFIG_DRM_IMX) += imx/
> +obj-y 			+= imx/
>  obj-$(CONFIG_DRM_INGENIC) += ingenic/
>  obj-$(CONFIG_DRM_MEDIATEK) += mediatek/
>  obj-$(CONFIG_DRM_MESON)	+= meson/
> -- 
> 2.23.0
> 
