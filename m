Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B9C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8BB2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgCFOna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCFOmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB1-0006JZ-6a; Fri, 06 Mar 2020 15:42:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 564D71C21DA;
        Fri,  6 Mar 2020 15:42:07 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:07 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Don't enable EAS on SMT systems
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200227191433.31994-2-valentin.schneider@arm.com>
References: <20200227191433.31994-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158350572709.28353.16255597109338898725.tip-bot2@tip-bot2>
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

Commit-ID:     38502ab4bf3c463081bfd53356980a9ec2f32d1d
Gitweb:        https://git.kernel.org/tip/38502ab4bf3c463081bfd53356980a9ec2f32d1d
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 27 Feb 2020 19:14:32 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:23 +01:00

sched/topology: Don't enable EAS on SMT systems

EAS already requires asymmetric CPU capacities to be enabled, and mixing
this with SMT is an aberration, but better be safe than sorry.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Quentin Perret <qperret@google.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200227191433.31994-2-valentin.schneider@arm.com
---
 kernel/sched/topology.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0091188..8344757 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -317,8 +317,9 @@ static void sched_energy_set(bool has_eas)
  * EAS can be used on a root domain if it meets all the following conditions:
  *    1. an Energy Model (EM) is available;
  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
- *    3. the EM complexity is low enough to keep scheduling overheads low;
- *    4. schedutil is driving the frequency of all CPUs of the rd;
+ *    3. no SMT is detected.
+ *    4. the EM complexity is low enough to keep scheduling overheads low;
+ *    5. schedutil is driving the frequency of all CPUs of the rd;
  *
  * The complexity of the Energy Model is defined as:
  *
@@ -360,6 +361,13 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 		goto free;
 	}
 
+	/* EAS definitely does *not* handle SMT */
+	if (sched_smt_active()) {
+		pr_warn("rd %*pbl: Disabling EAS, SMT is not supported\n",
+			cpumask_pr_args(cpu_map));
+		goto free;
+	}
+
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
 		if (find_pd(pd, i))
