Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36897C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A53F2087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIBHC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:02:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgIBHCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:02:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 320F5AC2FA410F4E76A5;
        Wed,  2 Sep 2020 15:02:22 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Sep 2020 15:02:12 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, 5kft <5kft@5kft.org>
Subject: [PATCH] f2fs: allocate proper size memory for zstd decompress
Date:   Wed, 2 Sep 2020 15:01:52 +0800
Message-ID: <20200902070152.67032-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 5kft <5kft@5kft.org> reported:

 kworker/u9:3: page allocation failure: order:9, mode:0x40c40(GFP_NOFS|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
 CPU: 3 PID: 8168 Comm: kworker/u9:3 Tainted: G         C        5.8.3-sunxi #trunk
 Hardware name: Allwinner sun8i Family
 Workqueue: f2fs_post_read_wq f2fs_post_read_work
 [<c010d6d5>] (unwind_backtrace) from [<c0109a55>] (show_stack+0x11/0x14)
 [<c0109a55>] (show_stack) from [<c056d489>] (dump_stack+0x75/0x84)
 [<c056d489>] (dump_stack) from [<c0243b53>] (warn_alloc+0xa3/0x104)
 [<c0243b53>] (warn_alloc) from [<c024473b>] (__alloc_pages_nodemask+0xb87/0xc40)
 [<c024473b>] (__alloc_pages_nodemask) from [<c02267c5>] (kmalloc_order+0x19/0x38)
 [<c02267c5>] (kmalloc_order) from [<c02267fd>] (kmalloc_order_trace+0x19/0x90)
 [<c02267fd>] (kmalloc_order_trace) from [<c047c665>] (zstd_init_decompress_ctx+0x21/0x88)
 [<c047c665>] (zstd_init_decompress_ctx) from [<c047e9cf>] (f2fs_decompress_pages+0x97/0x228)
 [<c047e9cf>] (f2fs_decompress_pages) from [<c045d0ab>] (__read_end_io+0xfb/0x130)
 [<c045d0ab>] (__read_end_io) from [<c045d141>] (f2fs_post_read_work+0x61/0x84)
 [<c045d141>] (f2fs_post_read_work) from [<c0130b2f>] (process_one_work+0x15f/0x3b0)
 [<c0130b2f>] (process_one_work) from [<c0130e7b>] (worker_thread+0xfb/0x3e0)
 [<c0130e7b>] (worker_thread) from [<c0135c3b>] (kthread+0xeb/0x10c)
 [<c0135c3b>] (kthread) from [<c0100159>]

zstd may allocate large size memory for {,de}compression, it may cause
file copy failure on low-end device which has very few memory.

For decompression, let's just allocate proper size memory based on current
file's cluster size instead of max cluster size.

Reported-by: 5kft <5kft@5kft.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 7 ++++---
 fs/f2fs/f2fs.h     | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index df097c4a71e1..357303d8514b 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -382,16 +382,17 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 	ZSTD_DStream *stream;
 	void *workspace;
 	unsigned int workspace_size;
+	unsigned int max_window_size =
+			MAX_COMPRESS_WINDOW_SIZE(dic->log_cluster_size);
 
-	workspace_size = ZSTD_DStreamWorkspaceBound(MAX_COMPRESS_WINDOW_SIZE);
+	workspace_size = ZSTD_DStreamWorkspaceBound(max_window_size);
 
 	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
 					workspace_size, GFP_NOFS);
 	if (!workspace)
 		return -ENOMEM;
 
-	stream = ZSTD_initDStream(MAX_COMPRESS_WINDOW_SIZE,
-					workspace, workspace_size);
+	stream = ZSTD_initDStream(max_window_size, workspace, workspace_size);
 	if (!stream) {
 		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD_initDStream failed\n",
 				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 21f86001bb3a..d210809292f9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1419,7 +1419,7 @@ struct decompress_io_ctx {
 #define NULL_CLUSTER			((unsigned int)(~0))
 #define MIN_COMPRESS_LOG_SIZE		2
 #define MAX_COMPRESS_LOG_SIZE		8
-#define MAX_COMPRESS_WINDOW_SIZE	((PAGE_SIZE) << MAX_COMPRESS_LOG_SIZE)
+#define MAX_COMPRESS_WINDOW_SIZE(log_size)	((PAGE_SIZE) << (log_size))
 
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
-- 
2.26.2

