Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8BFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A612D2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgGASg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:36:58 -0400
Received: from mail5.windriver.com ([192.103.53.11]:52022 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgGASg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:36:57 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 061IZqNx013904
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 1 Jul 2020 11:36:03 -0700
Received: from yow-pgortmak-d4.wrs.com (128.224.56.60) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Jul 2020 11:35:42 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH] sched: nohz: stop passing around unused "ticks" parameter.
Date:   Wed, 1 Jul 2020 14:34:18 -0400
Message-ID: <1593628458-32290-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ticks" parameter was added in commit 0f004f5a696a ("sched: Cure more
NO_HZ load average woes") since calc_global_nohz() was called and needed
the "ticks" argument.

But in commit c308b56b5398 ("sched: Fix nohz load accounting -- again!")
it became unused as the function calc_global_nohz() dropped using "ticks".

Fixes: c308b56b5398 ("sched: Fix nohz load accounting -- again!")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/sched/loadavg.h | 2 +-
 kernel/sched/loadavg.c        | 2 +-
 kernel/time/timekeeping.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/loadavg.h b/include/linux/sched/loadavg.h
index 4859bea47a7b..83ec54b65e79 100644
--- a/include/linux/sched/loadavg.h
+++ b/include/linux/sched/loadavg.h
@@ -43,6 +43,6 @@ extern unsigned long calc_load_n(unsigned long load, unsigned long exp,
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 
-extern void calc_global_load(unsigned long ticks);
+extern void calc_global_load(void);
 
 #endif /* _LINUX_SCHED_LOADAVG_H */
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index de22da666ac7..d2a655643a02 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -347,7 +347,7 @@ static inline void calc_global_nohz(void) { }
  *
  * Called from the global timer code.
  */
-void calc_global_load(unsigned long ticks)
+void calc_global_load(void)
 {
 	unsigned long sample_window;
 	long active, delta;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d20d489841c8..63a632f9896c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2193,7 +2193,7 @@ void ktime_get_coarse_ts64(struct timespec64 *ts)
 void do_timer(unsigned long ticks)
 {
 	jiffies_64 += ticks;
-	calc_global_load(ticks);
+	calc_global_load();
 }
 
 /**
-- 
3.9.1

