Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F74C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553782084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCFOmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53874 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgCFOm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB9-0006Q1-Ex; Fri, 06 Mar 2020 15:42:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 68DEB1C21D5;
        Fri,  6 Mar 2020 15:42:14 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:14 -0000
From:   "tip-bot2 for Peter Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] sched/core: Remove rq.hrtick_csd_pending
Cc:     Peter Xu <peterx@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191216213125.9536-4-peterx@redhat.com>
References: <20191216213125.9536-4-peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <158350573414.28353.9184925891014185535.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     fd3eafda8f146d4ad8f95f91a8c2b9a5319ff6b2
Gitweb:        https://git.kernel.org/tip/fd3eafda8f146d4ad8f95f91a8c2b9a5319ff6b2
Author:        Peter Xu <peterx@redhat.com>
AuthorDate:    Mon, 16 Dec 2019 16:31:25 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 13:42:28 +01:00

sched/core: Remove rq.hrtick_csd_pending

Now smp_call_function_single_async() provides the protection that
we'll return with -EBUSY if the csd object is still pending, then we
don't need the rq.hrtick_csd_pending any more.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20191216213125.9536-4-peterx@redhat.com
---
 kernel/sched/core.c  |  9 ++-------
 kernel/sched/sched.h |  1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983d..b70ec38 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -269,7 +269,6 @@ static void __hrtick_start(void *arg)
 
 	rq_lock(rq, &rf);
 	__hrtick_restart(rq);
-	rq->hrtick_csd_pending = 0;
 	rq_unlock(rq, &rf);
 }
 
@@ -293,12 +292,10 @@ void hrtick_start(struct rq *rq, u64 delay)
 
 	hrtimer_set_expires(timer, time);
 
-	if (rq == this_rq()) {
+	if (rq == this_rq())
 		__hrtick_restart(rq);
-	} else if (!rq->hrtick_csd_pending) {
+	else
 		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
-		rq->hrtick_csd_pending = 1;
-	}
 }
 
 #else
@@ -322,8 +319,6 @@ void hrtick_start(struct rq *rq, u64 delay)
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	rq->hrtick_csd_pending = 0;
-
 	rq->hrtick_csd.flags = 0;
 	rq->hrtick_csd.func = __hrtick_start;
 	rq->hrtick_csd.info = rq;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9ea6478..38e60b8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -967,7 +967,6 @@ struct rq {
 
 #ifdef CONFIG_SCHED_HRTICK
 #ifdef CONFIG_SMP
-	int			hrtick_csd_pending;
 	call_single_data_t	hrtick_csd;
 #endif
 	struct hrtimer		hrtick_timer;
