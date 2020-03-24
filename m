Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B32C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838DF20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCXGuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:50:03 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:55642 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCXGuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:50:03 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 02O6nmWl029457; Tue, 24 Mar 2020 15:49:48 +0900
X-Iguazu-Qid: 34trcFcTRI9OQ3pVZs
X-Iguazu-QSIG: v=2; s=0; t=1585032588; q=34trcFcTRI9OQ3pVZs; m=EmoQwMXMklS5qfdk+YmVEVG4lj5CgLLx7pina2cL0mQ=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id 02O6nlgQ014411;
        Tue, 24 Mar 2020 15:49:47 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 02O765XO026120;
        Tue, 24 Mar 2020 16:06:05 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 02O6nkWB010175;
        Tue, 24 Mar 2020 15:49:47 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v5 1/2] mtd: spinand: toshiba: Rename function name to change suffix and prefix (8Gbit)
Date:   Tue, 24 Mar 2020 15:49:44 +0900
X-TSB-HOP: ON
Message-Id: <0dedd9869569a17625822dba87878254d253ba0e.1584949601.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1584949601.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1584949601.git.ytc-mb-yfuruyama7@kioxia.com>
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
changelog[v5]:Remake on -rc6.
changelog[v4]:Remake on top of the last -rc.
changelog[v3]:Fixed commit message to make it easier to understand.
changelog[v2]:Split 2 patches, and add patch description.

 drivers/mtd/nand/spi/toshiba.c | 60 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index d347731..5d217dd 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -26,8 +26,8 @@ static SPINAND_OP_VARIANTS(write_cache_variants,
 static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-static int tc58cxgxsx_ooblayout_ecc(struct mtd_info *mtd, int section,
-				     struct mtd_oob_region *region)
+static int tx58cxgxsxraix_ooblayout_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
 {
 	if (section > 0)
 		return -ERANGE;
@@ -38,8 +38,8 @@ static int tc58cxgxsx_ooblayout_ecc(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-static int tc58cxgxsx_ooblayout_free(struct mtd_info *mtd, int section,
-				      struct mtd_oob_region *region)
+static int tx58cxgxsxraix_ooblayout_free(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *region)
 {
 	if (section > 0)
 		return -ERANGE;
@@ -51,13 +51,13 @@ static int tc58cxgxsx_ooblayout_free(struct mtd_info *mtd, int section,
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
@@ -96,7 +96,7 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 
 static const struct spinand_info toshiba_spinand_table[] = {
 	/* 3.3V 1Gb */
-	SPINAND_INFO("TC58CVG0S3",
+	SPINAND_INFO("TC58CVG0S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xC2),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -104,10 +104,10 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 2Gb */
-	SPINAND_INFO("TC58CVG1S3",
+	SPINAND_INFO("TC58CVG1S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xCB),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -115,10 +115,10 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 4Gb */
-	SPINAND_INFO("TC58CVG2S0",
+	SPINAND_INFO("TC58CVG2S0HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xCD),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -126,10 +126,10 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 3.3V 4Gb */
-	SPINAND_INFO("TC58CVG2S0",
+	SPINAND_INFO("TC58CVG2S0HRAIJ",
 			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xED),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -137,10 +137,10 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 1Gb */
-	SPINAND_INFO("TC58CYG0S3",
+	SPINAND_INFO("TC58CYG0S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xB2),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -148,10 +148,10 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 2Gb */
-	SPINAND_INFO("TC58CYG1S3",
+	SPINAND_INFO("TC58CYG1S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xBB),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -159,10 +159,10 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 	/* 1.8V 4Gb */
-	SPINAND_INFO("TC58CYG2S0",
+	SPINAND_INFO("TC58CYG2S0HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xBD),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -170,8 +170,8 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
-				     tc58cxgxsx_ecc_get_status)),
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
-- 
1.9.1

