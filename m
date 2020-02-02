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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C5C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0784F2051A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKZNTLxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBBV50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:57:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39413 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:57:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so14796807wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 13:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WK+KzBfTuQqE2Bcx0psUGki6jAtzDkPOrrhY+kNzNrw=;
        b=dKZNTLxhPUHx6EOOf2Qkeu1Hx1OXdFhIE8zfY9iMPrqzA7GC9AF7HyMkacIAKJNyn5
         pg7ZLI5GNyW6/csEq9Gz+1np77n/Kl3ps1iJRUAaG/1pC/xMoJrkP0r6Uc9Yh7W4Rh7b
         9aS8GsdEZ3BR3IH8UySnnxkQzdKrLCMPL5a3kBKf7Q8DlYscKgW+zCNiHR6Obc1NeWGb
         yNO68/2Lhe0qmT95pLQA5MB47/ucTa8S8UkA4l5hAK1SG2XLBa0OAcpEDCqgoa8LCEZ3
         2cKz6JPxsHcXTSMTPiCwGVtkVBcnOuLQtRG4uojCimaw8VwXjhtMDV5puH9a67D9zkeG
         BKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WK+KzBfTuQqE2Bcx0psUGki6jAtzDkPOrrhY+kNzNrw=;
        b=PKnOrmbux+CusUU+76Dg0m2E+Qj9rVQvX83xvvXiTSvxEGg2OtQiyBCoATRFrH6MER
         SFw7gI6sGLW3PzgfWnw6aPFjFFYrTgwpHl+x4Fe0h8Hdica1itKdaFS1wRPJMBtJzeJ6
         ldoGdCBe/hKQZ9YGDMuPMO8dEU2OLNKd6+wSjJF7ueJuTx9av3fDTTBafplWSK88R3XT
         4MIy0BEbCi27AW66gnJ6iOwFWUUYUyPDLxOAz9uiQ2pW0AD8FnUFe8SJ1KN+HsVqs0lw
         ckPV6Se52ICGhUpjle9DjS3JRLGQhxfj+ES7iKBkmFxO47Rhcd8cAHuoURD0iSw+cBFG
         8yYA==
X-Gm-Message-State: APjAAAUoocHTd1jpo8e2BIa+71176FaNu83yHVJ4I5rWHhn5UomlbKi3
        21k6aKXDL3mTsFKsyiP1poE=
X-Google-Smtp-Source: APXvYqxBmkS8IudXwxttujzOHR5bJgYd2rCSqZHjrQyWQ0VIwRxtZe2qBYweM8fZWEdCESRwkDFR+Q==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr23989468wmi.37.1580680642746;
        Sun, 02 Feb 2020 13:57:22 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c4sm20612488wml.7.2020.02.02.13.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:57:22 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v3 2/5] mtd: spinand: micron: Add new Micron SPI NAND devices
Date:   Sun,  2 Feb 2020 22:55:05 +0100
Message-Id: <20200202215508.2928-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202215508.2928-1-sshivamurthy@micron.com>
References: <20200202215508.2928-1-sshivamurthy@micron.com>
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

