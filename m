Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54320C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0979121D95
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf0FBTPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIIKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIIKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:41:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C58C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 03:41:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1143836pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 03:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jMmvyrW+ZElVGTX7LX4dirnjquiIC/ocjxrUYPDYShY=;
        b=Kf0FBTPwsnIc+2SL9raQl61h0SIDSu8a2lstsrnbVvwRGlMcj9avkntI/LHX5PvqqK
         /nPPLQRtLosvGwx5nyUtyCWrxIhX/pgT+yhz3D/b3tJNeZD5SaSv7OcDjcoo2VLz7Hhj
         D1onKjrb/nQFRPntb95KdnICoXRySkqHSDJsaQ02rOyU04T0GEg1gJH7x6YLEnCW74rv
         QFZvcGBVS7KzsGPfAaVVGoreJCi+Rr8kSjie2dIad/72RR1GFX/PZsofAVSJbKRZfCHb
         E/LOAMhMKWUD8kLA9+yFjS5XoZAuVKHAUfK6X6yOxXLaIq2kBvBHuDtpBriVtdQQukU8
         HQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jMmvyrW+ZElVGTX7LX4dirnjquiIC/ocjxrUYPDYShY=;
        b=s7Jr7eNVkjHmEFqpTx5sfNSsTBwfOFysofp6Oh/RfFUaLUCnSxpKS/n2iQd2QaT2FF
         TydUa/+7ZVLCnvyhe1QG9rIfNHyH+i6jqXy4/geuz+ykbfLZjzmgZreyLhHWkYsQXxDz
         uGUTKHDATGw9zen5bCn3JkQfSxwFEJrcgiEVIxKe4YEszflyH0g66iWhXyM73iMd4aov
         X/eL8QAFQXqb59o1B4xTo7u2lCaYDWcsBFsc2XzvNzt2YZzciF0UjuFyRYvPKJ8xIVEe
         Ll8DNc/tvP3rCSHuv9xJQMqhag8uugh2ugvUyRHWFKefbVJOKG3jAbUWDcnE/nyrCU6b
         o2Cg==
X-Gm-Message-State: AOAM530c4q95PTQaa+d70xHV2MT/qhKjIGGYqvaR87oDrFvu+xhuNd6I
        EswAyOTQ72Fb6kmZMQ8mG60=
X-Google-Smtp-Source: ABdhPJxNAGTjGIEEJ22q5j8+QO5ZbIXcB3coZ6mvvNQVawPkG/0XCMZXzy1twUfr5w9eynG32C481A==
X-Received: by 2002:a17:90a:e513:: with SMTP id t19mr270769pjy.137.1599648088652;
        Wed, 09 Sep 2020 03:41:28 -0700 (PDT)
Received: from rapsodo.Rapsodo.com ([101.100.171.87])
        by smtp.gmail.com with ESMTPSA id s22sm2543301pfd.90.2020.09.09.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 03:41:27 -0700 (PDT)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v3] mtd: spinand: micron: add support for MT29F2G01AAAED
Date:   Wed,  9 Sep 2020 18:44:42 +0800
Message-Id: <20200909104442.22171-1-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
ECC

Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
---
 drivers/mtd/nand/spi/micron.c | 141 ++++++++++++++++++++++++----------
 1 file changed, 101 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5d370cfcdaaa..fa8c20f37611 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -28,7 +28,7 @@
 
 #define MICRON_SELECT_DIE(x)	((x) << 6)
 
-static SPINAND_OP_VARIANTS(read_cache_variants,
+static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
@@ -36,14 +36,27 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
 
-static SPINAND_OP_VARIANTS(write_cache_variants,
+static SPINAND_OP_VARIANTS(x4_write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD(true, 0, NULL, 0));
 
-static SPINAND_OP_VARIANTS(update_cache_variants,
+static SPINAND_OP_VARIANTS(x4_update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
+/* Micron  MT29F2G01AAAED Device */
+static SPINAND_OP_VARIANTS(x4_read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(x1_write_cache_variants,
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(x1_update_cache_variants,
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
 static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -69,11 +82,49 @@ static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-static const struct mtd_ooblayout_ops micron_8_ooblayout = {
+static int mt29f2g01aaaed_ooblayout_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+
+	if (section >= spinand->base.memorg.pagesize /
+			mtd->ecc_step_size)
+		return -ERANGE;
+
+	region->offset = (section * 16) + 8;
+	region->length = 8;
+
+	return 0;
+}
+
+static int mt29f2g01aaaed_ooblayout_free(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *region)
+{
+	if (section >= 4)
+		return -ERANGE;
+
+	if (section) {
+		region->offset = 16 * section;
+		region->length = 8;
+	} else {
+		/* section 0 has two bytes reserved for the BBM */
+		region->offset = 2;
+		region->length = 6;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops micron_grouped_ooblayout = {
 	.ecc = micron_8_ooblayout_ecc,
 	.free = micron_8_ooblayout_free,
 };
 
+static const struct mtd_ooblayout_ops micron_interleaved_ooblayout = {
+	.ecc = mt29f2g01aaaed_ooblayout_ecc,
+	.free = mt29f2g01aaaed_ooblayout_free,
+};
+
 static int micron_select_target(struct spinand_device *spinand,
 				unsigned int target)
 {
@@ -120,55 +171,55 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M79A 2Gb 1.8V */
 	SPINAND_INFO("MT29F2G01ABBGD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M78A 1Gb 3.3V */
 	SPINAND_INFO("MT29F1G01ABAFD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M78A 1Gb 1.8V */
 	SPINAND_INFO("MT29F1G01ABAFD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M79A 4Gb 3.3V */
 	SPINAND_INFO("MT29F4G01ADAGD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x36),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 80, 2, 1, 2),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
 	/* M70A 4Gb 3.3V */
@@ -176,33 +227,33 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x34),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     SPINAND_HAS_CR_FEAT_BIT,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M70A 4Gb 1.8V */
 	SPINAND_INFO("MT29F4G01ABBFD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     SPINAND_HAS_CR_FEAT_BIT,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M70A 8Gb 3.3V */
 	SPINAND_INFO("MT29F8G01ADAFD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x46),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     SPINAND_HAS_CR_FEAT_BIT,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
 	/* M70A 8Gb 1.8V */
@@ -210,13 +261,23 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x47),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     SPINAND_HAS_CR_FEAT_BIT,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
+	/* M69A 2Gb 3.3V */
+	SPINAND_INFO("MT29F2G01AAAED",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9F),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 80, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&x4_read_cache_variants,
+					      &x1_write_cache_variants,
+					      &x1_update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_interleaved_ooblayout, NULL)),
 };
 
 static int micron_spinand_init(struct spinand_device *spinand)
-- 
2.17.1

