Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF02920665
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgIBGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:50:02 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:55570 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBGtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:49:51 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 680ACC1074;
        Wed,  2 Sep 2020 14:49:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P29633T140716596516608S1599029386847454_;
        Wed, 02 Sep 2020 14:49:48 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <fef32d83f8180e077a234ca958fc9073>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 5/6] clk: rockchip: fix the clk config to support module build
Date:   Wed,  2 Sep 2020 14:49:44 +0800
Message-Id: <20200902064944.18943-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902064847.18881-1-zhangqing@rock-chips.com>
References: <20200902064847.18881-1-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use CONFIG_COMMON_CLK_ROCKCHIP for Rk common clk drivers.
use CONFIG_CLK_RKXX for Rk soc clk driver.
Mark configuration to "tristate",
to support building Rk SoCs clock driver as module.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/Kconfig           |  1 +
 drivers/clk/rockchip/Kconfig  | 78 +++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/Makefile | 42 ++++++++++---------
 3 files changed, 101 insertions(+), 20 deletions(-)
 create mode 100644 drivers/clk/rockchip/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4026fac9fac3..b41aaed9bd51 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -373,6 +373,7 @@ source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
+source "drivers/clk/rockchip/Kconfig"
 source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/sprd/Kconfig"
diff --git a/drivers/clk/rockchip/Kconfig b/drivers/clk/rockchip/Kconfig
new file mode 100644
index 000000000000..53a44396bc35
--- /dev/null
+++ b/drivers/clk/rockchip/Kconfig
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+# common clock support for ROCKCHIP SoC family.
+
+config COMMON_CLK_ROCKCHIP
+	tristate "Rockchip clock controller common support"
+	depends on ARCH_ROCKCHIP
+	default ARCH_ROCKCHIP
+	help
+	  Say y here to enable common clock controller.
+
+if COMMON_CLK_ROCKCHIP
+config CLK_PX30
+	tristate "Rockchip Px30 clock controller support"
+	default y
+	help
+	  Build the driver for Px30 Clock Driver.
+
+config CLK_RV110X
+	tristate "Rockchip Rv110x clock controller support"
+	default y
+	help
+	  Build the driver for Rv110x Clock Driver.
+
+config CLK_RK3036
+	tristate "Rockchip Rk3036 clock controller support"
+	default y
+	help
+	  Build the driver for Rk3036 Clock Driver.
+
+config CLK_RK312X
+	tristate "Rockchip Rk312x clock controller support"
+	default y
+	help
+	  Build the driver for Rk312x Clock Driver.
+
+config CLK_RK3188
+	tristate "Rockchip Rk3188 clock controller support"
+	default y
+	help
+	  Build the driver for Rk3188 Clock Driver.
+
+config CLK_RK322X
+	tristate "Rockchip Rk322x clock controller support"
+	default y
+	help
+	  Build the driver for Rk322x Clock Driver.
+
+config CLK_RK3288
+	tristate "Rockchip Rk3288 clock controller support"
+	depends on ARM
+	default y
+	help
+	  Build the driver for Rk3288 Clock Driver.
+
+config CLK_RK3308
+	tristate "Rockchip Rk3308 clock controller support"
+	default y
+	help
+	  Build the driver for Rk3308 Clock Driver.
+
+config CLK_RK3328
+	tristate "Rockchip Rk3328 clock controller support"
+	default y
+	help
+	  Build the driver for Rk3328 Clock Driver.
+
+config CLK_RK3368
+	tristate "Rockchip Rk3368 clock controller support"
+	default y
+	help
+	  Build the driver for Rk3368 Clock Driver.
+
+config CLK_RK3399
+	tristate "Rockchip Rk3399 clock controller support"
+	default y
+	help
+	  Build the driver for Rk3399 Clock Driver.
+endif
diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 7c5b5813a87c..a99e4d9bbae1 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -3,24 +3,26 @@
 # Rockchip Clock specific Makefile
 #
 
-obj-y	+= clk.o
-obj-y	+= clk-pll.o
-obj-y	+= clk-cpu.o
-obj-y	+= clk-half-divider.o
-obj-y	+= clk-inverter.o
-obj-y	+= clk-mmc-phase.o
-obj-y	+= clk-muxgrf.o
-obj-y	+= clk-ddr.o
-obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
+obj-$(CONFIG_COMMON_CLK_ROCKCHIP) += clk-rockchip.o
 
-obj-y	+= clk-px30.o
-obj-y	+= clk-rv1108.o
-obj-y	+= clk-rk3036.o
-obj-y	+= clk-rk3128.o
-obj-y	+= clk-rk3188.o
-obj-y	+= clk-rk3228.o
-obj-y	+= clk-rk3288.o
-obj-y	+= clk-rk3308.o
-obj-y	+= clk-rk3328.o
-obj-y	+= clk-rk3368.o
-obj-y	+= clk-rk3399.o
+clk-rockchip-y += clk.o
+clk-rockchip-y += clk-pll.o
+clk-rockchip-y += clk-cpu.o
+clk-rockchip-y += clk-half-divider.o
+clk-rockchip-y += clk-inverter.o
+clk-rockchip-y += clk-mmc-phase.o
+clk-rockchip-y += clk-muxgrf.o
+clk-rockchip-y += clk-ddr.o
+clk-rockchip-$(CONFIG_RESET_CONTROLLER) += softrst.o
+
+obj-$(CONFIG_CLK_PX30)          += clk-px30.o
+obj-$(CONFIG_CLK_RV110X)        += clk-rv1108.o
+obj-$(CONFIG_CLK_RK3036)        += clk-rk3036.o
+obj-$(CONFIG_CLK_RK312X)        += clk-rk3128.o
+obj-$(CONFIG_CLK_RK3188)        += clk-rk3188.o
+obj-$(CONFIG_CLK_RK322X)        += clk-rk3228.o
+obj-$(CONFIG_CLK_RK3288)        += clk-rk3288.o
+obj-$(CONFIG_CLK_RK3308)        += clk-rk3308.o
+obj-$(CONFIG_CLK_RK3328)        += clk-rk3328.o
+obj-$(CONFIG_CLK_RK3368)        += clk-rk3368.o
+obj-$(CONFIG_CLK_RK3399)        += clk-rk3399.o
-- 
2.17.1



