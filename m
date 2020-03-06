Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646892072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFDFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:05:32 -0500
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:48054 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFDFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:05:31 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 02635Hwn016770; Fri, 6 Mar 2020 12:05:17 +0900
X-Iguazu-Qid: 2wGrZsIRE9x4JsUiaA
X-Iguazu-QSIG: v=2; s=0; t=1583463916; q=2wGrZsIRE9x4JsUiaA; m=8eRUmWIC3godALj9xZbSEUsjiS77yQSOH4/Jn/h1+FA=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1113) id 02635FHR001348;
        Fri, 6 Mar 2020 12:05:15 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 02635FEb014487;
        Fri, 6 Mar 2020 12:05:15 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 02635FRa021523;
        Fri, 6 Mar 2020 12:05:15 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3 2/2] mtd: spinand: toshiba: Support for new Kioxia Serial NAND
Date:   Fri,  6 Mar 2020 12:05:13 +0900
X-TSB-HOP: ON
Message-Id:
 <fcd0899a764689dde17fa8d776d59dde8265b796.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200306030513.kCjsZjIuEDLSuFdM6_5iKyQUnXoOoqQI9Jj8dlseltA@z>

Add support for new Kioxia products.
The new Kioxia products support program load x4 command, and have
HOLD_D bit which is equivalent to QE bit.

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
changelog[v3]:No change.
changelog[v2]:Split 2 patches.

 drivers/mtd/nand/spi/toshiba.c | 119 +++++++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 700d86f..505f9f5 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -19,6 +19,18 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
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
 
@@ -94,7 +106,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info toshiba_spinand_table[] = {
-	/* 3.3V 1Gb */
+	/* 3.3V 1Gb (1st generation) */
 	SPINAND_INFO("TC58CVG0S3HRAIG", 0xC2,
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -104,7 +116,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 3.3V 2Gb */
+	/* 3.3V 2Gb (1st generation) */
 	SPINAND_INFO("TC58CVG1S3HRAIG", 0xCB,
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -114,7 +126,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 3.3V 4Gb */
+	/* 3.3V 4Gb (1st generation) */
 	SPINAND_INFO("TC58CVG2S0HRAIG", 0xCD,
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -124,17 +136,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 3.3V 4Gb */
-	SPINAND_INFO("TC58CVG2S0HRAIJ", 0xED,
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
 	SPINAND_INFO("TC58CYG0S3HRAIG", 0xB2,
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -144,7 +146,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 1.8V 2Gb */
+	/* 1.8V 2Gb (1st generation) */
 	SPINAND_INFO("TC58CYG1S3HRAIG", 0xBB,
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -154,7 +156,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
-	/* 1.8V 4Gb */
+	/* 1.8V 4Gb (1st generation) */
 	SPINAND_INFO("TC58CYG2S0HRAIG", 0xBD,
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -164,6 +166,91 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
+
+	/*
+	 * 2nd generation serial nand has HOLD_D which is equivalent to
+	 * QE_BIT.
+	 */
+	/* 3.3V 1Gb (2nd generation) */
+	SPINAND_INFO("TC58CVG0S3HRAIJ", 0xE2,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 3.3V 2Gb (2nd generation) */
+	SPINAND_INFO("TC58CVG1S3HRAIJ", 0xEB,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 3.3V 4Gb (2nd generation) */
+	SPINAND_INFO("TC58CVG2S0HRAIJ", 0xED,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 3.3V 8Gb (2nd generation) */
+	SPINAND_INFO("TH58CVG3S0HRAIJ", 0xE4,
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 1Gb (2nd generation) */
+	SPINAND_INFO("TC58CYG0S3HRAIJ", 0xD2,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 2Gb (2nd generation) */
+	SPINAND_INFO("TC58CYG1S3HRAIJ", 0xDB,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 4Gb (2nd generation) */
+	SPINAND_INFO("TC58CYG2S0HRAIJ", 0xDD,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 8Gb (2nd generation) */
+	SPINAND_INFO("TH58CYG3S0HRAIJ", 0xD4,
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 };
 
 static int toshiba_spinand_detect(struct spinand_device *spinand)
-- 
1.9.1

