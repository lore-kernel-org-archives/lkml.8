Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88348C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D98D24692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xq/zkBRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgB0MiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:38:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38658 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgB0MiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:38:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RCc0fk117345;
        Thu, 27 Feb 2020 06:38:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582807080;
        bh=ixAPQJdNXHfaYAwd0a821FNFCS6Wv9ULBLSO6ySWj1A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xq/zkBRHiJQJC5RR8xX2pyd9YnKnKWXTyhGYh56sQ4fF78VZqrOluvTurQXNR+yo4
         dPOhdBCJrsyn+dui1NYm4C4GHvzCQ4EY6d/h+4MlhGOVMW1Oa9FyjO06nmeI1qgfQU
         tJY/Ht/25QVtZEBYq7v1Yzk2qihUbePwgVB4LGBw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RCc02h127709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 06:38:00 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 06:37:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 06:37:58 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbnvP100207;
        Thu, 27 Feb 2020 06:37:56 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <han.xu@nxp.com>,
        <richard@nod.at>, <mripard@kernel.org>, <wens@csie.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vkoul@kernel.org>
Subject: [PATCH 2/7] mtd: rawnand: marvell: Release DMA channel on error
Date:   Thu, 27 Feb 2020 14:37:44 +0200
Message-ID: <20200227123749.24064-3-peter.ujfalusi@ti.com>
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

Release the DMA channel on errors after the channel has been successfully
requested.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index fb5abdcfb007..b6c7e1903396 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2751,8 +2751,10 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r)
-		return -ENXIO;
+	if (!r) {
+		ret = -ENXIO;
+		goto release_channel;
+	}
 
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -2763,7 +2765,7 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 	ret = dmaengine_slave_config(nfc->dma_chan, &config);
 	if (ret < 0) {
 		dev_err(nfc->dev, "Failed to configure DMA channel\n");
-		return ret;
+		goto release_channel;
 	}
 
 	/*
@@ -2773,12 +2775,20 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 	 * the provided buffer.
 	 */
 	nfc->dma_buf = kmalloc(MAX_CHUNK_SIZE, GFP_KERNEL | GFP_DMA);
-	if (!nfc->dma_buf)
-		return -ENOMEM;
+	if (!nfc->dma_buf) {
+		ret = -ENOMEM;
+		goto release_channel;
+	}
 
 	nfc->use_dma = true;
 
 	return 0;
+
+release_channel:
+	dma_release_channel(nfc->dma_chan);
+	nfc->dma_chan = NULL;
+
+	return ret;
 }
 
 static void marvell_nfc_reset(struct marvell_nfc *nfc)
@@ -2920,10 +2930,13 @@ static int marvell_nfc_probe(struct platform_device *pdev)
 
 	ret = marvell_nand_chips_init(dev, nfc);
 	if (ret)
-		goto unprepare_reg_clk;
+		goto release_dma;
 
 	return 0;
 
+release_dma:
+	if (nfc->use_dma)
+		dma_release_channel(nfc->dma_chan);
 unprepare_reg_clk:
 	clk_disable_unprepare(nfc->reg_clk);
 unprepare_core_clk:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

