Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EA6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAD220734
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLqUdOr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgGSFoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 01:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgGSFoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 01:44:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30637C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 22:44:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so7185975pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 22:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7Hio3ZAZnC6526MvIONhlzLrk1YgS7ld2jxR+GeflQ=;
        b=fLqUdOr4VU4tq/6gLs5t5PoruMXnM60xzwj4nm/rI2NEWsnb35rAtEfIofwcRYqdJa
         OLJBy4xPM+q3zL1rJpYMl1Pz7Oky/QqWJm47XIqBm4mPsP+QXkR8jBwptUcVp7UNyyZU
         RN7Bpe9vle1BdJOTrEt6FiAhxOS/hwjoVmJyV4OV+Fx35/H2AN4emcdCKKa8nddjY1/q
         FEFRlX91hM56PXm6jdlF3MVVlKG8juwlMgppelUmFq9z6CFKEmLXKmI3iYq6Bt1J+VUy
         U+ozuK8vgJj4wATl/bx1GFLRhMizWdXH3i4BXz12rhKGEl0j0ovBqVBkMfnyef19/uqk
         sBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7Hio3ZAZnC6526MvIONhlzLrk1YgS7ld2jxR+GeflQ=;
        b=EbzdDNvdReRqqZgaIgVLf2bgeGy05AoacDDkeUiqUQ7yCbecsp0cxHSVBT/XFgCdp1
         7ntTGDA0vBmBsIcaiuybbnivM6XjqivHZKhfA+8EuQDFQWfC0qVnGZC7U7h4Y18vPxps
         OziJEbLo3eYCyDywUFWKjFIae1ctUDPgYx+KJhPitlo04GJe3RWPDjIg5/a3N3qExJve
         9NW10zCiDLGGDn2sOnnCQTbFlSlr/0tfWNnj96v3xwsIMjSRB2dTLu2avfOj5UT6cFuB
         7Ggu1l3k2kzP1ce/ey15Dhkxr6GmPsBWTCT2+DXhU6cKYRbzPpMNwmOhxUutHLTZI36m
         H54w==
X-Gm-Message-State: AOAM533oSZiXpCHkMM3mMpPcZdPDLSsqokqzQi46YlWLtuj7jf0Aqedg
        VqB4/5TYwPDcqp27ecJwdTh3NuJPA9M=
X-Google-Smtp-Source: ABdhPJxJHgXS/HkIxS066qjd5z+2CBE7YzM/F7vAQFmMUEXQ8N22mPsMqj1X7zV+tHQDrd9UOYidCA==
X-Received: by 2002:a17:902:5981:: with SMTP id p1mr13024975pli.141.1595137478312;
        Sat, 18 Jul 2020 22:44:38 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id l207sm12573821pfd.79.2020.07.18.22.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 22:44:37 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs: add volume_name mount option
Date:   Sun, 19 Jul 2020 14:44:09 +0900
Message-Id: <20200719054409.3050516-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200719054409.3050516-1-daeho43@gmail.com>
References: <20200719054409.3050516-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added "volume_name" mount option. When the volume name in the on-disk
superblock doesn't exist, we can input the volume name as a mount
option and this is used to create a sysfs symbolic link pointing to
/sys/fs/f2fs/<disk>. The format of the symbolic directory link is like
/sys/fs/f2fs/<volume_name>_<num>, <volume_name> is the passed volume
name and <num> means the order of mounting with the same volume name.
When the on-disk volume name already exists, this mount option will be
ignored.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/filesystems/f2fs.rst |  8 ++++++++
 fs/f2fs/super.c                    | 23 +++++++++++++++++++++++
 fs/f2fs/sysfs.c                    | 14 +++++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 8221f3af6042..07507bed4fc1 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -260,6 +260,14 @@ compress_extension=%s  Support adding specified extension, so that f2fs can enab
                        For other files, we can still enable compression via ioctl.
                        Note that, there is one reserved special extension '*', it
                        can be set to enable compression for all files.
+volume_name=%s         When the volume name in the on-disk superblock doesn't exist,
+                       we can input the volume name as a mount option and this is
+                       used to create a sysfs symbolic link pointing to
+                       /sys/fs/f2fs/<disk>. The format of the symbolic directory
+                       link is like /sys/fs/f2fs/<volume_name>_<num>, <volume_name>
+                       is the passed volume name and <num> means the order of mounting
+                       with the same volume name. When the on-disk volume name already
+                       exists, this mount option will be ignored.
 ====================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7b002785417a..18d0a535697d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -145,6 +145,7 @@ enum {
 	Opt_compress_algorithm,
 	Opt_compress_log_size,
 	Opt_compress_extension,
+	Opt_volume_name,
 	Opt_err,
 };
 
@@ -211,6 +212,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_compress_algorithm, "compress_algorithm=%s"},
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
+	{Opt_volume_name, "volume_name=%s"},
 	{Opt_err, NULL},
 };
 
@@ -918,6 +920,21 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
+		case Opt_volume_name:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+
+			if (strlen(name) > MAX_VOLUME_NAME) {
+				f2fs_err(sbi,
+					"Volume name is too long");
+				kfree(name);
+				return -EINVAL;
+			}
+
+			strncpy(sbi->syslink_name, name, MAX_VOLUME_NAME);
+			kfree(name);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -1609,6 +1626,12 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
 
 	f2fs_show_compress_options(seq, sbi->sb);
+
+	mutex_lock(&sbi->syslink_mutex);
+	if (f2fs_has_syslink(sbi))
+		seq_printf(seq, ",volume_name=%s", sbi->syslink_name);
+	mutex_unlock(&sbi->syslink_mutex);
+
 	return 0;
 }
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e9818dd338c1..6d4a2f8aa0d7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -907,7 +907,7 @@ static void f2fs_unload_syslink(struct f2fs_sb_info *sbi)
 	memset(sbi->syslink_name, 0, MAX_SYSLINK_NAME);
 }
 
-static int f2fs_load_syslink(struct f2fs_sb_info *sbi)
+static int f2fs_load_syslink(struct f2fs_sb_info *sbi, bool mount)
 {
 	int idx, count, ret;
 
@@ -918,6 +918,14 @@ static int f2fs_load_syslink(struct f2fs_sb_info *sbi)
 			MAX_VOLUME_NAME);
 	up_read(&sbi->sb_lock);
 
+	if (mount) {
+		if (count)
+			memset(sbi->syslink_name + count, 0,
+					MAX_SYSLINK_NAME - count);
+		else
+			count = strlen(sbi->syslink_name);
+	}
+
 	if (!count)
 		return -ENOENT;
 
@@ -939,7 +947,7 @@ void f2fs_reload_syslink(struct f2fs_sb_info *sbi)
 {
 	mutex_lock(&sbi->syslink_mutex);
 	f2fs_unload_syslink(sbi);
-	f2fs_load_syslink(sbi);
+	f2fs_load_syslink(sbi, false);
 	mutex_unlock(&sbi->syslink_mutex);
 }
 
@@ -1001,7 +1009,7 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				victim_bits_seq_show, sb);
 	}
 
-	f2fs_load_syslink(sbi);
+	f2fs_load_syslink(sbi, true);
 
 	return 0;
 }
-- 
2.28.0.rc0.105.gf9edc3c819-goog

