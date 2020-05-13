Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B747BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A5620708
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388446;
	bh=7E/fIz7wM1U/2tw53VAP5TR7b5+Gc4cizUa5GyslGks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZKXPjoRdTQTgXl225mXGUrIArGT5JUKasqvykuM/r6ssKIlyEFr1hBDmgDwy6jmJ
	 ySggpjgZKCxmTPA6lmx0lj1qsVR5ggFBTW25/w7pUx7iD9K82X3ezAV4fhAA2Osx6Z
	 5UW8ARq7CA4E642BMfOyJQbpHLL04PiujOTLPrn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbgEMQrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbgEMQrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:21 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87ACB20690;
        Wed, 13 May 2020 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388442;
        bh=7E/fIz7wM1U/2tw53VAP5TR7b5+Gc4cizUa5GyslGks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPW/zq5mJ5MxavWnwbZp1e9Oo7o6aQh6c+7Ql2wOsSUCW12kSSo7TLbzSQTOWt9WB
         HCHyIndOdvRzDyRkOeXBdYuY8KCglWt1j1IwM3kuM6Bo3xw6rVmqmZs4QPM0+2FOak
         HSU9G9Gi2tIYkmE8TCXnkgzNn510LrE0PhMs4bzI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code entrypoints
Date:   Wed, 13 May 2020 18:47:05 +0200
Message-Id: <20200513164714.22557-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
timers) can unconditionally lock rdp->nocb_lock as they always execute
in the context of an offloaded rdp.

This also prepare for toggling CPUs to/from callback's offloaded mode
where the offloaded state will possibly change when rdp->nocb_lock
isn't taken. We'll still want the entrypoints to lock the rdp in any
case.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_plugin.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 097635c41135..523570469864 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1909,7 +1909,7 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
-	rcu_nocb_lock_irqsave(rdp, flags);
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
 	__call_rcu_nocb_wake(rdp, true, flags);
 }
@@ -1942,7 +1942,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 */
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
-		rcu_nocb_lock_irqsave(rdp, flags);
+		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		if (bypass_ncbs &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
@@ -1951,7 +1951,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			(void)rcu_nocb_try_flush_bypass(rdp, j);
 			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 			continue; /* No callbacks here, try next. */
 		}
 		if (bypass_ncbs) {
@@ -1996,7 +1996,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		} else {
 			needwake = false;
 		}
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		if (needwake) {
 			swake_up_one(&rdp->nocb_cb_wq);
 			gotcbs = true;
@@ -2084,7 +2084,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	rcu_do_batch(rdp);
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
-	rcu_nocb_lock_irqsave(rdp, flags);
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
 	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
 	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
@@ -2092,7 +2092,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	}
 	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		if (needwake_gp)
 			rcu_gp_kthread_wake();
 		return;
@@ -2100,7 +2100,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
 	WRITE_ONCE(rdp->nocb_cb_sleep, true);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	if (needwake_gp)
 		rcu_gp_kthread_wake();
 	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
-- 
2.25.0

