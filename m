Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD228C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806BE2469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J5g8ORUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgB0MiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:38:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38660 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbgB0MiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:38:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbuKr117335;
        Thu, 27 Feb 2020 06:37:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582807076;
        bh=Z4xHzVimku6GaO/uJJfGUrX05MI6KgVNH9lyK1vuJOw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J5g8ORUa0Uh8C9gatDxzoG78qgUFARSC6gCL1Io+L+FE/JwuvC+qu0faZo8uDTmky
         ddw6DK5xpdJAtZNyuy4j43amj94PldkNgAsUylQ6LRABCmC2JlAOIcAZz8rXLoTcJt
         G4LozC50Gcxz5fYfGFNcVCPLEfNUqYQfEU4j0ras=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RCbus6127675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 06:37:56 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 06:37:55 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 06:37:55 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbnvO100207;
        Thu, 27 Feb 2020 06:37:52 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <han.xu@nxp.com>,
        <richard@nod.at>, <mripard@kernel.org>, <wens@csie.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vkoul@kernel.org>
Subject: [PATCH 1/7] mtd: rawnand: gpmi: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Thu, 27 Feb 2020 14:37:43 +0200
Message-ID: <20200227123749.24064-2-peter.ujfalusi@ti.com>
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
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index b9d5d55a5edb..53b00c841aec 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1148,20 +1148,21 @@ static int acquire_dma_channels(struct gpmi_nand_data *this)
 {
 	struct platform_device *pdev = this->pdev;
 	struct dma_chan *dma_chan;
+	int ret = 0;
 
 	/* request dma channel */
-	dma_chan = dma_request_slave_channel(&pdev->dev, "rx-tx");
-	if (!dma_chan) {
-		dev_err(this->dev, "Failed to request DMA channel.\n");
-		goto acquire_err;
+	dma_chan = dma_request_chan(&pdev->dev, "rx-tx");
+	if (IS_ERR(dma_chan)) {
+		ret = PTR_ERR(dma_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(this->dev, "DMA channel request failed: %d\n",
+				ret);
+		release_dma_channels(this);
+	} else {
+		this->dma_chans[0] = dma_chan;
 	}
 
-	this->dma_chans[0] = dma_chan;
-	return 0;
-
-acquire_err:
-	release_dma_channels(this);
-	return -EINVAL;
+	return ret;
 }
 
 static int gpmi_get_clks(struct gpmi_nand_data *this)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

