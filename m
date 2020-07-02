Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660D82071A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbeCyT/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGBEOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGBEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:14:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43CC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:14:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so8360649pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+qX1WR+/gY97AaJQlkMfUlyzd/SfBNCNoFC77bQsTs=;
        b=lbeCyT/DAkeQAHhQ5m+WLWcWjrSEnlmLRE83XTDyxwUGaKQJLoPzJvkpW7XDC60AOu
         3c1vrs4JK+eHFPnRvaMdq8HllHWtbOxT1w42NIc/JBGf+Rtp4f+IdjiQsZHJQd6TAZZV
         5x3X0Tf1hTlZ02jeKfK+ZV9U6395ts6u9rZiSm5kyASWzg+gBNJi9UdcLo8YnqkowlhV
         mm4RTl5ijWvUWTx+fnbfLBUamlUFrJy2ouCXMBIxifOeVAR4y03qZGHiAiU6mSsbWD+z
         bbFeu7Jg9eGC9xqmI9JsmhfT0j9U/DHD7o4CKK2EP4PMTrUOWZLYDMFtOF3vJG1yAUUR
         hlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+qX1WR+/gY97AaJQlkMfUlyzd/SfBNCNoFC77bQsTs=;
        b=bss4SuGAmPGVlIrEFJYzHHQkfziEhCRslQkO7NdOPZuuO2NbIDkygHe05ROZ0Hqg6G
         x2tfp3yW3stBDhGfyreujPMjOr7xkmJtpvUce/hqe29VY6DyATyaS2ScmHxo+XSyaJ4r
         uw6JDojpoHC7UrBmuVBmFs4FpXWiZRQcjYs43MCxdvkNC54QELmZJ6q4oyOOU3JHTDF/
         //InkjBVTtTsGLbjTUU8KlAtaexSxkSyi3g+HEj3CzmO7prFRW877zB0CEpl8fr9oTGd
         2xVMW0kiEELu0i3P5QTaR7ruRf4g3aBHNjyiXJdS5rq4HHnOtkmbfA5VF6TdVPpWolAV
         r2Mw==
X-Gm-Message-State: AOAM530TX84c1Fukq97P1X3XQwayfUIkEpTMaF+UDwomF7LEeTCKA3o8
        NalPV4WeSsNDOQ3818O1G88oVlCS
X-Google-Smtp-Source: ABdhPJx6AOnqfO2ng21YQ93yxGxgEIlpQuRdxJr8ZZAUKpzhtmUNz8VBWieLaSp82cA4IpT2r1qxig==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr30490284pjb.111.1593663263997;
        Wed, 01 Jul 2020 21:14:23 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id m140sm7569714pfd.195.2020.07.01.21.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:14:23 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: add GC_URGENT_LOW mode in gc_urgent
Date:   Thu,  2 Jul 2020 13:14:14 +0900
Message-Id: <20200702041414.3017119-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new gc_urgent mode, GC_URGENT_LOW, in which mode
F2FS will lower the bar of checking idle in order to
process outstanding discard commands and GC a little bit
aggressively.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  4 +++-
 fs/f2fs/f2fs.h                          | 10 ++++++++--
 fs/f2fs/gc.c                            |  6 +++---
 fs/f2fs/segment.c                       |  4 ++--
 fs/f2fs/sysfs.c                         | 10 +++++++---
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 4bb93a06d8ab..7f730c4c8df2 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -229,7 +229,9 @@ Date:		August 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Do background GC agressively when set. When gc_urgent = 1,
 		background thread starts to do GC by given gc_urgent_sleep_time
-		interval. It is set to 0 by default.
+		interval. When gc_urgent = 2, F2FS will lower the bar of
+		checking idle in order to process outstanding discard commands
+		and GC a little bit aggressively. It is set to 0 by default.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent_sleep_time
 Date:		August 2017
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6e47618a357..4b28fd42fdbc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1283,7 +1283,8 @@ enum {
 	GC_NORMAL,
 	GC_IDLE_CB,
 	GC_IDLE_GREEDY,
-	GC_URGENT,
+	GC_URGENT_HIGH,
+	GC_URGENT_LOW,
 };
 
 enum {
@@ -1540,6 +1541,7 @@ struct f2fs_sb_info {
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
 	unsigned int next_victim_seg[2];	/* next segment in victim section */
+
 	/* for skip statistic */
 	unsigned int atomic_files;              /* # of opened atomic file */
 	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
@@ -2480,7 +2482,7 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 
 static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
-	if (sbi->gc_mode == GC_URGENT)
+	if (sbi->gc_mode == GC_URGENT_HIGH)
 		return true;
 
 	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
@@ -2498,6 +2500,10 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 			atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
 		return false;
 
+	if (sbi->gc_mode == GC_URGENT_LOW &&
+			(type == DISCARD_TIME || type == GC_TIME))
+		return true;
+
 	return f2fs_time_over(sbi, type);
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6eec3b2d606d..3b718da69910 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -82,7 +82,7 @@ static int gc_thread_func(void *data)
 		 * invalidated soon after by user update or deletion.
 		 * So, I'd like to wait some time to collect dirty segments.
 		 */
-		if (sbi->gc_mode == GC_URGENT) {
+		if (sbi->gc_mode == GC_URGENT_HIGH) {
 			wait_ms = gc_th->urgent_sleep_time;
 			down_write(&sbi->gc_lock);
 			goto do_gc;
@@ -176,7 +176,7 @@ static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
 		gc_mode = GC_CB;
 		break;
 	case GC_IDLE_GREEDY:
-	case GC_URGENT:
+	case GC_URGENT_HIGH:
 		gc_mode = GC_GREEDY;
 		break;
 	}
@@ -211,7 +211,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 	 * foreground GC and urgent GC cases.
 	 */
 	if (gc_type != FG_GC &&
-			(sbi->gc_mode != GC_URGENT) &&
+			(sbi->gc_mode != GC_URGENT_HIGH) &&
 			p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45e473508a9..5924b3965ae4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -174,7 +174,7 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
 
 	if (f2fs_lfs_mode(sbi))
 		return false;
-	if (sbi->gc_mode == GC_URGENT)
+	if (sbi->gc_mode == GC_URGENT_HIGH)
 		return true;
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return true;
@@ -1759,7 +1759,7 @@ static int issue_discard_thread(void *data)
 			continue;
 		}
 
-		if (sbi->gc_mode == GC_URGENT)
+		if (sbi->gc_mode == GC_URGENT_HIGH)
 			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
 
 		sb_start_intwrite(sbi->sb);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e877c59b9fdb..2a140657fc4d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -350,16 +350,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return -EINVAL;
 
 	if (!strcmp(a->attr.name, "gc_urgent")) {
-		if (t >= 1) {
-			sbi->gc_mode = GC_URGENT;
+		if (t == 0) {
+			sbi->gc_mode = GC_NORMAL;
+		} else if (t == 1) {
+			sbi->gc_mode = GC_URGENT_HIGH;
 			if (sbi->gc_thread) {
 				sbi->gc_thread->gc_wake = 1;
 				wake_up_interruptible_all(
 					&sbi->gc_thread->gc_wait_queue_head);
 				wake_up_discard_thread(sbi, true);
 			}
+		} else if (t == 2) {
+			sbi->gc_mode = GC_URGENT_LOW;
 		} else {
-			sbi->gc_mode = GC_NORMAL;
+			return -EINVAL;
 		}
 		return count;
 	}
-- 
2.27.0.383.g050319c2ae-goog

