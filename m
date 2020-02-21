Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D2C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C038F20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgBUN5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:57:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728177AbgBUN5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:57:13 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E0FC9C6B6B8C4734654A;
        Fri, 21 Feb 2020 21:57:10 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Feb 2020
 21:57:00 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubifs: Don't discard nodes in recovery when ecc err detected
Date:   Fri, 21 Feb 2020 22:04:13 +0800
Message-ID: <1582293853-136727-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following process will lead TNC to find no corresponding inode node
(Reproduce method see Link):

  1. Garbage collection.
     1) move valid inode nodes from leb A to leb B
        (The leb number of B has been written as GC type bud node in log)
     2) unmap leb A, and corresponding peb is erased
        (GCed inode nodes exist only on leb B)
  2. Poweroff. A node near the end of the LEB is corrupted before power
     on, which is uncorrectable error of ECC.
  3. Replay and return success.
     1) replay_buds -> bud for leb B is the last GC type record in log
     2) ubifs_recover_leb:
        For SCANNED_A_CORRUPT_NODE error caused by node_B, UBIFS will
        discard node_A ... node_C, such nodes are in the same max_io unit.

               corrupt
                  ↓
        node_A  node_B ... node_C
        XXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXX...   ← Replay GC LEB
        |←   max_write_size    →|
   4. Finding a missing inode node triggers an error, as follows:
      [ 2276.992557] UBIFS error (ubi0:0 pid 2509): ubifs_read_node
      [ubifs]: bad node type (255 but expected 2)
      [ 2276.996814] UBIFS error (ubi0:0 pid 2509): ubifs_read_node
      [ubifs]: bad node at LEB 15:73728, LEB mapping status 0
      [ 2276.998439] Not a node, first 24 bytes:
      [ 2276.998442] 00000000: ff ff ff ff ff ff ff ff ff ff ff ff

Fix this by returning fail when scan bad data with ecc error detected in
ubifs_recover_leb(). This reduces the fault tolerance of the file system.
In the case of pad node ecc error at the end of LEB without affecting the
file system data, it also returns fail, but the probability is very low.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <Stable@vger.kernel.org>
Fixes: 1e51764a3c2ac05a23a22b2a95 ("UBIFS: add new flash file system")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206625
---
 fs/ubifs/recovery.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index f116f7b3f9e5..e60f23ea4575 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -624,14 +624,28 @@ struct ubifs_scan_leb *ubifs_recover_leb(struct ubifs_info *c, int lnum,
 {
 	int ret = 0, err, len = c->leb_size - offs, start = offs, min_io_unit;
 	int grouped = jhead == -1 ? 0 : c->jheads[jhead].grouped;
+	int ecc_err = 0;
 	struct ubifs_scan_leb *sleb;
 	void *buf = sbuf + offs;
 
 	dbg_rcvry("%d:%d, jhead %d, grouped %d", lnum, offs, jhead, grouped);
 
-	sleb = ubifs_start_scan(c, lnum, offs, sbuf);
-	if (IS_ERR(sleb))
-		return sleb;
+	sleb = kzalloc(sizeof(struct ubifs_scan_leb), GFP_NOFS);
+	if (!sleb)
+		return ERR_PTR(-ENOMEM);
+
+	sleb->lnum = lnum;
+	INIT_LIST_HEAD(&sleb->nodes);
+	sleb->buf = sbuf;
+
+	err = ubifs_leb_read(c, lnum, sbuf + offs, offs, c->leb_size - offs, 0);
+	if (err && err != -EBADMSG) {
+		ubifs_err(c, "cannot read %d bytes from LEB %d:%d, error %d",
+			  c->leb_size - offs, lnum, offs, err);
+		kfree(sleb);
+		return ERR_PTR(err);
+	} else if (err == -EBADMSG)
+		ecc_err = 1;
 
 	ubifs_assert(c, len >= 8);
 	while (len >= 8) {
@@ -677,10 +691,24 @@ struct ubifs_scan_leb *ubifs_recover_leb(struct ubifs_info *c, int lnum,
 	}
 
 	if (ret == SCANNED_GARBAGE || ret == SCANNED_A_BAD_PAD_NODE) {
-		if (!is_last_write(c, buf, offs))
+		/*
+		 * If the garbage area or bad pad node is caused by ecc
+		 * error, skipping valid nodes in the aligned max write
+		 * size unit will lead tnc to mismatch node (inode,
+		 * data, etc.). But if the ecc error infects only a pad
+		 * node, which doesn't corrupt data nodes on UBIFS, still
+		 * failed. We choose robustness here at the cost of
+		 * giving up tolerating some small probability mistakes.
+		 */
+		if (!is_last_write(c, buf, offs) || ecc_err)
 			goto corrupted_rescan;
 	} else if (ret == SCANNED_A_CORRUPT_NODE) {
-		if (!no_more_nodes(c, buf, len, lnum, offs))
+		/*
+		 * If the corrupt node is caused by ecc error, skipping
+		 * valid nodes in the aligned max write size unit will
+		 * lead tnc to mismatch node (inode, data, etc.).
+		 */
+		if (!no_more_nodes(c, buf, len, lnum, offs) || ecc_err)
 			goto corrupted_rescan;
 	} else if (!is_empty(buf, len)) {
 		if (!is_last_write(c, buf, offs)) {
@@ -782,7 +810,8 @@ struct ubifs_scan_leb *ubifs_recover_leb(struct ubifs_info *c, int lnum,
 	ubifs_scanned_corruption(c, lnum, offs, buf);
 	err = -EUCLEAN;
 error:
-	ubifs_err(c, "LEB %d scanning failed", lnum);
+	ubifs_err(c, "LEB %d scanning failed%s", lnum,
+		  ecc_err ? ", ecc error detected!" : "");
 	ubifs_scan_destroy(sleb);
 	return ERR_PTR(err);
 }
-- 
2.7.4

