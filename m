Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B87C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9BB2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgFPHKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:10:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbgFPHKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:10:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F1261C149E093188DAF8;
        Tue, 16 Jun 2020 15:10:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 15:10:33 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>, <liu.song11@zte.com.cn>
Subject: [PATCH RFC 3/5] ubifs: Pass node length in all node dumping callers
Date:   Tue, 16 Jun 2020 15:11:44 +0800
Message-ID: <20200616071146.2607061-4-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200616071146.2607061-1-chengzhihao1@huawei.com>
References: <20200616071146.2607061-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ubifs_dump_node() has been modified to avoid memory oob
accessing while dumping node, node length (corresponding to the
size of allocated memory for node) should be passed into all node
dumping callers.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/commit.c   |  4 ++--
 fs/ubifs/debug.c    | 30 +++++++++++++++---------------
 fs/ubifs/file.c     |  2 +-
 fs/ubifs/io.c       | 23 +++++++++++------------
 fs/ubifs/journal.c  |  3 ++-
 fs/ubifs/master.c   |  4 ++--
 fs/ubifs/orphan.c   |  6 ++++--
 fs/ubifs/recovery.c |  6 +++---
 fs/ubifs/replay.c   |  4 ++--
 fs/ubifs/sb.c       |  2 +-
 fs/ubifs/scan.c     |  4 ++--
 fs/ubifs/super.c    |  2 +-
 fs/ubifs/tnc.c      |  8 ++++----
 fs/ubifs/tnc_misc.c |  4 ++--
 fs/ubifs/ubifs.h    |  4 ++--
 15 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/fs/ubifs/commit.c b/fs/ubifs/commit.c
index ad292c5a43a9..2a3963e3b569 100644
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -701,13 +701,13 @@ int dbg_check_old_index(struct ubifs_info *c, struct ubifs_zbranch *zroot)
 
 out_dump:
 	ubifs_err(c, "dumping index node (iip=%d)", i->iip);
-	ubifs_dump_node(c, idx);
+	ubifs_dump_node(c, idx, ubifs_idx_node_sz(c, c->fanout));
 	list_del(&i->list);
 	kfree(i);
 	if (!list_empty(&list)) {
 		i = list_entry(list.prev, struct idx_node, list);
 		ubifs_err(c, "dumping parent index node");
-		ubifs_dump_node(c, &i->idx);
+		ubifs_dump_node(c, &i->idx, ubifs_idx_node_sz(c, c->fanout));
 	}
 out_free:
 	while (!list_empty(&list)) {
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index e995e553541d..24a6e6fb5e9a 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -871,7 +871,7 @@ void ubifs_dump_leb(const struct ubifs_info *c, int lnum)
 		cond_resched();
 		pr_err("Dumping node at LEB %d:%d len %d\n", lnum,
 		       snod->offs, snod->len);
-		ubifs_dump_node(c, snod->node);
+		ubifs_dump_node(c, snod->node, c->leb_size - snod->offs);
 	}
 
 	pr_err("(pid %d) finish dumping LEB %d\n", current->pid, lnum);
@@ -1248,7 +1248,7 @@ static int dbg_check_key_order(struct ubifs_info *c, struct ubifs_zbranch *zbr1,
 		ubifs_err(c, "but it should have key %s according to tnc",
 			  dbg_snprintf_key(c, &zbr1->key, key_buf,
 					   DBG_KEY_BUF_LEN));
-		ubifs_dump_node(c, dent1);
+		ubifs_dump_node(c, dent1, UBIFS_MAX_DENT_NODE_SZ);
 		goto out_free;
 	}
 
@@ -1260,7 +1260,7 @@ static int dbg_check_key_order(struct ubifs_info *c, struct ubifs_zbranch *zbr1,
 		ubifs_err(c, "but it should have key %s according to tnc",
 			  dbg_snprintf_key(c, &zbr2->key, key_buf,
 					   DBG_KEY_BUF_LEN));
-		ubifs_dump_node(c, dent2);
+		ubifs_dump_node(c, dent2, UBIFS_MAX_DENT_NODE_SZ);
 		goto out_free;
 	}
 
@@ -1279,9 +1279,9 @@ static int dbg_check_key_order(struct ubifs_info *c, struct ubifs_zbranch *zbr1,
 			  dbg_snprintf_key(c, &key, key_buf, DBG_KEY_BUF_LEN));
 
 	ubifs_msg(c, "first node at %d:%d\n", zbr1->lnum, zbr1->offs);
-	ubifs_dump_node(c, dent1);
+	ubifs_dump_node(c, dent1, UBIFS_MAX_DENT_NODE_SZ);
 	ubifs_msg(c, "second node at %d:%d\n", zbr2->lnum, zbr2->offs);
-	ubifs_dump_node(c, dent2);
+	ubifs_dump_node(c, dent2, UBIFS_MAX_DENT_NODE_SZ);
 
 out_free:
 	kfree(dent2);
@@ -2146,7 +2146,7 @@ static int check_leaf(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 
 out_dump:
 	ubifs_msg(c, "dump of node at LEB %d:%d", zbr->lnum, zbr->offs);
-	ubifs_dump_node(c, node);
+	ubifs_dump_node(c, node, zbr->len);
 out_free:
 	kfree(node);
 	return err;
@@ -2279,7 +2279,7 @@ static int check_inodes(struct ubifs_info *c, struct fsck_data *fsckd)
 
 	ubifs_msg(c, "dump of the inode %lu sitting in LEB %d:%d",
 		  (unsigned long)fscki->inum, zbr->lnum, zbr->offs);
-	ubifs_dump_node(c, ino);
+	ubifs_dump_node(c, ino, zbr->len);
 	kfree(ino);
 	return -EINVAL;
 }
@@ -2350,12 +2350,12 @@ int dbg_check_data_nodes_order(struct ubifs_info *c, struct list_head *head)
 
 		if (sa->type != UBIFS_DATA_NODE) {
 			ubifs_err(c, "bad node type %d", sa->type);
-			ubifs_dump_node(c, sa->node);
+			ubifs_dump_node(c, sa->node, c->leb_size - sa->offs);
 			return -EINVAL;
 		}
 		if (sb->type != UBIFS_DATA_NODE) {
 			ubifs_err(c, "bad node type %d", sb->type);
-			ubifs_dump_node(c, sb->node);
+			ubifs_dump_node(c, sb->node, c->leb_size - sb->offs);
 			return -EINVAL;
 		}
 
@@ -2386,8 +2386,8 @@ int dbg_check_data_nodes_order(struct ubifs_info *c, struct list_head *head)
 	return 0;
 
 error_dump:
-	ubifs_dump_node(c, sa->node);
-	ubifs_dump_node(c, sb->node);
+	ubifs_dump_node(c, sa->node, c->leb_size - sa->offs);
+	ubifs_dump_node(c, sb->node, c->leb_size - sb->offs);
 	return -EINVAL;
 }
 
@@ -2418,13 +2418,13 @@ int dbg_check_nondata_nodes_order(struct ubifs_info *c, struct list_head *head)
 		if (sa->type != UBIFS_INO_NODE && sa->type != UBIFS_DENT_NODE &&
 		    sa->type != UBIFS_XENT_NODE) {
 			ubifs_err(c, "bad node type %d", sa->type);
-			ubifs_dump_node(c, sa->node);
+			ubifs_dump_node(c, sa->node, c->leb_size - sa->offs);
 			return -EINVAL;
 		}
 		if (sb->type != UBIFS_INO_NODE && sb->type != UBIFS_DENT_NODE &&
 		    sb->type != UBIFS_XENT_NODE) {
 			ubifs_err(c, "bad node type %d", sb->type);
-			ubifs_dump_node(c, sb->node);
+			ubifs_dump_node(c, sb->node, c->leb_size - sb->offs);
 			return -EINVAL;
 		}
 
@@ -2474,9 +2474,9 @@ int dbg_check_nondata_nodes_order(struct ubifs_info *c, struct list_head *head)
 
 error_dump:
 	ubifs_msg(c, "dumping first node");
-	ubifs_dump_node(c, sa->node);
+	ubifs_dump_node(c, sa->node, c->leb_size - sa->offs);
 	ubifs_msg(c, "dumping second node");
-	ubifs_dump_node(c, sb->node);
+	ubifs_dump_node(c, sb->node, c->leb_size - sb->offs);
 	return -EINVAL;
 	return 0;
 }
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 49fe062ce45e..c5b09183a8b1 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -92,7 +92,7 @@ static int read_block(struct inode *inode, void *addr, unsigned int block,
 dump:
 	ubifs_err(c, "bad data node (block %u, inode %lu)",
 		  block, inode->i_ino);
-	ubifs_dump_node(c, dn);
+	ubifs_dump_node(c, dn, UBIFS_MAX_DATA_NODE_SZ);
 	return -EINVAL;
 }
 
diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 8ceb51478800..4ef7d0830020 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -198,6 +198,7 @@ int ubifs_is_mapped(const struct ubifs_info *c, int lnum)
  * ubifs_check_node - check node.
  * @c: UBIFS file-system description object
  * @buf: node to check
+ * @len: node length
  * @lnum: logical eraseblock number
  * @offs: offset within the logical eraseblock
  * @quiet: print no messages
@@ -222,8 +223,8 @@ int ubifs_is_mapped(const struct ubifs_info *c, int lnum)
  * This function returns zero in case of success and %-EUCLEAN in case of bad
  * CRC or magic.
  */
-int ubifs_check_node(const struct ubifs_info *c, const void *buf, int lnum,
-		     int offs, int quiet, int must_chk_crc)
+int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
+		     int lnum, int offs, int quiet, int must_chk_crc)
 {
 	int err = -EINVAL, type, node_len;
 	uint32_t crc, node_crc, magic;
@@ -281,7 +282,7 @@ int ubifs_check_node(const struct ubifs_info *c, const void *buf, int lnum,
 out:
 	if (!quiet) {
 		ubifs_err(c, "bad node at LEB %d:%d", lnum, offs);
-		ubifs_dump_node(c, buf);
+		ubifs_dump_node(c, buf, len);
 		dump_stack();
 	}
 	return err;
@@ -718,7 +719,7 @@ int ubifs_bg_wbufs_sync(struct ubifs_info *c)
 int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
 {
 	struct ubifs_info *c = wbuf->c;
-	int err, written, n, aligned_len = ALIGN(len, 8);
+	int err, n, written = 0, aligned_len = ALIGN(len, 8);
 
 	dbg_io("%d bytes (%s) to jhead %s wbuf at LEB %d:%d", len,
 	       dbg_ntype(((struct ubifs_ch *)buf)->node_type),
@@ -781,8 +782,6 @@ int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
 		goto exit;
 	}
 
-	written = 0;
-
 	if (wbuf->used) {
 		/*
 		 * The node is large enough and does not fit entirely within
@@ -878,7 +877,7 @@ int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
 out:
 	ubifs_err(c, "cannot write %d bytes to LEB %d:%d, error %d",
 		  len, wbuf->lnum, wbuf->offs, err);
-	ubifs_dump_node(c, buf);
+	ubifs_dump_node(c, buf, written + len);
 	dump_stack();
 	ubifs_dump_leb(c, wbuf->lnum);
 	return err;
@@ -921,7 +920,7 @@ int ubifs_write_node_hmac(struct ubifs_info *c, void *buf, int len, int lnum,
 
 	err = ubifs_leb_write(c, lnum, buf, offs, buf_len);
 	if (err)
-		ubifs_dump_node(c, buf);
+		ubifs_dump_node(c, buf, len);
 
 	return err;
 }
@@ -1004,7 +1003,7 @@ int ubifs_read_node_wbuf(struct ubifs_wbuf *wbuf, void *buf, int type, int len,
 		goto out;
 	}
 
-	err = ubifs_check_node(c, buf, lnum, offs, 0, 0);
+	err = ubifs_check_node(c, buf, len, lnum, offs, 0, 0);
 	if (err) {
 		ubifs_err(c, "expected node type %d", type);
 		return err;
@@ -1020,7 +1019,7 @@ int ubifs_read_node_wbuf(struct ubifs_wbuf *wbuf, void *buf, int type, int len,
 
 out:
 	ubifs_err(c, "bad node at LEB %d:%d", lnum, offs);
-	ubifs_dump_node(c, buf);
+	ubifs_dump_node(c, buf, len);
 	dump_stack();
 	return -EINVAL;
 }
@@ -1060,7 +1059,7 @@ int ubifs_read_node(const struct ubifs_info *c, void *buf, int type, int len,
 		goto out;
 	}
 
-	err = ubifs_check_node(c, buf, lnum, offs, 0, 0);
+	err = ubifs_check_node(c, buf, len, lnum, offs, 0, 0);
 	if (err) {
 		ubifs_errc(c, "expected node type %d", type);
 		return err;
@@ -1078,7 +1077,7 @@ int ubifs_read_node(const struct ubifs_info *c, void *buf, int type, int len,
 	ubifs_errc(c, "bad node at LEB %d:%d, LEB mapping status %d", lnum,
 		   offs, ubi_is_mapped(c->ubi, lnum));
 	if (!c->probing) {
-		ubifs_dump_node(c, buf);
+		ubifs_dump_node(c, buf, len);
 		dump_stack();
 	}
 	return -EINVAL;
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index e5ec1afe1c66..a62fa19f7bcb 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1555,7 +1555,8 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 			if (dn_len <= 0 || dn_len > UBIFS_BLOCK_SIZE) {
 				ubifs_err(c, "bad data node (block %u, inode %lu)",
 					  blk, inode->i_ino);
-				ubifs_dump_node(c, dn);
+				ubifs_dump_node(c, dn, sz - UBIFS_INO_NODE_SZ -
+						UBIFS_TRUN_NODE_SZ);
 				goto out_free;
 			}
 
diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index 911d0555b9f2..0df9a3dd0aaa 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -314,7 +314,7 @@ static int validate_master(const struct ubifs_info *c)
 
 out:
 	ubifs_err(c, "bad master node at offset %d error %d", c->mst_offs, err);
-	ubifs_dump_node(c, c->mst_node);
+	ubifs_dump_node(c, c->mst_node, c->mst_node_alsz);
 	return -EINVAL;
 }
 
@@ -392,7 +392,7 @@ int ubifs_read_master(struct ubifs_info *c)
 		if (c->leb_cnt < old_leb_cnt ||
 		    c->leb_cnt < UBIFS_MIN_LEB_CNT) {
 			ubifs_err(c, "bad leb_cnt on master node");
-			ubifs_dump_node(c, c->mst_node);
+			ubifs_dump_node(c, c->mst_node, c->mst_node_alsz);
 			return -EINVAL;
 		}
 
diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 2c294085ffed..30c8f3de91da 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -644,7 +644,8 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 		if (snod->type != UBIFS_ORPH_NODE) {
 			ubifs_err(c, "invalid node type %d in orphan area at %d:%d",
 				  snod->type, sleb->lnum, snod->offs);
-			ubifs_dump_node(c, snod->node);
+			ubifs_dump_node(c, snod->node,
+					c->leb_size - snod->offs);
 			err = -EINVAL;
 			goto out_free;
 		}
@@ -672,7 +673,8 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 			if (!first) {
 				ubifs_err(c, "out of order commit number %llu in orphan node at %d:%d",
 					  cmt_no, sleb->lnum, snod->offs);
-				ubifs_dump_node(c, snod->node);
+				ubifs_dump_node(c, snod->node,
+						c->leb_size - snod->offs);
 				err = -EINVAL;
 				goto out_free;
 			}
diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index f116f7b3f9e5..f0d51dd21c9e 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -352,11 +352,11 @@ int ubifs_recover_master_node(struct ubifs_info *c)
 	ubifs_err(c, "failed to recover master node");
 	if (mst1) {
 		ubifs_err(c, "dumping first master node");
-		ubifs_dump_node(c, mst1);
+		ubifs_dump_node(c, mst1, c->leb_size - ((void *)mst1 - buf1));
 	}
 	if (mst2) {
 		ubifs_err(c, "dumping second master node");
-		ubifs_dump_node(c, mst2);
+		ubifs_dump_node(c, mst2, c->leb_size - ((void *)mst2 - buf2));
 	}
 	vfree(buf2);
 	vfree(buf1);
@@ -469,7 +469,7 @@ static int no_more_nodes(const struct ubifs_info *c, void *buf, int len,
 	 * The area after the common header size is not empty, so the common
 	 * header must be intact. Check it.
 	 */
-	if (ubifs_check_node(c, buf, lnum, offs, 1, 0) != -EUCLEAN) {
+	if (ubifs_check_node(c, buf, len, lnum, offs, 1, 0) != -EUCLEAN) {
 		dbg_rcvry("unexpected bad common header at %d:%d", lnum, offs);
 		return 0;
 	}
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index b69ffac7e415..6966003501bb 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -827,7 +827,7 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 
 out_dump:
 	ubifs_err(c, "bad node is at LEB %d:%d", lnum, snod->offs);
-	ubifs_dump_node(c, snod->node);
+	ubifs_dump_node(c, snod->node, c->leb_size - snod->offs);
 	ubifs_scan_destroy(sleb);
 	return -EINVAL;
 }
@@ -1125,7 +1125,7 @@ static int replay_log_leb(struct ubifs_info *c, int lnum, int offs, void *sbuf)
 out_dump:
 	ubifs_err(c, "log error detected while replaying the log at LEB %d:%d",
 		  lnum, offs + snod->offs);
-	ubifs_dump_node(c, snod->node);
+	ubifs_dump_node(c, snod->node, c->leb_size - snod->offs);
 	ubifs_scan_destroy(sleb);
 	return -EINVAL;
 }
diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 4b4b65b48c57..0e1988d426a0 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -502,7 +502,7 @@ static int validate_sb(struct ubifs_info *c, struct ubifs_sb_node *sup)
 
 failed:
 	ubifs_err(c, "bad superblock, error %d", err);
-	ubifs_dump_node(c, sup);
+	ubifs_dump_node(c, sup, ALIGN(UBIFS_SB_NODE_SZ, c->min_io_size));
 	return -EINVAL;
 }
 
diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
index c69cdb5e65bc..84a9157dcc32 100644
--- a/fs/ubifs/scan.c
+++ b/fs/ubifs/scan.c
@@ -76,7 +76,7 @@ int ubifs_scan_a_node(const struct ubifs_info *c, void *buf, int len, int lnum,
 	dbg_scan("scanning %s at LEB %d:%d",
 		 dbg_ntype(ch->node_type), lnum, offs);
 
-	if (ubifs_check_node(c, buf, lnum, offs, quiet, 1))
+	if (ubifs_check_node(c, buf, len, lnum, offs, quiet, 1))
 		return SCANNED_A_CORRUPT_NODE;
 
 	if (ch->node_type == UBIFS_PAD_NODE) {
@@ -90,7 +90,7 @@ int ubifs_scan_a_node(const struct ubifs_info *c, void *buf, int len, int lnum,
 			if (!quiet) {
 				ubifs_err(c, "bad pad node at LEB %d:%d",
 					  lnum, offs);
-				ubifs_dump_node(c, pad);
+				ubifs_dump_node(c, pad, len);
 			}
 			return SCANNED_A_BAD_PAD_NODE;
 		}
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 7fc2f3f07c16..18f289f2ffb6 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -235,7 +235,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 
 out_invalid:
 	ubifs_err(c, "inode %lu validation failed, error %d", inode->i_ino, err);
-	ubifs_dump_node(c, ino);
+	ubifs_dump_node(c, ino, UBIFS_MAX_INO_NODE_SZ);
 	ubifs_dump_inode(c, inode);
 	err = -EINVAL;
 out_ino:
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index e8e7b0e9532e..b2f9e927acc3 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -316,7 +316,7 @@ static int lnc_add(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 	err = ubifs_validate_entry(c, dent);
 	if (err) {
 		dump_stack();
-		ubifs_dump_node(c, dent);
+		ubifs_dump_node(c, dent, zbr->len);
 		return err;
 	}
 
@@ -349,7 +349,7 @@ static int lnc_add_directly(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 	err = ubifs_validate_entry(c, node);
 	if (err) {
 		dump_stack();
-		ubifs_dump_node(c, node);
+		ubifs_dump_node(c, node, zbr->len);
 		return err;
 	}
 
@@ -1700,7 +1700,7 @@ static int validate_data_node(struct ubifs_info *c, void *buf,
 		goto out_err;
 	}
 
-	err = ubifs_check_node(c, buf, zbr->lnum, zbr->offs, 0, 0);
+	err = ubifs_check_node(c, buf, zbr->len, zbr->lnum, zbr->offs, 0, 0);
 	if (err) {
 		ubifs_err(c, "expected node type %d", UBIFS_DATA_NODE);
 		goto out;
@@ -1734,7 +1734,7 @@ static int validate_data_node(struct ubifs_info *c, void *buf,
 	err = -EINVAL;
 out:
 	ubifs_err(c, "bad node at LEB %d:%d", zbr->lnum, zbr->offs);
-	ubifs_dump_node(c, buf);
+	ubifs_dump_node(c, buf, zbr->len);
 	dump_stack();
 	return err;
 }
diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index 49cb34c3f324..302fe1d8719d 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -390,7 +390,7 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 
 out_dump:
 	ubifs_err(c, "bad indexing node at LEB %d:%d, error %d", lnum, offs, err);
-	ubifs_dump_node(c, idx);
+	ubifs_dump_node(c, idx, c->max_idx_node_sz);
 	kfree(idx);
 	return -EINVAL;
 }
@@ -489,7 +489,7 @@ int ubifs_tnc_read_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 			  zbr->lnum, zbr->offs);
 		dbg_tnck(key, "looked for key ");
 		dbg_tnck(&key1, "but found node's key ");
-		ubifs_dump_node(c, node);
+		ubifs_dump_node(c, node, zbr->len);
 		return -EINVAL;
 	}
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index bff682309fbe..2393715a9251 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1718,8 +1718,8 @@ int ubifs_write_node(struct ubifs_info *c, void *node, int len, int lnum,
 		     int offs);
 int ubifs_write_node_hmac(struct ubifs_info *c, void *buf, int len, int lnum,
 			  int offs, int hmac_offs);
-int ubifs_check_node(const struct ubifs_info *c, const void *buf, int lnum,
-		     int offs, int quiet, int must_chk_crc);
+int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
+		     int lnum, int offs, int quiet, int must_chk_crc);
 void ubifs_init_node(struct ubifs_info *c, void *buf, int len, int pad);
 void ubifs_crc_node(struct ubifs_info *c, void *buf, int len);
 void ubifs_prepare_node(struct ubifs_info *c, void *buf, int len, int pad);
-- 
2.25.4

