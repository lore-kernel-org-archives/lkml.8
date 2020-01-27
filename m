Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247A8C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20B320661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoshAeqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgA0KQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:16:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37767 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgA0KQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:16:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so4924730pga.4;
        Mon, 27 Jan 2020 02:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PRL92drL21zY0Q9t9ZySq6tJLHhcfzKy1Z3/kgM9dTw=;
        b=EoshAeqbl0tp+i7ZOK2uOymTRiS8FAn8OLNj7lsYqpY4k0jJbWs+/IoZ0iXYOfzb0g
         Mq4BtMFtuAYcVsmlYTeizIHACl4L6nUMDSuUCbvv6JG8cUMKVVbZUV1Kyi0Wh9m5k1D8
         2txE3nuY8ydP/ZLBry+QvsCJTS2ssXfUOvk0CdbTzHpO2qVfO01loKWqT9MdnWbOl79k
         vnib7r7HDPVL76U/gYzb6jYL1cilRKtzF0dFRcKPGtLLneE8YTQoz7wfWNxFHBEh+ZEL
         Iy3cZOjDI7J3EIMKabbhMKQGdsiq4sz2oGW3ySv0bC/OGPLThIU+HNmeenrs6W5boGMv
         wGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PRL92drL21zY0Q9t9ZySq6tJLHhcfzKy1Z3/kgM9dTw=;
        b=HXkOkgvlRMxen9q53sK3qwWOp5RxWp9IYgfJYAhglri9pnq5ozSdNiUY5X6kjtD+PQ
         HAjJxm2WGS8Vf0XnCmmwo4DTRktnPw5UyFdZWKADy71Fs2xOkxJeEfkQx6R70Rf6IVyI
         yV2PkM0rGKJCbOSjP66FZEYtrFXd7V9yCFq5Lqd8Jpkpeq4YxeaCfgLB+ghGef3wiifN
         MOATFfV2v6yPBzLzgfFxDZNzmaocb0ZdlpHcllSKwTmuKlWMVqy7SKRfmRznlDwQwVtL
         dYb9zycA/jvId6dIUmWt2jbvq9ymQjW230r8CL98mfgzjoLDdW+BHlmoJvXm9WqmxTfN
         cIMQ==
X-Gm-Message-State: APjAAAWUbL3eH6fcubXh/kCfIAcK67z4FxJjiCc3byud/VIjuTFLZCuj
        +Hd6ey1rRVrk3TM8bdE4u6A=
X-Google-Smtp-Source: APXvYqxbAroxE4Q/rtQsO4UKtr31V2/raCu+0yDkH8B7Fj/HwAxXh3HUhH9GjQnGrkpXATh/eyjtsw==
X-Received: by 2002:a62:e414:: with SMTP id r20mr15373253pfh.154.1580120165390;
        Mon, 27 Jan 2020 02:16:05 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:16:04 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 21/22] staging: exfat: Rename variable "ModifyTimestamp" to "modify_timestamp"
Date:   Mon, 27 Jan 2020 15:43:42 +0530
Message-Id: <20200127101343.20415-22-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change all the occurrences of "ModifyTimestamp" to "modify_timestamp" in
exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 46 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 9b3b4a6f586b..92f36fcc4591 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -279,7 +279,7 @@ struct dir_entry_t {
 	u64 Size;
 	u32 num_subdirs;
 	struct date_time_t create_timestamp;
-	struct date_time_t ModifyTimestamp;
+	struct date_time_t modify_timestamp;
 	struct date_time_t AccessTimestamp;
 };
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 4279fb309f9e..3fb7977ef27f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1460,7 +1460,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			info->attr = ATTR_SUBDIR;
 			memset((char *)&info->create_timestamp, 0,
 			       sizeof(struct date_time_t));
-			memset((char *)&info->ModifyTimestamp, 0,
+			memset((char *)&info->modify_timestamp, 0,
 			       sizeof(struct date_time_t));
 			memset((char *)&info->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
@@ -1514,13 +1514,13 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->create_timestamp.milli_second = 0;
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
-	info->ModifyTimestamp.year = tm.year;
-	info->ModifyTimestamp.month = tm.mon;
-	info->ModifyTimestamp.day = tm.day;
-	info->ModifyTimestamp.hour = tm.hour;
-	info->ModifyTimestamp.minute = tm.min;
-	info->ModifyTimestamp.second = tm.sec;
-	info->ModifyTimestamp.milli_second = 0;
+	info->modify_timestamp.year = tm.year;
+	info->modify_timestamp.month = tm.mon;
+	info->modify_timestamp.day = tm.day;
+	info->modify_timestamp.hour = tm.hour;
+	info->modify_timestamp.minute = tm.min;
+	info->modify_timestamp.second = tm.sec;
+	info->modify_timestamp.milli_second = 0;
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
 
@@ -1613,12 +1613,12 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.year = info->create_timestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
 
-	tm.sec  = info->ModifyTimestamp.second;
-	tm.min  = info->ModifyTimestamp.minute;
-	tm.hour = info->ModifyTimestamp.hour;
-	tm.day  = info->ModifyTimestamp.day;
-	tm.mon  = info->ModifyTimestamp.month;
-	tm.year = info->ModifyTimestamp.year;
+	tm.sec  = info->modify_timestamp.second;
+	tm.min  = info->modify_timestamp.minute;
+	tm.hour = info->modify_timestamp.hour;
+	tm.day  = info->modify_timestamp.day;
+	tm.mon  = info->modify_timestamp.month;
+	tm.year = info->modify_timestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_MODIFY);
 
 	p_fs->fs_func->set_entry_size(ep2, info->Size);
@@ -1934,13 +1934,13 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->create_timestamp.milli_second = 0;
 
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
-			dir_entry->ModifyTimestamp.year = tm.year;
-			dir_entry->ModifyTimestamp.month = tm.mon;
-			dir_entry->ModifyTimestamp.day = tm.day;
-			dir_entry->ModifyTimestamp.hour = tm.hour;
-			dir_entry->ModifyTimestamp.minute = tm.min;
-			dir_entry->ModifyTimestamp.second = tm.sec;
-			dir_entry->ModifyTimestamp.milli_second = 0;
+			dir_entry->modify_timestamp.year = tm.year;
+			dir_entry->modify_timestamp.month = tm.mon;
+			dir_entry->modify_timestamp.day = tm.day;
+			dir_entry->modify_timestamp.hour = tm.hour;
+			dir_entry->modify_timestamp.minute = tm.min;
+			dir_entry->modify_timestamp.second = tm.sec;
+			dir_entry->modify_timestamp.milli_second = 0;
 
 			memset((char *)&dir_entry->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
@@ -3191,7 +3191,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 	inode->i_blocks = ((i_size_read(inode) + (p_fs->cluster_size - 1))
 				& ~((loff_t)p_fs->cluster_size - 1)) >> 9;
 
-	exfat_time_fat2unix(&inode->i_mtime, &info.ModifyTimestamp);
+	exfat_time_fat2unix(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_fat2unix(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_fat2unix(&inode->i_atime, &info.AccessTimestamp);
 
@@ -3262,7 +3262,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	info.attr = exfat_make_attr(inode);
 	info.Size = i_size_read(inode);
 
-	exfat_time_unix2fat(&inode->i_mtime, &info.ModifyTimestamp);
+	exfat_time_unix2fat(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_unix2fat(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
 
-- 
2.17.1

