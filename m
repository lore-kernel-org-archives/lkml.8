Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3590C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8179720658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCXJUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:20:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43913 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgCXJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffo-0007wb-Gt; Tue, 24 Mar 2020 10:16:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2801C1C0470;
        Tue, 24 Mar 2020 10:16:31 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:30 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Manually clean up after rcu_barrier() failure
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139074.28353.12661964318347740564.tip-bot2@tip-bot2>
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

Commit-ID:     9470a18fabd056e67ee12059dab04faf6e1f253c
Gitweb:        https://git.kernel.org/tip/9470a18fabd056e67ee12059dab04faf6e1f253c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 05 Feb 2020 12:54:34 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:31 -08:00

rcutorture: Manually clean up after rcu_barrier() failure

Currently, if rcu_barrier() returns too soon, the test waits 100ms and
then does another instance of the test.  However, if rcu_barrier() were
to have waited for more than 100ms too short a time, this could cause
the test's rcu_head structures to be reused while they were still on
RCU's callback lists.  This can result in knock-on errors that obscure
the original rcu_barrier() test failure.

This commit therefore adds code that attempts to wait until all of
the test's callbacks have been invoked.  Of course, if RCU completely
lost track of the corresponding rcu_head structures, this wait could be
forever.  This commit therefore also complains if this attempted recovery
takes more than one second, and it also gives up when the test ends.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f82515c..5453bd5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2124,7 +2124,21 @@ static int rcu_torture_barrier(void *arg)
 			pr_err("barrier_cbs_invoked = %d, n_barrier_cbs = %d\n",
 			       atomic_read(&barrier_cbs_invoked),
 			       n_barrier_cbs);
-			WARN_ON_ONCE(1);
+			WARN_ON(1);
+			// Wait manually for the remaining callbacks
+			i = 0;
+			do {
+				if (WARN_ON(i++ > HZ))
+					i = INT_MIN;
+				schedule_timeout_interruptible(1);
+				cur_ops->cb_barrier();
+			} while (atomic_read(&barrier_cbs_invoked) !=
+				 n_barrier_cbs &&
+				 !torture_must_stop());
+			smp_mb(); // Can't trust ordering if broken.
+			if (!torture_must_stop())
+				pr_err("Recovered: barrier_cbs_invoked = %d\n",
+				       atomic_read(&barrier_cbs_invoked));
 		} else {
 			n_barrier_successes++;
 		}
