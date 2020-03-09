Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19717C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22B220848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO/c66Jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCILzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:55:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgCILzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:55:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id l18so628169wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M993Xxg570Z0qNth+AfgZmhK2IPDaBi6vXhUHO9PeJw=;
        b=eO/c66Jo81J/h9ylI6Ij1ZV0ARuX3/K0UAZVUQUJqiOUYNav6uE9nWVryGj+MBba/W
         frXDBER5dI38Itmdq0khKT4tHhUV2rTFwLxqXtcA5L757P2+XLssy9O+49t4t0zjgNBi
         izCnaPHtVtfo2ICtwH6ELMf3/4KzGZgE5WjgFhv5ghduyjCWhv741drHquSecGHVbNFN
         14uEa8ig0tGAP1qmsPBrjr9xz3eR7Vhl2m9dr5dWm4trmSggnMANF/pzTkTJBC4xUgTh
         rFJD0vXviJJd78OFgGvOXZGExzuXGanziNOVMO9mp/C7ncac/hYLRGniZH9k5irvhB17
         OTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M993Xxg570Z0qNth+AfgZmhK2IPDaBi6vXhUHO9PeJw=;
        b=FjNyuLDd/CpACCJDycC8z3NxHk3xpM2NNn5fQZADiAbTNeFFIr8Bvwv9dgzGcgJrwa
         VDRRfI5y71gJp0wRSaL5GcIc7KgPktLfiji1kIgNiUS5GeUhguoq6Ccupdb/zY27iVJR
         WjP6gePlLKzUi3SLXNFnk7tQ2zKBNDzos87rbIxtsgDAKxkMXQ4J8V7iMNuoSjuintpR
         6nHXs+kyyYjeF8iXsr/Gsehoil4tHh0LdP+2zAY5yCO1MxdmQNZniml/v1fmJiNBxJV7
         qw+9CevJlt4p7Z/rT6Qp3MtibN9zcmweAy4UclV8O31EUrfXPTPWxky1lc/cgIFfe3vR
         ZbQg==
X-Gm-Message-State: ANhLgQ36fSy8+hc8Oqt8CIb/4/s+SqcSqnE+lyv3O8ay/Rc+LBZzOiPV
        ex7fmM6FEHim1wGBuLmhclE=
X-Google-Smtp-Source: ADFU+vsR4Ug2gciCuv+leVePyOHBqCXxvpvAEDC06Ybpr79hKygWqzH/+wTxC+MaiX9GNEOEilzuNA==
X-Received: by 2002:adf:f584:: with SMTP id f4mr21816282wro.77.1583754934751;
        Mon, 09 Mar 2020 04:55:34 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m21sm25035226wmi.27.2020.03.09.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:55:34 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v6 1/6] mtd: spinand: micron: Generalize the OOB layout structure and function names
Date:   Mon,  9 Mar 2020 12:52:25 +0100
Message-Id: <20200309115230.7207-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309115230.7207-1-sshivamurthy@micron.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
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

