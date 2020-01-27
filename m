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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61730C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388B5214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9E6IKBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgA0KOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:14:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36196 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbgA0KOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:14:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so4911474pgc.3;
        Mon, 27 Jan 2020 02:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uIY1k/F4qz3I9+Mt+13/qHd1W5zwRU5xiYnctorVf9s=;
        b=K9E6IKBgLDiZ4rZHU6pLuv+HuDinxTG20+j7jESDU7/MrY8ctb6JnOy/0v1rOe33Mb
         2lIJLledCslf3q4Eh628Kx4EEe9wrE+IuPn4Or4Kbh/QDcpz2+w2DWjQezHNC9e0YjPX
         Eje6Ii3GAxiC5nhmuyQ6puhrNa2V/5N108VINROcuMlUMlHA1D9sG9diulGC//cLvaSh
         LNdOmBYX5njp2bk+K5F9eXGBipnTWUEa+bTRb9WaH2DjpFcfS2IjWCEpasKY3r05U0yj
         IwhkOU/LVezEaMDm2osuvz0KYkhPimlZoafU9eLOdeSEvv6M6RNUv1SYUeC7WE28EEkU
         9iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uIY1k/F4qz3I9+Mt+13/qHd1W5zwRU5xiYnctorVf9s=;
        b=nAfkWzNPu7iK78+O5UW/rLplA3/bpnbTuT47tWR03yzIkAkOkXd4HOsOwhMtaq9Qfn
         CYv6sHHZ6UHA1hhGeFh4lo1dOsBTaSZojhABxykWTyvZzUEYILV+5UcrAN5NzcSl+XOZ
         Up5MxRdfFKq9giajPnoeFA8HQN+S/mjrs/wRrGxYgqsC/+YYJvT2ElALSUX7fRfPoWnb
         tN5e0i/KNGfgtV0QQ3WsF6gNxSLtUwR878NxIonC9tBk27/ywiyUm3QNOzT6ByrLg9qe
         sTiVcLBxtjdAN/XWr0qk8YpRyHpGnST8sMJkbcnhJLQqWzjZ8aWrckZsWXrMSqJEb3cx
         10FA==
X-Gm-Message-State: APjAAAXVANBGPPWixOhex/QrWIBswUqFvBGOdR6IG+t7lzMKVje1zgK9
        XhfvY+BpmZatWThSwvqRmpg=
X-Google-Smtp-Source: APXvYqw+L6a9eNgpKTF+4PAjoBGxr5E4VNY826eU/e+46nQSddWXCgcHa7rr6EfX8oWos7ZqikE8OQ==
X-Received: by 2002:a63:6c03:: with SMTP id h3mr17732122pgc.19.1580120092628;
        Mon, 27 Jan 2020 02:14:52 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:14:52 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 06/22] staging: exfat: Rename variable "Second" to "second"
Date:   Mon, 27 Jan 2020 15:43:27 +0530
Message-Id: <20200127101343.20415-7-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change all the occurrences of "Second" to "second" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 755e2fd6e3fd..85fbea44219a 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -227,7 +227,7 @@ struct date_time_t {
 	u16      day;
 	u16      hour;
 	u16      minute;
-	u16      Second;
+	u16      second;
 	u16      MilliSecond;
 };
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 70fa5f118a38..0582c49f091d 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -60,7 +60,7 @@ static void exfat_write_super(struct super_block *sb);
 static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 {
 	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->day,
-			      tp->hour, tp->minute, tp->Second);
+			      tp->hour, tp->minute, tp->second);
 
 	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
 }
@@ -75,7 +75,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 
 	if (second < UNIX_SECS_1980) {
 		tp->MilliSecond = 0;
-		tp->Second	= 0;
+		tp->second	= 0;
 		tp->minute	= 0;
 		tp->hour	= 0;
 		tp->day		= 1;
@@ -86,7 +86,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 
 	if (second >= UNIX_SECS_2108) {
 		tp->MilliSecond = 999;
-		tp->Second	= 59;
+		tp->second	= 59;
 		tp->minute	= 59;
 		tp->hour	= 23;
 		tp->day		= 31;
@@ -96,7 +96,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	}
 
 	tp->MilliSecond = ts->tv_nsec / NSEC_PER_MSEC;
-	tp->Second	= tm.tm_sec;
+	tp->second	= tm.tm_sec;
 	tp->minute	= tm.tm_min;
 	tp->hour	= tm.tm_hour;
 	tp->day		= tm.tm_mday;
@@ -1510,7 +1510,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->CreateTimestamp.day = tm.day;
 	info->CreateTimestamp.hour = tm.hour;
 	info->CreateTimestamp.minute = tm.min;
-	info->CreateTimestamp.Second = tm.sec;
+	info->CreateTimestamp.second = tm.sec;
 	info->CreateTimestamp.MilliSecond = 0;
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
@@ -1519,7 +1519,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->ModifyTimestamp.day = tm.day;
 	info->ModifyTimestamp.hour = tm.hour;
 	info->ModifyTimestamp.minute = tm.min;
-	info->ModifyTimestamp.Second = tm.sec;
+	info->ModifyTimestamp.second = tm.sec;
 	info->ModifyTimestamp.MilliSecond = 0;
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
@@ -1605,7 +1605,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	p_fs->fs_func->set_entry_attr(ep, info->Attr);
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
-	tm.sec  = info->CreateTimestamp.Second;
+	tm.sec  = info->CreateTimestamp.second;
 	tm.min  = info->CreateTimestamp.minute;
 	tm.hour = info->CreateTimestamp.hour;
 	tm.day  = info->CreateTimestamp.day;
@@ -1613,7 +1613,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.year = info->CreateTimestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
 
-	tm.sec  = info->ModifyTimestamp.Second;
+	tm.sec  = info->ModifyTimestamp.second;
 	tm.min  = info->ModifyTimestamp.minute;
 	tm.hour = info->ModifyTimestamp.hour;
 	tm.day  = info->ModifyTimestamp.day;
@@ -1930,7 +1930,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.day = tm.day;
 			dir_entry->CreateTimestamp.hour = tm.hour;
 			dir_entry->CreateTimestamp.minute = tm.min;
-			dir_entry->CreateTimestamp.Second = tm.sec;
+			dir_entry->CreateTimestamp.second = tm.sec;
 			dir_entry->CreateTimestamp.MilliSecond = 0;
 
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
@@ -1939,7 +1939,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->ModifyTimestamp.day = tm.day;
 			dir_entry->ModifyTimestamp.hour = tm.hour;
 			dir_entry->ModifyTimestamp.minute = tm.min;
-			dir_entry->ModifyTimestamp.Second = tm.sec;
+			dir_entry->ModifyTimestamp.second = tm.sec;
 			dir_entry->ModifyTimestamp.MilliSecond = 0;
 
 			memset((char *)&dir_entry->AccessTimestamp, 0,
-- 
2.17.1

