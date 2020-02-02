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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C510C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675E420679
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6sn9HS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgBBV5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:57:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51921 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgBBV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:57:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so13802919wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3dLHbgqnxzITEPk0xVr2q4acu5k1gqYIJuRiRDYsyfM=;
        b=i6sn9HS05ehtC8NoNAFCY/z7MxG4qIQXHBHzArXM8R7czsmlRH6VVbnr7zCGzCMxFw
         +cpgr9ZntSojztMI+KlXsSAR4fASYj/fXZ/qbKiujILL3t+o+TxxbmL+RA4EAGfQay6D
         X31ns5YaTQ7PVDmm1QRN94lcDSsq4ne7jbgyiuN1G8vpsvvFOINewix/kDI/r9ZKhgok
         0jpnTHIjKF/IyYRnfthPoxAbercMPKZgQO+b72Yzr/+wKXaJDHRcmLKfcwMnBZyo26qN
         1raof8u7y86H7Ag5Zovex574/oGUUHnXs5leK1lZ2OjTFv8kvK8DJJBuCpuPIzwk/HFz
         7oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3dLHbgqnxzITEPk0xVr2q4acu5k1gqYIJuRiRDYsyfM=;
        b=NDgWFpWNRWfzwpPnhCLnKpTj7W68/JbBXzywTKRSv5RJKXuai3TwTW0fJnLJzwiRh6
         2SA8c7RvSfQg83UERtTyxIM/Mmsg82DlI3K2ySvvr90fBSzrM6aFC/eKZuRXscocNkIm
         1OC1G9O4n3O1Ug02PObzBWWLMJI/IHcgpaJBActZ0dwTPCnF/dLbp4FVn9kAkXAKKlx+
         WzJS4n8WwLty8rpMQ9RPXUYRmlkMcnisWAr+/sEVnC7rqqhvefsGEItEL+xGxLrVA8yz
         JLgXDriFCXaSsoBRGRa2cG4N6sdsmG2Q+GmaZFyXz94idih7B17N7EP0CDNCoTLGmRcE
         YVug==
X-Gm-Message-State: APjAAAXDMReg7awh/XHZTZD+NxxY/Vx93wdu/mm0rgSCXjgrvDspA+q+
        7onYcQdxJ09SRyycIlpNGpU=
X-Google-Smtp-Source: APXvYqxkq79MGinXkrF1t0NJB9q3e2oug5VUdbRsPHSxyrVhg0GfF97I0VOF9GGEzaM6bnpOxTkE4Q==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr23679112wmi.146.1580680652015;
        Sun, 02 Feb 2020 13:57:32 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c4sm20612488wml.7.2020.02.02.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:57:31 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v3 5/5] mtd: spinand: micron: Add new Micron SPI NAND devices with multiple dies
Date:   Sun,  2 Feb 2020 22:55:08 +0100
Message-Id: <20200202215508.2928-6-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202215508.2928-1-sshivamurthy@micron.com>
References: <20200202215508.2928-1-sshivamurthy@micron.com>
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

