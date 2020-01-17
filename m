Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1BAC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C9622525
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAQKJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgAQKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYe-0005UC-1l; Fri, 17 Jan 2020 11:08:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B0101C19CF;
        Fri, 17 Jan 2020 11:08:43 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:43 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair : Improve update_sd_pick_busiest for
 spare capacity case
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1576839893-26930-1-git-send-email-vincent.guittot@linaro.org>
References: <1576839893-26930-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157925572333.396.14134699274514143888.tip-bot2@tip-bot2>
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

Commit-ID:     5f68eb19b5716f8cf3ccfa833cffd1522813b0e8
Gitweb:        https://git.kernel.org/tip/5f68eb19b5716f8cf3ccfa833cffd1522813b0e8
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 20 Dec 2019 12:04:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:19 +01:00

sched/fair : Improve update_sd_pick_busiest for spare capacity case

Similarly to calculate_imbalance() and find_busiest_group(), using the
number of idle CPUs when there is only 1 CPU in the group is not efficient
because we can't make a difference between a CPU running 1 task and a CPU
running dozens of small tasks competing for the same CPU but not enough
to overload it. More generally speaking, we should use the number of
running tasks when there is the same number of idle CPUs in a group instead
of blindly select the 1st one.

When the groups have spare capacity and the same number of idle CPUs, we
compare the number of running tasks to select the busiest group.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1576839893-26930-1-git-send-email-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d170b5..35c1057 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8181,14 +8181,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_has_spare:
 		/*
-		 * Select not overloaded group with lowest number of
-		 * idle cpus. We could also compare the spare capacity
-		 * which is more stable but it can end up that the
-		 * group has less spare capacity but finally more idle
+		 * Select not overloaded group with lowest number of idle cpus
+		 * and highest number of running tasks. We could also compare
+		 * the spare capacity which is more stable but it can end up
+		 * that the group has less spare capacity but finally more idle
 		 * CPUs which means less opportunity to pull tasks.
 		 */
-		if (sgs->idle_cpus >= busiest->idle_cpus)
+		if (sgs->idle_cpus > busiest->idle_cpus)
 			return false;
+		else if ((sgs->idle_cpus == busiest->idle_cpus) &&
+			 (sgs->sum_nr_running <= busiest->sum_nr_running))
+			return false;
+
 		break;
 	}
 
