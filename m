Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A86FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDC620657
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgESVqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgESVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:46:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86483C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:46:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jbA3j-0002af-36; Tue, 19 May 2020 23:45:59 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Subject: [PATCH v1 02/25] mm/swap: Don't abuse the seqcount latching API
Date:   Tue, 19 May 2020 23:45:24 +0200
Message-Id: <20200519214547.352050-3-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit eef1a429f234 ("mm/swap.c: piggyback lru_add_drain_all() calls")
implemented an optimization mechanism to exit the to-be-started LRU
drain operation (name it A) if another drain operation *started and
finished* while (A) was blocked on the LRU draining mutex.

This was done through a seqcount latch, which is an abuse of its
semantics:

  1. Seqcount latching should be used for the purpose of switching
     between two storage places with sequence protection to allow
     interruptible, preemptible writer sections. The optimization
     mechanism has absolutely nothing to do with that.

  2. The used raw_write_seqcount_latch() has two smp write memory
     barriers to always insure one consistent storage place out of the
     two storage places available. This extra smp_wmb() is redundant for
     the optimization use case.

Beside the API abuse, the semantics of a latch sequence counter was
force fitted into the optimization. What was actually meant is to track
generations of LRU draining operations, where "current lru draining
generation = x" implies that all generations 0 < n <= x are already
*scheduled* for draining.

Remove the conceptually-inappropriate seqcount latch usage and manually
implement the optimization using a counter and SMP memory barriers.

Link: https://lkml.kernel.org/r/CALYGNiPSr-cxV9MX9czaVh6Wz_gzSv3H_8KPvgjBTGbJywUJpA@mail.gmail.com
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 mm/swap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index bf9a79fed62d..d6910eeed43d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -713,10 +713,20 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
  */
 void lru_add_drain_all(void)
 {
-	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
-	static DEFINE_MUTEX(lock);
+	/*
+	 * lru_drain_gen - Current generation of pages that could be in vectors
+	 *
+	 * (A) Definition: lru_drain_gen = x implies that all generations
+	 *     0 < n <= x are already scheduled for draining.
+	 *
+	 * This is an optimization for the highly-contended use case where a
+	 * user space workload keeps constantly generating a flow of pages
+	 * for each CPU.
+	 */
+	static unsigned int lru_drain_gen;
 	static struct cpumask has_work;
-	int cpu, seq;
+	static DEFINE_MUTEX(lock);
+	int cpu, this_gen;
 
 	/*
 	 * Make sure nobody triggers this path before mm_percpu_wq is fully
@@ -725,21 +735,48 @@ void lru_add_drain_all(void)
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
-	seq = raw_read_seqcount_latch(&seqcount);
+	/*
+	 * (B) Cache the LRU draining generation number
+	 *
+	 * smp_rmb() ensures that the counter is loaded before the mutex is
+	 * taken. It pairs with the smp_wmb() inside the mutex critical section
+	 * at (D).
+	 */
+	this_gen = READ_ONCE(lru_drain_gen);
+	smp_rmb();
 
 	mutex_lock(&lock);
 
 	/*
-	 * Piggyback on drain started and finished while we waited for lock:
-	 * all pages pended at the time of our enter were drained from vectors.
+	 * (C) Exit the draining operation if a newer generation, from another
+	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
 	 */
-	if (__read_seqcount_retry(&seqcount, seq))
+	if (unlikely(this_gen != lru_drain_gen))
 		goto done;
 
-	raw_write_seqcount_latch(&seqcount);
+	/*
+	 * (D) Increment generation number
+	 *
+	 * Pairs with READ_ONCE() and smp_rmb() at (B), outside of the critical
+	 * section.
+	 *
+	 * This pairing must be done here, before the for_each_online_cpu loop
+	 * below which drains the page vectors.
+	 *
+	 * Let x, y, and z represent some system CPU numbers, where x < y < z.
+	 * Assume CPU #z is is in the middle of the for_each_online_cpu loop
+	 * below and has already reached CPU #y's per-cpu data. CPU #x comes
+	 * along, adds some pages to its per-cpu vectors, then calls
+	 * lru_add_drain_all().
+	 *
+	 * If the paired smp_wmb() below is done at any later step, e.g. after
+	 * the loop, CPU #x will just exit at (C) and miss flushing out all of
+	 * its added pages.
+	 */
+	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
+	smp_wmb();
 
 	cpumask_clear(&has_work);
-
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
@@ -766,7 +803,7 @@ void lru_add_drain_all(void)
 {
 	lru_add_drain();
 }
-#endif
+#endif /* CONFIG_SMP */
 
 /**
  * release_pages - batched put_page()
-- 
2.20.1

