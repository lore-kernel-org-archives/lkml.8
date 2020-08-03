Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E3B22B4E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596475710;
	bh=PZUKrLZAE6MCA4MiMsW6VcdNloK3vEM4/UvrHZAkelg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tLkT8LEVEwq7EvSuV1Pn1kI7x88FczQvt4p45Nov9QYPdEpJ6mcMH7C9eOSJSej0m
	 AbqKkaPE81BVyKhqaEs4g3/Edk1yyFoapq/bT9jbfxsmewahjv+FfBglsMrtHz4jy5
	 dWO5qTi8ikvqoK6IiF5f8CPm+kBkB1l+0mWf1lNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgHCR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHCR22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:28:28 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909112086A;
        Mon,  3 Aug 2020 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596475706;
        bh=PZUKrLZAE6MCA4MiMsW6VcdNloK3vEM4/UvrHZAkelg=;
        h=From:To:Cc:Subject:Date:From;
        b=BJBLpZPZ9lVyYJPVH/5O6irUb4fPXQJeCjDA3OP6GcggQrkpDdgQxBrOo3SkqDJui
         0ZMl3jqu3g0vAQmIOuk0J8978Uigm6GpPGXIk5nBNKe1fbLCd11w92fcEIDz3WvNJb
         MHNQ8qgBCINJSJ3PHXFCNGuqR/MQ7iQMMdkxkAnc=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] f2fs: remove a waiter for checkpoint completion
Date:   Mon,  3 Aug 2020 10:28:25 -0700
Message-Id: <20200803172825.4077289-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't need to wait for checkpoint being completed triggered by end_io.

[   20.157753] ------------[ cut here ]------------
[   20.158393] do not call blocking ops when !TASK_RUNNING; state=2 set at [<0000000096354225>] prepare_to_wait+0xcd/0x430
[   20.159858] WARNING: CPU: 1 PID: 1152 at kernel/sched/core.c:7142 __might_sleep+0x149/0x1a0
...
[   20.176110]  __submit_merged_write_cond+0x191/0x310
[   20.176739]  f2fs_submit_merged_write+0x18/0x20
[   20.177323]  f2fs_wait_on_all_pages+0x269/0x2d0
[   20.177899]  ? block_operations+0x980/0x980
[   20.178441]  ? __kasan_check_read+0x11/0x20
[   20.178975]  ? finish_wait+0x260/0x260
[   20.179488]  ? percpu_counter_set+0x147/0x230
[   20.180049]  do_checkpoint+0x1757/0x2a50
[   20.180558]  f2fs_write_checkpoint+0x840/0xaf0
[   20.181126]  f2fs_sync_fs+0x287/0x4a0

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 6 +-----
 fs/f2fs/data.c       | 4 ----
 fs/f2fs/f2fs.h       | 1 -
 fs/f2fs/super.c      | 1 -
 4 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 99c8061da55b9..2bdddc725e677 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1255,11 +1255,7 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
 
 void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 {
-	DEFINE_WAIT(wait);
-
 	for (;;) {
-		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
-
 		if (!get_pages(sbi, type))
 			break;
 
@@ -1271,9 +1267,9 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 							FS_CP_META_IO);
 		else if (type == F2FS_WB_CP_DATA)
 			f2fs_submit_merged_write(sbi, DATA);
+
 		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	}
-	finish_wait(&sbi->cp_wait, &wait);
 }
 
 static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c1b676be67b9a..588d2871bbe69 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -383,10 +383,6 @@ static void f2fs_write_end_io(struct bio *bio)
 		clear_cold_data(page);
 		end_page_writeback(page);
 	}
-	if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
-				wq_has_sleeper(&sbi->cp_wait))
-		wake_up(&sbi->cp_wait);
-
 	bio_put(bio);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 02811ce15059b..a036539363030 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1437,7 +1437,6 @@ struct f2fs_sb_info {
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
 	struct rw_semaphore node_write;		/* locking node writes */
 	struct rw_semaphore node_change;	/* locking node change */
-	wait_queue_head_t cp_wait;
 	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
 	long interval_time[MAX_TIME];		/* to store thresholds */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 83bf9a02f83f2..5f4d9abc079d6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3540,7 +3540,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	init_rwsem(&sbi->cp_rwsem);
 	init_rwsem(&sbi->quota_sem);
-	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
 	err = init_percpu_info(sbi);
-- 
2.28.0.163.g6104cc2f0b6-goog

