Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB7BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8609D22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y1mV2kVw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BY9gNkBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgH0PMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:12:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgH0Lkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:40:42 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598528434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMqgdQtrL9KkVo4R+kGlzmmWtYDHEwOz0TcrSWf2Bzs=;
        b=Y1mV2kVwChCqd5pR9WedpTE72GW/HIHzwg+yD0BWSpblxs2ic0azaxKuXUy3gyC+Oa2XXX
        Si2RUYXhhI/T3i2o2B4QacLg/UnxS8sdKxf8LlKn570IiIyQdg9ng4Y9Heb2p0TPvZVL6n
        jI+4fMqZm+gBOJr0fxFym6xjXi5XB3AKyBiYchYjFx/r829PO9iU8Ji4c7lvjguPWkUP9z
        CgCeJu3FFdCeBrakJ01HgHdJGdEnrpLXQpBndrURaITvAC18HfmEdlL+FxjRngx5ZPW8Gy
        3Mdis3lAU1hIgXUkEykndkqBrGaHCFfbpoqAvkG15S3VrXioqYBED2fi+UAK8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598528434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMqgdQtrL9KkVo4R+kGlzmmWtYDHEwOz0TcrSWf2Bzs=;
        b=BY9gNkBfUXyrwK+3tyeSP9m9sFYi/gXpQxizhLtUR5Fn7mSlRDFRSOq9wdVeULrT8igA3H
        0PQoXUDyQu1yDKAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 2/8] mm/swap: Do not abuse the seqcount_t latching API
Date:   Thu, 27 Aug 2020 13:40:38 +0200
Message-Id: <20200827114044.11173-3-a.darwish@linutronix.de>
In-Reply-To: <20200827114044.11173-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200827114044.11173-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit eef1a429f234 ("mm/swap.c: piggyback lru_add_drain_all() calls")
implemented an optimization mechanism to exit the to-be-started LRU
drain operation (name it A) if another drain operation *started and
finished* while (A) was blocked on the LRU draining mutex.

This was done through a seqcount_t latch, which is an abuse of its
semantics:

  1. seqcount_t latching should be used for the purpose of switching
     between two storage places with sequence protection to allow
     interruptible, preemptible, writer sections. The referenced
     optimization mechanism has absolutely nothing to do with that.

  2. The used raw_write_seqcount_latch() has two SMP write memory
     barriers to insure one consistent storage place out of the two
     storage places available. A full memory barrier is required
     instead: to guarantee that the pagevec counter stores visible by
     local CPU are visible to other CPUs -- before loading the current
     drain generation.

Beside the seqcount_t API abuse, the semantics of a latch sequence
counter was force-fitted into the referenced optimization. What was
meant is to track "generations" of LRU draining operations, where
"global lru draining generation = x" implies that all generations
0 < n <= x are already *scheduled* for draining -- thus nothing needs
to be done if the current generation number n <= x.

Remove the conceptually-inappropriate seqcount_t latch usage. Manually
implement the referenced optimization using a counter and SMP memory
barriers.

Note, while at it, use the non-atomic variant of cpumask_set_cpu(),
__cpumask_set_cpu(), due to the already existing mutex protection.

Link: https://lkml.kernel.org/r/CALYGNiPSr-cxV9MX9czaVh6Wz_gzSv3H_8KPvgjBTGbJywUJpA@mail.gmail.com
Link: https://lkml.kernel.org/r/87y2pg9erj.fsf@vostro.fn.ogness.net
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 mm/swap.c | 65 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index d16d65d9b4e0..a1ec807e325d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -763,10 +763,20 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
  */
 void lru_add_drain_all(void)
 {
-	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
-	static DEFINE_MUTEX(lock);
+	/*
+	 * lru_drain_gen - Global pages generation number
+	 *
+	 * (A) Definition: global lru_drain_gen = x implies that all generations
+	 *     0 < n <= x are already *scheduled* for draining.
+	 *
+	 * This is an optimization for the highly-contended use case where a
+	 * user space workload keeps constantly generating a flow of pages for
+	 * each CPU.
+	 */
+	static unsigned int lru_drain_gen;
 	static struct cpumask has_work;
-	int cpu, seq;
+	static DEFINE_MUTEX(lock);
+	unsigned cpu, this_gen;
 
 	/*
 	 * Make sure nobody triggers this path before mm_percpu_wq is fully
@@ -775,21 +785,54 @@ void lru_add_drain_all(void)
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
-	seq = raw_read_seqcount_latch(&seqcount);
+	/*
+	 * Guarantee pagevec counter stores visible by this CPU are visible to
+	 * other CPUs before loading the current drain generation.
+	 */
+	smp_mb();
+
+	/*
+	 * (B) Locally cache global LRU draining generation number
+	 *
+	 * The read barrier ensures that the counter is loaded before the mutex
+	 * is taken. It pairs with smp_mb() inside the mutex critical section
+	 * at (D).
+	 */
+	this_gen = smp_load_acquire(&lru_drain_gen);
 
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
+	 * (D) Increment global generation number
+	 *
+	 * Pairs with smp_load_acquire() at (B), outside of the critical
+	 * section. Use a full memory barrier to guarantee that the new global
+	 * drain generation number is stored before loading pagevec counters.
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
+	 * If the paired barrier is done at any later step, e.g. after the
+	 * loop, CPU #x will just exit at (C) and miss flushing out all of its
+	 * added pages.
+	 */
+	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
+	smp_mb();
 
 	cpumask_clear(&has_work);
-
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
@@ -801,7 +844,7 @@ void lru_add_drain_all(void)
 		    need_activate_page_drain(cpu)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
-			cpumask_set_cpu(cpu, &has_work);
+			__cpumask_set_cpu(cpu, &has_work);
 		}
 	}
 
@@ -816,7 +859,7 @@ void lru_add_drain_all(void)
 {
 	lru_add_drain();
 }
-#endif
+#endif /* CONFIG_SMP */
 
 /**
  * release_pages - batched put_page()
-- 
2.28.0

