Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D1C38A2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8246A221F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="drqtgiwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgDPVqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728526AbgDPVqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76950C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:46:49 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0497D97D;
        Thu, 16 Apr 2020 23:46:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587073608;
        bh=YnVX9kx1ktI0ybMo9FTw1KK97VU/pddRDv0WisuHbvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drqtgiwQlWQFoWRUuZt+zKKzjGNHOElDVl0ns/IZA/URl7QWIVTHFYpAiJAZGST0s
         WF4KrDJ6OfG32ypZvZg5fVBRRIKZJ46v8McykKgVoo8cqDGl/IHfKpsmZhEnsMfq9j
         j1yz+EbAYKDSQ0koqWrHOOCiKnLTzCSNNg+ARRqI=
Date:   Fri, 17 Apr 2020 00:46:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>, sam@ravnborg.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: panel: Return always an error pointer in
 drm_panel_bridge_add()
Message-ID: <20200416214635.GD28162@pendragon.ideasonboard.com>
References: <20200416210654.2468805-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416210654.2468805-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Thu, Apr 16, 2020 at 11:06:54PM +0200, Enric Balletbo i Serra wrote:
> Since commit 89958b7cd955 ("drm/bridge: panel: Infer connector type from
> panel by default"), drm_panel_bridge_add() and their variants can return
> NULL and an error pointer. This is fine but none of the actual users of
> the API are checking for the NULL value. Instead of change all the
> users, seems reasonable to return an error pointer instead. So change
> the returned value for those functions when the connector type is unknown.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpu/drm/bridge/panel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 8461ee8304ba..7a3df0f319f3 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -166,7 +166,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
>   *
>   * The connector type is set to @panel->connector_type, which must be set to a
>   * known type. Calling this function with a panel whose connector type is
> - * DRM_MODE_CONNECTOR_Unknown will return NULL.
> + * DRM_MODE_CONNECTOR_Unknown will return ERR_PTR(-EINVAL).
>   *
>   * See devm_drm_panel_bridge_add() for an automatically managed version of this
>   * function.
> @@ -174,7 +174,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)
>  {
>  	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  
>  	return drm_panel_bridge_add_typed(panel, panel->connector_type);
>  }
> @@ -265,7 +265,7 @@ struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
>  					     struct drm_panel *panel)
>  {
>  	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  
>  	return devm_drm_panel_bridge_add_typed(dev, panel,
>  					       panel->connector_type);

-- 
Regards,

Laurent Pinchart
