Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78565C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502A9208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596028958;
	bh=2nO1aS9EUs24pPVkavg7mosszYZtF5AQTrcRye3PWI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eLxwGf658CbMbwWEd45KFVZ7LwrId5+IlEew+3AVjFYvTAmIHAr6YgvKtAxdVFwba
	 m2YSJu8BwF7EadyEXc4dP//CjCjNakN4I/w1PSl5iAMFHX7SJt5jXvzGBN//I6Q5TX
	 B19rot+7xhzQt5tKUut2UjZubGip3mjLgSDxvn6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgG2NWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgG2NWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:22:34 -0400
Received: from localhost.localdomain (unknown [49.65.247.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 445C420829;
        Wed, 29 Jul 2020 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596028953;
        bh=2nO1aS9EUs24pPVkavg7mosszYZtF5AQTrcRye3PWI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTlBironlpJOkLWkS4ZrSH2Cu33V9KhUh0n/hJq7JEr8gq7JDcAhG/+zYxjMpjsFG
         DCVIplbZTbeV/GfSaktdtqs6o/uAGR0dYQb74POhIZK1bG8T30wmjPXao2v+iCmSzc
         edDC3+n4lGO/vK66ZnwBn1TAaTqKt2JLhLLRPJLk=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: compress: disable compression mount option if compression is off
Date:   Wed, 29 Jul 2020 21:21:36 +0800
Message-Id: <20200729132136.11134-2-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200729132136.11134-1-chao@kernel.org>
References: <20200729132136.11134-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

If CONFIG_F2FS_FS_COMPRESSION is off, don't allow to configure or
show compression related mount option.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5e0a3eeb8ca4..cdca2087dba0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -460,9 +460,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	substring_t args[MAX_OPT_ARGS];
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 	unsigned char (*ext)[F2FS_EXTENSION_LEN];
+	int ext_cnt;
+#endif
 	char *p, *name;
-	int arg = 0, ext_cnt;
+	int arg = 0;
 	kuid_t uid;
 	kgid_t gid;
 	int ret;
@@ -853,6 +856,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_checkpoint_enable:
 			clear_opt(sbi, DISABLE_CHECKPOINT);
 			break;
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 		case Opt_compress_algorithm:
 			if (!f2fs_sb_has_compression(sbi)) {
 				f2fs_err(sbi, "Compression feature if off");
@@ -918,6 +922,13 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
+#else
+		case Opt_compress_algorithm:
+		case Opt_compress_log_size:
+		case Opt_compress_extension:
+			f2fs_info(sbi, "compression options not supported");
+			break;
+#endif
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -1608,7 +1619,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
 		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 	f2fs_show_compress_options(seq, sbi->sb);
+#endif
 	return 0;
 }
 
-- 
2.22.0

