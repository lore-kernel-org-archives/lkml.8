Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F799C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF0820FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgFPMXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgFPMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61850C08C5C4;
        Tue, 16 Jun 2020 05:22:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbF-0004gO-BB; Tue, 16 Jun 2020 14:21:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 995791C0833;
        Tue, 16 Jun 2020 14:21:52 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:52 -0000
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Optimize dl_bw_cpus()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520134243.19352-2-dietmar.eggemann@arm.com>
References: <20200520134243.19352-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <159231011243.16989.7064939919417124511.tip-bot2@tip-bot2>
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

Commit-ID:     c81b89329933c6c0be809d4c0d2cb57c49153ee3
Gitweb:        https://git.kernel.org/tip/c81b89329933c6c0be809d4c0d2cb57c49153ee3
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 20 May 2020 15:42:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:04 +02:00

sched/deadline: Optimize dl_bw_cpus()

Return the weight of the root domain (rd) span in case it is a subset
of the cpu_active_mask.

Continue to compute the number of CPUs over rd span and cpu_active_mask
when in hotplug.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200520134243.19352-2-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f31964a..ec90265 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -54,10 +54,16 @@ static inline struct dl_bw *dl_bw_of(int i)
 static inline int dl_bw_cpus(int i)
 {
 	struct root_domain *rd = cpu_rq(i)->rd;
-	int cpus = 0;
+	int cpus;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
 			 "sched RCU must be held");
+
+	if (cpumask_subset(rd->span, cpu_active_mask))
+		return cpumask_weight(rd->span);
+
+	cpus = 0;
+
 	for_each_cpu_and(i, rd->span, cpu_active_mask)
 		cpus++;
 
