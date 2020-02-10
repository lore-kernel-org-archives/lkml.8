Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B6C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E5820715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/98isVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgBJSiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:38:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42836 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgBJSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:38:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so4342857pgl.9;
        Mon, 10 Feb 2020 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uBIMPOfBTgLJ9F750/zExiDaSZF5wks+0wth9UWA4bI=;
        b=U/98isVs+NwvcG+k1yzIV1AwWoGla2g9i9qTnLHOqSS8BRRNMC96ve09aw8HaUzEpW
         wFN5RpVv++OyXfxe9TCEH/eNMtfeebT5TpCoxN7ZBKM5CVgm0jNsfmjCdP4RffwbaAf0
         MV0bvZ4W28jcJQLZwCwh4zw1+a9TsXYoRa4e5o0ZNFISoHZAVBUs4hU+fhFPy5aBQA8u
         mX/bfG+x6/g8aaNN2OH/45+W3tq8MWy32MDChjn1ZNITQdIr4rdTbWkAnEwa9XIVEAzw
         uZPRXdJGUlVBB+Ha4xxzXB/PigbYa2nQRZ49eEpmIPSskCS+ImdOhOhr3oeUMmZAGEJX
         dvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uBIMPOfBTgLJ9F750/zExiDaSZF5wks+0wth9UWA4bI=;
        b=T0JEHfAveLru5Ae8yVTBgFEF+lGOzMX6FsWRqnYC3Kf0Juud6uSdzRjY0xUQdYgmLO
         cvdZY40ZpBEkeKQ10XeUgNoSg9k+1uuddB/M0BBJnall+gUOFkYgMyR/fPA3e8uO1Ql2
         jnBFk4y35rCUZm1ETBt7U4t2v3k4TwuXn/RuJVvLrGSNKSmEu7VPc0CcyY4TnXbMOHaW
         KcLiE0iz/Xd8Cny0L62DTdafN5PhjWGsbV0rVphyf3vKHaVykOYiHZDfxgvk3q4CdwZh
         VXEz/RXp32cbsnCULoLhh+Vb2Bx4jV6UMHNUqWL1NwuTrA9ihyCO5LhTZVZPDfnXITlZ
         Qc0Q==
X-Gm-Message-State: APjAAAUPwIhqrNcNNciz0r+GQsxGkP32p1JROouh7kmcET0gD+zsohyv
        aVeSJ3eryb8dGWoZL5MHLxHX3XgNxjk=
X-Google-Smtp-Source: APXvYqwCMF/9v7IHSJ4pTeCAIoaJLAOduHtDR6jO86pAdhAkqZ6nPja5IitT53QOBf/e2R9mgMmfUA==
X-Received: by 2002:a63:f0a:: with SMTP id e10mr2706771pgl.402.1581359880044;
        Mon, 10 Feb 2020 10:38:00 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:59 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 18/19] staging: exfat: Rename variable 'ModifyTimestamp' to 'modify_timestamp'
Date:   Tue, 11 Feb 2020 00:05:57 +0530
Message-Id: <20200210183558.11836-19-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "ModifyTimestamp" to
"modify_timestamp"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 46 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c99652ab13f1..2c911f1ea949 100644
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
index ed862c3e3e10..7388aa8fb344 100644
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
 	info->create_timestamp.millisecond = 0;
 
 	exfat_get_entry_time(ep, &tm, TM_MODIFY);
-	info->ModifyTimestamp.year = tm.year;
-	info->ModifyTimestamp.month = tm.mon;
-	info->ModifyTimestamp.day = tm.day;
-	info->ModifyTimestamp.hour = tm.hour;
-	info->ModifyTimestamp.minute = tm.min;
-	info->ModifyTimestamp.second = tm.sec;
-	info->ModifyTimestamp.millisecond = 0;
+	info->modify_timestamp.year = tm.year;
+	info->modify_timestamp.month = tm.mon;
+	info->modify_timestamp.day = tm.day;
+	info->modify_timestamp.hour = tm.hour;
+	info->modify_timestamp.minute = tm.min;
+	info->modify_timestamp.second = tm.sec;
+	info->modify_timestamp.millisecond = 0;
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
 
@@ -1613,12 +1613,12 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.year = info->create_timestamp.year;
 	exfat_set_entry_time(ep, &tm, TM_CREATE);
 
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
 	exfat_set_entry_time(ep, &tm, TM_MODIFY);
 
 	exfat_set_entry_size(ep2, info->Size);
@@ -1931,13 +1931,13 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->create_timestamp.millisecond = 0;
 
 			exfat_get_entry_time(ep, &tm, TM_MODIFY);
-			dir_entry->ModifyTimestamp.year = tm.year;
-			dir_entry->ModifyTimestamp.month = tm.mon;
-			dir_entry->ModifyTimestamp.day = tm.day;
-			dir_entry->ModifyTimestamp.hour = tm.hour;
-			dir_entry->ModifyTimestamp.minute = tm.min;
-			dir_entry->ModifyTimestamp.second = tm.sec;
-			dir_entry->ModifyTimestamp.millisecond = 0;
+			dir_entry->modify_timestamp.year = tm.year;
+			dir_entry->modify_timestamp.month = tm.mon;
+			dir_entry->modify_timestamp.day = tm.day;
+			dir_entry->modify_timestamp.hour = tm.hour;
+			dir_entry->modify_timestamp.minute = tm.min;
+			dir_entry->modify_timestamp.second = tm.sec;
+			dir_entry->modify_timestamp.millisecond = 0;
 
 			memset((char *)&dir_entry->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
@@ -3188,7 +3188,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 	inode->i_blocks = ((i_size_read(inode) + (p_fs->cluster_size - 1))
 				& ~((loff_t)p_fs->cluster_size - 1)) >> 9;
 
-	exfat_time_fat2unix(&inode->i_mtime, &info.ModifyTimestamp);
+	exfat_time_fat2unix(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_fat2unix(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_fat2unix(&inode->i_atime, &info.AccessTimestamp);
 
@@ -3259,7 +3259,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	info.attr = exfat_make_attr(inode);
 	info.Size = i_size_read(inode);
 
-	exfat_time_unix2fat(&inode->i_mtime, &info.ModifyTimestamp);
+	exfat_time_unix2fat(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_unix2fat(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
 
-- 
2.17.1

