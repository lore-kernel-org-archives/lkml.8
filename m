Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781DEC54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBF420870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgCXJU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:20:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43887 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgCXJQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffj-0007wr-TX; Tue, 24 Mar 2020 10:16:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 857B01C0481;
        Tue, 24 Mar 2020 10:16:31 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:31 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make rcu_torture_barrier_cbs() post from
 corresponding CPU
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139123.28353.17748031342974553550.tip-bot2@tip-bot2>
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

Commit-ID:     50d4b62970e21e9573daf0e3c1138b4d1ebcca47
Gitweb:        https://git.kernel.org/tip/50d4b62970e21e9573daf0e3c1138b4d1ebcca47
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 04 Feb 2020 15:00:56 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:31 -08:00

rcutorture: Make rcu_torture_barrier_cbs() post from corresponding CPU

Currently, rcu_torture_barrier_cbs() posts callbacks from whatever CPU
it is running on, which means that all these kthreads might well be
posting from the same CPU, which would drastically reduce the effectiveness
of this test.  This commit therefore uses IPIs to make the callbacks be
posted from the corresponding CPU (given by local variable myid).

If the IPI fails (which can happen if the target CPU is offline or does
not exist at all), the callback is posted on whatever CPU is currently
running.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7e01e9a..f82515c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2053,6 +2053,14 @@ static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 	atomic_inc(&barrier_cbs_invoked);
 }
 
+/* IPI handler to get callback posted on desired CPU, if online. */
+static void rcu_torture_barrier1cb(void *rcu_void)
+{
+	struct rcu_head *rhp = rcu_void;
+
+	cur_ops->call(rhp, rcu_torture_barrier_cbf);
+}
+
 /* kthread function to register callbacks used to test RCU barriers. */
 static int rcu_torture_barrier_cbs(void *arg)
 {
@@ -2076,9 +2084,11 @@ static int rcu_torture_barrier_cbs(void *arg)
 		 * The above smp_load_acquire() ensures barrier_phase load
 		 * is ordered before the following ->call().
 		 */
-		local_irq_disable(); /* Just to test no-irq call_rcu(). */
-		cur_ops->call(&rcu, rcu_torture_barrier_cbf);
-		local_irq_enable();
+		if (smp_call_function_single(myid, rcu_torture_barrier1cb,
+					     &rcu, 1)) {
+			// IPI failed, so use direct call from current CPU.
+			cur_ops->call(&rcu, rcu_torture_barrier_cbf);
+		}
 		if (atomic_dec_and_test(&barrier_cbs_count))
 			wake_up(&barrier_wq);
 	} while (!torture_must_stop());
