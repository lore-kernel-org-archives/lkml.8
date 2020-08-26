Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A9DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD742078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cc4TtiVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHZSpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:45:10 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:11411
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbgHZSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgehubZpbjEenMqN6KYVHEWRwBtMBhP052qkunHjRIw4ch66mADcOvJH7+TAYNVyQjkE0JJlWQ4wjWyC8Z5NCC6nmQ77ugvlMVI4+DlJlrbhd7ynerPgXGyaFj+fap6TdM9RhjlB4AwqIKKl9/Y2NeMRUUDZP3KdYJrpH232zTAFMxssU2ZpWr96wuZRsl0zIrJmUSbIB060Bzp59kvZcFjlMd0nS7CKLU1wICTcdVj0RslcpIw/yX6n6vTZ+2XOxc22/FanRzinGbbTNmsE+T3ef0AExuZGiAkmj+WmtSehNf7P6ew/TIrhUqGiawpwLA2hkV87RoUm+tVHmikFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+DpTDFZ7qdrpKpkIT3yONwCFRVtl8Tm6t+ZR5wKv6o=;
 b=UQtdXLSWkscKS7XLZFBg8KWRnVoBAK5cztsmzDvESV6hoSv1PY84z/dSdWx4tecMxSB3SkKL52PIDwSJMlJhcgDbE8Pcc3bYEaP8A/DoEgVQle5++XU4GcnnTo88oxbyXRiUJ1UGL7jom1oB6QFVjy8vF8Uxb1xKXuordXlP///YmInGcpZ3NDrKQkAFtw+beg7IgEfrgAguUzY+/x+3LdRm9405NYzapJBLgwnggHg591A7OGLcuLP0zVhwRRSLwVagS2bnwvo61pA6ou06TQg/vJ9dltm5eC4I8+2a608apsRZZcXfaL29xHGT+AUQdn40098qjHRXYglbTB5BVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+DpTDFZ7qdrpKpkIT3yONwCFRVtl8Tm6t+ZR5wKv6o=;
 b=cc4TtiVnHAPWKtlN/ZNTT7NWplX1R3Eu/aoW369GSc1A24yHBZ4wKRZ7SzMHdiLrwiKT9/f5icYg/zq/H4q+eMLshiN65yvgAUArQqnxvV34MTQKC2EUrMYlu9FSzq1IzIgN3UgDTBXkxMMkv69aH4A7grvA4npQVpbfOG9OkUE=
Received: from CY4PR08CA0041.namprd08.prod.outlook.com (2603:10b6:903:151::27)
 by BN6PR02MB2787.namprd02.prod.outlook.com (2603:10b6:404:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 18:45:02 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:151:cafe::74) by CY4PR08CA0041.outlook.office365.com
 (2603:10b6:903:151::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 18:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 18:45:02
 +0000
Received: from [149.199.38.66] (port=58779 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kB0PP-0000mA-6J; Wed, 26 Aug 2020 11:44:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kB0Pu-00006E-7e; Wed, 26 Aug 2020 11:45:02 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07QIitc6011723;
        Wed, 26 Aug 2020 11:44:55 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kB0Pm-0008RO-Et; Wed, 26 Aug 2020 11:44:55 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 93D2C1211FE; Thu, 27 Aug 2020 00:14:30 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
Date:   Thu, 27 Aug 2020 00:14:01 +0530
Message-Id: <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 096f9289-c353-4ad5-bfb2-08d849f02478
X-MS-TrafficTypeDiagnostic: BN6PR02MB2787:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2787B4BDB8D795A020B750FEC1540@BN6PR02MB2787.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaHxBiiw5cl6zmeHUSgF4myjvNOs/OKXijXOtU+kiNjieS8WPX9ldwvUEiV8/uGl0KL4KowXOQc0jMhwvGyJIgh4yooYJ9NK7xH0UG31nRKXXQnyW3ALjUraLEZHU7GJIxYRtQ+QLYpE7u+Zj1nVG2HBLkLszuIfAGjBuAaFYIw89yGM7d+1qdWoINjEKPfIMv0s1x6EQ+izIY8DfabummrI1vLRCYPOreeClfXjFBaTJKLRyJffKRWOpTF3t0uH7/6sDEXa8cdX4zOCj3dYlaytyYuX6T20MLaDIGywCXEwAWLBgTjsMWQte7ByEGEBpxQvc+eXwFDvS7eArVLscAm7mHAH3m8gctliC98hS3qPeJtg+Akl5OT45iVvakbIqPuxEk4c9lvQqW+2997J5g==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(46966005)(6666004)(8676002)(83380400001)(42186006)(356005)(107886003)(478600001)(81166007)(316002)(6266002)(47076004)(82740400003)(82310400002)(30864003)(426003)(2616005)(5660300002)(8936002)(70586007)(186003)(44832011)(26005)(36756003)(4326008)(336012)(2906002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 18:45:02.5687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096f9289-c353-4ad5-bfb2-08d849f02478
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for supporting Xilinx platforms. This driver handles
the USB 3.0 PHY initialization and PIPE control & reset operations for
ZynqMP platforms. This also handles the USB 2.0 PHY initialization and
reset operations for Versal platforms.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/dwc3/Kconfig          |   8 +
 drivers/usb/dwc3/Makefile         |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c |   1 -
 drivers/usb/dwc3/dwc3-xilinx.c    | 416 ++++++++++++++++++++++++++++++
 4 files changed, 425 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 7a2304565a73..416063ee9d05 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -139,4 +139,12 @@ config USB_DWC3_QCOM
 	  for peripheral mode support.
 	  Say 'Y' or 'M' if you have one such device.
 
+config USB_DWC3_XILINX
+       tristate "Xilinx Platforms"
+       depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
+       default USB_DWC3
+       help
+         Support Xilinx SoCs with DesignWare Core USB3 IP.
+	 Say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index ae86da0dc5bd..add567578b1f 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
+obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 7df115012935..e3a485b76818 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -172,7 +172,6 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 
 static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "rockchip,rk3399-dwc3" },
-	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
 	{ .compatible = "sprd,sc9860-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
new file mode 100644
index 000000000000..272906797a7a
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
+ *
+ * Authors: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
+ *          Manish Narani <manish.narani@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/io.h>
+
+#include <linux/phy/phy.h>
+
+/* USB phy reset mask register */
+#define XLNX_USB_PHY_RST		0x001C
+#define XLNX_PHY_RST_MASK		0x1
+
+/* Xilinx USB 3.0 IP Register */
+#define XLNX_USB_COHERENCY		0x005C
+#define XLNX_USB_COHERENCY_ENABLE	0x1
+
+/* Versal USB Reset ID */
+#define VERSAL_USB_RESET_ID		0xC104036
+
+#define PIPE_CLK_OFFSET			0x7c
+#define PIPE_CLK_ON			1
+#define PIPE_CLK_OFF			0
+#define PIPE_POWER_OFFSET		0x80
+#define PIPE_POWER_ON			1
+#define PIPE_POWER_OFF			0
+
+#define RST_TIMEOUT			1000
+
+struct dwc3_xlnx {
+	int				num_clocks;
+	struct clk_bulk_data		*clks;
+	struct device			*dev;
+	void __iomem			*regs;
+	struct dwc3			*dwc;
+	struct phy			*phy;
+	struct phy			*usb3_phy;
+	struct reset_control		*crst;
+	struct reset_control		*hibrst;
+	struct reset_control		*apbrst;
+};
+
+static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
+{
+	u32 reg;
+
+	reg = readl(priv_data->regs + XLNX_USB_PHY_RST);
+
+	if (mask)
+		/*
+		 * Mask the phy reset signal from comtroller
+		 * reaching ULPI phy. This can be done by
+		 * writing 0 into usb2_phy_reset register
+		 */
+		reg &= ~XLNX_PHY_RST_MASK;
+	else
+		/*
+		 * Allow phy reset signal from controller to
+		 * reset ULPI phy. This can be done by writing
+		 * 0x1 into usb2_phy_reset register
+		 */
+		reg |= XLNX_PHY_RST_MASK;
+
+	writel(reg, priv_data->regs + XLNX_USB_PHY_RST);
+}
+
+static int dwc3_xlnx_rst_assert(struct reset_control *rstc)
+{
+	unsigned long loop_time = msecs_to_jiffies(RST_TIMEOUT);
+	unsigned long timeout;
+
+	reset_control_assert(rstc);
+
+	/* wait until reset is asserted or timeout */
+	timeout = jiffies + loop_time;
+
+	while (!time_after_eq(jiffies, timeout)) {
+		if (reset_control_status(rstc) > 0)
+			return 0;
+
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int dwc3_xlnx_rst_deassert(struct reset_control *rstc)
+{
+	unsigned long loop_time = msecs_to_jiffies(RST_TIMEOUT);
+	unsigned long timeout;
+
+	reset_control_deassert(rstc);
+
+	/* wait until reset is de-asserted or timeout */
+	timeout = jiffies + loop_time;
+	while (!time_after_eq(jiffies, timeout)) {
+		if (!reset_control_status(rstc))
+			return 0;
+
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
+{
+	struct device *dev = priv_data->dev;
+	int ret;
+
+	dwc3_xlnx_mask_phy_rst(priv_data, false);
+
+	/* Assert and De-assert reset */
+	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
+				     PM_RESET_ACTION_ASSERT);
+	if (ret < 0) {
+		dev_err(dev, "failed to assert Reset\n");
+		return ret;
+	}
+
+	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
+				     PM_RESET_ACTION_RELEASE);
+	if (ret < 0) {
+		dev_err(dev, "failed to De-assert Reset\n");
+		return ret;
+	}
+
+	dwc3_xlnx_mask_phy_rst(priv_data, true);
+
+	return 0;
+}
+
+static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
+{
+	struct device *dev = priv_data->dev;
+	int ret;
+	u32 reg;
+
+	priv_data->crst = devm_reset_control_get(dev, "usb_crst");
+	if (IS_ERR(priv_data->crst)) {
+		dev_err(dev, "failed to get %s reset signal\n", "usb_crst");
+		ret = PTR_ERR(priv_data->crst);
+		goto err;
+	}
+
+	priv_data->hibrst = devm_reset_control_get(dev, "usb_hibrst");
+	if (IS_ERR(priv_data->hibrst)) {
+		dev_err(dev, "failed to get %s reset signal\n", "usb_hibrst");
+		ret = PTR_ERR(priv_data->hibrst);
+		goto err;
+	}
+
+	priv_data->apbrst = devm_reset_control_get(dev, "usb_apbrst");
+	if (IS_ERR(priv_data->apbrst)) {
+		dev_err(dev, "failed to get %s reset signal\n", "usb_apbrst");
+		ret = PTR_ERR(priv_data->apbrst);
+		goto err;
+	}
+
+	priv_data->usb3_phy = devm_phy_get(dev, "usb3-phy");
+
+	ret = dwc3_xlnx_rst_assert(priv_data->crst);
+	if (ret < 0) {
+		dev_err(dev, "%s: %d: Failed to assert reset\n",
+			__func__, __LINE__);
+		goto err;
+	}
+
+	ret = dwc3_xlnx_rst_assert(priv_data->hibrst);
+	if (ret < 0) {
+		dev_err(dev, "%s: %d: Failed to assert reset\n",
+			__func__, __LINE__);
+		goto err;
+	}
+
+	ret = dwc3_xlnx_rst_assert(priv_data->apbrst);
+	if (ret < 0) {
+		dev_err(dev, "%s: %d: Failed to assert reset\n",
+			__func__, __LINE__);
+		goto err;
+	}
+
+	ret = phy_init(priv_data->usb3_phy);
+	if (ret < 0) {
+		phy_exit(priv_data->usb3_phy);
+		goto err;
+	}
+
+	ret = dwc3_xlnx_rst_deassert(priv_data->apbrst);
+	if (ret < 0) {
+		dev_err(dev, "%s: %d: Failed to release reset\n",
+			__func__, __LINE__);
+		goto err;
+	}
+
+	/* Set PIPE power present signal */
+	writel(PIPE_POWER_ON, priv_data->regs + PIPE_POWER_OFFSET);
+
+	/* Clear PIPE CLK signal */
+	writel(PIPE_CLK_OFF, priv_data->regs + PIPE_CLK_OFFSET);
+
+	ret = dwc3_xlnx_rst_deassert(priv_data->crst);
+	if (ret < 0) {
+		dev_err(dev, "%s: %d: Failed to release reset\n",
+			__func__, __LINE__);
+		goto err;
+	}
+
+	ret = dwc3_xlnx_rst_deassert(priv_data->hibrst);
+	if (ret < 0) {
+		dev_err(dev, "%s: %d: Failed to release reset\n",
+			__func__, __LINE__);
+		goto err;
+	}
+
+	ret = phy_power_on(priv_data->usb3_phy);
+	if (ret < 0) {
+		phy_exit(priv_data->usb3_phy);
+		goto err;
+	}
+
+	/*
+	 * This routes the usb dma traffic to go through CCI path instead
+	 * of reaching DDR directly. This traffic routing is needed to
+	 * make SMMU and CCI work with USB dma.
+	 */
+	if (of_dma_is_coherent(dev->of_node) || dev->iommu_group) {
+		reg = readl(priv_data->regs + XLNX_USB_COHERENCY);
+		reg |= XLNX_USB_COHERENCY_ENABLE;
+		writel(reg, priv_data->regs + XLNX_USB_COHERENCY);
+	}
+
+err:
+	return ret;
+}
+
+static int dwc3_xlnx_probe(struct platform_device *pdev)
+{
+	struct dwc3_xlnx	*priv_data;
+	struct device		*dev = &pdev->dev;
+	struct device_node	*np = dev->of_node;
+	struct resource		*res;
+	void __iomem		*regs;
+	int			ret;
+
+	priv_data = devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	/* Store the usb control regs into priv_data for further usage */
+	priv_data->regs = regs;
+
+	priv_data->dev = dev;
+
+	platform_set_drvdata(pdev, priv_data);
+
+	ret = clk_bulk_get_all(priv_data->dev, &priv_data->clks);
+	if (ret < 0)
+		return ret;
+
+	priv_data->num_clocks = ret;
+
+	ret = clk_bulk_prepare_enable(priv_data->num_clocks, priv_data->clks);
+	if (ret)
+		return ret;
+
+	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-dwc3")) {
+		ret = dwc3_xlnx_init_zynqmp(priv_data);
+		if (ret)
+			goto err_clk_put;
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,versal-dwc3")) {
+		ret = dwc3_xlnx_init_versal(priv_data);
+		if (ret)
+			goto err_clk_put;
+	}
+
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret)
+		goto err_clk_put;
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_suspend_ignore_children(dev, false);
+	pm_runtime_get_sync(dev);
+
+	pm_runtime_forbid(dev);
+
+	return 0;
+
+err_clk_put:
+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
+
+	return ret;
+}
+
+static int dwc3_xlnx_remove(struct platform_device *pdev)
+{
+	struct dwc3_xlnx	*priv_data = platform_get_drvdata(pdev);
+	struct device		*dev = &pdev->dev;
+
+	of_platform_depopulate(dev);
+
+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
+	priv_data->num_clocks = 0;
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int dwc3_xlnx_runtime_suspend(struct device *dev)
+{
+	struct dwc3_xlnx	*priv_data = dev_get_drvdata(dev);
+
+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
+
+	return 0;
+}
+
+static int dwc3_xlnx_runtime_idle(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_autosuspend(dev);
+
+	return 0;
+}
+
+static int dwc3_xlnx_runtime_resume(struct device *dev)
+{
+	struct dwc3_xlnx	*priv_data = dev_get_drvdata(dev);
+
+	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
+}
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_PM_SLEEP
+static int dwc3_xlnx_suspend(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	/* Disable the clocks */
+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
+
+	return 0;
+}
+
+static int dwc3_xlnx_resume(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops dwc3_xlnx_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_xlnx_suspend, dwc3_xlnx_resume)
+	SET_RUNTIME_PM_OPS(dwc3_xlnx_runtime_suspend, dwc3_xlnx_runtime_resume,
+			   dwc3_xlnx_runtime_idle)
+};
+
+static const struct of_device_id of_dwc3_xlnx_match[] = {
+	{ .compatible = "xlnx,zynqmp-dwc3" },
+	{ .compatible = "xlnx,versal-dwc3" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_dwc3_xlnx_match);
+
+static struct platform_driver dwc3_xlnx_driver = {
+	.probe		= dwc3_xlnx_probe,
+	.remove		= dwc3_xlnx_remove,
+	.driver		= {
+		.name	= "dwc3-xilinx",
+		.of_match_table = of_dwc3_xlnx_match,
+		.pm	= &dwc3_xlnx_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dwc3_xlnx_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
+MODULE_AUTHOR("Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>");
+MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
-- 
2.17.1

