Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D194C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D31320678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAqybs4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgAJCwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:52:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33090 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730965AbgAJCwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:52:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so398204pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 18:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CxE8CCc9g1RNDQhZZqJp+Rrgjs5Vx0eu5bOZbcJVnhE=;
        b=FAqybs4gdWCoqOw2tD7wT2ynFOuWRevqd8VFLlTvimIQC5S+6+G68KJnyVR12PIVr4
         LM0RNsllo64IrJICtn0kALIE+3dJmdSw1cNgBdpCZwndFnlfs3AmuMHKoBzY5O5miKnt
         yPdc20OIHAVVxe9GR71K2ouQsAtPT7gg35uuAnezAY1WtsmrKd3eHiakvTRZkum6wRHp
         JbEnILMmq83KpR5XGl4iu0bj8Ae7BTeNWJWg6T6FYl1vhge7BZLSuopDu49jNoLM8m1b
         DwalTh0uT9vCOlsayaQtc1/C8GYf7lG2clb6yiTwUlPvJMZJrtTRntFz0kxCGrCJ90Oh
         AeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CxE8CCc9g1RNDQhZZqJp+Rrgjs5Vx0eu5bOZbcJVnhE=;
        b=q0BYw3HgLAI/seyq1RnvNKCd6gcPg3lgYBQDIAT556mhSIhvuPAKVgN3b2dvMRB5Wu
         UA3Sy5hCWh4oSbZnP7WKIVTBc0O4FlB7KsfxRbJRwmdvpOog0MLsdbQyMZBGO/ZHlnWK
         E+BPDnqXzCO/NqHq4kLwDJe9xuvgOkIFIl5fCD2Nfdd+oy0idOW3VL1vy2reuzBFRcdH
         1UUHsJiCD0AxkZSAaTToT3cPO6pCzYVY49j93bZXEJV9+aOYUyVAsF/TY3kM9ke69xM2
         NCPm5x3UiX1hNp7RuyTkK4KNFEfvPQieOWPCLkHi8OtYkXolgt0x5yczl8slpKIanZIz
         RF/g==
X-Gm-Message-State: APjAAAWqLDIucB1uWBFksl9XMxurHa9JMmQMfxdDe7h7cCghBPSr1+g3
        UKcwcyUzjkJ0avZLIbETU9Y=
X-Google-Smtp-Source: APXvYqxoarnSyuERHQUf3kk9NmNbjgwcLI4uB0pap+jj2FhGe9VpBg1m/drI0IROMWd1CwQ169Q2Gg==
X-Received: by 2002:a63:1a08:: with SMTP id a8mr1418455pga.425.1578624768193;
        Thu, 09 Jan 2020 18:52:48 -0800 (PST)
Received: from localhost.localdomain ([240e:379:970:fa70::fa3])
        by smtp.gmail.com with ESMTPSA id o6sm331154pgg.37.2020.01.09.18.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 18:52:47 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: nand: spi: rework detect procedure for different read id op
Date:   Fri, 10 Jan 2020 10:51:14 +0800
Message-Id: <20200110025218.1257809-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are 3 different variants of read_id implementation:
1. opcode only. Found in GD5FxGQ4xF.
2. opcode + 1 addr byte. Found in GD5GxGQ4xA/E
3. opcode + 1 dummy byte. Found in other currently supported chips.

Original implementation was for variant 1 and let detect function
of chips with variant 2 and 3 to ignore the first byte. This isn't
robust:

1. For chips of variant 2, if SPI master doesn't keep MOSI low
during read, chip will get a random id offset, and the entire id
buffer will shift by that offset, causing detect failure.

2. For chips of variant 1, if it happens to get a devid that equals
to manufacture id of variant 2 or 3 chips, it'll get incorrectly
detected.

This patch reworks detect procedure to address problems above. New
logic do detection for all variants separatedly, in 1-2-3 order.
Since all current detect methods do exactly the same id matching
procedure, unify them into core.c and remove detect method from
manufacture_ops.

Tested on GD5F1GQ4UAYIG and W25N01GVZEIG.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---

Changes since v1:

1. rename spinand_table to chips
2. introduce per-chip spinand_devid structure containing id value, length
   and read id method.

 drivers/mtd/nand/spi/core.c       | 90 +++++++++++++++++++++++--------
 drivers/mtd/nand/spi/gigadevice.c | 45 +++++-----------
 drivers/mtd/nand/spi/macronix.c   | 30 +++--------
 drivers/mtd/nand/spi/micron.c     | 26 ++-------
 drivers/mtd/nand/spi/paragon.c    | 28 +++-------
 drivers/mtd/nand/spi/toshiba.c    | 42 +++++----------
 drivers/mtd/nand/spi/winbond.c    | 34 +++---------
 include/linux/mtd/spinand.h       | 66 +++++++++++++++--------
 8 files changed, 159 insertions(+), 202 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 89f6beefb01c..71c4293a5d2f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -370,10 +370,11 @@ static int spinand_wait(struct spinand_device *spinand, u8 *s)
 	return status & STATUS_BUSY ? -ETIMEDOUT : 0;
 }
 
-static int spinand_read_id_op(struct spinand_device *spinand, u8 *buf)
+static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
+			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(0, spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->spimem, &op);
@@ -762,24 +763,62 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&winbond_spinand_manufacturer,
 };
 
-static int spinand_manufacturer_detect(struct spinand_device *spinand)
+static int spinand_manufacturer_match(struct spinand_device *spinand,
+				      enum spinand_readid_method rdid_method)
 {
+	u8 *id = spinand->id.data;
 	unsigned int i;
 	int ret;
 
 	for (i = 0; i < ARRAY_SIZE(spinand_manufacturers); i++) {
-		ret = spinand_manufacturers[i]->ops->detect(spinand);
-		if (ret > 0) {
-			spinand->manufacturer = spinand_manufacturers[i];
-			return 0;
-		} else if (ret < 0) {
-			return ret;
-		}
-	}
+		const struct spinand_manufacturer *manufacturer =
+			spinand_manufacturers[i];
+
+		if (id[0] != manufacturer->id)
+			continue;
 
+		ret = spinand_match_and_init(spinand,
+					     manufacturer->chips,
+					     manufacturer->nchips,
+					     rdid_method);
+		if (ret < 0)
+			continue;
+
+		spinand->manufacturer = manufacturer;
+		return 0;
+	}
 	return -ENOTSUPP;
 }
 
+static int spinand_manufacturer_detect(struct spinand_device *spinand)
+{
+	u8 *id = spinand->id.data;
+	int ret;
+
+	ret = spinand_read_id_op(spinand, 0, 0, id);
+	if (ret)
+		return ret;
+	ret = spinand_manufacturer_match(spinand, SPINAND_READID_METHOD_OPCODE);
+	if (!ret)
+		return 0;
+
+	ret = spinand_read_id_op(spinand, 1, 0, id);
+	if (ret)
+		return ret;
+	ret = spinand_manufacturer_match(spinand,
+					 SPINAND_READID_METHOD_OPCODE_ADDR);
+	if (!ret)
+		return 0;
+
+	ret = spinand_read_id_op(spinand, 0, 1, id);
+	if (ret)
+		return ret;
+	ret = spinand_manufacturer_match(spinand,
+					 SPINAND_READID_METHOD_OPCODE_DUMMY);
+
+	return ret;
+}
+
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
 	if (spinand->manufacturer->ops->init)
@@ -835,9 +874,9 @@ spinand_select_op_variant(struct spinand_device *spinand,
  * @spinand: SPI NAND object
  * @table: SPI NAND device description table
  * @table_size: size of the device description table
+ * @rdid_method: read id method to match
  *
- * Should be used by SPI NAND manufacturer drivers when they want to find a
- * match between a device ID retrieved through the READ_ID command and an
+ * Match between a device ID retrieved through the READ_ID command and an
  * entry in the SPI NAND description table. If a match is found, the spinand
  * object will be initialized with information provided by the matching
  * spinand_info entry.
@@ -846,22 +885,33 @@ spinand_select_op_variant(struct spinand_device *spinand,
  */
 int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
-			   unsigned int table_size, u16 devid)
+			   unsigned int table_size,
+			   enum spinand_readid_method rdid_method)
 {
+	u8 *id = spinand->id.data;
 	struct nand_device *nand = spinand_to_nand(spinand);
-	unsigned int i;
+	u16 devid;
+	unsigned int i, j;
 
 	for (i = 0; i < table_size; i++) {
 		const struct spinand_info *info = &table[i];
 		const struct spi_mem_op *op;
 
-		if (devid != info->devid)
+		if (rdid_method != info->devid.method)
+			continue;
+
+		devid = id[1];
+		for (j = 1; j < info->devid.len ; j++)
+			devid = devid << 8 | id[j + 1];
+
+		if (devid != info->devid.id)
 			continue;
 
 		nand->memorg = table[i].memorg;
 		nand->eccreq = table[i].eccreq;
 		spinand->eccinfo = table[i].eccinfo;
 		spinand->flags = table[i].flags;
+		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 
 		op = spinand_select_op_variant(spinand,
@@ -898,12 +948,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	ret = spinand_read_id_op(spinand, spinand->id.data);
-	if (ret)
-		return ret;
-
-	spinand->id.len = SPINAND_MAX_ID_LEN;
-
 	ret = spinand_manufacturer_detect(spinand);
 	if (ret) {
 		dev_err(dev, "unknown raw ID %*phN\n", SPINAND_MAX_ID_LEN,
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index e99d425aa93f..0d734dd467c7 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -195,7 +195,8 @@ static int gd5fxgq4ufxxg_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info gigadevice_spinand_table[] = {
-	SPINAND_INFO("GD5F1GQ4xA", 0xF1,
+	SPINAND_INFO("GD5F1GQ4xA",
+		     SPINAND_ID(0xF1, 1, SPINAND_READID_METHOD_OPCODE_ADDR),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -204,7 +205,8 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&gd5fxgq4xa_ooblayout,
 				     gd5fxgq4xa_ecc_get_status)),
-	SPINAND_INFO("GD5F2GQ4xA", 0xF2,
+	SPINAND_INFO("GD5F2GQ4xA",
+		     SPINAND_ID(0xF2, 1, SPINAND_READID_METHOD_OPCODE_ADDR),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -213,7 +215,8 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&gd5fxgq4xa_ooblayout,
 				     gd5fxgq4xa_ecc_get_status)),
-	SPINAND_INFO("GD5F4GQ4xA", 0xF4,
+	SPINAND_INFO("GD5F4GQ4xA",
+		     SPINAND_ID(0xF4, 1, SPINAND_READID_METHOD_OPCODE_ADDR),
 		     NAND_MEMORG(1, 2048, 64, 64, 4096, 80, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -222,7 +225,8 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&gd5fxgq4xa_ooblayout,
 				     gd5fxgq4xa_ecc_get_status)),
-	SPINAND_INFO("GD5F1GQ4UExxG", 0xd1,
+	SPINAND_INFO("GD5F1GQ4UExxG",
+		     SPINAND_ID(0xd1, 1, SPINAND_READID_METHOD_OPCODE_ADDR),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -231,7 +235,8 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&gd5fxgq4_variant2_ooblayout,
 				     gd5fxgq4uexxg_ecc_get_status)),
-	SPINAND_INFO("GD5F1GQ4UFxxG", 0xb148,
+	SPINAND_INFO("GD5F1GQ4UFxxG",
+		     SPINAND_ID(0xb148, 2, SPINAND_READID_METHOD_OPCODE),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_f,
@@ -242,39 +247,13 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 				     gd5fxgq4ufxxg_ecc_get_status)),
 };
 
-static int gigadevice_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	u16 did;
-	int ret;
-
-	/*
-	 * Earlier GDF5-series devices (A,E) return [0][MID][DID]
-	 * Later (F) devices return [MID][DID1][DID2]
-	 */
-
-	if (id[0] == SPINAND_MFR_GIGADEVICE)
-		did = (id[1] << 8) + id[2];
-	else if (id[0] == 0 && id[1] == SPINAND_MFR_GIGADEVICE)
-		did = id[2];
-	else
-		return 0;
-
-	ret = spinand_match_and_init(spinand, gigadevice_spinand_table,
-				     ARRAY_SIZE(gigadevice_spinand_table),
-				     did);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
-	.detect = gigadevice_spinand_detect,
 };
 
 const struct spinand_manufacturer gigadevice_spinand_manufacturer = {
 	.id = SPINAND_MFR_GIGADEVICE,
 	.name = "GigaDevice",
+	.chips = gigadevice_spinand_table,
+	.nchips = ARRAY_SIZE(gigadevice_spinand_table),
 	.ops = &gigadevice_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 21def3f8fb36..2d9c179d290e 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -99,7 +99,8 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info macronix_spinand_table[] = {
-	SPINAND_INFO("MX35LF1GE4AB", 0x12,
+	SPINAND_INFO("MX35LF1GE4AB",
+		     SPINAND_ID(0x12, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -108,7 +109,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
-	SPINAND_INFO("MX35LF2GE4AB", 0x22,
+	SPINAND_INFO("MX35LF2GE4AB",
+		     SPINAND_ID(0x22, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -118,33 +120,13 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 };
 
-static int macronix_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * Macronix SPI NAND read ID needs a dummy byte, so the first byte in
-	 * raw_id is garbage.
-	 */
-	if (id[1] != SPINAND_MFR_MACRONIX)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, macronix_spinand_table,
-				     ARRAY_SIZE(macronix_spinand_table),
-				     id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
-	.detect = macronix_spinand_detect,
 };
 
 const struct spinand_manufacturer macronix_spinand_manufacturer = {
 	.id = SPINAND_MFR_MACRONIX,
 	.name = "Macronix",
+	.chips = macronix_spinand_table,
+	.nchips = ARRAY_SIZE(macronix_spinand_table),
 	.ops = &macronix_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 7d7b1f7fcf71..339643e3739a 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -91,7 +91,8 @@ static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info micron_spinand_table[] = {
-	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
+	SPINAND_INFO("MT29F2G01ABAGD",
+		     SPINAND_ID(0x24, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -102,32 +103,13 @@ static const struct spinand_info micron_spinand_table[] = {
 				     mt29f2g01abagd_ecc_get_status)),
 };
 
-static int micron_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * Micron SPI NAND read ID need a dummy byte,
-	 * so the first byte in raw_id is dummy.
-	 */
-	if (id[1] != SPINAND_MFR_MICRON)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, micron_spinand_table,
-				     ARRAY_SIZE(micron_spinand_table), id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
-	.detect = micron_spinand_detect,
 };
 
 const struct spinand_manufacturer micron_spinand_manufacturer = {
 	.id = SPINAND_MFR_MICRON,
 	.name = "Micron",
+	.chips = micron_spinand_table,
+	.nchips = ARRAY_SIZE(micron_spinand_table),
 	.ops = &micron_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index 52307681cbd0..dc2c9e535613 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -97,7 +97,8 @@ static const struct mtd_ooblayout_ops pn26g0xa_ooblayout = {
 
 
 static const struct spinand_info paragon_spinand_table[] = {
-	SPINAND_INFO("PN26G01A", 0xe1,
+	SPINAND_INFO("PN26G01A",
+		     SPINAND_ID(0xe1, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 21, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -106,7 +107,8 @@ static const struct spinand_info paragon_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&pn26g0xa_ooblayout,
 				     pn26g0xa_ecc_get_status)),
-	SPINAND_INFO("PN26G02A", 0xe2,
+	SPINAND_INFO("PN26G02A",
+		     SPINAND_ID(0xe2, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 41, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -117,31 +119,13 @@ static const struct spinand_info paragon_spinand_table[] = {
 				     pn26g0xa_ecc_get_status)),
 };
 
-static int paragon_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/* Read ID returns [0][MID][DID] */
-
-	if (id[1] != SPINAND_MFR_PARAGON)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, paragon_spinand_table,
-				     ARRAY_SIZE(paragon_spinand_table),
-				     id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static const struct spinand_manufacturer_ops paragon_spinand_manuf_ops = {
-	.detect = paragon_spinand_detect,
 };
 
 const struct spinand_manufacturer paragon_spinand_manufacturer = {
 	.id = SPINAND_MFR_PARAGON,
 	.name = "Paragon",
+	.chips = paragon_spinand_table,
+	.nchips = ARRAY_SIZE(paragon_spinand_table),
 	.ops = &paragon_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 1cb3760ff779..6b1b4f07856b 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -95,7 +95,8 @@ static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 
 static const struct spinand_info toshiba_spinand_table[] = {
 	/* 3.3V 1Gb */
-	SPINAND_INFO("TC58CVG0S3", 0xC2,
+	SPINAND_INFO("TC58CVG0S3",
+		     SPINAND_ID(0xC2, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -105,7 +106,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
 				     tc58cxgxsx_ecc_get_status)),
 	/* 3.3V 2Gb */
-	SPINAND_INFO("TC58CVG1S3", 0xCB,
+	SPINAND_INFO("TC58CVG1S3",
+		     SPINAND_ID(0xCB, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -115,7 +117,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
 				     tc58cxgxsx_ecc_get_status)),
 	/* 3.3V 4Gb */
-	SPINAND_INFO("TC58CVG2S0", 0xCD,
+	SPINAND_INFO("TC58CVG2S0",
+		     SPINAND_ID(0xCD, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -125,7 +128,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
 				     tc58cxgxsx_ecc_get_status)),
 	/* 1.8V 1Gb */
-	SPINAND_INFO("TC58CYG0S3", 0xB2,
+	SPINAND_INFO("TC58CYG0S3",
+		     SPINAND_ID(0xB2, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -135,7 +139,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
 				     tc58cxgxsx_ecc_get_status)),
 	/* 1.8V 2Gb */
-	SPINAND_INFO("TC58CYG1S3", 0xBB,
+	SPINAND_INFO("TC58CYG1S3",
+		     SPINAND_ID(0xBB, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -145,7 +150,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
 				     tc58cxgxsx_ecc_get_status)),
 	/* 1.8V 4Gb */
-	SPINAND_INFO("TC58CYG2S0", 0xBD,
+	SPINAND_INFO("TC58CYG2S0",
+		     SPINAND_ID(0xBD, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -156,33 +162,13 @@ static const struct spinand_info toshiba_spinand_table[] = {
 				     tc58cxgxsx_ecc_get_status)),
 };
 
-static int toshiba_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * Toshiba SPI NAND read ID needs a dummy byte,
-	 * so the first byte in id is garbage.
-	 */
-	if (id[1] != SPINAND_MFR_TOSHIBA)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, toshiba_spinand_table,
-				     ARRAY_SIZE(toshiba_spinand_table),
-				     id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
-	.detect = toshiba_spinand_detect,
 };
 
 const struct spinand_manufacturer toshiba_spinand_manufacturer = {
 	.id = SPINAND_MFR_TOSHIBA,
 	.name = "Toshiba",
+	.chips = toshiba_spinand_table,
+	.nchips = ARRAY_SIZE(toshiba_spinand_table),
 	.ops = &toshiba_spinand_manuf_ops,
 };
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index a6c17e0cace8..765a69d217b6 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -75,7 +75,8 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
 }
 
 static const struct spinand_info winbond_spinand_table[] = {
-	SPINAND_INFO("W25M02GV", 0xAB,
+	SPINAND_INFO("W25M02GV",
+		     SPINAND_ID(0xAB, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -84,7 +85,8 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
-	SPINAND_INFO("W25N01GV", 0xAA,
+	SPINAND_INFO("W25N01GV",
+		     SPINAND_ID(0xAA, 1, SPINAND_READID_METHOD_OPCODE_DUMMY),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -94,31 +96,6 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 };
 
-/**
- * winbond_spinand_detect - initialize device related part in spinand_device
- * struct if it is a Winbond device.
- * @spinand: SPI NAND device structure
- */
-static int winbond_spinand_detect(struct spinand_device *spinand)
-{
-	u8 *id = spinand->id.data;
-	int ret;
-
-	/*
-	 * Winbond SPI NAND read ID need a dummy byte,
-	 * so the first byte in raw_id is dummy.
-	 */
-	if (id[1] != SPINAND_MFR_WINBOND)
-		return 0;
-
-	ret = spinand_match_and_init(spinand, winbond_spinand_table,
-				     ARRAY_SIZE(winbond_spinand_table), id[2]);
-	if (ret)
-		return ret;
-
-	return 1;
-}
-
 static int winbond_spinand_init(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -138,12 +115,13 @@ static int winbond_spinand_init(struct spinand_device *spinand)
 }
 
 static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
-	.detect = winbond_spinand_detect,
 	.init = winbond_spinand_init,
 };
 
 const struct spinand_manufacturer winbond_spinand_manufacturer = {
 	.id = SPINAND_MFR_WINBOND,
 	.name = "Winbond",
+	.chips = winbond_spinand_table,
+	.nchips = ARRAY_SIZE(winbond_spinand_table),
 	.ops = &winbond_spinand_manuf_ops,
 };
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 4ea558bd3c46..626f9e54ddfd 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -32,9 +32,9 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_READID_OP(ndummy, buf, len)				\
+#define SPINAND_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9f, 1),				\
-		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_ADDR(naddr, 0, 1),			\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
@@ -176,37 +176,46 @@ struct spinand_device;
  * @data: buffer containing the id bytes. Currently 4 bytes large, but can
  *	  be extended if required
  * @len: ID length
- *
- * struct_spinand_id->data contains all bytes returned after a READ_ID command,
- * including dummy bytes if the chip does not emit ID bytes right after the
- * READ_ID command. The responsibility to extract real ID bytes is left to
- * struct_manufacurer_ops->detect().
  */
 struct spinand_id {
 	u8 data[SPINAND_MAX_ID_LEN];
 	int len;
 };
 
+enum spinand_readid_method {
+	SPINAND_READID_METHOD_OPCODE,
+	SPINAND_READID_METHOD_OPCODE_ADDR,
+	SPINAND_READID_METHOD_OPCODE_DUMMY,
+};
+
+/**
+ * struct spinand_devid - SPI NAND device id structure
+ * @id: device id of current chip
+ * @len: number of bytes in device id
+ * @method: method to read chip id
+ *	    There are 3 possible variants:
+ *	    SPINAND_READID_METHOD_OPCODE: chip id is returned immediately
+ *	    after read_id opcode.
+ *	    SPINAND_READID_METHOD_OPCODE_ADDR: chip id is returned after
+ *	    read_id opcode + 1-byte address.
+ *	    SPINAND_READID_METHOD_OPCODE_DUMMY: chip id is returned after
+ *	    read_id opcode + 1 dummy byte.
+ */
+struct spinand_devid {
+	u16 id;
+	u8 len;
+	enum spinand_readid_method method;
+};
+
 /**
  * struct manufacurer_ops - SPI NAND manufacturer specific operations
- * @detect: detect a SPI NAND device. Every time a SPI NAND device is probed
- *	    the core calls the struct_manufacurer_ops->detect() hook of each
- *	    registered manufacturer until one of them return 1. Note that
- *	    the first thing to check in this hook is that the manufacturer ID
- *	    in struct_spinand_device->id matches the manufacturer whose
- *	    ->detect() hook has been called. Should return 1 if there's a
- *	    match, 0 if the manufacturer ID does not match and a negative
- *	    error code otherwise. When true is returned, the core assumes
- *	    that properties of the NAND chip (spinand->base.memorg and
- *	    spinand->base.eccreq) have been filled
  * @init: initialize a SPI NAND device
  * @cleanup: cleanup a SPI NAND device
  *
  * Each SPI NAND manufacturer driver should implement this interface so that
- * NAND chips coming from this vendor can be detected and initialized properly.
+ * NAND chips coming from this vendor can be initialized properly.
  */
 struct spinand_manufacturer_ops {
-	int (*detect)(struct spinand_device *spinand);
 	int (*init)(struct spinand_device *spinand);
 	void (*cleanup)(struct spinand_device *spinand);
 };
@@ -215,11 +224,16 @@ struct spinand_manufacturer_ops {
  * struct spinand_manufacturer - SPI NAND manufacturer instance
  * @id: manufacturer ID
  * @name: manufacturer name
+ * @devid_len: number of bytes in device ID
+ * @chips: supported SPI NANDs under current manufacturer
+ * @nchips: number of SPI NANDs available in chips array
  * @ops: manufacturer operations
  */
 struct spinand_manufacturer {
 	u8 id;
 	char *name;
+	const struct spinand_info *chips;
+	const size_t nchips;
 	const struct spinand_manufacturer_ops *ops;
 };
 
@@ -291,7 +305,7 @@ struct spinand_ecc_info {
  */
 struct spinand_info {
 	const char *model;
-	u16 devid;
+	struct spinand_devid devid;
 	u32 flags;
 	struct nand_memory_organization memorg;
 	struct nand_ecc_req eccreq;
@@ -305,6 +319,13 @@ struct spinand_info {
 			     unsigned int target);
 };
 
+#define SPINAND_ID(__id, __len, __method)				\
+	{								\
+		.id = __id,						\
+		.len = __len,						\
+		.method = __method,					\
+	}
+
 #define SPINAND_INFO_OP_VARIANTS(__read, __write, __update)		\
 	{								\
 		.read_cache = __read,					\
@@ -451,9 +472,10 @@ static inline void spinand_set_of_node(struct spinand_device *spinand,
 	nanddev_set_of_node(&spinand->base, np);
 }
 
-int spinand_match_and_init(struct spinand_device *dev,
+int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
-			   unsigned int table_size, u16 devid);
+			   unsigned int table_size,
+			   enum spinand_readid_method rdid_method);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
-- 
2.24.1

