Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B819C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625C920B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tXxq7ue2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGCClX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:41:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34950 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgGCClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:41:20 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200703024113epoutp045380d737ef1d92a831e3a3748790fb64~eHcqBcv521643716437epoutp04I
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:41:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200703024113epoutp045380d737ef1d92a831e3a3748790fb64~eHcqBcv521643716437epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593744073;
        bh=lPWTF24cvm/3DJPB+QhAM1qfh+SIRCNLK8HrkJ562sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXxq7ue2NwRvR3BGDH/k5i4aPPJ0sLXN3zq5CBGZdacCnLef3cxsQs0S3j3n+ucDN
         93k6aVCrB4Ly1ImOyVQGIyzPBrMGCcqkPqHoVOlQB/b6CXMougR4fN7qaZTSE2kzNq
         wtuvnPoTWLDtWg+ZMt94k5iMjthYG3rIt0MuF/A0=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200703024112epcas5p13e69ae8187d4ac15ed0da3aff4748e01~eHcpE88ef2011320113epcas5p1L;
        Fri,  3 Jul 2020 02:41:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.1A.09467.8CA9EFE5; Fri,  3 Jul 2020 11:41:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200703024112epcas5p326e2e16f659242b1beb2db581043a0c8~eHcoeRqAb0693606936epcas5p3t;
        Fri,  3 Jul 2020 02:41:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703024112epsmtrp2f6f2113c4f94229247c795cd14434da1~eHcodPZx10790007900epsmtrp2Z;
        Fri,  3 Jul 2020 02:41:12 +0000 (GMT)
X-AuditID: b6c32a49-a3fff700000024fb-6f-5efe9ac8de06
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.9D.08303.7CA9EFE5; Fri,  3 Jul 2020 11:41:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703024110epsmtip1236cdfc2c2e5653fd49e59a5266b85b6~eHcmzNtdz2726127261epsmtip1A;
        Fri,  3 Jul 2020 02:41:10 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, krzk@kernel.org, kwmad.kim@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kishon@ti.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v11 2/2] phy: samsung-ufs: add UFS PHY driver for samsung
 SoC
Date:   Fri,  3 Jul 2020 07:51:03 +0530
Message-Id: <20200703022103.41849-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703022103.41849-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7bCmuu6JWf/iDG59ULF4MG8bm8X8I+dY
        LS487WGzOH9+A7vFzS1HWSw2Pb7GanF51xw2ixnn9zFZtO49wm6x884JZgcuj02rOtk8Ni+p
        9+jbsorR4/iN7UwenzfJBbBGcdmkpOZklqUW6dslcGWsnbiYqeDxbMaKRT33GBsYNzYxdjFy
        ckgImEj8v3yGtYuRi0NIYDejxJ+fvWAJIYFPjBItjfoQic+MEqcbHrF0MXKAdZycrAsR38Uo
        Me3lVCYIp4VJYt2VJnaQbjYBbYm707cwgdgiAiISq1fOYwQpYhb4yyix7fpHVpCEsIC/xMO5
        y8EaWARUJbbc2MsCYvMK2Ej07XnJCnGfvMTqDQeYQWxOAVuJfaunMkPUCEqcnPkErJ4ZqKZ5
        62xmkAUSAlM5JPZvegPV7CLx+/9yKFtY4tXxLewQtpTE53d72SDeyZbo2WUMEa6RWDrvGAuE
        bS9x4MocsI+ZBTQl1u/Sh1jFJ9H7+wkTRCevREebEES1qkTzu6tQndISE7u7oZZ6SCw+thUa
        uhMYJe5d7mGdwCg/C8kHs5B8MAth2wJG5lWMkqkFxbnpqcWmBYZ5qeV6xYm5xaV56XrJ+bmb
        GMFpR8tzB+PdBx/0DjEycTAeYpTgYFYS4U1Q/RcnxJuSWFmVWpQfX1Sak1p8iFGag0VJnFfp
        x5k4IYH0xJLU7NTUgtQimCwTB6dUAxPTBa8l1yyvFxxMairk8fFLSg/tuF1+ZqFZ65EHTbq2
        ducezncOjvRwuGUSKfXv942f3LV5Rvf1dhzlYq7oKPk/m2XHufd2sSvvBR+/uFH5c+weTaeK
        CV4btDResKZ9W/6uJ+b5h5b3d95dc0uWnxfeMf02T4ZHS4ks37qG544PL76yujdpjfpusXDJ
        L27ncpc2vT30YeXTM/vOK+7qbDvaxhRpafrN+03qljPn+DfpNJlMSIif+K+4gCHu1Pz9eR+X
        p77ZkxN7Y2p4+pzI53kHm23D79j7K67yLl9YOdtnXvPR5eKq1wJXHBa/OslvWXe7DdORSeul
        0zaf4Qsv35r0QWDTYbb7ah+jp/39dGW1EktxRqKhFnNRcSIApyf/1qoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnO7xWf/iDBYttrJ4MG8bm8X8I+dY
        LS487WGzOH9+A7vFzS1HWSw2Pb7GanF51xw2ixnn9zFZtO49wm6x884JZgcuj02rOtk8Ni+p
        9+jbsorR4/iN7UwenzfJBbBGcdmkpOZklqUW6dslcGWsnbiYqeDxbMaKRT33GBsYNzYxdjFy
        cEgImEicnKzbxcjJISSwg1Fi9g4/EFtCQFri+sYJ7BC2sMTKf8+BbC6gmiYmiWW7uthAEmwC
        2hJ3p29hArFFBEQkVq+cxwhSxCzQziRx/fsBsISwgK/En8ctrCA2i4CqxJYbe1lAbF4BG4m+
        PS9ZITbIS6zecIAZxOYUsJXYt3oqM8RFNhJf3l2EqheUODnzCQvI0cwC6hLr5wmBhJmBWpu3
        zmaewCg4C0nVLISqWUiqFjAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4QLa0d
        jHtWfdA7xMjEwXiIUYKDWUmEN0H1X5wQb0piZVVqUX58UWlOavEhRmkOFiVx3q+zFsYJCaQn
        lqRmp6YWpBbBZJk4OKUamIrTP1Y81Z/8amXevfkTO/+Waac56k7u+dZ1bd2buzvmTRe6veHE
        Y64pS7+cjU+e85bb9q2L/pS3b7lCuozf5/Rkn//7te+LTf/ZyPx/XgvV39cV3V+h/P2E8WzO
        eofZAZVTWA0810rMDD3jci/TMWeqxbsy9uORzXt2Tmf8+srHIKBw40QzjR7hY3cU7Jjnz5mi
        9vDmVoOvGkZOfFaFa4w/rZNhFnnNuaqnh1u6VpWx7aDmTMclC61e9TJ8zAszvfs2Y+k52TDx
        9CXOiXzviyM5X59iPCa2N/4KL/veJCMu15dr+8QYYvIvtsvO2nb+8YpXW8o8s+RTmaLPm3dc
        ZHA7JLF4VqX8De9F1QdZdJRYijMSDbWYi4oTASl75VD/AgAA
X-CMS-MailID: 20200703024112epcas5p326e2e16f659242b1beb2db581043a0c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200703024112epcas5p326e2e16f659242b1beb2db581043a0c8
References: <20200703022103.41849-1-alim.akhtar@samsung.com>
        <CGME20200703024112epcas5p326e2e16f659242b1beb2db581043a0c8@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces Samsung UFS PHY driver. This driver
supports to deal with phy calibration and power control
according to UFS host driver's behavior.

[Robot: -Wmissing-prototypes]
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Kiwoong Kim <kwmad.kim@samsung.com>
Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 Change log V10 -> V11
 * Addressed review comments from Vinod.
 * minor clean up

 drivers/phy/samsung/Kconfig           |   9 +
 drivers/phy/samsung/Makefile          |   1 +
 drivers/phy/samsung/phy-exynos7-ufs.h |  86 +++++++
 drivers/phy/samsung/phy-samsung-ufs.c | 357 ++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.h | 139 ++++++++++
 5 files changed, 592 insertions(+)
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
index 000000000000..c4aab792d30e
--- /dev/null
+++ b/drivers/phy/samsung/phy-exynos7-ufs.h
@@ -0,0 +1,86 @@
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
+static const struct samsung_ufs_phy_cfg exynos7_post_init_cfg[] = {
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
+	[CFG_POST_INIT]		= exynos7_post_init_cfg,
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
index 000000000000..c0e6411abbc6
--- /dev/null
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -0,0 +1,357 @@
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
+out:
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
+		goto out;
+	}
+
+	phy->rx0_symbol_clk = devm_clk_get(phy->dev, "rx0_symbol_clk");
+	if (IS_ERR(phy->rx0_symbol_clk)) {
+		dev_err(phy->dev, "failed to get rx0_symbol_clk clock\n");
+		goto out;
+	}
+
+	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
+	if (IS_ERR(phy->rx0_symbol_clk)) {
+		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
+		goto out;
+	}
+
+	ret = clk_prepare_enable(phy->tx0_symbol_clk);
+	if (ret) {
+		dev_err(phy->dev, "%s: tx0_symbol_clk enable failed %d\n", __func__, ret);
+		goto out;
+	}
+	ret = clk_prepare_enable(phy->rx0_symbol_clk);
+	if (ret) {
+		dev_err(phy->dev, "%s: rx0_symbol_clk enable failed %d\n", __func__, ret);
+		clk_disable_unprepare(phy->tx0_symbol_clk);
+		goto out;
+	}
+	ret = clk_prepare_enable(phy->rx1_symbol_clk);
+	if (ret) {
+		dev_err(phy->dev, "%s: rx1_symbol_clk enable failed %d\n", __func__, ret);
+		clk_disable_unprepare(phy->tx0_symbol_clk);
+		clk_disable_unprepare(phy->rx0_symbol_clk);
+	}
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
+	dev_info(phy->dev, "UFS MPHY ref_clk_rate = %ld\n", clk_get_rate(phy->ref_clk));
+
+	return 0;
+}
+
+static int samsung_ufs_phy_init(struct phy *phy)
+{
+	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
+	int ret;
+
+	_phy->lane_cnt = phy->attrs.bus_width;
+	_phy->ufs_phy_state = CFG_PRE_INIT;
+
+	if (_phy->drvdata->has_symbol_clk) {
+		ret = samsung_ufs_phy_symbol_clk_init(_phy);
+		if (ret)
+			dev_err(_phy->dev, "failed to set ufs phy symbol clocks\n");
+	}
+
+	ret = samsung_ufs_phy_clks_init(_phy);
+	if (ret)
+		dev_err(_phy->dev, "failed to set ufs phy  clocks\n");
+
+	samsung_ufs_phy_calibrate(phy);
+
+	return 0;
+}
+
+static int samsung_ufs_phy_power_on(struct phy *phy)
+{
+	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
+
+	samsung_ufs_phy_ctrl_isol(_phy, false);
+	return 0;
+}
+
+static int samsung_ufs_phy_power_off(struct phy *phy)
+{
+	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
+
+	samsung_ufs_phy_ctrl_isol(_phy, true);
+	return 0;
+}
+
+static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
+				    enum phy_mode mode, int submode)
+{
+	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(generic_phy);
+
+	_phy->mode = PHY_MODE_INVALID;
+
+	if (mode > 0)
+		_phy->mode = mode;
+
+	return 0;
+}
+
+static int samsung_ufs_phy_exit(struct phy *phy)
+{
+	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
+
+	clk_disable_unprepare(_phy->ref_clk);
+
+	if (_phy->drvdata->has_symbol_clk) {
+		clk_disable_unprepare(_phy->tx0_symbol_clk);
+		clk_disable_unprepare(_phy->rx0_symbol_clk);
+		clk_disable_unprepare(_phy->rx1_symbol_clk);
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

