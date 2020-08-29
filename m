Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE427C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE3E207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lTEbp8Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgH2SmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:42:07 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53932 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgH2SmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:42:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07TIfwTG041781;
        Sat, 29 Aug 2020 13:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598726518;
        bh=/czBZGu7D21+O5ILIP8EVJaQjv5J+NV+j9SplcX4p5U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lTEbp8Xbc16e7zXRGK+aQVXSgVGkT00LHYmmgBexVQra7iK0Vu2rZtGX0rUIzpAqb
         XY+YN9GTzxXZzRYR0NNBPjEG8Z/rdgiXH1CxclcTDqlsXeXbvBAjahpi639ontxrn7
         zKz5Mw7WhrrgHqezDKVMwJk5+sVloYxMf8bUGkZA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07TIfrrv084263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 13:41:58 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 29
 Aug 2020 13:41:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 29 Aug 2020 13:41:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07TIfpaP110773;
        Sat, 29 Aug 2020 13:41:52 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 1/3] soc: ti: k3: ringacc: add am65x sr2.0 support
Date:   Sat, 29 Aug 2020 21:41:37 +0300
Message-ID: <20200829184139.15547-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829184139.15547-1-grygorii.strashko@ti.com>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM65x SR2.0 Ringacc has fixed errata i2023 "RINGACC, UDMA: RINGACC and
UDMA Ring State Interoperability Issue after Channel Teardown". This errata
also fixed for J271E SoC.

Use SOC bus data for K3 SoC identification and enable i2023 errate w/a only
for the AM65x SR1.0. This also makes obsolete "ti,dma-ring-reset-quirk" DT
property.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 6dcc21dde0cb..1147dc4c1d59 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/sys_soc.h>
 #include <linux/soc/ti/k3-ringacc.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/soc/ti/ti_sci_inta_msi.h>
@@ -208,6 +209,15 @@ struct k3_ringacc {
 	const struct k3_ringacc_ops *ops;
 };
 
+/**
+ * struct k3_ringacc - Rings accelerator SoC data
+ *
+ * @dma_ring_reset_quirk:  DMA reset w/a enable
+ */
+struct k3_ringacc_soc_data {
+	unsigned dma_ring_reset_quirk:1;
+};
+
 static long k3_ringacc_ring_get_fifo_pos(struct k3_ring *ring)
 {
 	return K3_RINGACC_FIFO_WINDOW_SIZE_BYTES -
@@ -1051,9 +1061,6 @@ static int k3_ringacc_probe_dt(struct k3_ringacc *ringacc)
 		return ret;
 	}
 
-	ringacc->dma_ring_reset_quirk =
-			of_property_read_bool(node, "ti,dma-ring-reset-quirk");
-
 	ringacc->tisci = ti_sci_get_by_phandle(node, "ti,sci");
 	if (IS_ERR(ringacc->tisci)) {
 		ret = PTR_ERR(ringacc->tisci);
@@ -1084,9 +1091,22 @@ static int k3_ringacc_probe_dt(struct k3_ringacc *ringacc)
 						 ringacc->rm_gp_range);
 }
 
+static const struct k3_ringacc_soc_data k3_ringacc_soc_data_sr1 = {
+	.dma_ring_reset_quirk = 1,
+};
+
+static const struct soc_device_attribute k3_ringacc_socinfo[] = {
+	{ .family = "AM65X",
+	  .revision = "SR1.0",
+	  .data = &k3_ringacc_soc_data_sr1
+	},
+	{/* sentinel */}
+};
+
 static int k3_ringacc_init(struct platform_device *pdev,
 			   struct k3_ringacc *ringacc)
 {
+	const struct soc_device_attribute *soc;
 	void __iomem *base_fifo, *base_rt;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
@@ -1103,6 +1123,13 @@ static int k3_ringacc_init(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	soc = soc_device_match(k3_ringacc_socinfo);
+	if (soc && soc->data) {
+		const struct k3_ringacc_soc_data *soc_data = soc->data;
+
+		ringacc->dma_ring_reset_quirk = soc_data->dma_ring_reset_quirk;
+	}
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rt");
 	base_rt = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base_rt))
-- 
2.17.1

