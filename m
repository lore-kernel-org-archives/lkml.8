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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F24C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3247921927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS9dN4t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBFUYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:24:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39772 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgBFUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:24:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so8694958wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vcj3e9+EJ4WNrgAbdDvcbbbPfC25UIBCN5ll5T2N4bs=;
        b=GS9dN4t3AWNdhQsrw7lNOfrPTeUpGVVfpKTXZ5Tr37i2IJdDwWfLfXmUMXLxJEBMtA
         1QsVckviqL47iHxcjHK6JGNZL3YRxg41jaeytjeysnnrzszWLS4387t5KFSoLbE2nldH
         L0J7a7YMHM7eAt0gQh9XJEX7cPIr67yyBemihzHrpngXf9dA1njqmZQS2HS70/at/lRR
         GuA67WgmfLTA7rjCiwIe+lz5+HjKDlhq8baVhgNL1ebQKkpMVsAjWiYeNala1uz67WBs
         Ca1ZOWcauhW8XVlfYUysjP/q2za9edtKPvLdxVI60Izi6CPGhEUtNKcrzCDPLUKTjz5w
         6vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vcj3e9+EJ4WNrgAbdDvcbbbPfC25UIBCN5ll5T2N4bs=;
        b=R8jt+eaUPN6rUt7WXrYMqSNkwApGWJmKMuBY3mIPGh60Fv69fe0Loy4MOifyG8Tx8E
         mU2qJou1sGjhXlfbaPdDN5KYreOSXF/ylQmKx17ZcRr91dvgAHPstwQ7TqvP2miLGuX3
         jM2O8hrxdE37F8JZtjCjvVgl4jEWnhdkZclc0HhqoBVuqvCTXdMSyfa3HmlGds9rMfRS
         qbctIxBWvC/5Z/c4rpvnqWCPtFSRn8GxzyAZXul2Y6G1k56zcNRtwyPnehrNiaz6ydWP
         uUYj089F31grnP/xDhOnE7jhdxq7RKSqGQ10WsEhFQIgC/gMm6hJX0+xkOFUJPtW0imd
         Rl4A==
X-Gm-Message-State: APjAAAW0tv7Q1VKSWHpUCR9eg9GeIqNIxX8c1O1eVPOl3txU2S/bUYTA
        hBqMqPpZ5MKARPnx/dsvEi8=
X-Google-Smtp-Source: APXvYqzPoHoZWjpqE5sSi/BYrIxB0T/cfaytBUDaq+eKbJVaq3F1f8ubDSgDWcw3PrZrGwAjO6cyyA==
X-Received: by 2002:adf:db48:: with SMTP id f8mr5266232wrj.146.1581020669767;
        Thu, 06 Feb 2020 12:24:29 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c13sm539929wrx.9.2020.02.06.12.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:24:29 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v4 1/5] mtd: spinand: micron: Generalize the OOB layout structure and function names
Date:   Thu,  6 Feb 2020 21:22:02 +0100
Message-Id: <20200206202206.14770-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206202206.14770-1-sshivamurthy@micron.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

In order to add new Micron SPI NAND devices, we generalized the OOB
layout structure and function names.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 7d7b1f7fcf71..c028d0d7e236 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -34,38 +34,38 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
+static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
 
-	region->offset = 64;
-	region->length = 64;
+	region->offset = mtd->oobsize / 2;
+	region->length = mtd->oobsize / 2;
 
 	return 0;
 }
 
-static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int section,
-					 struct mtd_oob_region *region)
+static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
 
 	/* Reserve 2 bytes for the BBM. */
 	region->offset = 2;
-	region->length = 62;
+	region->length = (mtd->oobsize / 2) - 2;
 
 	return 0;
 }
 
-static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout = {
-	.ecc = mt29f2g01abagd_ooblayout_ecc,
-	.free = mt29f2g01abagd_ooblayout_free,
+static const struct mtd_ooblayout_ops micron_8_ooblayout = {
+	.ecc = micron_8_ooblayout_ecc,
+	.free = micron_8_ooblayout_free,
 };
 
-static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
-					 u8 status)
+static int micron_8_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
 {
 	switch (status & MICRON_STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -98,8 +98,8 @@ static const struct spinand_info micron_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
-				     mt29f2g01abagd_ecc_get_status)),
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

