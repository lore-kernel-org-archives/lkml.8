Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2CAC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16687206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpeZZ6L5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgASO5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 09:57:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35283 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:57:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so12175952wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 06:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9CMukmm383ZbRg41KDwagKi6+XBBa8RTph8WtX5WX4U=;
        b=jpeZZ6L5e/I8FoMqQz4hyNtTSq4qBK5DDib3wtqclp6SN9gu+2vD2X69Hqqf7f2QsF
         AScwKQo78kBRx/coXiW+Bjpb+mW617Ca2zrqgPC/E7Zfzyng/i2XgDjNvcr8fG6ge3bY
         f9k5peccBCksty4y/8shMPHz7lecCCjjdO2qI+UP0by9fcMC6+9GKwUrRPmCPEMyq3UE
         dvMEwXJpIJN2ZZRn1hDAaStm3ToC9goUnVxpswKfbCeAmI6xnoQuY8S3iKfS1RYEaD07
         fCbrx9hiAloZH0Hxi6alGcKJCM6Zp9M6zscleNolR3WGuD318svg2YbwL8xxlYkaa09V
         YGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9CMukmm383ZbRg41KDwagKi6+XBBa8RTph8WtX5WX4U=;
        b=AhbCI6dUImCYpoVMxjugHsrVe7aErG6vEEN3SCBfcuX1btsX6zd+rSk/a7AHxAAmIo
         G6u2Jy7pvIwMODgLAVTWlB/05ZBSkoPc9BnD9v2ynqzJn2XHzOUkbBD0LKHL0gD/rHys
         FvLs778TiCI4vi6GyrF284M56zagN4y5kyBSbmOxIOltSnG+mtLJ063jtZvBvyPMQgfB
         A/jFoFpvFVXUMkfIlFKsIy0l6kK221dMUQ62ScQxXdUKw7VEe6GkM6JJDILke+WL9rxv
         nKEdiZlOU0+U/kZIth6q0/ovn+ob7FMrJvwGqIU91MqAfYzMitDdOyrDyssvz6ZdbqrI
         Vs2A==
X-Gm-Message-State: APjAAAU0vn/nZuSbo8zokRdoV+VL2djsTwzNGAwvDVu22Avf41RF8Dft
        TQdff7Pq7KTfwhytY+3EVWc=
X-Google-Smtp-Source: APXvYqxJDn2VK4pNd82pnezUbcecnBMOI1AfXgTJS7x92jCDab+m0tAoZ6nJieP/AGcG+DbbV3AHEA==
X-Received: by 2002:a1c:9e15:: with SMTP id h21mr14834897wme.95.1579445820059;
        Sun, 19 Jan 2020 06:57:00 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id p17sm43347877wrx.20.2020.01.19.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 06:56:59 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 4/4] mtd: spinand: Add new Micron SPI NAND devices with multiple dies
Date:   Sun, 19 Jan 2020 15:54:32 +0100
Message-Id: <20200119145432.10405-5-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119145432.10405-1-sshivamurthy@micron.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for new Micron SPI NAND devices, which have multiple
dies. While at it, add support to select the die.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 45fc37c58f8a..03b486843210 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -18,6 +18,8 @@
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
 #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
 
+#define MICRON_DIE_SELECTION_BIT	6
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -64,6 +66,21 @@ static const struct mtd_ooblayout_ops micron_8_ooblayout = {
 	.free = micron_8_ooblayout_free,
 };
 
+static int micron_select_target(struct spinand_device *spinand,
+				unsigned int target)
+{
+	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(0xd0,
+						      spinand->scratchbuf);
+
+	/*
+	 * As per datasheet, die selection is done by the 6th bit of Die
+	 * Select Register (Address 0xD0).
+	 */
+	*spinand->scratchbuf = target << MICRON_DIE_SELECTION_BIT;
+
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
+
 static int micron_8_ecc_get_status(struct spinand_device *spinand,
 				   u8 status)
 {
@@ -131,6 +148,17 @@ static const struct spinand_info micron_spinand_table[] = {
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
@@ -151,6 +179,28 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M70A 8Gb 3.3V */
+	SPINAND_INFO("MT29F8G01ADAFD", 0x46,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
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
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status),
+		     SPINAND_SELECT_TARGET(micron_select_target)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

