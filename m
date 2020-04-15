Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71571C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BFD206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aAQmrtxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415097AbgDOQAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:00:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28068 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415052AbgDOP7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:59:37 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FFbV2V021305;
        Wed, 15 Apr 2020 17:59:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=MAAvXOpPFKkjpOaCEBbUbgZpac918EwI2tYNZN7FjEw=;
 b=aAQmrtxRGR6ABz6w95fGuTDIUrhsug9Bl9O7W+rwnJN8o+wvJDptPbu66/bFkMYTV2C/
 MbHG1ubDnVpC56fpf3fJs5tp6SBep1Vyhm9NAmVRTWQ8PSqbKqwGllhLWKTiZjkL7UOr
 zVdBrOT6UOf1cBBnhHDYyOQ8vpQtHDXehnlCx8kfNEE7ZX6REaeptfovjRTFoiCygkq1
 tJeVY3Y/FxLu9jpVpgdBAHK+QZoCip/jgyrJmg2QsmepyUQ1NbOwKuE2+mWfmQ0xumBS
 4S2/B/2Yc+vTEgDW3sgbX5ePzNmbXVlLdJIWOAhcVkiXAA2jkNu6MEzmPgKBNFbv8RwS wA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn8rvx2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 17:59:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E0D86100034;
        Wed, 15 Apr 2020 17:59:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D06F92AF597;
        Wed, 15 Apr 2020 17:59:15 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 15 Apr 2020 17:59:13
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v2 10/12] mtd: rawnand: stm32_fmc2: use regmap APIs
Date:   Wed, 15 Apr 2020 17:57:34 +0200
Message-ID: <1586966256-29548-11-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_05:2020-04-14,2020-04-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses regmap APIs to access all FMC2 registers.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
Changes in v2:
 - use of regmap_bulk_write/regmap_bulk_read APIs

 drivers/mtd/nand/raw/Kconfig           |   2 +
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 267 +++++++++++++++------------------
 2 files changed, 126 insertions(+), 143 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index a80a46b..12b715a 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -419,6 +419,8 @@ config MTD_NAND_TEGRA
 config MTD_NAND_STM32_FMC2
 	tristate "Support for NAND controller on STM32MP SoCs"
 	depends on MACH_STM32MP157 || COMPILE_TEST
+	select REGMAP
+	select REGMAP_MMIO
 	help
 	  Enables support for NAND Flash chips on SoCs containing the FMC2
 	  NAND controller. This controller is found on STM32MP SoCs.
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 9f12a59..a3c2a11 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -51,6 +51,16 @@
 #define FMC2_PMEM_DEFAULT		0x0a0a0a0a
 #define FMC2_PATT_DEFAULT		0x0a0a0a0a
 
+/* Regmap registers configuration */
+#define FMC2_MAX_REGISTER		0x3fc
+
+static const struct regmap_config stm32_fmc2_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = FMC2_MAX_REGISTER,
+};
+
 enum stm32_fmc2_ecc {
 	FMC2_ECC_HAM = 1,
 	FMC2_ECC_BCH4 = 4,
@@ -90,7 +100,7 @@ struct stm32_fmc2_nfc {
 	struct nand_controller base;
 	struct stm32_fmc2_nand nand;
 	struct device *dev;
-	void __iomem *io_base;
+	struct regmap *regmap;
 	void __iomem *data_base[FMC2_MAX_CE];
 	void __iomem *cmd_base[FMC2_MAX_CE];
 	void __iomem *addr_base[FMC2_MAX_CE];
@@ -125,40 +135,37 @@ static void stm32_fmc2_nfc_timings_init(struct nand_chip *chip)
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct stm32_fmc2_nand *nand = to_fmc2_nand(chip);
 	struct stm32_fmc2_timings *timings = &nand->timings;
-	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
 	u32 pmem, patt;
 
 	/* Set tclr/tar timings */
-	pcr &= ~FMC2_PCR_TCLR;
-	pcr |= FIELD_PREP(FMC2_PCR_TCLR, timings->tclr);
-	pcr &= ~FMC2_PCR_TAR;
-	pcr |= FIELD_PREP(FMC2_PCR_TAR, timings->tar);
+	regmap_update_bits(nfc->regmap, FMC2_PCR,
+			   FMC2_PCR_TCLR | FMC2_PCR_TAR,
+			   FIELD_PREP(FMC2_PCR_TCLR, timings->tclr) |
+			   FIELD_PREP(FMC2_PCR_TAR, timings->tar));
 
 	/* Set tset/twait/thold/thiz timings in common bank */
 	pmem = FIELD_PREP(FMC2_PMEM_MEMSET, timings->tset_mem);
 	pmem |= FIELD_PREP(FMC2_PMEM_MEMWAIT, timings->twait);
 	pmem |= FIELD_PREP(FMC2_PMEM_MEMHOLD, timings->thold_mem);
 	pmem |= FIELD_PREP(FMC2_PMEM_MEMHIZ, timings->thiz);
+	regmap_write(nfc->regmap, FMC2_PMEM, pmem);
 
 	/* Set tset/twait/thold/thiz timings in attribut bank */
 	patt = FIELD_PREP(FMC2_PATT_ATTSET, timings->tset_att);
 	patt |= FIELD_PREP(FMC2_PATT_ATTWAIT, timings->twait);
 	patt |= FIELD_PREP(FMC2_PATT_ATTHOLD, timings->thold_att);
 	patt |= FIELD_PREP(FMC2_PATT_ATTHIZ, timings->thiz);
-
-	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
-	writel_relaxed(pmem, nfc->io_base + FMC2_PMEM);
-	writel_relaxed(patt, nfc->io_base + FMC2_PATT);
+	regmap_write(nfc->regmap, FMC2_PATT, patt);
 }
 
 static void stm32_fmc2_nfc_setup(struct nand_chip *chip)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
-	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
+	u32 pcr = 0, pcr_mask;
 
 	/* Configure ECC algorithm (default configuration is Hamming) */
-	pcr &= ~FMC2_PCR_ECCALG;
-	pcr &= ~FMC2_PCR_BCHECC;
+	pcr_mask = FMC2_PCR_ECCALG;
+	pcr_mask |= FMC2_PCR_BCHECC;
 	if (chip->ecc.strength == FMC2_ECC_BCH8) {
 		pcr |= FMC2_PCR_ECCALG;
 		pcr |= FMC2_PCR_BCHECC;
@@ -167,15 +174,15 @@ static void stm32_fmc2_nfc_setup(struct nand_chip *chip)
 	}
 
 	/* Set buswidth */
-	pcr &= ~FMC2_PCR_PWID;
+	pcr_mask |= FMC2_PCR_PWID;
 	if (chip->options & NAND_BUSWIDTH_16)
 		pcr |= FIELD_PREP(FMC2_PCR_PWID, FMC2_PCR_PWID_BUSWIDTH_16);
 
 	/* Set ECC sector size */
-	pcr &= ~FMC2_PCR_ECCSS;
+	pcr_mask |= FMC2_PCR_ECCSS;
 	pcr |= FIELD_PREP(FMC2_PCR_ECCSS, FMC2_PCR_ECCSS_512);
 
-	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
+	regmap_update_bits(nfc->regmap, FMC2_PCR, pcr_mask, pcr);
 }
 
 static int stm32_fmc2_nfc_select_chip(struct nand_chip *chip, int chipnr)
@@ -241,81 +248,63 @@ static int stm32_fmc2_nfc_select_chip(struct nand_chip *chip, int chipnr)
 
 static void stm32_fmc2_nfc_set_buswidth_16(struct stm32_fmc2_nfc *nfc, bool set)
 {
-	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
+	u32 pcr;
 
-	pcr &= ~FMC2_PCR_PWID;
-	if (set)
-		pcr |= FIELD_PREP(FMC2_PCR_PWID, FMC2_PCR_PWID_BUSWIDTH_16);
-	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
+	pcr = set ? FIELD_PREP(FMC2_PCR_PWID, FMC2_PCR_PWID_BUSWIDTH_16) :
+		    FIELD_PREP(FMC2_PCR_PWID, FMC2_PCR_PWID_BUSWIDTH_8);
+
+	regmap_update_bits(nfc->regmap, FMC2_PCR, FMC2_PCR_PWID, pcr);
 }
 
 static void stm32_fmc2_nfc_set_ecc(struct stm32_fmc2_nfc *nfc, bool enable)
 {
-	u32 pcr = readl(nfc->io_base + FMC2_PCR);
-
-	pcr &= ~FMC2_PCR_ECCEN;
-	if (enable)
-		pcr |= FMC2_PCR_ECCEN;
-	writel(pcr, nfc->io_base + FMC2_PCR);
+	regmap_update_bits(nfc->regmap, FMC2_PCR, FMC2_PCR_ECCEN,
+			   enable ? FMC2_PCR_ECCEN : 0);
 }
 
-static inline void stm32_fmc2_nfc_enable_seq_irq(struct stm32_fmc2_nfc *nfc)
+static void stm32_fmc2_nfc_enable_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
-	u32 csqier = readl_relaxed(nfc->io_base + FMC2_CSQIER);
-
-	csqier |= FMC2_CSQIER_TCIE;
-
 	nfc->irq_state = FMC2_IRQ_SEQ;
 
-	writel_relaxed(csqier, nfc->io_base + FMC2_CSQIER);
+	regmap_update_bits(nfc->regmap, FMC2_CSQIER,
+			   FMC2_CSQIER_TCIE, FMC2_CSQIER_TCIE);
 }
 
-static inline void stm32_fmc2_nfc_disable_seq_irq(struct stm32_fmc2_nfc *nfc)
+static void stm32_fmc2_nfc_disable_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
-	u32 csqier = readl_relaxed(nfc->io_base + FMC2_CSQIER);
-
-	csqier &= ~FMC2_CSQIER_TCIE;
-
-	writel_relaxed(csqier, nfc->io_base + FMC2_CSQIER);
+	regmap_update_bits(nfc->regmap, FMC2_CSQIER, FMC2_CSQIER_TCIE, 0);
 
 	nfc->irq_state = FMC2_IRQ_UNKNOWN;
 }
 
-static inline void stm32_fmc2_nfc_clear_seq_irq(struct stm32_fmc2_nfc *nfc)
+static void stm32_fmc2_nfc_clear_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
-	writel_relaxed(FMC2_CSQICR_CLEAR_IRQ, nfc->io_base + FMC2_CSQICR);
+	regmap_write(nfc->regmap, FMC2_CSQICR, FMC2_CSQICR_CLEAR_IRQ);
 }
 
-static inline void stm32_fmc2_nfc_enable_bch_irq(struct stm32_fmc2_nfc *nfc,
-						 int mode)
+static void stm32_fmc2_nfc_enable_bch_irq(struct stm32_fmc2_nfc *nfc, int mode)
 {
-	u32 bchier = readl_relaxed(nfc->io_base + FMC2_BCHIER);
+	nfc->irq_state = FMC2_IRQ_BCH;
 
 	if (mode == NAND_ECC_WRITE)
-		bchier |= FMC2_BCHIER_EPBRIE;
+		regmap_update_bits(nfc->regmap, FMC2_BCHIER,
+				   FMC2_BCHIER_EPBRIE, FMC2_BCHIER_EPBRIE);
 	else
-		bchier |= FMC2_BCHIER_DERIE;
-
-	nfc->irq_state = FMC2_IRQ_BCH;
-
-	writel_relaxed(bchier, nfc->io_base + FMC2_BCHIER);
+		regmap_update_bits(nfc->regmap, FMC2_BCHIER,
+				   FMC2_BCHIER_DERIE, FMC2_BCHIER_DERIE);
 }
 
-static inline void stm32_fmc2_nfc_disable_bch_irq(struct stm32_fmc2_nfc *nfc)
+static void stm32_fmc2_nfc_disable_bch_irq(struct stm32_fmc2_nfc *nfc)
 {
-	u32 bchier = readl_relaxed(nfc->io_base + FMC2_BCHIER);
-
-	bchier &= ~FMC2_BCHIER_DERIE;
-	bchier &= ~FMC2_BCHIER_EPBRIE;
-
-	writel_relaxed(bchier, nfc->io_base + FMC2_BCHIER);
+	regmap_update_bits(nfc->regmap, FMC2_BCHIER,
+			   FMC2_BCHIER_DERIE | FMC2_BCHIER_EPBRIE, 0);
 
 	nfc->irq_state = FMC2_IRQ_UNKNOWN;
 }
 
-static inline void stm32_fmc2_nfc_clear_bch_irq(struct stm32_fmc2_nfc *nfc)
+static void stm32_fmc2_nfc_clear_bch_irq(struct stm32_fmc2_nfc *nfc)
 {
-	writel_relaxed(FMC2_BCHICR_CLEAR_IRQ, nfc->io_base + FMC2_BCHICR);
+	regmap_write(nfc->regmap, FMC2_BCHICR, FMC2_BCHICR_CLEAR_IRQ);
 }
 
 /*
@@ -329,13 +318,8 @@ static void stm32_fmc2_nfc_hwctl(struct nand_chip *chip, int mode)
 	stm32_fmc2_nfc_set_ecc(nfc, false);
 
 	if (chip->ecc.strength != FMC2_ECC_HAM) {
-		u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
-
-		if (mode == NAND_ECC_WRITE)
-			pcr |= FMC2_PCR_WEN;
-		else
-			pcr &= ~FMC2_PCR_WEN;
-		writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
+		regmap_update_bits(nfc->regmap, FMC2_PCR, FMC2_PCR_WEN,
+				   mode == NAND_ECC_WRITE ? FMC2_PCR_WEN : 0);
 
 		reinit_completion(&nfc->complete);
 		stm32_fmc2_nfc_clear_bch_irq(nfc);
@@ -350,7 +334,7 @@ static void stm32_fmc2_nfc_hwctl(struct nand_chip *chip, int mode)
  * ECC is 3 bytes for 512 bytes of data (supports error correction up to
  * max of 1-bit)
  */
-static inline void stm32_fmc2_nfc_ham_set_ecc(const u32 ecc_sta, u8 *ecc)
+static void stm32_fmc2_nfc_ham_set_ecc(const u32 ecc_sta, u8 *ecc)
 {
 	ecc[0] = ecc_sta;
 	ecc[1] = ecc_sta >> 8;
@@ -364,15 +348,15 @@ static int stm32_fmc2_nfc_ham_calculate(struct nand_chip *chip, const u8 *data,
 	u32 sr, heccr;
 	int ret;
 
-	ret = readl_relaxed_poll_timeout_atomic(nfc->io_base + FMC2_SR,
-						sr, sr & FMC2_SR_NWRF, 1,
-						1000 * FMC2_TIMEOUT_MS);
+	ret = regmap_read_poll_timeout(nfc->regmap, FMC2_SR, sr,
+				       sr & FMC2_SR_NWRF, 1,
+				       1000 * FMC2_TIMEOUT_MS);
 	if (ret) {
 		dev_err(nfc->dev, "ham timeout\n");
 		return ret;
 	}
 
-	heccr = readl_relaxed(nfc->io_base + FMC2_HECCR);
+	regmap_read(nfc->regmap, FMC2_HECCR, &heccr);
 	stm32_fmc2_nfc_ham_set_ecc(heccr, ecc);
 	stm32_fmc2_nfc_set_ecc(nfc, false);
 
@@ -451,13 +435,13 @@ static int stm32_fmc2_nfc_bch_calculate(struct nand_chip *chip, const u8 *data,
 	}
 
 	/* Read parity bits */
-	bchpbr = readl_relaxed(nfc->io_base + FMC2_BCHPBR1);
+	regmap_read(nfc->regmap, FMC2_BCHPBR1, &bchpbr);
 	ecc[0] = bchpbr;
 	ecc[1] = bchpbr >> 8;
 	ecc[2] = bchpbr >> 16;
 	ecc[3] = bchpbr >> 24;
 
-	bchpbr = readl_relaxed(nfc->io_base + FMC2_BCHPBR2);
+	regmap_read(nfc->regmap, FMC2_BCHPBR2, &bchpbr);
 	ecc[4] = bchpbr;
 	ecc[5] = bchpbr >> 8;
 	ecc[6] = bchpbr >> 16;
@@ -465,13 +449,13 @@ static int stm32_fmc2_nfc_bch_calculate(struct nand_chip *chip, const u8 *data,
 	if (chip->ecc.strength == FMC2_ECC_BCH8) {
 		ecc[7] = bchpbr >> 24;
 
-		bchpbr = readl_relaxed(nfc->io_base + FMC2_BCHPBR3);
+		regmap_read(nfc->regmap, FMC2_BCHPBR3, &bchpbr);
 		ecc[8] = bchpbr;
 		ecc[9] = bchpbr >> 8;
 		ecc[10] = bchpbr >> 16;
 		ecc[11] = bchpbr >> 24;
 
-		bchpbr = readl_relaxed(nfc->io_base + FMC2_BCHPBR4);
+		regmap_read(nfc->regmap, FMC2_BCHPBR4, &bchpbr);
 		ecc[12] = bchpbr;
 	}
 
@@ -533,11 +517,7 @@ static int stm32_fmc2_nfc_bch_correct(struct nand_chip *chip, u8 *dat,
 		return -ETIMEDOUT;
 	}
 
-	ecc_sta[0] = readl_relaxed(nfc->io_base + FMC2_BCHDSR0);
-	ecc_sta[1] = readl_relaxed(nfc->io_base + FMC2_BCHDSR1);
-	ecc_sta[2] = readl_relaxed(nfc->io_base + FMC2_BCHDSR2);
-	ecc_sta[3] = readl_relaxed(nfc->io_base + FMC2_BCHDSR3);
-	ecc_sta[4] = readl_relaxed(nfc->io_base + FMC2_BCHDSR4);
+	regmap_bulk_read(nfc->regmap, FMC2_BCHDSR0, ecc_sta, 5);
 
 	stm32_fmc2_nfc_set_ecc(nfc, false);
 
@@ -612,30 +592,29 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	u32 csqcfgr1, csqcfgr2, csqcfgr3;
-	u32 csqar1, csqar2;
 	u32 ecc_offset = mtd->writesize + FMC2_BBM_LEN;
-	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
+	/*
+	 * cfg[0] => csqcfgr1, cfg[1] => csqcfgr2, cfg[2] => csqcfgr3
+	 * cfg[3] => csqar1, cfg[4] => csqar2
+	 */
+	u32 cfg[5];
 
-	if (write_data)
-		pcr |= FMC2_PCR_WEN;
-	else
-		pcr &= ~FMC2_PCR_WEN;
-	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
+	regmap_update_bits(nfc->regmap, FMC2_PCR, FMC2_PCR_WEN,
+			   write_data ? FMC2_PCR_WEN : 0);
 
 	/*
 	 * - Set Program Page/Page Read command
 	 * - Enable DMA request data
 	 * - Set timings
 	 */
-	csqcfgr1 = FMC2_CSQCFGR1_DMADEN | FMC2_CSQCFGR1_CMD1T;
+	cfg[0] = FMC2_CSQCFGR1_DMADEN | FMC2_CSQCFGR1_CMD1T;
 	if (write_data)
-		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_CMD1, NAND_CMD_SEQIN);
+		cfg[0] |= FIELD_PREP(FMC2_CSQCFGR1_CMD1, NAND_CMD_SEQIN);
 	else
-		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_CMD1, NAND_CMD_READ0) |
-			    FMC2_CSQCFGR1_CMD2EN |
-			    FIELD_PREP(FMC2_CSQCFGR1_CMD2, NAND_CMD_READSTART) |
-			    FMC2_CSQCFGR1_CMD2T;
+		cfg[0] |= FIELD_PREP(FMC2_CSQCFGR1_CMD1, NAND_CMD_READ0) |
+			  FMC2_CSQCFGR1_CMD2EN |
+			  FIELD_PREP(FMC2_CSQCFGR1_CMD2, NAND_CMD_READSTART) |
+			  FMC2_CSQCFGR1_CMD2T;
 
 	/*
 	 * - Set Random Data Input/Random Data Read command
@@ -644,30 +623,29 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 	 * - Set timings
 	 */
 	if (write_data)
-		csqcfgr2 = FIELD_PREP(FMC2_CSQCFGR2_RCMD1, NAND_CMD_RNDIN);
+		cfg[1] = FIELD_PREP(FMC2_CSQCFGR2_RCMD1, NAND_CMD_RNDIN);
 	else
-		csqcfgr2 = FIELD_PREP(FMC2_CSQCFGR2_RCMD1, NAND_CMD_RNDOUT) |
-			   FMC2_CSQCFGR2_RCMD2EN |
-			   FIELD_PREP(FMC2_CSQCFGR2_RCMD2,
-				      NAND_CMD_RNDOUTSTART) |
-			   FMC2_CSQCFGR2_RCMD1T |
-			   FMC2_CSQCFGR2_RCMD2T;
+		cfg[1] = FIELD_PREP(FMC2_CSQCFGR2_RCMD1, NAND_CMD_RNDOUT) |
+			 FMC2_CSQCFGR2_RCMD2EN |
+			 FIELD_PREP(FMC2_CSQCFGR2_RCMD2, NAND_CMD_RNDOUTSTART) |
+			 FMC2_CSQCFGR2_RCMD1T |
+			 FMC2_CSQCFGR2_RCMD2T;
 	if (!raw) {
-		csqcfgr2 |= write_data ? 0 : FMC2_CSQCFGR2_DMASEN;
-		csqcfgr2 |= FMC2_CSQCFGR2_SQSDTEN;
+		cfg[1] |= write_data ? 0 : FMC2_CSQCFGR2_DMASEN;
+		cfg[1] |= FMC2_CSQCFGR2_SQSDTEN;
 	}
 
 	/*
 	 * - Set the number of sectors to be written
 	 * - Set timings
 	 */
-	csqcfgr3 = FIELD_PREP(FMC2_CSQCFGR3_SNBR, chip->ecc.steps - 1);
+	cfg[2] = FIELD_PREP(FMC2_CSQCFGR3_SNBR, chip->ecc.steps - 1);
 	if (write_data) {
-		csqcfgr3 |= FMC2_CSQCFGR3_RAC2T;
+		cfg[2] |= FMC2_CSQCFGR3_RAC2T;
 		if (chip->options & NAND_ROW_ADDR_3)
-			csqcfgr3 |= FMC2_CSQCFGR3_AC5T;
+			cfg[2] |= FMC2_CSQCFGR3_AC5T;
 		else
-			csqcfgr3 |= FMC2_CSQCFGR3_AC4T;
+			cfg[2] |= FMC2_CSQCFGR3_AC4T;
 	}
 
 	/*
@@ -675,8 +653,8 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 	 * Byte 1 and byte 2 => column, we start at 0x0
 	 * Byte 3 and byte 4 => page
 	 */
-	csqar1 = FIELD_PREP(FMC2_CSQCAR1_ADDC3, page);
-	csqar1 |= FIELD_PREP(FMC2_CSQCAR1_ADDC4, page >> 8);
+	cfg[3] = FIELD_PREP(FMC2_CSQCAR1_ADDC3, page);
+	cfg[3] |= FIELD_PREP(FMC2_CSQCAR1_ADDC4, page >> 8);
 
 	/*
 	 * - Set chip enable number
@@ -684,23 +662,19 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 	 * - Calculate the number of address cycles to be issued
 	 * - Set byte 5 of address cycle if needed
 	 */
-	csqar2 = FIELD_PREP(FMC2_CSQCAR2_NANDCEN, nfc->cs_sel);
+	cfg[4] = FIELD_PREP(FMC2_CSQCAR2_NANDCEN, nfc->cs_sel);
 	if (chip->options & NAND_BUSWIDTH_16)
-		csqar2 |= FIELD_PREP(FMC2_CSQCAR2_SAO, ecc_offset >> 1);
+		cfg[4] |= FIELD_PREP(FMC2_CSQCAR2_SAO, ecc_offset >> 1);
 	else
-		csqar2 |= FIELD_PREP(FMC2_CSQCAR2_SAO, ecc_offset);
+		cfg[4] |= FIELD_PREP(FMC2_CSQCAR2_SAO, ecc_offset);
 	if (chip->options & NAND_ROW_ADDR_3) {
-		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_ACYNBR, 5);
-		csqar2 |= FIELD_PREP(FMC2_CSQCAR2_ADDC5, page >> 16);
+		cfg[0] |= FIELD_PREP(FMC2_CSQCFGR1_ACYNBR, 5);
+		cfg[4] |= FIELD_PREP(FMC2_CSQCAR2_ADDC5, page >> 16);
 	} else {
-		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_ACYNBR, 4);
+		cfg[0] |= FIELD_PREP(FMC2_CSQCFGR1_ACYNBR, 4);
 	}
 
-	writel_relaxed(csqcfgr1, nfc->io_base + FMC2_CSQCFGR1);
-	writel_relaxed(csqcfgr2, nfc->io_base + FMC2_CSQCFGR2);
-	writel_relaxed(csqcfgr3, nfc->io_base + FMC2_CSQCFGR3);
-	writel_relaxed(csqar1, nfc->io_base + FMC2_CSQAR1);
-	writel_relaxed(csqar2, nfc->io_base + FMC2_CSQAR2);
+	regmap_bulk_write(nfc->regmap, FMC2_CSQCFGR1, cfg, 5);
 }
 
 static void stm32_fmc2_nfc_dma_callback(void *arg)
@@ -718,7 +692,6 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 	struct dma_chan *dma_ch = nfc->dma_rx_ch;
 	enum dma_data_direction dma_data_dir = DMA_FROM_DEVICE;
 	enum dma_transfer_direction dma_transfer_dir = DMA_DEV_TO_MEM;
-	u32 csqcr = readl_relaxed(nfc->io_base + FMC2_CSQCR);
 	int eccsteps = chip->ecc.steps;
 	int eccsize = chip->ecc.size;
 	unsigned long timeout = msecs_to_jiffies(FMC2_TIMEOUT_MS);
@@ -796,8 +769,8 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 	stm32_fmc2_nfc_enable_seq_irq(nfc);
 
 	/* Start the transfer */
-	csqcr |= FMC2_CSQCR_CSQSTART;
-	writel_relaxed(csqcr, nfc->io_base + FMC2_CSQCR);
+	regmap_update_bits(nfc->regmap, FMC2_CSQCR,
+			   FMC2_CSQCR_CSQSTART, FMC2_CSQCR_CSQSTART);
 
 	/* Wait end of sequencer transfer */
 	if (!wait_for_completion_timeout(&nfc->complete, timeout)) {
@@ -890,11 +863,13 @@ static int stm32_fmc2_nfc_seq_write_page_raw(struct nand_chip *chip,
 }
 
 /* Get a status indicating which sectors have errors */
-static inline u16 stm32_fmc2_nfc_get_mapping_status(struct stm32_fmc2_nfc *nfc)
+static u16 stm32_fmc2_nfc_get_mapping_status(struct stm32_fmc2_nfc *nfc)
 {
-	u32 csqemsr = readl_relaxed(nfc->io_base + FMC2_CSQEMSR);
+	u32 csqemsr;
+
+	regmap_read(nfc->regmap, FMC2_CSQEMSR, &csqemsr);
 
-	return csqemsr & FMC2_CSQEMSR_SEM;
+	return FIELD_GET(FMC2_CSQEMSR_SEM, csqemsr);
 }
 
 static int stm32_fmc2_nfc_seq_correct(struct nand_chip *chip, u8 *dat,
@@ -1150,9 +1125,9 @@ static int stm32_fmc2_nfc_waitrdy(struct nand_chip *chip,
 	u32 isr, sr;
 
 	/* Check if there is no pending requests to the NAND flash */
-	if (readl_relaxed_poll_timeout_atomic(nfc->io_base + FMC2_SR, sr,
-					      sr & FMC2_SR_NWRF, 1,
-					      1000 * FMC2_TIMEOUT_MS))
+	if (regmap_read_poll_timeout(nfc->regmap, FMC2_SR, sr,
+				     sr & FMC2_SR_NWRF, 1,
+				     1000 * FMC2_TIMEOUT_MS))
 		dev_warn(nfc->dev, "Waitrdy timeout\n");
 
 	/* Wait tWB before R/B# signal is low */
@@ -1160,12 +1135,12 @@ static int stm32_fmc2_nfc_waitrdy(struct nand_chip *chip,
 	ndelay(PSEC_TO_NSEC(timings->tWB_max));
 
 	/* R/B# signal is low, clear high level flag */
-	writel_relaxed(FMC2_ICR_CIHLF, nfc->io_base + FMC2_ICR);
+	regmap_write(nfc->regmap, FMC2_ICR, FMC2_ICR_CIHLF);
 
 	/* Wait R/B# signal is high */
-	return readl_relaxed_poll_timeout_atomic(nfc->io_base + FMC2_ISR,
-						 isr, isr & FMC2_ISR_IHLF,
-						 5, 1000 * timeout_ms);
+	return regmap_read_poll_timeout(nfc->regmap, FMC2_ISR, isr,
+					isr & FMC2_ISR_IHLF, 5,
+					1000 * FMC2_TIMEOUT_MS);
 }
 
 static int stm32_fmc2_nfc_exec_op(struct nand_chip *chip,
@@ -1223,8 +1198,9 @@ static int stm32_fmc2_nfc_exec_op(struct nand_chip *chip,
 
 static void stm32_fmc2_nfc_init(struct stm32_fmc2_nfc *nfc)
 {
-	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
-	u32 bcr1 = readl_relaxed(nfc->io_base + FMC2_BCR1);
+	u32 pcr;
+
+	regmap_read(nfc->regmap, FMC2_PCR, &pcr);
 
 	/* Set CS used to undefined */
 	nfc->cs_sel = -1;
@@ -1255,12 +1231,12 @@ static void stm32_fmc2_nfc_init(struct stm32_fmc2_nfc *nfc)
 	pcr |= FIELD_PREP(FMC2_PCR_TAR, FMC2_PCR_TAR_DEFAULT);
 
 	/* Enable FMC2 controller */
-	bcr1 |= FMC2_BCR1_FMC2EN;
+	regmap_update_bits(nfc->regmap, FMC2_BCR1,
+			   FMC2_BCR1_FMC2EN, FMC2_BCR1_FMC2EN);
 
-	writel_relaxed(bcr1, nfc->io_base + FMC2_BCR1);
-	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
-	writel_relaxed(FMC2_PMEM_DEFAULT, nfc->io_base + FMC2_PMEM);
-	writel_relaxed(FMC2_PATT_DEFAULT, nfc->io_base + FMC2_PATT);
+	regmap_write(nfc->regmap, FMC2_PCR, pcr);
+	regmap_write(nfc->regmap, FMC2_PMEM, FMC2_PMEM_DEFAULT);
+	regmap_write(nfc->regmap, FMC2_PATT, FMC2_PATT_DEFAULT);
 }
 
 static void stm32_fmc2_nfc_calc_timings(struct nand_chip *chip,
@@ -1695,6 +1671,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
+	void __iomem *mmio;
 	int chip_cs, mem_region, ret, irq;
 
 	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
@@ -1710,9 +1687,13 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nfc->io_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(nfc->io_base))
-		return PTR_ERR(nfc->io_base);
+	mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	nfc->regmap = devm_regmap_init_mmio(dev, mmio, &stm32_fmc2_regmap_cfg);
+	if (IS_ERR(nfc->regmap))
+		return PTR_ERR(nfc->regmap);
 
 	nfc->io_phys_addr = res->start;
 
-- 
1.9.1

