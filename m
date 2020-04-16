Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BA9C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9D820732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="i+E3b4Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgDPRDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732667AbgDPRDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:03:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C309C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:03:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7957F97D;
        Thu, 16 Apr 2020 19:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587056617;
        bh=ub1B1IcZSLEWleDHY8gnWOomy9qkKYullnvOHINq9K0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+E3b4Vf4b0hPQlkTJENwVcfiNm6KUV0Xlc8TZr/3iNoySXvfGXaa7MyIe0XG6Ufv
         0dSoj9phmYSsdxKMEGJpPSNBw9sdUSoMZ4zWVkY4dCUvOwB3I9zFV8wupZSnljch+B
         2U2WXN1I7ge3yOWErGvygFj3xHpS86/cODsZdyFo=
Date:   Thu, 16 Apr 2020 20:03:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        sam@ravnborg.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm: panel: Set connector type for LP120UP1
Message-ID: <20200416170325.GG4796@pendragon.ideasonboard.com>
References: <20200416164404.2418426-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416164404.2418426-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Thu, Apr 16, 2020 at 06:44:03PM +0200, Enric Balletbo i Serra wrote:
> The LP120UP1 is a eDP panel, set the connector type accordingly.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpu/drm/panel/panel-simple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 3ad828eaefe1..6253635601bb 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2168,6 +2168,7 @@ static const struct panel_desc lg_lp120up1 = {
>  		.width = 267,
>  		.height = 183,
>  	},
> +	.connector_type = DRM_MODE_CONNECTOR_eDP,
>  };
>  
>  static const struct drm_display_mode lg_lp129qe_mode = {

-- 
Regards,

Laurent Pinchart
