Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3C0C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6172082D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgDHL4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:56:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgDHL4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:56:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D9C8B1FD422C2A0619FE;
        Wed,  8 Apr 2020 19:56:40 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 19:56:34 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: support lzo-rle compress algorithm
Date:   Wed, 8 Apr 2020 19:56:32 +0800
Message-ID: <20200408115632.15712-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LZO-RLE extension (run length encoding) was introduced to improve
performance of LZO algorithm in scenario of data contains many zeros,
zram has changed to use this extended algorithm by default, this
patch adds to support this algorithm extension, to enable this
extension, it needs to enable F2FS_FS_LZO and F2FS_FS_LZORLE config,
and specifies "compress_algorithm=lzo-rle" mountoption.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt |  2 +-
 fs/f2fs/Kconfig                    | 10 ++++++++++
 fs/f2fs/compress.c                 | 30 ++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/super.c                    |  7 +++++++
 include/trace/events/f2fs.h        |  3 ++-
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index b1a66cf0e967..f3f1184cca29 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -236,7 +236,7 @@ checkpoint=%s[:%u[%]]     Set to "disable" to turn off checkpointing. Set to "en
                        would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
                        This space is reclaimed once checkpoint=enable.
 compress_algorithm=%s  Control compress algorithm, currently f2fs supports "lzo",
-                       "lz4" and "zstd" algorithm.
+                       "lz4", "zstd" and "lzo-rle" algorithm.
 compress_log_size=%u   Support configuring compress cluster size, the size will
                        be 4KB * (1 << %u), 16KB is minimum size, also it's
                        default size.
diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index bb68d21e1f8c..d13c5c6a9787 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -127,3 +127,13 @@ config F2FS_FS_ZSTD
 	default y
 	help
 	  Support ZSTD compress algorithm, if unsure, say Y.
+
+config F2FS_FS_LZORLE
+	bool "LZO-RLE compression support"
+	depends on F2FS_FS_COMPRESSION
+	depends on F2FS_FS_LZO
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+	default y
+	help
+	  Support LZO-RLE compress algorithm, if unsure, say Y.
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ac265c6c40b5..498e0c2ba6ea 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -442,6 +442,31 @@ static const struct f2fs_compress_ops f2fs_zstd_ops = {
 };
 #endif
 
+#ifdef CONFIG_F2FS_FS_LZO
+#ifdef CONFIG_F2FS_FS_LZORLE
+static int lzorle_compress_pages(struct compress_ctx *cc)
+{
+	int ret;
+
+	ret = lzorle1x_1_compress(cc->rbuf, cc->rlen, cc->cbuf->cdata,
+					&cc->clen, cc->private);
+	if (ret != LZO_E_OK) {
+		printk_ratelimited("%sF2FS-fs (%s): lzo-rle compress failed, ret:%d\n",
+				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id, ret);
+		return -EIO;
+	}
+	return 0;
+}
+
+static const struct f2fs_compress_ops f2fs_lzorle_ops = {
+	.init_compress_ctx	= lzo_init_compress_ctx,
+	.destroy_compress_ctx	= lzo_destroy_compress_ctx,
+	.compress_pages		= lzorle_compress_pages,
+	.decompress_pages	= lzo_decompress_pages,
+};
+#endif
+#endif
+
 static const struct f2fs_compress_ops *f2fs_cops[COMPRESS_MAX] = {
 #ifdef CONFIG_F2FS_FS_LZO
 	&f2fs_lzo_ops,
@@ -458,6 +483,11 @@ static const struct f2fs_compress_ops *f2fs_cops[COMPRESS_MAX] = {
 #else
 	NULL,
 #endif
+#if defined(CONFIG_F2FS_FS_LZO) && defined(CONFIG_F2FS_FS_LZORLE)
+	&f2fs_lzorle_ops,
+#else
+	NULL,
+#endif
 };
 
 bool f2fs_is_compress_backend_ready(struct inode *inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e0d520f2c142..f2071bb72deb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1272,6 +1272,7 @@ enum compress_algorithm_type {
 	COMPRESS_LZO,
 	COMPRESS_LZ4,
 	COMPRESS_ZSTD,
+	COMPRESS_LZORLE,
 	COMPRESS_MAX,
 };
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9ad927c4d259..a321d78e8601 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -833,6 +833,10 @@ static int parse_options(struct super_block *sb, char *options)
 					!strcmp(name, "zstd")) {
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_ZSTD;
+			} else if (strlen(name) == 7 &&
+					!strcmp(name, "lzo-rle")) {
+				F2FS_OPTION(sbi).compress_algorithm =
+								COMPRESS_LZORLE;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -1426,6 +1430,9 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 	case COMPRESS_ZSTD:
 		algtype = "zstd";
 		break;
+	case COMPRESS_LZORLE:
+		algtype = "lzo-rle";
+		break;
 	}
 	seq_printf(seq, ",compress_algorithm=%s", algtype);
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index d97adfc327f0..226ac89cf7c9 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -154,7 +154,8 @@ TRACE_DEFINE_ENUM(CP_PAUSE);
 	__print_symbolic(type,						\
 		{ COMPRESS_LZO,		"LZO" },			\
 		{ COMPRESS_LZ4,		"LZ4" },			\
-		{ COMPRESS_ZSTD,	"ZSTD" })
+		{ COMPRESS_ZSTD,	"ZSTD" },			\
+		{ COMPRESS_LZORLE,	"LZO-RLE" })
 
 struct f2fs_sb_info;
 struct f2fs_io_info;
-- 
2.18.0.rc1

