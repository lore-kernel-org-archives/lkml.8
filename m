Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D307FC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A0120708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgEAPX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgEAPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:23:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D91AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 08:23:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id BE6212A3116
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, Sam Ravnborg <sam@ravnborg.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 4/7] drm/mediatek: mtk_dsi: Convert to bridge driver
Date:   Fri,  1 May 2020 17:23:32 +0200
Message-Id: <20200501152335.1805790-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501152335.1805790-1-enric.balletbo@collabora.com>
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mtk_dsi to a bridge driver with built-in encoder support for
compatibility with existing component drivers.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v4:
- Remove double call to drm_encoder_init(). (Chun-Kuang Hu)
- Cleanup the encoder in mtk_dsi_unbind(). (Chun-Kuang Hu)

Changes in v3:
- Add the bridge.type. (Laurent Pinchart)

Changes in v2: None

 drivers/gpu/drm/mediatek/mtk_dsi.c | 108 +++++++++++++++++++----------
 1 file changed, 70 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 37b8d7ffd835..38cbdcb15fff 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -180,6 +180,7 @@ struct mtk_dsi {
 	struct device *dev;
 	struct mipi_dsi_host host;
 	struct drm_encoder encoder;
+	struct drm_bridge bridge;
 	struct drm_connector conn;
 	struct drm_panel *panel;
 	struct drm_bridge *next_bridge;
@@ -205,9 +206,9 @@ struct mtk_dsi {
 	const struct mtk_dsi_driver_data *driver_data;
 };
 
-static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
+static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
 {
-	return container_of(e, struct mtk_dsi, encoder);
+	return container_of(b, struct mtk_dsi, bridge);
 }
 
 static inline struct mtk_dsi *connector_to_dsi(struct drm_connector *c)
@@ -796,32 +797,43 @@ static const struct drm_encoder_funcs mtk_dsi_encoder_funcs = {
 	.destroy = mtk_dsi_encoder_destroy,
 };
 
-static bool mtk_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
-				       const struct drm_display_mode *mode,
-				       struct drm_display_mode *adjusted_mode)
+static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi);
+static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi);
+
+static int mtk_dsi_bridge_attach(struct drm_bridge *bridge,
+				 enum drm_bridge_attach_flags flags)
 {
-	return true;
+	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+
+	return mtk_dsi_create_conn_enc(bridge->dev, dsi);
+}
+
+static void mtk_dsi_bridge_detach(struct drm_bridge *bridge)
+{
+	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+
+	mtk_dsi_destroy_conn_enc(dsi);
 }
 
-static void mtk_dsi_encoder_mode_set(struct drm_encoder *encoder,
-				     struct drm_display_mode *mode,
-				     struct drm_display_mode *adjusted)
+static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
+				    const struct drm_display_mode *mode,
+				    const struct drm_display_mode *adjusted)
 {
-	struct mtk_dsi *dsi = encoder_to_dsi(encoder);
+	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
 
 	drm_display_mode_to_videomode(adjusted, &dsi->vm);
 }
 
-static void mtk_dsi_encoder_disable(struct drm_encoder *encoder)
+static void mtk_dsi_bridge_disable(struct drm_bridge *bridge)
 {
-	struct mtk_dsi *dsi = encoder_to_dsi(encoder);
+	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
 
 	mtk_output_dsi_disable(dsi);
 }
 
-static void mtk_dsi_encoder_enable(struct drm_encoder *encoder)
+static void mtk_dsi_bridge_enable(struct drm_bridge *bridge)
 {
-	struct mtk_dsi *dsi = encoder_to_dsi(encoder);
+	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
 
 	mtk_output_dsi_enable(dsi);
 }
@@ -833,11 +845,12 @@ static int mtk_dsi_connector_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(dsi->panel, connector);
 }
 
-static const struct drm_encoder_helper_funcs mtk_dsi_encoder_helper_funcs = {
-	.mode_fixup = mtk_dsi_encoder_mode_fixup,
-	.mode_set = mtk_dsi_encoder_mode_set,
-	.disable = mtk_dsi_encoder_disable,
-	.enable = mtk_dsi_encoder_enable,
+static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
+	.attach = mtk_dsi_bridge_attach,
+	.detach = mtk_dsi_bridge_detach,
+	.disable = mtk_dsi_bridge_disable,
+	.enable = mtk_dsi_bridge_enable,
+	.mode_set = mtk_dsi_bridge_mode_set,
 };
 
 static const struct drm_connector_funcs mtk_dsi_connector_funcs = {
@@ -888,20 +901,6 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
 {
 	int ret;
 
-	ret = drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_funcs,
-			       DRM_MODE_ENCODER_DSI, NULL);
-	if (ret) {
-		DRM_ERROR("Failed to encoder init to drm\n");
-		return ret;
-	}
-	drm_encoder_helper_add(&dsi->encoder, &mtk_dsi_encoder_helper_funcs);
-
-	/*
-	 * Currently display data paths are statically assigned to a crtc each.
-	 * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
-	 */
-	dsi->encoder.possible_crtcs = 1;
-
 	/* If there's a next bridge, attach to it and let it create the connector */
 	if (dsi->next_bridge) {
 		ret = drm_bridge_attach(&dsi->encoder, dsi->next_bridge, NULL,
@@ -1123,6 +1122,34 @@ static const struct mipi_dsi_host_ops mtk_dsi_ops = {
 	.transfer = mtk_dsi_host_transfer,
 };
 
+static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
+{
+	int ret;
+
+	ret = drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
+	if (ret) {
+		DRM_ERROR("Failed to encoder init to drm\n");
+		return ret;
+	}
+
+	/*
+	 * Currently display data paths are statically assigned to a crtc each.
+	 * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
+	 */
+	dsi->encoder.possible_crtcs = 1;
+
+	ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
+	if (ret)
+		goto err_cleanup_encoder;
+
+	return 0;
+
+err_cleanup_encoder:
+	drm_encoder_cleanup(&dsi->encoder);
+	return ret;
+}
+
 static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 {
 	int ret;
@@ -1136,11 +1163,9 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
-	ret = mtk_dsi_create_conn_enc(drm, dsi);
-	if (ret) {
-		DRM_ERROR("Encoder create failed with %d\n", ret);
+	ret = mtk_dsi_encoder_init(drm, dsi);
+	if (ret)
 		goto err_unregister;
-	}
 
 	return 0;
 
@@ -1155,7 +1180,7 @@ static void mtk_dsi_unbind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct mtk_dsi *dsi = dev_get_drvdata(dev);
 
-	mtk_dsi_destroy_conn_enc(dsi);
+	drm_encoder_cleanup(&dsi->encoder);
 	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
 }
 
@@ -1265,6 +1290,12 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dsi);
 
+	dsi->bridge.funcs = &mtk_dsi_bridge_funcs;
+	dsi->bridge.of_node = dev->of_node;
+	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
+
+	drm_bridge_add(&dsi->bridge);
+
 	ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add component: %d\n", ret);
@@ -1283,6 +1314,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
 	struct mtk_dsi *dsi = platform_get_drvdata(pdev);
 
 	mtk_output_dsi_disable(dsi);
+	drm_bridge_remove(&dsi->bridge);
 	component_del(&pdev->dev, &mtk_dsi_component_ops);
 	mipi_dsi_host_unregister(&dsi->host);
 
-- 
2.26.2

