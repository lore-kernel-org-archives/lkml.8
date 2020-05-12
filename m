Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8977AC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CE720674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgELG6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:58:35 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:53308 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbgELG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:58:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436289|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.118451-0.00916542-0.872384;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.HXGIgNF_1589266705;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HXGIgNF_1589266705)
          by smtp.aliyun-inc.com(10.147.41.143);
          Tue, 12 May 2020 14:58:30 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Subject: [PATCH] mtd: offset align to block size bofore block operation
Date:   Tue, 12 May 2020 14:58:35 +0800
Message-Id: <1589266715-4168-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The off parameter on mtdpsore_block_*() does not align to block size,
which makes some bugs. For example, a block contains dmesg zones
with number 0 to 3. When user remove all these files, mapped to
these zones, mtdpstore is expected to check whether No.0 to No.3 is
unused then erase this block. However it check No.3 to No.6 because
it get wrongly beginning zonenum from misaligned off.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---

This patch bases on series v8 of pstore/blk.
Series Link: https://lore.kernel.org/lkml/20200511233229.27745-1-keescook@chromium.org/

 drivers/mtd/mtdpstore.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 06084eff1004..a4fe6060b960 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -27,7 +27,10 @@ static int mtdpstore_block_isbad(struct mtdpstore_context *cxt, loff_t off)
 {
 	int ret;
 	struct mtd_info *mtd = cxt->mtd;
-	u64 blknum = div_u64(off, mtd->erasesize);
+	u64 blknum;
+
+	off = ALIGN_DOWN(off, mtd->erasesize);
+	blknum = div_u64(off, mtd->erasesize);
 
 	if (test_bit(blknum, cxt->badmap))
 		return true;
@@ -46,8 +49,10 @@ static inline int mtdpstore_panic_block_isbad(struct mtdpstore_context *cxt,
 		loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u64 blknum = div_u64(off, mtd->erasesize);
+	u64 blknum;
 
+	off = ALIGN_DOWN(off, mtd->erasesize);
+	blknum = div_u64(off, mtd->erasesize);
 	return test_bit(blknum, cxt->badmap);
 }
 
@@ -75,9 +80,11 @@ static inline void mtdpstore_block_mark_unused(struct mtdpstore_context *cxt,
 		loff_t off)
 {
 	struct mtd_info *mtd = cxt->mtd;
-	u64 zonenum = div_u64(off, cxt->info.kmsg_size);
-	u32 zonecnt = cxt->mtd->erasesize / cxt->info.kmsg_size;
+	u32 zonecnt = mtd->erasesize / cxt->info.kmsg_size;
+	u64 zonenum;
 
+	off = ALIGN_DOWN(off, mtd->erasesize);
+	zonenum = div_u64(off, cxt->info.kmsg_size);
 	while (zonecnt > 0) {
 		dev_dbg(&mtd->dev, "mark zone %llu unused\n", zonenum);
 		clear_bit(zonenum, cxt->usedmap);
@@ -99,9 +106,12 @@ static inline int mtdpstore_is_used(struct mtdpstore_context *cxt, loff_t off)
 static int mtdpstore_block_is_used(struct mtdpstore_context *cxt,
 		loff_t off)
 {
-	u64 zonenum = div_u64(off, cxt->info.kmsg_size);
-	u32 zonecnt = cxt->mtd->erasesize / cxt->info.kmsg_size;
+	struct mtd_info *mtd = cxt->mtd;
+	u32 zonecnt = mtd->erasesize / cxt->info.kmsg_size;
+	u64 zonenum;
 
+	off = ALIGN_DOWN(off, mtd->erasesize);
+	zonenum = div_u64(off, cxt->info.kmsg_size);
 	while (zonecnt > 0) {
 		if (test_bit(zonenum, cxt->usedmap))
 			return true;
@@ -138,9 +148,12 @@ static void mtdpstore_mark_removed(struct mtdpstore_context *cxt, loff_t off)
 static void mtdpstore_block_clear_removed(struct mtdpstore_context *cxt,
 		loff_t off)
 {
-	u64 zonenum = div_u64(off, cxt->info.kmsg_size);
-	u32 zonecnt = cxt->mtd->erasesize / cxt->info.kmsg_size;
+	struct mtd_info *mtd = cxt->mtd;
+	u32 zonecnt = mtd->erasesize / cxt->info.kmsg_size;
+	u64 zonenum;
 
+	off = ALIGN_DOWN(off, mtd->erasesize);
+	zonenum = div_u64(off, cxt->info.kmsg_size);
 	while (zonecnt > 0) {
 		clear_bit(zonenum, cxt->rmmap);
 		zonenum++;
@@ -151,9 +164,12 @@ static void mtdpstore_block_clear_removed(struct mtdpstore_context *cxt,
 static int mtdpstore_block_is_removed(struct mtdpstore_context *cxt,
 		loff_t off)
 {
-	u64 zonenum = div_u64(off, cxt->info.kmsg_size);
-	u32 zonecnt = cxt->mtd->erasesize / cxt->info.kmsg_size;
+	struct mtd_info *mtd = cxt->mtd;
+	u32 zonecnt = mtd->erasesize / cxt->info.kmsg_size;
+	u64 zonenum;
 
+	off = ALIGN_DOWN(off, mtd->erasesize);
+	zonenum = div_u64(off, cxt->info.kmsg_size);
 	while (zonecnt > 0) {
 		if (test_bit(zonenum, cxt->rmmap))
 			return true;
@@ -169,6 +185,7 @@ static int mtdpstore_erase_do(struct mtdpstore_context *cxt, loff_t off)
 	struct erase_info erase;
 	int ret;
 
+	off = ALIGN_DOWN(off, cxt->mtd->erasesize);
 	dev_dbg(&mtd->dev, "try to erase off 0x%llx\n", off);
 	erase.len = cxt->mtd->erasesize;
 	erase.addr = off;
@@ -205,7 +222,6 @@ static ssize_t mtdpstore_erase(size_t size, loff_t off)
 	}
 
 	/* all zones are unused, erase it */
-	off = ALIGN_DOWN(off, cxt->mtd->erasesize);
 	return mtdpstore_erase_do(cxt, off);
 }
 
@@ -235,7 +251,6 @@ static int mtdpstore_security(struct mtdpstore_context *cxt, loff_t off)
 	}
 
 	/* If there is no any empty zone, we have no way but to do erase */
-	off = ALIGN_DOWN(off, erasesize);
 	while (blkcnt--) {
 		div64_u64_rem(off + erasesize, cxt->mtd->size, (u64 *)&off);
 
-- 
1.9.1

