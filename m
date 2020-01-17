Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016BEC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5FE24681
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAQKIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:08:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55338 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgAQKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYV-0005RS-27; Fri, 17 Jan 2020 11:08:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6A42F1C19CF;
        Fri, 17 Jan 2020 11:08:41 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:41 -0000
From:   "tip-bot2 for Peng Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix sgc->{min,max}_capacity calculation
 for SD_OVERLAP
Cc:     Peng Liu <iwtbavbm@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
References: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Message-ID: <157925572126.396.16039413045911352646.tip-bot2@tip-bot2>
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

Commit-ID:     4c58f57fa6e93318a0899f70d8b99fe6bac22ce8
Gitweb:        https://git.kernel.org/tip/4c58f57fa6e93318a0899f70d8b99fe6bac22ce8
Author:        Peng Liu <iwtbavbm@gmail.com>
AuthorDate:    Sat, 04 Jan 2020 21:08:28 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:21 +01:00

sched/fair: Fix sgc->{min,max}_capacity calculation for SD_OVERLAP

commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
sched_group_capacity") introduced per-cpu min_capacity.

commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
introduced per-cpu max_capacity.

In the SD_OVERLAP case, the local variable 'capacity' represents the sum
of CPU capacity of all CPUs in the first sched group (sg) of the sched
domain (sd).

It is erroneously used to calculate sg's min and max CPU capacity.
To fix this use capacity_of(cpu) instead of 'capacity'.

The code which achieves this via cpu_rq(cpu)->sd->groups->sgc->capacity
(for rq->sd != NULL) can be removed since it delivers the same value as
capacity_of(cpu) which is currently only used for the (!rq->sd) case
(see update_cpu_capacity()).
An sg of the lowest sd (rq->sd or sd->child == NULL) represents a single
CPU (and hence sg->sgc->capacity == capacity_of(cpu)).

Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ
---
 kernel/sched/fair.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 32c5421..e84723c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7802,29 +7802,11 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 		 */
 
 		for_each_cpu(cpu, sched_group_span(sdg)) {
-			struct sched_group_capacity *sgc;
-			struct rq *rq = cpu_rq(cpu);
+			unsigned long cpu_cap = capacity_of(cpu);
 
-			/*
-			 * build_sched_domains() -> init_sched_groups_capacity()
-			 * gets here before we've attached the domains to the
-			 * runqueues.
-			 *
-			 * Use capacity_of(), which is set irrespective of domains
-			 * in update_cpu_capacity().
-			 *
-			 * This avoids capacity from being 0 and
-			 * causing divide-by-zero issues on boot.
-			 */
-			if (unlikely(!rq->sd)) {
-				capacity += capacity_of(cpu);
-			} else {
-				sgc = rq->sd->groups->sgc;
-				capacity += sgc->capacity;
-			}
-
-			min_capacity = min(capacity, min_capacity);
-			max_capacity = max(capacity, max_capacity);
+			capacity += cpu_cap;
+			min_capacity = min(cpu_cap, min_capacity);
+			max_capacity = max(cpu_cap, max_capacity);
 		}
 	} else  {
 		/*
