Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8BBC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F6820CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgDWKDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:03:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2841 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgDWKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:03:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 305877B68F68317747C4;
        Thu, 23 Apr 2020 18:03:21 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 18:03:13 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add compressed/gc data read IO stat
Date:   Thu, 23 Apr 2020 18:03:06 +0800
Message-ID: <20200423100306.8817-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in order to account data read IOs more accurately.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---

Jaegeuk, merge this patch into ("f2fs: support read iostat") will
be okay to me as well.

 fs/f2fs/data.c              |  1 +
 fs/f2fs/f2fs.h              |  2 ++
 fs/f2fs/gc.c                |  2 ++
 fs/f2fs/sysfs.c             |  7 +++++++
 include/trace/events/f2fs.h | 11 ++++++++---
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 199877cb57fe..8dd48c5b6c0d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2176,6 +2176,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		inc_page_count(sbi, F2FS_RD_DATA);
 		f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, FS_CDATA_READ_IO, F2FS_BLKSIZE);
 		ClearPageError(page);
 		*last_block_in_bio = blkaddr;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3b9603266a2a..c154651335cd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1108,6 +1108,8 @@ enum iostat_type {
 	APP_READ_IO,			/* app read IOs */
 	APP_MAPPED_READ_IO,		/* app mapped read IOs */
 	FS_DATA_READ_IO,		/* data read IOs */
+	FS_GDATA_READ_IO,		/* data read IOs from background gc */
+	FS_CDATA_READ_IO,		/* compressed data read IOs */
 	FS_NODE_READ_IO,		/* node read IOs */
 	FS_META_READ_IO,		/* meta read IOs */
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 28a8c79c8bdc..a4c02bf61f8a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -739,6 +739,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	f2fs_put_page(page, 1);
 
 	f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, FS_GDATA_READ_IO, F2FS_BLKSIZE);
 
 	return 0;
 put_encrypted_page:
@@ -845,6 +846,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		}
 
 		f2fs_update_iostat(fio.sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(fio.sbi, FS_GDATA_READ_IO, F2FS_BLKSIZE);
 
 		lock_page(mpage);
 		if (unlikely(mpage->mapping != META_MAPPING(fio.sbi) ||
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index eaf8088548f0..a117ae1f9d5f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -803,6 +803,7 @@ static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 	seq_printf(seq, "time:		%-16llu\n", now);
 
 	/* print app write IOs */
+	seq_puts(seq, "[WRITE]\n");
 	seq_printf(seq, "app buffered:	%-16llu\n",
 				sbi->rw_iostat[APP_BUFFERED_IO]);
 	seq_printf(seq, "app direct:	%-16llu\n",
@@ -829,6 +830,7 @@ static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 				sbi->rw_iostat[FS_CP_META_IO]);
 
 	/* print app read IOs */
+	seq_puts(seq, "[READ]\n");
 	seq_printf(seq, "app buffered:	%-16llu\n",
 				sbi->rw_iostat[APP_BUFFERED_READ_IO]);
 	seq_printf(seq, "app direct:	%-16llu\n",
@@ -839,12 +841,17 @@ static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 	/* print fs read IOs */
 	seq_printf(seq, "fs data:	%-16llu\n",
 				sbi->rw_iostat[FS_DATA_READ_IO]);
+	seq_printf(seq, "fs gc data:	%-16llu\n",
+				sbi->rw_iostat[FS_GDATA_READ_IO]);
+	seq_printf(seq, "fs compr_data:	%-16llu\n",
+				sbi->rw_iostat[FS_CDATA_READ_IO]);
 	seq_printf(seq, "fs node:	%-16llu\n",
 				sbi->rw_iostat[FS_NODE_READ_IO]);
 	seq_printf(seq, "fs meta:	%-16llu\n",
 				sbi->rw_iostat[FS_META_READ_IO]);
 
 	/* print other IOs */
+	seq_puts(seq, "[OTHER]\n");
 	seq_printf(seq, "fs discard:	%-16llu\n",
 				sbi->rw_iostat[FS_DISCARD]);
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 417a486f5c8a..9ef8dea5c833 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1837,6 +1837,8 @@ TRACE_EVENT(f2fs_iostat,
 		__field(unsigned long long,	app_rio)
 		__field(unsigned long long,	app_mrio)
 		__field(unsigned long long,	fs_drio)
+		__field(unsigned long long,	fs_gdrio)
+		__field(unsigned long long,	fs_cdrio)
 		__field(unsigned long long,	fs_nrio)
 		__field(unsigned long long,	fs_mrio)
 		__field(unsigned long long,	fs_discard)
@@ -1861,6 +1863,8 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->app_rio	= iostat[APP_READ_IO];
 		__entry->app_mrio	= iostat[APP_MAPPED_READ_IO];
 		__entry->fs_drio	= iostat[FS_DATA_READ_IO];
+		__entry->fs_gdrio	= iostat[FS_GDATA_READ_IO];
+		__entry->fs_cdrio	= iostat[FS_CDATA_READ_IO];
 		__entry->fs_nrio	= iostat[FS_NODE_READ_IO];
 		__entry->fs_mrio	= iostat[FS_META_READ_IO];
 		__entry->fs_discard	= iostat[FS_DISCARD];
@@ -1872,15 +1876,16 @@ TRACE_EVENT(f2fs_iostat,
 		"gc [data=%llu, node=%llu], "
 		"cp [data=%llu, node=%llu, meta=%llu], "
 		"app [read=%llu (direct=%llu, buffered=%llu), mapped=%llu], "
-		"fs [data=%llu, node=%llu, meta=%llu]",
+		"fs [data=%llu, (gc_data=%llu, compr_data=%llu), "
+		"node=%llu, meta=%llu]",
 		show_dev(__entry->dev), __entry->app_wio, __entry->app_dio,
 		__entry->app_bio, __entry->app_mio, __entry->fs_dio,
 		__entry->fs_nio, __entry->fs_mio, __entry->fs_discard,
 		__entry->fs_gc_dio, __entry->fs_gc_nio, __entry->fs_cp_dio,
 		__entry->fs_cp_nio, __entry->fs_cp_mio,
 		__entry->app_rio, __entry->app_drio, __entry->app_brio,
-		__entry->app_mrio, __entry->fs_drio, __entry->fs_nrio,
-		__entry->fs_mrio)
+		__entry->app_mrio, __entry->fs_drio, __entry->fs_gdrio,
+		__entry->fs_cdrio, __entry->fs_nrio, __entry->fs_mrio)
 );
 
 #endif /* _TRACE_F2FS_H */
-- 
2.18.0.rc1

