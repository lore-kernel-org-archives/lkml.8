Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA836C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C884720704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDYOts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:49:48 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43694 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDYOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:49:47 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8BB5620070;
        Sat, 25 Apr 2020 16:49:44 +0200 (CEST)
Date:   Sat, 25 Apr 2020 16:49:43 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH] drm/bridge: panel: Return always an error pointer in
 drm_panel_bridge_add()
Message-ID: <20200425144943.GE32235@ravnborg.org>
References: <20200416210654.2468805-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416210654.2468805-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=P1BnusSwAAAA:8 a=QX4gbG5DAAAA:8 a=e5mUnYsNAAAA:8
        a=-fIW-uut3qeXBzhQ7CAA:9 a=CjuIK1q_8ugA:10 a=D0XLA9XvdZm18NrgonBM:22
        a=AbAUZ8qAyYyZVLSsDulk:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Thanks, added to drm-misc-next.

	Sam

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
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
