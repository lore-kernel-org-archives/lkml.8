Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DD4C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111FA24960
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgEKVAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732024AbgEKU7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C84C061A0E;
        Mon, 11 May 2020 13:59:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWg-0005vE-0z; Mon, 11 May 2020 22:59:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CC9E71C001F;
        Mon, 11 May 2020 22:59:36 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:36 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add test of holding scheduler locks
 across rcu_read_unlock()
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077669.390.10389843741359424479.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     52b1fc3f798d02a3a9d1cf7a84e98a795223410a
Gitweb:        https://git.kernel.org/tip/52b1fc3f798d02a3a9d1cf7a84e98a795223410a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 28 Mar 2020 18:53:25 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcutorture: Add test of holding scheduler locks across rcu_read_unlock()

Now that it should be safe to hold scheduler locks across
rcu_read_unlock(), even in cases where the corresponding RCU read-side
critical section might have been preempted and boosted, the commit adds
a test of this capability to rcutorture.  This has been tested on current
mainline (which can deadlock in this situation), and lockdep duly reported
the expected deadlock.  On -rcu, lockdep is silent, thus far, anyway.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5453bd5..b348cf8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1147,6 +1147,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 				  struct torture_random_state *trsp,
 				  struct rt_read_seg *rtrsp)
 {
+	unsigned long flags;
 	int idxnew = -1;
 	int idxold = *readstate;
 	int statesnew = ~*readstate & newstate;
@@ -1181,8 +1182,15 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_SCHED)
 		rcu_read_unlock_sched();
-	if (statesold & RCUTORTURE_RDR_RCU)
+	if (statesold & RCUTORTURE_RDR_RCU) {
+		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);
+
+		if (lockit)
+			raw_spin_lock_irqsave(&current->pi_lock, flags);
 		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
+		if (lockit)
+			raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+	}
 
 	/* Delay if neither beginning nor end and there was a change. */
 	if ((statesnew || statesold) && *readstate && newstate)
