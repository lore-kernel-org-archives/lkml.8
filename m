Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18055C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4F220663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="JNL0TMcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgGMR23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbgGMR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:28:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B0CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:28:28 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id br7so4336383ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gueaV2wIJr/nXnGZ1QG9gTmS9FKOEq1Ps1eBHo/++Xs=;
        b=JNL0TMcuk4UDCLWif2LH8K842tkj63LpxOOpwvVsoreKcWtI8kX5Y3Y/pjW2LvJde9
         19Cl6JyvqLxD+0Eo7EdZOr/HsF+dSEsK3u3E+c3VP5iEB6cOGvfo9Zc3ONZrSM0AUpNC
         PJpdXxhiiGJpjkirDfQB3m5/MnP/bizl37Tog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gueaV2wIJr/nXnGZ1QG9gTmS9FKOEq1Ps1eBHo/++Xs=;
        b=Y8WSMa3cuwFZgN6uQHVa5IXgMF2K4SpicdThK8hWnS/1v0Y6r24KalpUEoRHbgo2sd
         l+mhWZ0dqY9w10hh2Qhpie/4AoMeFDk2AvrYzEiUQ4mPTF222jObzX2onSGE/V08dRRk
         1FvgRBklMmB3twNfcFfD75IZKCIVY0F7G36QWcPHj3S9uNvp7mEjbdn6feLxrQ+ZQ7dG
         nnOl7fHIMdadgcRiewKfyP2bSl2TwwQUFLe1boQyAzHQ7/DanMGqaK5xNHWXbAchsNRQ
         RDwIzXq2D/6dbGxZ9hptVEZBLoQ8TQzyvPaJ/TYEZW295/J1IqEBFxVl6rE5UmrUcWbe
         WFXg==
X-Gm-Message-State: AOAM531q9c2PCpYIT/xrQ/CE1ZjRP0e0rStro+YEsAy+xyBXUV2prFMY
        b338XEdIAlDwCr7fN0oRw4bQ8g==
X-Google-Smtp-Source: ABdhPJzGceRKr7Ho3EG48gwAk3TwXvpo8QcnBYzSqYibywqA+ihCr25RuKdCWVYt5p/2XCK8HAuGZw==
X-Received: by 2002:a17:906:3e13:: with SMTP id k19mr748174eji.476.1594661307342;
        Mon, 13 Jul 2020 10:28:27 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id gu15sm10117140ejb.111.2020.07.13.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:28:26 -0700 (PDT)
Date:   Mon, 13 Jul 2020 18:28:26 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <8b23758d0c66b5e2263e08baf9c4b6a7565cbd8f.1594661218.git.chris@chrisdown.name>
References: <cover.1594661218.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594661218.git.chris@chrisdown.name>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default is still set to inode32 for backwards compatibility, but
system administrators can opt in to the new 64-bit inode numbers by
either:

1. Passing inode64 on the command line when mounting, or
2. Configuring the kernel with CONFIG_TMPFS_INODE64=y

The inode64 and inode32 names are used based on existing precedent from
XFS.

Signed-off-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 Documentation/filesystems/tmpfs.rst | 11 +++++
 fs/Kconfig                          | 15 +++++++
 include/linux/shmem_fs.h            |  1 +
 mm/shmem.c                          | 65 ++++++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 4e95929301a5..47b84ddaa8bb 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -150,6 +150,15 @@ These options do not have any effect on remount. You can change these
 parameters with chmod(1), chown(1) and chgrp(1) on a mounted filesystem.
 
 
+tmpfs has a mount option to select whether it will wrap at 32- or 64-bit inode
+numbers:
+
+inode64   Use 64-bit inode numbers
+inode32   Use 32-bit inode numbers
+
+On 64-bit, the default is set by CONFIG_TMPFS_INODE64. On 32-bit, inode64 is
+not legal and will produce an error at mount time.
+
 So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
 will give you tmpfs instance on /mytmpfs which can allocate 10GB
 RAM/SWAP in 10240 inodes and it is only accessible by root.
@@ -161,3 +170,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by root.
    Hugh Dickins, 4 June 2007
 :Updated:
    KOSAKI Motohiro, 16 Mar 2010
+Updated:
+   Chris Down, 13 July 2020
diff --git a/fs/Kconfig b/fs/Kconfig
index ff257b81fde5..64d530ba42f6 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -229,6 +229,21 @@ config TMPFS_XATTR
 
 	  If unsure, say N.
 
+config TMPFS_INODE64
+	bool "Use 64-bit ino_t by default in tmpfs"
+	depends on TMPFS && 64BIT
+	default n
+	help
+	  tmpfs has historically used only inode numbers as wide as an unsigned
+	  int. In some cases this can cause wraparound, potentially resulting in
+	  multiple files with the same inode number on a single device. This option
+	  makes tmpfs use the full width of ino_t by default, similarly to the
+	  inode64 mount option.
+
+	  To override this default, use the inode32 or inode64 mount options.
+
+	  If unsure, say N.
+
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends on X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index eb628696ec66..a5a5d1d4d7b1 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -36,6 +36,7 @@ struct shmem_sb_info {
 	unsigned char huge;	    /* Whether to try for hugepages */
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
+	bool full_inums;	    /* If i_ino should be uint or ino_t */
 	ino_t next_ino;		    /* The next per-sb inode number to use */
 	ino_t __percpu *ino_batch;  /* The next per-cpu inode number to use */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
diff --git a/mm/shmem.c b/mm/shmem.c
index 0ae250b4da28..f3126ad7ba3d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -114,11 +114,13 @@ struct shmem_options {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
+	bool full_inums;
 	int huge;
 	int seen;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
+#define SHMEM_SEEN_INUMS 8
 };
 
 #ifdef CONFIG_TMPFS
@@ -286,12 +288,17 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
 			ino = sbinfo->next_ino++;
 			if (unlikely(is_zero_ino(ino)))
 				ino = sbinfo->next_ino++;
-			if (unlikely(ino > UINT_MAX)) {
+			if (unlikely(!sbinfo->full_inums &&
+				     ino > UINT_MAX)) {
 				/*
 				 * Emulate get_next_ino uint wraparound for
 				 * compatibility
 				 */
-				ino = 1;
+				if (IS_ENABLED(CONFIG_64BIT))
+					pr_warn("%s: inode number overflow on device %d, consider using inode64 mount option\n",
+						__func__, MINOR(sb->s_dev));
+				sbinfo->next_ino = 1;
+				ino = sbinfo->next_ino++;
 			}
 			*inop = ino;
 		}
@@ -304,6 +311,10 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
 		 * unknown contexts. As such, use a per-cpu batched allocator
 		 * which doesn't require the per-sb stat_lock unless we are at
 		 * the batch boundary.
+		 *
+		 * We don't need to worry about inode{32,64} since SB_KERNMOUNT
+		 * shmem mounts are not exposed to userspace, so we don't need
+		 * to worry about things like glibc compatibility.
 		 */
 		ino_t *next_ino;
 		next_ino = per_cpu_ptr(sbinfo->ino_batch, get_cpu());
@@ -3397,6 +3408,8 @@ enum shmem_param {
 	Opt_nr_inodes,
 	Opt_size,
 	Opt_uid,
+	Opt_inode32,
+	Opt_inode64,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3416,6 +3429,8 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_string("nr_inodes",	Opt_nr_inodes),
 	fsparam_string("size",		Opt_size),
 	fsparam_u32   ("uid",		Opt_uid),
+	fsparam_flag  ("inode32",	Opt_inode32),
+	fsparam_flag  ("inode64",	Opt_inode64),
 	{}
 };
 
@@ -3487,6 +3502,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 			break;
 		}
 		goto unsupported_parameter;
+	case Opt_inode32:
+		ctx->full_inums = false;
+		ctx->seen |= SHMEM_SEEN_INUMS;
+		break;
+	case Opt_inode64:
+		if (sizeof(ino_t) < 8) {
+			return invalfc(fc,
+				       "Cannot use inode64 with <64bit inums in kernel\n");
+		}
+		ctx->full_inums = true;
+		ctx->seen |= SHMEM_SEEN_INUMS;
+		break;
 	}
 	return 0;
 
@@ -3578,8 +3605,16 @@ static int shmem_reconfigure(struct fs_context *fc)
 		}
 	}
 
+	if ((ctx->seen & SHMEM_SEEN_INUMS) && !ctx->full_inums &&
+	    sbinfo->next_ino > UINT_MAX) {
+		err = "Current inum too high to switch to 32-bit inums";
+		goto out;
+	}
+
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
+	if (ctx->seen & SHMEM_SEEN_INUMS)
+		sbinfo->full_inums = ctx->full_inums;
 	if (ctx->seen & SHMEM_SEEN_BLOCKS)
 		sbinfo->max_blocks  = ctx->blocks;
 	if (ctx->seen & SHMEM_SEEN_INODES) {
@@ -3619,6 +3654,29 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	if (!gid_eq(sbinfo->gid, GLOBAL_ROOT_GID))
 		seq_printf(seq, ",gid=%u",
 				from_kgid_munged(&init_user_ns, sbinfo->gid));
+
+	/*
+	 * Showing inode{64,32} might be useful even if it's the system default,
+	 * since then people don't have to resort to checking both here and
+	 * /proc/config.gz to confirm 64-bit inums were successfully applied
+	 * (which may not even exist if IKCONFIG_PROC isn't enabled).
+	 *
+	 * We hide it when inode64 isn't the default and we are using 32-bit
+	 * inodes, since that probably just means the feature isn't even under
+	 * consideration.
+	 *
+	 * As such:
+	 *
+	 *                     +-----------------+-----------------+
+	 *                     | TMPFS_INODE64=y | TMPFS_INODE64=n |
+	 *  +------------------+-----------------+-----------------+
+	 *  | full_inums=true  | show            | show            |
+	 *  | full_inums=false | show            | hide            |
+	 *  +------------------+-----------------+-----------------+
+	 *
+	 */
+	if (IS_ENABLED(CONFIG_TMPFS_INODE64) || sbinfo->full_inums)
+		seq_printf(seq, ",inode%d", (sbinfo->full_inums ? 64 : 32));
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Rightly or wrongly, show huge mount option unmasked by shmem_huge */
 	if (sbinfo->huge)
@@ -3667,6 +3725,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 			ctx->blocks = shmem_default_max_blocks();
 		if (!(ctx->seen & SHMEM_SEEN_INODES))
 			ctx->inodes = shmem_default_max_inodes();
+		if (!(ctx->seen & SHMEM_SEEN_INUMS))
+			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
 	} else {
 		sb->s_flags |= SB_NOUSER;
 	}
@@ -3684,6 +3744,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sbinfo->uid = ctx->uid;
 	sbinfo->gid = ctx->gid;
+	sbinfo->full_inums = ctx->full_inums;
 	sbinfo->mode = ctx->mode;
 	sbinfo->huge = ctx->huge;
 	sbinfo->mpol = ctx->mpol;
-- 
2.27.0

