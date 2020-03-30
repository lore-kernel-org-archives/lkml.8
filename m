Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A7C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C92206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgC3RFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:05:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:10809 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbgC3RFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:05:22 -0400
IronPort-SDR: vtYfNiSvigg+knPLp7V6nCb5hhPc1lJXZ1YL6gZPX5IgelyFNrqEAGJ0Eop65TpPteNeVGELzl
 ZZqwFMb+ILpw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 10:05:22 -0700
IronPort-SDR: ZEVsaQizZrY2Liacu9c/nVdwcmke+TZ4kA2uBk0L7azKUw+bwGSU21EQw+AWdO4bo4mGUSCL6/
 aqdl0YyKw/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="294667227"
Received: from unknown (HELO climb.png.intel.com) ([10.221.118.165])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2020 10:05:19 -0700
From:   Voon Weifeng <weifeng.voon@intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>
Subject: [net-next,v2, 2/3] net: stmmac: add EHL PSE0 & PSE1 1Gbps PCI info and PCI ID
Date:   Tue, 31 Mar 2020 01:05:11 +0800
Message-Id: <20200330170512.22240-3-weifeng.voon@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330170512.22240-1-weifeng.voon@intel.com>
References: <20200330170512.22240-1-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EHL PSE0/1 RGMII & SGMII 1Gbps PCI info and PCI ID

Signed-off-by: Voon Weifeng <weifeng.voon@intel.com>
Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 6c19aa361444..12927571cee4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -210,6 +210,66 @@ static struct stmmac_pci_info ehl_rgmii1g_pci_info = {
 	.setup = ehl_rgmii_data,
 };
 
+static int ehl_pse0_common_data(struct pci_dev *pdev,
+				struct plat_stmmacenet_data *plat)
+{
+	plat->bus_id = 2;
+	plat->phy_addr = 1;
+	return ehl_common_data(pdev, plat);
+}
+
+static int ehl_pse0_rgmii1g_data(struct pci_dev *pdev,
+				 struct plat_stmmacenet_data *plat)
+{
+	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
+	return ehl_pse0_common_data(pdev, plat);
+}
+
+static struct stmmac_pci_info ehl_pse0_rgmii1g_pci_info = {
+	.setup = ehl_pse0_rgmii1g_data,
+};
+
+static int ehl_pse0_sgmii1g_data(struct pci_dev *pdev,
+				 struct plat_stmmacenet_data *plat)
+{
+	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
+	return ehl_pse0_common_data(pdev, plat);
+}
+
+static struct stmmac_pci_info ehl_pse0_sgmii1g_pci_info = {
+	.setup = ehl_pse0_sgmii1g_data,
+};
+
+static int ehl_pse1_common_data(struct pci_dev *pdev,
+				struct plat_stmmacenet_data *plat)
+{
+	plat->bus_id = 3;
+	plat->phy_addr = 1;
+	return ehl_common_data(pdev, plat);
+}
+
+static int ehl_pse1_rgmii1g_data(struct pci_dev *pdev,
+				 struct plat_stmmacenet_data *plat)
+{
+	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
+	return ehl_pse1_common_data(pdev, plat);
+}
+
+static struct stmmac_pci_info ehl_pse1_rgmii1g_pci_info = {
+	.setup = ehl_pse1_rgmii1g_data,
+};
+
+static int ehl_pse1_sgmii1g_data(struct pci_dev *pdev,
+				 struct plat_stmmacenet_data *plat)
+{
+	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
+	return ehl_pse1_common_data(pdev, plat);
+}
+
+static struct stmmac_pci_info ehl_pse1_sgmii1g_pci_info = {
+	.setup = ehl_pse1_sgmii1g_data,
+};
+
 static int tgl_common_data(struct pci_dev *pdev,
 			   struct plat_stmmacenet_data *plat)
 {
@@ -480,12 +540,27 @@ static SIMPLE_DEV_PM_OPS(intel_eth_pm_ops, intel_eth_pci_suspend,
 #define PCI_DEVICE_ID_INTEL_QUARK_ID		0x0937
 #define PCI_DEVICE_ID_INTEL_EHL_RGMII1G_ID	0x4b30
 #define PCI_DEVICE_ID_INTEL_EHL_SGMII1G_ID	0x4b31
+/* Intel(R) Programmable Services Engine (Intel(R) PSE) consist of 2 MAC
+ * which are named PSE0 and PSE1
+ */
+#define PCI_DEVICE_ID_INTEL_EHL_PSE0_RGMII1G_ID	0x4ba0
+#define PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII1G_ID	0x4ba1
+#define PCI_DEVICE_ID_INTEL_EHL_PSE1_RGMII1G_ID	0x4bb0
+#define PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII1G_ID	0x4bb1
 #define PCI_DEVICE_ID_INTEL_TGL_SGMII1G_ID	0xa0ac
 
 static const struct pci_device_id intel_eth_pci_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, QUARK_ID, &quark_pci_info) },
 	{ PCI_DEVICE_DATA(INTEL, EHL_RGMII1G_ID, &ehl_rgmii1g_pci_info) },
 	{ PCI_DEVICE_DATA(INTEL, EHL_SGMII1G_ID, &ehl_sgmii1g_pci_info) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_PSE0_RGMII1G_ID,
+			  &ehl_pse0_rgmii1g_pci_info) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_PSE0_SGMII1G_ID,
+			  &ehl_pse0_sgmii1g_pci_info) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_PSE1_RGMII1G_ID,
+			  &ehl_pse1_rgmii1g_pci_info) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_PSE1_SGMII1G_ID,
+			  &ehl_pse1_sgmii1g_pci_info) },
 	{ PCI_DEVICE_DATA(INTEL, TGL_SGMII1G_ID, &tgl_sgmii1g_pci_info) },
 	{}
 };
-- 
2.17.1

