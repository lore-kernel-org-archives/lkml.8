Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416FCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001F72070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZXQZffHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGQBrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:47:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25782 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgGQBrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:47:35 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200717014728epoutp03a1d0d45bcb64d88fbefd6e0d57f326bb~iZvuavtCa1195611956epoutp03H
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:47:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200717014728epoutp03a1d0d45bcb64d88fbefd6e0d57f326bb~iZvuavtCa1195611956epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594950448;
        bh=7Z+XwmoCvUvvh9iHZt9klSv4JcpZHagNyaoTh8MWdmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXQZffHFFehN+J0MZXcJWbd8scn1fHdu2g50d9yPt6ss80WNNHw1CiJijWAtON29R
         wy48oi8omOYtjx5EmWNc19hUBvh3dd3hobmYZyOvwI6h9ZWMzRlCIgQQRc1NlJBclh
         sPVOSMsF8yP7eyypdAe0xsTiZKQvY0eUzuWXWWK8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200717014728epcas5p407a95f0dae44dc6345251509186a1feb~iZvtpgWen2266422664epcas5p4W;
        Fri, 17 Jul 2020 01:47:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.13.09475.F23011F5; Fri, 17 Jul 2020 10:47:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200716194407epcas5p291e5f0b9cf9da29e8f63d79289a5d2a5~iUyeLjns60038300383epcas5p2_;
        Thu, 16 Jul 2020 19:44:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200716194407epsmtrp2fdcee29154ea9b922b3e4bcd23d0b9ee~iUyeKqkEH1392113921epsmtrp2G;
        Thu, 16 Jul 2020 19:44:07 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-5e-5f11032f1b57
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.AE.08382.70EA01F5; Fri, 17 Jul 2020 04:44:07 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200716194405epsmtip18bc608c3a6f125ed8e8a4234beb58853~iUyctTuMp1985919859epsmtip1V;
        Thu, 16 Jul 2020 19:44:05 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, krzk@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v13 2/2] phy: samsung-ufs: add UFS PHY driver for samsung
 SoC
Date:   Fri, 17 Jul 2020 00:52:17 +0530
Message-Id: <20200716192217.35740-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716192217.35740-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7bCmhq4+s2C8wc+v1hYP5m1js5h/5Byr
        xYWnPWwW589vYLfY9Pgaq8XlXXPYLGac38dk0br3CLvFzjsnmB04PTat6mTz2Lyk3qNvyypG
        j+M3tjN5fN4kF8AaxWWTkpqTWZZapG+XwJVxpfUsU8GseYwVX3cdY21g3NPC2MXIySEhYCKx
        5PN1IJuLQ0hgN6PEjc2/oZxPjBJn7yxjBakSEvjGKHGwwxemY97BicwQRXsZJWb/mQHV0cIk
        8bO1gQWkik1AW+Lu9C1MILaIgIjE6pXzwIqYBf4zSux8OBVsubCAv8SiKTvYQGwWAVWJ/mOT
        mUFsXgEbif233rJDrJOXWL3hAFicU8BWYvfiF0wQNYISJ2c+AVvGDFTTvHU2M0R9L4fEv2uy
        ELaLxKdVvVBzhCVeHd8CZUtJfH63F2gvB5CdLdGzyxgiXCOxdN4xFgjbXuLAlTksICXMApoS
        63fpQ4RlJaaeWscEsZVPovf3EyaIOK/EjnkwtqpE87urUGOkJSZ2d7NC2B4S0y4+YoOE1QRG
        iZsfetkmMCrMQvLNLCTfzEJYvYCReRWjZGpBcW56arFpgXFearlecWJucWleul5yfu4mRnAa
        0vLewfjowQe9Q4xMHIyHGCU4mJVEeOe/FIgX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqv040yc
        kEB6YklqdmpqQWoRTJaJg1OqgWmlSai8ze0jS7KmdVV0LF3puvzexsebG+avmdNjd2jOblG1
        5dv8jVd8X+W44GFs7TTdqOhZCx/3z2Iy5Pfbb6i9hCH34gMeLYvJby78+X+P336lHffLqweX
        rZ4hItrVXzA3Vy5EIHvl27cW8nZqCg8q3pgzpt/X4Sw8sv2g6HpxF56pPPMV1ynlqNxNF9O/
        fKDg8fGHpyb+ZLLsf62v78Z/89BX19h3SmG5v2UKOLPPx5xxkVG/wqpu+8L2usB09fbm9U6W
        z4SDtvhtrlkQm3763XSuKf3MKwTUb/Bc+FA9w0ltW1vOzqkvGnv2yvMxijgn3pTY/vSY9bZf
        70812DDz2056X7nRgisugfO1l5USS3FGoqEWc1FxIgD1U6BXsgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnC77OoF4g6/L+SwezNvGZjH/yDlW
        iwtPe9gszp/fwG6x6fE1VovLu+awWcw4v4/JonXvEXaLnXdOMDtwemxa1cnmsXlJvUffllWM
        HsdvbGfy+LxJLoA1issmJTUnsyy1SN8ugSvjSutZpoJZ8xgrvu46xtrAuKeFsYuRk0NCwERi
        3sGJzF2MXBxCArsZJc7+v8YGkZCWuL5xAjuELSyx8t9zdoiiJiaJK5/PMoMk2AS0Je5O38IE
        YosIiEisXjmPEaSIWaCdSeLYoQlADgeHsICvxMqnVSA1LAKqEv3HJoP18grYSOy/9RZqgbzE
        6g0HwOKcArYSuxe/AJspBFSz9fpNNoh6QYmTM5+wgIxkFlCXWD9PCCTMDNTavHU28wRGwVlI
        qmYhVM1CUrWAkXkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwZGhp7mDcvuqD3iFG
        Jg7GQ4wSHMxKIrw8XLzxQrwpiZVVqUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgt
        gskycXBKNTCduz7RplG36c7W2YIhi38eWVZ5/cdq599fahKPzj9YIMxs5cO4yrXjyrqGSqvH
        lVKPpBkvT7st5Rgc25FRaPlzucf0yfG2PvJvvXaqL7DcWOS9jWu33sv5/lmNC9hOvthkn7Xi
        qOeuwyckP0zzaRFQPyTCar/5+gvXmK47c11Dpn5IL/serGPTpf7+JwvfhD2ZJ+MXJmxOT3Yv
        MlzNunBax6cJWUILt2x8/O646DGpDT8tm+YfK4+4mbtngkNIBm+69vf9Ii0+p98EzVt/97d+
        dxTj8tVt0ScERDLuzDh9f5JWkIb41PiljvbGWtmPTTufOCudqeR/Hr7a72xK2/eT/UemPFxr
        7OqgdNzKes1mJZbijERDLeai4kQA56VVl/sCAAA=
X-CMS-MailID: 20200716194407epcas5p291e5f0b9cf9da29e8f63d79289a5d2a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200716194407epcas5p291e5f0b9cf9da29e8f63d79289a5d2a5
References: <20200716192217.35740-1-alim.akhtar@samsung.com>
        <CGME20200716194407epcas5p291e5f0b9cf9da29e8f63d79289a5d2a5@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces Samsung UFS PHY driver. This driver
supports to deal with phy calibration and power control
according to UFS host driver's behavior.

[Robot: -Wmissing-prototypes and -Wsometimes-uninitialized]
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Kiwoong Kim <kwmad.kim@samsung.com>
Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 - Changes V12 -> V13
 * Addressed more review comments from Vinod [1]
 [1] https://lkml.org/lkml/2020/7/13/99
 
 - Changes V11 -> V12
 * Fixed kernel test robot warnings

 - Changes V10 -> V11
 * Addressed review comments from Vinod

 drivers/phy/samsung/Kconfig           |   9 +
 drivers/phy/samsung/Makefile          |   1 +
 drivers/phy/samsung/phy-exynos7-ufs.h |  81 ++++++
 drivers/phy/samsung/phy-samsung-ufs.c | 366 ++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.h | 139 ++++++++++
 5 files changed, 596 insertions(+)
 create mode 100644 drivers/phy/samsung/phy-exynos7-ufs.h
 create mode 100644 drivers/phy/samsung/phy-samsung-ufs.c
 create mode 100644 drivers/phy/samsung/phy-samsung-ufs.h

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 19f2e3119343..e20d2fcc9fe7 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -29,6 +29,15 @@ config PHY_EXYNOS_PCIE
 	  Enable PCIe PHY support for Exynos SoC series.
 	  This driver provides PHY interface for Exynos PCIe controller.
 
+config PHY_SAMSUNG_UFS
+	tristate "SAMSUNG SoC series UFS PHY driver"
+	depends on OF && (ARCH_EXYNOS || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable this to support the Samsung UFS PHY driver for
+	  Samsung SoCs. This driver provides the interface for UFS
+	  host controller to do PHY related programming.
+
 config PHY_SAMSUNG_USB2
 	tristate "Samsung USB 2.0 PHY driver"
 	depends on HAS_IOMEM
diff --git a/drivers/phy/samsung/Makefile b/drivers/phy/samsung/Makefile
index db9b1aa0de6e..3959100fe8a2 100644
--- a/drivers/phy/samsung/Makefile
+++ b/drivers/phy/samsung/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
 obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
 obj-$(CONFIG_PHY_EXYNOS_PCIE)		+= phy-exynos-pcie.o
+obj-$(CONFIG_PHY_SAMSUNG_UFS)		+= phy-samsung-ufs.o
 obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
 phy-exynos-usb2-y			+= phy-samsung-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
diff --git a/drivers/phy/samsung/phy-exynos7-ufs.h b/drivers/phy/samsung/phy-exynos7-ufs.h
new file mode 100644
index 000000000000..518923141958
--- /dev/null
+++ b/drivers/phy/samsung/phy-exynos7-ufs.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UFS PHY driver data for Samsung EXYNOS7 SoC
+ *
+ * Copyright (C) 2020 Samsung Electronics Co., Ltd.
+ */
+#ifndef _PHY_EXYNOS7_UFS_H_
+#define _PHY_EXYNOS7_UFS_H_
+
+#include "phy-samsung-ufs.h"
+
+#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL	0x720
+#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK	0x1
+#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN	BIT(0)
+
+/* Calibration for phy initialization */
+static const struct samsung_ufs_phy_cfg exynos7_pre_init_cfg[] = {
+	PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x010, 0x82, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x011, 0x1e, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x017, 0x84, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x035, 0x58, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x036, 0x32, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x037, 0x40, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x03b, 0x83, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x042, 0x88, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x043, 0xa6, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x048, 0x74, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x04c, 0x5b, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x04d, 0x83, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x05c, 0x14, PWR_MODE_ANY),
+	END_UFS_PHY_CFG
+};
+
+/* Calibration for HS mode series A/B */
+static const struct samsung_ufs_phy_cfg exynos7_pre_pwr_hs_cfg[] = {
+	PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_HS_ANY),
+	PHY_COMN_REG_CFG(0x010, 0x82, PWR_MODE_HS_ANY),
+	PHY_COMN_REG_CFG(0x011, 0x1e, PWR_MODE_HS_ANY),
+	/* Setting order: 1st(0x16, 2nd(0x15) */
+	PHY_COMN_REG_CFG(0x016, 0xff, PWR_MODE_HS_ANY),
+	PHY_COMN_REG_CFG(0x015, 0x80, PWR_MODE_HS_ANY),
+	PHY_COMN_REG_CFG(0x017, 0x94, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG(0x036, 0x32, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG(0x037, 0x43, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG(0x038, 0x3f, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG(0x042, 0x88, PWR_MODE_HS_G2_SER_A),
+	PHY_TRSV_REG_CFG(0x042, 0xbb, PWR_MODE_HS_G2_SER_B),
+	PHY_TRSV_REG_CFG(0x043, 0xa6, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG(0x048, 0x74, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG(0x034, 0x35, PWR_MODE_HS_G2_SER_A),
+	PHY_TRSV_REG_CFG(0x034, 0x36, PWR_MODE_HS_G2_SER_B),
+	PHY_TRSV_REG_CFG(0x035, 0x5b, PWR_MODE_HS_G2_SER_A),
+	PHY_TRSV_REG_CFG(0x035, 0x5c, PWR_MODE_HS_G2_SER_B),
+	END_UFS_PHY_CFG
+};
+
+/* Calibration for HS mode series A/B atfer PMC */
+static const struct samsung_ufs_phy_cfg exynos7_post_pwr_hs_cfg[] = {
+	PHY_COMN_REG_CFG(0x015, 0x00, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG(0x04d, 0x83, PWR_MODE_HS_ANY),
+	END_UFS_PHY_CFG
+};
+
+static const struct samsung_ufs_phy_cfg *exynos7_ufs_phy_cfgs[CFG_TAG_MAX] = {
+	[CFG_PRE_INIT]		= exynos7_pre_init_cfg,
+	[CFG_PRE_PWR_HS]	= exynos7_pre_pwr_hs_cfg,
+	[CFG_POST_PWR_HS]	= exynos7_post_pwr_hs_cfg,
+};
+
+static struct samsung_ufs_phy_drvdata exynos7_ufs_phy = {
+	.cfg = exynos7_ufs_phy_cfgs,
+	.isol = {
+		.offset = EXYNOS7_EMBEDDED_COMBO_PHY_CTRL,
+		.mask = EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK,
+		.en = EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN,
+	},
+	.has_symbol_clk = 1,
+};
+
+#endif /* _PHY_EXYNOS7_UFS_H_ */
diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
new file mode 100644
index 000000000000..43ef77d1d96c
--- /dev/null
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UFS PHY driver for Samsung SoC
+ *
+ * Copyright (C) 2020 Samsung Electronics Co., Ltd.
+ * Author: Seungwon Jeon <essuuj@gmail.com>
+ * Author: Alim Akhtar <alim.akhtar@samsung.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "phy-samsung-ufs.h"
+
+#define for_each_phy_lane(phy, i) \
+	for (i = 0; i < (phy)->lane_cnt; i++)
+#define for_each_phy_cfg(cfg) \
+	for (; (cfg)->id; (cfg)++)
+
+#define PHY_DEF_LANE_CNT	1
+
+static void samsung_ufs_phy_config(struct samsung_ufs_phy *phy,
+				   const struct samsung_ufs_phy_cfg *cfg,
+				   u8 lane)
+{
+	enum {LANE_0, LANE_1}; /* lane index */
+
+	switch (lane) {
+	case LANE_0:
+		writel(cfg->val, (phy)->reg_pma + cfg->off_0);
+		break;
+	case LANE_1:
+		if (cfg->id == PHY_TRSV_BLK)
+			writel(cfg->val, (phy)->reg_pma + cfg->off_1);
+		break;
+	}
+}
+
+static int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy)
+{
+	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
+	const unsigned int timeout_us = 100000;
+	const unsigned int sleep_us = 10;
+	u32 val;
+	int err;
+
+	err = readl_poll_timeout(
+			ufs_phy->reg_pma + PHY_APB_ADDR(PHY_PLL_LOCK_STATUS),
+			val, (val & PHY_PLL_LOCK_BIT), sleep_us, timeout_us);
+	if (err) {
+		dev_err(ufs_phy->dev,
+			"failed to get phy pll lock acquisition %d\n", err);
+		goto out;
+	}
+
+	err = readl_poll_timeout(
+			ufs_phy->reg_pma + PHY_APB_ADDR(PHY_CDR_LOCK_STATUS),
+			val, (val & PHY_CDR_LOCK_BIT), sleep_us, timeout_us);
+	if (err)
+		dev_err(ufs_phy->dev,
+			"failed to get phy cdr lock acquisition %d\n", err);
+out:
+	return err;
+}
+
+static int samsung_ufs_phy_calibrate(struct phy *phy)
+{
+	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
+	struct samsung_ufs_phy_cfg **cfgs = ufs_phy->cfg;
+	const struct samsung_ufs_phy_cfg *cfg;
+	int err = 0;
+	int i;
+
+	if (unlikely(ufs_phy->ufs_phy_state < CFG_PRE_INIT ||
+		     ufs_phy->ufs_phy_state >= CFG_TAG_MAX)) {
+		dev_err(ufs_phy->dev, "invalid phy config index %d\n", ufs_phy->ufs_phy_state);
+		return -EINVAL;
+	}
+
+	cfg = cfgs[ufs_phy->ufs_phy_state];
+	if (!cfg)
+		goto out;
+
+	for_each_phy_cfg(cfg) {
+		for_each_phy_lane(ufs_phy, i) {
+			samsung_ufs_phy_config(ufs_phy, cfg, i);
+		}
+	}
+
+	if (ufs_phy->ufs_phy_state == CFG_POST_PWR_HS)
+		err = samsung_ufs_phy_wait_for_lock_acq(phy);
+
+	/**
+	 * In Samsung ufshci, PHY need to be calibrated at different
+	 * stages / state mainly before Linkstartup, after Linkstartup,
+	 * before power mode change and after power mode change.
+	 * Below state machine to make sure to calibrate PHY in each
+	 * state. Here after configuring PHY in a given state, will
+	 * change the state to next state so that next state phy
+	 * calibration value can be programed
+	 */
+out:
+	switch (ufs_phy->ufs_phy_state) {
+	case CFG_PRE_INIT:
+		ufs_phy->ufs_phy_state = CFG_POST_INIT;
+		break;
+	case CFG_POST_INIT:
+		ufs_phy->ufs_phy_state = CFG_PRE_PWR_HS;
+		break;
+	case CFG_PRE_PWR_HS:
+		ufs_phy->ufs_phy_state = CFG_POST_PWR_HS;
+		break;
+	case CFG_POST_PWR_HS:
+		/* Change back to INIT state */
+		ufs_phy->ufs_phy_state = CFG_PRE_INIT;
+		break;
+	default:
+		dev_err(ufs_phy->dev, "wrong state for phy calibration\n");
+	}
+
+	return err;
+}
+
+static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy *phy)
+{
+	int ret;
+
+	phy->tx0_symbol_clk = devm_clk_get(phy->dev, "tx0_symbol_clk");
+	if (IS_ERR(phy->tx0_symbol_clk)) {
+		dev_err(phy->dev, "failed to get tx0_symbol_clk clock\n");
+		return PTR_ERR(phy->tx0_symbol_clk);
+	}
+
+	phy->rx0_symbol_clk = devm_clk_get(phy->dev, "rx0_symbol_clk");
+	if (IS_ERR(phy->rx0_symbol_clk)) {
+		dev_err(phy->dev, "failed to get rx0_symbol_clk clock\n");
+		return PTR_ERR(phy->rx0_symbol_clk);
+	}
+
+	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
+	if (IS_ERR(phy->rx0_symbol_clk)) {
+		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
+		return PTR_ERR(phy->rx1_symbol_clk);
+	}
+
+	ret = clk_prepare_enable(phy->tx0_symbol_clk);
+	if (ret) {
+		dev_err(phy->dev, "%s: tx0_symbol_clk enable failed %d\n", __func__, ret);
+		goto out;
+	}
+
+	ret = clk_prepare_enable(phy->rx0_symbol_clk);
+	if (ret) {
+		dev_err(phy->dev, "%s: rx0_symbol_clk enable failed %d\n", __func__, ret);
+		goto out_disable_tx0_clk;
+	}
+
+	ret = clk_prepare_enable(phy->rx1_symbol_clk);
+	if (ret) {
+		dev_err(phy->dev, "%s: rx1_symbol_clk enable failed %d\n", __func__, ret);
+		goto out_disable_rx0_clk;
+	}
+
+	return 0;
+
+out_disable_rx0_clk:
+	clk_disable_unprepare(phy->rx0_symbol_clk);
+out_disable_tx0_clk:
+	clk_disable_unprepare(phy->tx0_symbol_clk);
+out:
+	return ret;
+}
+
+static int samsung_ufs_phy_clks_init(struct samsung_ufs_phy *phy)
+{
+	int ret;
+
+	phy->ref_clk = devm_clk_get(phy->dev, "ref_clk");
+	if (IS_ERR(phy->ref_clk))
+		dev_err(phy->dev, "failed to get ref_clk clock\n");
+
+	ret = clk_prepare_enable(phy->ref_clk);
+	if (ret) {
+		dev_err(phy->dev, "%s: ref_clk enable failed %d\n", __func__, ret);
+		return ret;
+	}
+
+	dev_dbg(phy->dev, "UFS MPHY ref_clk_rate = %ld\n", clk_get_rate(phy->ref_clk));
+
+	return 0;
+}
+
+static int samsung_ufs_phy_init(struct phy *phy)
+{
+	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
+	int ret;
+
+	ss_phy->lane_cnt = phy->attrs.bus_width;
+	ss_phy->ufs_phy_state = CFG_PRE_INIT;
+
+	if (ss_phy->drvdata->has_symbol_clk) {
+		ret = samsung_ufs_phy_symbol_clk_init(ss_phy);
+		if (ret)
+			dev_err(ss_phy->dev, "failed to set ufs phy symbol clocks\n");
+	}
+
+	ret = samsung_ufs_phy_clks_init(ss_phy);
+	if (ret)
+		dev_err(ss_phy->dev, "failed to set ufs phy clocks\n");
+
+	ret = samsung_ufs_phy_calibrate(phy);
+	if (ret)
+		dev_err(ss_phy->dev, "ufs phy calibration failed\n");
+
+	return ret;
+}
+
+static int samsung_ufs_phy_power_on(struct phy *phy)
+{
+	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
+
+	samsung_ufs_phy_ctrl_isol(ss_phy, false);
+	return 0;
+}
+
+static int samsung_ufs_phy_power_off(struct phy *phy)
+{
+	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
+
+	samsung_ufs_phy_ctrl_isol(ss_phy, true);
+	return 0;
+}
+
+static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
+				    enum phy_mode mode, int submode)
+{
+	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(generic_phy);
+
+	ss_phy->mode = PHY_MODE_INVALID;
+
+	if (mode > 0)
+		ss_phy->mode = mode;
+
+	return 0;
+}
+
+static int samsung_ufs_phy_exit(struct phy *phy)
+{
+	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
+
+	clk_disable_unprepare(ss_phy->ref_clk);
+
+	if (ss_phy->drvdata->has_symbol_clk) {
+		clk_disable_unprepare(ss_phy->tx0_symbol_clk);
+		clk_disable_unprepare(ss_phy->rx0_symbol_clk);
+		clk_disable_unprepare(ss_phy->rx1_symbol_clk);
+	}
+
+	return 0;
+}
+
+static struct phy_ops samsung_ufs_phy_ops = {
+	.init		= samsung_ufs_phy_init,
+	.exit		= samsung_ufs_phy_exit,
+	.power_on	= samsung_ufs_phy_power_on,
+	.power_off	= samsung_ufs_phy_power_off,
+	.calibrate	= samsung_ufs_phy_calibrate,
+	.set_mode	= samsung_ufs_phy_set_mode,
+	.owner          = THIS_MODULE,
+};
+
+static const struct of_device_id samsung_ufs_phy_match[];
+
+static int samsung_ufs_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct samsung_ufs_phy *phy;
+	struct phy *gen_phy;
+	struct phy_provider *phy_provider;
+	const struct samsung_ufs_phy_drvdata *drvdata;
+	int err = 0;
+
+	match = of_match_node(samsung_ufs_phy_match, dev->of_node);
+	if (!match) {
+		err = -EINVAL;
+		dev_err(dev, "failed to get match_node\n");
+		goto out;
+	}
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	phy->reg_pma = devm_platform_ioremap_resource_byname(pdev, "phy-pma");
+	if (IS_ERR(phy->reg_pma)) {
+		err = PTR_ERR(phy->reg_pma);
+		goto out;
+	}
+
+	phy->reg_pmu = syscon_regmap_lookup_by_phandle(
+				dev->of_node, "samsung,pmu-syscon");
+	if (IS_ERR(phy->reg_pmu)) {
+		err = PTR_ERR(phy->reg_pmu);
+		dev_err(dev, "failed syscon remap for pmu\n");
+		goto out;
+	}
+
+	gen_phy = devm_phy_create(dev, NULL, &samsung_ufs_phy_ops);
+	if (IS_ERR(gen_phy)) {
+		err = PTR_ERR(gen_phy);
+		dev_err(dev, "failed to create PHY for ufs-phy\n");
+		goto out;
+	}
+
+	drvdata = match->data;
+	phy->dev = dev;
+	phy->drvdata = drvdata;
+	phy->cfg = (struct samsung_ufs_phy_cfg **)drvdata->cfg;
+	phy->isol = &drvdata->isol;
+	phy->lane_cnt = PHY_DEF_LANE_CNT;
+
+	phy_set_drvdata(gen_phy, phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		err = PTR_ERR(phy_provider);
+		dev_err(dev, "failed to register phy-provider\n");
+		goto out;
+	}
+out:
+	return err;
+}
+
+static const struct of_device_id samsung_ufs_phy_match[] = {
+	{
+		.compatible = "samsung,exynos7-ufs-phy",
+		.data = &exynos7_ufs_phy,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, samsung_ufs_phy_match);
+
+static struct platform_driver samsung_ufs_phy_driver = {
+	.probe  = samsung_ufs_phy_probe,
+	.driver = {
+		.name = "samsung-ufs-phy",
+		.of_match_table = samsung_ufs_phy_match,
+	},
+};
+module_platform_driver(samsung_ufs_phy_driver);
+MODULE_DESCRIPTION("Samsung SoC UFS PHY Driver");
+MODULE_AUTHOR("Seungwon Jeon <essuuj@gmail.com>");
+MODULE_AUTHOR("Alim Akhtar <alim.akhtar@samsung.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/phy-samsung-ufs.h
new file mode 100644
index 000000000000..5de78710524c
--- /dev/null
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UFS PHY driver for Samsung EXYNOS SoC
+ *
+ * Copyright (C) 2020 Samsung Electronics Co., Ltd.
+ * Author: Seungwon Jeon <essuuj@gmail.com>
+ * Author: Alim Akhtar <alim.akhtar@samsung.com>
+ *
+ */
+#ifndef _PHY_SAMSUNG_UFS_
+#define _PHY_SAMSUNG_UFS_
+
+#define PHY_COMN_BLK	1
+#define PHY_TRSV_BLK	2
+#define END_UFS_PHY_CFG { 0 }
+#define PHY_TRSV_CH_OFFSET	0x30
+#define PHY_APB_ADDR(off)	((off) << 2)
+
+#define PHY_COMN_REG_CFG(o, v, d) {	\
+	.off_0 = PHY_APB_ADDR((o)),	\
+	.off_1 = 0,		\
+	.val = (v),		\
+	.desc = (d),		\
+	.id = PHY_COMN_BLK,	\
+}
+
+#define PHY_TRSV_REG_CFG(o, v, d) {	\
+	.off_0 = PHY_APB_ADDR((o)),	\
+	.off_1 = PHY_APB_ADDR((o) + PHY_TRSV_CH_OFFSET),	\
+	.val = (v),		\
+	.desc = (d),		\
+	.id = PHY_TRSV_BLK,	\
+}
+
+/* UFS PHY registers */
+#define PHY_PLL_LOCK_STATUS	0x1e
+#define PHY_CDR_LOCK_STATUS	0x5e
+
+#define PHY_PLL_LOCK_BIT	BIT(5)
+#define PHY_CDR_LOCK_BIT	BIT(4)
+
+/* description for PHY calibration */
+enum {
+	/* applicable to any */
+	PWR_DESC_ANY	= 0,
+	/* mode */
+	PWR_DESC_PWM	= 1,
+	PWR_DESC_HS	= 2,
+	/* series */
+	PWR_DESC_SER_A	= 1,
+	PWR_DESC_SER_B	= 2,
+	/* gear */
+	PWR_DESC_G1	= 1,
+	PWR_DESC_G2	= 2,
+	PWR_DESC_G3	= 3,
+	/* field mask */
+	MD_MASK		= 0x3,
+	SR_MASK		= 0x3,
+	GR_MASK		= 0x7,
+};
+
+#define PWR_MODE_HS_G1_ANY	PWR_MODE_HS(PWR_DESC_G1, PWR_DESC_ANY)
+#define PWR_MODE_HS_G1_SER_A	PWR_MODE_HS(PWR_DESC_G1, PWR_DESC_SER_A)
+#define PWR_MODE_HS_G1_SER_B	PWR_MODE_HS(PWR_DESC_G1, PWR_DESC_SER_B)
+#define PWR_MODE_HS_G2_ANY	PWR_MODE_HS(PWR_DESC_G2, PWR_DESC_ANY)
+#define PWR_MODE_HS_G2_SER_A	PWR_MODE_HS(PWR_DESC_G2, PWR_DESC_SER_A)
+#define PWR_MODE_HS_G2_SER_B	PWR_MODE_HS(PWR_DESC_G2, PWR_DESC_SER_B)
+#define PWR_MODE_HS_G3_ANY	PWR_MODE_HS(PWR_DESC_G3, PWR_DESC_ANY)
+#define PWR_MODE_HS_G3_SER_A	PWR_MODE_HS(PWR_DESC_G3, PWR_DESC_SER_A)
+#define PWR_MODE_HS_G3_SER_B	PWR_MODE_HS(PWR_DESC_G3, PWR_DESC_SER_B)
+#define PWR_MODE(g, s, m)	((((g) & GR_MASK) << 4) |\
+				 (((s) & SR_MASK) << 2) | ((m) & MD_MASK))
+#define PWR_MODE_PWM_ANY	PWR_MODE(PWR_DESC_ANY,\
+					 PWR_DESC_ANY, PWR_DESC_PWM)
+#define PWR_MODE_HS(g, s)	((((g) & GR_MASK) << 4) |\
+				 (((s) & SR_MASK) << 2) | PWR_DESC_HS)
+#define PWR_MODE_HS_ANY		PWR_MODE(PWR_DESC_ANY,\
+					 PWR_DESC_ANY, PWR_DESC_HS)
+#define PWR_MODE_ANY		PWR_MODE(PWR_DESC_ANY,\
+					 PWR_DESC_ANY, PWR_DESC_ANY)
+/* PHY calibration point/state */
+enum {
+	CFG_PRE_INIT,
+	CFG_POST_INIT,
+	CFG_PRE_PWR_HS,
+	CFG_POST_PWR_HS,
+	CFG_TAG_MAX,
+};
+
+struct samsung_ufs_phy_cfg {
+	u32 off_0;
+	u32 off_1;
+	u32 val;
+	u8 desc;
+	u8 id;
+};
+
+struct samsung_ufs_phy_drvdata {
+	const struct samsung_ufs_phy_cfg **cfg;
+	struct pmu_isol {
+		u32 offset;
+		u32 mask;
+		u32 en;
+	} isol;
+	bool has_symbol_clk;
+};
+
+struct samsung_ufs_phy {
+	struct device *dev;
+	void __iomem *reg_pma;
+	struct regmap *reg_pmu;
+	struct clk *ref_clk;
+	struct clk *ref_clk_parent;
+	struct clk *tx0_symbol_clk;
+	struct clk *rx0_symbol_clk;
+	struct clk *rx1_symbol_clk;
+	const struct samsung_ufs_phy_drvdata *drvdata;
+	struct samsung_ufs_phy_cfg **cfg;
+	const struct pmu_isol *isol;
+	u8 lane_cnt;
+	int ufs_phy_state;
+	enum phy_mode mode;
+};
+
+static inline struct samsung_ufs_phy *get_samsung_ufs_phy(struct phy *phy)
+{
+	return (struct samsung_ufs_phy *)phy_get_drvdata(phy);
+}
+
+static inline void samsung_ufs_phy_ctrl_isol(
+		struct samsung_ufs_phy *phy, u32 isol)
+{
+	regmap_update_bits(phy->reg_pmu, phy->isol->offset,
+			   phy->isol->mask, isol ? 0 : phy->isol->en);
+}
+
+#include "phy-exynos7-ufs.h"
+
+#endif /* _PHY_SAMSUNG_UFS_ */
-- 
2.17.1

