Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B921C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDEC206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgEONMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:12:31 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53504 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgEONM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:12:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E9585FB04;
        Fri, 15 May 2020 15:12:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ud4qQG39xKE9; Fri, 15 May 2020 15:12:19 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6D3FB445A8; Fri, 15 May 2020 15:12:15 +0200 (CEST)
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
Subject: [RFC PATCH 2/6] drm/bridge: Add mux-input bridge
Date:   Fri, 15 May 2020 15:12:11 +0200
Message-Id: <1d4a97de9acea438f156092dfd1434eb160bf861.1589548223.git.agx@sigxcpu.org>
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

This bridge allows to select the input source
via a mux controller. The input source is
determined via DT but it could become rutime
selectable in the future.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/bridge/Kconfig     |   9 ++
 drivers/gpu/drm/bridge/Makefile    |   1 +
 drivers/gpu/drm/bridge/mux-input.c | 238 +++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/mux-input.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 04f876e985de..3886c0f41bdd 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -206,6 +206,15 @@ config DRM_TI_TPD12S015
 	  Texas Instruments TPD12S015 HDMI level shifter and ESD protection
 	  driver.
 
+config DRM_MUX_INPUT
+	tristate "Bridge to select a video input source"
+	depends on OF
+	depends on DRM_BRIDGE
+	select MULTIPLEXER
+	help
+	  Select this option if you want to select the input source to
+	  a DRM bridge or panel via a separate mux chip.
+
 source "drivers/gpu/drm/bridge/analogix/Kconfig"
 
 source "drivers/gpu/drm/bridge/adv7511/Kconfig"
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index d63d4b7e4347..9f3370ce7e07 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
 obj-$(CONFIG_DRM_DISPLAY_CONNECTOR) += display-connector.o
 obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
+obj-$(CONFIG_DRM_MUX_INPUT) += mux-input.o
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
 obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
 obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
diff --git a/drivers/gpu/drm/bridge/mux-input.c b/drivers/gpu/drm/bridge/mux-input.c
new file mode 100644
index 000000000000..24961d41ac30
--- /dev/null
+++ b/drivers/gpu/drm/bridge/mux-input.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Purism SPC
+ */
+
+#include <linux/module.h>
+#include <linux/mux/consumer.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
+#define DRV_NAME "mux-input-bridge"
+
+struct mux_input {
+	struct drm_bridge bridge;
+	struct drm_bridge *out;
+	struct device *dev;
+	struct mux_control *mux;
+	unsigned int n_inputs;
+	unsigned int input;
+	struct drm_bridge_timings timings;
+};
+
+static inline struct mux_input *bridge_to_mux_input(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct mux_input, bridge);
+}
+
+static void mux_input_bridge_disable(struct drm_bridge *bridge)
+{
+	struct mux_input *mux_input = bridge_to_mux_input(bridge);
+
+	pm_runtime_put(mux_input->dev);
+}
+
+static void mux_input_bridge_pre_enable(struct drm_bridge *bridge)
+{
+	struct mux_input *mux_input = bridge_to_mux_input(bridge);
+
+	pm_runtime_get(mux_input->dev);
+}
+
+static int mux_input_bridge_attach(struct drm_bridge *bridge,
+				   enum drm_bridge_attach_flags flags)
+{
+	struct mux_input *mux_input = bridge_to_mux_input(bridge);
+	struct drm_bridge *panel_bridge;
+	struct drm_panel *panel;
+	struct device *dev;
+	struct device_node *remote;
+	int ret;
+
+	/* Only attach to the selected input */
+	remote = of_graph_get_remote_node(mux_input->dev->of_node,
+					  mux_input->input,
+					  0);
+	if (!remote)
+		return -EINVAL;
+
+	if (bridge->dev) {
+		dev = bridge->dev->dev;
+		if (dev->of_node != remote) {
+			DRM_DEV_DEBUG(mux_input->dev,
+				      "Not attaching to endpoint %s",
+				      dev->of_node->name);
+			return -EINVAL;
+		}
+	}
+	of_node_put(remote);
+
+	ret = drm_of_find_panel_or_bridge(mux_input->dev->of_node,
+					  mux_input->n_inputs - 1, 0, &panel,
+					  &panel_bridge);
+	if (ret)
+		return ret;
+
+	if (panel) {
+		panel_bridge = drm_panel_bridge_add(panel);
+		if (IS_ERR(panel_bridge))
+			return PTR_ERR(panel_bridge);
+	}
+	mux_input->out = panel_bridge;
+
+	if (!mux_input->out)
+		return -EPROBE_DEFER;
+
+	/* Bubble downstream bridge timings upwards */
+	memcpy(&mux_input->timings, mux_input->out->timings,
+	       sizeof(mux_input->timings));
+	mux_input->bridge.timings = &mux_input->timings;
+	return drm_bridge_attach(bridge->encoder, mux_input->out, bridge,
+				 flags);
+}
+
+static void mux_input_bridge_detach(struct drm_bridge *bridge)
+{	struct mux_input *mux_input = bridge_to_mux_input(bridge);
+
+	drm_of_panel_bridge_remove(mux_input->dev->of_node,
+				   mux_input->n_inputs - 1, 0);
+}
+
+static const struct drm_bridge_funcs mux_input_bridge_funcs = {
+	.pre_enable = mux_input_bridge_pre_enable,
+	.disable    = mux_input_bridge_disable,
+	.attach	    = mux_input_bridge_attach,
+	.detach	    = mux_input_bridge_detach,
+};
+
+static int mux_input_select_input(struct mux_input *mux_input)
+{
+	int ret;
+
+	DRM_DEV_DEBUG(mux_input->dev, "Using input %d as pixel source\n",
+		      mux_input->input);
+	ret = mux_control_try_select(mux_input->mux, mux_input->input);
+	if (ret < 0) {
+		DRM_DEV_ERROR(mux_input->dev, "Failed to select input: %d\n",
+			      ret);
+	}
+
+	return ret;
+}
+
+static int mux_input_deselect_input(struct mux_input *mux_input)
+{
+	int ret;
+
+	ret = mux_control_deselect(mux_input->mux);
+	if (ret < 0) {
+		DRM_DEV_ERROR(mux_input->dev, "Failed to deselect input: %d\n",
+			      ret);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id mux_input_dt_ids[] = {
+	{ .compatible = "mux-input-bridge", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mux_input_dt_ids);
+
+static int mux_input_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *ep;
+	struct mux_input *mux_input;
+	int ret;
+
+	mux_input = devm_kzalloc(dev, sizeof(*mux_input), GFP_KERNEL);
+	if (!mux_input)
+		return -ENOMEM;
+
+	mux_input->dev = dev;
+
+	/*
+	 * The largest numbered port is the output port. It determines
+	 * total number of ports.
+	 */
+	for_each_endpoint_of_node(np, ep) {
+		struct of_endpoint endpoint;
+
+		of_graph_parse_endpoint(ep, &endpoint);
+		mux_input->n_inputs = max(mux_input->n_inputs,
+					  endpoint.port + 1);
+	}
+
+	if (mux_input->n_inputs < 2) {
+		DRM_DEV_ERROR(dev, "Not enough ports %d\n",
+			      mux_input->n_inputs);
+		return -EINVAL;
+	}
+
+	if (device_property_read_u32(dev, "default-input",
+				     &mux_input->input))
+		mux_input->input = 0;
+
+	if (mux_input->input > mux_input->n_inputs - 2) {
+		DRM_DEV_ERROR(dev, "Invalid default port %d\n",
+			      mux_input->input);
+		return -EINVAL;
+	}
+
+	mux_input->mux = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(mux_input->mux)) {
+		ret = PTR_ERR(mux_input->mux);
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(dev, "Failed to get mux: %d\n", ret);
+		return ret;
+	}
+
+	mux_input->bridge.driver_private = mux_input;
+	mux_input->bridge.funcs = &mux_input_bridge_funcs;
+	mux_input->bridge.of_node = dev->of_node;
+
+	dev_set_drvdata(dev, mux_input);
+	pm_runtime_enable(dev);
+
+	ret = mux_input_select_input(mux_input);
+	if (ret < 0) {
+		pm_runtime_disable(&pdev->dev);
+		return ret;
+	}
+
+	drm_bridge_add(&mux_input->bridge);
+	return 0;
+}
+
+static int mux_input_remove(struct platform_device *pdev)
+{
+	struct mux_input *mux_input = platform_get_drvdata(pdev);
+
+	mux_input_deselect_input(mux_input);
+	drm_bridge_remove(&mux_input->bridge);
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver mux_input_driver = {
+	.probe		= mux_input_probe,
+	.remove		= mux_input_remove,
+	.driver		= {
+		.of_match_table = mux_input_dt_ids,
+		.name	= DRV_NAME,
+	},
+};
+
+module_platform_driver(mux_input_driver);
+
+MODULE_AUTHOR("Purism SPC");
+MODULE_DESCRIPTION("Mux input bridge");
+MODULE_LICENSE("GPL");
-- 
2.26.1

