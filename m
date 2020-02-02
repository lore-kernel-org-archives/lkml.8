Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFB6C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5176D2051A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv10nS8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBBV5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:57:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54552 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgBBV5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:57:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id g1so13767106wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jmAtE7xwSXR+AJEG/25i5LGMBTNXSyD6hhPgoSBYe1o=;
        b=gv10nS8Z7FAbqlgYZGrOQBrI83FVSAwXFPTLKNyQt0LPaxtiTHggSqFghbPdNvQ1r5
         7CkgF+sngWjdtVSYpGpxslRLevkHc0HF7YUOngXO4fxYvdgym6MYjadjADlJSgJCFH0a
         IsfEp0GZFwoNoeZM+zxU3Gm6iti34QXCJto3EjqrcbkClmrzpBF5EAwgDlPXRvXtpALe
         kLraKIror4yaN+RXwB0XGFp/g1BO2Y9ydI7ARVEkUAZhUTG1SIdhEEzkMnLZq9dJiXnA
         tq1CpucixSYrU0y77vx4YVVe5O8N3yLN64zKhJl0p89ikh6wb9ZqRjGBRtr+Ri9Vzdjn
         O6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jmAtE7xwSXR+AJEG/25i5LGMBTNXSyD6hhPgoSBYe1o=;
        b=FKplSfgBe0KpuTYgkRnOSCgGXkucBTyY51bPKksdL2WasSJeA4YeAdRf/rVl9yCiV+
         LfDzDvSIQrTlSF+6V9BHFh3H988Vl6bjGq/iK6nCUvQo3Rl2VLP8kA5aFr0jo9/11s4X
         56kmbvuzT0JIWlWkPQTsbHdPgw6y2gQUnRcNX/J4DknJ3nw/K/L3rhHw6OATQiRHkir6
         iIyp3ws+GCwfyflY5h1UiYPKc/RZqRAf1lgVYznQkDoDYcY90dxy+0jlUJpoxFUroSAL
         DGfFG121+atfJ9vRAbY6sDVOR4cRPE+mrUGZZBrRnJRgJVllBu3d6RKCPZ8Ft7EmByYk
         5E7Q==
X-Gm-Message-State: APjAAAWgOh4ybUwJE/iXvp4DfKA85xZy5Ku8xPBgOefnln+ROw2cx6KM
        lKBLLyJZeIfpRKFHQ5Hr7ag=
X-Google-Smtp-Source: APXvYqxJwDn66jjhZAwmIruS4H0N6mjIcP4rBfVPljwStGDUMtTwYEUR6ImG3moa8tMtGbD1xRFWfg==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr24198750wml.3.1580680649279;
        Sun, 02 Feb 2020 13:57:29 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c4sm20612488wml.7.2020.02.02.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:57:28 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v3 4/5] mtd: spinand: micron: Add M70A series Micron SPI NAND devices
Date:   Sun,  2 Feb 2020 22:55:07 +0100
Message-Id: <20200202215508.2928-5-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202215508.2928-1-sshivamurthy@micron.com>
References: <20200202215508.2928-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M70A series Micron SPI NAND devices.

As opposed to the M79A and M78A series already supported, M70A parts
have the "Continuous Read" feature enabled by default, which does not fit
the subsystem needs.

In this mode, the READ CACHE command doesn't require the starting column
address. The device always output the data starting from the first
column of the cache register, and once the end of the cache register
reached, the data output continues through the next page. With the
continuous read mode, it is possible to read out the entire block using
a single READ command, and once the end of the block reached, the output
pins become High-Z state. However, during this mode the read command
doesn't output the OOB area.

Hence, we disable the feature at probe time.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5fd1f921ef12..3d3734afc35e 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -18,6 +18,8 @@
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
 #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
 
+#define MICRON_CFG_CONTI_READ		BIT(0)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -131,6 +133,26 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M70A 4Gb 3.3V */
+	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M70A 4Gb 1.8V */
+	SPINAND_INFO("MT29F4G01ABBFD", 0x35,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
@@ -153,8 +175,22 @@ static int micron_spinand_detect(struct spinand_device *spinand)
 	return 1;
 }
 
+static int micron_spinand_init(struct spinand_device *spinand)
+{
+	/*
+	 * M70A device series enable Continuous Read feature at Power-up,
+	 * which is not supported. Disable this bit to avoid any possible
+	 * failure.
+	 */
+	if (spinand->flags == SPINAND_HAS_CR_FEAT_BIT)
+		return spinand_upd_cfg(spinand, MICRON_CFG_CONTI_READ, 0);
+
+	return 0;
+}
+
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
 	.detect = micron_spinand_detect,
+	.init = micron_spinand_init,
 };
 
 const struct spinand_manufacturer micron_spinand_manufacturer = {
-- 
2.17.1

