Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFF0C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5F32076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UhIfmKrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbgDPRW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388338AbgDPRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:22:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B72C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:22:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3145897D;
        Thu, 16 Apr 2020 19:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587057775;
        bh=bTfJZ+75ndQOARxqXeuOxJFXyYt8RzIOrx7gvZeGM5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhIfmKrRUNzc0klYEFAND1I5BO8RI0zq5GjDoZW2tHzP9cxwLQYneLPVCYJ6bl+02
         XVgqihJFaXzbRtD0iNQStH+CzDk+kbln0wVmmiI0D6U496AnHN2pJmiKOEEsagB50g
         PBTy+E/IcEX3vmXwbUlbFLnp1q9O0VQPqx3NMc+I=
Date:   Thu, 16 Apr 2020 20:22:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/7] drm/bridge_connector: Set default status
 connected for eDP connectors
Message-ID: <20200416172243.GL4796@pendragon.ideasonboard.com>
References: <20200416155720.2360443-1-enric.balletbo@collabora.com>
 <20200416155720.2360443-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416155720.2360443-3-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Thu, Apr 16, 2020 at 05:57:14PM +0200, Enric Balletbo i Serra wrote:
> In an eDP application, HPD is not required and on most bridge chips
> useless. If HPD is not used, we need to set initial status as connected,
> otherwise the connector created by the drm_bridge_connector API remains
> in an unknown state.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/drm_bridge_connector.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> index c6994fe673f3..a58cbde59c34 100644
> --- a/drivers/gpu/drm/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/drm_bridge_connector.c
> @@ -187,6 +187,7 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
>  		case DRM_MODE_CONNECTOR_DPI:
>  		case DRM_MODE_CONNECTOR_LVDS:
>  		case DRM_MODE_CONNECTOR_DSI:
> +		case DRM_MODE_CONNECTOR_eDP:
>  			status = connector_status_connected;
>  			break;
>  		default:

-- 
Regards,

Laurent Pinchart
