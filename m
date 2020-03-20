Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E572C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB520776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCTM7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:59:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35619 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgCTM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDz-0003ie-Jp; Fri, 20 Mar 2020 13:58:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 258F51C22BF;
        Fri, 20 Mar 2020 13:58:04 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:03 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Improve spreading of utilization
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200312165429.990-1-vincent.guittot@linaro.org>
References: <20200312165429.990-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <158470908386.28353.10623151233945522135.tip-bot2@tip-bot2>
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

Commit-ID:     c32b4308295aaaaedd5beae56cb42e205ae63e58
Gitweb:        https://git.kernel.org/tip/c32b4308295aaaaedd5beae56cb42e205ae63e58
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 12 Mar 2020 17:54:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:20 +01:00

sched/fair: Improve spreading of utilization

During load_balancing, a group with spare capacity will try to pull some
utilizations from an overloaded group. In such case, the load balance
looks for the runqueue with the highest utilization. Nevertheless, it
should also ensure that there are some pending tasks to pull otherwise
the load balance will fail to pull a task and the spread of the load will
be delayed.

This situation is quite transient but it's possible to highlight the
effect with a short run of sysbench test so the time to spread task impacts
the global result significantly.

Below are the average results for 15 iterations on an arm64 octo core:
sysbench --test=cpu --num-threads=8  --max-requests=1000 run

                           tip/sched/core  +patchset
total time:                172ms           158ms
per-request statistics:
         avg:                1.337ms         1.244ms
         max:               21.191ms        10.753ms

The average max doesn't fully reflect the wide spread of the value which
ranges from 1.350ms to more than 41ms for the tip/sched/core and from
1.350ms to 21ms with the patch.

Other factors like waiting for an idle load balance or cache hotness
can delay the spreading of the tasks which explains why we can still
have up to 21ms with the patch.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200312165429.990-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c7aaae2..783356f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9313,6 +9313,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		case migrate_util:
 			util = cpu_util(cpu_of(rq));
 
+			/*
+			 * Don't try to pull utilization from a CPU with one
+			 * running task. Whatever its utilization, we will fail
+			 * detach the task.
+			 */
+			if (nr_running <= 1)
+				continue;
+
 			if (busiest_util < util) {
 				busiest_util = util;
 				busiest = rq;
