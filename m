Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E873C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F6D20C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Mv4UYy8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIITDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:03:54 -0400
Received: from mail-bn8nam08on2057.outbound.protection.outlook.com ([40.107.100.57]:14817
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgIITDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFVdM/zZiLKVKwG+hgCzvI6ri+eZv7fxQRoLTGZQNO2tWvZCIpTm5QPlCbGMyTaKDjijwko7IzDV50g8QkB7O3EncQbEi6nH+qGen7tRDQtyj0VlTgUZPKCQvYmql+UO3of4Pf9QLwMxQIZcfuZji7j6dXY0hLcp445cmeYUR03HYr7lIwRI9ZWLfWarzMPY3dE/8YebVOgUWxt3MUIoBzT6sgKeoz9AciQ8yM9uVZ6uzXZI0Q8J3Ya78SyzcrlWodci0jtGaPHO5+2ItblFE+1uJrYBk7YFHnHlSJNS54mmGmSe52SSntUsGtD2N7TMjGzRkcbNhwndy1jjSS1uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WYPMeu4SXiMDUBFH0jpPYq+vQ6/ocF8+/zIOJ/+eCU=;
 b=hcGWZ2xpxLw+PF4OEMBIndTSHxyWOvXemV2R1VuagRPCEVM+2YYk5LDt4ZtBT79Mhzg6zjPVznwPJqHcw8K2wa/nljnAQXJsFcMVTao+vJvpx3RiSYMRvHLNa5yTIUqQyuqBgtFIJtIo+Tt5SKEHQt2T8GFvWOcNglJWNNjF+XLXGYXG28xcVwFARmicOb0b35mXGSI6o5Qt4Hs/O0G4+3CfANkOBOlVs2qcVdqNuOfCjbxsd3yN97M9yUFLXHA5NOJUoAaVz1UYZe19ZlRsnDjOsw5SVVYyEzG93TzQzB9FI+qCXag3Bzgkam5/bVfFTkkU2oib0ajXMHH0qSB3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WYPMeu4SXiMDUBFH0jpPYq+vQ6/ocF8+/zIOJ/+eCU=;
 b=Mv4UYy8LKYytltUHmE2Po0rO/wbDEJvR3O6lc4eipr1uwq+O4Z6Qcd++rwgGIqTm/z4P7/DHFIxnsBtFUdIIEwyIYFgIVsFA6tvay6OqP9a3Cd0P697iZBG6+w6qpROfLtr6635gdds+oogRGrTO6DhJn6c3ziEM7MHLdDAfiZA=
Received: from SA0PR11CA0029.namprd11.prod.outlook.com (2603:10b6:806:d3::34)
 by BYAPR02MB4053.namprd02.prod.outlook.com (2603:10b6:a02:f9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 19:03:44 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::47) by SA0PR11CA0029.outlook.office365.com
 (2603:10b6:806:d3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 19:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 19:03:44
 +0000
Received: from [149.199.38.66] (port=46265 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kG5NP-0000KS-Oz; Wed, 09 Sep 2020 12:03:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kG5Nf-0006rN-Sv; Wed, 09 Sep 2020 12:03:43 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kG5Nc-0006ql-Av; Wed, 09 Sep 2020 12:03:40 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 768A61210FA; Thu, 10 Sep 2020 00:33:19 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 2/2] usb: dwc3: Add driver for Xilinx platforms
Date:   Thu, 10 Sep 2020 00:33:05 +0530
Message-Id: <1599678185-119412-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
References: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b0775e7f-b2a6-408d-9a32-08d854f312c8
X-MS-TrafficTypeDiagnostic: BYAPR02MB4053:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4053B5BF96ECD9384569CBBCC1260@BYAPR02MB4053.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKRHkJK8YTgvRUKS0RFmUcGZ5g65LbFlV20KHdljSjNu0bXdkwjeucAd0S/VglVLIvFmCMIgaoEJCG7tzpwkvkM1Jmb0ie2uu9TLNp2KwgZ3EpgcDiRBhU7pwp+AAee1iQjyCBwLlFZqYQ5FkPdrHoEU2Xhi8JsAgmY8PRPUYsrOhqmvpDVGq75NSIxqO9m6gsKN5yTKvHw4phEQEgBsajcwvBAht7pH+aPBnVQpQD0jroS0AN6q1yBQdixUXPvbdu6eEZ+sTIimpwlQZoM4PEHUuTtvOvYyK0BdxAS0adWJx5VICGWI4bnD1mDYFnUsYpZZ5VMYomYLiCaQM6cTrPe8826AiTxUS4qVKY8WG4n4OPuyvumUgoKiTCrjiGe92ar+lgrnTXF/MQjVCLzDtQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(346002)(46966005)(44832011)(6666004)(30864003)(36756003)(5660300002)(2616005)(81166007)(336012)(82740400003)(83380400001)(26005)(186003)(426003)(70206006)(70586007)(356005)(47076004)(82310400003)(4326008)(6266002)(2906002)(8936002)(42186006)(8676002)(478600001)(316002)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 19:03:44.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0775e7f-b2a6-408d-9a32-08d854f312c8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for supporting Xilinx platforms. This driver is used
for some sequence of operations required for Xilinx USB controllers.
This driver is also used to choose between PIPE clock coming from SerDes
and the Suspend Clock. Before the controller is out of reset, the clock
selection should be changed to PIPE clock in order to make the USB
controller work. There is a register added in Xilinx USB controller
register space for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/dwc3/Kconfig          |   9 +
 drivers/usb/dwc3/Makefile         |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c |   1 -
 drivers/usb/dwc3/dwc3-xilinx.c    | 334 ++++++++++++++++++++++++++++++
 4 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 7a2304565a73..0e00e6dfccd8 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -139,4 +139,13 @@ config USB_DWC3_QCOM
 	  for peripheral mode support.
 	  Say 'Y' or 'M' if you have one such device.
 
+config USB_DWC3_XILINX
+	tristate "Xilinx Platforms"
+	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
+	default USB_DWC3
+	help
+	  Support Xilinx SoCs with DesignWare Core USB3 IP.
+	  This driver handles both ZynqMP and Versal SoC operations.
+	  Say 'Y' or 'M' if you have one such device.
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
index 000000000000..7e485951d2f7
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
+ *
+ * Authors: Manish Narani <manish.narani@xilinx.com>
+ *          Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
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
+#define XLNX_USB_PHY_RST_EN			0x001C
+#define XLNX_PHY_RST_MASK			0x1
+
+/* Xilinx USB 3.0 IP Register */
+#define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
+#define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
+
+/* Versal USB Reset ID */
+#define VERSAL_USB_RESET_ID			0xC104036
+
+#define XLNX_USB_FPD_PIPE_CLK			0x7c
+#define PIPE_CLK_DESELECT			1
+#define PIPE_CLK_SELECT				0
+#define XLNX_USB_FPD_POWER_PRSNT		0x80
+#define PIPE_POWER_ON				1
+#define PIPE_POWER_OFF				0
+
+struct dwc3_xlnx {
+	int				num_clocks;
+	struct clk_bulk_data		*clks;
+	struct device			*dev;
+	void __iomem			*regs;
+	int				(*pltfm_init)(struct dwc3_xlnx *data);
+};
+
+static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
+{
+	u32 reg;
+
+	/*
+	 * Enable or disable ULPI PHY reset from USB Controller.
+	 * This does not actually reset the phy, but just controls
+	 * whether USB controller can or cannot reset ULPI PHY.
+	 */
+	reg = readl(priv_data->regs + XLNX_USB_PHY_RST_EN);
+
+	if (mask)
+		reg &= ~XLNX_PHY_RST_MASK;
+	else
+		reg |= XLNX_PHY_RST_MASK;
+
+	writel(reg, priv_data->regs + XLNX_USB_PHY_RST_EN);
+}
+
+static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
+{
+	struct device		*dev = priv_data->dev;
+	int			ret;
+
+	dwc3_xlnx_mask_phy_rst(priv_data, false);
+
+	/* Assert and De-assert reset */
+	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
+				     PM_RESET_ACTION_ASSERT);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to assert Reset\n");
+		return ret;
+	}
+
+	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
+				     PM_RESET_ACTION_RELEASE);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
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
+	struct device		*dev = priv_data->dev;
+	struct reset_control	*crst, *hibrst, *apbrst;
+	struct phy		*usb3_phy;
+	int			ret;
+	u32			reg;
+
+	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
+	if (IS_ERR(crst)) {
+		ret = PTR_ERR(crst);
+		dev_err_probe(dev, ret,
+			      "failed to get core reset signal\n");
+		goto err;
+	}
+
+	hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
+	if (IS_ERR(hibrst)) {
+		ret = PTR_ERR(hibrst);
+		dev_err_probe(dev, ret,
+			      "failed to get hibernation reset signal\n");
+		goto err;
+	}
+
+	apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
+	if (IS_ERR(apbrst)) {
+		ret = PTR_ERR(apbrst);
+		dev_err_probe(dev, ret,
+			      "failed to get APB reset signal\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(crst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert core reset\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(hibrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert hibernation reset\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(apbrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert APB reset\n");
+		goto err;
+	}
+
+	usb3_phy = devm_phy_get(dev, "usb3-phy");
+
+	ret = phy_init(usb3_phy);
+	if (ret < 0) {
+		phy_exit(usb3_phy);
+		goto err;
+	}
+
+	ret = reset_control_deassert(apbrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release APB reset\n");
+		goto err;
+	}
+
+	/* Set PIPE Power Present signal in FPD Power Present Register*/
+	writel(PIPE_POWER_ON, priv_data->regs + XLNX_USB_FPD_POWER_PRSNT);
+
+	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
+	writel(PIPE_CLK_SELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
+
+	ret = reset_control_deassert(crst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release core reset\n");
+		goto err;
+	}
+
+	ret = reset_control_deassert(hibrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release hibernation reset\n");
+		goto err;
+	}
+
+	ret = phy_power_on(usb3_phy);
+	if (ret < 0) {
+		phy_exit(usb3_phy);
+		goto err;
+	}
+
+	/*
+	 * This routes the USB DMA traffic to go through FPD path instead
+	 * of reaching DDR directly. This traffic routing is needed to
+	 * make SMMU and CCI work with USB DMA.
+	 */
+	if (of_dma_is_coherent(dev->of_node) || device_iommu_mapped(dev)) {
+		reg = readl(priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+		reg |= XLNX_USB_TRAFFIC_ROUTE_FPD;
+		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+	}
+
+err:
+	return ret;
+}
+
+static const struct of_device_id dwc3_xlnx_of_match[] = {
+	{
+		.compatible = "xlnx,zynqmp-dwc3",
+		.data = &dwc3_xlnx_init_zynqmp,
+	},
+	{
+		.compatible = "xlnx,versal-dwc3",
+		.data = &dwc3_xlnx_init_versal,
+	},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
+
+static int dwc3_xlnx_probe(struct platform_device *pdev)
+{
+	struct dwc3_xlnx		*priv_data;
+	struct device			*dev = &pdev->dev;
+	struct device_node		*np = dev->of_node;
+	const struct of_device_id	*match;
+	void __iomem			*regs;
+	int				ret;
+
+	priv_data = devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		dev_err_probe(dev, ret, "failed to map registers\n");
+		return ret;
+	}
+
+	match = of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
+
+	priv_data->pltfm_init = match->data;
+	priv_data->regs = regs;
+	priv_data->dev = dev;
+
+	platform_set_drvdata(pdev, priv_data);
+
+	ret = devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
+	if (ret < 0)
+		return ret;
+
+	priv_data->num_clocks = ret;
+
+	ret = clk_bulk_prepare_enable(priv_data->num_clocks, priv_data->clks);
+	if (ret)
+		return ret;
+
+	ret = priv_data->pltfm_init(priv_data);
+	if (ret)
+		goto err_clk_put;
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
+static int __maybe_unused dwc3_xlnx_suspend_common(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_xlnx_resume_common(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
+}
+
+static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_autosuspend(dev);
+
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops, dwc3_xlnx_suspend_common,
+			    dwc3_xlnx_resume_common, dwc3_xlnx_runtime_idle);
+
+static struct platform_driver dwc3_xlnx_driver = {
+	.probe		= dwc3_xlnx_probe,
+	.remove		= dwc3_xlnx_remove,
+	.driver		= {
+		.name		= "dwc3-xilinx",
+		.of_match_table	= dwc3_xlnx_of_match,
+		.pm		= &dwc3_xlnx_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dwc3_xlnx_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
+MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
+MODULE_AUTHOR("Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>");
-- 
2.17.1

