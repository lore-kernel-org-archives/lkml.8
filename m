Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945A1C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BD620754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCTM6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35632 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgCTM6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDv-0003iT-QJ; Fri, 20 Mar 2020 13:58:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 685F31C22BF;
        Fri, 20 Mar 2020 13:58:03 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:03 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: cpupri_find: Trigger a full search as fallback
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200310142219.syxzn5ljpdxqtbgx@e107158-lin.cambridge.arm.com>
References: <20200310142219.syxzn5ljpdxqtbgx@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Message-ID: <158470908311.28353.10090988248383112451.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e94f80f6c49020008e6fa0f3d4b806b8595d17d8
Gitweb:        https://git.kernel.org/tip/e94f80f6c49020008e6fa0f3d4b806b8595d17d8
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 05 Mar 2020 10:24:50 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:20 +01:00

sched/rt: cpupri_find: Trigger a full search as fallback

If we failed to find a fitting CPU, in cpupri_find(), we only fallback
to the level we found a hit at.

But Steve suggested to fallback to a second full scan instead as this
could be a better effort.

	https://lore.kernel.org/lkml/20200304135404.146c56eb@gandalf.local.home/

We trigger the 2nd search unconditionally since the argument about
triggering a full search is that the recorded fall back level might have
become empty by then. Which means storing any data about what happened
would be meaningless and stale.

I had a humble try at timing it and it seemed okay for the small 6 CPUs
system I was running on

	https://lore.kernel.org/lkml/20200305124324.42x6ehjxbnjkklnh@e107158-lin.cambridge.arm.com/

On large system this second full scan could be expensive. But there are
no users outside capacity awareness for this fitness function at the
moment. Heterogeneous systems tend to be small with 8cores in total.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20200310142219.syxzn5ljpdxqtbgx@e107158-lin.cambridge.arm.com
---
 kernel/sched/cpupri.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index dd3f16d..0033731 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -122,8 +122,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 		bool (*fitness_fn)(struct task_struct *p, int cpu))
 {
 	int task_pri = convert_prio(p->prio);
-	int best_unfit_idx = -1;
-	int idx = 0, cpu;
+	int idx, cpu;
 
 	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
 
@@ -145,31 +144,15 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 		 * If no CPU at the current priority can fit the task
 		 * continue looking
 		 */
-		if (cpumask_empty(lowest_mask)) {
-			/*
-			 * Store our fallback priority in case we
-			 * didn't find a fitting CPU
-			 */
-			if (best_unfit_idx == -1)
-				best_unfit_idx = idx;
-
+		if (cpumask_empty(lowest_mask))
 			continue;
-		}
 
 		return 1;
 	}
 
 	/*
-	 * If we failed to find a fitting lowest_mask, make sure we fall back
-	 * to the last known unfitting lowest_mask.
-	 *
-	 * Note that the map of the recorded idx might have changed since then,
-	 * so we must ensure to do the full dance to make sure that level still
-	 * holds a valid lowest_mask.
-	 *
-	 * As per above, the map could have been concurrently emptied while we
-	 * were busy searching for a fitting lowest_mask at the other priority
-	 * levels.
+	 * If we failed to find a fitting lowest_mask, kick off a new search
+	 * but without taking into account any fitness criteria this time.
 	 *
 	 * This rule favours honouring priority over fitting the task in the
 	 * correct CPU (Capacity Awareness being the only user now).
@@ -184,8 +167,8 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 	 * must do proper RT planning to avoid overloading the system if they
 	 * really care.
 	 */
-	if (best_unfit_idx != -1)
-		return __cpupri_find(cp, p, lowest_mask, best_unfit_idx);
+	if (fitness_fn)
+		return cpupri_find(cp, p, lowest_mask);
 
 	return 0;
 }
