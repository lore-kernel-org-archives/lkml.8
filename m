Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E9BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1016C2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nZjDY51I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIGH12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgIGH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:27:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD7C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:27:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so521499wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hay2yEcI22ZSFrOTAPZIAGYpeLN1kbCsa/3kPh9ppwI=;
        b=nZjDY51I1YSbK6z4AfhIIBGMCmb5h7LCEobGhvx3rwTwM84yjwcLmNSKzTfZNChkjr
         cxoY6WwkKoc4s4DYbCf74tuPoY6YHeJ0LyZX3c3U/3R/j2OYvagvSirnkClKXAHBkRi/
         vwQYYBba6Er1i0F71RX8ZfZU+DzeQDHZBBR2YInSYA4kNU2TO8VXPfYl4zBdMgrhnTEb
         CTrtS72IzE12CVk0Yz+/YyzQSD9A4d6MgXtJJM8dM8naEQAd3Xa7Fusqh/R/TKVkPdsl
         r7k0rp3CvnwXQ6xokN/AbfhRYLMF4WZL/7KxS5/tQCW2MP++csR8NY6zr4peRrvPPcuK
         xIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hay2yEcI22ZSFrOTAPZIAGYpeLN1kbCsa/3kPh9ppwI=;
        b=CIC8ESnJimgc1OsgnxnFA6kRM0sdDVen8idIyrazjQ1uUoOPxwpMAMn62Hu0YFtC6Q
         CZx/ftoCKgOf/gcdeXBdzlmavAVQ53D56/ZoIOn71/a37FdSSVRgLFVMqa0FErFSZilB
         3v0fYAXCQqaxn8+gLWjYVZlv1/+xaZXIxsd0gFdxPVpoUZT5DV9pj+11byzDGvWPzA8v
         H7BajfUVSBH1u/bAWAi36Ail7LcHLzv9yOPLb8GPB1Vcb2T872hTNg5NJKxRo64/lOh+
         b8oAk32RrWA5v4wTJHwGKvhp94BZKmCB0BVX0uiU82uvr48hl/z/z6sv0jDF1U7J+gr8
         AIEg==
X-Gm-Message-State: AOAM531ekJ2TobI78CXZaqkELJYU5/9tt0SVjctvNnKbqNj+vTL3Ssoj
        RHWLmNKPQCLP1MyzsZbXOOZsr2KsNs0QZ7s/
X-Google-Smtp-Source: ABdhPJz2+hEZQ2C1erApIXzv2mlD/8YTxQGOwrVPYcc9ncn7c5zRdr++PZrxIxyxVeBfPmik7XdajA==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr6402173wme.140.1599463639096;
        Mon, 07 Sep 2020 00:27:19 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id x16sm25560500wrq.62.2020.09.07.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:27:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] phy: amlogic: Add AXG MIPI D-PHY driver
Date:   Mon,  7 Sep 2020 09:27:08 +0200
Message-Id: <20200907072708.26043-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907072708.26043-1-narmstrong@baylibre.com>
References: <20200907072708.26043-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG SoCs embeds a MIPI D-PHY used to communicate with DSI
panels.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/Kconfig                   |  12 +
 drivers/phy/amlogic/Makefile                  |   1 +
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c | 413 ++++++++++++++++++
 3 files changed, 426 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 617cf073e9aa..99e8a4c7f1f3 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -70,3 +70,15 @@ config PHY_MESON_AXG_MIPI_PCIE_ANALOG
 	  Enable this to support the Meson MIPI + PCIE analog PHY
 	  found in Meson AXG SoCs.
 	  If unsure, say N.
+
+config PHY_MESON_AXG_MIPI_DPHY
+	tristate "Meson AXG MIPI DPHY driver"
+	default ARCH_MESON
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	select GENERIC_PHY_MIPI_DPHY
+	help
+	  Enable this to support the Meson MIPI DPHY found in Meson AXG
+	  SoCs.
+	  If unsure, say N.
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 99702a45e9be..8fa07fbd0d92 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
 obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
 obj-$(CONFIG_PHY_MESON_AXG_PCIE)		+= phy-meson-axg-pcie.o
 obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
+obj-$(CONFIG_PHY_MESON_AXG_MIPI_DPHY)		+= phy-meson-axg-mipi-dphy.o
diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
new file mode 100644
index 000000000000..cd2332bf0e31
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Meson AXG MIPI DPHY driver
+ *
+ * Copyright (C) 2018 Amlogic, Inc. All rights reserved
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+/* [31] soft reset for the phy.
+ *		1: reset. 0: dessert the reset.
+ * [30] clock lane soft reset.
+ * [29] data byte lane 3 soft reset.
+ * [28] data byte lane 2 soft reset.
+ * [27] data byte lane 1 soft reset.
+ * [26] data byte lane 0 soft reset.
+ * [25] mipi dsi pll clock selection.
+ *		1:  clock from fixed 850Mhz clock source. 0: from VID2 PLL.
+ * [12] mipi HSbyteclk enable.
+ * [11] mipi divider clk selection.
+ *		1: select the mipi DDRCLKHS from clock divider.
+ *		0: from PLL clock.
+ * [10] mipi clock divider control.
+ *		1: /4. 0: /2.
+ * [9]  mipi divider output enable.
+ * [8]  mipi divider counter enable.
+ * [7]  PLL clock enable.
+ * [5]  LPDT data endian.
+ *		1 = transfer the high bit first. 0 : transfer the low bit first.
+ * [4]  HS data endian.
+ * [3]  force data byte lane in stop mode.
+ * [2]  force data byte lane 0 in receiver mode.
+ * [1]  write 1 to sync the txclkesc input. the internal logic have to
+ *	use txclkesc to decide Txvalid and Txready.
+ * [0]  enalbe the MIPI DPHY TxDDRClk.
+ */
+#define MIPI_DSI_PHY_CTRL				0x0
+
+/* [31] clk lane tx_hs_en control selection.
+ *		1: from register. 0: use clk lane state machine.
+ * [30] register bit for clock lane tx_hs_en.
+ * [29] clk lane tx_lp_en contrl selection.
+ *		1: from register. 0: from clk lane state machine.
+ * [28] register bit for clock lane tx_lp_en.
+ * [27] chan0 tx_hs_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [26] register bit for chan0 tx_hs_en.
+ * [25] chan0 tx_lp_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [24] register bit from chan0 tx_lp_en.
+ * [23] chan0 rx_lp_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [22] register bit from chan0 rx_lp_en.
+ * [21] chan0 contention detection enable control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [20] register bit from chan0 contention dectection enable.
+ * [19] chan1 tx_hs_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [18] register bit for chan1 tx_hs_en.
+ * [17] chan1 tx_lp_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [16] register bit from chan1 tx_lp_en.
+ * [15] chan2 tx_hs_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [14] register bit for chan2 tx_hs_en.
+ * [13] chan2 tx_lp_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [12] register bit from chan2 tx_lp_en.
+ * [11] chan3 tx_hs_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [10] register bit for chan3 tx_hs_en.
+ * [9]  chan3 tx_lp_en control selection.
+ *		1: from register. 0: from chan0 state machine.
+ * [8]  register bit from chan3 tx_lp_en.
+ * [4]  clk chan power down. this bit is also used as the power down
+ *	of the whole MIPI_DSI_PHY.
+ * [3]  chan3 power down.
+ * [2]  chan2 power down.
+ * [1]  chan1 power down.
+ * [0]  chan0 power down.
+ */
+#define MIPI_DSI_CHAN_CTRL				0x4
+
+/* [24]   rx turn watch dog triggered.
+ * [23]   rx esc watchdog  triggered.
+ * [22]   mbias ready.
+ * [21]   txclkesc  synced and ready.
+ * [20:17] clk lane state. {mbias_ready, tx_stop, tx_ulps, tx_hs_active}
+ * [16:13] chan3 state{0, tx_stop, tx_ulps, tx_hs_active}
+ * [12:9]  chan2 state.{0, tx_stop, tx_ulps, tx_hs_active}
+ * [8:5]   chan1 state. {0, tx_stop, tx_ulps, tx_hs_active}
+ * [4:0]   chan0 state. {TX_STOP, tx_ULPS, hs_active, direction, rxulpsesc}
+ */
+#define MIPI_DSI_CHAN_STS				0x8
+
+/* [31:24] TCLK_PREPARE.
+ * [23:16] TCLK_ZERO.
+ * [15:8]  TCLK_POST.
+ * [7:0]   TCLK_TRAIL.
+ */
+#define MIPI_DSI_CLK_TIM				0xc
+
+/* [31:24] THS_PREPARE.
+ * [23:16] THS_ZERO.
+ * [15:8]  THS_TRAIL.
+ * [7:0]   THS_EXIT.
+ */
+#define MIPI_DSI_HS_TIM					0x10
+
+/* [31:24] tTA_GET.
+ * [23:16] tTA_GO.
+ * [15:8]  tTA_SURE.
+ * [7:0]   tLPX.
+ */
+#define MIPI_DSI_LP_TIM					0x14
+
+/* wait time to  MIPI DIS analog ready. */
+#define MIPI_DSI_ANA_UP_TIM				0x18
+
+/* TINIT. */
+#define MIPI_DSI_INIT_TIM				0x1c
+
+/* TWAKEUP. */
+#define MIPI_DSI_WAKEUP_TIM				0x20
+
+/* when in RxULPS check state, after the the logic enable the analog,
+ *	how long we should wait to check the lP state .
+ */
+#define MIPI_DSI_LPOK_TIM				0x24
+
+/* Watchdog for RX low power state no finished. */
+#define MIPI_DSI_LP_WCHDOG				0x28
+
+/* tMBIAS,  after send power up signals to analog,
+ *	how long we should wait for analog powered up.
+ */
+#define MIPI_DSI_ANA_CTRL				0x2c
+
+/* [31:8]  reserved for future.
+ * [7:0]   tCLK_PRE.
+ */
+#define MIPI_DSI_CLK_TIM1				0x30
+
+/* watchdog for turn around waiting time. */
+#define MIPI_DSI_TURN_WCHDOG				0x34
+
+/* When in RxULPS state, how frequency we should to check
+ *	if the TX side out of ULPS state.
+ */
+#define MIPI_DSI_ULPS_CHECK				0x38
+#define MIPI_DSI_TEST_CTRL0				0x3c
+#define MIPI_DSI_TEST_CTRL1				0x40
+
+struct phy_meson_axg_mipi_dphy_priv {
+	struct device				*dev;
+	struct regmap				*regmap;
+	struct clk				*clk;
+	struct reset_control			*reset;
+	struct phy				*analog;
+	struct phy_configure_opts_mipi_dphy	config;
+};
+
+static const struct regmap_config phy_meson_axg_mipi_dphy_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = MIPI_DSI_TEST_CTRL1,
+};
+
+static int phy_meson_axg_mipi_dphy_init(struct phy *phy)
+{
+	struct phy_meson_axg_mipi_dphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = phy_init(priv->analog);
+	if (ret)
+		return ret;
+
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int phy_meson_axg_mipi_dphy_configure(struct phy *phy,
+					      union phy_configure_opts *opts)
+{
+	struct phy_meson_axg_mipi_dphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = phy_mipi_dphy_config_validate(&opts->mipi_dphy);
+	if (ret)
+		return ret;
+
+	ret = phy_configure(priv->analog, opts);
+	if (ret)
+		return ret;
+
+	memcpy(&priv->config, opts, sizeof(priv->config));
+
+	return 0;
+}
+
+static int phy_meson_axg_mipi_dphy_power_on(struct phy *phy)
+{
+	struct phy_meson_axg_mipi_dphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+	unsigned long temp;
+
+	ret = phy_power_on(priv->analog);
+	if (ret)
+		return ret;
+
+	/* enable phy clock */
+	regmap_write(priv->regmap, MIPI_DSI_PHY_CTRL,  0x1);
+	regmap_write(priv->regmap, MIPI_DSI_PHY_CTRL,
+		     BIT(0) | /* enable the DSI PLL clock . */
+		     BIT(7) | /* enable pll clock which connected to DDR clock path */
+		     BIT(8)); /* enable the clock divider counter */
+
+	/* enable the divider clock out */
+	regmap_update_bits(priv->regmap, MIPI_DSI_PHY_CTRL, BIT(9), BIT(9));
+
+	/* enable the byte clock generation. */
+	regmap_update_bits(priv->regmap, MIPI_DSI_PHY_CTRL, BIT(12), BIT(12));
+	regmap_update_bits(priv->regmap, MIPI_DSI_PHY_CTRL, BIT(31), BIT(31));
+	regmap_update_bits(priv->regmap, MIPI_DSI_PHY_CTRL, BIT(31), 0);
+
+	/* Calculate lanebyteclk period in ps */
+	temp = (1000000 * 100) / (priv->config.hs_clk_rate / 1000);
+	temp = temp * 8 * 10;
+
+	regmap_write(priv->regmap, MIPI_DSI_CLK_TIM,
+		     DIV_ROUND_UP(priv->config.clk_trail, temp) |
+		     (DIV_ROUND_UP(priv->config.clk_post +
+				   priv->config.hs_trail, temp) << 8) |
+		     (DIV_ROUND_UP(priv->config.clk_zero, temp) << 16) |
+		     (DIV_ROUND_UP(priv->config.clk_prepare, temp) << 24));
+	regmap_write(priv->regmap, MIPI_DSI_CLK_TIM1,
+		     DIV_ROUND_UP(priv->config.clk_pre, temp));
+
+	regmap_write(priv->regmap, MIPI_DSI_HS_TIM,
+		     DIV_ROUND_UP(priv->config.hs_exit, temp) |
+		     (DIV_ROUND_UP(priv->config.hs_trail, temp) << 8) |
+		     (DIV_ROUND_UP(priv->config.hs_zero, temp) << 16) |
+		     (DIV_ROUND_UP(priv->config.hs_prepare, temp) << 24));
+
+	regmap_write(priv->regmap, MIPI_DSI_LP_TIM,
+		     DIV_ROUND_UP(priv->config.lpx, temp) |
+		     (DIV_ROUND_UP(priv->config.ta_sure, temp) << 8) |
+		     (DIV_ROUND_UP(priv->config.ta_go, temp) << 16) |
+		     (DIV_ROUND_UP(priv->config.ta_get, temp) << 24));
+
+	regmap_write(priv->regmap, MIPI_DSI_ANA_UP_TIM, 0x0100);
+	regmap_write(priv->regmap, MIPI_DSI_INIT_TIM,
+		     DIV_ROUND_UP(priv->config.init * NSEC_PER_MSEC, temp));
+	regmap_write(priv->regmap, MIPI_DSI_WAKEUP_TIM,
+		     DIV_ROUND_UP(priv->config.wakeup * NSEC_PER_MSEC, temp));
+	regmap_write(priv->regmap, MIPI_DSI_LPOK_TIM, 0x7C);
+	regmap_write(priv->regmap, MIPI_DSI_ULPS_CHECK, 0x927C);
+	regmap_write(priv->regmap, MIPI_DSI_LP_WCHDOG, 0x1000);
+	regmap_write(priv->regmap, MIPI_DSI_TURN_WCHDOG, 0x1000);
+
+	/* Powerup the analog circuit */
+	switch (priv->config.lanes) {
+	case 1:
+		regmap_write(priv->regmap, MIPI_DSI_CHAN_CTRL, 0xe);
+		break;
+	case 2:
+		regmap_write(priv->regmap, MIPI_DSI_CHAN_CTRL, 0xc);
+		break;
+	case 3:
+		regmap_write(priv->regmap, MIPI_DSI_CHAN_CTRL, 0x8);
+		break;
+	case 4:
+	default:
+		regmap_write(priv->regmap, MIPI_DSI_CHAN_CTRL, 0);
+		break;
+	}
+
+	/* Trigger a sync active for esc_clk */
+	regmap_update_bits(priv->regmap, MIPI_DSI_PHY_CTRL, BIT(1), BIT(1));
+
+	return 0;
+}
+
+static int phy_meson_axg_mipi_dphy_power_off(struct phy *phy)
+{
+	struct phy_meson_axg_mipi_dphy_priv *priv = phy_get_drvdata(phy);
+
+	regmap_write(priv->regmap, MIPI_DSI_CHAN_CTRL, 0xf);
+	regmap_write(priv->regmap, MIPI_DSI_PHY_CTRL, BIT(31));
+
+	phy_power_off(priv->analog);
+
+	return 0;
+}
+
+static int phy_meson_axg_mipi_dphy_exit(struct phy *phy)
+{
+	struct phy_meson_axg_mipi_dphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = phy_exit(priv->analog);
+	if (ret)
+		return ret;
+
+	return reset_control_reset(priv->reset);
+}
+
+static const struct phy_ops phy_meson_axg_mipi_dphy_ops = {
+	.configure	= phy_meson_axg_mipi_dphy_configure,
+	.init		= phy_meson_axg_mipi_dphy_init,
+	.exit		= phy_meson_axg_mipi_dphy_exit,
+	.power_on	= phy_meson_axg_mipi_dphy_power_on,
+	.power_off	= phy_meson_axg_mipi_dphy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int phy_meson_axg_mipi_dphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	struct phy_meson_axg_mipi_dphy_priv *priv;
+	struct phy *phy;
+	void __iomem *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	platform_set_drvdata(pdev, priv);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					&phy_meson_axg_mipi_dphy_regmap_conf);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->clk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->reset = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	priv->analog = devm_phy_get(dev, "analog");
+	if (IS_ERR(priv->analog))
+		return PTR_ERR(priv->analog);
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		return ret;
+
+	phy = devm_phy_create(dev, NULL, &phy_meson_axg_mipi_dphy_ops);
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to create PHY\n");
+
+		return ret;
+	}
+
+	phy_set_drvdata(phy, priv);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id phy_meson_axg_mipi_dphy_of_match[] = {
+	{ .compatible = "amlogic,axg-mipi-dphy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, phy_meson_axg_mipi_dphy_of_match);
+
+static struct platform_driver phy_meson_axg_mipi_dphy_driver = {
+	.probe	= phy_meson_axg_mipi_dphy_probe,
+	.driver	= {
+		.name		= "phy-meson-axg-mipi-dphy",
+		.of_match_table	= phy_meson_axg_mipi_dphy_of_match,
+	},
+};
+module_platform_driver(phy_meson_axg_mipi_dphy_driver);
+
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Meson AXG MIPI DPHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.22.0

