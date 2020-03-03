Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFEFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579FF20726
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCCHV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:21:58 -0500
Received: from twhmllg3.macronix.com ([211.75.127.131]:31787 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgCCHV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:21:57 -0500
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 0237LRLD023026;
        Tue, 3 Mar 2020 15:21:32 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, allison@lohutok.net,
        linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        rfontana@redhat.com, linux-mtd@lists.infradead.org,
        yuehaibing@huawei.com, s.hauer@pengutronix.de,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 4/4] mtd: rawnand: Add support Macronix deep power down mode
Date:   Tue,  3 Mar 2020 15:21:24 +0800
Message-Id: <1583220084-10890-5-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 0237LRLD023026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macronix AD series support deep power down mode for a minimum
power consumption state.

Patch nand_suspend() & nand_resume() by Macronix specific deep
power down mode command and exit it.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index a4cd12c..ca46ec1 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -6,6 +6,7 @@
  * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
  */
 
+#include "linux/delay.h"
 #include "internals.h"
 
 #define MACRONIX_READ_RETRY_BIT BIT(0)
@@ -15,6 +16,8 @@
 #define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
 #define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
 
+#define MXIC_CMD_POWER_DOWN 0xB9
+
 struct nand_onfi_vendor_macronix {
 	u8 reserved;
 	u8 reliability_func;
@@ -162,6 +165,76 @@ static void macronix_nand_block_protection_support(struct nand_chip *chip)
 	chip->unlock_area = mxic_nand_unlock;
 }
 
+static int nand_power_down_op(struct nand_chip *chip)
+{
+	int ret;
+
+	if (nand_has_exec_op(chip)) {
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(MXIC_CMD_POWER_DOWN, 0),
+		};
+
+		struct nand_operation op = NAND_OPERATION(chip->cur_cs, instrs);
+
+		ret = nand_exec_op(chip, &op);
+		if (ret)
+			return ret;
+
+	} else {
+		chip->legacy.cmdfunc(chip, MXIC_CMD_POWER_DOWN, -1, -1);
+	}
+
+	return 0;
+}
+
+static int mxic_nand_suspend(struct nand_chip *chip)
+{
+	int ret;
+
+	nand_select_target(chip, 0);
+	ret = nand_power_down_op(chip);
+	if (ret < 0)
+		pr_err("Suspending MXIC NAND chip failed (%d)\n", ret);
+	nand_deselect_target(chip);
+
+	return ret;
+}
+
+static void mxic_nand_resume(struct nand_chip *chip)
+{
+	/*
+	 * Toggle #CS pin to resume NAND device and don't care
+	 * of the others CLE, #WE, #RE pins status.
+	 * A NAND controller ensure it is able to assert/de-assert #CS
+	 * by sending any byte over the NAND bus.
+	 * i.e.,
+	 * NAND power down command or reset command w/o R/B# status checking.
+	 */
+	nand_select_target(chip, 0);
+	nand_power_down_op(chip);
+	/* The minimum of a recovery time tRDP is 35 us */
+	usleep_range(35, 100);
+	nand_deselect_target(chip);
+}
+
+static void macronix_nand_deep_power_down_support(struct nand_chip *chip)
+{
+	int i;
+	static const char * const deep_power_down_dev[] = {
+		"MX30UF1G28AD",
+		"MX30UF2G28AD",
+		"MX30UF4G28AD",
+	};
+
+	i = match_string(deep_power_down_dev, ARRAY_SIZE(deep_power_down_dev),
+			 chip->parameters.model);
+	if (i < 0)
+		return;
+
+	chip->_suspend = mxic_nand_suspend;
+	chip->_resume = mxic_nand_resume;
+}
+
 static int macronix_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
@@ -170,6 +243,7 @@ static int macronix_nand_init(struct nand_chip *chip)
 	macronix_nand_fix_broken_get_timings(chip);
 	macronix_nand_onfi_init(chip);
 	macronix_nand_block_protection_support(chip);
+	macronix_nand_deep_power_down_support(chip);
 
 	return 0;
 }
-- 
1.9.1

