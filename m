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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F6FC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3720206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocEEjur2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgASO4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 09:56:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33651 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:56:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so26990685wrq.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WK+KzBfTuQqE2Bcx0psUGki6jAtzDkPOrrhY+kNzNrw=;
        b=ocEEjur2qdRmr4lVyh8MGSAlo7vilPkyZS0yf5IljHlpYW/CQmZ6ymYBz4554MEqth
         uBCUlp05Q+3TXQBkcbThe8wCoPDu64Lo/tsyeYNb/fjOa1Bqs5btCCDCMvo9OZaQckYC
         eQg6kokH5BFWvGHK5/VOCSGuDERfDY+x7FLamTqsHC5cGtBA0dQTG3ZdewXIVUvuxW6w
         06keHbAwSsgx/ialSmPZ9jJ8QhMaYi5sAL5S5VBD6QTr0RsQsfxH50u7bdVPLLJcpO2i
         MIAoXCAfzIYCiG0DPKxyAxR9RDXJgNVB4ksAgLZPlvkzlszE3RJ5593PL4XjmMGRVVj6
         ruxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WK+KzBfTuQqE2Bcx0psUGki6jAtzDkPOrrhY+kNzNrw=;
        b=l0MaBYOocaqq8ecd9Iq6fUxTZf7Og+06CQ9EiCQr/I1GisdBODNV5efdKxvubWEO5c
         nxNvYm5lgyDSMQNNhfbEbkivgDJGj7KpQgBB976xI6DZZr8BWAiilDyeICoRfaMx0bVI
         fDsyuK481bX6L3iviwieuNaMou8pK50Fm5QmTkCqXotfb0u21rnviTImKch0nZcmrY5z
         UGwqWTbfcA6qaJOZQ165rfIsuMrOUNkgVr1lbKVQzOVN5kLFSoyJfHRgCgnuhK38jz4u
         sFHVur/FgT0Qv790v6xxW+ha79VjGMAvW4D+166fmS1QNG9WFbT6Zad4sG6z1W9aGXbd
         Ylrw==
X-Gm-Message-State: APjAAAVFM3Js+mSbsJTkLNoSqqyoTHLo6ajej8M7zxGsoS4aJCVj8Ge5
        DeO46HBdxJUN7OtIpVFLQtEDdrdlnJdgBw==
X-Google-Smtp-Source: APXvYqyJW1l7oAfaAJjtPzbHzd+gAykbid4micm19NvJcLs+SkNHmtQym+RAEFK+sy75xmlBWtLVqQ==
X-Received: by 2002:adf:f803:: with SMTP id s3mr13674700wrp.7.1579445809064;
        Sun, 19 Jan 2020 06:56:49 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id p17sm43347877wrx.20.2020.01.19.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 06:56:48 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 2/4] mtd: spinand: Add new Micron SPI NAND devices
Date:   Sun, 19 Jan 2020 15:54:30 +0100
Message-Id: <20200119145432.10405-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119145432.10405-1-sshivamurthy@micron.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M79A and M78A series Micron SPI NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index c028d0d7e236..5fd1f921ef12 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -91,6 +91,7 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info micron_spinand_table[] = {
+	/* M79A 2Gb 3.3V */
 	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -100,6 +101,36 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M79A 2Gb 1.8V */
+	SPINAND_INFO("MT29F2G01ABBGD", 0x25,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 3.3V */
+	SPINAND_INFO("MT29F1G01ABAFD", 0x14,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 1.8V */
+	SPINAND_INFO("MT29F1G01ABAFD", 0x15,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

