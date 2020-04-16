Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABFBC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9731C21734
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046972;
	bh=pToQ0G8nlkKkaq5eQ55M2R1lUalT3J/AbDnqg1tEiQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QGjbwcAVTJPN7ewD7IVJrirABU0Ger7g8b+k/374L+OT7SOx4t9bLvh0vWePfQC4t
	 uQBQkyjINWj/cKhkikqEjtNXCNstYt6qbS/9Tuhy1z6MPeYf0+O8mMH7BVImwlxcH+
	 nLeQ+yt6ZeZ17a3M2hxi0nQfyCt0pI08zlLemo5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394134AbgDPOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409014AbgDPN4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:56:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B5D20786;
        Thu, 16 Apr 2020 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045378;
        bh=pToQ0G8nlkKkaq5eQ55M2R1lUalT3J/AbDnqg1tEiQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZddvgieJMsJAqBCnmthQaFspeDh+psKjEv3I1ksSfjWRwl9g0pf45T7k437L4FQov
         KDKeUrmJTFgCN8zctdQihL/ggdyL2xbs6UpicHNUxiVKpTXgL+DZ0Ykp2Q3KqciBra
         7pf60aIiGCcljn3/nZFANKzrskC4xxu//+rPZWMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5.6 111/254] rcu: Make rcu_barrier() account for offline no-CBs CPUs
Date:   Thu, 16 Apr 2020 15:23:20 +0200
Message-Id: <20200416131340.061168935@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

commit 127e29815b4b2206c0a97ac1d83f92ffc0e25c34 upstream.

Currently, rcu_barrier() ignores offline CPUs,  However, it is possible
for an offline no-CBs CPU to have callbacks queued, and rcu_barrier()
must wait for those callbacks.  This commit therefore makes rcu_barrier()
directly invoke the rcu_barrier_func() with interrupts disabled for such
CPUs.  This requires passing the CPU number into this function so that
it can entrain the rcu_barrier() callback onto the correct CPU's callback
list, given that the code must instead execute on the current CPU.

While in the area, this commit fixes a bug where the first CPU's callback
might have been invoked before rcu_segcblist_entrain() returned, which
would also result in an early wakeup.

Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Apply optimization feedback from Boqun Feng. ]
Cc: <stable@vger.kernel.org> # 5.5.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/trace/events/rcu.h |    1 +
 kernel/rcu/tree.c          |   36 ++++++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)

--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -712,6 +712,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
  *	"Begin": rcu_barrier() started.
  *	"EarlyExit": rcu_barrier() piggybacked, thus early exit.
  *	"Inc1": rcu_barrier() piggyback check counter incremented.
+ *	"OfflineNoCBQ": rcu_barrier() found offline no-CBs CPU with callbacks.
  *	"OnlineQ": rcu_barrier() found online CPU with callbacks.
  *	"OnlineNQ": rcu_barrier() found online CPU, no callbacks.
  *	"IRQ": An rcu_barrier_callback() callback posted on remote CPU.
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3090,9 +3090,10 @@ static void rcu_barrier_callback(struct
 /*
  * Called with preemption disabled, and from cross-cpu IRQ context.
  */
-static void rcu_barrier_func(void *unused)
+static void rcu_barrier_func(void *cpu_in)
 {
-	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
+	uintptr_t cpu = (uintptr_t)cpu_in;
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 	rcu_barrier_trace(TPS("IRQ"), -1, rcu_state.barrier_sequence);
 	rdp->barrier_head.func = rcu_barrier_callback;
@@ -3119,7 +3120,7 @@ static void rcu_barrier_func(void *unuse
  */
 void rcu_barrier(void)
 {
-	int cpu;
+	uintptr_t cpu;
 	struct rcu_data *rdp;
 	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
 
@@ -3142,13 +3143,14 @@ void rcu_barrier(void)
 	rcu_barrier_trace(TPS("Inc1"), -1, rcu_state.barrier_sequence);
 
 	/*
-	 * Initialize the count to one rather than to zero in order to
-	 * avoid a too-soon return to zero in case of a short grace period
-	 * (or preemption of this task).  Exclude CPU-hotplug operations
-	 * to ensure that no offline CPU has callbacks queued.
+	 * Initialize the count to two rather than to zero in order
+	 * to avoid a too-soon return to zero in case of an immediate
+	 * invocation of the just-enqueued callback (or preemption of
+	 * this task).  Exclude CPU-hotplug operations to ensure that no
+	 * offline non-offloaded CPU has callbacks queued.
 	 */
 	init_completion(&rcu_state.barrier_completion);
-	atomic_set(&rcu_state.barrier_cpu_count, 1);
+	atomic_set(&rcu_state.barrier_cpu_count, 2);
 	get_online_cpus();
 
 	/*
@@ -3158,13 +3160,23 @@ void rcu_barrier(void)
 	 */
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
-		if (!cpu_online(cpu) &&
+		if (cpu_is_offline(cpu) &&
 		    !rcu_segcblist_is_offloaded(&rdp->cblist))
 			continue;
-		if (rcu_segcblist_n_cbs(&rdp->cblist)) {
+		if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
 			rcu_barrier_trace(TPS("OnlineQ"), cpu,
 					  rcu_state.barrier_sequence);
-			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
+			smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1);
+		} else if (rcu_segcblist_n_cbs(&rdp->cblist) &&
+			   cpu_is_offline(cpu)) {
+			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu,
+					  rcu_state.barrier_sequence);
+			local_irq_disable();
+			rcu_barrier_func((void *)cpu);
+			local_irq_enable();
+		} else if (cpu_is_offline(cpu)) {
+			rcu_barrier_trace(TPS("OfflineNoCBNoQ"), cpu,
+					  rcu_state.barrier_sequence);
 		} else {
 			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
 					  rcu_state.barrier_sequence);
@@ -3176,7 +3188,7 @@ void rcu_barrier(void)
 	 * Now that we have an rcu_barrier_callback() callback on each
 	 * CPU, and thus each counted, remove the initial count.
 	 */
-	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count))
+	if (atomic_sub_and_test(2, &rcu_state.barrier_cpu_count))
 		complete(&rcu_state.barrier_completion);
 
 	/* Wait for all rcu_barrier_callback() callbacks to be invoked. */


