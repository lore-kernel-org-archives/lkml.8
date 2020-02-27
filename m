Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F24C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099A124695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dgkuGMcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgB0Mi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:38:27 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46536 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgB0Mi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:38:26 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RCc3dC033099;
        Thu, 27 Feb 2020 06:38:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582807083;
        bh=rBvL/jTgQtXPQwaQj/9VSebj/1cBnnhVjwXy8JgbaGE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dgkuGMcGK4+dJG4uVpsTVpbhwKUVjfYHbed1kNfQiEGTBacM+oSvcrx5+YxzM92Ea
         qDQgLxYx1ae4916jGjaFobCdRyT1bIlA01wePmx5wwn14GRMPTFxbmuFmkJA23bCRG
         ASl5y3zKjaxE3d4RXbrvNV/kRgcM8u1nXaYwArmc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RCc2n9116708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 06:38:02 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 06:38:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 06:38:01 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbnvQ100207;
        Thu, 27 Feb 2020 06:37:59 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <han.xu@nxp.com>,
        <richard@nod.at>, <mripard@kernel.org>, <wens@csie.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vkoul@kernel.org>
Subject: [PATCH 3/7] mtd: rawnand: marvell: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Thu, 27 Feb 2020 14:37:45 +0200
Message-ID: <20200227123749.24064-4-peter.ujfalusi@ti.com>
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

Use using dma_request_chan() directly to return the real error code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index b6c7e1903396..911430cca7c8 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2743,11 +2743,14 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 	if (ret)
 		return ret;
 
-	nfc->dma_chan =	dma_request_slave_channel(nfc->dev, "data");
-	if (!nfc->dma_chan) {
-		dev_err(nfc->dev,
-			"Unable to request data DMA channel\n");
-		return -ENODEV;
+	nfc->dma_chan =	dma_request_chan(nfc->dev, "data");
+	if (IS_ERR(nfc->dma_chan)) {
+		ret = PTR_ERR(nfc->dma_chan);
+		nfc->dma_chan = NULL;
+		if (ret != -EPROBE_DEFER)
+			dev_err(nfc->dev, "DMA channel request failed: %d\n",
+				ret);
+		return ret;
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

