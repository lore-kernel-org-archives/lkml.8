Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5686FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCCC20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbgFWIsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbgFWIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:48:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471DBC061755;
        Tue, 23 Jun 2020 01:48:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jnebR-0005Rb-Ou; Tue, 23 Jun 2020 10:48:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6F9301C0244;
        Tue, 23 Jun 2020 10:48:25 +0200 (CEST)
Date:   Tue, 23 Jun 2020 08:48:25 -0000
From:   "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix PI boosting between RT and DEADLINE tasks
Cc:     syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com,
        Juri Lelli <juri.lelli@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20181119153201.GB2119@localhost.localdomain>
References: <20181119153201.GB2119@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <159290210525.16989.11595870440958834087.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     93a952a81bf31bffaf21eca1b530245acce12597
Gitweb:        https://git.kernel.org/tip/93a952a81bf31bffaf21eca1b530245acce12597
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Mon, 19 Nov 2018 16:32:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 23 Jun 2020 10:42:39 +02:00

sched/core: Fix PI boosting between RT and DEADLINE tasks

syzbot reported the following warning:

 WARNING: CPU: 1 PID: 6351 at kernel/sched/deadline.c:628
 enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504

At deadline.c:628 we have:

 623 static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 624 {
 625 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 626 	struct rq *rq = rq_of_dl_rq(dl_rq);
 627
 628 	WARN_ON(dl_se->dl_boosted);
 629 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
        [...]
     }

Which means that setup_new_dl_entity() has been called on a task
currently boosted. This shouldn't happen though, as setup_new_dl_entity()
is only called when the 'dynamic' deadline of the new entity
is in the past w.r.t. rq_clock and boosted tasks shouldn't verify this
condition.

Digging through the PI code I noticed that what above might in fact happen
if an RT tasks blocks on an rt_mutex hold by a DEADLINE task. In the
first branch of boosting conditions we check only if a pi_task 'dynamic'
deadline is earlier than mutex holder's and in this case we set mutex
holder to be dl_boosted. However, since RT 'dynamic' deadlines are only
initialized if such tasks get boosted at some point (or if they become
DEADLINE of course), in general RT 'dynamic' deadlines are usually equal
to 0 and this verifies the aforementioned condition.

Fix it by checking that the potential donor task is actually (even if
temporary because in turn boosted) running at DEADLINE priority before
using its 'dynamic' deadline value.

Fixes: 2d3d891d3344 ("sched/deadline: Add SCHED_DEADLINE inheritance logic")
Reported-by: syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
Link: https://lkml.kernel.org/r/20181119153201.GB2119@localhost.localdomain
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9eeac94..c1ba2e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4533,7 +4533,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 */
 	if (dl_prio(prio)) {
 		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
+		    (pi_task && dl_prio(pi_task->prio) &&
+		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
 			p->dl.dl_boosted = 1;
 			queue_flag |= ENQUEUE_REPLENISH;
 		} else
