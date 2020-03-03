Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7481EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA4320726
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgCCHVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:21:51 -0500
Received: from twhmllg3.macronix.com ([211.75.127.131]:31755 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbgCCHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:21:50 -0500
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 0237LRLA023026;
        Tue, 3 Mar 2020 15:21:29 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, allison@lohutok.net,
        linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        rfontana@redhat.com, linux-mtd@lists.infradead.org,
        yuehaibing@huawei.com, s.hauer@pengutronix.de,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 1/4] mtd: rawnand: Add support manufacturer specific lock/unlock operation
Date:   Tue,  3 Mar 2020 15:21:21 +0800
Message-Id: <1583220084-10890-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 0237LRLA023026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nand_lock() & nand_unlock() for manufacturer specific lock & unlock
operation while the device supports Block Portection function.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 36 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/rawnand.h      |  5 +++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f64e3b6..769be81 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4360,6 +4360,38 @@ static void nand_shutdown(struct mtd_info *mtd)
 	nand_suspend(mtd);
 }
 
+/**
+ * nand_lock - [MTD Interface] Lock the NAND flash
+ * @mtd: MTD device structure
+ * @ofs: offset byte address
+ * @len: number of bytes to lock (must be a multiple of block/page size)
+ */
+static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (!chip->lock_area)
+		return -ENOTSUPP;
+
+	return chip->lock_area(chip, ofs, len);
+}
+
+/**
+ * nand_unlock - [MTD Interface] Unlock the NAND flash
+ * @mtd: MTD device structure
+ * @ofs: offset byte address
+ * @len: number of bytes to unlock (must be a multiple of block/page size)
+ */
+static int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (!chip->unlock_area)
+		return -ENOTSUPP;
+
+	return chip->unlock_area(chip, ofs, len);
+}
+
 /* Set default functions */
 static void nand_set_defaults(struct nand_chip *chip)
 {
@@ -5786,8 +5818,8 @@ static int nand_scan_tail(struct nand_chip *chip)
 	mtd->_read_oob = nand_read_oob;
 	mtd->_write_oob = nand_write_oob;
 	mtd->_sync = nand_sync;
-	mtd->_lock = NULL;
-	mtd->_unlock = NULL;
+	mtd->_lock = nand_lock;
+	mtd->_unlock = nand_unlock;
 	mtd->_suspend = nand_suspend;
 	mtd->_resume = nand_resume;
 	mtd->_reboot = nand_shutdown;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4ab9bcc..bc2fa3c 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1077,6 +1077,8 @@ struct nand_legacy {
  * @manufacturer:	[INTERN] Contains manufacturer information
  * @manufacturer.desc:	[INTERN] Contains manufacturer's description
  * @manufacturer.priv:	[INTERN] Contains manufacturer private information
+ * @lock_area:		[REPLACEABLE] specific NAND chip lock operation
+ * @unlock_area:	[REPLACEABLE] specific NAND chip unlock operation
  */
 
 struct nand_chip {
@@ -1136,6 +1138,9 @@ struct nand_chip {
 		const struct nand_manufacturer *desc;
 		void *priv;
 	} manufacturer;
+
+	int (*lock_area)(struct nand_chip *chip, loff_t ofs, uint64_t len);
+	int (*unlock_area)(struct nand_chip *chip, loff_t ofs, uint64_t len);
 };
 
 extern const struct mtd_ooblayout_ops nand_ooblayout_sp_ops;
-- 
1.9.1

