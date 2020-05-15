Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07826C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF76920759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgEONMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:12:49 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53528 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgEONM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:12:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0CC7DFB05;
        Fri, 15 May 2020 15:12:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id brG_Y9P4LUL8; Fri, 15 May 2020 15:12:20 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 86BB7445AB; Fri, 15 May 2020 15:12:15 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 4/6] drm/bridge/nwl-dsi: Drop mux handling
Date:   Fri, 15 May 2020 15:12:13 +0200
Message-Id: <951688795f969ebcbf9fb3c38065ccce6f488235.1589548223.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1589548223.git.agx@sigxcpu.org>
References: <cover.1589548223.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be handled via the mux-input-bridge.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/bridge/Kconfig   |  1 -
 drivers/gpu/drm/bridge/nwl-dsi.c | 61 --------------------------------
 2 files changed, 62 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 3886c0f41bdd..11444f841e35 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -78,7 +78,6 @@ config DRM_NWL_MIPI_DSI
 	select DRM_PANEL_BRIDGE
 	select GENERIC_PHY_MIPI_DPHY
 	select MFD_SYSCON
-	select MULTIPLEXER
 	select REGMAP_MMIO
 	help
 	  This enables the Northwest Logic MIPI DSI Host controller as
diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index b14d725bf609..8839f333f39c 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -12,7 +12,6 @@
 #include <linux/math64.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/mux/consumer.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
@@ -44,9 +43,6 @@ enum transfer_direction {
 	DSI_PACKET_RECEIVE,
 };
 
-#define NWL_DSI_ENDPOINT_LCDIF 0
-#define NWL_DSI_ENDPOINT_DCSS 1
-
 struct nwl_dsi_plat_clk_config {
 	const char *id;
 	struct clk *clk;
@@ -94,7 +90,6 @@ struct nwl_dsi {
 	struct reset_control *rst_esc;
 	struct reset_control *rst_dpi;
 	struct reset_control *rst_pclk;
-	struct mux_control *mux;
 
 	/* DSI clocks */
 	struct clk *phy_ref_clk;
@@ -1018,14 +1013,6 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
 	}
 	dsi->tx_esc_clk = clk;
 
-	dsi->mux = devm_mux_control_get(dsi->dev, NULL);
-	if (IS_ERR(dsi->mux)) {
-		ret = PTR_ERR(dsi->mux);
-		if (ret != -EPROBE_DEFER)
-			DRM_DEV_ERROR(dsi->dev, "Failed to get mux: %d\n", ret);
-		return ret;
-	}
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1073,47 +1060,6 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
 	return 0;
 }
 
-static int nwl_dsi_select_input(struct nwl_dsi *dsi)
-{
-	struct device_node *remote;
-	u32 use_dcss = 1;
-	int ret;
-
-	remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
-					  NWL_DSI_ENDPOINT_LCDIF);
-	if (remote) {
-		use_dcss = 0;
-	} else {
-		remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
-						  NWL_DSI_ENDPOINT_DCSS);
-		if (!remote) {
-			DRM_DEV_ERROR(dsi->dev,
-				      "No valid input endpoint found\n");
-			return -EINVAL;
-		}
-	}
-
-	DRM_DEV_INFO(dsi->dev, "Using %s as input source\n",
-		     (use_dcss) ? "DCSS" : "LCDIF");
-	ret = mux_control_try_select(dsi->mux, use_dcss);
-	if (ret < 0)
-		DRM_DEV_ERROR(dsi->dev, "Failed to select input: %d\n", ret);
-
-	of_node_put(remote);
-	return ret;
-}
-
-static int nwl_dsi_deselect_input(struct nwl_dsi *dsi)
-{
-	int ret;
-
-	ret = mux_control_deselect(dsi->mux);
-	if (ret < 0)
-		DRM_DEV_ERROR(dsi->dev, "Failed to deselect input: %d\n", ret);
-
-	return ret;
-}
-
 static const struct drm_bridge_timings nwl_dsi_timings = {
 	.input_bus_flags = DRM_BUS_FLAG_DE_LOW,
 };
@@ -1175,12 +1121,6 @@ static int nwl_dsi_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, dsi);
 	pm_runtime_enable(dev);
 
-	ret = nwl_dsi_select_input(dsi);
-	if (ret < 0) {
-		mipi_dsi_host_unregister(&dsi->dsi_host);
-		return ret;
-	}
-
 	drm_bridge_add(&dsi->bridge);
 	return 0;
 }
@@ -1189,7 +1129,6 @@ static int nwl_dsi_remove(struct platform_device *pdev)
 {
 	struct nwl_dsi *dsi = platform_get_drvdata(pdev);
 
-	nwl_dsi_deselect_input(dsi);
 	mipi_dsi_host_unregister(&dsi->dsi_host);
 	drm_bridge_remove(&dsi->bridge);
 	pm_runtime_disable(&pdev->dev);
-- 
2.26.1

