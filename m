Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA18BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7A82469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgB1DML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:12:11 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:55892 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgB1DML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:12:11 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 01S3BrCn014517; Fri, 28 Feb 2020 12:11:53 +0900
X-Iguazu-Qid: 2wGr5CsUeWlh3XnBYo
X-Iguazu-QSIG: v=2; s=0; t=1582859513; q=2wGr5CsUeWlh3XnBYo; m=cKA1WqBwp9278sMXGhVPx0BJPTbV/bGQvne2zGk28cU=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id 01S3Bqc9003483;
        Fri, 28 Feb 2020 12:11:52 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 01S3Bqu1006791;
        Fri, 28 Feb 2020 12:11:52 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 01S3Bp9k009638;
        Fri, 28 Feb 2020 12:11:52 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v2 1/2] mtd: spinand: toshiba: Rename function name to change suffix and prefix (8Gbit)
Date:   Fri, 28 Feb 2020 12:11:50 +0900
X-TSB-HOP: ON
Message-Id: <41b30e2d308ec7f252d71970a2ed1c29cd25c0d7.1582603241.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582603241.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1582603241.git.ytc-mb-yfuruyama7@kioxia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suffix was changed to classify from "g" to "j" between 1st generation
device and 2nd generation device that's new Serial NAND of Kioxia brand.
As reference that's
1st generation device of 1Gbit product is "tc58cvg0s3hraig"
2nd generation device of 1Gbit product is "tc58cvg0s3hraij".

The 8Gbit product "TH58CxG3S0HRAIJ" is new line up of Kioxia's serial nand
and changed the prefix from tc58 to th58.
Thus it was changed argument to the function from "tc58cxgxsx" to
"tx58cxgxsxraix".

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
---
changelog[v2]:Split 2 patches, and add patch description.

 drivers/mtd/nand/spi/toshiba.c | 60 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 0db5ee4..700d86f 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -25,8 +25,8 @@ static SPINAND_OP_VARIANTS(write_cache_variants,
 static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-static int tc58cxgxsx_ooblayout_ecc(struct mtd_info *mtd, int section,
-				     struct mtd_oob_region *region)
+static int tx58cxgxsxraix_ooblayout_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
 {
 	if (section > 0)
 		return -ERANGE;
@@ -37,8 +37,8 @@ static int tc58cxgxsx_ooblayout_ecc(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-static int tc58cxgxsx_ooblayout_free(struct mtd_info *mtd, int section,
-				      struct mtd_oob_region *region)
+static int tx58cxgxsxraix_ooblayout_free(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *region)
 {
 	if (section > 0)
 		return -ERANGE;
@@ -50,13 +50,13 @@ static int tc58cxgxsx_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-static const struct mtd_ooblayout_ops tc58cxgxsx_ooblayout = {
-	.ecc = tc58cxgxsx_ooblayout_ecc,
-	.free = tc58cxgxsx_ooblayout_free,
+static const struct mtd_ooblayout_ops tx58cxgxsxraix_ooblayout = {
+	.ecc = tx58cxgxsxraix_ooblayout_ecc,
+	.free = tx58cxgxsxraix_ooblayout_free,
 };
 
-static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
-				      u8 status)
+static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
+					 u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
@@ -95,75 +95,75 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 
 static const struct spinand_info toshiba_spinand_table[] = {
 	/* 3.3V 1Gb */
-	SPINAND_INFO("TC58CVG0S3", 0xC2,
+	SPINAND_INFO("TC58CVG0S3HRAIG", 0xC2,
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 2Gb */
-	SPINAND_INFO("TC58CVG1S3", 0xCB,
+	SPINAND_INFO("TC58CVG1S3HRAIG", 0xCB,
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 4Gb */
-	SPINAND_INFO("TC58CVG2S0", 0xCD,
+	SPINAND_INFO("TC58CVG2S0HRAIG", 0xCD,
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 4Gb */
-	SPINAND_INFO("TC58CVG2S0", 0xED,
+	SPINAND_INFO("TC58CVG2S0HRAIJ", 0xED,
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 1Gb */
-	SPINAND_INFO("TC58CYG0S3", 0xB2,
+	SPINAND_INFO("TC58CYG0S3HRAIG", 0xB2,
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 2Gb */
-	SPINAND_INFO("TC58CYG1S3", 0xBB,
+	SPINAND_INFO("TC58CYG1S3HRAIG", 0xBB,
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 4Gb */
-	SPINAND_INFO("TC58CYG2S0", 0xBD,
+	SPINAND_INFO("TC58CYG2S0HRAIG", 0xBD,
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 };
 
 static int toshiba_spinand_detect(struct spinand_device *spinand)
-- 
1.9.1

