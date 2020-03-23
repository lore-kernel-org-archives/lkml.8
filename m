Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45806C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31122080C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="y9LmCjnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCWPAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22194 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727448AbgCWPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NEc2nN029540;
        Mon, 23 Mar 2020 16:00:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Pd46b+iunQLe43OXzrq/izDbyYPTPaz5DWoFXjieNJQ=;
 b=y9LmCjnbGl5XoRYY+L0UQeg5PWP14K6SpEjR1/8hOFa4DWYS1//b8z3w+YFXXAHyq37P
 QIiDJistUHjh4jJGHcCKBl/JraKp15Va4uwaQBjegCFd+XlunGODk9UVqoAL878PlraS
 YmYiPq2932I5yLG/FOzxSaHFHfTPE8iTv7heDhq4GSIIcv7kKF40/z5OMtyOL8tnFlSb
 SJsiZ8h9J/Ck3hFMoSHUJzw03hKswqAfr1VbULWYc99ImRuVjpqX/oFoAvTT4uNfgZ8l
 xt9q+rzIHtRc+JoYWggeXq6KlzXamb4uvvkDpH8EsdJM0gkQU29wXwm3kWQaFgbhEscH 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw8xdtndm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Mar 2020 16:00:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5842510003D;
        Mon, 23 Mar 2020 16:00:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 485E4220F8F;
        Mon, 23 Mar 2020 16:00:10 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 23 Mar 2020 16:00:08
 +0100
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [11/12] mtd: rawnand: stm32_fmc2: use stm32_fmc2 structure in nfc controller
Date:   Mon, 23 Mar 2020 15:58:51 +0100
Message-ID: <1584975532-8038-12-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
References: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_05:2020-03-21,2020-03-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves common used resources (registers base, clocks, ...)
in stm32_fmc2 structure.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/Kconfig           |   1 +
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 218 ++++++++++++++++++++++-----------
 2 files changed, 150 insertions(+), 69 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 12b715a..ad7d887 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -421,6 +421,7 @@ config MTD_NAND_STM32_FMC2
 	depends on MACH_STM32MP157 || COMPILE_TEST
 	select REGMAP
 	select REGMAP_MMIO
+	select MFD_STM32_FMC2
 	help
 	  Enables support for NAND Flash chips on SoCs containing the FMC2
 	  NAND controller. This controller is found on STM32MP SoCs.
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index bc16614..1dc568f 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -97,14 +97,12 @@ static inline struct stm32_fmc2_nand *to_fmc2_nand(struct nand_chip *chip)
 struct stm32_fmc2_nfc {
 	struct nand_controller base;
 	struct stm32_fmc2_nand nand;
+	struct stm32_fmc2 *fmc2;
 	struct device *dev;
-	struct regmap *regmap;
 	void __iomem *data_base[FMC2_MAX_CE];
 	void __iomem *cmd_base[FMC2_MAX_CE];
 	void __iomem *addr_base[FMC2_MAX_CE];
-	phys_addr_t io_phys_addr;
 	phys_addr_t data_phys_addr[FMC2_MAX_CE];
-	struct clk *clk;
 	u8 irq_state;
 
 	struct dma_chan *dma_tx_ch;
@@ -133,10 +131,11 @@ static void stm32_fmc2_nfc_timings_init(struct nand_chip *chip)
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct stm32_fmc2_nand *nand = to_fmc2_nand(chip);
 	struct stm32_fmc2_timings *timings = &nand->timings;
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	u32 pmem, patt;
 
 	/* Set tclr/tar timings */
-	regmap_update_bits(nfc->regmap, FMC2_PCR,
+	regmap_update_bits(fmc2->regmap, FMC2_PCR,
 			   FMC2_PCR_TCLR | FMC2_PCR_TAR,
 			   FIELD_PREP(FMC2_PCR_TCLR, timings->tclr) |
 			   FIELD_PREP(FMC2_PCR_TAR, timings->tar));
@@ -146,19 +145,20 @@ static void stm32_fmc2_nfc_timings_init(struct nand_chip *chip)
 	pmem |= FIELD_PREP(FMC2_PMEM_MEMWAIT, timings->twait);
 	pmem |= FIELD_PREP(FMC2_PMEM_MEMHOLD, timings->thold_mem);
 	pmem |= FIELD_PREP(FMC2_PMEM_MEMHIZ, timings->thiz);
-	regmap_write(nfc->regmap, FMC2_PMEM, pmem);
+	regmap_write(fmc2->regmap, FMC2_PMEM, pmem);
 
 	/* Set tset/twait/thold/thiz timings in attribut bank */
 	patt = FIELD_PREP(FMC2_PATT_ATTSET, timings->tset_att);
 	patt |= FIELD_PREP(FMC2_PATT_ATTWAIT, timings->twait);
 	patt |= FIELD_PREP(FMC2_PATT_ATTHOLD, timings->thold_att);
 	patt |= FIELD_PREP(FMC2_PATT_ATTHIZ, timings->thiz);
-	regmap_write(nfc->regmap, FMC2_PATT, patt);
+	regmap_write(fmc2->regmap, FMC2_PATT, patt);
 }
 
 static void stm32_fmc2_nfc_setup(struct nand_chip *chip)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	u32 pcr = 0, pcr_mask;
 
 	/* Configure ECC algorithm (default configuration is Hamming) */
@@ -180,13 +180,14 @@ static void stm32_fmc2_nfc_setup(struct nand_chip *chip)
 	pcr_mask |= FMC2_PCR_ECCSS;
 	pcr |= FIELD_PREP(FMC2_PCR_ECCSS, FMC2_PCR_ECCSS_512);
 
-	regmap_update_bits(nfc->regmap, FMC2_PCR, pcr_mask, pcr);
+	regmap_update_bits(fmc2->regmap, FMC2_PCR, pcr_mask, pcr);
 }
 
 static int stm32_fmc2_nfc_select_chip(struct nand_chip *chip, int chipnr)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct stm32_fmc2_nand *nand = to_fmc2_nand(chip);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	struct dma_slave_config dma_cfg;
 	int ret;
 
@@ -225,7 +226,7 @@ static int stm32_fmc2_nfc_select_chip(struct nand_chip *chip, int chipnr)
 		 * BCH4/BCH8: we read BCHDSRSx registers
 		 */
 		memset(&dma_cfg, 0, sizeof(dma_cfg));
-		dma_cfg.src_addr = nfc->io_phys_addr;
+		dma_cfg.src_addr = fmc2->reg_phys_addr;
 		dma_cfg.src_addr += chip->ecc.strength == FMC2_ECC_HAM ?
 				    FMC2_HECCR : FMC2_BCHDSR0;
 		dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -246,55 +247,68 @@ static int stm32_fmc2_nfc_select_chip(struct nand_chip *chip, int chipnr)
 
 static void stm32_fmc2_nfc_set_buswidth_16(struct stm32_fmc2_nfc *nfc, bool set)
 {
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	u32 pcr;
 
 	pcr = set ? FIELD_PREP(FMC2_PCR_PWID, FMC2_PCR_PWID_BUSWIDTH_16) :
 		    FIELD_PREP(FMC2_PCR_PWID, FMC2_PCR_PWID_BUSWIDTH_8);
 
-	regmap_update_bits(nfc->regmap, FMC2_PCR, FMC2_PCR_PWID, pcr);
+	regmap_update_bits(fmc2->regmap, FMC2_PCR, FMC2_PCR_PWID, pcr);
 }
 
 static void stm32_fmc2_nfc_set_ecc(struct stm32_fmc2_nfc *nfc, bool enable)
 {
-	regmap_update_bits(nfc->regmap, FMC2_PCR, FMC2_PCR_ECCEN,
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
+
+	regmap_update_bits(fmc2->regmap, FMC2_PCR, FMC2_PCR_ECCEN,
 			   enable ? FMC2_PCR_ECCEN : 0);
 }
 
 static void stm32_fmc2_nfc_enable_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
+
 	nfc->irq_state = FMC2_IRQ_SEQ;
 
-	regmap_update_bits(nfc->regmap, FMC2_CSQIER,
+	regmap_update_bits(fmc2->regmap, FMC2_CSQIER,
 			   FMC2_CSQIER_TCIE, FMC2_CSQIER_TCIE);
 }
 
 static void stm32_fmc2_nfc_disable_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
-	regmap_update_bits(nfc->regmap, FMC2_CSQIER, FMC2_CSQIER_TCIE, 0);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
+
+	regmap_update_bits(fmc2->regmap, FMC2_CSQIER, FMC2_CSQIER_TCIE, 0);
 
 	nfc->irq_state = FMC2_IRQ_UNKNOWN;
 }
 
 static void stm32_fmc2_nfc_clear_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
-	regmap_write(nfc->regmap, FMC2_CSQICR, FMC2_CSQICR_CLEAR_IRQ);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
+
+	regmap_write(fmc2->regmap, FMC2_CSQICR, FMC2_CSQICR_CLEAR_IRQ);
 }
 
 static void stm32_fmc2_nfc_enable_bch_irq(struct stm32_fmc2_nfc *nfc, int mode)
 {
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
+
 	nfc->irq_state = FMC2_IRQ_BCH;
 
 	if (mode == NAND_ECC_WRITE)
-		regmap_update_bits(nfc->regmap, FMC2_BCHIER,
+		regmap_update_bits(fmc2->regmap, FMC2_BCHIER,
 				   FMC2_BCHIER_EPBRIE, FMC2_BCHIER_EPBRIE);
 	else
-		regmap_update_bits(nfc->regmap, FMC2_BCHIER,
+		regmap_update_bits(fmc2->regmap, FMC2_BCHIER,
 				   FMC2_BCHIER_DERIE, FMC2_BCHIER_DERIE);
 }
 
 static void stm32_fmc2_nfc_disable_bch_irq(struct stm32_fmc2_nfc *nfc)
 {
-	regmap_update_bits(nfc->regmap, FMC2_BCHIER,
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
+
+	regmap_update_bits(fmc2->regmap, FMC2_BCHIER,
 			   FMC2_BCHIER_DERIE | FMC2_BCHIER_EPBRIE, 0);
 
 	nfc->irq_state = FMC2_IRQ_UNKNOWN;
@@ -302,7 +316,9 @@ static void stm32_fmc2_nfc_disable_bch_irq(struct stm32_fmc2_nfc *nfc)
 
 static void stm32_fmc2_nfc_clear_bch_irq(struct stm32_fmc2_nfc *nfc)
 {
-	regmap_write(nfc->regmap, FMC2_BCHICR, FMC2_BCHICR_CLEAR_IRQ);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
+
+	regmap_write(fmc2->regmap, FMC2_BCHICR, FMC2_BCHICR_CLEAR_IRQ);
 }
 
 /*
@@ -312,11 +328,12 @@ static void stm32_fmc2_nfc_clear_bch_irq(struct stm32_fmc2_nfc *nfc)
 static void stm32_fmc2_nfc_hwctl(struct nand_chip *chip, int mode)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 
 	stm32_fmc2_nfc_set_ecc(nfc, false);
 
 	if (chip->ecc.strength != FMC2_ECC_HAM) {
-		regmap_update_bits(nfc->regmap, FMC2_PCR, FMC2_PCR_WEN,
+		regmap_update_bits(fmc2->regmap, FMC2_PCR, FMC2_PCR_WEN,
 				   mode == NAND_ECC_WRITE ? FMC2_PCR_WEN : 0);
 
 		reinit_completion(&nfc->complete);
@@ -343,10 +360,11 @@ static int stm32_fmc2_nfc_ham_calculate(struct nand_chip *chip, const u8 *data,
 					u8 *ecc)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	u32 sr, heccr;
 	int ret;
 
-	ret = regmap_read_poll_timeout(nfc->regmap, FMC2_SR, sr,
+	ret = regmap_read_poll_timeout(fmc2->regmap, FMC2_SR, sr,
 				       sr & FMC2_SR_NWRF, 1,
 				       1000 * FMC2_TIMEOUT_MS);
 	if (ret) {
@@ -354,7 +372,7 @@ static int stm32_fmc2_nfc_ham_calculate(struct nand_chip *chip, const u8 *data,
 		return ret;
 	}
 
-	regmap_read(nfc->regmap, FMC2_HECCR, &heccr);
+	regmap_read(fmc2->regmap, FMC2_HECCR, &heccr);
 	stm32_fmc2_nfc_ham_set_ecc(heccr, ecc);
 	stm32_fmc2_nfc_set_ecc(nfc, false);
 
@@ -422,6 +440,7 @@ static int stm32_fmc2_nfc_bch_calculate(struct nand_chip *chip, const u8 *data,
 					u8 *ecc)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	u32 bchpbr;
 
 	/* Wait until the BCH code is ready */
@@ -433,13 +452,13 @@ static int stm32_fmc2_nfc_bch_calculate(struct nand_chip *chip, const u8 *data,
 	}
 
 	/* Read parity bits */
-	regmap_read(nfc->regmap, FMC2_BCHPBR1, &bchpbr);
+	regmap_read(fmc2->regmap, FMC2_BCHPBR1, &bchpbr);
 	ecc[0] = bchpbr;
 	ecc[1] = bchpbr >> 8;
 	ecc[2] = bchpbr >> 16;
 	ecc[3] = bchpbr >> 24;
 
-	regmap_read(nfc->regmap, FMC2_BCHPBR2, &bchpbr);
+	regmap_read(fmc2->regmap, FMC2_BCHPBR2, &bchpbr);
 	ecc[4] = bchpbr;
 	ecc[5] = bchpbr >> 8;
 	ecc[6] = bchpbr >> 16;
@@ -447,13 +466,13 @@ static int stm32_fmc2_nfc_bch_calculate(struct nand_chip *chip, const u8 *data,
 	if (chip->ecc.strength == FMC2_ECC_BCH8) {
 		ecc[7] = bchpbr >> 24;
 
-		regmap_read(nfc->regmap, FMC2_BCHPBR3, &bchpbr);
+		regmap_read(fmc2->regmap, FMC2_BCHPBR3, &bchpbr);
 		ecc[8] = bchpbr;
 		ecc[9] = bchpbr >> 8;
 		ecc[10] = bchpbr >> 16;
 		ecc[11] = bchpbr >> 24;
 
-		regmap_read(nfc->regmap, FMC2_BCHPBR4, &bchpbr);
+		regmap_read(fmc2->regmap, FMC2_BCHPBR4, &bchpbr);
 		ecc[12] = bchpbr;
 	}
 
@@ -505,6 +524,7 @@ static int stm32_fmc2_nfc_bch_correct(struct nand_chip *chip, u8 *dat,
 				      u8 *read_ecc, u8 *calc_ecc)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	u32 ecc_sta[5];
 
 	/* Wait until the decoding error is ready */
@@ -515,11 +535,11 @@ static int stm32_fmc2_nfc_bch_correct(struct nand_chip *chip, u8 *dat,
 		return -ETIMEDOUT;
 	}
 
-	regmap_read(nfc->regmap, FMC2_BCHDSR0, &ecc_sta[0]);
-	regmap_read(nfc->regmap, FMC2_BCHDSR1, &ecc_sta[1]);
-	regmap_read(nfc->regmap, FMC2_BCHDSR2, &ecc_sta[2]);
-	regmap_read(nfc->regmap, FMC2_BCHDSR3, &ecc_sta[3]);
-	regmap_read(nfc->regmap, FMC2_BCHDSR4, &ecc_sta[4]);
+	regmap_read(fmc2->regmap, FMC2_BCHDSR0, &ecc_sta[0]);
+	regmap_read(fmc2->regmap, FMC2_BCHDSR1, &ecc_sta[1]);
+	regmap_read(fmc2->regmap, FMC2_BCHDSR2, &ecc_sta[2]);
+	regmap_read(fmc2->regmap, FMC2_BCHDSR3, &ecc_sta[3]);
+	regmap_read(fmc2->regmap, FMC2_BCHDSR4, &ecc_sta[4]);
 
 	stm32_fmc2_nfc_set_ecc(nfc, false);
 
@@ -593,12 +613,13 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 					int raw, bool write_data)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	u32 csqcfgr1, csqcfgr2, csqcfgr3;
 	u32 csqar1, csqar2;
 	u32 ecc_offset = mtd->writesize + FMC2_BBM_LEN;
 
-	regmap_update_bits(nfc->regmap, FMC2_PCR, FMC2_PCR_WEN,
+	regmap_update_bits(fmc2->regmap, FMC2_PCR, FMC2_PCR_WEN,
 			   write_data ? FMC2_PCR_WEN : 0);
 
 	/*
@@ -674,11 +695,11 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_ACYNBR, 4);
 	}
 
-	regmap_write(nfc->regmap, FMC2_CSQCFGR1, csqcfgr1);
-	regmap_write(nfc->regmap, FMC2_CSQCFGR2, csqcfgr2);
-	regmap_write(nfc->regmap, FMC2_CSQCFGR3, csqcfgr3);
-	regmap_write(nfc->regmap, FMC2_CSQAR1, csqar1);
-	regmap_write(nfc->regmap, FMC2_CSQAR2, csqar2);
+	regmap_write(fmc2->regmap, FMC2_CSQCFGR1, csqcfgr1);
+	regmap_write(fmc2->regmap, FMC2_CSQCFGR2, csqcfgr2);
+	regmap_write(fmc2->regmap, FMC2_CSQCFGR3, csqcfgr3);
+	regmap_write(fmc2->regmap, FMC2_CSQAR1, csqar1);
+	regmap_write(fmc2->regmap, FMC2_CSQAR2, csqar2);
 }
 
 static void stm32_fmc2_nfc_dma_callback(void *arg)
@@ -691,6 +712,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 			       int raw, bool write_data)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	struct dma_async_tx_descriptor *desc_data, *desc_ecc;
 	struct scatterlist *sg;
 	struct dma_chan *dma_ch = nfc->dma_rx_ch;
@@ -773,7 +795,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 	stm32_fmc2_nfc_enable_seq_irq(nfc);
 
 	/* Start the transfer */
-	regmap_update_bits(nfc->regmap, FMC2_CSQCR,
+	regmap_update_bits(fmc2->regmap, FMC2_CSQCR,
 			   FMC2_CSQCR_CSQSTART, FMC2_CSQCR_CSQSTART);
 
 	/* Wait end of sequencer transfer */
@@ -869,9 +891,10 @@ static int stm32_fmc2_nfc_seq_write_page_raw(struct nand_chip *chip,
 /* Get a status indicating which sectors have errors */
 static u16 stm32_fmc2_nfc_get_mapping_status(struct stm32_fmc2_nfc *nfc)
 {
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	u32 csqemsr;
 
-	regmap_read(nfc->regmap, FMC2_CSQEMSR, &csqemsr);
+	regmap_read(fmc2->regmap, FMC2_CSQEMSR, &csqemsr);
 
 	return FIELD_GET(FMC2_CSQEMSR_SEM, csqemsr);
 }
@@ -1125,11 +1148,12 @@ static int stm32_fmc2_nfc_waitrdy(struct nand_chip *chip,
 				  unsigned long timeout_ms)
 {
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	const struct nand_sdr_timings *timings;
 	u32 isr, sr;
 
 	/* Check if there is no pending requests to the NAND flash */
-	if (regmap_read_poll_timeout(nfc->regmap, FMC2_SR, sr,
+	if (regmap_read_poll_timeout(fmc2->regmap, FMC2_SR, sr,
 				     sr & FMC2_SR_NWRF, 1,
 				     1000 * FMC2_TIMEOUT_MS))
 		dev_warn(nfc->dev, "Waitrdy timeout\n");
@@ -1139,10 +1163,10 @@ static int stm32_fmc2_nfc_waitrdy(struct nand_chip *chip,
 	ndelay(PSEC_TO_NSEC(timings->tWB_max));
 
 	/* R/B# signal is low, clear high level flag */
-	regmap_write(nfc->regmap, FMC2_ICR, FMC2_ICR_CIHLF);
+	regmap_write(fmc2->regmap, FMC2_ICR, FMC2_ICR_CIHLF);
 
 	/* Wait R/B# signal is high */
-	return regmap_read_poll_timeout(nfc->regmap, FMC2_ISR, isr,
+	return regmap_read_poll_timeout(fmc2->regmap, FMC2_ISR, isr,
 					isr & FMC2_ISR_IHLF, 5,
 					1000 * FMC2_TIMEOUT_MS);
 }
@@ -1202,9 +1226,10 @@ static int stm32_fmc2_nfc_exec_op(struct nand_chip *chip,
 
 static void stm32_fmc2_nfc_init(struct stm32_fmc2_nfc *nfc)
 {
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	u32 pcr;
 
-	regmap_read(nfc->regmap, FMC2_PCR, &pcr);
+	regmap_read(fmc2->regmap, FMC2_PCR, &pcr);
 
 	/* Set CS used to undefined */
 	nfc->cs_sel = -1;
@@ -1234,13 +1259,9 @@ static void stm32_fmc2_nfc_init(struct stm32_fmc2_nfc *nfc)
 	pcr &= ~FMC2_PCR_TAR;
 	pcr |= FIELD_PREP(FMC2_PCR_TAR, FMC2_PCR_TAR_DEFAULT);
 
-	/* Enable FMC2 controller */
-	regmap_update_bits(nfc->regmap, FMC2_BCR1,
-			   FMC2_BCR1_FMC2EN, FMC2_BCR1_FMC2EN);
-
-	regmap_write(nfc->regmap, FMC2_PCR, pcr);
-	regmap_write(nfc->regmap, FMC2_PMEM, FMC2_PMEM_DEFAULT);
-	regmap_write(nfc->regmap, FMC2_PATT, FMC2_PATT_DEFAULT);
+	regmap_write(fmc2->regmap, FMC2_PCR, pcr);
+	regmap_write(fmc2->regmap, FMC2_PMEM, FMC2_PMEM_DEFAULT);
+	regmap_write(fmc2->regmap, FMC2_PATT, FMC2_PATT_DEFAULT);
 }
 
 static void stm32_fmc2_nfc_calc_timings(struct nand_chip *chip,
@@ -1249,7 +1270,8 @@ static void stm32_fmc2_nfc_calc_timings(struct nand_chip *chip,
 	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct stm32_fmc2_nand *nand = to_fmc2_nand(chip);
 	struct stm32_fmc2_timings *tims = &nand->timings;
-	unsigned long hclk = clk_get_rate(nfc->clk);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
+	unsigned long hclk = clk_get_rate(fmc2->clk);
 	unsigned long hclkp = NSEC_PER_SEC / (hclk / 1000);
 	unsigned long timing, tar, tclr, thiz, twait;
 	unsigned long tset_mem, tset_att, thold_mem, thold_att;
@@ -1666,17 +1688,57 @@ static int stm32_fmc2_nfc_parse_dt(struct stm32_fmc2_nfc *nfc)
 	return ret;
 }
 
+static void stm32_fmc2_nfc_enable(struct stm32_fmc2 *fmc2)
+{
+	regmap_update_bits(fmc2->regmap, FMC2_BCR1,
+			   FMC2_BCR1_FMC2EN, FMC2_BCR1_FMC2EN);
+}
+
+static void stm32_fmc2_nfc_disable(struct stm32_fmc2 *fmc2)
+{
+	regmap_update_bits(fmc2->regmap, FMC2_BCR1, FMC2_BCR1_FMC2EN, 0);
+}
+
+static int stm32_fmc2_nfc_set_mmio_clk(struct platform_device *pdev,
+				       struct stm32_fmc2 *fmc2)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *mmio;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	fmc2->regmap = devm_regmap_init_mmio(dev, mmio, &stm32_fmc2_regmap_cfg);
+	if (IS_ERR(fmc2->regmap))
+		return PTR_ERR(fmc2->regmap);
+
+	fmc2->reg_phys_addr = res->start;
+
+	fmc2->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(fmc2->clk))
+		return PTR_ERR(fmc2->clk);
+
+	fmc2->enable = stm32_fmc2_nfc_enable;
+	fmc2->disable = stm32_fmc2_nfc_disable;
+
+	return 0;
+}
+
 static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct reset_control *rstc;
+	struct stm32_fmc2 *fmc2;
 	struct stm32_fmc2_nfc *nfc;
 	struct stm32_fmc2_nand *nand;
 	struct resource *res;
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
-	void __iomem *mmio;
 	int chip_cs, mem_region, ret, irq;
+	int num_region = 0;
 
 	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
 	if (!nfc)
@@ -1690,18 +1752,27 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmio = devm_ioremap_resource(dev, res);
-	if (IS_ERR(mmio))
-		return PTR_ERR(mmio);
+	fmc2 = dev_get_drvdata(dev->parent);
+	if (!fmc2) {
+		num_region = 1;
 
-	nfc->regmap = devm_regmap_init_mmio(dev, mmio, &stm32_fmc2_regmap_cfg);
-	if (IS_ERR(nfc->regmap))
-		return PTR_ERR(nfc->regmap);
+		fmc2 = devm_kzalloc(dev, sizeof(*fmc2), GFP_KERNEL);
+		if (!fmc2)
+			return -ENOMEM;
 
-	nfc->io_phys_addr = res->start;
+		ret = stm32_fmc2_nfc_set_mmio_clk(pdev, fmc2);
+		if (ret)
+			return ret;
+	}
+	nfc->fmc2 = fmc2;
 
-	for (chip_cs = 0, mem_region = 1; chip_cs < FMC2_MAX_CE;
+	if (atomic_inc_return(&fmc2->nwait_is_used) > 1) {
+		dev_err(dev, "NWAIT signal in used by a FMC controller\n");
+		atomic_dec(&fmc2->nwait_is_used);
+		return -EINVAL;
+	}
+
+	for (chip_cs = 0, mem_region = num_region; chip_cs < FMC2_MAX_CE;
 	     chip_cs++, mem_region += 3) {
 		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
@@ -1739,11 +1810,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 
 	init_completion(&nfc->complete);
 
-	nfc->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(nfc->clk))
-		return PTR_ERR(nfc->clk);
-
-	ret = clk_prepare_enable(nfc->clk);
+	ret = clk_prepare_enable(fmc2->clk);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
 		return ret;
@@ -1763,6 +1830,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dma_setup;
 
+	fmc2->enable(fmc2);
 	stm32_fmc2_nfc_init(nfc);
 
 	nand = &nfc->nand;
@@ -1782,7 +1850,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	/* Scan to find existence of the device */
 	ret = nand_scan(chip, nand->ncs);
 	if (ret)
-		goto err_dma_setup;
+		goto err_nand_scan;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
@@ -1795,6 +1863,10 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 err_device_register:
 	nand_cleanup(chip);
 
+err_nand_scan:
+	regmap_update_bits(fmc2->regmap, FMC2_PCR, FMC2_PCR_PBKEN, 0);
+	fmc2->disable(fmc2);
+
 err_dma_setup:
 	if (nfc->dma_ecc_ch)
 		dma_release_channel(nfc->dma_ecc_ch);
@@ -1807,7 +1879,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	sg_free_table(&nfc->dma_ecc_sg);
 
 err_clk_disable:
-	clk_disable_unprepare(nfc->clk);
+	clk_disable_unprepare(fmc2->clk);
 
 	return ret;
 }
@@ -1816,7 +1888,11 @@ static int stm32_fmc2_nfc_remove(struct platform_device *pdev)
 {
 	struct stm32_fmc2_nfc *nfc = platform_get_drvdata(pdev);
 	struct stm32_fmc2_nand *nand = &nfc->nand;
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 
+	regmap_update_bits(fmc2->regmap, FMC2_PCR, FMC2_PCR_PBKEN, 0);
+	atomic_dec(&fmc2->nwait_is_used);
+	fmc2->disable(fmc2);
 	nand_release(&nand->chip);
 
 	if (nfc->dma_ecc_ch)
@@ -1829,7 +1905,7 @@ static int stm32_fmc2_nfc_remove(struct platform_device *pdev)
 	sg_free_table(&nfc->dma_data_sg);
 	sg_free_table(&nfc->dma_ecc_sg);
 
-	clk_disable_unprepare(nfc->clk);
+	clk_disable_unprepare(fmc2->clk);
 
 	return 0;
 }
@@ -1837,8 +1913,10 @@ static int stm32_fmc2_nfc_remove(struct platform_device *pdev)
 static int __maybe_unused stm32_fmc2_nfc_suspend(struct device *dev)
 {
 	struct stm32_fmc2_nfc *nfc = dev_get_drvdata(dev);
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 
-	clk_disable_unprepare(nfc->clk);
+	fmc2->disable(fmc2);
+	clk_disable_unprepare(fmc2->clk);
 
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -1849,16 +1927,18 @@ static int __maybe_unused stm32_fmc2_nfc_resume(struct device *dev)
 {
 	struct stm32_fmc2_nfc *nfc = dev_get_drvdata(dev);
 	struct stm32_fmc2_nand *nand = &nfc->nand;
+	struct stm32_fmc2 *fmc2 = nfc->fmc2;
 	int chip_cs, ret;
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = clk_prepare_enable(nfc->clk);
+	ret = clk_prepare_enable(fmc2->clk);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
 		return ret;
 	}
 
+	fmc2->enable(fmc2);
 	stm32_fmc2_nfc_init(nfc);
 
 	for (chip_cs = 0; chip_cs < FMC2_MAX_CE; chip_cs++) {
-- 
1.9.1

