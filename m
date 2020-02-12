Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1ECC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C304D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qMTJ1CYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBLKev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:34:51 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:40639 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727558AbgBLKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:34:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581503689; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2BzVBkWXGOG1Dibf8D8odHQzCgza5j9KmDN17ZfpAAs=; b=qMTJ1CYcVWVSyFPcDyaqM3MPj9aIjZ4ZddmGjuEwXQrkpPP8AJs+C17d0vm1NdfTcvgPgHHT
 jSe7vvviDz41H0CP29w3tkUNyEDxhNkj3E91ADMA42p/rd2I0DzJI7B1F+SjXbUgVOQ5cPSQ
 GqzDDVKHg+008AxdH+B+XZN3j7s=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e43d4c7.7f2c914487d8-smtp-out-n01;
 Wed, 12 Feb 2020 10:34:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 529F4C4479C; Wed, 12 Feb 2020 10:34:47 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7DD8C433A2;
        Wed, 12 Feb 2020 10:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7DD8C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix the panic in do_checkpoint()
Date:   Wed, 12 Feb 2020 16:04:25 +0530
Message-Id: <1581503665-19914-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a scenario where f2fs_sync_meta_pages() will not
ensure that all F2FS_DIRTY_META pages are submitted for IO. Thus,
resulting in the below panic in do_checkpoint() -

f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
				!f2fs_cp_error(sbi));

This can happen in a low-memory condition, where shrinker could
also be doing the writepage operation (stack shown below)
at the same time when checkpoint is running on another core.

schedule
down_write
f2fs_submit_page_write -> by this time, this page in page cache is tagged
			as PAGECACHE_TAG_WRITEBACK and PAGECACHE_TAG_DIRTY
			is cleared, due to which f2fs_sync_meta_pages()
			cannot sync this page in do_checkpoint() path.
f2fs_do_write_meta_page
__f2fs_write_meta_page
f2fs_write_meta_page
shrink_page_list
shrink_inactive_list
shrink_node_memcg
shrink_node
kswapd

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/checkpoint.c | 16 ++++++++--------
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/super.c      |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ffdaba0..2b651a3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1250,14 +1250,14 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
 	f2fs_unlock_all(sbi);
 }
 
-void f2fs_wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
+void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 {
 	DEFINE_WAIT(wait);
 
 	for (;;) {
 		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		if (!get_pages(sbi, F2FS_WB_CP_DATA))
+		if (!get_pages(sbi, type))
 			break;
 
 		if (unlikely(f2fs_cp_error(sbi)))
@@ -1384,8 +1384,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Flush all the NAT/SIT pages */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
-	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
-					!f2fs_cp_error(sbi));
+	/* Wait for all dirty meta pages to be submitted for IO */
+	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
 
 	/*
 	 * modify checkpoint
@@ -1493,11 +1493,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Here, we have one bio having CP pack except cp pack 2 page */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
-	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
-					!f2fs_cp_error(sbi));
+	/* Wait for all dirty meta pages to be submitted for IO */
+	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
 
 	/* wait for previous submitted meta pages writeback */
-	f2fs_wait_on_all_pages_writeback(sbi);
+	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
 	/* flush all device cache */
 	err = f2fs_flush_device_cache(sbi);
@@ -1506,7 +1506,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* barrier and flush checkpoint cp pack 2 page if it can */
 	commit_checkpoint(sbi, ckpt, start_blk);
-	f2fs_wait_on_all_pages_writeback(sbi);
+	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
 	/*
 	 * invalidate intermediate page cache borrowed from meta inode
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a0..b0e0535 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3196,7 +3196,7 @@ bool f2fs_is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 void f2fs_update_dirty_page(struct inode *inode, struct page *page);
 void f2fs_remove_dirty_inode(struct inode *inode);
 int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
-void f2fs_wait_on_all_pages_writeback(struct f2fs_sb_info *sbi);
+void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type);
 int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi);
 int __init f2fs_create_checkpoint_caches(void);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5111e1f..084633b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1105,7 +1105,7 @@ static void f2fs_put_super(struct super_block *sb)
 	/* our cp_error case, we can wait for any writeback page */
 	f2fs_flush_merged_writes(sbi);
 
-	f2fs_wait_on_all_pages_writeback(sbi);
+	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
