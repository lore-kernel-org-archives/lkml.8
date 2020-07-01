Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA0CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F24420780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgGALXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:23:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730169AbgGALXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:23:08 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3BBDA27DAFB;
        Wed,  1 Jul 2020 12:23:06 +0100 (BST)
Date:   Wed, 1 Jul 2020 13:23:03 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        laurent.pinchart@ideasonboard.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [RESEND PATCH 1/3] drm/mediatek: mtk_dpi: Rename bridge to
 next_bridge
Message-ID: <20200701132303.047ea605@collabora.com>
In-Reply-To: <20200518173909.2259259-2-enric.balletbo@collabora.com>
References: <20200518173909.2259259-1-enric.balletbo@collabora.com>
        <20200518173909.2259259-2-enric.balletbo@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 19:39:07 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> This is really a cosmetic change just to make a bit more readable the
> code after convert the driver to drm_bridge. The bridge variable name
> will be used by the encoder drm_bridge, and the chained bridge will be
> named next_bridge.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
> 
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 7fbfa95bab09..7112125dc3d1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -61,7 +61,7 @@ enum mtk_dpi_out_color_format {
>  struct mtk_dpi {
>  	struct mtk_ddp_comp ddp_comp;
>  	struct drm_encoder encoder;
> -	struct drm_bridge *bridge;
> +	struct drm_bridge *next_bridge;

Did you consider moving the drm_of_find_panel_or_bridge() call to
mtk_dpi_bind() so you can get rid of this field?

This makes we realize there's no refcounting on bridges, which means
the bridge can vanish between the drm_of_find_panel_or_bridge() and
drm_bridge_attach() calls :-/.

>  	void __iomem *regs;
>  	struct device *dev;
>  	struct clk *engine_clk;
> @@ -607,7 +607,7 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>  	/* Currently DPI0 is fixed to be driven by OVL1 */
>  	dpi->encoder.possible_crtcs = BIT(1);
>  
> -	ret = drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL, 0);
> +	ret = drm_bridge_attach(&dpi->encoder, dpi->next_bridge, NULL, 0);
>  	if (ret) {
>  		dev_err(dev, "Failed to attach bridge: %d\n", ret);
>  		goto err_cleanup;
> @@ -747,11 +747,11 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> -					  NULL, &dpi->bridge);
> +					  NULL, &dpi->next_bridge);
>  	if (ret)
>  		return ret;
>  
> -	dev_info(dev, "Found bridge node: %pOF\n", dpi->bridge->of_node);
> +	dev_info(dev, "Found bridge node: %pOF\n", dpi->next_bridge->of_node);
>  
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
>  	if (comp_id < 0) {

