Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC38C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37D32073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFDJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:09:03 -0500
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:55682 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgCFDJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:09:03 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 02638mXr029245; Fri, 6 Mar 2020 12:08:48 +0900
X-Iguazu-Qid: 2wGrDj8Mc35JYvFk0m
X-Iguazu-QSIG: v=2; s=0; t=1583464128; q=2wGrDj8Mc35JYvFk0m; m=30XSXFJA1rnp94hRBnSOkpVXRTzIW0024bvn1q+XQp0=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1113) id 02638l6W008534;
        Fri, 6 Mar 2020 12:08:48 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 02638lrE020487;
        Fri, 6 Mar 2020 12:08:47 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 02638kFH000418;
        Fri, 6 Mar 2020 12:08:46 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3 1/2] mtd: spinand: toshiba: Rename function name to change suffix and prefix (8Gbit)
Date:   Fri,  6 Mar 2020 12:08:44 +0900
X-TSB-HOP: ON
Message-Id: <d6d53d2b5723e7c8b1818080626d0f0a48bb17d8.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suffix was changed from "G" to "J" to classify between 1st generation
and 2nd generation serial NAND devices (which now belong to the Kioxia
brand).
As reference that's
1st generation device of 1Gbit product is "TC58CVG0S3HRAIG"
2nd generation device of 1Gbit product is "TC58CVG0S3HRAIJ".

The 8Gbit type "TH58CxG3S0HRAIJ" is new to Kioxia's serial NAND lineup and
the prefix was changed from "TC58" to "TH58".

Thus the functions were renamed from tc58cxgxsx_*() to tx58cxgxsxraix_*().

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
changelog[v3]:Fixed commit message to make it easier to understand.
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

