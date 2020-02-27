Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20614C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E642A24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oZL24vsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgB0Mie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:38:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51166 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgB0Mid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:38:33 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RCc9Mk060757;
        Thu, 27 Feb 2020 06:38:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582807089;
        bh=lxEo+tSFG1DiFTuGLCWGl5deytcPL1kaEzXneacjjbw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oZL24vsxHovF8nXugumq/4kpyAKXXeqTUY1t/66zkkyPctslE5OdkMcqtTXVKVyJz
         gFtEaLxo2iAGhT5//6BCRr55eklI8bxV43JVe4jd5zPDsKkZMyvhH94lmNsEtNXtZP
         SZdG/ErlPRw6mnYtezQpHzM5bxrzKwImdFxpwkL4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RCc8L5128189
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 06:38:09 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 06:38:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 06:38:08 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbnvS100207;
        Thu, 27 Feb 2020 06:38:05 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <han.xu@nxp.com>,
        <richard@nod.at>, <mripard@kernel.org>, <wens@csie.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vkoul@kernel.org>
Subject: [PATCH 5/7] mtd: rawnand: qcom: Release resources on failure within qcom_nandc_alloc()
Date:   Thu, 27 Feb 2020 14:37:47 +0200
Message-ID: <20200227123749.24064-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227123749.24064-1-peter.ujfalusi@ti.com>
References: <20200227123749.24064-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case when DMA channel request or alloc_bam_transaction() fails,
dma_unmap_single() and any channels already requested should be released.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 61 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 7bb9a7e8e1e7..ca21cb3836dc 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2628,6 +2628,29 @@ static const struct nand_controller_ops qcom_nandc_ops = {
 	.attach_chip = qcom_nand_attach_chip,
 };
 
+static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
+{
+	if (nandc->props->is_bam) {
+		if (!dma_mapping_error(nandc->dev, nandc->reg_read_dma))
+			dma_unmap_single(nandc->dev, nandc->reg_read_dma,
+					 MAX_REG_RD *
+					 sizeof(*nandc->reg_read_buf),
+					 DMA_FROM_DEVICE);
+
+		if (nandc->tx_chan)
+			dma_release_channel(nandc->tx_chan);
+
+		if (nandc->rx_chan)
+			dma_release_channel(nandc->rx_chan);
+
+		if (nandc->cmd_chan)
+			dma_release_channel(nandc->cmd_chan);
+	} else {
+		if (nandc->chan)
+			dma_release_channel(nandc->chan);
+	}
+}
+
 static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 {
 	int ret;
@@ -2676,19 +2699,22 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 		nandc->tx_chan = dma_request_slave_channel(nandc->dev, "tx");
 		if (!nandc->tx_chan) {
 			dev_err(nandc->dev, "failed to request tx channel\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto unalloc;
 		}
 
 		nandc->rx_chan = dma_request_slave_channel(nandc->dev, "rx");
 		if (!nandc->rx_chan) {
 			dev_err(nandc->dev, "failed to request rx channel\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto unalloc;
 		}
 
 		nandc->cmd_chan = dma_request_slave_channel(nandc->dev, "cmd");
 		if (!nandc->cmd_chan) {
 			dev_err(nandc->dev, "failed to request cmd channel\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto unalloc;
 		}
 
 		/*
@@ -2702,7 +2728,8 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 		if (!nandc->bam_txn) {
 			dev_err(nandc->dev,
 				"failed to allocate bam transaction\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto unalloc;
 		}
 	} else {
 		nandc->chan = dma_request_slave_channel(nandc->dev, "rxtx");
@@ -2720,29 +2747,9 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 	nandc->controller.ops = &qcom_nandc_ops;
 
 	return 0;
-}
-
-static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
-{
-	if (nandc->props->is_bam) {
-		if (!dma_mapping_error(nandc->dev, nandc->reg_read_dma))
-			dma_unmap_single(nandc->dev, nandc->reg_read_dma,
-					 MAX_REG_RD *
-					 sizeof(*nandc->reg_read_buf),
-					 DMA_FROM_DEVICE);
-
-		if (nandc->tx_chan)
-			dma_release_channel(nandc->tx_chan);
-
-		if (nandc->rx_chan)
-			dma_release_channel(nandc->rx_chan);
-
-		if (nandc->cmd_chan)
-			dma_release_channel(nandc->cmd_chan);
-	} else {
-		if (nandc->chan)
-			dma_release_channel(nandc->chan);
-	}
+unalloc:
+	qcom_nandc_unalloc(nandc);
+	return ret;
 }
 
 /* one time setup of a few nand controller registers */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

