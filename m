Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1184AC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BC320747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="krDxiVt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgELLtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:49:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21818 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729294AbgELLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:49:11 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CBm5db028469;
        Tue, 12 May 2020 13:48:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=MqtOlI3c//0YkPp+LdIJZhaPvay85GkbS9KLzFX5RU4=;
 b=krDxiVt1V1yj1k8D/W6LBkY+bjd/kjNDooMXsnVkaU1nRiaE3SpXX8EP+aeSrjcc+4z+
 ymI06rqZspiYGYYv1OgWgOf1VIoH3A1yHtv0EyPJgeiN6iRB8YuAWysRx3wERquF72RH
 EvICJji7x+N6NOB7Mq215pMovrtUIoWS2pig22bWkAm0T8nerloh/uV3U2EfcOUoSUYt
 HC0hZ3RtSAA6HDl9CoVdiywAd+Su5M4XZf8635MzyxdG/uJHPSdKp6SY6kMwcKehhasf
 gp+YLQlbZfDDWhi5mTbIwi1LoLvlDTLyIYY8LdWAjY5+FQ5hzYzaCqOO4biG+sXu3+xU 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30whn9g69y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 13:48:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C314100034;
        Tue, 12 May 2020 13:48:49 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 502FA2BAE77;
        Tue, 12 May 2020 13:48:49 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 12 May 2020 13:48:47
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v5 2/2] mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros
Date:   Tue, 12 May 2020 13:47:48 +0200
Message-ID: <1589284068-4079-3-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589284068-4079-1-git-send-email-christophe.kerello@st.com>
References: <1589284068-4079-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_03:2020-05-11,2020-05-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes custom macros and uses FIELD_PREP and FIELD_GET macros.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v5:
 - rebase on top of nand/next
Changes in v3:
 - add Miquel reviewed-by tag

 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 177 ++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 92 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 901ebd8..8f02d5e 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -4,6 +4,7 @@
  * Author: Christophe Kerello <christophe.kerello@st.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -84,20 +85,16 @@
 /* Register: FMC2_PCR */
 #define FMC2_PCR_PWAITEN		BIT(1)
 #define FMC2_PCR_PBKEN			BIT(2)
-#define FMC2_PCR_PWID_MASK		GENMASK(5, 4)
-#define FMC2_PCR_PWID(x)		(((x) & 0x3) << 4)
+#define FMC2_PCR_PWID			GENMASK(5, 4)
 #define FMC2_PCR_PWID_BUSWIDTH_8	0
 #define FMC2_PCR_PWID_BUSWIDTH_16	1
 #define FMC2_PCR_ECCEN			BIT(6)
 #define FMC2_PCR_ECCALG			BIT(8)
-#define FMC2_PCR_TCLR_MASK		GENMASK(12, 9)
-#define FMC2_PCR_TCLR(x)		(((x) & 0xf) << 9)
+#define FMC2_PCR_TCLR			GENMASK(12, 9)
 #define FMC2_PCR_TCLR_DEFAULT		0xf
-#define FMC2_PCR_TAR_MASK		GENMASK(16, 13)
-#define FMC2_PCR_TAR(x)			(((x) & 0xf) << 13)
+#define FMC2_PCR_TAR			GENMASK(16, 13)
 #define FMC2_PCR_TAR_DEFAULT		0xf
-#define FMC2_PCR_ECCSS_MASK		GENMASK(19, 17)
-#define FMC2_PCR_ECCSS(x)		(((x) & 0x7) << 17)
+#define FMC2_PCR_ECCSS			GENMASK(19, 17)
 #define FMC2_PCR_ECCSS_512		1
 #define FMC2_PCR_ECCSS_2048		3
 #define FMC2_PCR_BCHECC			BIT(24)
@@ -107,17 +104,17 @@
 #define FMC2_SR_NWRF			BIT(6)
 
 /* Register: FMC2_PMEM */
-#define FMC2_PMEM_MEMSET(x)		(((x) & 0xff) << 0)
-#define FMC2_PMEM_MEMWAIT(x)		(((x) & 0xff) << 8)
-#define FMC2_PMEM_MEMHOLD(x)		(((x) & 0xff) << 16)
-#define FMC2_PMEM_MEMHIZ(x)		(((x) & 0xff) << 24)
+#define FMC2_PMEM_MEMSET		GENMASK(7, 0)
+#define FMC2_PMEM_MEMWAIT		GENMASK(15, 8)
+#define FMC2_PMEM_MEMHOLD		GENMASK(23, 16)
+#define FMC2_PMEM_MEMHIZ		GENMASK(31, 24)
 #define FMC2_PMEM_DEFAULT		0x0a0a0a0a
 
 /* Register: FMC2_PATT */
-#define FMC2_PATT_ATTSET(x)		(((x) & 0xff) << 0)
-#define FMC2_PATT_ATTWAIT(x)		(((x) & 0xff) << 8)
-#define FMC2_PATT_ATTHOLD(x)		(((x) & 0xff) << 16)
-#define FMC2_PATT_ATTHIZ(x)		(((x) & 0xff) << 24)
+#define FMC2_PATT_ATTSET		GENMASK(7, 0)
+#define FMC2_PATT_ATTWAIT		GENMASK(15, 8)
+#define FMC2_PATT_ATTHOLD		GENMASK(23, 16)
+#define FMC2_PATT_ATTHIZ		GENMASK(31, 24)
 #define FMC2_PATT_DEFAULT		0x0a0a0a0a
 
 /* Register: FMC2_ISR */
@@ -132,9 +129,9 @@
 /* Register: FMC2_CSQCFGR1 */
 #define FMC2_CSQCFGR1_CMD2EN		BIT(1)
 #define FMC2_CSQCFGR1_DMADEN		BIT(2)
-#define FMC2_CSQCFGR1_ACYNBR(x)		(((x) & 0x7) << 4)
-#define FMC2_CSQCFGR1_CMD1(x)		(((x) & 0xff) << 8)
-#define FMC2_CSQCFGR1_CMD2(x)		(((x) & 0xff) << 16)
+#define FMC2_CSQCFGR1_ACYNBR		GENMASK(6, 4)
+#define FMC2_CSQCFGR1_CMD1		GENMASK(15, 8)
+#define FMC2_CSQCFGR1_CMD2		GENMASK(23, 16)
 #define FMC2_CSQCFGR1_CMD1T		BIT(24)
 #define FMC2_CSQCFGR1_CMD2T		BIT(25)
 
@@ -142,13 +139,13 @@
 #define FMC2_CSQCFGR2_SQSDTEN		BIT(0)
 #define FMC2_CSQCFGR2_RCMD2EN		BIT(1)
 #define FMC2_CSQCFGR2_DMASEN		BIT(2)
-#define FMC2_CSQCFGR2_RCMD1(x)		(((x) & 0xff) << 8)
-#define FMC2_CSQCFGR2_RCMD2(x)		(((x) & 0xff) << 16)
+#define FMC2_CSQCFGR2_RCMD1		GENMASK(15, 8)
+#define FMC2_CSQCFGR2_RCMD2		GENMASK(23, 16)
 #define FMC2_CSQCFGR2_RCMD1T		BIT(24)
 #define FMC2_CSQCFGR2_RCMD2T		BIT(25)
 
 /* Register: FMC2_CSQCFGR3 */
-#define FMC2_CSQCFGR3_SNBR(x)		(((x) & 0x1f) << 8)
+#define FMC2_CSQCFGR3_SNBR		GENMASK(13, 8)
 #define FMC2_CSQCFGR3_AC1T		BIT(16)
 #define FMC2_CSQCFGR3_AC2T		BIT(17)
 #define FMC2_CSQCFGR3_AC3T		BIT(18)
@@ -159,15 +156,15 @@
 #define FMC2_CSQCFGR3_RAC2T		BIT(23)
 
 /* Register: FMC2_CSQCAR1 */
-#define FMC2_CSQCAR1_ADDC1(x)		(((x) & 0xff) << 0)
-#define FMC2_CSQCAR1_ADDC2(x)		(((x) & 0xff) << 8)
-#define FMC2_CSQCAR1_ADDC3(x)		(((x) & 0xff) << 16)
-#define FMC2_CSQCAR1_ADDC4(x)		(((x) & 0xff) << 24)
+#define FMC2_CSQCAR1_ADDC1		GENMASK(7, 0)
+#define FMC2_CSQCAR1_ADDC2		GENMASK(15, 8)
+#define FMC2_CSQCAR1_ADDC3		GENMASK(23, 16)
+#define FMC2_CSQCAR1_ADDC4		GENMASK(31, 24)
 
 /* Register: FMC2_CSQCAR2 */
-#define FMC2_CSQCAR2_ADDC5(x)		(((x) & 0xff) << 0)
-#define FMC2_CSQCAR2_NANDCEN(x)		(((x) & 0x3) << 10)
-#define FMC2_CSQCAR2_SAO(x)		(((x) & 0xffff) << 16)
+#define FMC2_CSQCAR2_ADDC5		GENMASK(7, 0)
+#define FMC2_CSQCAR2_NANDCEN		GENMASK(11, 10)
+#define FMC2_CSQCAR2_SAO		GENMASK(31, 16)
 
 /* Register: FMC2_CSQIER */
 #define FMC2_CSQIER_TCIE		BIT(0)
@@ -188,28 +185,23 @@
 /* Register: FMC2_BCHDSR0 */
 #define FMC2_BCHDSR0_DUE		BIT(0)
 #define FMC2_BCHDSR0_DEF		BIT(1)
-#define FMC2_BCHDSR0_DEN_MASK		GENMASK(7, 4)
-#define FMC2_BCHDSR0_DEN_SHIFT		4
+#define FMC2_BCHDSR0_DEN		GENMASK(7, 4)
 
 /* Register: FMC2_BCHDSR1 */
-#define FMC2_BCHDSR1_EBP1_MASK		GENMASK(12, 0)
-#define FMC2_BCHDSR1_EBP2_MASK		GENMASK(28, 16)
-#define FMC2_BCHDSR1_EBP2_SHIFT		16
+#define FMC2_BCHDSR1_EBP1		GENMASK(12, 0)
+#define FMC2_BCHDSR1_EBP2		GENMASK(28, 16)
 
 /* Register: FMC2_BCHDSR2 */
-#define FMC2_BCHDSR2_EBP3_MASK		GENMASK(12, 0)
-#define FMC2_BCHDSR2_EBP4_MASK		GENMASK(28, 16)
-#define FMC2_BCHDSR2_EBP4_SHIFT		16
+#define FMC2_BCHDSR2_EBP3		GENMASK(12, 0)
+#define FMC2_BCHDSR2_EBP4		GENMASK(28, 16)
 
 /* Register: FMC2_BCHDSR3 */
-#define FMC2_BCHDSR3_EBP5_MASK		GENMASK(12, 0)
-#define FMC2_BCHDSR3_EBP6_MASK		GENMASK(28, 16)
-#define FMC2_BCHDSR3_EBP6_SHIFT		16
+#define FMC2_BCHDSR3_EBP5		GENMASK(12, 0)
+#define FMC2_BCHDSR3_EBP6		GENMASK(28, 16)
 
 /* Register: FMC2_BCHDSR4 */
-#define FMC2_BCHDSR4_EBP7_MASK		GENMASK(12, 0)
-#define FMC2_BCHDSR4_EBP8_MASK		GENMASK(28, 16)
-#define FMC2_BCHDSR4_EBP8_SHIFT		16
+#define FMC2_BCHDSR4_EBP7		GENMASK(12, 0)
+#define FMC2_BCHDSR4_EBP8		GENMASK(28, 16)
 
 enum stm32_fmc2_ecc {
 	FMC2_ECC_HAM = 1,
@@ -289,22 +281,22 @@ static void stm32_fmc2_nfc_timings_init(struct nand_chip *chip)
 	u32 pmem, patt;
 
 	/* Set tclr/tar timings */
-	pcr &= ~FMC2_PCR_TCLR_MASK;
-	pcr |= FMC2_PCR_TCLR(timings->tclr);
-	pcr &= ~FMC2_PCR_TAR_MASK;
-	pcr |= FMC2_PCR_TAR(timings->tar);
+	pcr &= ~FMC2_PCR_TCLR;
+	pcr |= FIELD_PREP(FMC2_PCR_TCLR, timings->tclr);
+	pcr &= ~FMC2_PCR_TAR;
+	pcr |= FIELD_PREP(FMC2_PCR_TAR, timings->tar);
 
 	/* Set tset/twait/thold/thiz timings in common bank */
-	pmem = FMC2_PMEM_MEMSET(timings->tset_mem);
-	pmem |= FMC2_PMEM_MEMWAIT(timings->twait);
-	pmem |= FMC2_PMEM_MEMHOLD(timings->thold_mem);
-	pmem |= FMC2_PMEM_MEMHIZ(timings->thiz);
+	pmem = FIELD_PREP(FMC2_PMEM_MEMSET, timings->tset_mem);
+	pmem |= FIELD_PREP(FMC2_PMEM_MEMWAIT, timings->twait);
+	pmem |= FIELD_PREP(FMC2_PMEM_MEMHOLD, timings->thold_mem);
+	pmem |= FIELD_PREP(FMC2_PMEM_MEMHIZ, timings->thiz);
 
 	/* Set tset/twait/thold/thiz timings in attribut bank */
-	patt = FMC2_PATT_ATTSET(timings->tset_att);
-	patt |= FMC2_PATT_ATTWAIT(timings->twait);
-	patt |= FMC2_PATT_ATTHOLD(timings->thold_att);
-	patt |= FMC2_PATT_ATTHIZ(timings->thiz);
+	patt = FIELD_PREP(FMC2_PATT_ATTSET, timings->tset_att);
+	patt |= FIELD_PREP(FMC2_PATT_ATTWAIT, timings->twait);
+	patt |= FIELD_PREP(FMC2_PATT_ATTHOLD, timings->thold_att);
+	patt |= FIELD_PREP(FMC2_PATT_ATTHIZ, timings->thiz);
 
 	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
 	writel_relaxed(pmem, nfc->io_base + FMC2_PMEM);
@@ -327,13 +319,13 @@ static void stm32_fmc2_nfc_setup(struct nand_chip *chip)
 	}
 
 	/* Set buswidth */
-	pcr &= ~FMC2_PCR_PWID_MASK;
+	pcr &= ~FMC2_PCR_PWID;
 	if (chip->options & NAND_BUSWIDTH_16)
-		pcr |= FMC2_PCR_PWID(FMC2_PCR_PWID_BUSWIDTH_16);
+		pcr |= FIELD_PREP(FMC2_PCR_PWID, FMC2_PCR_PWID_BUSWIDTH_16);
 
 	/* Set ECC sector size */
-	pcr &= ~FMC2_PCR_ECCSS_MASK;
-	pcr |= FMC2_PCR_ECCSS(FMC2_PCR_ECCSS_512);
+	pcr &= ~FMC2_PCR_ECCSS;
+	pcr |= FIELD_PREP(FMC2_PCR_ECCSS, FMC2_PCR_ECCSS_512);
 
 	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
 }
@@ -403,9 +395,9 @@ static void stm32_fmc2_nfc_set_buswidth_16(struct stm32_fmc2_nfc *nfc, bool set)
 {
 	u32 pcr = readl_relaxed(nfc->io_base + FMC2_PCR);
 
-	pcr &= ~FMC2_PCR_PWID_MASK;
+	pcr &= ~FMC2_PCR_PWID;
 	if (set)
-		pcr |= FMC2_PCR_PWID(FMC2_PCR_PWID_BUSWIDTH_16);
+		pcr |= FIELD_PREP(FMC2_PCR_PWID, FMC2_PCR_PWID_BUSWIDTH_16);
 	writel_relaxed(pcr, nfc->io_base + FMC2_PCR);
 }
 
@@ -659,16 +651,16 @@ static int stm32_fmc2_nfc_bch_decode(int eccsize, u8 *dat, u32 *ecc_sta)
 	if (unlikely(bchdsr0 & FMC2_BCHDSR0_DUE))
 		return -EBADMSG;
 
-	pos[0] = bchdsr1 & FMC2_BCHDSR1_EBP1_MASK;
-	pos[1] = (bchdsr1 & FMC2_BCHDSR1_EBP2_MASK) >> FMC2_BCHDSR1_EBP2_SHIFT;
-	pos[2] = bchdsr2 & FMC2_BCHDSR2_EBP3_MASK;
-	pos[3] = (bchdsr2 & FMC2_BCHDSR2_EBP4_MASK) >> FMC2_BCHDSR2_EBP4_SHIFT;
-	pos[4] = bchdsr3 & FMC2_BCHDSR3_EBP5_MASK;
-	pos[5] = (bchdsr3 & FMC2_BCHDSR3_EBP6_MASK) >> FMC2_BCHDSR3_EBP6_SHIFT;
-	pos[6] = bchdsr4 & FMC2_BCHDSR4_EBP7_MASK;
-	pos[7] = (bchdsr4 & FMC2_BCHDSR4_EBP8_MASK) >> FMC2_BCHDSR4_EBP8_SHIFT;
+	pos[0] = FIELD_GET(FMC2_BCHDSR1_EBP1, bchdsr1);
+	pos[1] = FIELD_GET(FMC2_BCHDSR1_EBP2, bchdsr1);
+	pos[2] = FIELD_GET(FMC2_BCHDSR2_EBP3, bchdsr2);
+	pos[3] = FIELD_GET(FMC2_BCHDSR2_EBP4, bchdsr2);
+	pos[4] = FIELD_GET(FMC2_BCHDSR3_EBP5, bchdsr3);
+	pos[5] = FIELD_GET(FMC2_BCHDSR3_EBP6, bchdsr3);
+	pos[6] = FIELD_GET(FMC2_BCHDSR4_EBP7, bchdsr4);
+	pos[7] = FIELD_GET(FMC2_BCHDSR4_EBP8, bchdsr4);
 
-	den = (bchdsr0 & FMC2_BCHDSR0_DEN_MASK) >> FMC2_BCHDSR0_DEN_SHIFT;
+	den = FIELD_GET(FMC2_BCHDSR0_DEN, bchdsr0);
 	for (i = 0; i < den; i++) {
 		if (pos[i] < eccsize * 8) {
 			change_bit(pos[i], (unsigned long *)dat);
@@ -790,11 +782,11 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 	 */
 	csqcfgr1 = FMC2_CSQCFGR1_DMADEN | FMC2_CSQCFGR1_CMD1T;
 	if (write_data)
-		csqcfgr1 |= FMC2_CSQCFGR1_CMD1(NAND_CMD_SEQIN);
+		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_CMD1, NAND_CMD_SEQIN);
 	else
-		csqcfgr1 |= FMC2_CSQCFGR1_CMD1(NAND_CMD_READ0) |
+		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_CMD1, NAND_CMD_READ0) |
 			    FMC2_CSQCFGR1_CMD2EN |
-			    FMC2_CSQCFGR1_CMD2(NAND_CMD_READSTART) |
+			    FIELD_PREP(FMC2_CSQCFGR1_CMD2, NAND_CMD_READSTART) |
 			    FMC2_CSQCFGR1_CMD2T;
 
 	/*
@@ -804,11 +796,12 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 	 * - Set timings
 	 */
 	if (write_data)
-		csqcfgr2 = FMC2_CSQCFGR2_RCMD1(NAND_CMD_RNDIN);
+		csqcfgr2 = FIELD_PREP(FMC2_CSQCFGR2_RCMD1, NAND_CMD_RNDIN);
 	else
-		csqcfgr2 = FMC2_CSQCFGR2_RCMD1(NAND_CMD_RNDOUT) |
+		csqcfgr2 = FIELD_PREP(FMC2_CSQCFGR2_RCMD1, NAND_CMD_RNDOUT) |
 			   FMC2_CSQCFGR2_RCMD2EN |
-			   FMC2_CSQCFGR2_RCMD2(NAND_CMD_RNDOUTSTART) |
+			   FIELD_PREP(FMC2_CSQCFGR2_RCMD2,
+				      NAND_CMD_RNDOUTSTART) |
 			   FMC2_CSQCFGR2_RCMD1T |
 			   FMC2_CSQCFGR2_RCMD2T;
 	if (!raw) {
@@ -820,7 +813,7 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 	 * - Set the number of sectors to be written
 	 * - Set timings
 	 */
-	csqcfgr3 = FMC2_CSQCFGR3_SNBR(chip->ecc.steps - 1);
+	csqcfgr3 = FIELD_PREP(FMC2_CSQCFGR3_SNBR, chip->ecc.steps - 1);
 	if (write_data) {
 		csqcfgr3 |= FMC2_CSQCFGR3_RAC2T;
 		if (chip->options & NAND_ROW_ADDR_3)
@@ -834,8 +827,8 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 	 * Byte 1 and byte 2 => column, we start at 0x0
 	 * Byte 3 and byte 4 => page
 	 */
-	csqar1 = FMC2_CSQCAR1_ADDC3(page);
-	csqar1 |= FMC2_CSQCAR1_ADDC4(page >> 8);
+	csqar1 = FIELD_PREP(FMC2_CSQCAR1_ADDC3, page);
+	csqar1 |= FIELD_PREP(FMC2_CSQCAR1_ADDC4, page >> 8);
 
 	/*
 	 * - Set chip enable number
@@ -843,16 +836,16 @@ static void stm32_fmc2_nfc_rw_page_init(struct nand_chip *chip, int page,
 	 * - Calculate the number of address cycles to be issued
 	 * - Set byte 5 of address cycle if needed
 	 */
-	csqar2 = FMC2_CSQCAR2_NANDCEN(nfc->cs_sel);
+	csqar2 = FIELD_PREP(FMC2_CSQCAR2_NANDCEN, nfc->cs_sel);
 	if (chip->options & NAND_BUSWIDTH_16)
-		csqar2 |= FMC2_CSQCAR2_SAO(ecc_offset >> 1);
+		csqar2 |= FIELD_PREP(FMC2_CSQCAR2_SAO, ecc_offset >> 1);
 	else
-		csqar2 |= FMC2_CSQCAR2_SAO(ecc_offset);
+		csqar2 |= FIELD_PREP(FMC2_CSQCAR2_SAO, ecc_offset);
 	if (chip->options & NAND_ROW_ADDR_3) {
-		csqcfgr1 |= FMC2_CSQCFGR1_ACYNBR(5);
-		csqar2 |= FMC2_CSQCAR2_ADDC5(page >> 16);
+		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_ACYNBR, 5);
+		csqar2 |= FIELD_PREP(FMC2_CSQCAR2_ADDC5, page >> 16);
 	} else {
-		csqcfgr1 |= FMC2_CSQCFGR1_ACYNBR(4);
+		csqcfgr1 |= FIELD_PREP(FMC2_CSQCFGR1_ACYNBR, 4);
 	}
 
 	writel_relaxed(csqcfgr1, nfc->io_base + FMC2_CSQCFGR1);
@@ -1393,7 +1386,7 @@ static void stm32_fmc2_nfc_init(struct stm32_fmc2_nfc *nfc)
 	pcr |= FMC2_PCR_PBKEN;
 
 	/* Set buswidth to 8 bits mode for identification */
-	pcr &= ~FMC2_PCR_PWID_MASK;
+	pcr &= ~FMC2_PCR_PWID;
 
 	/* ECC logic is disabled */
 	pcr &= ~FMC2_PCR_ECCEN;
@@ -1404,14 +1397,14 @@ static void stm32_fmc2_nfc_init(struct stm32_fmc2_nfc *nfc)
 	pcr &= ~FMC2_PCR_WEN;
 
 	/* Set default ECC sector size */
-	pcr &= ~FMC2_PCR_ECCSS_MASK;
-	pcr |= FMC2_PCR_ECCSS(FMC2_PCR_ECCSS_2048);
+	pcr &= ~FMC2_PCR_ECCSS;
+	pcr |= FIELD_PREP(FMC2_PCR_ECCSS, FMC2_PCR_ECCSS_2048);
 
 	/* Set default tclr/tar timings */
-	pcr &= ~FMC2_PCR_TCLR_MASK;
-	pcr |= FMC2_PCR_TCLR(FMC2_PCR_TCLR_DEFAULT);
-	pcr &= ~FMC2_PCR_TAR_MASK;
-	pcr |= FMC2_PCR_TAR(FMC2_PCR_TAR_DEFAULT);
+	pcr &= ~FMC2_PCR_TCLR;
+	pcr |= FIELD_PREP(FMC2_PCR_TCLR, FMC2_PCR_TCLR_DEFAULT);
+	pcr &= ~FMC2_PCR_TAR;
+	pcr |= FIELD_PREP(FMC2_PCR_TAR, FMC2_PCR_TAR_DEFAULT);
 
 	/* Enable FMC2 controller */
 	bcr1 |= FMC2_BCR1_FMC2EN;
-- 
1.9.1

