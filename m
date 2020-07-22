Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185DAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A442077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgGVIur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:50:47 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:40495 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgGVIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:50:47 -0400
X-Greylist: delayed 2814 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 04:50:47 EDT
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 06M83qEr003038
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:03:52 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 06M83Cpj002700;
        Wed, 22 Jul 2020 16:03:26 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
From:   YouChing Lin <ycllin@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        juliensu@mxic.com.tw, YouChing Lin <ycllin@mxic.com.tw>
Subject: [PATCH 1/2] mtd: spinand: macronix: Add support for MX31LF1GE4BC
Date:   Wed, 22 Jul 2020 16:02:57 +0800
Message-Id: <1595404978-31079-2-git-send-email-ycllin@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1595404978-31079-1-git-send-email-ycllin@mxic.com.tw>
References: <1595404978-31079-1-git-send-email-ycllin@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 06M83Cpj002700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Macronix MX31LF1GE4BC is a 3V, 1Gbit (128MB) serial
NAND flash device.

Validated by read, erase, read back, write and read back
on Xilinx Zynq PicoZed FPGA board which included
Macronix SPI Host (driver/spi/spi-mxic.c).

Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 0f900f3..c9aa9f4 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -118,6 +118,16 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX31LF1GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0 /*SPINAND_HAS_QE_BIT*/,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
-- 
1.9.1

