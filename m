Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FD4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7065420801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFLKNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:13:22 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:58202 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726258AbgFLKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:13:18 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 12 Jun 2020 18:43:15 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.225.35)
        by 156.147.1.121 with ESMTP; 12 Jun 2020 18:43:15 +0900
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From:   Hyunchul Lee <hyc.lee@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: [PATCH 2/2] exfat: allow to change some mount options for remount
Date:   Fri, 12 Jun 2020 18:42:50 +0900
Message-Id: <20200612094250.9347-2-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612094250.9347-1-hyc.lee@gmail.com>
References: <20200612094250.9347-1-hyc.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to change permission masks, allow_utime,
errors. But ignore other options.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/exfat/super.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 61c6cf240c19..3c1d47289ba2 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -696,9 +696,13 @@ static void exfat_free(struct fs_context *fc)
 static int exfat_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_mount_options *new_opts;
 	int ret;
 	bool new_rdonly;
 
+	new_opts = &((struct exfat_sb_info *)fc->s_fs_info)->options;
+
 	new_rdonly = fc->sb_flags & SB_RDONLY;
 	if (new_rdonly != sb_rdonly(sb)) {
 		if (new_rdonly) {
@@ -708,6 +712,12 @@ static int exfat_reconfigure(struct fs_context *fc)
 				return ret;
 		}
 	}
+
+	/* allow to change these options but ignore others */
+	sbi->options.fs_fmask = new_opts->fs_fmask;
+	sbi->options.fs_dmask = new_opts->fs_dmask;
+	sbi->options.allow_utime = new_opts->allow_utime;
+	sbi->options.errors = new_opts->errors;
 	return 0;
 }
 
@@ -726,17 +736,25 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	if (!sbi)
 		return -ENOMEM;
 
-	mutex_init(&sbi->s_lock);
-	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
-			DEFAULT_RATELIMIT_BURST);
-
-	sbi->options.fs_uid = current_uid();
-	sbi->options.fs_gid = current_gid();
-	sbi->options.fs_fmask = current->fs->umask;
-	sbi->options.fs_dmask = current->fs->umask;
-	sbi->options.allow_utime = -1;
-	sbi->options.iocharset = exfat_default_iocharset;
-	sbi->options.errors = EXFAT_ERRORS_RO;
+	if (fc->root) {
+		/* reconfiguration */
+		memcpy(&sbi->options, &EXFAT_SB(fc->root->d_sb)->options,
+			sizeof(struct exfat_mount_options));
+		sbi->options.iocharset = exfat_default_iocharset;
+	} else {
+		mutex_init(&sbi->s_lock);
+		ratelimit_state_init(&sbi->ratelimit,
+				DEFAULT_RATELIMIT_INTERVAL,
+				DEFAULT_RATELIMIT_BURST);
+
+		sbi->options.fs_uid = current_uid();
+		sbi->options.fs_gid = current_gid();
+		sbi->options.fs_fmask = current->fs->umask;
+		sbi->options.fs_dmask = current->fs->umask;
+		sbi->options.allow_utime = -1;
+		sbi->options.iocharset = exfat_default_iocharset;
+		sbi->options.errors = EXFAT_ERRORS_RO;
+	}
 
 	fc->s_fs_info = sbi;
 	fc->ops = &exfat_context_ops;
-- 
2.17.1

