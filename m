Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF418C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7489020737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJzM0OhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgCKR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:58:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50310 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgCKR6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:58:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id a5so3109767wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=knKxmw0pxQ5Najb1qdtFuNgnhs0cDNgJ5XYCxXVgosg=;
        b=qJzM0OhX0JFdbqgPq5YWJpiEvMDEeOdVcpY4Up0cRcPOkDWU3qp8g8X7Q2pzFFPWFs
         xAFzXZP6wP1MWEAjwZKsNxUhvS5DQgwfY8Ivt+KKmBgqY4tzXyCjKkhuNrlWqVAaqlMi
         OC/dDCFbt33H4Ek9vKHZBB52zMKJhQ62v41XHRVTqINLNdxfRDiwSYUclya2ULd5e8lm
         WTguo+IYaYdeTUfNmZzW32+acdg1RPW82iU6WD8krr59hmYEIa6rkvBkmg1XR9Df482n
         sCrbKvZUZJDIhlkK4KQHn6iL2o0afM9zinwMqLn1dlI7THR5EQzByGvnOW27YXWb4q4k
         XRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=knKxmw0pxQ5Najb1qdtFuNgnhs0cDNgJ5XYCxXVgosg=;
        b=GtA8pyU0PtsW3l+X2lJgCP4W2Rc47bQPI1bmiLZkoDI9d1vHxY0AnCc4WINU3/uD5K
         ufDF8EHvecCE9DPLrpd/PBnRyDyv09MPq8psKngJp35Xmz2rAl+eOhFAeNecxwax8mMN
         NxL9hkWNey1zlyJXQEQSp8d5fhP1CkmZo6/pvOFq0fx9IjjCZaXBhJBfddH2/z9e0nqU
         03a8NTH+CPePlo/6tP41S/htaqzKOiDf22P7142ZOw6KuqYwuMsoCQOrqe5aE8ufiy63
         CUmHqbF5fu7C4rentMzsUd72UfdTRjo7Nby9CuCq0QdNg6eANNlFsoLjGPMORqizIWUa
         xGxA==
X-Gm-Message-State: ANhLgQ1uFUY9GANAC2tYRAqhL1JexKMNsP3lilksbNVJLI2nKWTYPvd9
        Qk+KzJRepx+APpMglyIQsWY=
X-Google-Smtp-Source: ADFU+vsAurwdyvOqykM4WDWKZJGNJb2HwFTrxFtjtMDFjzs0DO5Fess9MLyMeRSaS+sQDoa0WBfQLA==
X-Received: by 2002:a1c:196:: with SMTP id 144mr4940965wmb.100.1583949528592;
        Wed, 11 Mar 2020 10:58:48 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id l18sm1502107wrr.17.2020.03.11.10.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:58:47 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v7 1/6] mtd: spinand: micron: Generalize the OOB layout structure and function names
Date:   Wed, 11 Mar 2020 18:57:30 +0100
Message-Id: <20200311175735.2007-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311175735.2007-1-sshivamurthy@micron.com>
References: <20200311175735.2007-1-sshivamurthy@micron.com>
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
index f56f81325e10..cc1ee68421c8 100644
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
@@ -99,8 +99,8 @@ static const struct spinand_info micron_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
-				     mt29f2g01abagd_ecc_get_status)),
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
-- 
2.17.1

