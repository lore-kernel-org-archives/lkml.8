Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D868C20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926473;
	bh=4Pu5l+a7R0giKXEjk93F4XnVBL48zhHRz7T5g0HZRQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/VUNDTUtMeNXBCJyG4UZOxeUiuuJ25IXxqc0k4V/rWecEsanqBSvejlw5DIA3Xtc
	 f+fv4Z9PDRva6EdV8O5H35NiT4PFy3lYZ1snUP89BmMNw/mw6l16Lg6phPgZ93VhSf
	 pw7hVeLfwu4ZcXB8QklmQEaNDKpVd9n4V9uwpUN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgHTM1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729886AbgHTJwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:52:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E7B2067C;
        Thu, 20 Aug 2020 09:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917130;
        bh=4Pu5l+a7R0giKXEjk93F4XnVBL48zhHRz7T5g0HZRQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISOzYfSNrkFfOc7y/K4v97ZM+k8CV1Et3Zgw4dk1Gwd+KMzJxOuS5ozBHZr6/vIur
         mfLHN/PgIXQVfpvFwJEFtpcSuAaOgUFF/JFn16mr1lcYQ3V0pX+bQXK/b4Bpjm+/Nv
         VoZGa0IVIi+51ejT7r0PMupWBhOszhPg6FL3JPY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ansuel Smith <ansuelsmth@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH 4.19 06/92] PCI: qcom: Define some PARF params needed for ipq8064 SoC
Date:   Thu, 20 Aug 2020 11:20:51 +0200
Message-Id: <20200820091537.825524967@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ansuel Smith <ansuelsmth@gmail.com>

commit 5149901e9e6deca487c01cc434a3ac4125c7b00b upstream.

Set some specific value for Tx De-Emphasis, Tx Swing and Rx equalization
needed on some ipq8064 based device (Netgear R7800 for example). Without
this the system locks on kernel load.

Link: https://lore.kernel.org/r/20200615210608.21469-8-ansuelsmth@gmail.com
Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: stable@vger.kernel.org # v4.5+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-qcom.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -76,6 +76,18 @@
 #define DBI_RO_WR_EN				1
 
 #define PERST_DELAY_US				1000
+/* PARF registers */
+#define PCIE20_PARF_PCS_DEEMPH			0x34
+#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
+
+#define PCIE20_PARF_PCS_SWING			0x38
+#define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
+#define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
+
+#define PCIE20_PARF_CONFIG_BITS		0x50
+#define PHY_RX0_EQ(x)				((x) << 24)
 
 #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
@@ -275,6 +287,7 @@ static int qcom_pcie_init_2_1_0(struct q
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	struct device_node *node = dev->of_node;
 	u32 val;
 	int ret;
 
@@ -319,6 +332,17 @@ static int qcom_pcie_init_2_1_0(struct q
 	val &= ~BIT(0);
 	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
 
+	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
+		writel(PCS_DEEMPH_TX_DEEMPH_GEN1(24) |
+			       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(24) |
+			       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(34),
+		       pcie->parf + PCIE20_PARF_PCS_DEEMPH);
+		writel(PCS_SWING_TX_SWING_FULL(120) |
+			       PCS_SWING_TX_SWING_LOW(120),
+		       pcie->parf + PCIE20_PARF_PCS_SWING);
+		writel(PHY_RX0_EQ(4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
+	}
+
 	/* enable external reference clock */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
 	val |= BIT(16);


