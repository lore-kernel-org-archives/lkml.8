Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1C2206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dD0vBGZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415034AbgDOP7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:59:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21762 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410051AbgDOP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:59:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FFW5Hp032217;
        Wed, 15 Apr 2020 17:58:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Khc/U1sUR95Aj2cY969DKti/dzXYr2tJdsiqM1nCHow=;
 b=dD0vBGZTW/7pq4LFVz7FHtV46GmihzFC636+ak1yV/xA6cBKTpaQ2WU+HBhTXjJU7Sen
 tmD+VfUh2eLZCp+5JItD1U6mgLVq2wITRiauilVZ1Ds/pCm5I/aqUukJarxG1siCBjse
 P63jojI20enLafnRlRxc4Kxf1ZZbSI4dkFXFVrCPmi0q2cGnvp+WfqWZqKCq+VqMGxsy
 QpaCHoRC5L5ZgwXZ0qK4LbkSu8b7Louvz4p6dZyOQwqPeLxC+L50NVbsk09Ivdvw6Nkq
 b8qj318uhT7gb46bv/Ki3DRiDkRbrNkUO0mMW0B7zJ5KOmPBLfzvoDdQptKXVnZyjrtu Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn94cxy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 17:58:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 221F1100038;
        Wed, 15 Apr 2020 17:58:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EDDB2AF597;
        Wed, 15 Apr 2020 17:58:46 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 15 Apr 2020 17:58:43
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v2 05/12] mtd: rawnand: stm32_fmc2: remove useless inline comments
Date:   Wed, 15 Apr 2020 17:57:29 +0200
Message-ID: <1586966256-29548-6-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_05:2020-04-14,2020-04-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove inline comments that are useless since function label are
self explanatory.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 40 ----------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 0a96797..ab53314 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -281,7 +281,6 @@ static inline struct stm32_fmc2_nfc *to_stm32_nfc(struct nand_controller *base)
 	return container_of(base, struct stm32_fmc2_nfc, base);
 }
 
-/* Timings configuration */
 static void stm32_fmc2_timings_init(struct nand_chip *chip)
 {
 	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
@@ -313,7 +312,6 @@ static void stm32_fmc2_timings_init(struct nand_chip *chip)
 	writel_relaxed(patt, fmc2->io_base + FMC2_PATT);
 }
 
-/* Controller configuration */
 static void stm32_fmc2_setup(struct nand_chip *chip)
 {
 	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
@@ -341,7 +339,6 @@ static void stm32_fmc2_setup(struct nand_chip *chip)
 	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
 }
 
-/* Select target */
 static int stm32_fmc2_select_chip(struct nand_chip *chip, int chipnr)
 {
 	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
@@ -353,11 +350,7 @@ static int stm32_fmc2_select_chip(struct nand_chip *chip, int chipnr)
 		return 0;
 
 	fmc2->cs_sel = nand->cs_used[chipnr];
-
-	/* FMC2 setup routine */
 	stm32_fmc2_setup(chip);
-
-	/* Apply timings */
 	stm32_fmc2_timings_init(chip);
 
 	if (fmc2->dma_tx_ch && fmc2->dma_rx_ch) {
@@ -407,7 +400,6 @@ static int stm32_fmc2_select_chip(struct nand_chip *chip, int chipnr)
 	return 0;
 }
 
-/* Set bus width to 16-bit or 8-bit */
 static void stm32_fmc2_set_buswidth_16(struct stm32_fmc2_nfc *fmc2, bool set)
 {
 	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
@@ -418,7 +410,6 @@ static void stm32_fmc2_set_buswidth_16(struct stm32_fmc2_nfc *fmc2, bool set)
 	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
 }
 
-/* Enable/disable ECC */
 static void stm32_fmc2_set_ecc(struct stm32_fmc2_nfc *fmc2, bool enable)
 {
 	u32 pcr = readl(fmc2->io_base + FMC2_PCR);
@@ -429,7 +420,6 @@ static void stm32_fmc2_set_ecc(struct stm32_fmc2_nfc *fmc2, bool enable)
 	writel(pcr, fmc2->io_base + FMC2_PCR);
 }
 
-/* Enable irq sources in case of the sequencer is used */
 static inline void stm32_fmc2_enable_seq_irq(struct stm32_fmc2_nfc *fmc2)
 {
 	u32 csqier = readl_relaxed(fmc2->io_base + FMC2_CSQIER);
@@ -441,7 +431,6 @@ static inline void stm32_fmc2_enable_seq_irq(struct stm32_fmc2_nfc *fmc2)
 	writel_relaxed(csqier, fmc2->io_base + FMC2_CSQIER);
 }
 
-/* Disable irq sources in case of the sequencer is used */
 static inline void stm32_fmc2_disable_seq_irq(struct stm32_fmc2_nfc *fmc2)
 {
 	u32 csqier = readl_relaxed(fmc2->io_base + FMC2_CSQIER);
@@ -453,13 +442,11 @@ static inline void stm32_fmc2_disable_seq_irq(struct stm32_fmc2_nfc *fmc2)
 	fmc2->irq_state = FMC2_IRQ_UNKNOWN;
 }
 
-/* Clear irq sources in case of the sequencer is used */
 static inline void stm32_fmc2_clear_seq_irq(struct stm32_fmc2_nfc *fmc2)
 {
 	writel_relaxed(FMC2_CSQICR_CLEAR_IRQ, fmc2->io_base + FMC2_CSQICR);
 }
 
-/* Enable irq sources in case of bch is used */
 static inline void stm32_fmc2_enable_bch_irq(struct stm32_fmc2_nfc *fmc2,
 					     int mode)
 {
@@ -475,7 +462,6 @@ static inline void stm32_fmc2_enable_bch_irq(struct stm32_fmc2_nfc *fmc2,
 	writel_relaxed(bchier, fmc2->io_base + FMC2_BCHIER);
 }
 
-/* Disable irq sources in case of bch is used */
 static inline void stm32_fmc2_disable_bch_irq(struct stm32_fmc2_nfc *fmc2)
 {
 	u32 bchier = readl_relaxed(fmc2->io_base + FMC2_BCHIER);
@@ -488,7 +474,6 @@ static inline void stm32_fmc2_disable_bch_irq(struct stm32_fmc2_nfc *fmc2)
 	fmc2->irq_state = FMC2_IRQ_UNKNOWN;
 }
 
-/* Clear irq sources in case of bch is used */
 static inline void stm32_fmc2_clear_bch_irq(struct stm32_fmc2_nfc *fmc2)
 {
 	writel_relaxed(FMC2_BCHICR_CLEAR_IRQ, fmc2->io_base + FMC2_BCHICR);
@@ -549,10 +534,7 @@ static int stm32_fmc2_ham_calculate(struct nand_chip *chip, const u8 *data,
 	}
 
 	heccr = readl_relaxed(fmc2->io_base + FMC2_HECCR);
-
 	stm32_fmc2_ham_set_ecc(heccr, ecc);
-
-	/* Disable ECC */
 	stm32_fmc2_set_ecc(fmc2, false);
 
 	return 0;
@@ -654,13 +636,11 @@ static int stm32_fmc2_bch_calculate(struct nand_chip *chip, const u8 *data,
 		ecc[12] = bchpbr;
 	}
 
-	/* Disable ECC */
 	stm32_fmc2_set_ecc(fmc2, false);
 
 	return 0;
 }
 
-/* BCH algorithm correction */
 static int stm32_fmc2_bch_decode(int eccsize, u8 *dat, u32 *ecc_sta)
 {
 	u32 bchdsr0 = ecc_sta[0];
@@ -720,7 +700,6 @@ static int stm32_fmc2_bch_correct(struct nand_chip *chip, u8 *dat,
 	ecc_sta[3] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR3);
 	ecc_sta[4] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR4);
 
-	/* Disable ECC */
 	stm32_fmc2_set_ecc(fmc2, false);
 
 	return stm32_fmc2_bch_decode(chip->ecc.size, dat, ecc_sta);
@@ -1054,7 +1033,6 @@ static int stm32_fmc2_sequencer_write_page(struct nand_chip *chip,
 {
 	int ret;
 
-	/* Select the target */
 	ret = stm32_fmc2_select_chip(chip, chip->cur_cs);
 	if (ret)
 		return ret;
@@ -1069,7 +1047,6 @@ static int stm32_fmc2_sequencer_write_page_raw(struct nand_chip *chip,
 {
 	int ret;
 
-	/* Select the target */
 	ret = stm32_fmc2_select_chip(chip, chip->cur_cs);
 	if (ret)
 		return ret;
@@ -1153,7 +1130,6 @@ static int stm32_fmc2_sequencer_read_page(struct nand_chip *chip, u8 *buf,
 	u16 sta_map;
 	int ret;
 
-	/* Select the target */
 	ret = stm32_fmc2_select_chip(chip, chip->cur_cs);
 	if (ret)
 		return ret;
@@ -1199,7 +1175,6 @@ static int stm32_fmc2_sequencer_read_page_raw(struct nand_chip *chip, u8 *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
-	/* Select the target */
 	ret = stm32_fmc2_select_chip(chip, chip->cur_cs);
 	if (ret)
 		return ret;
@@ -1409,7 +1384,6 @@ static int stm32_fmc2_exec_op(struct nand_chip *chip,
 	return ret;
 }
 
-/* Controller initialization */
 static void stm32_fmc2_init(struct stm32_fmc2_nfc *fmc2)
 {
 	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
@@ -1452,7 +1426,6 @@ static void stm32_fmc2_init(struct stm32_fmc2_nfc *fmc2)
 	writel_relaxed(FMC2_PATT_DEFAULT, fmc2->io_base + FMC2_PATT);
 }
 
-/* Controller timings */
 static void stm32_fmc2_calc_timings(struct nand_chip *chip,
 				    const struct nand_sdr_timings *sdrt)
 {
@@ -1596,14 +1569,11 @@ static int stm32_fmc2_setup_interface(struct nand_chip *chip, int chipnr,
 		return 0;
 
 	stm32_fmc2_calc_timings(chip, sdrt);
-
-	/* Apply timings */
 	stm32_fmc2_timings_init(chip);
 
 	return 0;
 }
 
-/* DMA configuration */
 static int stm32_fmc2_dma_setup(struct stm32_fmc2_nfc *fmc2)
 {
 	int ret = 0;
@@ -1667,7 +1637,6 @@ static int stm32_fmc2_dma_setup(struct stm32_fmc2_nfc *fmc2)
 	return ret;
 }
 
-/* NAND callbacks setup */
 static void stm32_fmc2_nand_callbacks_setup(struct nand_chip *chip)
 {
 	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
@@ -1708,7 +1677,6 @@ static void stm32_fmc2_nand_callbacks_setup(struct nand_chip *chip)
 		chip->ecc.bytes = chip->options & NAND_BUSWIDTH_16 ? 8 : 7;
 }
 
-/* FMC2 layout */
 static int stm32_fmc2_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
 					 struct mtd_oob_region *oobregion)
 {
@@ -1744,7 +1712,6 @@ static int stm32_fmc2_nand_ooblayout_free(struct mtd_info *mtd, int section,
 	.free = stm32_fmc2_nand_ooblayout_free,
 };
 
-/* FMC2 caps */
 static int stm32_fmc2_calc_ecc_bytes(int step_size, int strength)
 {
 	/* Hamming */
@@ -1763,7 +1730,6 @@ static int stm32_fmc2_calc_ecc_bytes(int step_size, int strength)
 		     FMC2_ECC_STEP_SIZE,
 		     FMC2_ECC_HAM, FMC2_ECC_BCH4, FMC2_ECC_BCH8);
 
-/* FMC2 controller ops */
 static int stm32_fmc2_attach_chip(struct nand_chip *chip)
 {
 	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
@@ -1797,13 +1763,10 @@ static int stm32_fmc2_attach_chip(struct nand_chip *chip)
 	if (chip->bbt_options & NAND_BBT_USE_FLASH)
 		chip->bbt_options |= NAND_BBT_NO_OOB;
 
-	/* NAND callbacks setup */
 	stm32_fmc2_nand_callbacks_setup(chip);
 
-	/* Define ECC layout */
 	mtd_set_ooblayout(mtd, &stm32_fmc2_nand_ooblayout_ops);
 
-	/* Configure bus width to 16-bit */
 	if (chip->options & NAND_BUSWIDTH_16)
 		stm32_fmc2_set_buswidth_16(fmc2, true);
 
@@ -1816,7 +1779,6 @@ static int stm32_fmc2_attach_chip(struct nand_chip *chip)
 	.setup_data_interface = stm32_fmc2_setup_interface,
 };
 
-/* FMC2 probe */
 static int stm32_fmc2_parse_child(struct stm32_fmc2_nfc *fmc2,
 				  struct device_node *dn)
 {
@@ -1976,12 +1938,10 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 		reset_control_deassert(rstc);
 	}
 
-	/* DMA setup */
 	ret = stm32_fmc2_dma_setup(fmc2);
 	if (ret)
 		goto err_dma_setup;
 
-	/* FMC2 init routine */
 	stm32_fmc2_init(fmc2);
 
 	nand = &fmc2->nand;
-- 
1.9.1

