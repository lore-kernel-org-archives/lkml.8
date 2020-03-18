Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D33C5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2386D20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCRHms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:42:48 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:57395 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:42:47 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 02I7gTOB041137;
        Wed, 18 Mar 2020 15:42:31 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, allison@lohutok.net,
        linux-mtd@lists.infradead.org, yuehaibing@huawei.com,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 2/2] mtd: rawnand: macronix: Add support for deep power down mode
Date:   Wed, 18 Mar 2020 15:42:28 +0800
Message-Id: <1584517348-14486-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584517348-14486-1-git-send-email-masonccyang@mxic.com.tw>
References: <1584517348-14486-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 02I7gTOB041137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macronix AD series support deep power down mode for a minimum
power consumption state.

Overload nand_suspend() & nand_resume() in Macronix specific code to
support deep power down mode.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 3ff7ce0..756c175 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -6,11 +6,14 @@
  * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
  */
 
+#include "linux/delay.h"
 #include "internals.h"
 
 #define MACRONIX_READ_RETRY_BIT BIT(0)
 #define MACRONIX_NUM_READ_RETRY_MODES 6
 
+#define MXIC_CMD_POWER_DOWN 0xB9
+
 struct nand_onfi_vendor_macronix {
 	u8 reserved;
 	u8 reliability_func;
@@ -91,6 +94,76 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
 		     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
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
+	chip->suspend = mxic_nand_suspend;
+	chip->resume = mxic_nand_resume;
+}
+
 static int macronix_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
@@ -98,6 +171,7 @@ static int macronix_nand_init(struct nand_chip *chip)
 
 	macronix_nand_fix_broken_get_timings(chip);
 	macronix_nand_onfi_init(chip);
+	macronix_nand_deep_power_down_support(chip);
 
 	return 0;
 }
-- 
1.9.1

