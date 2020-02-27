Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74469C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A44B24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LGPj3ilO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgB0Mii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:38:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51162 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgB0Mib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:38:31 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RCcFCs060774;
        Thu, 27 Feb 2020 06:38:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582807095;
        bh=oZwRKKvJx/G8CRNhVZ7kLkdfzgNJ4E/mi5KsY0jh8pM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LGPj3ilOH+EuYGqvyVZX0Bpj5e6SFcaJeVANJdnB3tc+r1ATu2fWeSQ2pS4Efzckr
         HYJ1AreHkJXbOWhPXhym+ZC4mPKkA5EBk2CE/6Zs/6Hevtab9eyFKQ2vyrJTp4Ho0h
         fHAOBISG5nuRA750+8G4N/PPjCkgoqoOk72q0D58=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RCcFFj117513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 06:38:15 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 06:38:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 06:38:14 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbnvU100207;
        Thu, 27 Feb 2020 06:38:11 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <han.xu@nxp.com>,
        <richard@nod.at>, <mripard@kernel.org>, <wens@csie.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vkoul@kernel.org>
Subject: [PATCH 7/7] mtd: rawnand: stm32_fmc2: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Thu, 27 Feb 2020 14:37:49 +0200
Message-ID: <20200227123749.24064-8-peter.ujfalusi@ti.com>
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

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

Use using dma_request_chan() directly and inform user of error in case the
DMA request failed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 44 ++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 3ba73f18841f..b6d45cd911ae 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1606,15 +1606,36 @@ static int stm32_fmc2_setup_interface(struct nand_chip *chip, int chipnr,
 /* DMA configuration */
 static int stm32_fmc2_dma_setup(struct stm32_fmc2_nfc *fmc2)
 {
-	int ret;
+	int ret = 0;
 
-	fmc2->dma_tx_ch = dma_request_slave_channel(fmc2->dev, "tx");
-	fmc2->dma_rx_ch = dma_request_slave_channel(fmc2->dev, "rx");
-	fmc2->dma_ecc_ch = dma_request_slave_channel(fmc2->dev, "ecc");
+	fmc2->dma_tx_ch = dma_request_chan(fmc2->dev, "tx");
+	if (IS_ERR(fmc2->dma_tx_ch)) {
+		ret = PTR_ERR(fmc2->dma_tx_ch);
+		if (ret != -ENODEV)
+			dev_err(fmc2->dev,
+				"failed to request tx DMA channel: %d\n", ret);
+		fmc2->dma_tx_ch = NULL;
+		goto err_dma;
+	}
 
-	if (!fmc2->dma_tx_ch || !fmc2->dma_rx_ch || !fmc2->dma_ecc_ch) {
-		dev_warn(fmc2->dev, "DMAs not defined in the device tree, polling mode is used\n");
-		return 0;
+	fmc2->dma_rx_ch = dma_request_chan(fmc2->dev, "rx");
+	if (IS_ERR(fmc2->dma_rx_ch)) {
+		ret = PTR_ERR(fmc2->dma_rx_ch);
+		if (ret != -ENODEV)
+			dev_err(fmc2->dev,
+				"failed to request rx DMA channel: %d\n", ret);
+		fmc2->dma_rx_ch = NULL;
+		goto err_dma;
+	}
+
+	fmc2->dma_ecc_ch = dma_request_chan(fmc2->dev, "ecc");
+	if (IS_ERR(fmc2->dma_ecc_ch)) {
+		ret = PTR_ERR(fmc2->dma_ecc_ch);
+		if (ret != -ENODEV)
+			dev_err(fmc2->dev,
+				"failed to request ecc DMA channel: %d\n", ret);
+		fmc2->dma_ecc_ch = NULL;
+		goto err_dma;
 	}
 
 	ret = sg_alloc_table(&fmc2->dma_ecc_sg, FMC2_MAX_SG, GFP_KERNEL);
@@ -1635,6 +1656,15 @@ static int stm32_fmc2_dma_setup(struct stm32_fmc2_nfc *fmc2)
 	init_completion(&fmc2->dma_ecc_complete);
 
 	return 0;
+
+err_dma:
+	if (ret == -ENODEV) {
+		dev_warn(fmc2->dev,
+			 "DMAs not defined in the DT, polling mode is used\n");
+		ret = 0;
+	}
+
+	return ret;
 }
 
 /* NAND callbacks setup */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

