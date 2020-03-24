Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C3C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079B42074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCXGuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:50:17 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:42204 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgCXGuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:50:17 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 02O6o0Ba026637; Tue, 24 Mar 2020 15:50:00 +0900
X-Iguazu-Qid: 34tr8v5eghfvG4TZMC
X-Iguazu-QSIG: v=2; s=0; t=1585032600; q=34tr8v5eghfvG4TZMC; m=/7nmUVTWLyYkH6rqmc7z7TbPbeiBWQL0xIEADdhLLbw=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 02O6nxCO009961;
        Tue, 24 Mar 2020 15:49:59 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 02O6nxjY010007;
        Tue, 24 Mar 2020 15:49:59 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 02O6nwOg030180;
        Tue, 24 Mar 2020 15:49:59 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v5 2/2] mtd: spinand: toshiba: Support for new Kioxia Serial NAND
Date:   Tue, 24 Mar 2020 15:49:55 +0900
X-TSB-HOP: ON
Message-Id: <aa69e455beedc5ce0d7141359b9364ed8aec9e65.1584949601.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1584949601.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1584949601.git.ytc-mb-yfuruyama7@kioxia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new Kioxia products.
The new Kioxia products support program load x4 command, and have
HOLD_D bit which is equivalent to QE bit.

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
changelog[v5]:Remake on -rc6.
changelog[v4]:Remake on top of the last -rc.
changelog[v3]:No change.
changelog[v2]:Split 2 patches.

 drivers/mtd/nand/spi/toshiba.c | 128 +++++++++++++++++++++++++++++++++++------
 1 file changed, 111 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 5d217dd..bc801d8 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -20,6 +20,18 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
 
+static SPINAND_OP_VARIANTS(write_cache_x4_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_x4_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+/**
+ * Backward compatibility for 1st generation Serial NAND devices
+ * which don't support Quad Program Load operation.
+ */
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD(true, 0, NULL, 0));
 
@@ -95,7 +107,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info toshiba_spinand_table[] = {
-	/* 3.3V 1Gb */
+	/* 3.3V 1Gb (1st generation) */
 	SPINAND_INFO("TC58CVG0S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xC2),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -106,7 +118,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 3.3V 2Gb */
+	/* 3.3V 2Gb (1st generation) */
 	SPINAND_INFO("TC58CVG1S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xCB),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -117,7 +129,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 3.3V 4Gb */
+	/* 3.3V 4Gb (1st generation) */
 	SPINAND_INFO("TC58CVG2S0HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xCD),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -128,18 +140,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 3.3V 4Gb */
-	SPINAND_INFO("TC58CVG2S0HRAIJ",
-			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xED),
-		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
-		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
-		     0,
-		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
-	/* 1.8V 1Gb */
+	/* 1.8V 1Gb (1st generation) */
 	SPINAND_INFO("TC58CYG0S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xB2),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -150,7 +151,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 1.8V 2Gb */
+	/* 1.8V 2Gb (1st generation) */
 	SPINAND_INFO("TC58CYG1S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xBB),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -161,7 +162,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 1.8V 4Gb */
+	/* 1.8V 4Gb (1st generation) */
 	SPINAND_INFO("TC58CYG2S0HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xBD),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -172,6 +173,99 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
+
+	/*
+	 * 2nd generation serial nand has HOLD_D which is equivalent to
+	 * QE_BIT.
+	 */
+	/* 3.3V 1Gb (2nd generation) */
+	SPINAND_INFO("TC58CVG0S3HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE2),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 3.3V 2Gb (2nd generation) */
+	SPINAND_INFO("TC58CVG1S3HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEB),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 3.3V 4Gb (2nd generation) */
+	SPINAND_INFO("TC58CVG2S0HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xED),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 3.3V 8Gb (2nd generation) */
+	SPINAND_INFO("TH58CVG3S0HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 1Gb (2nd generation) */
+	SPINAND_INFO("TC58CYG0S3HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xD2),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 2Gb (2nd generation) */
+	SPINAND_INFO("TC58CYG1S3HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xDB),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 4Gb (2nd generation) */
+	SPINAND_INFO("TC58CYG2S0HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xDD),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 8Gb (2nd generation) */
+	SPINAND_INFO("TH58CYG3S0HRAIJ",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xD4),
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
-- 
1.9.1

