Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5107EC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206CB21927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxhr0TnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgBFUYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:24:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54712 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBFUYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:24:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id g1so229407wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3dLHbgqnxzITEPk0xVr2q4acu5k1gqYIJuRiRDYsyfM=;
        b=jxhr0TnMonMJJu8Byv9wwBeMUGPmV2t5n4m5e6tv1WCbMtrujFvOyDobJGMgjPRcXn
         SvNaXcznk2vynoJvVeqA/Z8FETgeS+7oIKEjEGSzpP0s9IwFetTOMpD/I1k+N6jSUgzb
         Okd54zoXmzx4xJqIzyNc7UUZyixelsFtbpDBlQCL/Bq7QmVidkG9h0q/5aDgT/+PVf1J
         IVehYXZEwTEeqtzbYMDP1n8l4uWAMpWXKF8OF9LAWXWldEsNSPHqtXnwWys+UmF6uKju
         0pYdtoTIKMR5Iu71EcPsMuJzXR/FFplsbPniXK/r91iI++4I6YN02fHS7Sa2sFeDIX8u
         Llpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3dLHbgqnxzITEPk0xVr2q4acu5k1gqYIJuRiRDYsyfM=;
        b=e7GcOL1KETbMBf/O3M8mgxp2NMccH+I/QwVie9tQJ/vfhQ1by7SU1M88Ex6o9k6pKO
         RQV7z/s5SAvng9maR5uVkLbHmGVS/O5IYGcxlNKdi1hmUQPNDII89grsSJfoRbdUQqzC
         fMxOy7R4HvcNap0wdt2wxs+N+2Skgi5pxg0/VtUX+Jjq4+OtkE+RiaaixYSSgHTBEeUV
         IXnYJtjVuPFKJwxSJipPcASNta8bdVBDoIq6d7a02CFCMGxee6E4WMWGvVYWYgMIlRw9
         Z0GjgcWI9DTW2K5qJ6P0POLJSWpqEN7J/o3TMs28BpGQsjnQ30xUXHIP8e8BYXB432h+
         NIrQ==
X-Gm-Message-State: APjAAAUxM+yO2Pl60WguvFNnZ/npRx/w25Sh9snXO542k/eA0vJNyZJA
        Y6MzQAfiELyePItN4PAK7OA=
X-Google-Smtp-Source: APXvYqyL8GPV+I2x3uNCsh7w/h15UQdozgbNLBioz7uqTzkfLRWnNUri5Am72ymP5kje+CRc6EJNpA==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr6395135wmg.34.1581020680609;
        Thu, 06 Feb 2020 12:24:40 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c13sm539929wrx.9.2020.02.06.12.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:24:40 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v4 5/5] mtd: spinand: micron: Add new Micron SPI NAND devices with multiple dies
Date:   Thu,  6 Feb 2020 21:22:06 +0100
Message-Id: <20200206202206.14770-6-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206202206.14770-1-sshivamurthy@micron.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for new Micron SPI NAND devices, which have multiple
dies.

Also, enable support to select the dies.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 58 +++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 3d3734afc35e..84e1c109ad0c 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -20,6 +20,15 @@
 
 #define MICRON_CFG_CONTI_READ		BIT(0)
 
+/*
+ * As per datasheet, die selection is done by the 6th bit of Die
+ * Select Register (Address 0xD0).
+ */
+#define MICRON_DIE_SELECT_REG	0xD0
+
+#define MICRON_SELECT_DIE_0	0x00
+#define MICRON_SELECT_DIE_1	0x40
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -66,6 +75,22 @@ static const struct mtd_ooblayout_ops micron_8_ooblayout = {
 	.free = micron_8_ooblayout_free,
 };
 
+static int micron_select_target(struct spinand_device *spinand,
+				unsigned int target)
+{
+	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(MICRON_DIE_SELECT_REG,
+						      spinand->scratchbuf);
+
+	if (target == 0)
+		*spinand->scratchbuf = MICRON_SELECT_DIE_0;
+	else if (target == 1)
+		*spinand->scratchbuf = MICRON_SELECT_DIE_1;
+	else
+		return -EINVAL;
+
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
+
 static int micron_8_ecc_get_status(struct spinand_device *spinand,
 				   u8 status)
 {
@@ -133,6 +158,17 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M79A 4Gb 3.3V */
+	SPINAND_INFO("MT29F4G01ADAGD", 0x36,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 80, 2, 1, 2),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status),
+		     SPINAND_SELECT_TARGET(micron_select_target)),
 	/* M70A 4Gb 3.3V */
 	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -153,6 +189,28 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_HAS_CR_FEAT_BIT,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M70A 8Gb 3.3V */
+	SPINAND_INFO("MT29F8G01ADAFD", 0x46,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status),
+		     SPINAND_SELECT_TARGET(micron_select_target)),
+	/* M70A 8Gb 1.8V */
+	SPINAND_INFO("MT29F8G01ADBFD", 0x47,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status),
+		     SPINAND_SELECT_TARGET(micron_select_target)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

