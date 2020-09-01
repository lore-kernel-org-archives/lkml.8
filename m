Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB29206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979046;
	bh=pqqc4i70zurQCjFY04KGJlNOtStPEkL0SfWqdT9iNNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zGt32eR5Hv5dbN/1ex1DtgW0S2i0nt6UISeQvbBal1F3esLlcvmV5XWTtAN09mPyP
	 ghITyaHeqd4okPOBSJT6oH/exkovve1ADpO0OiLhYkEtHJGgfcsH40jQykuqpM2QTL
	 37e/tMLghkHcjY/7XBXcHUA0OjU/yXkNYqwxeQgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgIAQup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgIAP0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:26:18 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5002151B;
        Tue,  1 Sep 2020 15:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973978;
        bh=pqqc4i70zurQCjFY04KGJlNOtStPEkL0SfWqdT9iNNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXk3liogyOzR6hy4xq+6tcYuqi1Pp4DPggmTuH4tB07OTDyvcGZSh5s95yZbJhUEd
         QlH6B/F9HJn/6dRx3g7UX/pWQiMHNQ6vpAfzesJekg77ezj8TbzROX6rmc4vFGaBAJ
         mO/IElkrXG55wVB14GuCWndO3NK9I9u01mUhcGs0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Han Xu <han.xu@nxp.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 6/6] mtd: rawnand: qcom: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 16:25:35 +0200
Message-Id: <20200901142535.12819-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901142535.12819-1-krzk@kernel.org>
References: <20200901142535.12819-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index bd7a7251429b..31d6b9682e3d 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2702,10 +2702,8 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 		if (IS_ERR(nandc->tx_chan)) {
 			ret = PTR_ERR(nandc->tx_chan);
 			nandc->tx_chan = NULL;
-			if (ret != -EPROBE_DEFER)
-				dev_err(nandc->dev,
-					"tx DMA channel request failed: %d\n",
-					ret);
+			dev_err_probe(nandc->dev, ret,
+				      "tx DMA channel request failed\n");
 			goto unalloc;
 		}
 
@@ -2713,10 +2711,8 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 		if (IS_ERR(nandc->rx_chan)) {
 			ret = PTR_ERR(nandc->rx_chan);
 			nandc->rx_chan = NULL;
-			if (ret != -EPROBE_DEFER)
-				dev_err(nandc->dev,
-					"rx DMA channel request failed: %d\n",
-					ret);
+			dev_err_probe(nandc->dev, ret,
+				      "rx DMA channel request failed\n");
 			goto unalloc;
 		}
 
@@ -2724,10 +2720,8 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 		if (IS_ERR(nandc->cmd_chan)) {
 			ret = PTR_ERR(nandc->cmd_chan);
 			nandc->cmd_chan = NULL;
-			if (ret != -EPROBE_DEFER)
-				dev_err(nandc->dev,
-					"cmd DMA channel request failed: %d\n",
-					ret);
+			dev_err_probe(nandc->dev, ret,
+				      "cmd DMA channel request failed\n");
 			goto unalloc;
 		}
 
@@ -2750,10 +2744,8 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 		if (IS_ERR(nandc->chan)) {
 			ret = PTR_ERR(nandc->chan);
 			nandc->chan = NULL;
-			if (ret != -EPROBE_DEFER)
-				dev_err(nandc->dev,
-					"rxtx DMA channel request failed: %d\n",
-					ret);
+			dev_err_probe(nandc->dev, ret,
+				      "rxtx DMA channel request failed\n");
 			return ret;
 		}
 	}
-- 
2.17.1

