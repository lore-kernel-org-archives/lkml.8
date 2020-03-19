Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A6C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D80120722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgCSL6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:58:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgCSL6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:58:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A1E2A610F59FCC8B2231;
        Thu, 19 Mar 2020 19:58:10 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 19:58:04 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: don't trigger data flush in foreground operation
Date:   Thu, 19 Mar 2020 19:57:58 +0800
Message-ID: <20200319115800.108926-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200319115800.108926-1-yuchao0@huawei.com>
References: <20200319115800.108926-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data flush can generate heavy IO and cause long latency during
flush, so it's not appropriate to trigger it in foreground
operation.

And also, we may face below potential deadlock during data flush:
- f2fs_write_multi_pages
 - f2fs_write_raw_pages
  - f2fs_write_single_data_page
   - f2fs_balance_fs
    - f2fs_balance_fs_bg
     - f2fs_sync_dirty_inodes
      - filemap_fdatawrite   -- stuck on flush same cluster

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/gc.c      | 2 +-
 fs/f2fs/node.c    | 2 +-
 fs/f2fs/segment.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 422a070526e5..09db79a20f8e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3246,7 +3246,7 @@ void f2fs_drop_inmem_pages(struct inode *inode);
 void f2fs_drop_inmem_page(struct inode *inode, struct page *page);
 int f2fs_commit_inmem_pages(struct inode *inode);
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
-void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi);
+void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg);
 int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f122fe3dbba3..26248c8936db 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -113,7 +113,7 @@ static int gc_thread_func(void *data)
 				prefree_segments(sbi), free_segments(sbi));
 
 		/* balancing f2fs's metadata periodically */
-		f2fs_balance_fs_bg(sbi);
+		f2fs_balance_fs_bg(sbi, true);
 next:
 		sb_end_write(sbi->sb);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 542335bdc100..ecbd6bd14a49 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1976,7 +1976,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 		goto skip_write;
 
 	/* balancing f2fs's metadata in background */
-	f2fs_balance_fs_bg(sbi);
+	f2fs_balance_fs_bg(sbi, true);
 
 	/* collect a number of dirty node pages and write together */
 	if (wbc->sync_mode != WB_SYNC_ALL &&
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 601d67e72c50..aece09a184fa 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -496,7 +496,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 
 	/* balance_fs_bg is able to be pending */
 	if (need && excess_cached_nats(sbi))
-		f2fs_balance_fs_bg(sbi);
+		f2fs_balance_fs_bg(sbi, false);
 
 	if (!f2fs_is_checkpoint_ready(sbi))
 		return;
@@ -511,7 +511,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	}
 }
 
-void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
+void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 {
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return;
@@ -540,7 +540,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			excess_dirty_nats(sbi) ||
 			excess_dirty_nodes(sbi) ||
 			f2fs_time_over(sbi, CP_TIME)) {
-		if (test_opt(sbi, DATA_FLUSH)) {
+		if (test_opt(sbi, DATA_FLUSH) && from_bg) {
 			struct blk_plug plug;
 
 			mutex_lock(&sbi->flush_lock);
-- 
2.18.0.rc1

