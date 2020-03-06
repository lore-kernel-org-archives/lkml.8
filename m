Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA2C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E323B21775
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCFOmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53876 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgCFOm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAz-0006Hg-QI; Fri, 06 Mar 2020 15:42:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 70FE91C21D3;
        Fri,  6 Mar 2020 15:42:04 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:04 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Allow pulling unfitting task
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302132721.8353-5-qais.yousef@arm.com>
References: <20200302132721.8353-5-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158350572419.28353.10129133387433061878.tip-bot2@tip-bot2>
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

Commit-ID:     98ca645f824301bde72e0a51cdc8bdbbea6774a5
Gitweb:        https://git.kernel.org/tip/98ca645f824301bde72e0a51cdc8bdbbea6774a5
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 02 Mar 2020 13:27:19 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:28 +01:00

sched/rt: Allow pulling unfitting task

When implemented RT Capacity Awareness; the logic was done such that if
a task was running on a fitting CPU, then it was sticky and we would try
our best to keep it there.

But as Steve suggested, to adhere to the strict priority rules of RT
class; allow pulling an RT task to unfitting CPU to ensure it gets a
chance to run ASAP.

LINK: https://lore.kernel.org/lkml/20200203111451.0d1da58f@oasis.local.home/
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
Link: https://lkml.kernel.org/r/20200302132721.8353-5-qais.yousef@arm.com
---
 kernel/sched/rt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 29a8695..bcb1436 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1656,8 +1656,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
-	    rt_task_fits_capacity(p, cpu))
+	    cpumask_test_cpu(cpu, p->cpus_ptr))
 		return 1;
 
 	return 0;
