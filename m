Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BEF206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZdu1WhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbgFWAqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbgFWAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:46:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B70C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:45:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b4so17338399qkn.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U5u5cQtMfW2cY2gSCcV6gUwhOVtzA52lPIPVAy1oiys=;
        b=sZdu1WhQqVwDW+IbO6JNJgAoa3N768tGjh9bCNKMujlDBwqoDnLme9XPx/jwLJyBan
         vQVFmVzg9Zvep72uCoVWq3Uy5M3ACF8vVWo4SmZ+k0QZ2D7jJdbJZ3zBK8W+PKWht91q
         V1tPooX5Q50F4NjdPj3K9lY4gYaq9Rpzu6oViPky1FawQ5WRabPgDsYM4qM4yzPwM2zA
         wZU8bdjlksD4v0Lh1AJileKGdGBkJtE+Vjoq9M3Gmr7g4gqMFavYjzzzV6dUqrG5kqIM
         vXFK1hry2LbS9CJQebgM0hI/A/xS4m3MgiF74TWA8wusPBnvENGznqxuoPzCP03r/fIm
         dHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U5u5cQtMfW2cY2gSCcV6gUwhOVtzA52lPIPVAy1oiys=;
        b=jb4iMkzrG8lzkzBpZvpTFy9WhXE0Pd/N09QjEQC3mJmVIx1JBLnupMshng6bt0AKo1
         1RZ8vChTbu+l3fKOABXbGJux8joAbpabbL0whgqSM3chx26/mRUYOzLOY8OpoGW5Iww0
         GNQeCFEtBFOgpv+Gq51ZIXMPCYgIWAnqK7AuCmWAmVyZsREd21gvu5TFGquuoXrE/ipD
         YsppdhD+tRhNV9OAuZdDcVr9Q5mSDYpwaeHf7+hMdlD4TTGaDIbKP3RBGu2CsY7/6qld
         lHi4QdfixM6J/M2cgqpHGz9b3mCCY/WCaC34fZ2SAzGiQxLJl+ML132W4LjlZb2bMyqm
         hk4w==
X-Gm-Message-State: AOAM533NyU+P9vOF/dHIunMbL/tv4X1lAbqpdaUBLHt7OxGxu6aXzlkp
        yR9WTtk0jBJHqUl7ZEegDw6JECAL
X-Google-Smtp-Source: ABdhPJyuCI7reyD1jdfvBnEhiieQ0mKVveGrfTeFQrFISXc4nPWHXrX93HOKxj6LW5KagCMnWKl6Sw==
X-Received: by 2002:a05:620a:52a:: with SMTP id h10mr18033907qkh.185.1592873127773;
        Mon, 22 Jun 2020 17:45:27 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id r2sm9493715qtn.27.2020.06.22.17.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:45:27 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Janos Farkas <chexum+dev@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v1 2/2] romfs: address performance regression since v3.10
Date:   Mon, 22 Jun 2020 20:45:20 -0400
Message-Id: <20200623004520.26520-3-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623004520.26520-1-TheSven73@gmail.com>
References: <20200623004520.26520-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem
-------
romfs sequential read performance has regressed very badly since
v3.10. Currently, reading a large file inside a romfs image is
up to 12x slower compared to reading the romfs image directly.

Benchmarks:
- use a romfs image which contains a single 250M file
- calculate the md5sum of the romfs image directly (test 1)
  $ time md5sum image.romfs
- loop-mount the romfs image, and calc the md5sum of the file
  inside it (test 2)
  $ mount -o loop,ro image.romfs /mnt/romfs
  $ time md5sum /mnt/romfs/file
- drop caches in between
  $ echo 3 > /proc/sys/vm/drop_caches

imx6 (arm cortex a9) on emmc, running v5.7.2:
(test 1)  5 seconds
(test 2) 60 seconds (12x slower)

Intel i7-3630QM on Samsung SSD 850 EVO (EMT02B6Q),
    running Ubuntu with v4.15.0-106-generic:
(test 1) 1.3 seconds
(test 2) 3.3 seconds (2.5x slower)

To show that a regression has occurred since v3.10:

imx6 on emmc, running v3.10.17:
(test 1) 16 seconds
(test 2) 18 seconds

Proposed Solution
-----------------
Increase the blocksize from 1K to PAGE_SIZE. This brings the
sequential read performance close to where it was on v3.10:

imx6 on emmc, running v5.7.2:
(test 2 1K blocksize) 60 seconds
(test 2 4K blocksize) 22 seconds

Intel on Ubuntu running v4.15:
(test 2 1K blocksize) 3.3 seconds
(test 2 4K blocksize) 1.9 seconds

There is a risk that this may increase latency on random-
access workloads. But the test below suggests that this
is not a concern:

Benchmark:
- use a 630M romfs image consisting of 9600 files
- loop-mount the romfs image
  $ mount -o loop,ro image.romfs /mnt/romfs
- drop all caches
- list all files in the filesystem (test 3)
  $ time find /mnt/romfs > /dev/null

imx6 on emmc, running v5.7.2:
(test 3 1K blocksize) 9.5 seconds
(test 3 4K blocksize) 9   seconds

Intel on Ubuntu, running v4.15:
(test 3 1K blocksize) 1.4 seconds
(test 3 4K blocksize) 1.2 seconds

Practical Solution
------------------
Introduce a mount-option called 'largeblocks'. If present,
increase the blocksize for much better sequential performance.

Note that the Linux block layer can only support n-K blocks if
the underlying block device length is also aligned to n-K. This
may not always be the case. Therefore, the driver will pick the
largest blocksize which the underlying block device can support.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Janos Farkas <chexum+dev@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
To: linux-kernel@vger.kernel.org
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 fs/romfs/super.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 6fecdea791f1..93565aeaa43c 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -65,7 +65,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
-#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/statfs.h>
@@ -460,6 +460,54 @@ static __u32 romfs_checksum(const void *data, int size)
 	return sum;
 }
 
+enum romfs_param {
+	Opt_largeblocks,
+};
+
+static const struct fs_parameter_spec romfs_fs_parameters[] = {
+	fsparam_flag("largeblocks", Opt_largeblocks),
+	{}
+};
+
+/*
+ * Parse a single mount parameter.
+ */
+static int romfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, romfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_largeblocks:
+		fc->fs_private = (void *) 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * pick the largest blocksize which the underlying block device
+ * is a multiple of. Or fall back to legacy (ROMBSIZE).
+ */
+static int romfs_largest_blocksize(struct super_block *sb)
+{
+	loff_t device_sz = i_size_read(sb->s_bdev->bd_inode);
+	int blksz;
+
+	for (blksz = PAGE_SIZE; blksz > ROMBSIZE; blksz >>= 1)
+		if ((device_sz % blksz) == 0)
+			break;
+
+	return blksz;
+}
+
 /*
  * fill in the superblock
  */
@@ -467,17 +515,19 @@ static int romfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct romfs_super_block *rsb;
 	struct inode *root;
-	unsigned long pos, img_size;
+	unsigned long pos, img_size, dev_blocksize;
 	const char *storage;
 	size_t len;
 	int ret;
 
 #ifdef CONFIG_BLOCK
+	dev_blocksize = fc->fs_private ? romfs_largest_blocksize(sb) :
+					 ROMBSIZE;
 	if (!sb->s_mtd) {
-		sb_set_blocksize(sb, ROMBSIZE);
+		sb_set_blocksize(sb, dev_blocksize);
 	} else {
-		sb->s_blocksize = ROMBSIZE;
-		sb->s_blocksize_bits = blksize_bits(ROMBSIZE);
+		sb->s_blocksize = dev_blocksize;
+		sb->s_blocksize_bits = blksize_bits(dev_blocksize);
 	}
 #endif
 
@@ -573,6 +623,7 @@ static int romfs_get_tree(struct fs_context *fc)
 static const struct fs_context_operations romfs_context_ops = {
 	.get_tree	= romfs_get_tree,
 	.reconfigure	= romfs_reconfigure,
+	.parse_param	= romfs_parse_param,
 };
 
 /*
@@ -607,6 +658,7 @@ static struct file_system_type romfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "romfs",
 	.init_fs_context = romfs_init_fs_context,
+	.parameters	= romfs_fs_parameters,
 	.kill_sb	= romfs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
-- 
2.17.1

