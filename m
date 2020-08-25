Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08B920706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHYWHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:07:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYWHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:07:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E1D53291F68
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH] phy: Move phy-rockchip-dphy-rx0 out of staging
Date:   Tue, 25 Aug 2020 19:07:10 -0300
Message-Id: <20200825220710.634106-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for this driver to be in staging.
Let's promote it!

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/phy/rockchip/Kconfig                        | 12 ++++++++++++
 drivers/phy/rockchip/Makefile                       |  1 +
 .../rockchip}/phy-rockchip-dphy-rx0.c               |  0
 drivers/staging/media/Kconfig                       |  2 --
 drivers/staging/media/Makefile                      |  1 -
 drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig | 13 -------------
 .../staging/media/phy-rockchip-dphy-rx0/Makefile    |  2 --
 drivers/staging/media/phy-rockchip-dphy-rx0/TODO    |  6 ------
 8 files changed, 13 insertions(+), 24 deletions(-)
 rename drivers/{staging/media/phy-rockchip-dphy-rx0 => phy/rockchip}/phy-rockchip-dphy-rx0.c (100%)
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/Makefile
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/TODO

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 0824b9dd5683..c2f22f90736c 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -9,6 +9,18 @@ config PHY_ROCKCHIP_DP
 	help
 	  Enable this to support the Rockchip Display Port PHY.
 
+config PHY_ROCKCHIP_DPHY_RX0
+	tristate "Rockchip MIPI Synopsys DPHY RX0 driver"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	select GENERIC_PHY_MIPI_DPHY
+	select GENERIC_PHY
+	help
+	  Enable this to support the Rockchip MIPI Synopsys DPHY RX0
+	  associated to the Rockchip ISP module present in RK3399 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called phy-rockchip-dphy-rx0.
+
 config PHY_ROCKCHIP_EMMC
 	tristate "Rockchip EMMC PHY Driver"
 	depends on ARCH_ROCKCHIP && OF
diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
index 9f59a81e4e0d..c3cfc7f0af5c 100644
--- a/drivers/phy/rockchip/Makefile
+++ b/drivers/phy/rockchip/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_ROCKCHIP_DP)		+= phy-rockchip-dp.o
+obj-$(CONFIG_PHY_ROCKCHIP_DPHY_RX0)     += phy-rockchip-dphy-rx0.o
 obj-$(CONFIG_PHY_ROCKCHIP_EMMC)		+= phy-rockchip-emmc.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
diff --git a/drivers/staging/media/phy-rockchip-dphy-rx0/phy-rockchip-dphy-rx0.c b/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c
similarity index 100%
rename from drivers/staging/media/phy-rockchip-dphy-rx0/phy-rockchip-dphy-rx0.c
rename to drivers/phy/rockchip/phy-rockchip-dphy-rx0.c
diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index 71d077762698..63d3bc61b529 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -42,8 +42,6 @@ source "drivers/staging/media/tegra-video/Kconfig"
 
 source "drivers/staging/media/ipu3/Kconfig"
 
-source "drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig"
-
 source "drivers/staging/media/rkisp1/Kconfig"
 
 if MEDIA_ANALOG_TV_SUPPORT
diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makefile
index 17ececa1e095..fee9c9b2aaaf 100644
--- a/drivers/staging/media/Makefile
+++ b/drivers/staging/media/Makefile
@@ -10,6 +10,5 @@ obj-$(CONFIG_VIDEO_TEGRA)	+= tegra-video/
 obj-$(CONFIG_TEGRA_VDE)		+= tegra-vde/
 obj-$(CONFIG_VIDEO_HANTRO)	+= hantro/
 obj-$(CONFIG_VIDEO_IPU3_IMGU)	+= ipu3/
-obj-$(CONFIG_PHY_ROCKCHIP_DPHY_RX0)	+= phy-rockchip-dphy-rx0/
 obj-$(CONFIG_VIDEO_ROCKCHIP_ISP1)	+= rkisp1/
 obj-$(CONFIG_VIDEO_USBVISION)	+= usbvision/
diff --git a/drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig b/drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig
deleted file mode 100644
index fb74df829371..000000000000
--- a/drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-config PHY_ROCKCHIP_DPHY_RX0
-	tristate "Rockchip MIPI Synopsys DPHY RX0 driver"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	select GENERIC_PHY_MIPI_DPHY
-	select GENERIC_PHY
-	help
-	  Enable this to support the Rockchip MIPI Synopsys DPHY RX0
-	  associated to the Rockchip ISP module present in RK3399 SoCs.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called phy-rockchip-dphy-rx0.
diff --git a/drivers/staging/media/phy-rockchip-dphy-rx0/Makefile b/drivers/staging/media/phy-rockchip-dphy-rx0/Makefile
deleted file mode 100644
index 507e5d0593ab..000000000000
--- a/drivers/staging/media/phy-rockchip-dphy-rx0/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PHY_ROCKCHIP_DPHY_RX0)		+= phy-rockchip-dphy-rx0.o
diff --git a/drivers/staging/media/phy-rockchip-dphy-rx0/TODO b/drivers/staging/media/phy-rockchip-dphy-rx0/TODO
deleted file mode 100644
index ab612e5b27dc..000000000000
--- a/drivers/staging/media/phy-rockchip-dphy-rx0/TODO
+++ /dev/null
@@ -1,6 +0,0 @@
-The main reason for keeping this in staging is because the only driver
-that uses this is rkisp1, which is also in staging. It should be moved together
-with rkisp1.
-
-Please CC patches to Linux Media <linux-media@vger.kernel.org> and
-Helen Koike <helen.koike@collabora.com>.
-- 
2.27.0

