Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5A9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC92206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="N1pfTM8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgGVLSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGVLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:18:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9EFC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:18:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E06B4329;
        Wed, 22 Jul 2020 13:18:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595416720;
        bh=3PppavpFe+RnKBwtRzRAtSsiWv4CSz6FActc7janNoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1pfTM8tHNetD+VOvb9GNg1KPDYrfYiK/wXi+pQMrSzu6Uc0eBPR82qtoEaTi5Ugd
         Ja8QpvhELuD9ctAd5afO173JOJGguGYVckOR+g49w/t3Bv0Im7mjSmzGGWHK3LhSDE
         olz25EyYMPPwKcV5IRq19U8Kn9nw/+jNpsKe8p90=
Date:   Wed, 22 Jul 2020 14:18:34 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 1/1] drm/bridge: nwl-dsi: Drop
 DRM_BRIDGE_ATTACH_NO_CONNECTOR check.
Message-ID: <20200722111834.GB5833@pendragon.ideasonboard.com>
References: <cover.1595096667.git.agx@sigxcpu.org>
 <8b6545b991afce6add0a24f5f5d116778b0cb763.1595096667.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b6545b991afce6add0a24f5f5d116778b0cb763.1595096667.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Thank you for the patch.

On Sat, Jul 18, 2020 at 08:26:37PM +0200, Guido Günther wrote:
> We don't create a connector but let panel_bridge handle that so there's
> no point in rejecting DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 77a79af70914..ce94f797d090 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -918,11 +918,6 @@ static int nwl_dsi_bridge_attach(struct drm_bridge *bridge,
>  	struct drm_panel *panel;
>  	int ret;
>  
> -	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> -		DRM_ERROR("Fix bridge driver to make connector optional!");
> -		return -EINVAL;
> -	}
> -
>  	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
>  					  &panel_bridge);
>  	if (ret)

-- 
Regards,

Laurent Pinchart
