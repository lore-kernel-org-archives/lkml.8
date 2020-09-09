Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC24C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1241A21D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SX3ufc4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIITn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:43:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47260 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:43:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 089JhoDh021373;
        Wed, 9 Sep 2020 14:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599680630;
        bh=/czBZGu7D21+O5ILIP8EVJaQjv5J+NV+j9SplcX4p5U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SX3ufc4kBVGrw83Vhk3IXeA2Me+HTIdZ99b6vJoyK0VbBrOqasyCzY64BWfDKw96U
         GiPlENPDZ9bF3Dy430pcGFjg+fL0bhSciZ6EdDxUJ7kj1lWEaoWjgm5v26t85sOrqq
         Rtb73vNaAbgUAQWtjpHaVb6iIaEcuyo95HWHJNNg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 089JhoBQ050848
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Sep 2020 14:43:50 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Sep
 2020 14:43:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Sep 2020 14:43:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089JhmPM130087;
        Wed, 9 Sep 2020 14:43:49 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RESEND PATCH next v2 1/2] soc: ti: k3: ringacc: add am65x sr2.0 support
Date:   Wed, 9 Sep 2020 22:43:37 +0300
Message-ID: <20200909194338.21840-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909194338.21840-1-grygorii.strashko@ti.com>
References: <20200909194338.21840-1-grygorii.strashko@ti.com>
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

