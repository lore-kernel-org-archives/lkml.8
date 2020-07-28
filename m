Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF0BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5832820786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgG1JE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:04:56 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:21905 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgG1JEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:04:55 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 05:04:55 EDT
Received: from wwh-vos.localdomain (unknown [58.251.74.227])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id C46B9107E9C;
        Tue, 28 Jul 2020 16:58:27 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Wang Wenhu <wenhu.wang@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched: loadavg: delete useless param ticks for calc_global_load
Date:   Tue, 28 Jul 2020 16:58:07 +0800
Message-Id: <20200728085809.60132-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk1OTB4fShlLQkJMVkpOQk5CSU1MSklOSEpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6KAw6HD8qPQ8#Dg8RGCEt
        KQxPFEtVSlVKTkJOQklNTEpJQkJCVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUhLQ0g3Bg++
X-HM-Tid: 0a7394a501109374kuwsc46b9107e9c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only parameter "unsigned long ticks" for calc_global_load is
never used inside the function definition. Delete it now.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
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
@@ -2193,7 +2193,7 @@ EXPORT_SYMBOL(ktime_get_coarse_ts64);
 void do_timer(unsigned long ticks)
 {
 	jiffies_64 += ticks;
-	calc_global_load(ticks);
+	calc_global_load();
 }
 
 /**
-- 
2.17.1

