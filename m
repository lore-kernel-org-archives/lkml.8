Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA5C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7407120726
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCCHVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:21:53 -0500
Received: from twhmllg3.macronix.com ([211.75.127.131]:31761 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCCHVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:21:52 -0500
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 0237LRLB023026;
        Tue, 3 Mar 2020 15:21:30 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, allison@lohutok.net,
        linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        rfontana@redhat.com, linux-mtd@lists.infradead.org,
        yuehaibing@huawei.com, s.hauer@pengutronix.de,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 2/4] mtd: rawnand: Add support Macronix Block Protection function
Date:   Tue,  3 Mar 2020 15:21:22 +0800
Message-Id: <1583220084-10890-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 0237LRLB023026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macronix AC/AD series support using SET_FEATURES to change
Block Portection and Unprotection. By GET_FEATURES operation
to detect if block protection support.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 3ff7ce0..a4cd12c 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -11,6 +11,10 @@
 #define MACRONIX_READ_RETRY_BIT BIT(0)
 #define MACRONIX_NUM_READ_RETRY_MODES 6
 
+#define ONFI_FEATURE_ADDR_MXIC_PROTECTION 0xA0
+#define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
+#define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
+
 struct nand_onfi_vendor_macronix {
 	u8 reserved;
 	u8 reliability_func;
@@ -91,6 +95,73 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
 		     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
 }
 
+/*
+ * Macronix NAND supports Block Protection by Protectoin(PT) pin;
+ * active high at power-on which protects the entire chip even the #WP is
+ * disabled. Lock/unlock protection area can be partition according to
+ * protection bits, i.e. upper 1/2 locked, upper 1/4 locked and so on.
+ */
+static int mxic_nand_lock(struct nand_chip *chip, loff_t ofs, uint64_t len)
+{
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
+	int ret;
+
+	feature[0] = MXIC_BLOCK_PROTECTION_ALL_LOCK;
+	nand_select_target(chip, 0);
+	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				feature);
+	nand_deselect_target(chip);
+	if (ret)
+		pr_err("%s all blocks failed\n", __func__);
+
+	return ret;
+}
+
+static int mxic_nand_unlock(struct nand_chip *chip, loff_t ofs, uint64_t len)
+{
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
+	int ret;
+
+	feature[0] = MXIC_BLOCK_PROTECTION_ALL_UNLOCK;
+	nand_select_target(chip, 0);
+	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				feature);
+	nand_deselect_target(chip);
+	if (ret)
+		pr_err("%s all blocks failed\n", __func__);
+
+	return ret;
+}
+
+static void macronix_nand_block_protection_support(struct nand_chip *chip)
+{
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
+	int ret;
+
+	bitmap_set(chip->parameters.get_feature_list,
+		   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
+
+	feature[0] = MXIC_BLOCK_PROTECTION_ALL_UNLOCK;
+	nand_select_target(chip, 0);
+	ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				feature);
+	nand_deselect_target(chip);
+	if (ret || feature[0] != MXIC_BLOCK_PROTECTION_ALL_LOCK) {
+		if (ret)
+			pr_err("Block protection check failed\n");
+
+		bitmap_clear(chip->parameters.get_feature_list,
+			     ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
+		return;
+	}
+
+	bitmap_set(chip->parameters.set_feature_list,
+		   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
+
+	chip->lock_area = mxic_nand_lock;
+	chip->unlock_area = mxic_nand_unlock;
+}
+
 static int macronix_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
@@ -98,6 +169,7 @@ static int macronix_nand_init(struct nand_chip *chip)
 
 	macronix_nand_fix_broken_get_timings(chip);
 	macronix_nand_onfi_init(chip);
+	macronix_nand_block_protection_support(chip);
 
 	return 0;
 }
-- 
1.9.1

