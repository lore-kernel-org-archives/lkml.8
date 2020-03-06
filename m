Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D76C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D18A2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCFOnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53769 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgCFOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAw-0006Ho-Gy; Fri, 06 Mar 2020 15:42:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 21CF91C21D6;
        Fri,  6 Mar 2020 15:42:05 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:04 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Re-instate old behavior in select_task_rq_rt()
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302132721.8353-3-qais.yousef@arm.com>
References: <20200302132721.8353-3-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158350572487.28353.5061886185700456995.tip-bot2@tip-bot2>
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

Commit-ID:     b28bc1e002c23ff8a4999c4a2fb1d4d412bc6f5e
Gitweb:        https://git.kernel.org/tip/b28bc1e002c23ff8a4999c4a2fb1d4d412bc6f5e
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 02 Mar 2020 13:27:17 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:27 +01:00

sched/rt: Re-instate old behavior in select_task_rq_rt()

When RT Capacity Aware support was added, the logic in select_task_rq_rt
was modified to force a search for a fitting CPU if the task currently
doesn't run on one.

But if the search failed, and the search was only triggered to fulfill
the fitness request; we could end up selecting a new CPU unnecessarily.

Fix this and re-instate the original behavior by ensuring we bail out
in that case.

This behavior change only affected asymmetric systems that are using
util_clamp to implement capacity aware. None asymmetric systems weren't
affected.

LINK: https://lore.kernel.org/lkml/20200218041620.GD28029@codeaurora.org/
Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
Link: https://lkml.kernel.org/r/20200302132721.8353-3-qais.yousef@arm.com
---
 kernel/sched/rt.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 55a4a50..f0071fa 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1475,6 +1475,13 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 		int target = find_lowest_rq(p);
 
 		/*
+		 * Bail out if we were forcing a migration to find a better
+		 * fitting CPU but our search failed.
+		 */
+		if (!test && target != -1 && !rt_task_fits_capacity(p, target))
+			goto out_unlock;
+
+		/*
 		 * Don't bother moving it if the destination CPU is
 		 * not running a lower priority task.
 		 */
@@ -1482,6 +1489,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
 			cpu = target;
 	}
+
+out_unlock:
 	rcu_read_unlock();
 
 out:
