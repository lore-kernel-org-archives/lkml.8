Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E4D252CF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iXxH8ybu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgFUW3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:29:48 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50434 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbgFUW3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 18:29:48 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 508DCA5E;
        Mon, 22 Jun 2020 00:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592778586;
        bh=h3DvNQrBW/7Awdz64VgXnEQbAUtTAIR4h5qUzpDJs0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXxH8ybuMEmE2+cEXdkRA09m8iBxbR5IKa1C3n8F6ZG+Q23WTIs2Dzio1nIGxhLEc
         kfgcdOPyszDgNDrY5h5JFHemAsMXrabaPeSo/6eMrIy31eYSxkZhSsf94AUCcQGLyx
         kpb/r0+0kBhq+qQCWeRbuyBygkBUK5+Wst/F3dpo=
Date:   Mon, 22 Jun 2020 01:29:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/panel-simple: Correct EDT ET057090DHU
 connector type
Message-ID: <20200621222922.GA25355@pendragon.ideasonboard.com>
References: <20200621222742.25695-1-digetx@gmail.com>
 <20200621222742.25695-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200621222742.25695-2-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch.

On Mon, Jun 22, 2020 at 01:27:41AM +0300, Dmitry Osipenko wrote:
> The EDT ET057090DHU panel has a DPI connector and not LVDS. This patch
> corrects the panel's description.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Fixes: 94f07917ebe8 ("drm/panel-simple: Add missing connector type for some panels")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/panel/panel-simple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index ea6973d5cf54..87edd2bdf09a 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1588,7 +1588,7 @@ static const struct panel_desc edt_et057090dhu = {
>  	},
>  	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
> -	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
>  };
>  
>  static const struct drm_display_mode edt_etm0700g0dh6_mode = {

-- 
Regards,

Laurent Pinchart
