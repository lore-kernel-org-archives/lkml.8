Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05320C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A047420753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="F2JmgXAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgCWPAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727314AbgCWPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:35 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NEbTUU023758;
        Mon, 23 Mar 2020 15:59:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=m21xKrJLs/OSGHibHlcNLM0+73h19wveY71mhiLNwAs=;
 b=F2JmgXAA45ygKjjyssrs3g7V2CwL+07oyQ/02M3zxRPntrGB936gQHmIaI1sEkf4T/bE
 ziXmVCJIA4yAHX2GHh/6yUidBfiR8oTfxl43ZM4cp5oXR7DlGhL7HcBfweCOZ/1YMQLv
 1RPH75G8ZfU0KXyNLy9msRs596nYxoXOOX7WwWlhiRL00jea/+8ORZFsPq+5AOgwZnbj
 tfD4Z+b5rQ29JV5w2/FFhwqSZMd6c1s9L587LfVvZKt/AuC/NU9Or3k3NUtvx6QxbbdK
 B+SnChDim2svA2A/kC6zUHjG07iacoLXiIJMixq4FOwnVCq4Wje2pdHe9BomltjX/bSV /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw995ajdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Mar 2020 15:59:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 92049100034;
        Mon, 23 Mar 2020 15:59:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8210A22193C;
        Mon, 23 Mar 2020 15:59:57 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 23 Mar 2020 15:59:52
 +0100
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [07/12] mtd: rawnand: stm32_fmc2: cleanup
Date:   Mon, 23 Mar 2020 15:58:47 +0100
Message-ID: <1584975532-8038-8-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
References: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_05:2020-03-21,2020-03-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames functions and local variables to be ready to use
stm32_fmc2 structure.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 812 ++++++++++++++++-----------------
 1 file changed, 404 insertions(+), 408 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index f159c39..9ce405d 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -280,12 +280,12 @@ static inline struct stm32_fmc2_nfc *to_stm32_nfc(struct nand_controller *base)
 	return container_of(base, struct stm32_fmc2_nfc, base);
 }
 
-static void stm32_fmc2_timings_init(struct nand_chip *chip)
+static void stm32_fmc2_nfc_timings_init(struct nand_chip *chip)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct stm32_fmc2_nand *nand = to_fmc2_nand(chip);
 	struct stm32_fmc2_timings *timings = &nand->timings;
-	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
 	u32 pmem, patt;
 
 	/* Set tclr/tar timings */
@@ -306,15 +306,15 @@ static void stm32_fmc2_timings_init(struct nand_chip *chip)
 	patt |= FMC2_PATT_ATTHOLD(timings->thold_att);
 	patt |= FMC2_PATT_ATTHIZ(timings->thiz);
 
-	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
-	writel_relaxed(pmem, fmc2->io_base + FMC2_PMEM);
-	writel_relaxed(patt, fmc2->io_base + FMC2_PATT);
+	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
+	writel_relaxed(pmem, nfc->io_base + FMC2_PMEM);
+	writel_relaxed(patt, nfc->io_base + FMC2_PATT);
 }
 
-static void stm32_fmc2_setup(struct nand_chip *chip)
+static void stm32_fmc2_nfc_setup(struct nand_chip *chip)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
-	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
 
 	/* Configure ECC algorithm (default configuration is Hamming) */
 	pcr &= ~FMC2_PCR_ECCALG;
@@ -335,174 +335,174 @@ static void stm32_fmc2_setup(struct nand_chip *chip)
 	pcr &= ~FMC2_PCR_ECCSS_MASK;
 	pcr |= FMC2_PCR_ECCSS(FMC2_PCR_ECCSS_512);
 
-	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
 }
 
-static int stm32_fmc2_select_chip(struct nand_chip *chip, int chipnr)
+static int stm32_fmc2_nfc_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct stm32_fmc2_nand *nand = to_fmc2_nand(chip);
 	struct dma_slave_config dma_cfg;
 	int ret;
 
-	if (nand->cs_used[chipnr] == fmc2->cs_sel)
+	if (nand->cs_used[chipnr] == nfc->cs_sel)
 		return 0;
 
-	fmc2->cs_sel = nand->cs_used[chipnr];
-	stm32_fmc2_setup(chip);
-	stm32_fmc2_timings_init(chip);
+	nfc->cs_sel = nand->cs_used[chipnr];
+	stm32_fmc2_nfc_setup(chip);
+	stm32_fmc2_nfc_timings_init(chip);
 
-	if (fmc2->dma_tx_ch && fmc2->dma_rx_ch) {
+	if (nfc->dma_tx_ch && nfc->dma_rx_ch) {
 		memset(&dma_cfg, 0, sizeof(dma_cfg));
-		dma_cfg.src_addr = fmc2->data_phys_addr[fmc2->cs_sel];
-		dma_cfg.dst_addr = fmc2->data_phys_addr[fmc2->cs_sel];
+		dma_cfg.src_addr = nfc->data_phys_addr[nfc->cs_sel];
+		dma_cfg.dst_addr = nfc->data_phys_addr[nfc->cs_sel];
 		dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		dma_cfg.src_maxburst = 32;
 		dma_cfg.dst_maxburst = 32;
 
-		ret = dmaengine_slave_config(fmc2->dma_tx_ch, &dma_cfg);
+		ret = dmaengine_slave_config(nfc->dma_tx_ch, &dma_cfg);
 		if (ret) {
-			dev_err(fmc2->dev, "tx DMA engine slave config failed\n");
+			dev_err(nfc->dev, "tx DMA engine slave config failed\n");
 			return ret;
 		}
 
-		ret = dmaengine_slave_config(fmc2->dma_rx_ch, &dma_cfg);
+		ret = dmaengine_slave_config(nfc->dma_rx_ch, &dma_cfg);
 		if (ret) {
-			dev_err(fmc2->dev, "rx DMA engine slave config failed\n");
+			dev_err(nfc->dev, "rx DMA engine slave config failed\n");
 			return ret;
 		}
 	}
 
-	if (fmc2->dma_ecc_ch) {
+	if (nfc->dma_ecc_ch) {
 		/*
 		 * Hamming: we read HECCR register
 		 * BCH4/BCH8: we read BCHDSRSx registers
 		 */
 		memset(&dma_cfg, 0, sizeof(dma_cfg));
-		dma_cfg.src_addr = fmc2->io_phys_addr;
+		dma_cfg.src_addr = nfc->io_phys_addr;
 		dma_cfg.src_addr += chip->ecc.strength == FMC2_ECC_HAM ?
 				    FMC2_HECCR : FMC2_BCHDSR0;
 		dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-		ret = dmaengine_slave_config(fmc2->dma_ecc_ch, &dma_cfg);
+		ret = dmaengine_slave_config(nfc->dma_ecc_ch, &dma_cfg);
 		if (ret) {
-			dev_err(fmc2->dev, "ECC DMA engine slave config failed\n");
+			dev_err(nfc->dev, "ECC DMA engine slave config failed\n");
 			return ret;
 		}
 
 		/* Calculate ECC length needed for one sector */
-		fmc2->dma_ecc_len = chip->ecc.strength == FMC2_ECC_HAM ?
-				    FMC2_HECCR_LEN : FMC2_BCHDSRS_LEN;
+		nfc->dma_ecc_len = chip->ecc.strength == FMC2_ECC_HAM ?
+				   FMC2_HECCR_LEN : FMC2_BCHDSRS_LEN;
 	}
 
 	return 0;
 }
 
-static void stm32_fmc2_set_buswidth_16(struct stm32_fmc2_nfc *fmc2, bool set)
+static void stm32_fmc2_nfc_set_buswidth_16(struct stm32_fmc2_nfc *nfc, bool set)
 {
-	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
 
 	pcr &= ~FMC2_PCR_PWID_MASK;
 	if (set)
 		pcr |= FMC2_PCR_PWID(FMC2_PCR_PWID_BUSWIDTH_16);
-	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
 }
 
-static void stm32_fmc2_set_ecc(struct stm32_fmc2_nfc *fmc2, bool enable)
+static void stm32_fmc2_nfc_set_ecc(struct stm32_fmc2_nfc *nfc, bool enable)
 {
-	u32 pcr = readl(fmc2->io_base + FMC2_PCR);
+	u32 pcr = readl(nfc->io_base + FMC2_PCR);
 
 	pcr &= ~FMC2_PCR_ECCEN;
 	if (enable)
 		pcr |= FMC2_PCR_ECCEN;
-	writel(pcr, fmc2->io_base + FMC2_PCR);
+	writel(pcr, nfc->io_base + FMC2_PCR);
 }
 
-static inline void stm32_fmc2_enable_seq_irq(struct stm32_fmc2_nfc *fmc2)
+static inline void stm32_fmc2_nfc_enable_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
-	u32 csqier = readl_relaxed(fmc2->io_base + FMC2_CSQIER);
+	u32 csqier = readl_relaxed(nfc->io_base + FMC2_CSQIER);
 
 	csqier |= FMC2_CSQIER_TCIE;
 
-	fmc2->irq_state = FMC2_IRQ_SEQ;
+	nfc->irq_state = FMC2_IRQ_SEQ;
 
-	writel_relaxed(csqier, fmc2->io_base + FMC2_CSQIER);
+	writel_relaxed(csqier, nfc->io_base + FMC2_CSQIER);
 }
 
-static inline void stm32_fmc2_disable_seq_irq(struct stm32_fmc2_nfc *fmc2)
+static inline void stm32_fmc2_nfc_disable_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
-	u32 csqier = readl_relaxed(fmc2->io_base + FMC2_CSQIER);
+	u32 csqier = readl_relaxed(nfc->io_base + FMC2_CSQIER);
 
 	csqier &= ~FMC2_CSQIER_TCIE;
 
-	writel_relaxed(csqier, fmc2->io_base + FMC2_CSQIER);
+	writel_relaxed(csqier, nfc->io_base + FMC2_CSQIER);
 
-	fmc2->irq_state = FMC2_IRQ_UNKNOWN;
+	nfc->irq_state = FMC2_IRQ_UNKNOWN;
 }
 
-static inline void stm32_fmc2_clear_seq_irq(struct stm32_fmc2_nfc *fmc2)
+static inline void stm32_fmc2_nfc_clear_seq_irq(struct stm32_fmc2_nfc *nfc)
 {
-	writel_relaxed(FMC2_CSQICR_CLEAR_IRQ, fmc2->io_base + FMC2_CSQICR);
+	writel_relaxed(FMC2_CSQICR_CLEAR_IRQ, nfc->io_base + FMC2_CSQICR);
 }
 
-static inline void stm32_fmc2_enable_bch_irq(struct stm32_fmc2_nfc *fmc2,
-					     int mode)
+static inline void stm32_fmc2_nfc_enable_bch_irq(struct stm32_fmc2_nfc *nfc,
+						 int mode)
 {
-	u32 bchier = readl_relaxed(fmc2->io_base + FMC2_BCHIER);
+	u32 bchier = readl_relaxed(nfc->io_base + FMC2_BCHIER);
 
 	if (mode == NAND_ECC_WRITE)
 		bchier |= FMC2_BCHIER_EPBRIE;
 	else
 		bchier |= FMC2_BCHIER_DERIE;
 
-	fmc2->irq_state = FMC2_IRQ_BCH;
+	nfc->irq_state = FMC2_IRQ_BCH;
 
-	writel_relaxed(bchier, fmc2->io_base + FMC2_BCHIER);
+	writel_relaxed(bchier, nfc->io_base + FMC2_BCHIER);
 }
 
-static inline void stm32_fmc2_disable_bch_irq(struct stm32_fmc2_nfc *fmc2)
+static inline void stm32_fmc2_nfc_disable_bch_irq(struct stm32_fmc2_nfc *nfc)
 {
-	u32 bchier = readl_relaxed(fmc2->io_base + FMC2_BCHIER);
+	u32 bchier = readl_relaxed(nfc->io_base + FMC2_BCHIER);
 
 	bchier &= ~FMC2_BCHIER_DERIE;
 	bchier &= ~FMC2_BCHIER_EPBRIE;
 
-	writel_relaxed(bchier, fmc2->io_base + FMC2_BCHIER);
+	writel_relaxed(bchier, nfc->io_base + FMC2_BCHIER);
 
-	fmc2->irq_state = FMC2_IRQ_UNKNOWN;
+	nfc->irq_state = FMC2_IRQ_UNKNOWN;
 }
 
-static inline void stm32_fmc2_clear_bch_irq(struct stm32_fmc2_nfc *fmc2)
+static inline void stm32_fmc2_nfc_clear_bch_irq(struct stm32_fmc2_nfc *nfc)
 {
-	writel_relaxed(FMC2_BCHICR_CLEAR_IRQ, fmc2->io_base + FMC2_BCHICR);
+	writel_relaxed(FMC2_BCHICR_CLEAR_IRQ, nfc->io_base + FMC2_BCHICR);
 }
 
 /*
  * Enable ECC logic and reset syndrome/parity bits previously calculated
  * Syndrome/parity bits is cleared by setting the ECCEN bit to 0
  */
-static void stm32_fmc2_hwctl(struct nand_chip *chip, int mode)
+static void stm32_fmc2_nfc_hwctl(struct nand_chip *chip, int mode)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 
-	stm32_fmc2_set_ecc(fmc2, false);
+	stm32_fmc2_nfc_set_ecc(nfc, false);
 
 	if (chip->ecc.strength != FMC2_ECC_HAM) {
-		u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+		u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
 
 		if (mode == NAND_ECC_WRITE)
 			pcr |= FMC2_PCR_WEN;
 		else
 			pcr &= ~FMC2_PCR_WEN;
-		writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+		writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
 
-		reinit_completion(&fmc2->complete);
-		stm32_fmc2_clear_bch_irq(fmc2);
-		stm32_fmc2_enable_bch_irq(fmc2, mode);
+		reinit_completion(&nfc->complete);
+		stm32_fmc2_nfc_clear_bch_irq(nfc);
+		stm32_fmc2_nfc_enable_bch_irq(nfc, mode);
 	}
 
-	stm32_fmc2_set_ecc(fmc2, true);
+	stm32_fmc2_nfc_set_ecc(nfc, true);
 }
 
 /*
@@ -510,37 +510,37 @@ static void stm32_fmc2_hwctl(struct nand_chip *chip, int mode)
  * ECC is 3 bytes for 512 bytes of data (supports error correction up to
  * max of 1-bit)
  */
-static inline void stm32_fmc2_ham_set_ecc(const u32 ecc_sta, u8 *ecc)
+static inline void stm32_fmc2_nfc_ham_set_ecc(const u32 ecc_sta, u8 *ecc)
 {
 	ecc[0] = ecc_sta;
 	ecc[1] = ecc_sta >> 8;
 	ecc[2] = ecc_sta >> 16;
 }
 
-static int stm32_fmc2_ham_calculate(struct nand_chip *chip, const u8 *data,
-				    u8 *ecc)
+static int stm32_fmc2_nfc_ham_calculate(struct nand_chip *chip, const u8 *data,
+					u8 *ecc)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	u32 sr, heccr;
 	int ret;
 
-	ret = readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR,
+	ret = readl_relaxed_poll_timeout_atomic(nfc->io_base + FMC2_SR,
 						sr, sr & FMC2_SR_NWRF, 1,
 						1000 * FMC2_TIMEOUT_MS);
 	if (ret) {
-		dev_err(fmc2->dev, "ham timeout\n");
+		dev_err(nfc->dev, "ham timeout\n");
 		return ret;
 	}
 
-	heccr = readl_relaxed(fmc2->io_base + FMC2_HECCR);
-	stm32_fmc2_ham_set_ecc(heccr, ecc);
-	stm32_fmc2_set_ecc(fmc2, false);
+	heccr = readl_relaxed(nfc->io_base + FMC2_HECCR);
+	stm32_fmc2_nfc_ham_set_ecc(heccr, ecc);
+	stm32_fmc2_nfc_set_ecc(nfc, false);
 
 	return 0;
 }
 
-static int stm32_fmc2_ham_correct(struct nand_chip *chip, u8 *dat,
-				  u8 *read_ecc, u8 *calc_ecc)
+static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
+				      u8 *read_ecc, u8 *calc_ecc)
 {
 	u8 bit_position = 0, b0, b1, b2;
 	u32 byte_addr = 0, b;
@@ -596,28 +596,28 @@ static int stm32_fmc2_ham_correct(struct nand_chip *chip, u8 *dat,
  * ECC is 7/13 bytes for 512 bytes of data (supports error correction up to
  * max of 4-bit/8-bit)
  */
-static int stm32_fmc2_bch_calculate(struct nand_chip *chip, const u8 *data,
-				    u8 *ecc)
+static int stm32_fmc2_nfc_bch_calculate(struct nand_chip *chip, const u8 *data,
+					u8 *ecc)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	u32 bchpbr;
 
 	/* Wait until the BCH code is ready */
-	if (!wait_for_completion_timeout(&fmc2->complete,
+	if (!wait_for_completion_timeout(&nfc->complete,
 					 msecs_to_jiffies(FMC2_TIMEOUT_MS))) {
-		dev_err(fmc2->dev, "bch timeout\n");
-		stm32_fmc2_disable_bch_irq(fmc2);
+		dev_err(nfc->dev, "bch timeout\n");
+		stm32_fmc2_nfc_disable_bch_irq(nfc);
 		return -ETIMEDOUT;
 	}
 
 	/* Read parity bits */
-	bchpbr = readl_relaxed(fmc2->io_base + FMC2_BCHPBR1);
+	bchpbr = readl_relaxed(nfc->io_base + FMC2_BCHPBR1);
 	ecc[0] = bchpbr;
 	ecc[1] = bchpbr >> 8;
 	ecc[2] = bchpbr >> 16;
 	ecc[3] = bchpbr >> 24;
 
-	bchpbr = readl_relaxed(fmc2->io_base + FMC2_BCHPBR2);
+	bchpbr = readl_relaxed(nfc->io_base + FMC2_BCHPBR2);
 	ecc[4] = bchpbr;
 	ecc[5] = bchpbr >> 8;
 	ecc[6] = bchpbr >> 16;
@@ -625,22 +625,22 @@ static int stm32_fmc2_bch_calculate(struct nand_chip *chip, const u8 *data,
 	if (chip->ecc.strength == FMC2_ECC_BCH8) {
 		ecc[7] = bchpbr >> 24;
 
-		bchpbr = readl_relaxed(fmc2->io_base + FMC2_BCHPBR3);
+		bchpbr = readl_relaxed(nfc->io_base + FMC2_BCHPBR3);
 		ecc[8] = bchpbr;
 		ecc[9] = bchpbr >> 8;
 		ecc[10] = bchpbr >> 16;
 		ecc[11] = bchpbr >> 24;
 
-		bchpbr = readl_relaxed(fmc2->io_base + FMC2_BCHPBR4);
+		bchpbr = readl_relaxed(nfc->io_base + FMC2_BCHPBR4);
 		ecc[12] = bchpbr;
 	}
 
-	stm32_fmc2_set_ecc(fmc2, false);
+	stm32_fmc2_nfc_set_ecc(nfc, false);
 
 	return 0;
 }
 
-static int stm32_fmc2_bch_decode(int eccsize, u8 *dat, u32 *ecc_sta)
+static int stm32_fmc2_nfc_bch_decode(int eccsize, u8 *dat, u32 *ecc_sta)
 {
 	u32 bchdsr0 = ecc_sta[0];
 	u32 bchdsr1 = ecc_sta[1];
@@ -679,33 +679,33 @@ static int stm32_fmc2_bch_decode(int eccsize, u8 *dat, u32 *ecc_sta)
 	return nb_errs;
 }
 
-static int stm32_fmc2_bch_correct(struct nand_chip *chip, u8 *dat,
-				  u8 *read_ecc, u8 *calc_ecc)
+static int stm32_fmc2_nfc_bch_correct(struct nand_chip *chip, u8 *dat,
+				      u8 *read_ecc, u8 *calc_ecc)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	u32 ecc_sta[5];
 
 	/* Wait until the decoding error is ready */
-	if (!wait_for_completion_timeout(&fmc2->complete,
+	if (!wait_for_completion_timeout(&nfc->complete,
 					 msecs_to_jiffies(FMC2_TIMEOUT_MS))) {
-		dev_err(fmc2->dev, "bch timeout\n");
-		stm32_fmc2_disable_bch_irq(fmc2);
+		dev_err(nfc->dev, "bch timeout\n");
+		stm32_fmc2_nfc_disable_bch_irq(nfc);
 		return -ETIMEDOUT;
 	}
 
-	ecc_sta[0] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR0);
-	ecc_sta[1] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR1);
-	ecc_sta[2] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR2);
-	ecc_sta[3] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR3);
-	ecc_sta[4] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR4);
+	ecc_sta[0] = readl_relaxed(nfc->io_base + FMC2_BCHDSR0);
+	ecc_sta[1] = readl_relaxed(nfc->io_base + FMC2_BCHDSR1);
+	ecc_sta[2] = readl_relaxed(nfc->io_base + FMC2_BCHDSR2);
+	ecc_sta[3] = readl_relaxed(nfc->io_base + FMC2_BCHDSR3);
+	ecc_sta[4] = readl_relaxed(nfc->io_base + FMC2_BCHDSR4);
 
-	stm32_fmc2_set_ecc(fmc2, false);
+	stm32_fmc2_nfc_set_ecc(nfc, false);
 
-	return stm32_fmc2_bch_decode(chip->ecc.size, dat, ecc_sta);
+	return stm32_fmc2_nfc_bch_decode(chip->ecc.size, dat, ecc_sta);
 }
 
-static int stm32_fmc2_read_page(struct nand_chip *chip, u8 *buf,
-				int oob_required, int page)
+static int stm32_fmc2_nfc_read_page(struct nand_chip *chip, u8 *buf,
+				    int oob_required, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret, i, s, stat, eccsize = chip->ecc.size;
@@ -767,21 +767,21 @@ static int stm32_fmc2_read_page(struct nand_chip *chip, u8 *buf,
 }
 
 /* Sequencer read/write configuration */
-static void stm32_fmc2_rw_page_init(struct nand_chip *chip, int page,
-				    int raw, bool write_data)
+static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
+					int raw, bool write_data)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	u32 csqcfgr1, csqcfgr2, csqcfgr3;
 	u32 csqar1, csqar2;
 	u32 ecc_offset = mtd->writesize + FMC2_BBM_LEN;
-	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
 
 	if (write_data)
 		pcr |= FMC2_PCR_WEN;
 	else
 		pcr &= ~FMC2_PCR_WEN;
-	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
 
 	/*
 	 * - Set Program Page/Page Read command
@@ -843,7 +843,7 @@ static void stm32_fmc2_rw_page_init(struct nand_chip *chip, int page,
 	 * - Calculate the number of address cycles to be issued
 	 * - Set byte 5 of address cycle if needed
 	 */
-	csqar2 = FMC2_CSQCAR2_NANDCEN(fmc2->cs_sel);
+	csqar2 = FMC2_CSQCAR2_NANDCEN(nfc->cs_sel);
 	if (chip->options & NAND_BUSWIDTH_16)
 		csqar2 |= FMC2_CSQCAR2_SAO(ecc_offset >> 1);
 	else
@@ -855,31 +855,32 @@ static void stm32_fmc2_rw_page_init(struct nand_chip *chip, int page,
 		csqcfgr1 |= FMC2_CSQCFGR1_ACYNBR(4);
 	}
 
-	writel_relaxed(csqcfgr1, fmc2->io_base + FMC2_CSQCFGR1);
-	writel_relaxed(csqcfgr2, fmc2->io_base + FMC2_CSQCFGR2);
-	writel_relaxed(csqcfgr3, fmc2->io_base + FMC2_CSQCFGR3);
-	writel_relaxed(csqar1, fmc2->io_base + FMC2_CSQAR1);
-	writel_relaxed(csqar2, fmc2->io_base + FMC2_CSQAR2);
+	writel_relaxed(csqcfgr1, nfc->io_base + FMC2_CSQCFGR1);
+	writel_relaxed(csqcfgr2, nfc->io_base + FMC2_CSQCFGR2);
+	writel_relaxed(csqcfgr3, nfc->io_base + FMC2_CSQCFGR3);
+	writel_relaxed(csqar1, nfc->io_base + FMC2_CSQAR1);
+	writel_relaxed(csqar2, nfc->io_base + FMC2_CSQAR2);
 }
 
-static void stm32_fmc2_dma_callback(void *arg)
+static void stm32_fmc2_nfc_dma_callback(void *arg)
 {
 	complete((struct completion *)arg);
 }
 
 /* Read/write data from/to a page */
-static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
-			   int raw, bool write_data)
+static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
+			       int raw, bool write_data)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct dma_async_tx_descriptor *desc_data, *desc_ecc;
 	struct scatterlist *sg;
-	struct dma_chan *dma_ch = fmc2->dma_rx_ch;
+	struct dma_chan *dma_ch = nfc->dma_rx_ch;
 	enum dma_data_direction dma_data_dir = DMA_FROM_DEVICE;
 	enum dma_transfer_direction dma_transfer_dir = DMA_DEV_TO_MEM;
-	u32 csqcr = readl_relaxed(fmc2->io_base + FMC2_CSQCR);
+	u32 csqcr = readl_relaxed(nfc->io_base + FMC2_CSQCR);
 	int eccsteps = chip->ecc.steps;
 	int eccsize = chip->ecc.size;
+	unsigned long timeout = msecs_to_jiffies(FMC2_TIMEOUT_MS);
 	const u8 *p = buf;
 	int s, ret;
 
@@ -887,20 +888,20 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 	if (write_data) {
 		dma_data_dir = DMA_TO_DEVICE;
 		dma_transfer_dir = DMA_MEM_TO_DEV;
-		dma_ch = fmc2->dma_tx_ch;
+		dma_ch = nfc->dma_tx_ch;
 	}
 
-	for_each_sg(fmc2->dma_data_sg.sgl, sg, eccsteps, s) {
+	for_each_sg(nfc->dma_data_sg.sgl, sg, eccsteps, s) {
 		sg_set_buf(sg, p, eccsize);
 		p += eccsize;
 	}
 
-	ret = dma_map_sg(fmc2->dev, fmc2->dma_data_sg.sgl,
+	ret = dma_map_sg(nfc->dev, nfc->dma_data_sg.sgl,
 			 eccsteps, dma_data_dir);
 	if (ret < 0)
 		return ret;
 
-	desc_data = dmaengine_prep_slave_sg(dma_ch, fmc2->dma_data_sg.sgl,
+	desc_data = dmaengine_prep_slave_sg(dma_ch, nfc->dma_data_sg.sgl,
 					    eccsteps, dma_transfer_dir,
 					    DMA_PREP_INTERRUPT);
 	if (!desc_data) {
@@ -908,10 +909,10 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 		goto err_unmap_data;
 	}
 
-	reinit_completion(&fmc2->dma_data_complete);
-	reinit_completion(&fmc2->complete);
-	desc_data->callback = stm32_fmc2_dma_callback;
-	desc_data->callback_param = &fmc2->dma_data_complete;
+	reinit_completion(&nfc->dma_data_complete);
+	reinit_completion(&nfc->complete);
+	desc_data->callback = stm32_fmc2_nfc_dma_callback;
+	desc_data->callback_param = &nfc->dma_data_complete;
 	ret = dma_submit_error(dmaengine_submit(desc_data));
 	if (ret)
 		goto err_unmap_data;
@@ -920,19 +921,19 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 
 	if (!write_data && !raw) {
 		/* Configure DMA ECC status */
-		p = fmc2->ecc_buf;
-		for_each_sg(fmc2->dma_ecc_sg.sgl, sg, eccsteps, s) {
-			sg_set_buf(sg, p, fmc2->dma_ecc_len);
-			p += fmc2->dma_ecc_len;
+		p = nfc->ecc_buf;
+		for_each_sg(nfc->dma_ecc_sg.sgl, sg, eccsteps, s) {
+			sg_set_buf(sg, p, nfc->dma_ecc_len);
+			p += nfc->dma_ecc_len;
 		}
 
-		ret = dma_map_sg(fmc2->dev, fmc2->dma_ecc_sg.sgl,
+		ret = dma_map_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
 				 eccsteps, dma_data_dir);
 		if (ret < 0)
 			goto err_unmap_data;
 
-		desc_ecc = dmaengine_prep_slave_sg(fmc2->dma_ecc_ch,
-						   fmc2->dma_ecc_sg.sgl,
+		desc_ecc = dmaengine_prep_slave_sg(nfc->dma_ecc_ch,
+						   nfc->dma_ecc_sg.sgl,
 						   eccsteps, dma_transfer_dir,
 						   DMA_PREP_INTERRUPT);
 		if (!desc_ecc) {
@@ -940,76 +941,73 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 			goto err_unmap_ecc;
 		}
 
-		reinit_completion(&fmc2->dma_ecc_complete);
-		desc_ecc->callback = stm32_fmc2_dma_callback;
-		desc_ecc->callback_param = &fmc2->dma_ecc_complete;
+		reinit_completion(&nfc->dma_ecc_complete);
+		desc_ecc->callback = stm32_fmc2_nfc_dma_callback;
+		desc_ecc->callback_param = &nfc->dma_ecc_complete;
 		ret = dma_submit_error(dmaengine_submit(desc_ecc));
 		if (ret)
 			goto err_unmap_ecc;
 
-		dma_async_issue_pending(fmc2->dma_ecc_ch);
+		dma_async_issue_pending(nfc->dma_ecc_ch);
 	}
 
-	stm32_fmc2_clear_seq_irq(fmc2);
-	stm32_fmc2_enable_seq_irq(fmc2);
+	stm32_fmc2_nfc_clear_seq_irq(nfc);
+	stm32_fmc2_nfc_enable_seq_irq(nfc);
 
 	/* Start the transfer */
 	csqcr |= FMC2_CSQCR_CSQSTART;
-	writel_relaxed(csqcr, fmc2->io_base + FMC2_CSQCR);
+	writel_relaxed(csqcr, nfc->io_base + FMC2_CSQCR);
 
 	/* Wait end of sequencer transfer */
-	if (!wait_for_completion_timeout(&fmc2->complete,
-					 msecs_to_jiffies(FMC2_TIMEOUT_MS))) {
-		dev_err(fmc2->dev, "seq timeout\n");
-		stm32_fmc2_disable_seq_irq(fmc2);
+	if (!wait_for_completion_timeout(&nfc->complete, timeout)) {
+		dev_err(nfc->dev, "seq timeout\n");
+		stm32_fmc2_nfc_disable_seq_irq(nfc);
 		dmaengine_terminate_all(dma_ch);
 		if (!write_data && !raw)
-			dmaengine_terminate_all(fmc2->dma_ecc_ch);
+			dmaengine_terminate_all(nfc->dma_ecc_ch);
 		ret = -ETIMEDOUT;
 		goto err_unmap_ecc;
 	}
 
 	/* Wait DMA data transfer completion */
-	if (!wait_for_completion_timeout(&fmc2->dma_data_complete,
-					 msecs_to_jiffies(FMC2_TIMEOUT_MS))) {
-		dev_err(fmc2->dev, "data DMA timeout\n");
+	if (!wait_for_completion_timeout(&nfc->dma_data_complete, timeout)) {
+		dev_err(nfc->dev, "data DMA timeout\n");
 		dmaengine_terminate_all(dma_ch);
 		ret = -ETIMEDOUT;
 	}
 
 	/* Wait DMA ECC transfer completion */
 	if (!write_data && !raw) {
-		if (!wait_for_completion_timeout(&fmc2->dma_ecc_complete,
-					msecs_to_jiffies(FMC2_TIMEOUT_MS))) {
-			dev_err(fmc2->dev, "ECC DMA timeout\n");
-			dmaengine_terminate_all(fmc2->dma_ecc_ch);
+		if (!wait_for_completion_timeout(&nfc->dma_ecc_complete,
+						 timeout)) {
+			dev_err(nfc->dev, "ECC DMA timeout\n");
+			dmaengine_terminate_all(nfc->dma_ecc_ch);
 			ret = -ETIMEDOUT;
 		}
 	}
 
 err_unmap_ecc:
 	if (!write_data && !raw)
-		dma_unmap_sg(fmc2->dev, fmc2->dma_ecc_sg.sgl,
+		dma_unmap_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
 			     eccsteps, dma_data_dir);
 
 err_unmap_data:
-	dma_unmap_sg(fmc2->dev, fmc2->dma_data_sg.sgl, eccsteps, dma_data_dir);
+	dma_unmap_sg(nfc->dev, nfc->dma_data_sg.sgl, eccsteps, dma_data_dir);
 
 	return ret;
 }
 
-static int stm32_fmc2_sequencer_write(struct nand_chip *chip,
-				      const u8 *buf, int oob_required,
-				      int page, int raw)
+static int stm32_fmc2_nfc_seq_write(struct nand_chip *chip, const u8 *buf,
+				    int oob_required, int page, int raw)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	/* Configure the sequencer */
-	stm32_fmc2_rw_page_init(chip, page, raw, true);
+	stm32_fmc2_nfc_rw_page_init(chip, page, raw, true);
 
 	/* Write the page */
-	ret = stm32_fmc2_xfer(chip, buf, raw, true);
+	ret = stm32_fmc2_nfc_xfer(chip, buf, raw, true);
 	if (ret)
 		return ret;
 
@@ -1025,53 +1023,50 @@ static int stm32_fmc2_sequencer_write(struct nand_chip *chip,
 	return nand_prog_page_end_op(chip);
 }
 
-static int stm32_fmc2_sequencer_write_page(struct nand_chip *chip,
-					   const u8 *buf,
-					   int oob_required,
-					   int page)
+static int stm32_fmc2_nfc_seq_write_page(struct nand_chip *chip, const u8 *buf,
+					 int oob_required, int page)
 {
 	int ret;
 
-	ret = stm32_fmc2_select_chip(chip, chip->cur_cs);
+	ret = stm32_fmc2_nfc_select_chip(chip, chip->cur_cs);
 	if (ret)
 		return ret;
 
-	return stm32_fmc2_sequencer_write(chip, buf, oob_required, page, false);
+	return stm32_fmc2_nfc_seq_write(chip, buf, oob_required, page, false);
 }
 
-static int stm32_fmc2_sequencer_write_page_raw(struct nand_chip *chip,
-					       const u8 *buf,
-					       int oob_required,
-					       int page)
+static int stm32_fmc2_nfc_seq_write_page_raw(struct nand_chip *chip,
+					     const u8 *buf, int oob_required,
+					     int page)
 {
 	int ret;
 
-	ret = stm32_fmc2_select_chip(chip, chip->cur_cs);
+	ret = stm32_fmc2_nfc_select_chip(chip, chip->cur_cs);
 	if (ret)
 		return ret;
 
-	return stm32_fmc2_sequencer_write(chip, buf, oob_required, page, true);
+	return stm32_fmc2_nfc_seq_write(chip, buf, oob_required, page, true);
 }
 
 /* Get a status indicating which sectors have errors */
-static inline u16 stm32_fmc2_get_mapping_status(struct stm32_fmc2_nfc *fmc2)
+static inline u16 stm32_fmc2_nfc_get_mapping_status(struct stm32_fmc2_nfc *nfc)
 {
-	u32 csqemsr = readl_relaxed(fmc2->io_base + FMC2_CSQEMSR);
+	u32 csqemsr = readl_relaxed(nfc->io_base + FMC2_CSQEMSR);
 
 	return csqemsr & FMC2_CSQEMSR_SEM;
 }
 
-static int stm32_fmc2_sequencer_correct(struct nand_chip *chip, u8 *dat,
-					u8 *read_ecc, u8 *calc_ecc)
+static int stm32_fmc2_nfc_seq_correct(struct nand_chip *chip, u8 *dat,
+				      u8 *read_ecc, u8 *calc_ecc)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	int eccstrength = chip->ecc.strength;
 	int i, s, eccsize = chip->ecc.size;
-	u32 *ecc_sta = (u32 *)fmc2->ecc_buf;
-	u16 sta_map = stm32_fmc2_get_mapping_status(fmc2);
+	u32 *ecc_sta = (u32 *)nfc->ecc_buf;
+	u16 sta_map = stm32_fmc2_nfc_get_mapping_status(nfc);
 	unsigned int max_bitflips = 0;
 
 	for (i = 0, s = 0; s < eccsteps; s++, i += eccbytes, dat += eccsize) {
@@ -1080,10 +1075,11 @@ static int stm32_fmc2_sequencer_correct(struct nand_chip *chip, u8 *dat,
 		if (eccstrength == FMC2_ECC_HAM) {
 			/* Ecc_sta = FMC2_HECCR */
 			if (sta_map & BIT(s)) {
-				stm32_fmc2_ham_set_ecc(*ecc_sta, &calc_ecc[i]);
-				stat = stm32_fmc2_ham_correct(chip, dat,
-							      &read_ecc[i],
-							      &calc_ecc[i]);
+				stm32_fmc2_nfc_ham_set_ecc(*ecc_sta,
+							   &calc_ecc[i]);
+				stat = stm32_fmc2_nfc_ham_correct(chip, dat,
+								  &read_ecc[i],
+								  &calc_ecc[i]);
 			}
 			ecc_sta++;
 		} else {
@@ -1095,8 +1091,8 @@ static int stm32_fmc2_sequencer_correct(struct nand_chip *chip, u8 *dat,
 			 * Ecc_sta[4] = FMC2_BCHDSR4
 			 */
 			if (sta_map & BIT(s))
-				stat = stm32_fmc2_bch_decode(eccsize, dat,
-							     ecc_sta);
+				stat = stm32_fmc2_nfc_bch_decode(eccsize, dat,
+								 ecc_sta);
 			ecc_sta += 5;
 		}
 
@@ -1119,29 +1115,29 @@ static int stm32_fmc2_sequencer_correct(struct nand_chip *chip, u8 *dat,
 	return max_bitflips;
 }
 
-static int stm32_fmc2_sequencer_read_page(struct nand_chip *chip, u8 *buf,
-					  int oob_required, int page)
+static int stm32_fmc2_nfc_seq_read_page(struct nand_chip *chip, u8 *buf,
+					int oob_required, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	u8 *ecc_calc = chip->ecc.calc_buf;
 	u8 *ecc_code = chip->ecc.code_buf;
 	u16 sta_map;
 	int ret;
 
-	ret = stm32_fmc2_select_chip(chip, chip->cur_cs);
+	ret = stm32_fmc2_nfc_select_chip(chip, chip->cur_cs);
 	if (ret)
 		return ret;
 
 	/* Configure the sequencer */
-	stm32_fmc2_rw_page_init(chip, page, 0, false);
+	stm32_fmc2_nfc_rw_page_init(chip, page, 0, false);
 
 	/* Read the page */
-	ret = stm32_fmc2_xfer(chip, buf, 0, false);
+	ret = stm32_fmc2_nfc_xfer(chip, buf, 0, false);
 	if (ret)
 		return ret;
 
-	sta_map = stm32_fmc2_get_mapping_status(fmc2);
+	sta_map = stm32_fmc2_nfc_get_mapping_status(nfc);
 
 	/* Check if errors happen */
 	if (likely(!sta_map)) {
@@ -1168,21 +1164,21 @@ static int stm32_fmc2_sequencer_read_page(struct nand_chip *chip, u8 *buf,
 	return chip->ecc.correct(chip, buf, ecc_code, ecc_calc);
 }
 
-static int stm32_fmc2_sequencer_read_page_raw(struct nand_chip *chip, u8 *buf,
-					      int oob_required, int page)
+static int stm32_fmc2_nfc_seq_read_page_raw(struct nand_chip *chip, u8 *buf,
+					    int oob_required, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
-	ret = stm32_fmc2_select_chip(chip, chip->cur_cs);
+	ret = stm32_fmc2_nfc_select_chip(chip, chip->cur_cs);
 	if (ret)
 		return ret;
 
 	/* Configure the sequencer */
-	stm32_fmc2_rw_page_init(chip, page, 1, false);
+	stm32_fmc2_nfc_rw_page_init(chip, page, 1, false);
 
 	/* Read the page */
-	ret = stm32_fmc2_xfer(chip, buf, 1, false);
+	ret = stm32_fmc2_nfc_xfer(chip, buf, 1, false);
 	if (ret)
 		return ret;
 
@@ -1195,31 +1191,31 @@ static int stm32_fmc2_sequencer_read_page_raw(struct nand_chip *chip, u8 *buf,
 	return 0;
 }
 
-static irqreturn_t stm32_fmc2_irq(int irq, void *dev_id)
+static irqreturn_t stm32_fmc2_nfc_irq(int irq, void *dev_id)
 {
-	struct stm32_fmc2_nfc *fmc2 = (struct stm32_fmc2_nfc *)dev_id;
+	struct stm32_fmc2_nfc *nfc = (struct stm32_fmc2_nfc *)dev_id;
 
-	if (fmc2->irq_state == FMC2_IRQ_SEQ)
+	if (nfc->irq_state == FMC2_IRQ_SEQ)
 		/* Sequencer is used */
-		stm32_fmc2_disable_seq_irq(fmc2);
-	else if (fmc2->irq_state == FMC2_IRQ_BCH)
+		stm32_fmc2_nfc_disable_seq_irq(nfc);
+	else if (nfc->irq_state == FMC2_IRQ_BCH)
 		/* BCH is used */
-		stm32_fmc2_disable_bch_irq(fmc2);
+		stm32_fmc2_nfc_disable_bch_irq(nfc);
 
-	complete(&fmc2->complete);
+	complete(&nfc->complete);
 
 	return IRQ_HANDLED;
 }
 
-static void stm32_fmc2_read_data(struct nand_chip *chip, void *buf,
-				 unsigned int len, bool force_8bit)
+static void stm32_fmc2_nfc_read_data(struct nand_chip *chip, void *buf,
+				     unsigned int len, bool force_8bit)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
-	void __iomem *io_addr_r = fmc2->data_base[fmc2->cs_sel];
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	void __iomem *io_addr_r = nfc->data_base[nfc->cs_sel];
 
 	if (force_8bit && chip->options & NAND_BUSWIDTH_16)
 		/* Reconfigure bus width to 8-bit */
-		stm32_fmc2_set_buswidth_16(fmc2, false);
+		stm32_fmc2_nfc_set_buswidth_16(nfc, false);
 
 	if (!IS_ALIGNED((uintptr_t)buf, sizeof(u32))) {
 		if (!IS_ALIGNED((uintptr_t)buf, sizeof(u16)) && len) {
@@ -1255,18 +1251,18 @@ static void stm32_fmc2_read_data(struct nand_chip *chip, void *buf,
 
 	if (force_8bit && chip->options & NAND_BUSWIDTH_16)
 		/* Reconfigure bus width to 16-bit */
-		stm32_fmc2_set_buswidth_16(fmc2, true);
+		stm32_fmc2_nfc_set_buswidth_16(nfc, true);
 }
 
-static void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
-				  unsigned int len, bool force_8bit)
+static void stm32_fmc2_nfc_write_data(struct nand_chip *chip, const void *buf,
+				      unsigned int len, bool force_8bit)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
-	void __iomem *io_addr_w = fmc2->data_base[fmc2->cs_sel];
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
+	void __iomem *io_addr_w = nfc->data_base[nfc->cs_sel];
 
 	if (force_8bit && chip->options & NAND_BUSWIDTH_16)
 		/* Reconfigure bus width to 8-bit */
-		stm32_fmc2_set_buswidth_16(fmc2, false);
+		stm32_fmc2_nfc_set_buswidth_16(nfc, false);
 
 	if (!IS_ALIGNED((uintptr_t)buf, sizeof(u32))) {
 		if (!IS_ALIGNED((uintptr_t)buf, sizeof(u16)) && len) {
@@ -1302,44 +1298,45 @@ static void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
 
 	if (force_8bit && chip->options & NAND_BUSWIDTH_16)
 		/* Reconfigure bus width to 16-bit */
-		stm32_fmc2_set_buswidth_16(fmc2, true);
+		stm32_fmc2_nfc_set_buswidth_16(nfc, true);
 }
 
-static int stm32_fmc2_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
+static int stm32_fmc2_nfc_waitrdy(struct nand_chip *chip,
+				  unsigned long timeout_ms)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	const struct nand_sdr_timings *timings;
 	u32 isr, sr;
 
 	/* Check if there is no pending requests to the NAND flash */
-	if (readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR, sr,
+	if (readl_relaxed_poll_timeout_atomic(nfc->io_base + FMC2_SR, sr,
 					      sr & FMC2_SR_NWRF, 1,
 					      1000 * FMC2_TIMEOUT_MS))
-		dev_warn(fmc2->dev, "Waitrdy timeout\n");
+		dev_warn(nfc->dev, "Waitrdy timeout\n");
 
 	/* Wait tWB before R/B# signal is low */
 	timings = nand_get_sdr_timings(&chip->data_interface);
 	ndelay(PSEC_TO_NSEC(timings->tWB_max));
 
 	/* R/B# signal is low, clear high level flag */
-	writel_relaxed(FMC2_ICR_CIHLF, fmc2->io_base + FMC2_ICR);
+	writel_relaxed(FMC2_ICR_CIHLF, nfc->io_base + FMC2_ICR);
 
 	/* Wait R/B# signal is high */
-	return readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_ISR,
+	return readl_relaxed_poll_timeout_atomic(nfc->io_base + FMC2_ISR,
 						 isr, isr & FMC2_ISR_IHLF,
 						 5, 1000 * timeout_ms);
 }
 
-static int stm32_fmc2_exec_op(struct nand_chip *chip,
-			      const struct nand_operation *op,
-			      bool check_only)
+static int stm32_fmc2_nfc_exec_op(struct nand_chip *chip,
+				  const struct nand_operation *op,
+				  bool check_only)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	const struct nand_op_instr *instr = NULL;
-	unsigned int op_id, i;
+	unsigned int op_id, i, timeout;
 	int ret;
 
-	ret = stm32_fmc2_select_chip(chip, op->cs);
+	ret = stm32_fmc2_nfc_select_chip(chip, op->cs);
 	if (ret)
 		return ret;
 
@@ -1352,30 +1349,30 @@ static int stm32_fmc2_exec_op(struct nand_chip *chip,
 		switch (instr->type) {
 		case NAND_OP_CMD_INSTR:
 			writeb_relaxed(instr->ctx.cmd.opcode,
-				       fmc2->cmd_base[fmc2->cs_sel]);
+				       nfc->cmd_base[nfc->cs_sel]);
 			break;
 
 		case NAND_OP_ADDR_INSTR:
 			for (i = 0; i < instr->ctx.addr.naddrs; i++)
 				writeb_relaxed(instr->ctx.addr.addrs[i],
-					       fmc2->addr_base[fmc2->cs_sel]);
+					       nfc->addr_base[nfc->cs_sel]);
 			break;
 
 		case NAND_OP_DATA_IN_INSTR:
-			stm32_fmc2_read_data(chip, instr->ctx.data.buf.in,
-					     instr->ctx.data.len,
-					     instr->ctx.data.force_8bit);
+			stm32_fmc2_nfc_read_data(chip, instr->ctx.data.buf.in,
+						 instr->ctx.data.len,
+						 instr->ctx.data.force_8bit);
 			break;
 
 		case NAND_OP_DATA_OUT_INSTR:
-			stm32_fmc2_write_data(chip, instr->ctx.data.buf.out,
-					      instr->ctx.data.len,
-					      instr->ctx.data.force_8bit);
+			stm32_fmc2_nfc_write_data(chip, instr->ctx.data.buf.out,
+						  instr->ctx.data.len,
+						  instr->ctx.data.force_8bit);
 			break;
 
 		case NAND_OP_WAITRDY_INSTR:
-			ret = stm32_fmc2_waitrdy(chip,
-						 instr->ctx.waitrdy.timeout_ms);
+			timeout = instr->ctx.waitrdy.timeout_ms;
+			ret = stm32_fmc2_nfc_waitrdy(chip, timeout);
 			break;
 		}
 	}
@@ -1383,13 +1380,13 @@ static int stm32_fmc2_exec_op(struct nand_chip *chip,
 	return ret;
 }
 
-static void stm32_fmc2_init(struct stm32_fmc2_nfc *fmc2)
+static void stm32_fmc2_nfc_init(struct stm32_fmc2_nfc *nfc)
 {
-	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
-	u32 bcr1 = readl_relaxed(fmc2->io_base + FMC2_BCR1);
+	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
+	u32 bcr1 = readl_relaxed(nfc->io_base + FMC2_BCR1);
 
 	/* Set CS used to undefined */
-	fmc2->cs_sel = -1;
+	nfc->cs_sel = -1;
 
 	/* Enable wait feature and nand flash memory bank */
 	pcr |= FMC2_PCR_PWAITEN;
@@ -1419,19 +1416,19 @@ static void stm32_fmc2_init(struct stm32_fmc2_nfc *fmc2)
 	/* Enable FMC2 controller */
 	bcr1 |= FMC2_BCR1_FMC2EN;
 
-	writel_relaxed(bcr1, fmc2->io_base + FMC2_BCR1);
-	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
-	writel_relaxed(FMC2_PMEM_DEFAULT, fmc2->io_base + FMC2_PMEM);
-	writel_relaxed(FMC2_PATT_DEFAULT, fmc2->io_base + FMC2_PATT);
+	writel_relaxed(bcr1, nfc->io_base + FMC2_BCR1);
+	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
+	writel_relaxed(FMC2_PMEM_DEFAULT, nfc->io_base + FMC2_PMEM);
+	writel_relaxed(FMC2_PATT_DEFAULT, nfc->io_base + FMC2_PATT);
 }
 
-static void stm32_fmc2_calc_timings(struct nand_chip *chip,
-				    const struct nand_sdr_timings *sdrt)
+static void stm32_fmc2_nfc_calc_timings(struct nand_chip *chip,
+					const struct nand_sdr_timings *sdrt)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct stm32_fmc2_nand *nand = to_fmc2_nand(chip);
 	struct stm32_fmc2_timings *tims = &nand->timings;
-	unsigned long hclk = clk_get_rate(fmc2->clk);
+	unsigned long hclk = clk_get_rate(nfc->clk);
 	unsigned long hclkp = NSEC_PER_SEC / (hclk / 1000);
 	unsigned long timing, tar, tclr, thiz, twait;
 	unsigned long tset_mem, tset_att, thold_mem, thold_att;
@@ -1555,80 +1552,79 @@ static void stm32_fmc2_calc_timings(struct nand_chip *chip,
 	tims->thold_att = clamp_val(timing, 1, FMC2_PMEM_PATT_TIMING_MASK);
 }
 
-static int stm32_fmc2_setup_interface(struct nand_chip *chip, int chipnr,
-				      const struct nand_data_interface *conf)
+static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
+					  const struct nand_data_interface *cf)
 {
 	const struct nand_sdr_timings *sdrt;
 
-	sdrt = nand_get_sdr_timings(conf);
+	sdrt = nand_get_sdr_timings(cf);
 	if (IS_ERR(sdrt))
 		return PTR_ERR(sdrt);
 
 	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
 		return 0;
 
-	stm32_fmc2_calc_timings(chip, sdrt);
-	stm32_fmc2_timings_init(chip);
+	stm32_fmc2_nfc_calc_timings(chip, sdrt);
+	stm32_fmc2_nfc_timings_init(chip);
 
 	return 0;
 }
 
-static int stm32_fmc2_dma_setup(struct stm32_fmc2_nfc *fmc2)
+static int stm32_fmc2_nfc_dma_setup(struct stm32_fmc2_nfc *nfc)
 {
 	int ret = 0;
 
-	fmc2->dma_tx_ch = dma_request_chan(fmc2->dev, "tx");
-	if (IS_ERR(fmc2->dma_tx_ch)) {
-		ret = PTR_ERR(fmc2->dma_tx_ch);
+	nfc->dma_tx_ch = dma_request_chan(nfc->dev, "tx");
+	if (IS_ERR(nfc->dma_tx_ch)) {
+		ret = PTR_ERR(nfc->dma_tx_ch);
 		if (ret != -ENODEV)
-			dev_err(fmc2->dev,
+			dev_err(nfc->dev,
 				"failed to request tx DMA channel: %d\n", ret);
-		fmc2->dma_tx_ch = NULL;
+		nfc->dma_tx_ch = NULL;
 		goto err_dma;
 	}
 
-	fmc2->dma_rx_ch = dma_request_chan(fmc2->dev, "rx");
-	if (IS_ERR(fmc2->dma_rx_ch)) {
-		ret = PTR_ERR(fmc2->dma_rx_ch);
+	nfc->dma_rx_ch = dma_request_chan(nfc->dev, "rx");
+	if (IS_ERR(nfc->dma_rx_ch)) {
+		ret = PTR_ERR(nfc->dma_rx_ch);
 		if (ret != -ENODEV)
-			dev_err(fmc2->dev,
+			dev_err(nfc->dev,
 				"failed to request rx DMA channel: %d\n", ret);
-		fmc2->dma_rx_ch = NULL;
+		nfc->dma_rx_ch = NULL;
 		goto err_dma;
 	}
 
-	fmc2->dma_ecc_ch = dma_request_chan(fmc2->dev, "ecc");
-	if (IS_ERR(fmc2->dma_ecc_ch)) {
-		ret = PTR_ERR(fmc2->dma_ecc_ch);
+	nfc->dma_ecc_ch = dma_request_chan(nfc->dev, "ecc");
+	if (IS_ERR(nfc->dma_ecc_ch)) {
+		ret = PTR_ERR(nfc->dma_ecc_ch);
 		if (ret != -ENODEV)
-			dev_err(fmc2->dev,
+			dev_err(nfc->dev,
 				"failed to request ecc DMA channel: %d\n", ret);
-		fmc2->dma_ecc_ch = NULL;
+		nfc->dma_ecc_ch = NULL;
 		goto err_dma;
 	}
 
-	ret = sg_alloc_table(&fmc2->dma_ecc_sg, FMC2_MAX_SG, GFP_KERNEL);
+	ret = sg_alloc_table(&nfc->dma_ecc_sg, FMC2_MAX_SG, GFP_KERNEL);
 	if (ret)
 		return ret;
 
 	/* Allocate a buffer to store ECC status registers */
-	fmc2->ecc_buf = devm_kzalloc(fmc2->dev, FMC2_MAX_ECC_BUF_LEN,
-				     GFP_KERNEL);
-	if (!fmc2->ecc_buf)
+	nfc->ecc_buf = devm_kzalloc(nfc->dev, FMC2_MAX_ECC_BUF_LEN, GFP_KERNEL);
+	if (!nfc->ecc_buf)
 		return -ENOMEM;
 
-	ret = sg_alloc_table(&fmc2->dma_data_sg, FMC2_MAX_SG, GFP_KERNEL);
+	ret = sg_alloc_table(&nfc->dma_data_sg, FMC2_MAX_SG, GFP_KERNEL);
 	if (ret)
 		return ret;
 
-	init_completion(&fmc2->dma_data_complete);
-	init_completion(&fmc2->dma_ecc_complete);
+	init_completion(&nfc->dma_data_complete);
+	init_completion(&nfc->dma_ecc_complete);
 
 	return 0;
 
 err_dma:
 	if (ret == -ENODEV) {
-		dev_warn(fmc2->dev,
+		dev_warn(nfc->dev,
 			 "DMAs not defined in the DT, polling mode is used\n");
 		ret = 0;
 	}
@@ -1636,34 +1632,34 @@ static int stm32_fmc2_dma_setup(struct stm32_fmc2_nfc *fmc2)
 	return ret;
 }
 
-static void stm32_fmc2_nand_callbacks_setup(struct nand_chip *chip)
+static void stm32_fmc2_nfc_nand_callbacks_setup(struct nand_chip *chip)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 
 	/*
 	 * Specific callbacks to read/write a page depending on
 	 * the mode (polling/sequencer) and the algo used (Hamming, BCH).
 	 */
-	if (fmc2->dma_tx_ch && fmc2->dma_rx_ch && fmc2->dma_ecc_ch) {
+	if (nfc->dma_tx_ch && nfc->dma_rx_ch && nfc->dma_ecc_ch) {
 		/* DMA => use sequencer mode callbacks */
-		chip->ecc.correct = stm32_fmc2_sequencer_correct;
-		chip->ecc.write_page = stm32_fmc2_sequencer_write_page;
-		chip->ecc.read_page = stm32_fmc2_sequencer_read_page;
-		chip->ecc.write_page_raw = stm32_fmc2_sequencer_write_page_raw;
-		chip->ecc.read_page_raw = stm32_fmc2_sequencer_read_page_raw;
+		chip->ecc.correct = stm32_fmc2_nfc_seq_correct;
+		chip->ecc.write_page = stm32_fmc2_nfc_seq_write_page;
+		chip->ecc.read_page = stm32_fmc2_nfc_seq_read_page;
+		chip->ecc.write_page_raw = stm32_fmc2_nfc_seq_write_page_raw;
+		chip->ecc.read_page_raw = stm32_fmc2_nfc_seq_read_page_raw;
 	} else {
 		/* No DMA => use polling mode callbacks */
-		chip->ecc.hwctl = stm32_fmc2_hwctl;
+		chip->ecc.hwctl = stm32_fmc2_nfc_hwctl;
 		if (chip->ecc.strength == FMC2_ECC_HAM) {
 			/* Hamming is used */
-			chip->ecc.calculate = stm32_fmc2_ham_calculate;
-			chip->ecc.correct = stm32_fmc2_ham_correct;
+			chip->ecc.calculate = stm32_fmc2_nfc_ham_calculate;
+			chip->ecc.correct = stm32_fmc2_nfc_ham_correct;
 			chip->ecc.options |= NAND_ECC_GENERIC_ERASED_CHECK;
 		} else {
 			/* BCH is used */
-			chip->ecc.calculate = stm32_fmc2_bch_calculate;
-			chip->ecc.correct = stm32_fmc2_bch_correct;
-			chip->ecc.read_page = stm32_fmc2_read_page;
+			chip->ecc.calculate = stm32_fmc2_nfc_bch_calculate;
+			chip->ecc.correct = stm32_fmc2_nfc_bch_correct;
+			chip->ecc.read_page = stm32_fmc2_nfc_read_page;
 		}
 	}
 
@@ -1676,8 +1672,8 @@ static void stm32_fmc2_nand_callbacks_setup(struct nand_chip *chip)
 		chip->ecc.bytes = chip->options & NAND_BUSWIDTH_16 ? 8 : 7;
 }
 
-static int stm32_fmc2_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
-					 struct mtd_oob_region *oobregion)
+static int stm32_fmc2_nfc_ooblayout_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *oobregion)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
@@ -1691,8 +1687,8 @@ static int stm32_fmc2_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-static int stm32_fmc2_nand_ooblayout_free(struct mtd_info *mtd, int section,
-					  struct mtd_oob_region *oobregion)
+static int stm32_fmc2_nfc_ooblayout_free(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *oobregion)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
@@ -1706,12 +1702,12 @@ static int stm32_fmc2_nand_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-static const struct mtd_ooblayout_ops stm32_fmc2_nand_ooblayout_ops = {
-	.ecc = stm32_fmc2_nand_ooblayout_ecc,
-	.free = stm32_fmc2_nand_ooblayout_free,
+static const struct mtd_ooblayout_ops stm32_fmc2_nfc_ooblayout_ops = {
+	.ecc = stm32_fmc2_nfc_ooblayout_ecc,
+	.free = stm32_fmc2_nfc_ooblayout_free,
 };
 
-static int stm32_fmc2_calc_ecc_bytes(int step_size, int strength)
+static int stm32_fmc2_nfc_calc_ecc_bytes(int step_size, int strength)
 {
 	/* Hamming */
 	if (strength == FMC2_ECC_HAM)
@@ -1725,13 +1721,13 @@ static int stm32_fmc2_calc_ecc_bytes(int step_size, int strength)
 	return 8;
 }
 
-NAND_ECC_CAPS_SINGLE(stm32_fmc2_ecc_caps, stm32_fmc2_calc_ecc_bytes,
+NAND_ECC_CAPS_SINGLE(stm32_fmc2_nfc_ecc_caps, stm32_fmc2_nfc_calc_ecc_bytes,
 		     FMC2_ECC_STEP_SIZE,
 		     FMC2_ECC_HAM, FMC2_ECC_BCH4, FMC2_ECC_BCH8);
 
-static int stm32_fmc2_attach_chip(struct nand_chip *chip)
+static int stm32_fmc2_nfc_attach_chip(struct nand_chip *chip)
 {
-	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	struct stm32_fmc2_nfc *nfc = to_stm32_nfc(chip->controller);
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
@@ -1743,45 +1739,45 @@ static int stm32_fmc2_attach_chip(struct nand_chip *chip)
 	 * ECC sector size = 512
 	 */
 	if (chip->ecc.mode != NAND_ECC_HW) {
-		dev_err(fmc2->dev, "nand_ecc_mode is not well defined in the DT\n");
+		dev_err(nfc->dev, "nand_ecc_mode is not well defined in the DT\n");
 		return -EINVAL;
 	}
 
-	ret = nand_ecc_choose_conf(chip, &stm32_fmc2_ecc_caps,
+	ret = nand_ecc_choose_conf(chip, &stm32_fmc2_nfc_ecc_caps,
 				   mtd->oobsize - FMC2_BBM_LEN);
 	if (ret) {
-		dev_err(fmc2->dev, "no valid ECC settings set\n");
+		dev_err(nfc->dev, "no valid ECC settings set\n");
 		return ret;
 	}
 
 	if (mtd->writesize / chip->ecc.size > FMC2_MAX_SG) {
-		dev_err(fmc2->dev, "nand page size is not supported\n");
+		dev_err(nfc->dev, "nand page size is not supported\n");
 		return -EINVAL;
 	}
 
 	if (chip->bbt_options & NAND_BBT_USE_FLASH)
 		chip->bbt_options |= NAND_BBT_NO_OOB;
 
-	stm32_fmc2_nand_callbacks_setup(chip);
+	stm32_fmc2_nfc_nand_callbacks_setup(chip);
 
-	mtd_set_ooblayout(mtd, &stm32_fmc2_nand_ooblayout_ops);
+	mtd_set_ooblayout(mtd, &stm32_fmc2_nfc_ooblayout_ops);
 
 	if (chip->options & NAND_BUSWIDTH_16)
-		stm32_fmc2_set_buswidth_16(fmc2, true);
+		stm32_fmc2_nfc_set_buswidth_16(nfc, true);
 
 	return 0;
 }
 
-static const struct nand_controller_ops stm32_fmc2_nand_controller_ops = {
-	.attach_chip = stm32_fmc2_attach_chip,
-	.exec_op = stm32_fmc2_exec_op,
-	.setup_data_interface = stm32_fmc2_setup_interface,
+static const struct nand_controller_ops stm32_fmc2_nfc_controller_ops = {
+	.attach_chip = stm32_fmc2_nfc_attach_chip,
+	.exec_op = stm32_fmc2_nfc_exec_op,
+	.setup_data_interface = stm32_fmc2_nfc_setup_interface,
 };
 
-static int stm32_fmc2_parse_child(struct stm32_fmc2_nfc *fmc2,
-				  struct device_node *dn)
+static int stm32_fmc2_nfc_parse_child(struct stm32_fmc2_nfc *nfc,
+				      struct device_node *dn)
 {
-	struct stm32_fmc2_nand *nand = &fmc2->nand;
+	struct stm32_fmc2_nand *nand = &nfc->nand;
 	u32 cs;
 	int ret, i;
 
@@ -1790,29 +1786,29 @@ static int stm32_fmc2_parse_child(struct stm32_fmc2_nfc *fmc2,
 
 	nand->ncs /= sizeof(u32);
 	if (!nand->ncs) {
-		dev_err(fmc2->dev, "invalid reg property size\n");
+		dev_err(nfc->dev, "invalid reg property size\n");
 		return -EINVAL;
 	}
 
 	for (i = 0; i < nand->ncs; i++) {
 		ret = of_property_read_u32_index(dn, "reg", i, &cs);
 		if (ret) {
-			dev_err(fmc2->dev, "could not retrieve reg property: %d\n",
+			dev_err(nfc->dev, "could not retrieve reg property: %d\n",
 				ret);
 			return ret;
 		}
 
 		if (cs > FMC2_MAX_CE) {
-			dev_err(fmc2->dev, "invalid reg value: %d\n", cs);
+			dev_err(nfc->dev, "invalid reg value: %d\n", cs);
 			return -EINVAL;
 		}
 
-		if (fmc2->cs_assigned & BIT(cs)) {
-			dev_err(fmc2->dev, "cs already assigned: %d\n", cs);
+		if (nfc->cs_assigned & BIT(cs)) {
+			dev_err(nfc->dev, "cs already assigned: %d\n", cs);
 			return -EINVAL;
 		}
 
-		fmc2->cs_assigned |= BIT(cs);
+		nfc->cs_assigned |= BIT(cs);
 		nand->cs_used[i] = cs;
 	}
 
@@ -1821,25 +1817,25 @@ static int stm32_fmc2_parse_child(struct stm32_fmc2_nfc *fmc2,
 	return 0;
 }
 
-static int stm32_fmc2_parse_dt(struct stm32_fmc2_nfc *fmc2)
+static int stm32_fmc2_nfc_parse_dt(struct stm32_fmc2_nfc *nfc)
 {
-	struct device_node *dn = fmc2->dev->of_node;
+	struct device_node *dn = nfc->dev->of_node;
 	struct device_node *child;
 	int nchips = of_get_child_count(dn);
 	int ret = 0;
 
 	if (!nchips) {
-		dev_err(fmc2->dev, "NAND chip not defined\n");
+		dev_err(nfc->dev, "NAND chip not defined\n");
 		return -EINVAL;
 	}
 
 	if (nchips > 1) {
-		dev_err(fmc2->dev, "too many NAND chips defined\n");
+		dev_err(nfc->dev, "too many NAND chips defined\n");
 		return -EINVAL;
 	}
 
 	for_each_child_of_node(dn, child) {
-		ret = stm32_fmc2_parse_child(fmc2, child);
+		ret = stm32_fmc2_nfc_parse_child(nfc, child);
 		if (ret < 0) {
 			of_node_put(child);
 			return ret;
@@ -1849,79 +1845,79 @@ static int stm32_fmc2_parse_dt(struct stm32_fmc2_nfc *fmc2)
 	return ret;
 }
 
-static int stm32_fmc2_probe(struct platform_device *pdev)
+static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct reset_control *rstc;
-	struct stm32_fmc2_nfc *fmc2;
+	struct stm32_fmc2_nfc *nfc;
 	struct stm32_fmc2_nand *nand;
 	struct resource *res;
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
 	int chip_cs, mem_region, ret, irq;
 
-	fmc2 = devm_kzalloc(dev, sizeof(*fmc2), GFP_KERNEL);
-	if (!fmc2)
+	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
+	if (!nfc)
 		return -ENOMEM;
 
-	fmc2->dev = dev;
-	nand_controller_init(&fmc2->base);
-	fmc2->base.ops = &stm32_fmc2_nand_controller_ops;
+	nfc->dev = dev;
+	nand_controller_init(&nfc->base);
+	nfc->base.ops = &stm32_fmc2_nfc_controller_ops;
 
-	ret = stm32_fmc2_parse_dt(fmc2);
+	ret = stm32_fmc2_nfc_parse_dt(nfc);
 	if (ret)
 		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fmc2->io_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(fmc2->io_base))
-		return PTR_ERR(fmc2->io_base);
+	nfc->io_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(nfc->io_base))
+		return PTR_ERR(nfc->io_base);
 
-	fmc2->io_phys_addr = res->start;
+	nfc->io_phys_addr = res->start;
 
 	for (chip_cs = 0, mem_region = 1; chip_cs < FMC2_MAX_CE;
 	     chip_cs++, mem_region += 3) {
-		if (!(fmc2->cs_assigned & BIT(chip_cs)))
+		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, mem_region);
-		fmc2->data_base[chip_cs] = devm_ioremap_resource(dev, res);
-		if (IS_ERR(fmc2->data_base[chip_cs]))
-			return PTR_ERR(fmc2->data_base[chip_cs]);
+		nfc->data_base[chip_cs] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(nfc->data_base[chip_cs]))
+			return PTR_ERR(nfc->data_base[chip_cs]);
 
-		fmc2->data_phys_addr[chip_cs] = res->start;
+		nfc->data_phys_addr[chip_cs] = res->start;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM,
 					    mem_region + 1);
-		fmc2->cmd_base[chip_cs] = devm_ioremap_resource(dev, res);
-		if (IS_ERR(fmc2->cmd_base[chip_cs]))
-			return PTR_ERR(fmc2->cmd_base[chip_cs]);
+		nfc->cmd_base[chip_cs] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(nfc->cmd_base[chip_cs]))
+			return PTR_ERR(nfc->cmd_base[chip_cs]);
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM,
 					    mem_region + 2);
-		fmc2->addr_base[chip_cs] = devm_ioremap_resource(dev, res);
-		if (IS_ERR(fmc2->addr_base[chip_cs]))
-			return PTR_ERR(fmc2->addr_base[chip_cs]);
+		nfc->addr_base[chip_cs] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(nfc->addr_base[chip_cs]))
+			return PTR_ERR(nfc->addr_base[chip_cs]);
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(dev, irq, stm32_fmc2_irq, 0,
-			       dev_name(dev), fmc2);
+	ret = devm_request_irq(dev, irq, stm32_fmc2_nfc_irq, 0,
+			       dev_name(dev), nfc);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		return ret;
 	}
 
-	init_completion(&fmc2->complete);
+	init_completion(&nfc->complete);
 
-	fmc2->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(fmc2->clk))
-		return PTR_ERR(fmc2->clk);
+	nfc->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(nfc->clk))
+		return PTR_ERR(nfc->clk);
 
-	ret = clk_prepare_enable(fmc2->clk);
+	ret = clk_prepare_enable(nfc->clk);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
 		return ret;
@@ -1937,18 +1933,18 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 		reset_control_deassert(rstc);
 	}
 
-	ret = stm32_fmc2_dma_setup(fmc2);
+	ret = stm32_fmc2_nfc_dma_setup(nfc);
 	if (ret)
 		goto err_dma_setup;
 
-	stm32_fmc2_init(fmc2);
+	stm32_fmc2_nfc_init(nfc);
 
-	nand = &fmc2->nand;
+	nand = &nfc->nand;
 	chip = &nand->chip;
 	mtd = nand_to_mtd(chip);
 	mtd->dev.parent = dev;
 
-	chip->controller = &fmc2->base;
+	chip->controller = &nfc->base;
 	chip->options |= NAND_BUSWIDTH_AUTO | NAND_NO_SUBPAGE_WRITE |
 			 NAND_USE_BOUNCE_BUFFER;
 
@@ -1966,7 +1962,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_device_register;
 
-	platform_set_drvdata(pdev, fmc2);
+	platform_set_drvdata(pdev, nfc);
 
 	return 0;
 
@@ -1974,73 +1970,73 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	nand_cleanup(chip);
 
 err_dma_setup:
-	if (fmc2->dma_ecc_ch)
-		dma_release_channel(fmc2->dma_ecc_ch);
-	if (fmc2->dma_tx_ch)
-		dma_release_channel(fmc2->dma_tx_ch);
-	if (fmc2->dma_rx_ch)
-		dma_release_channel(fmc2->dma_rx_ch);
+	if (nfc->dma_ecc_ch)
+		dma_release_channel(nfc->dma_ecc_ch);
+	if (nfc->dma_tx_ch)
+		dma_release_channel(nfc->dma_tx_ch);
+	if (nfc->dma_rx_ch)
+		dma_release_channel(nfc->dma_rx_ch);
 
-	sg_free_table(&fmc2->dma_data_sg);
-	sg_free_table(&fmc2->dma_ecc_sg);
+	sg_free_table(&nfc->dma_data_sg);
+	sg_free_table(&nfc->dma_ecc_sg);
 
 err_clk_disable:
-	clk_disable_unprepare(fmc2->clk);
+	clk_disable_unprepare(nfc->clk);
 
 	return ret;
 }
 
-static int stm32_fmc2_remove(struct platform_device *pdev)
+static int stm32_fmc2_nfc_remove(struct platform_device *pdev)
 {
-	struct stm32_fmc2_nfc *fmc2 = platform_get_drvdata(pdev);
-	struct stm32_fmc2_nand *nand = &fmc2->nand;
+	struct stm32_fmc2_nfc *nfc = platform_get_drvdata(pdev);
+	struct stm32_fmc2_nand *nand = &nfc->nand;
 
 	nand_release(&nand->chip);
 
-	if (fmc2->dma_ecc_ch)
-		dma_release_channel(fmc2->dma_ecc_ch);
-	if (fmc2->dma_tx_ch)
-		dma_release_channel(fmc2->dma_tx_ch);
-	if (fmc2->dma_rx_ch)
-		dma_release_channel(fmc2->dma_rx_ch);
+	if (nfc->dma_ecc_ch)
+		dma_release_channel(nfc->dma_ecc_ch);
+	if (nfc->dma_tx_ch)
+		dma_release_channel(nfc->dma_tx_ch);
+	if (nfc->dma_rx_ch)
+		dma_release_channel(nfc->dma_rx_ch);
 
-	sg_free_table(&fmc2->dma_data_sg);
-	sg_free_table(&fmc2->dma_ecc_sg);
+	sg_free_table(&nfc->dma_data_sg);
+	sg_free_table(&nfc->dma_ecc_sg);
 
-	clk_disable_unprepare(fmc2->clk);
+	clk_disable_unprepare(nfc->clk);
 
 	return 0;
 }
 
-static int __maybe_unused stm32_fmc2_suspend(struct device *dev)
+static int __maybe_unused stm32_fmc2_nfc_suspend(struct device *dev)
 {
-	struct stm32_fmc2_nfc *fmc2 = dev_get_drvdata(dev);
+	struct stm32_fmc2_nfc *nfc = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(fmc2->clk);
+	clk_disable_unprepare(nfc->clk);
 
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
 }
 
-static int __maybe_unused stm32_fmc2_resume(struct device *dev)
+static int __maybe_unused stm32_fmc2_nfc_resume(struct device *dev)
 {
-	struct stm32_fmc2_nfc *fmc2 = dev_get_drvdata(dev);
-	struct stm32_fmc2_nand *nand = &fmc2->nand;
+	struct stm32_fmc2_nfc *nfc = dev_get_drvdata(dev);
+	struct stm32_fmc2_nand *nand = &nfc->nand;
 	int chip_cs, ret;
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = clk_prepare_enable(fmc2->clk);
+	ret = clk_prepare_enable(nfc->clk);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
 		return ret;
 	}
 
-	stm32_fmc2_init(fmc2);
+	stm32_fmc2_nfc_init(nfc);
 
 	for (chip_cs = 0; chip_cs < FMC2_MAX_CE; chip_cs++) {
-		if (!(fmc2->cs_assigned & BIT(chip_cs)))
+		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
 
 		nand_reset(&nand->chip, chip_cs);
@@ -2049,27 +2045,27 @@ static int __maybe_unused stm32_fmc2_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_fmc2_pm_ops, stm32_fmc2_suspend,
-			 stm32_fmc2_resume);
+static SIMPLE_DEV_PM_OPS(stm32_fmc2_nfc_pm_ops, stm32_fmc2_nfc_suspend,
+			 stm32_fmc2_nfc_resume);
 
-static const struct of_device_id stm32_fmc2_match[] = {
+static const struct of_device_id stm32_fmc2_nfc_match[] = {
 	{.compatible = "st,stm32mp15-fmc2"},
 	{}
 };
-MODULE_DEVICE_TABLE(of, stm32_fmc2_match);
+MODULE_DEVICE_TABLE(of, stm32_fmc2_nfc_match);
 
-static struct platform_driver stm32_fmc2_driver = {
-	.probe	= stm32_fmc2_probe,
-	.remove	= stm32_fmc2_remove,
+static struct platform_driver stm32_fmc2_nfc_driver = {
+	.probe	= stm32_fmc2_nfc_probe,
+	.remove	= stm32_fmc2_nfc_remove,
 	.driver	= {
-		.name = "stm32_fmc2_nand",
-		.of_match_table = stm32_fmc2_match,
-		.pm = &stm32_fmc2_pm_ops,
+		.name = "stm32_fmc2_nfc",
+		.of_match_table = stm32_fmc2_nfc_match,
+		.pm = &stm32_fmc2_nfc_pm_ops,
 	},
 };
-module_platform_driver(stm32_fmc2_driver);
+module_platform_driver(stm32_fmc2_nfc_driver);
 
-MODULE_ALIAS("platform:stm32_fmc2_nand");
+MODULE_ALIAS("platform:stm32_fmc2_nfc");
 MODULE_AUTHOR("Christophe Kerello <christophe.kerello@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics STM32 FMC2 nand driver");
+MODULE_DESCRIPTION("STMicroelectronics STM32 FMC2 nfc driver");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

