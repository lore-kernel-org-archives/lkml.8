Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88793C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630CE20732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgA2LdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgA2LdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlaj-0007op-1Y; Wed, 29 Jan 2020 12:33:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9EFB71C1C1E;
        Wed, 29 Jan 2020 12:33:00 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:33:00 -0000
From:   "tip-bot2 for Scott Wood" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Don't skip remote tick for idle CPUs
Cc:     Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1578736419-14628-2-git-send-email-swood@redhat.com>
References: <1578736419-14628-2-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Message-ID: <158029758043.396.4187118276137508123.tip-bot2@tip-bot2>
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

Commit-ID:     488603b815a7514c7009e6fc339d74ed4a30f343
Gitweb:        https://git.kernel.org/tip/488603b815a7514c7009e6fc339d74ed4a30f343
Author:        Scott Wood <swood@redhat.com>
AuthorDate:    Sat, 11 Jan 2020 04:53:38 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:36:16 +01:00

sched/core: Don't skip remote tick for idle CPUs

This will be used in the next patch to get a loadavg update from
nohz cpus.  The delta check is skipped because idle_sched_class
doesn't update se.exec_start.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/1578736419-14628-2-git-send-email-swood@redhat.com
---
 kernel/sched/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc0..cf8b33d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3669,22 +3669,24 @@ static void sched_tick_remote(struct work_struct *work)
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
+	if (!tick_nohz_tick_stopped_cpu(cpu))
 		goto out_requeue;
 
 	rq_lock_irq(rq, &rf);
 	curr = rq->curr;
-	if (is_idle_task(curr) || cpu_is_offline(cpu))
+	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
 	update_rq_clock(rq);
-	delta = rq_clock_task(rq) - curr->se.exec_start;
 
-	/*
-	 * Make sure the next tick runs within a reasonable
-	 * amount of time.
-	 */
-	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	if (!is_idle_task(curr)) {
+		/*
+		 * Make sure the next tick runs within a reasonable
+		 * amount of time.
+		 */
+		delta = rq_clock_task(rq) - curr->se.exec_start;
+		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	}
 	curr->sched_class->task_tick(rq, curr, 0);
 
 out_unlock:
