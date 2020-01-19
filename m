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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB437C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0EA206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJjHJJqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgASO4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 09:56:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52102 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:56:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so11889261wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 06:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vcj3e9+EJ4WNrgAbdDvcbbbPfC25UIBCN5ll5T2N4bs=;
        b=uJjHJJqVURy6TfKDZ0x10u95wtZfUeM1/a7XqkmJuxfW87TBuSGW2AohOC/aX8H6xR
         pjMdloJkoRLwBnDGjfm0qXG5W5Mp8HlsDdlUUns2mXz83evc5JPeS6uPPJuUwtJtzTSi
         fhZ3TBHQnf9i+GauEundt0IIfPWuS9+lizTT5brFdzYqmLjHLXoPPNISEynL6qY4NzCL
         h73QpFnl0kQzuJ3U0c4u9YOyeRaR/ZxtrSHGnepe1ZQtkmo+TtcOCCL4eSbqRmwTX75o
         g/dcpy72227RfDmUQjnaOEmA2lJR+ze22CXSidnnAcITWx6cZOTD8kObKv+tahdrRR5d
         lqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vcj3e9+EJ4WNrgAbdDvcbbbPfC25UIBCN5ll5T2N4bs=;
        b=Lnm/ZpX8m0RELLEAXWQLBCmP3tcxXL7G+HY/UuKUI/R+41RTe0JVYe1BalAg+3L6Ee
         c/LMc0RTIQyCDmu/3a1jwVQDoTVDCYs7D6ji0QO44ga/fmG46tr3CzHpyQulfbcQZTfV
         2ZRILaCqjD8LBYcBRxtsDzyRagoCiPzmTFWNG296IVznIsaKNg7yOSPKBebSDGmSsyMn
         6RLo+9H5g5TljLT3Bh5YEsDll+IPxh/jczwifKN/CrUCeJINUp6Cdb3eEWkvbptydUCc
         zqrcjosraXcb0L9W2/p0v310k8QQp7mXSGQB5NZRzRMwvcGHmHmr0ShMtV5ZkAw8WISy
         HaRg==
X-Gm-Message-State: APjAAAU6Wwa3AwViT+NHMMmf7ryJE5MaTPt+1oqi4JbREEn/CdbEls3j
        A/FPU3x4eEtFUbMmYT9bvOs=
X-Google-Smtp-Source: APXvYqzqT29cH7JTk9/dHMTsbCBu8gBpjtadWaH0fvg7N0PK0S8OieaQASmLQyz7syI4rgWel2YcTA==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr14472574wmj.75.1579445803665;
        Sun, 19 Jan 2020 06:56:43 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id p17sm43347877wrx.20.2020.01.19.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 06:56:43 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 1/4] mtd: spinand: Generalize the OOB layout structure and function names
Date:   Sun, 19 Jan 2020 15:54:29 +0100
Message-Id: <20200119145432.10405-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119145432.10405-1-sshivamurthy@micron.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
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

