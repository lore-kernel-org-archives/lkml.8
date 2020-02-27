Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44EBC4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CD424695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FskWtjnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgB0MiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:38:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38656 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgB0MiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:38:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RCc5t7117401;
        Thu, 27 Feb 2020 06:38:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582807085;
        bh=rajg4uTg/TEsV6CsUleF0jbc10ghlyv7bjJVEvPVLiU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FskWtjnNY3OwRDzpQjNUVBsqmFuGzzDUUaB6Knvmlo3V0fmrNa5PSNlX6+uQd4cHG
         4fSA44R8tHLbSovbpRwMeoWwDoY6uBMUwGT1TmvE3AygtePsainRv6ZOTv7O/PtMrS
         q4TLs6F981JAxJOz2AWqn0fBGOd2EJHz3XpJXsDM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RCc5kG117291
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 06:38:05 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 06:38:04 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 06:38:05 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbnvR100207;
        Thu, 27 Feb 2020 06:38:02 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <han.xu@nxp.com>,
        <richard@nod.at>, <mripard@kernel.org>, <wens@csie.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vkoul@kernel.org>
Subject: [PATCH 4/7] mtd: rawnand: sunxi: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Thu, 27 Feb 2020 14:37:46 +0200
Message-ID: <20200227123749.24064-5-peter.ujfalusi@ti.com>
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

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 37a4ac0dd85b..3a24c4512af7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2123,8 +2123,16 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_ahb_reset_reassert;
 
-	nfc->dmac = dma_request_slave_channel(dev, "rxtx");
-	if (nfc->dmac) {
+	nfc->dmac = dma_request_chan(dev, "rxtx");
+	if (IS_ERR(nfc->dmac)) {
+		ret = PTR_ERR(nfc->dmac);
+		if (ret == -EPROBE_DEFER)
+			goto out_ahb_reset_reassert;
+
+		/* Ignore errors to fall back to PIO mode */
+		dev_warn(dev, "failed to request rxtx DMA channel: %d\n", ret);
+		nfc->dmac = NULL;
+	} else {
 		struct dma_slave_config dmac_cfg = { };
 
 		dmac_cfg.src_addr = r->start + nfc->caps->reg_io_data;
@@ -2138,9 +2146,6 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 		if (nfc->caps->extra_mbus_conf)
 			writel(readl(nfc->regs + NFC_REG_CTL) |
 			       NFC_DMA_TYPE_NORMAL, nfc->regs + NFC_REG_CTL);
-
-	} else {
-		dev_warn(dev, "failed to request rxtx DMA channel\n");
 	}
 
 	platform_set_drvdata(pdev, nfc);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

