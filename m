Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FE1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B2C218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgAYKns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44368 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgAYKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuN-0000GB-Qq; Sat, 25 Jan 2020 11:43:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4737E1C1A74;
        Sat, 25 Jan 2020 11:42:58 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:58 -0000
From:   "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix missed wakeup of exp_wq waiters
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897807.396.7789560572541212936.tip-bot2@tip-bot2>
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

Commit-ID:     fd6bc19d7676a060a171d1cf3dcbf6fd797eb05f
Gitweb:        https://git.kernel.org/tip/fd6bc19d7676a060a171d1cf3dcbf6fd797eb05f
Author:        Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate:    Tue, 19 Nov 2019 03:17:07 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:24:57 -08:00

rcu: Fix missed wakeup of exp_wq waiters

Tasks waiting within exp_funnel_lock() for an expedited grace period to
elapse can be starved due to the following sequence of events:

1.	Tasks A and B both attempt to start an expedited grace
	period at about the same time.	This grace period will have
	completed when the lower four bits of the rcu_state structure's
	->expedited_sequence field are 0b'0100', for example, when the
	initial value of this counter is zero.	Task A wins, and thus
	does the actual work of starting the grace period, including
	acquiring the rcu_state structure's .exp_mutex and sets the
	counter to 0b'0001'.

2.	Because task B lost the race to start the grace period, it
	waits on ->expedited_sequence to reach 0b'0100' inside of
	exp_funnel_lock(). This task therefore blocks on the rcu_node
	structure's ->exp_wq[1] field, keeping in mind that the
	end-of-grace-period value of ->expedited_sequence (0b'0100')
	is shifted down two bits before indexing the ->exp_wq[] field.

3.	Task C attempts to start another expedited grace period,
	but blocks on ->exp_mutex, which is still held by Task A.

4.	The aforementioned expedited grace period completes, so that
	->expedited_sequence now has the value 0b'0100'.  A kworker task
	therefore acquires the rcu_state structure's ->exp_wake_mutex
	and starts awakening any tasks waiting for this grace period.

5.	One of the first tasks awakened happens to be Task A.  Task A
	therefore releases the rcu_state structure's ->exp_mutex,
	which allows Task C to start the next expedited grace period,
	which causes the lower four bits of the rcu_state structure's
	->expedited_sequence field to become 0b'0101'.

6.	Task C's expedited grace period completes, so that the lower four
	bits of the rcu_state structure's ->expedited_sequence field now
	become 0b'1000'.

7.	The kworker task from step 4 above continues its wakeups.
	Unfortunately, the wake_up_all() refetches the rcu_state
	structure's .expedited_sequence field:

	wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);

	This results in the wakeup being applied to the rcu_node
	structure's ->exp_wq[2] field, which is unfortunate given that
	Task B is instead waiting on ->exp_wq[1].

On a busy system, no harm is done (or at least no permanent harm is done).
Some later expedited grace period will redo the wakeup.  But on a quiet
system, such as many embedded systems, it might be a good long time before
there was another expedited grace period.  On such embedded systems,
this situation could therefore result in a system hang.

This issue manifested as DPM device timeout during suspend (which
usually qualifies as a quiet time) due to a SCSI device being stuck in
_synchronize_rcu_expedited(), with the following stack trace:

	schedule()
	synchronize_rcu_expedited()
	synchronize_rcu()
	scsi_device_quiesce()
	scsi_bus_suspend()
	dpm_run_callback()
	__device_suspend()

This commit therefore prevents such delays, timeouts, and hangs by
making rcu_exp_wait_wake() use its "s" argument consistently instead of
refetching from rcu_state.expedited_sequence.

Fixes: 3b5f668e715b ("rcu: Overlap wakeups with next expedited grace period")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 3b59c3e..fa143e4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -557,7 +557,7 @@ static void rcu_exp_wait_wake(unsigned long s)
 			spin_unlock(&rnp->exp_lock);
 		}
 		smp_mb(); /* All above changes before wakeup. */
-		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
+		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
 	}
 	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
 	mutex_unlock(&rcu_state.exp_wake_mutex);
