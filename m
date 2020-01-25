Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6724DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45155218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgAYKod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:44:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbgAYKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuQ-0000HC-HW; Sat, 25 Jan 2020 11:43:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1A9521C1A95;
        Sat, 25 Jan 2020 11:42:59 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:58 -0000
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Avoid modifying mask_ofl_ipi in
 sync_rcu_exp_select_node_cpus()
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897887.396.17380984006682495096.tip-bot2@tip-bot2>
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

Commit-ID:     9f08cf088676c12a5b53bd5a29cf04f00c787b5d
Gitweb:        https://git.kernel.org/tip/9f08cf088676c12a5b53bd5a29cf04f00c787b5d
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 08 Oct 2019 13:01:40 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:24:56 -08:00

rcu: Avoid modifying mask_ofl_ipi in sync_rcu_exp_select_node_cpus()

The "mask_ofl_ipi" is used to track which CPUs get IPIed, however
in the IPI sending loop, "mask_ofl_ipi" along with another variable
"mask_ofl_test" might also get modified to record which CPUs' quiesent
states must be reported by the sync_rcu_exp_select_node_cpus() at
the end of sync_rcu_exp_select_node_cpus().  This overlap of roles
can be confusing, so this patch cleans things a little by using
"mask_ofl_ipi" solely for determining which CPUs must be IPIed  and
"mask_ofl_test" for solely determining on behalf of  which CPUs
sync_rcu_exp_select_node_cpus() must report a quiscent state.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Marco Elver <elver@google.com>
---
 kernel/rcu/tree_exp.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 69c5aa6..6a6f328 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -387,10 +387,10 @@ retry_ipi:
 		}
 		ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
 		put_cpu();
-		if (!ret) {
-			mask_ofl_ipi &= ~mask;
+		/* The CPU will report the QS in response to the IPI. */
+		if (!ret)
 			continue;
-		}
+
 		/* Failed, raced with CPU hotplug operation. */
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if ((rnp->qsmaskinitnext & mask) &&
@@ -401,13 +401,12 @@ retry_ipi:
 			schedule_timeout_uninterruptible(1);
 			goto retry_ipi;
 		}
-		/* CPU really is offline, so we can ignore it. */
-		if (!(rnp->expmask & mask))
-			mask_ofl_ipi &= ~mask;
+		/* CPU really is offline, so we must report its QS. */
+		if (rnp->expmask & mask)
+			mask_ofl_test |= mask;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 	/* Report quiescent states for those that went offline. */
-	mask_ofl_test |= mask_ofl_ipi;
 	if (mask_ofl_test)
 		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
 }
