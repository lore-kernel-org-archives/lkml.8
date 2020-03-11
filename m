Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2675C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18C720828
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgCKIjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:39:09 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:38076 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgCKIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:39:09 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 02B8crad025431; Wed, 11 Mar 2020 17:38:53 +0900
X-Iguazu-Qid: 2wHHmtTgkJK7xepRsv
X-Iguazu-QSIG: v=2; s=0; t=1583915933; q=2wHHmtTgkJK7xepRsv; m=CTR+wak4u3Jesv1LiBVCOyGbLEeAwdX18vkpcTjoyac=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id 02B8cpa7009875;
        Wed, 11 Mar 2020 17:38:52 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 02B8cpx0011428;
        Wed, 11 Mar 2020 17:38:51 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 02B8cpsm009597;
        Wed, 11 Mar 2020 17:38:51 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3] mtd: rawnand: toshiba: Support actual bitflips for BENAND (Built-in ECC NAND)
Date:   Wed, 11 Mar 2020 15:19:43 +0900
X-TSB-HOP: ON
Message-Id: <1583907583-5967-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support vendor specific commands for KIOXIA CORPORATION BENAND.
The actual bitflips number can be get by this command.

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
---
changelog[v3]:Tested version.
original patch:"[RFC,v2] mtd: nand: toshiba: Add support for ->exec_op()".

 drivers/mtd/nand/raw/nand_toshiba.c | 55 +++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
index 9c03fbb..10fcfbd 100644
--- a/drivers/mtd/nand/raw/nand_toshiba.c
+++ b/drivers/mtd/nand/raw/nand_toshiba.c
@@ -14,14 +14,65 @@
 /* Recommended to rewrite for BENAND */
 #define TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED	BIT(3)
 
+/* ECC Status Read Command for BENAND */
+#define TOSHIBA_NAND_CMD_ECC_STATUS_READ	0x7A
+
+/* ECC Status Mask for BENAND */
+#define TOSHIBA_NAND_ECC_STATUS_MASK		0x0F
+
+/* Uncorrectable Error for BENAND */
+#define TOSHIBA_NAND_ECC_STATUS_UNCORR		0x0F
+
+static int toshiba_nand_benand_read_eccstatus_op(struct nand_chip *chip,
+						 u8 *buf)
+{
+	u8 *ecc_status = buf;
+
+	if (nand_has_exec_op(chip)) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(TOSHIBA_NAND_CMD_ECC_STATUS_READ,
+				    PSEC_TO_NSEC(sdr->tADL_min)),
+			NAND_OP_8BIT_DATA_IN(chip->ecc.steps, ecc_status, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(chip->cur_cs, instrs);
+
+		return nand_exec_op(chip, &op);
+	}
+
+	return -ENOTSUPP;
+}
+
 static int toshiba_nand_benand_eccstatus(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 	unsigned int max_bitflips = 0;
-	u8 status;
+	u8 status, ecc_status[8];
 
 	/* Check Status */
+	ret = toshiba_nand_benand_read_eccstatus_op(chip, ecc_status);
+	if (!ret) {
+		unsigned int i, bitflips = 0;
+
+		for (i = 0; i < chip->ecc.steps; i++) {
+			bitflips = ecc_status[i] & TOSHIBA_NAND_ECC_STATUS_MASK;
+			if (bitflips == TOSHIBA_NAND_ECC_STATUS_UNCORR) {
+				mtd->ecc_stats.failed++;
+			} else {
+				mtd->ecc_stats.corrected += bitflips;
+				max_bitflips = max(max_bitflips, bitflips);
+			}
+		}
+
+		return max_bitflips;
+	}
+
+	/*
+	 * Fallback to regular status check if
+	 * toshiba_nand_benand_read_eccstatus_op() failed.
+	 */
 	ret = nand_status_op(chip, &status);
 	if (ret)
 		return ret;
@@ -108,7 +159,7 @@ static void toshiba_nand_decode_id(struct nand_chip *chip)
 	 */
 	if (chip->id.len >= 6 && nand_is_slc(chip) &&
 	    (chip->id.data[5] & 0x7) == 0x6 /* 24nm */ &&
-	    !(chip->id.data[4] & 0x80) /* !BENAND */) {
+	    !(chip->id.data[4] & TOSHIBA_NAND_ID4_IS_BENAND) /* !BENAND */) {
 		memorg->oobsize = 32 * memorg->pagesize >> 9;
 		mtd->oobsize = memorg->oobsize;
 	}
-- 
1.9.1

