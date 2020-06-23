Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D54C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7733D20786
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgFWHTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbgFWHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:19:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAAC061573;
        Tue, 23 Jun 2020 00:19:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jndDb-0003Bn-56; Tue, 23 Jun 2020 09:19:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D64161C0470;
        Tue, 23 Jun 2020 09:19:41 +0200 (CEST)
Date:   Tue, 23 Jun 2020 07:19:41 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: s/WF_ON_RQ/WQ_ON_CPU/
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200622100825.785115830@infradead.org>
References: <20200622100825.785115830@infradead.org>
MIME-Version: 1.0
Message-ID: <159289678161.16989.18175975273999269504.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     38d8705bb63d19747eb6259c22c54d18cc47e4f7
Gitweb:        https://git.kernel.org/tip/38d8705bb63d19747eb6259c22c54d18cc47e4f7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Jun 2020 12:01:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Jun 2020 20:51:06 +02:00

sched: s/WF_ON_RQ/WQ_ON_CPU/

Avoids confusion...

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20200622100825.785115830@infradead.org
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/sched.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3328c29..019db7a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2376,7 +2376,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	 * the soon-to-be-idle CPU as the current CPU is likely busy.
 	 * nr_running is checked to avoid unnecessary task stacking.
 	 */
-	if ((wake_flags & WF_ON_RQ) && cpu_rq(cpu)->nr_running <= 1)
+	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
 		return true;
 
 	return false;
@@ -2636,7 +2636,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * scheduling.
 	 */
 	if (smp_load_acquire(&p->on_cpu) &&
-	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_RQ))
+	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
 		goto unlock;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d4e94c..877fb08 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1682,7 +1682,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
 #define WF_MIGRATED		0x04		/* Internal use, task got migrated */
-#define WF_ON_RQ		0x08		/* Wakee is on_rq */
+#define WF_ON_CPU		0x08		/* Wakee is on_cpu */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
