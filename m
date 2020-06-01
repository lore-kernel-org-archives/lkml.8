Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BE6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD47A2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgFAGX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:23:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48716 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgFAGXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:23:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 385A12004B1;
        Mon,  1 Jun 2020 08:23:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F7EA2004A1;
        Mon,  1 Jun 2020 08:23:16 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EE0E4402A7;
        Mon,  1 Jun 2020 14:23:08 +0800 (SGT)
From:   sandor.yu@nxp.com
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, heiko@sntech.de, hjc@rock-chips.com,
        Sandor.yu@nxp.com, dkos@cadence.com,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH 4/7] drm: imx: mhdp: initial support for i.MX8MQ MHDP Displayport
Date:   Mon,  1 Jun 2020 14:17:34 +0800
Message-Id: <25f0d6e497bc76741a715f03f1c5853c8d77cee5.1590982881.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590982881.git.Sandor.yu@nxp.com>
References: <cover.1590982881.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
In-Reply-To: <cover.1590982881.git.Sandor.yu@nxp.com>
References: <cover.1590982881.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandor Yu <Sandor.yu@nxp.com>

Initial support for i.MX8MQ MHDP Displayport.
Add MHDP DP PHY configutation.
The features are same as MHDP DP bridge driver.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
---
 drivers/gpu/drm/imx/Kconfig                 |   1 +
 drivers/gpu/drm/imx/Makefile                |   1 +
 drivers/gpu/drm/imx/mhdp/Kconfig            |   8 +
 drivers/gpu/drm/imx/mhdp/Makefile           |   4 +
 drivers/gpu/drm/imx/mhdp/cdns-mhdp-dp-phy.c | 390 ++++++++++++++++++++
 drivers/gpu/drm/imx/mhdp/cdns-mhdp-imxdrv.c | 130 +++++++
 drivers/gpu/drm/imx/mhdp/cdns-mhdp-phy.h    | 146 ++++++++
 7 files changed, 680 insertions(+)
 create mode 100644 drivers/gpu/drm/imx/mhdp/Kconfig
 create mode 100644 drivers/gpu/drm/imx/mhdp/Makefile
 create mode 100644 drivers/gpu/drm/imx/mhdp/cdns-mhdp-dp-phy.c
 create mode 100644 drivers/gpu/drm/imx/mhdp/cdns-mhdp-imxdrv.c
 create mode 100644 drivers/gpu/drm/imx/mhdp/cdns-mhdp-phy.h

diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
index 6231048aa5aa..4af2f575f04b 100644
--- a/drivers/gpu/drm/imx/Kconfig
+++ b/drivers/gpu/drm/imx/Kconfig
@@ -41,3 +41,4 @@ config DRM_IMX_HDMI
 	  Choose this if you want to use HDMI on i.MX6.
 
 source "drivers/gpu/drm/imx/dcss/Kconfig"
+source "drivers/gpu/drm/imx/mhdp/Kconfig"
diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
index b644deffe948..0b46c46b19a8 100644
--- a/drivers/gpu/drm/imx/Makefile
+++ b/drivers/gpu/drm/imx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_DRM_IMX_LDB) += imx-ldb.o
 
 obj-$(CONFIG_DRM_IMX_HDMI) += dw_hdmi-imx.o
 obj-$(CONFIG_DRM_IMX_DCSS) += dcss/
+obj-$(CONFIG_DRM_IMX_CDNS_MHDP) += mhdp/
diff --git a/drivers/gpu/drm/imx/mhdp/Kconfig b/drivers/gpu/drm/imx/mhdp/Kconfig
new file mode 100644
index 000000000000..c9e07a3bf3df
--- /dev/null
+++ b/drivers/gpu/drm/imx/mhdp/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_IMX_CDNS_MHDP
+	tristate "NXP i.MX MX8 DRM DP"
+	select DRM_CDNS_MHDP
+	select DRM_CDNS_DP
+	help
+	  Choose this if you want to use Displayport on i.MX8.
diff --git a/drivers/gpu/drm/imx/mhdp/Makefile b/drivers/gpu/drm/imx/mhdp/Makefile
new file mode 100644
index 000000000000..4383e689445a
--- /dev/null
+++ b/drivers/gpu/drm/imx/mhdp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+cdns_mhdp_imx-objs := cdns-mhdp-imxdrv.o cdns-mhdp-dp-phy.o
+obj-$(CONFIG_DRM_IMX_CDNS_MHDP) += cdns_mhdp_imx.o
diff --git a/drivers/gpu/drm/imx/mhdp/cdns-mhdp-dp-phy.c b/drivers/gpu/drm/imx/mhdp/cdns-mhdp-dp-phy.c
new file mode 100644
index 000000000000..bb694301984d
--- /dev/null
+++ b/drivers/gpu/drm/imx/mhdp/cdns-mhdp-dp-phy.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cadence Display Port Interface (DP) PHY driver
+ *
+ * Copyright (C) 2019-2020 NXP Semiconductor, Inc.
+ */
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/bridge/cdns-mhdp.h>
+#include "cdns-mhdp-phy.h"
+
+enum dp_link_rate {
+	RATE_1_6 = 162000,
+	RATE_2_1 = 216000,
+	RATE_2_4 = 243000,
+	RATE_2_7 = 270000,
+	RATE_3_2 = 324000,
+	RATE_4_3 = 432000,
+	RATE_5_4 = 540000,
+	RATE_8_1 = 810000,
+};
+
+struct phy_pll_reg {
+	u16 val[7];
+	u32 addr;
+};
+
+static const struct phy_pll_reg phy_pll_27m_cfg[] = {
+	/*  1.62    2.16    2.43    2.7     3.24    4.32    5.4      register address */
+	{{ 0x010E, 0x010E, 0x010E, 0x010E, 0x010E, 0x010E, 0x010E }, CMN_PLL0_VCOCAL_INIT_TMR },
+	{{ 0x001B, 0x001B, 0x001B, 0x001B, 0x001B, 0x001B, 0x001B }, CMN_PLL0_VCOCAL_ITER_TMR },
+	{{ 0x30B9, 0x3087, 0x3096, 0x30B4, 0x30B9, 0x3087, 0x30B4 }, CMN_PLL0_VCOCAL_START },
+	{{ 0x0077, 0x009F, 0x00B3, 0x00C7, 0x0077, 0x009F, 0x00C7 }, CMN_PLL0_INTDIV },
+	{{ 0xF9DA, 0xF7CD, 0xF6C7, 0xF5C1, 0xF9DA, 0xF7CD, 0xF5C1 }, CMN_PLL0_FRACDIV },
+	{{ 0x001E, 0x0028, 0x002D, 0x0032, 0x001E, 0x0028, 0x0032 }, CMN_PLL0_HIGH_THR },
+	{{ 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020 }, CMN_PLL0_DSM_DIAG },
+	{{ 0x0000, 0x1000, 0x1000, 0x1000, 0x0000, 0x1000, 0x1000 }, CMN_PLLSM0_USER_DEF_CTRL },
+	{{ 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000 }, CMN_DIAG_PLL0_OVRD },
+	{{ 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000 }, CMN_DIAG_PLL0_FBH_OVRD },
+	{{ 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000 }, CMN_DIAG_PLL0_FBL_OVRD },
+	{{ 0x0006, 0x0007, 0x0007, 0x0007, 0x0006, 0x0007, 0x0007 }, CMN_DIAG_PLL0_V2I_TUNE },
+	{{ 0x0043, 0x0043, 0x0043, 0x0042, 0x0043, 0x0043, 0x0042 }, CMN_DIAG_PLL0_CP_TUNE },
+	{{ 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008 }, CMN_DIAG_PLL0_LF_PROG },
+	{{ 0x0100, 0x0001, 0x0001, 0x0001, 0x0100, 0x0001, 0x0001 }, CMN_DIAG_PLL0_PTATIS_TUNE1 },
+	{{ 0x0007, 0x0001, 0x0001, 0x0001, 0x0007, 0x0001, 0x0001 }, CMN_DIAG_PLL0_PTATIS_TUNE2 },
+	{{ 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020 }, CMN_DIAG_PLL0_TEST_MODE},
+	{{ 0x0016, 0x0016, 0x0016, 0x0016, 0x0016, 0x0016, 0x0016 }, CMN_PSM_CLK_CTRL }
+};
+
+static int link_rate_index(u32 rate)
+{
+	switch (rate) {
+	case RATE_1_6:
+		return 0;
+	case RATE_2_1:
+		return 1;
+	case RATE_2_4:
+		return 2;
+	case RATE_2_7:
+		return 3;
+	case RATE_3_2:
+		return 4;
+	case RATE_4_3:
+		return 5;
+	case RATE_5_4:
+		return 6;
+	default:
+		return -1;
+	}
+}
+
+static void dp_aux_cfg(struct cdns_mhdp_device *mhdp)
+{
+	/* Power up Aux */
+	cdns_phy_reg_write(mhdp, TXDA_CYA_AUXDA_CYA, 1);
+
+	cdns_phy_reg_write(mhdp, TX_DIG_CTRL_REG_1, 0x3);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_DIG_CTRL_REG_2, 36);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_2, 0x0100);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_2, 0x0300);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_3, 0x0000);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_1, 0x2008);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_1, 0x2018);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_1, 0xA018);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_2, 0x030C);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_5, 0x0000);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_4, 0x1001);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_1, 0xA098);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_1, 0xA198);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_2, 0x030d);
+	ndelay(150);
+	cdns_phy_reg_write(mhdp, TX_ANA_CTRL_REG_2, 0x030f);
+}
+
+/* PMA common configuration for 27MHz */
+static void dp_phy_pma_cmn_cfg_27mhz(struct cdns_mhdp_device *mhdp)
+{
+	u32 num_lanes = mhdp->dp.num_lanes;
+	u16 val;
+	int k;
+
+	val = cdns_phy_reg_read(mhdp, PHY_PMA_CMN_CTRL1);
+	val &= 0xFFF7;
+	val |= 0x0008;
+	cdns_phy_reg_write(mhdp, PHY_PMA_CMN_CTRL1, val);
+
+	/* Startup state machine registers */
+	cdns_phy_reg_write(mhdp, CMN_SSM_BIAS_TMR, 0x0087);
+	cdns_phy_reg_write(mhdp, CMN_PLLSM0_PLLEN_TMR, 0x001B);
+	cdns_phy_reg_write(mhdp, CMN_PLLSM0_PLLPRE_TMR, 0x0036);
+	cdns_phy_reg_write(mhdp, CMN_PLLSM0_PLLVREF_TMR, 0x001B);
+	cdns_phy_reg_write(mhdp, CMN_PLLSM0_PLLLOCK_TMR, 0x006C);
+
+	/* Current calibration registers */
+	cdns_phy_reg_write(mhdp, CMN_ICAL_INIT_TMR, 0x0044);
+	cdns_phy_reg_write(mhdp, CMN_ICAL_ITER_TMR, 0x0006);
+	cdns_phy_reg_write(mhdp, CMN_ICAL_ADJ_INIT_TMR, 0x0022);
+	cdns_phy_reg_write(mhdp, CMN_ICAL_ADJ_ITER_TMR, 0x0006);
+
+	/* Resistor calibration registers */
+	cdns_phy_reg_write(mhdp, CMN_TXPUCAL_INIT_TMR, 0x0022);
+	cdns_phy_reg_write(mhdp, CMN_TXPUCAL_ITER_TMR, 0x0006);
+	cdns_phy_reg_write(mhdp, CMN_TXPU_ADJ_INIT_TMR, 0x0022);
+	cdns_phy_reg_write(mhdp, CMN_TXPU_ADJ_ITER_TMR, 0x0006);
+	cdns_phy_reg_write(mhdp, CMN_TXPDCAL_INIT_TMR, 0x0022);
+	cdns_phy_reg_write(mhdp, CMN_TXPDCAL_ITER_TMR, 0x0006);
+	cdns_phy_reg_write(mhdp, CMN_TXPD_ADJ_INIT_TMR, 0x0022);
+	cdns_phy_reg_write(mhdp, CMN_TXPD_ADJ_ITER_TMR, 0x0006);
+	cdns_phy_reg_write(mhdp, CMN_RXCAL_INIT_TMR, 0x0022);
+	cdns_phy_reg_write(mhdp, CMN_RXCAL_ITER_TMR, 0x0006);
+	cdns_phy_reg_write(mhdp, CMN_RX_ADJ_INIT_TMR, 0x0022);
+	cdns_phy_reg_write(mhdp, CMN_RX_ADJ_ITER_TMR, 0x0006);
+
+	for (k = 0; k < num_lanes; k = k + 1) {
+		/* Power state machine registers */
+		cdns_phy_reg_write(mhdp, XCVR_PSM_CAL_TMR  | (k << 9), 0x016D);
+		cdns_phy_reg_write(mhdp, XCVR_PSM_A0IN_TMR | (k << 9), 0x016D);
+		/* Transceiver control and diagnostic registers */
+		cdns_phy_reg_write(mhdp, XCVR_DIAG_LANE_FCM_EN_MGN_TMR | (k << 9), 0x00A2);
+		cdns_phy_reg_write(mhdp, TX_DIAG_BGREF_PREDRV_DELAY    | (k << 9), 0x0097);
+		/* Transmitter receiver detect registers */
+		cdns_phy_reg_write(mhdp, TX_RCVDET_EN_TMR | (k << 9), 0x0A8C);
+		cdns_phy_reg_write(mhdp, TX_RCVDET_ST_TMR | (k << 9), 0x0036);
+	}
+}
+
+static void dp_phy_pma_cmn_pll0_27mhz(struct cdns_mhdp_device *mhdp)
+{
+	u32 num_lanes = mhdp->dp.num_lanes;
+	u32 link_rate = mhdp->dp.rate;
+	u16 val;
+	int index, i, k;
+
+	/*
+	 * PLL reference clock source select
+	 * for single ended reference clock val |= 0x0030;
+	 * for differential clock  val |= 0x0000;
+	 */
+	val = cdns_phy_reg_read(mhdp, PHY_PMA_CMN_CTRL1);
+	val &= 0xFF8F;
+	cdns_phy_reg_write(mhdp, PHY_PMA_CMN_CTRL1, val);
+
+	/* for differential clock on the refclk_p and refclk_m off chip pins:
+	 * CMN_DIAG_ACYA[8]=1'b1
+	 */
+	cdns_phy_reg_write(mhdp, CMN_DIAG_ACYA, 0x0100);
+
+	/* DP PLL data rate 0/1 clock divider value */
+	val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+	val &= 0x00FF;
+	if (link_rate <= RATE_2_7)
+		val |= 0x2400;
+	else
+		val |= 0x1200;
+	cdns_phy_reg_write(mhdp, PHY_HDP_CLK_CTL, val);
+
+	/* High speed clock 0/1 div */
+	val = cdns_phy_reg_read(mhdp, CMN_DIAG_HSCLK_SEL);
+	val &= 0xFFCC;
+	if (link_rate <= RATE_2_7)
+		val |= 0x0011;
+	cdns_phy_reg_write(mhdp, CMN_DIAG_HSCLK_SEL, val);
+
+	for (k = 0; k < num_lanes; k++) {
+		val = cdns_phy_reg_read(mhdp, (XCVR_DIAG_HSCLK_SEL | (k << 9)));
+		val = val & 0xCFFF;
+		if (link_rate <= RATE_2_7)
+			val |= 0x1000;
+		cdns_phy_reg_write(mhdp, (XCVR_DIAG_HSCLK_SEL | (k << 9)), val);
+	}
+
+	/* DP PHY PLL 27MHz configuration */
+	index = link_rate_index(link_rate);
+	for (i = 0; i < ARRAY_SIZE(phy_pll_27m_cfg); i++)
+		cdns_phy_reg_write(mhdp, phy_pll_27m_cfg[i].addr, phy_pll_27m_cfg[i].val[index]);
+
+	/* Transceiver control and diagnostic registers */
+	for (k = 0; k < num_lanes; k++) {
+		val = cdns_phy_reg_read(mhdp, (XCVR_DIAG_PLLDRC_CTRL | (k << 9)));
+		val = val & 0x8FFF;
+		if (link_rate <= RATE_2_7)
+			val |= 0x2000;
+		else
+			val |= 0x1000;
+		cdns_phy_reg_write(mhdp, (XCVR_DIAG_PLLDRC_CTRL | (k << 9)), val);
+	}
+
+	for (k = 0; k < num_lanes; k = k + 1) {
+		/* Power state machine registers */
+		cdns_phy_reg_write(mhdp, (XCVR_PSM_RCTRL | (k << 9)),  0xBEFC);
+		cdns_phy_reg_write(mhdp, (TX_PSC_A0 | (k << 9)), 0x6799);
+		cdns_phy_reg_write(mhdp, (TX_PSC_A1 | (k << 9)), 0x6798);
+		cdns_phy_reg_write(mhdp, (TX_PSC_A2 | (k << 9)), 0x0098);
+		cdns_phy_reg_write(mhdp, (TX_PSC_A3 | (k << 9)), 0x0098);
+		/* Receiver calibration power state definition register */
+		val = cdns_phy_reg_read(mhdp, RX_PSC_CAL | (k << 9));
+		val &= 0xFFBB;
+		cdns_phy_reg_write(mhdp, (RX_PSC_CAL | (k << 9)), val);
+		val = cdns_phy_reg_read(mhdp, RX_PSC_A0  | (k << 9));
+		val &= 0xFFBB;
+		cdns_phy_reg_write(mhdp, (RX_PSC_A0  | (k << 9)), val);
+	}
+}
+
+static void dp_phy_power_down(struct cdns_mhdp_device *mhdp)
+{
+	u16 val;
+	int i;
+
+	if (!mhdp->power_up)
+		return;
+
+	/* Place the PHY lanes in the A3 power state. */
+	cdns_phy_reg_write(mhdp, PHY_HDP_MODE_CTRL, 0x8);
+	/* Wait for Power State A3 Ack */
+	for (i = 0; i < 10; i++) {
+		val = cdns_phy_reg_read(mhdp, PHY_HDP_MODE_CTRL);
+		if (val & (1 << 7))
+			break;
+		msleep(20);
+	}
+	if (i == 10) {
+		dev_err(mhdp->dev, "Wait A3 Ack failed\n");
+		return;
+	}
+
+	/* Disable HDP PLL’s data rate and full rate clocks out of PMA. */
+	val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+	val &= ~(1 << 2);
+	cdns_phy_reg_write(mhdp, PHY_HDP_CLK_CTL, val);
+	/* Wait for PLL clock gate ACK */
+	for (i = 0; i < 10; i++) {
+		val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+		if (!(val & (1 << 3)))
+			break;
+		msleep(20);
+	}
+	if (i == 10) {
+		dev_err(mhdp->dev, "Wait PLL clock gate Ack failed\n");
+		return;
+	}
+
+	/* Disable HDP PLL’s for high speed clocks */
+	val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+	val &= ~(1 << 0);
+	cdns_phy_reg_write(mhdp, PHY_HDP_CLK_CTL, val);
+	/* Wait for PLL disable ACK */
+	for (i = 0; i < 10; i++) {
+		val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+		if (!(val & (1 << 1)))
+			break;
+		msleep(20);
+	}
+	if (i == 10) {
+		dev_err(mhdp->dev, "Wait PLL disable Ack failed\n");
+		return;
+	}
+}
+
+static int dp_phy_power_up(struct cdns_mhdp_device *mhdp)
+{
+	u32 val, i;
+
+	/* Enable HDP PLL’s for high speed clocks */
+	val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+	val |= (1 << 0);
+	cdns_phy_reg_write(mhdp, PHY_HDP_CLK_CTL, val);
+	/* Wait for PLL ready ACK */
+	for (i = 0; i < 10; i++) {
+		val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+		if (val & (1 << 1))
+			break;
+		msleep(20);
+	}
+	if (i == 10) {
+		dev_err(mhdp->dev, "Wait PLL Ack failed\n");
+		return -1;
+	}
+
+	/* Enable HDP PLL’s data rate and full rate clocks out of PMA. */
+	val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+	val |= (1 << 2);
+	cdns_phy_reg_write(mhdp, PHY_HDP_CLK_CTL, val);
+	/* Wait for PLL clock enable ACK */
+	for (i = 0; i < 10; i++) {
+		val = cdns_phy_reg_read(mhdp, PHY_HDP_CLK_CTL);
+		if (val & (1 << 3))
+			break;
+		msleep(20);
+	}
+	if (i == 10) {
+		dev_err(mhdp->dev, "Wait PLL clock enable ACk failed\n");
+		return -1;
+	}
+
+	/* Configure PHY in A2 Mode */
+	cdns_phy_reg_write(mhdp, PHY_HDP_MODE_CTRL, 0x0004);
+	/* Wait for Power State A2 Ack */
+	for (i = 0; i < 10; i++) {
+		val = cdns_phy_reg_read(mhdp, PHY_HDP_MODE_CTRL);
+		if (val & (1 << 6))
+			break;
+		msleep(20);
+	}
+	if (i == 10) {
+		dev_err(mhdp->dev, "Wait A2 Ack failed\n");
+		return -1;
+	}
+
+	/* Configure PHY in A0 mode (PHY must be in the A0 power
+	 * state in order to transmit data)
+	 */
+	cdns_phy_reg_write(mhdp, PHY_HDP_MODE_CTRL, 0x0101);
+
+	/* Wait for Power State A0 Ack */
+	for (i = 0; i < 10; i++) {
+		val = cdns_phy_reg_read(mhdp, PHY_HDP_MODE_CTRL);
+		if (val & (1 << 4))
+			break;
+		msleep(20);
+	}
+	if (i == 10) {
+		dev_err(mhdp->dev, "Wait A0 Ack failed\n");
+		return -1;
+	}
+
+	mhdp->power_up = true;
+
+	return 0;
+}
+
+int cdns_dp_phy_set_imx8mq(struct cdns_mhdp_device *mhdp)
+{
+	int ret;
+
+	/* Disable phy clock if PHY in power up state */
+	dp_phy_power_down(mhdp);
+
+	dp_phy_pma_cmn_cfg_27mhz(mhdp);
+
+	dp_phy_pma_cmn_pll0_27mhz(mhdp);
+
+	cdns_phy_reg_write(mhdp, TX_DIAG_ACYA_0, 1);
+	cdns_phy_reg_write(mhdp, TX_DIAG_ACYA_1, 1);
+	cdns_phy_reg_write(mhdp, TX_DIAG_ACYA_2, 1);
+	cdns_phy_reg_write(mhdp, TX_DIAG_ACYA_3, 1);
+
+	/* PHY power up */
+	ret = dp_phy_power_up(mhdp);
+	if (ret < 0)
+		return ret;
+
+	dp_aux_cfg(mhdp);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/imx/mhdp/cdns-mhdp-imxdrv.c b/drivers/gpu/drm/imx/mhdp/cdns-mhdp-imxdrv.c
new file mode 100644
index 000000000000..2dec2e051be6
--- /dev/null
+++ b/drivers/gpu/drm/imx/mhdp/cdns-mhdp-imxdrv.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * copyright (c) 2019-2020 nxp semiconductor, inc.
+ *
+ */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/component.h>
+#include <drm/drm_of.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder_slave.h>
+
+#include "cdns-mhdp-phy.h"
+#include "../imx-drm.h"
+
+struct imx_mhdp_device {
+	struct cdns_mhdp_device mhdp;
+	struct drm_encoder encoder;
+};
+
+static const struct drm_encoder_funcs cdns_mhdp_imx_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static struct cdns_plat_data imx8mq_dp_drv_data = {
+	.plat_name = "imx8mq-dp",
+	.bind	= cdns_dp_bind,
+	.unbind	= cdns_dp_unbind,
+	.phy_set = cdns_dp_phy_set_imx8mq,
+	.lane_mapping = 0xc6,
+};
+
+static const struct of_device_id cdns_mhdp_imx_dt_ids[] = {
+	{ .compatible = "nxp,imx8mq-cdns-dp",
+	  .data = &imx8mq_dp_drv_data
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cdns_mhdp_imx_dt_ids);
+
+static int cdns_mhdp_imx_bind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	const struct cdns_plat_data *plat_data;
+	const struct of_device_id *match;
+	struct drm_device *drm = data;
+	struct drm_encoder *encoder;
+	struct imx_mhdp_device *imx_mhdp;
+	int ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	imx_mhdp = devm_kzalloc(&pdev->dev, sizeof(*imx_mhdp), GFP_KERNEL);
+	if (!imx_mhdp)
+		return -ENOMEM;
+
+	match = of_match_node(cdns_mhdp_imx_dt_ids, pdev->dev.of_node);
+	plat_data = match->data;
+	encoder = &imx_mhdp->encoder;
+
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+
+	/*
+	 * If we failed to find the CRTC(s) which this encoder is
+	 * supposed to be connected to, it's because the CRTC has
+	 * not been registered yet.  Defer probing, and hope that
+	 * the required CRTC is added later.
+	 */
+	if (encoder->possible_crtcs == 0)
+		return -EPROBE_DEFER;
+
+	drm_encoder_init(drm, encoder, &cdns_mhdp_imx_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
+
+
+	imx_mhdp->mhdp.plat_data = plat_data;
+	imx_mhdp->mhdp.dev = dev;
+	ret = plat_data->bind(pdev, encoder, &imx_mhdp->mhdp);
+	/*
+	 * If cdns_mhdp_bind() fails we'll never call cdns_mhdp_unbind(),
+	 * which would have called the encoder cleanup.  Do it manually.
+	 */
+	if (ret < 0)
+		drm_encoder_cleanup(encoder);
+
+	return ret;
+}
+
+static void cdns_mhdp_imx_unbind(struct device *dev, struct device *master,
+			       void *data)
+{
+	struct imx_mhdp_device *imx_mhdp = dev_get_drvdata(dev);
+
+	imx_mhdp->mhdp.plat_data->unbind(dev);
+}
+
+static const struct component_ops cdns_mhdp_imx_ops = {
+	.bind	= cdns_mhdp_imx_bind,
+	.unbind	= cdns_mhdp_imx_unbind,
+};
+
+static int cdns_mhdp_imx_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &cdns_mhdp_imx_ops);
+}
+
+static int cdns_mhdp_imx_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &cdns_mhdp_imx_ops);
+
+	return 0;
+}
+
+static struct platform_driver cdns_mhdp_imx_platform_driver = {
+	.probe  = cdns_mhdp_imx_probe,
+	.remove = cdns_mhdp_imx_remove,
+	.driver = {
+		.name = "cdns-mhdp-imx",
+		.of_match_table = cdns_mhdp_imx_dt_ids,
+	},
+};
+
+module_platform_driver(cdns_mhdp_imx_platform_driver);
+
+MODULE_AUTHOR("Sandor YU <sandor.yu@nxp.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cdnsmhdp-imx");
diff --git a/drivers/gpu/drm/imx/mhdp/cdns-mhdp-phy.h b/drivers/gpu/drm/imx/mhdp/cdns-mhdp-phy.h
new file mode 100644
index 000000000000..79b1907726db
--- /dev/null
+++ b/drivers/gpu/drm/imx/mhdp/cdns-mhdp-phy.h
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019-2020 NXP Semiconductor, Inc.
+ *
+ */
+#ifndef _CDNS_MHDP_PHY_H
+#define _CDNS_MHDP_PHY_H
+
+#include <drm/bridge/cdns-mhdp.h>
+
+#define CMN_SSM_BIAS_TMR                0x0022
+#define CMN_PLLSM0_PLLEN_TMR            0x0029
+#define CMN_PLLSM0_PLLPRE_TMR           0x002A
+#define CMN_PLLSM0_PLLVREF_TMR          0x002B
+#define CMN_PLLSM0_PLLLOCK_TMR          0x002C
+#define CMN_PLLSM0_USER_DEF_CTRL        0x002F
+#define CMN_PSM_CLK_CTRL                0x0061
+#define CMN_CDIAG_REFCLK_CTRL           0x0062
+#define CMN_PLL0_VCOCAL_START           0x0081
+#define CMN_PLL0_VCOCAL_INIT_TMR        0x0084
+#define CMN_PLL0_VCOCAL_ITER_TMR        0x0085
+#define CMN_PLL0_INTDIV                 0x0094
+#define CMN_PLL0_FRACDIV                0x0095
+#define CMN_PLL0_HIGH_THR               0x0096
+#define CMN_PLL0_DSM_DIAG               0x0097
+#define CMN_PLL0_SS_CTRL1               0x0098
+#define CMN_PLL0_SS_CTRL2               0x0099
+#define CMN_ICAL_INIT_TMR               0x00C4
+#define CMN_ICAL_ITER_TMR               0x00C5
+#define CMN_RXCAL_INIT_TMR              0x00D4
+#define CMN_RXCAL_ITER_TMR              0x00D5
+#define CMN_TXPUCAL_CTRL                0x00E0
+#define CMN_TXPUCAL_INIT_TMR            0x00E4
+#define CMN_TXPUCAL_ITER_TMR            0x00E5
+#define CMN_TXPDCAL_CTRL                0x00F0
+#define CMN_TXPDCAL_INIT_TMR            0x00F4
+#define CMN_TXPDCAL_ITER_TMR            0x00F5
+#define CMN_ICAL_ADJ_INIT_TMR           0x0102
+#define CMN_ICAL_ADJ_ITER_TMR           0x0103
+#define CMN_RX_ADJ_INIT_TMR             0x0106
+#define CMN_RX_ADJ_ITER_TMR             0x0107
+#define CMN_TXPU_ADJ_CTRL               0x0108
+#define CMN_TXPU_ADJ_INIT_TMR           0x010A
+#define CMN_TXPU_ADJ_ITER_TMR           0x010B
+#define CMN_TXPD_ADJ_CTRL               0x010c
+#define CMN_TXPD_ADJ_INIT_TMR           0x010E
+#define CMN_TXPD_ADJ_ITER_TMR           0x010F
+#define CMN_DIAG_PLL0_FBH_OVRD          0x01C0
+#define CMN_DIAG_PLL0_FBL_OVRD          0x01C1
+#define CMN_DIAG_PLL0_OVRD              0x01C2
+#define CMN_DIAG_PLL0_TEST_MODE         0x01C4
+#define CMN_DIAG_PLL0_V2I_TUNE          0x01C5
+#define CMN_DIAG_PLL0_CP_TUNE           0x01C6
+#define CMN_DIAG_PLL0_LF_PROG           0x01C7
+#define CMN_DIAG_PLL0_PTATIS_TUNE1      0x01C8
+#define CMN_DIAG_PLL0_PTATIS_TUNE2      0x01C9
+#define CMN_DIAG_PLL0_INCLK_CTRL        0x01CA
+#define CMN_DIAG_PLL0_PXL_DIVH          0x01CB
+#define CMN_DIAG_PLL0_PXL_DIVL          0x01CC
+#define CMN_DIAG_HSCLK_SEL              0x01E0
+#define CMN_DIAG_PER_CAL_ADJ            0x01EC
+#define CMN_DIAG_CAL_CTRL               0x01ED
+#define CMN_DIAG_ACYA                   0x01FF
+#define XCVR_PSM_RCTRL                  0x4001
+#define XCVR_PSM_CAL_TMR                0x4002
+#define XCVR_PSM_A0IN_TMR               0x4003
+#define TX_TXCC_CAL_SCLR_MULT_0         0x4047
+#define TX_TXCC_CPOST_MULT_00_0         0x404C
+#define TX_TXCC_MGNFS_MULT_000_0        0x4050
+#define XCVR_DIAG_PLLDRC_CTRL           0x40E0
+#define XCVR_DIAG_PLLDRC_CTRL           0x40E0
+#define XCVR_DIAG_HSCLK_SEL             0x40E1
+#define XCVR_DIAG_BIDI_CTRL             0x40E8
+#define XCVR_DIAG_LANE_FCM_EN_MGN_TMR   0x40F2
+#define XCVR_DIAG_LANE_FCM_EN_MGN       0x40F2
+#define TX_PSC_A0                       0x4100
+#define TX_PSC_A1                       0x4101
+#define TX_PSC_A2                       0x4102
+#define TX_PSC_A3                       0x4103
+#define TX_RCVDET_CTRL                  0x4120
+#define TX_RCVDET_EN_TMR                0x4122
+#define TX_RCVDET_EN_TMR                0x4122
+#define TX_RCVDET_ST_TMR                0x4123
+#define TX_RCVDET_ST_TMR                0x4123
+#define TX_BIST_CTRL                    0x4140
+#define TX_BIST_UDDWR                   0x4141
+#define TX_DIAG_TX_CTRL                 0x41E0
+#define TX_DIAG_TX_DRV                  0x41E1
+#define TX_DIAG_BGREF_PREDRV_DELAY      0x41E7
+#define TX_DIAG_BGREF_PREDRV_DELAY      0x41E7
+#define XCVR_PSM_RCTRL_1                0x4201
+#define TX_TXCC_CAL_SCLR_MULT_1         0x4247
+#define TX_TXCC_CPOST_MULT_00_1         0x424C
+#define TX_TXCC_MGNFS_MULT_000_1        0x4250
+#define XCVR_DIAG_PLLDRC_CTRL_1         0x42E0
+#define XCVR_DIAG_HSCLK_SEL_1           0x42E1
+#define XCVR_DIAG_LANE_FCM_EN_MGN_TMR_1 0x42F2
+#define TX_RCVDET_EN_TMR_1              0x4322
+#define TX_RCVDET_ST_TMR_1              0x4323
+#define TX_DIAG_ACYA_0                  0x41FF
+#define TX_DIAG_ACYA_1                  0x43FF
+#define TX_DIAG_ACYA_2                  0x45FF
+#define TX_DIAG_ACYA_3                  0x47FF
+#define TX_ANA_CTRL_REG_1               0x5020
+#define TX_ANA_CTRL_REG_2               0x5021
+#define TXDA_COEFF_CALC                 0x5022
+#define TX_DIG_CTRL_REG_1               0x5023
+#define TX_DIG_CTRL_REG_2               0x5024
+#define TXDA_CYA_AUXDA_CYA              0x5025
+#define TX_ANA_CTRL_REG_3               0x5026
+#define TX_ANA_CTRL_REG_4               0x5027
+#define TX_ANA_CTRL_REG_5               0x5029
+#define RX_PSC_A0                       0x8000
+#define RX_PSC_CAL                      0x8006
+#define PMA_LANE_CFG                    0xC000
+#define PIPE_CMN_CTRL1                  0xC001
+#define PIPE_CMN_CTRL2                  0xC002
+#define PIPE_COM_LOCK_CFG1              0xC003
+#define PIPE_COM_LOCK_CFG2              0xC004
+#define PIPE_RCV_DET_INH                0xC005
+#define PHY_HDP_MODE_CTRL               0xC008
+#define PHY_HDP_CLK_CTL                 0xC009
+#define STS                             0xC00F
+#define PHY_ISO_CMN_CTRL                0xC010
+#define PHY_ISO_CMN_CTRL                0xC010
+#define PHY_HDP_TX_CTL_L0               0xC408
+#define PHY_DP_TX_CTL                   0xC408
+#define PHY_HDP_TX_CTL_L1               0xC448
+#define PHY_HDP_TX_CTL_L2               0xC488
+#define PHY_HDP_TX_CTL_L3               0xC4C8
+#define PHY_PMA_CMN_CTRL1               0xC800
+#define PMA_CMN_CTRL1                   0xC800
+#define PHY_PMA_ISO_CMN_CTRL            0xC810
+#define PHY_PMA_ISO_PLL_CTRL1           0xC812
+#define PHY_PMA_ISOLATION_CTRL          0xC81F
+#define PHY_ISOLATION_CTRL              0xC81F
+#define PHY_PMA_ISO_XCVR_CTRL           0xCC11
+#define PHY_PMA_ISO_LINK_MODE           0xCC12
+#define PHY_PMA_ISO_PWRST_CTRL          0xCC13
+#define PHY_PMA_ISO_TX_DATA_LO          0xCC14
+#define PHY_PMA_ISO_TX_DATA_HI          0xCC15
+#define PHY_PMA_ISO_RX_DATA_LO          0xCC16
+#define PHY_PMA_ISO_RX_DATA_HI          0xCC17
+
+int cdns_dp_phy_set_imx8mq(struct cdns_mhdp_device *hdp);
+#endif /* _CDNS_MHDP_PHY_H */
-- 
2.17.1

