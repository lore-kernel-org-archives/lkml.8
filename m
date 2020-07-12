Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A3320674
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZUYXIBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGLN5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgGLN5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:57:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF4EC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 06:57:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d194so4814729pga.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t1DD21hpudIl7FcxmIGxgkbZcJ2yGSiWAAezO5F79aU=;
        b=CZUYXIBZoVXVChixa0O/K3kXm7Ewilu0RFQ7/4JPxQxJaX8gN28WnJm5kSrLnTpUsN
         2KJbBZCFQ0tzbK1A/DjuWDwic1QLIYXrOpN19GqYSE4/k0C8Kada89vUPDEGb3Ik2opQ
         RGauVFFXSonL5FOtD6hPw/SXjSbEtD6NkRjRcXYRBrhYLOrFQuJKRNlFSSHGyM/xtMnU
         etnecfT2zZSfIaVJQqJnTymtuLYpBxi+dSoGcB5c5hemrNtV4j1S+qlL3LxA+70gDUKn
         RIwGsPyQLjvqFEKa6IOStVyD04Ejj456//Ut7v7lyQ3FvjeBWYEeUDm1OQtfdrBDHGsT
         zE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t1DD21hpudIl7FcxmIGxgkbZcJ2yGSiWAAezO5F79aU=;
        b=iQPHtYRZXH+gOII/Jdyi4ZBnbY2TcbRVvBJTTy1Z5x90sgzM9Ye8f4SOB+kXCyQgFF
         nSrXGwi0+lcrxhJ3QHLNra9k1vNu1RnU0dilChbOD+PyxHIUYmE8hDgYAnbGnRebd1/+
         7BaFlkKTX5NCMik03dq0XojVJKRX1o1AwTmDZkSKlY2cAtX4AbdZc6O7M69os+acpitD
         4/XSI8W1BHRFjYfesX6PBfNOrNRI0qaTIqKJLMh0qy6dD9iULNgcffLdh0H1OC8JDync
         9aIAUQjLunJBaLe2oPCdvC7ESPMHZntJRczR1qrW9gTmLSVDITAJQn2f+GTbH4uQurO8
         SILQ==
X-Gm-Message-State: AOAM5329NGhYXLt4SrbT0GRSfc2i5hDwSveUOI/yL1CPDEjfv5KtM31V
        l6HDsC5gMFEmVxxM7LswahY=
X-Google-Smtp-Source: ABdhPJw7BzcwvU8d0O+5AuIwLNw0BQrrJ8O1PDi9wenGTXVIm6dEfVg1zNrbKn7/ozhP/RJYPCcM0w==
X-Received: by 2002:a63:b546:: with SMTP id u6mr28953675pgo.381.1594562271696;
        Sun, 12 Jul 2020 06:57:51 -0700 (PDT)
Received: from rapsodo.Rapsodo.com ([101.100.171.87])
        by smtp.gmail.com with ESMTPSA id o4sm11682022pjo.16.2020.07.12.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 06:57:50 -0700 (PDT)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH] mtd: spinand: micron: add support for MT29F2G01AAAED
Date:   Sun, 12 Jul 2020 21:59:42 +0800
Message-Id: <20200712135942.10904-1-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
ECC

Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
---
 drivers/mtd/nand/spi/micron.c | 77 +++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5d370cfcdaaa..7e0b61d7b90f 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -17,6 +17,7 @@
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
 #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
+#define MICRON_STATUS_ECC_1TO4_BITFLIPS	(1 << 4)
 
 #define MICRON_CFG_CR			BIT(0)
 
@@ -44,6 +45,19 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
+/* Micron  MT29F2G01AAAED Device */
+static SPINAND_OP_VARIANTS(read_cache_variants_mt29f2g01aaaed,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants_mt29f2g01aaaed,
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants_mt29f2g01aaaed,
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
 static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -69,11 +83,41 @@ static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static int mt29f2g01aaaed_ooblayout_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section >= 4)
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
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = (section * 16) + 2;
+	region->length = 6;
+
+	return 0;
+}
+
 static const struct mtd_ooblayout_ops micron_8_ooblayout = {
 	.ecc = micron_8_ooblayout_ecc,
 	.free = micron_8_ooblayout_free,
 };
 
+static const struct mtd_ooblayout_ops mt29f2g01aaaed_ooblayout = {
+	.ecc = mt29f2g01aaaed_ooblayout_ecc,
+	.free = mt29f2g01aaaed_ooblayout_free,
+};
+
 static int micron_select_target(struct spinand_device *spinand,
 				unsigned int target)
 {
@@ -114,6 +158,27 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+static int mt29f2g01aaaed_ecc_get_status(struct spinand_device *spinand,
+					 u8 status)
+{
+	switch (status & MICRON_STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	/* 1 to 4-bit error detected and corrected */
+	case MICRON_STATUS_ECC_1TO4_BITFLIPS:
+		return 4;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static const struct spinand_info micron_spinand_table[] = {
 	/* M79A 2Gb 3.3V */
 	SPINAND_INFO("MT29F2G01ABAGD",
@@ -217,6 +282,18 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
+	/* M70A 2Gb 3.3V */
+	SPINAND_INFO("MT29F2G01AAAED",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9F),
+		     NAND_MEMORG(1, 2048, 256, 64, 2048, 80, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_mt29f2g01aaaed,
+					      &write_cache_variants_mt29f2g01aaaed,
+					      &update_cache_variants_mt29f2g01aaaed),
+		     0,
+		     SPINAND_ECCINFO(&mt29f2g01aaaed_ooblayout,
+				     mt29f2g01aaaed_ecc_get_status),
+		     SPINAND_SELECT_TARGET(micron_select_target)),
 };
 
 static int micron_spinand_init(struct spinand_device *spinand)
-- 
2.17.1

