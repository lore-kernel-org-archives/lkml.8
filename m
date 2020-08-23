Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B368C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF3C2072D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/uHLHLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHWLLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 07:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgHWLLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 07:11:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F31C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 04:11:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so2851681plk.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YD5/tuFYylE3nC+kaxG7wk/ch1daemiPGvCKQ4+XnlA=;
        b=r/uHLHLc0D6/uJVINt9TdWu+C6BXWithiVksrkI4fB+2FGyqtizWwEO1P/m4quH4Oh
         aj7EsOBbthGl2Qn8esLJ4eTi/7hEGo0Y7UpKDyuaFSRyqRtdurBfx0F4I4Z6LV096xMB
         L+oB7aaQ/wqE0H+N5QFMq8/g3WDA33XuiJPjMcA6lallOaik72bV7tXyvlhn9DQvKNKT
         aL6zFvr8z7mJmtkSnJJJvlv7Iib2kBZ3uw1bYKEHc/94czRC7nIsZ8H5+SNlvJ2ziB8P
         31YsdyPHTgQV5l5pY4sYi7i0L5VT9P53P64WSEoTFETZnhwZIspgJAeP3dmi3LtpOVK4
         ITnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YD5/tuFYylE3nC+kaxG7wk/ch1daemiPGvCKQ4+XnlA=;
        b=h5Ktr8tqo4X7YW9hutlBhTl9dPAcr5YciEOTI45lXvSk62z4f7f/yfjvjt2MUzCqfk
         EWpUED26Hmz6plGRjKdJxkwE5EeoM7VFUPhwI9iFygc1OZ5fwryxBxtgWzzO1GrkUeBE
         oyj3I4YOCYTlXuT90dDYcK8Lm8J2tzdj320JEXdOnz7tlFzuUtZyy0nuUyAS/6+kS9FW
         aHNcCEM3OF8zt8OfC26pcw74cmcmhU2bYZQ2BoUfNf/KI+ILuOyXhUKSPlC2Wq4zkv/0
         4kduizIsQPFQ0V4G4Vgx2+ErlapO5xqHyoYAB090GJlxLJKSo780Jzakytio/1PUg+Ty
         w3aQ==
X-Gm-Message-State: AOAM533rj3I9h8z7K+F2g9ZQJmNi3cSOXxmbnfMLkbNt8quyMuZ6P0NA
        Kcq87u3YZ2qHJ/vLxrWZTC0=
X-Google-Smtp-Source: ABdhPJzw3HwJpr98RnKtRy3ePimjZzv0hGYfy+RZngPcHf7xQkpvvRQTAOYJQ7QEylLr9uxSR5s9BQ==
X-Received: by 2002:a17:90a:450d:: with SMTP id u13mr727702pjg.99.1598181100513;
        Sun, 23 Aug 2020 04:11:40 -0700 (PDT)
Received: from rapsodo.Rapsodo.com ([101.100.171.87])
        by smtp.gmail.com with ESMTPSA id d5sm6625157pjw.18.2020.08.23.04.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 04:11:39 -0700 (PDT)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v2] mtd: spinand: micron: add support for MT29F2G01AAAED
Date:   Sun, 23 Aug 2020 19:14:10 +0800
Message-Id: <20200823111410.13049-1-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
ECC

Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
---
 v2: removed SPINAND_SELECT_TARGET as per the comments & fixed typo errors

 drivers/mtd/nand/spi/micron.c | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5d370cfcdaaa..c21ca395d657 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -18,6 +18,9 @@
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
 #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
 
+/* For Micron MT29F2G01AAAED Device */
+#define MICRON_STATUS_ECC_1TO4_BITFLIPS	(1 << 4)
+
 #define MICRON_CFG_CR			BIT(0)
 
 /*
@@ -44,6 +47,19 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
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
@@ -69,11 +85,41 @@ static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
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
@@ -114,6 +160,27 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
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
@@ -217,6 +284,17 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
+	/* M69A 2Gb 3.3V */
+	SPINAND_INFO("MT29F2G01AAAED",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9F),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 80, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_mt29f2g01aaaed,
+					      &write_cache_variants_mt29f2g01aaaed,
+					      &update_cache_variants_mt29f2g01aaaed),
+		     0,
+		     SPINAND_ECCINFO(&mt29f2g01aaaed_ooblayout,
+				     mt29f2g01aaaed_ecc_get_status),
 };
 
 static int micron_spinand_init(struct spinand_device *spinand)
-- 
2.17.1

