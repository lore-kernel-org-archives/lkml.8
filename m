Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF49C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296682078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbgEKVBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732089AbgEKVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D27C061A0E;
        Mon, 11 May 2020 14:00:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWt-00060V-Tl; Mon, 11 May 2020 23:00:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BC35A1C0857;
        Mon, 11 May 2020 22:59:42 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:42 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Mark rcu_state.gp_seq to detect more concurrent writes
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078266.390.7799718018876713808.tip-bot2@tip-bot2>
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

Commit-ID:     62ae19511f1efbe9f57346ca1f45e13b061a56ff
Gitweb:        https://git.kernel.org/tip/62ae19511f1efbe9f57346ca1f45e13b061a56ff
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 21 Mar 2020 19:52:20 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

rcu: Mark rcu_state.gp_seq to detect more concurrent writes

The rcu_state structure's gp_seq field is only to be modified by the RCU
grace-period kthread, which is single-threaded.  This commit therefore
enlists KCSAN's help in enforcing this restriction.  This commit applies
KCSAN-specific primitives, so cannot go upstream until KCSAN does.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0132bc6..183b9cf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1230,7 +1230,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("newreq"));
+	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1519,6 +1519,7 @@ static bool rcu_gp_init(void)
 	record_gp_stall_check_time();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
@@ -1805,6 +1806,7 @@ static void rcu_gp_cleanup(void)
 	/* Declare grace period done, trace first to use old GP number. */
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
 	rcu_seq_end(&rcu_state.gp_seq);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	rcu_state.gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
