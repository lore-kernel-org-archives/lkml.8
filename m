Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F1C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AD720720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgA2LdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51080 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2LdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlab-0007kk-Bm; Wed, 29 Jan 2020 12:32:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0A9561C1C18;
        Wed, 29 Jan 2020 12:32:57 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:56 -0000
From:   "tip-bot2 for Srikar Dronamraju" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Optimize select_idle_core()
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191206172422.6578-1-srikar@linux.vnet.ibm.com>
References: <20191206172422.6578-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <158029757682.396.5003778386647847776.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: 1.5
X-Linutronix-Spam-Level: +
X-Linutronix-Spam-Status: No , 1.5 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_DBL_ABUSE_MALW=2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bec2860a2bd6cd38ea34434d04f4033eb32f0f31
Gitweb:        https://git.kernel.org/tip/bec2860a2bd6cd38ea34434d04f4033eb32f0f31
Author:        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate:    Fri, 06 Dec 2019 22:54:22 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:37:08 +01:00

sched/fair: Optimize select_idle_core()

Currently we loop through all threads of a core to evaluate if the core is
idle or not. This is unnecessary. If a thread of a core is not idle, skip
evaluating other threads of a core. Also while clearing the cpumask, bits
of all CPUs of a core can be cleared in one-shot.

Collecting ticks on a Power 9 SMT 8 system around select_idle_core
while running schbench shows us

(units are in ticks, hence lesser is better)
Without patch
    N        Min     Max     Median         Avg      Stddev
x 130        151    1083        284   322.72308   144.41494

With patch
    N        Min     Max     Median         Avg      Stddev   Improvement
x 164         88     610        201   225.79268   106.78943        30.03%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lkml.kernel.org/r/20191206172422.6578-1-srikar@linux.vnet.ibm.com
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25dffc0..1a0ce83 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5787,10 +5787,12 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int 
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			__cpumask_clear_cpu(cpu, cpus);
-			if (!available_idle_cpu(cpu))
+			if (!available_idle_cpu(cpu)) {
 				idle = false;
+				break;
+			}
 		}
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
