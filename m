Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A570C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F82D246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxqGCszp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgB1PDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:03:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35996 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgB1PDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:03:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id g83so1334595wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M993Xxg570Z0qNth+AfgZmhK2IPDaBi6vXhUHO9PeJw=;
        b=fxqGCszp3U5TsaRO8DeMwhFdG9VCC5MFftPvMMFEJqZP+CwEr4KSsqnlcjv1enzIkm
         XbtoKSQk0K3qLppIp49AHQ0MG8MO9Gu9oB0Aw5+Ce3sivUFewhs/RIL2n4wFPZlK5IbC
         nj6YOkZUYbb81Nir0LBidFtn6yePYS2AVsWDf8+2wbBRcsedbSJdieZ3TAylWGVCFBnJ
         pKp2q3LsoH6MQePzJUTz+QQX7cCRsNUAouRM6c30kLJWXOqsS1asoNuSRi+K26n2RFWD
         8mHDo1wUMYUQD6co5OjEIYBKzD1Iohxt64AC/ik6DZFIUmolV7Y3d6Ur0i0zim0fQnw4
         IbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M993Xxg570Z0qNth+AfgZmhK2IPDaBi6vXhUHO9PeJw=;
        b=tHBjZs/okdIJjtovmrzKP7lKBzBqyol8jyPv7FTmKpnImbquPxXhylYgvX7fJpc444
         JnnspN1sjKb6GX4L+WMnPlwbBRwXJvQBN9gr3BUU0Nh0yotpHz7AxkG19Zz4/VW5PCwl
         aGpvXDvUvRMLiSqdPBDIT5PlJuseHruia3/snonQHEY8zDZ6VUvX1S9Rv71YDsdrywgG
         cLLh0G8aPeHQIVEWP273ZFjv+o6pLIJuCgNsk1GwspQG94LugNxhSe7cQT1EwbuAoTbK
         vNVEXOOi7ladFMBShokEJ/swGQyJ6f71EgBLD44Xi4JzMVDUmKVxo/uv7dcagM8Ogn+A
         Zjmg==
X-Gm-Message-State: APjAAAWavM3SG9K0yptGBs6JN59s63q9HZFXkrtt4lTl/gMc+W/MGGrJ
        9axwt3obhsIVJ+QIlYON3+8=
X-Google-Smtp-Source: APXvYqwNSQFWyVhTdvukpuDwLPKGh9J5VLffoz16pWUJG+qow3vh1xugI/kVAVbZ5FBaDlNbHvIsqg==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr5174861wmj.59.1582902202694;
        Fri, 28 Feb 2020 07:03:22 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m125sm2540235wmf.8.2020.02.28.07.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:03:22 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v5 1/6] mtd: spinand: micron: Generalize the OOB layout structure and function names
Date:   Fri, 28 Feb 2020 16:03:06 +0100
Message-Id: <20200228150311.12184-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150311.12184-1-sshivamurthy@micron.com>
References: <20200228150311.12184-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

In order to add new Micron SPI NAND devices, we generalized the OOB
layout structure and function names.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
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

