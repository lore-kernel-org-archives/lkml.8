Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D2BC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4596F20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586794614;
	bh=00NfhYZ8RL0JxCpNolUpraJn5ePTrwODtHaKcWmumkM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lYn6Mdr6TlxY0NdPzr+FJZVa6PVgHim2CeK2bWH20JxRvfAi6EhXpxZNNM/EUKoT8
	 ezIYNr5YIuTvTchqc+2DosWcNoKJkKWwJoX1pz/yVjcAX1Vy2ZA+3DpzqTl6OXtz9C
	 WWRy+DL9KQ2c6S9UvNoDSFNQP2916+fjXeI5itHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgDMQQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbgDMQQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:51 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 356612072C;
        Mon, 13 Apr 2020 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586794610;
        bh=00NfhYZ8RL0JxCpNolUpraJn5ePTrwODtHaKcWmumkM=;
        h=From:To:Cc:Subject:Date:From;
        b=IONbqX8E0ThhePaqxTvRFuFNjKhxQbD2iIOQReMMU0IDGKXLH/BAk1q3o2iAkvmFY
         qhb667+CauT1QoL4Tnib3bkDyegY05vSk8KzkDlE/y4N8Xh5mMzrxmPNw3XMlqy7uK
         VHNcwBNIaxnQxs0Ni0L6cgfWluE+cfbYWjFgjX9I=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add tracepoint for f2fs iostat
Date:   Mon, 13 Apr 2020 09:16:49 -0700
Message-Id: <20200413161649.38177-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a tracepoint to see iostat of f2fs. Default period of that
is 3 second. This tracepoint can be used to be monitoring
I/O statistics periodically.

Bug: 152162885
Change-Id: I6fbe010b9cf1a90caa0f4793a6dab77c4cba7da6
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h              | 10 ++++++-
 fs/f2fs/sysfs.c             | 34 ++++++++++++++++++++++++
 include/trace/events/f2fs.h | 52 +++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c2788738aa0d4..87baa09f76fb2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2999,16 +2999,22 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 		sizeof((f2fs_inode)->field))			\
 		<= (F2FS_OLD_ATTRIBUTE_SIZE + (extra_isize)))	\
 
+extern unsigned long long f2fs_prev_iostat[NR_IO_TYPE];
+
 static inline void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
 {
 	int i;
 
 	spin_lock(&sbi->iostat_lock);
-	for (i = 0; i < NR_IO_TYPE; i++)
+	for (i = 0; i < NR_IO_TYPE; i++) {
 		sbi->write_iostat[i] = 0;
+		f2fs_prev_iostat[i] = 0;
+	}
 	spin_unlock(&sbi->iostat_lock);
 }
 
+extern void f2fs_record_iostat(struct f2fs_sb_info *sbi);
+
 static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 			enum iostat_type type, unsigned long long io_bytes)
 {
@@ -3022,6 +3028,8 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 			sbi->write_iostat[APP_WRITE_IO] -
 			sbi->write_iostat[APP_DIRECT_IO];
 	spin_unlock(&sbi->iostat_lock);
+
+	f2fs_record_iostat(sbi);
 }
 
 #define __is_large_section(sbi)		((sbi)->segs_per_sec > 1)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index aeebfb5024a22..f34cb75cd039c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -15,6 +15,7 @@
 #include "f2fs.h"
 #include "segment.h"
 #include "gc.h"
+#include <trace/events/f2fs.h>
 
 static struct proc_dir_entry *f2fs_proc_root;
 
@@ -751,6 +752,39 @@ static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static const unsigned long period_ms = 3000;
+static unsigned long next_period;
+unsigned long long f2fs_prev_iostat[NR_IO_TYPE] = {0};
+
+static DEFINE_SPINLOCK(iostat_lock);
+
+void f2fs_record_iostat(struct f2fs_sb_info *sbi)
+{
+	unsigned long long iostat_diff[NR_IO_TYPE];
+	int i;
+
+	if (time_is_after_jiffies(next_period))
+		return;
+
+	/* Need double check under the lock */
+	spin_lock(&iostat_lock);
+	if (time_is_after_jiffies(next_period)) {
+		spin_unlock(&iostat_lock);
+		return;
+	}
+	next_period = jiffies + msecs_to_jiffies(period_ms);
+	spin_unlock(&iostat_lock);
+
+	spin_lock(&sbi->iostat_lock);
+	for (i = 0; i < NR_IO_TYPE; i++) {
+		iostat_diff[i] = sbi->write_iostat[i] - f2fs_prev_iostat[i];
+		f2fs_prev_iostat[i] = sbi->write_iostat[i];
+	}
+	spin_unlock(&sbi->iostat_lock);
+
+	trace_f2fs_iostat(sbi, iostat_diff);
+}
+
 static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 					       void *offset)
 {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index d97adfc327f03..e78c8696e2adc 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1812,6 +1812,58 @@ DEFINE_EVENT(f2fs_zip_end, f2fs_decompress_pages_end,
 	TP_ARGS(inode, cluster_idx, compressed_size, ret)
 );
 
+TRACE_EVENT(f2fs_iostat,
+
+	TP_PROTO(struct f2fs_sb_info *sbi, unsigned long long *iostat),
+
+	TP_ARGS(sbi, iostat),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(unsigned long long,	app_dio)
+		__field(unsigned long long,	app_bio)
+		__field(unsigned long long,	app_wio)
+		__field(unsigned long long,	app_mio)
+		__field(unsigned long long,	fs_dio)
+		__field(unsigned long long,	fs_nio)
+		__field(unsigned long long,	fs_mio)
+		__field(unsigned long long,	fs_gc_dio)
+		__field(unsigned long long,	fs_gc_nio)
+		__field(unsigned long long,	fs_cp_dio)
+		__field(unsigned long long,	fs_cp_nio)
+		__field(unsigned long long,	fs_cp_mio)
+		__field(unsigned long long,	fs_discard)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sbi->sb->s_dev;
+		__entry->app_dio	= iostat[APP_DIRECT_IO];
+		__entry->app_bio	= iostat[APP_BUFFERED_IO];
+		__entry->app_wio	= iostat[APP_WRITE_IO];
+		__entry->app_mio	= iostat[APP_MAPPED_IO];
+		__entry->fs_dio		= iostat[FS_DATA_IO];
+		__entry->fs_nio		= iostat[FS_NODE_IO];
+		__entry->fs_mio		= iostat[FS_META_IO];
+		__entry->fs_gc_dio	= iostat[FS_GC_DATA_IO];
+		__entry->fs_gc_nio	= iostat[FS_GC_NODE_IO];
+		__entry->fs_cp_dio	= iostat[FS_CP_DATA_IO];
+		__entry->fs_cp_nio	= iostat[FS_CP_NODE_IO];
+		__entry->fs_cp_mio	= iostat[FS_CP_META_IO];
+		__entry->fs_discard	= iostat[FS_DISCARD];
+	),
+
+	TP_printk("dev = (%d,%d), "
+		"app [write=%llu (direct=%llu, buffered=%llu), mapped=%llu], "
+		"fs [data=%llu, node=%llu, meta=%llu, discard=%llu], "
+		"gc [data=%llu, node=%llu], "
+		"cp [data=%llu, node=%llu, meta=%llu]",
+		show_dev(__entry->dev), __entry->app_wio, __entry->app_dio,
+		__entry->app_bio, __entry->app_mio, __entry->fs_dio,
+		__entry->fs_nio, __entry->fs_mio, __entry->fs_discard,
+		__entry->fs_gc_dio, __entry->fs_gc_nio, __entry->fs_cp_dio,
+		__entry->fs_cp_nio, __entry->fs_cp_mio)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.26.0.110.g2183baf09c-goog

