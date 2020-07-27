Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E53FC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B865207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3SnS5cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbgG0O2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732716AbgG0O2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:28:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4DDC061794;
        Mon, 27 Jul 2020 07:28:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so8078105pls.5;
        Mon, 27 Jul 2020 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ByU1/eNsYuK+GvYyh2kCuTxeEuK1AGp+s4ZtpbXbVKU=;
        b=o3SnS5cuvequyTLFcS+lezgeWpNLkUtAmwe6DnMeHTy/MxmANCgHVsSpEhLvBTM76Z
         oLwhVYeuXBw39dvfolBjCQ9lW1sW8fF4vvwmhC2Yt4fVoa0er0GJeBTWN0nEn39fLeJu
         yJueqvcQ/qS6605ydP+dlCSsvWjg44rUT10pg12fePozF2rJkc6d5gXjGerCCvGLPED2
         CfCppqOH4SincYE547zDZ5H5gPMIkVuQ4Pgsmq0ZekfsiFKrkHPG9EoWpjV3W75klSeN
         fbP7dXwryyACOzbT3p5KlcZyhEuM6uUt1pJfRm1guIhBegsp0Dr72okkzz+Z/hz+QHmZ
         GpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ByU1/eNsYuK+GvYyh2kCuTxeEuK1AGp+s4ZtpbXbVKU=;
        b=a+t3yIDK2UD7wdW9vILB7C50kaww+OltZvrhmFFMn5uebqKCjf3NKNb9y0S/RPbz3x
         CU6qsbY0GGvnXtri1BxRchfHI41om6/jzK/Iz/kRisih45ZZMH+ShHPcuuovDcvOd5iD
         fHWVbjcJpytQIdiUuKKNQ6BqdzC8y0q5U/dHTGAnI5gZxG3PyL3HKBJGmWgaPgxQqG0d
         elMNclMV61uKXUdDkGAi+zkGvWxqFd9jF5TqqwQgkEQiz812dBC/vdmuHCJzhcUPaIgo
         6T/QfMneHNQlVaIq+0PbH+/1kuehl/KRQbcN2VM5juxIYdb5I7hKoTkR1xjF1PBB+tAq
         sxvA==
X-Gm-Message-State: AOAM5335aIiusjbIof65r1m23mwvuS6BCqUTyzBatFhSa1VBvMVituNG
        K4BC3Ck8d6o+zcNGO1RBJEwA+W/l2+c=
X-Google-Smtp-Source: ABdhPJyVv9oMvEfyk+7j0Q4ouhj0Zs/TlRaSAhSD3yKSd4N3VR8GQ1eYPDUyJVqxH5A0ymP0ZxUG+Q==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr3335612plx.109.1595860121354;
        Mon, 27 Jul 2020 07:28:41 -0700 (PDT)
Received: from carrot.localdomain (i60-35-88-138.s42.a014.ap.plala.or.jp. [60.35.88.138])
        by smtp.gmail.com with ESMTPSA id g18sm15430460pfk.40.2020.07.27.07.28.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:28:40 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] nilfs2: Convert __nilfs_msg to integrate the level and format
Date:   Mon, 27 Jul 2020 23:28:30 +0900
Message-Id: <1595860111-3920-3-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595860111-3920-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1595860111-3920-1-git-send-email-konishi.ryusuke@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

Reduce object size a bit by removing the KERN_<LEVEL> as a
separate argument and adding it to the format string.

Reduce overall object size by about ~.5% (x86-64 defconfig w/ nilfs2)

old:
$ size -t fs/nilfs2/built-in.a | tail -1
 191738	   8676	     44	 200458	  30f0a	(TOTALS)

new:
$ size -t fs/nilfs2/built-in.a | tail -1
 190971	   8676	     44	 199691	  30c0b	(TOTALS)

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/nilfs.h |  9 ++++-----
 fs/nilfs2/super.c | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 42395ba52da6..979a41016743 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -289,9 +289,8 @@ static inline int nilfs_mark_inode_dirty_sync(struct inode *inode)
 /* super.c */
 extern struct inode *nilfs_alloc_inode(struct super_block *);
 
-extern __printf(3, 4)
-void __nilfs_msg(struct super_block *sb, const char *level,
-		 const char *fmt, ...);
+__printf(2, 3)
+void __nilfs_msg(struct super_block *sb, const char *fmt, ...);
 extern __printf(3, 4)
 void __nilfs_error(struct super_block *sb, const char *function,
 		   const char *fmt, ...);
@@ -299,7 +298,7 @@ void __nilfs_error(struct super_block *sb, const char *function,
 #ifdef CONFIG_PRINTK
 
 #define nilfs_msg(sb, level, fmt, ...)					\
-	__nilfs_msg(sb, level, fmt, ##__VA_ARGS__)
+	__nilfs_msg(sb, level fmt, ##__VA_ARGS__)
 #define nilfs_error(sb, fmt, ...)					\
 	__nilfs_error(sb, __func__, fmt, ##__VA_ARGS__)
 
@@ -307,7 +306,7 @@ void __nilfs_error(struct super_block *sb, const char *function,
 
 #define nilfs_msg(sb, level, fmt, ...)					\
 	do {								\
-		no_printk(fmt, ##__VA_ARGS__);				\
+		no_printk(level fmt, ##__VA_ARGS__);			\
 		(void)(sb);						\
 	} while (0)
 #define nilfs_error(sb, fmt, ...)					\
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 5729ee86da9a..fef4821a1f0f 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -62,19 +62,25 @@
 static int nilfs_setup_super(struct super_block *sb, int is_mount);
 static int nilfs_remount(struct super_block *sb, int *flags, char *data);
 
-void __nilfs_msg(struct super_block *sb, const char *level, const char *fmt,
-		 ...)
+void __nilfs_msg(struct super_block *sb, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
+	int level;
 
 	va_start(args, fmt);
-	vaf.fmt = fmt;
+
+	level = printk_get_level(fmt);
+	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
+
 	if (sb)
-		printk("%sNILFS (%s): %pV\n", level, sb->s_id, &vaf);
+		printk("%c%cNILFS (%s): %pV\n",
+		       KERN_SOH_ASCII, level, sb->s_id, &vaf);
 	else
-		printk("%sNILFS: %pV\n", level, &vaf);
+		printk("%c%cNILFS: %pV\n",
+		       KERN_SOH_ASCII, level, &vaf);
+
 	va_end(args);
 }
 
-- 
1.8.3.1

