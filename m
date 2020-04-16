Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8038C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E012076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JFrpxmOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgDPRYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:24:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50072 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgDPRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:24:50 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1F8B97D;
        Thu, 16 Apr 2020 19:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587057888;
        bh=n96mzpZtECYxDWfSDMueCKOeosR0PhwZDxdep4i2jmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFrpxmOXiWHzXnwDoyiRONCycIkNUzJYgNmk635T7FlC9y2jc/AlXdflLh+I/WI+s
         rFk4kGJdsGPl0HQEAP8Id2du0KeHQn3uIN6nEo6+fX0ijONqcCJOgGXH/zoBXkwaHN
         Y0NErElmPG3LoFsHaCFdRq+/Buhl9BCJ71y7rcoM=
Date:   Thu, 16 Apr 2020 20:24:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/7] drm/mediatek: mtk_dsi: Rename bridge to
 next_bridge
Message-ID: <20200416172435.GM4796@pendragon.ideasonboard.com>
References: <20200416155720.2360443-1-enric.balletbo@collabora.com>
 <20200416155720.2360443-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416155720.2360443-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Thu, Apr 16, 2020 at 05:57:15PM +0200, Enric Balletbo i Serra wrote:
> This is really a cosmetic change just to make a bit more readable the
> code after convert the driver to drm_bridge. The bridge variable name
> will be used by the encoder drm_bridge, and the chained bridge will be
> named next_bridge.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index cfa45d6abd74..44ee884cc31c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -182,7 +182,7 @@ struct mtk_dsi {
>  	struct drm_encoder encoder;
>  	struct drm_connector conn;
>  	struct drm_panel *panel;
> -	struct drm_bridge *bridge;
> +	struct drm_bridge *next_bridge;
>  	struct phy *phy;
>  
>  	void __iomem *regs;
> @@ -903,8 +903,9 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
>  	dsi->encoder.possible_crtcs = 1;
>  
>  	/* If there's a bridge, attach to it and let it create the connector */

Maybe s/bridge/next bridge/ here ? I expect this comment to go away
though, as there will always be a next bridge when the driver switches
to the DRM panel bridge helper.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> -	if (dsi->bridge) {
> -		ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL, 0);
> +	if (dsi->next_bridge) {
> +		ret = drm_bridge_attach(&dsi->encoder, dsi->next_bridge, NULL,
> +					0);
>  		if (ret) {
>  			DRM_ERROR("Failed to attach bridge to drm\n");
>  			goto err_encoder_cleanup;
> @@ -1185,7 +1186,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> -					  &dsi->panel, &dsi->bridge);
> +					  &dsi->panel, &dsi->next_bridge);
>  	if (ret)
>  		goto err_unregister_host;
>  

-- 
Regards,

Laurent Pinchart
