Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47CDC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765DB20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978271;
	bh=dmuzdEMkWpJ2XunLy5TWSr/ChN5Y2eJJuRVReEFs1o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iw7oKwmZAkAT0RjoynUVndkbwGG1+FpBYvZhHOcTiNBBDMMUenVbPkzNwizafLP9c
	 CdStva9EagOTLDg/AydwlIXquFgNKtVQqVtPCAyf+baYsw6EMPXZSsgB6d4zChRym1
	 L5fNUU/IIiGID2eQqUDpedDClBxXeR11X1GjCb7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgIAP3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbgIAP0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:26:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC482151B;
        Tue,  1 Sep 2020 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973963;
        bh=dmuzdEMkWpJ2XunLy5TWSr/ChN5Y2eJJuRVReEFs1o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7+IM86krsVpZqXeWOsl7Hl53BXun2lQDzl3t/nJFFL0zhoFU5iuqUywOQoFtdv+v
         AsGipIUi3I8al3evi43iyzt7mwxwg4hkociDaHxNk2OmDtv/9kL2rJ9dDmknQ5gl+8
         vdQY/uMsVqSh1hpyvIzJ4WMdYp1phgli4sq3w7jA=
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
Subject: [PATCH 2/6] mtd: rawnand: atmel: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 16:25:31 +0200
Message-Id: <20200901142535.12819-2-krzk@kernel.org>
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
 drivers/mtd/nand/raw/atmel/nand-controller.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index c9818f548d07..71e2b83485d7 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1976,13 +1976,9 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 	platform_set_drvdata(pdev, nc);
 
 	nc->pmecc = devm_atmel_pmecc_get(dev);
-	if (IS_ERR(nc->pmecc)) {
-		ret = PTR_ERR(nc->pmecc);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Could not get PMECC object (err = %d)\n",
-				ret);
-		return ret;
-	}
+	if (IS_ERR(nc->pmecc))
+		return dev_err_probe(dev, PTR_ERR(nc->pmecc),
+				     "Could not get PMECC object\n");
 
 	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
 		dma_cap_mask_t mask;
-- 
2.17.1

