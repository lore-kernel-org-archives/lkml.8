Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B406C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD352065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388451;
	bh=SIiRDjQEoO42UM7Rv3/azXOu3Z3Dd7mT4qygfIL3pws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DRQFNl6tg9/GRmlYjVZxQ5cVzvKAGNfY6I8L3skq5H+QE/c9ULxuZN2TMHAnoL/q1
	 WzSPFZYFNc+lfqdLNj10eFe8y7HzjZJ0ifRcO7i6gMrBCq9mY8fS5nJshP8KuYTCm0
	 fJmIt+5YH3+npvP1KQMtEd5nLYun0uHeYWAF/43Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbgEMQr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389599AbgEMQrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:24 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B794206F5;
        Wed, 13 May 2020 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388443;
        bh=SIiRDjQEoO42UM7Rv3/azXOu3Z3Dd7mT4qygfIL3pws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tqi90BhBYrU6De9n8eLrXS6ISdR8eVdy8Na64tfRb7rmTrfxnA5B0cnvBYwujiLWm
         mPt7UvWqLLkoMTmyJxtdZXUgvyWAmwFZJHfx+fRPGAYjhGWdtJw7+Xui0ICTqItzYF
         EMddMH9LWYFWIwKob+h0q5J/VdRZT0lMHHygQC+k=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 02/10] rcu: Use direct rdp->nocb_lock operations on local calls
Date:   Wed, 13 May 2020 18:47:06 +0200
Message-Id: <20200513164714.22557-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally lock rdp->nocb_lock on nocb code that is called after
we verified that the rdp is offloaded:

This clarify the locking rules and expectations.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_plugin.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 523570469864..1d22b16c03e0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1628,11 +1628,11 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force,
 	if (!READ_ONCE(rdp_gp->nocb_gp_kthread)) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("AlreadyAwake"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		return;
 	}
 	del_timer(&rdp->nocb_timer);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
@@ -1753,7 +1753,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 
 	// Don't use ->nocb_bypass during early boot.
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
-		rcu_nocb_lock(rdp);
+		raw_spin_lock(&rdp->nocb_lock);
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false;
@@ -1778,7 +1778,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
 	// ->nocb_bypass first.
 	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
-		rcu_nocb_lock(rdp);
+		raw_spin_lock(&rdp->nocb_lock);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		if (*was_alldone)
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
@@ -1792,7 +1792,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// flush ->nocb_bypass to ->cblist.
 	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
 	    ncbs >= qhimark) {
-		rcu_nocb_lock(rdp);
+		raw_spin_lock(&rdp->nocb_lock);
 		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
 			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 			if (*was_alldone)
@@ -1807,7 +1807,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		return true; // Callback already enqueued.
 	}
 
@@ -1827,7 +1827,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		local_irq_restore(flags);
 	} else {
 		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
-		rcu_nocb_lock(rdp); // Rare during call_rcu() flood.
+		raw_spin_lock(&rdp->nocb_lock); // Rare during call_rcu() flood.
 		if (!rcu_segcblist_pend_cbs(&rdp->cblist)) {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQwake"));
@@ -1835,7 +1835,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		} else {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQnoWake"));
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		}
 	}
 	return true; // Callback already enqueued.
@@ -1861,7 +1861,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	if (rcu_nocb_poll || !t) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		return;
 	}
 	// Need to actually to a wakeup.
@@ -1876,7 +1876,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		} else {
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		}
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
@@ -1894,10 +1894,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		    !timer_pending(&rdp->nocb_bypass_timer))
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	} else {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	}
 	return;
 }
-- 
2.25.0

