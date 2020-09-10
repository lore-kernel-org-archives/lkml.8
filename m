Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D92C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E45207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xwISuiDi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3aGRWhvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgIJT1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731411AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163EC06135B;
        Thu, 10 Sep 2020 08:08:31 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCurwOkbo5AoczvL3xuGbBKL9eeVyxXTS5Nyvj202ok=;
        b=xwISuiDi1sPiik7upOitVxCZnCrtUXtPkl0OifZ6AqdPFS3EpBA3E2EsljCG9t/vs5HVuG
        aj72LMu2PrQ9KJoe6FJipmWAdieKySeyt3KHcq4MsWFCJbW+sjTQbbHF4tibweY+dG3F5n
        eBAgYiajXDsnHUlr0irrq7tDAGtA8EifAVyQzrRWuegpYOSGAHb/8c/EEfoi6CpreYOrIc
        ufej1aGPceXkL3+tWaaaRe2in3cwmGaL2oa+veMi4E9sXr4eY6mwpFOId4l83w35AX6aZc
        Zk8fRDXDBasLK4+UtLZjGMwE8chInEGDJLDGnc1MZRvJjir0WoptCj2exWXbsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCurwOkbo5AoczvL3xuGbBKL9eeVyxXTS5Nyvj202ok=;
        b=3aGRWhvnxY9HfKDAuvdR31y+PbjCa6C+AlEEKCuoiv8ZPnENVNtHwJlmcbbqW/nCr/Wz//
        Ye4UA/d3Y/SGO0DA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] mm/swap: Do not abuse the seqcount_t latching API
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87y2pg9erj.fsf@vostro.fn.ogness.net>
References: <87y2pg9erj.fsf@vostro.fn.ogness.net>
MIME-Version: 1.0
Message-ID: <159975050868.20229.18166886647511885303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6446a5131e24a834606c15a965fa920041581c2c
Gitweb:        https://git.kernel.org/tip/6446a5131e24a834606c15a965fa920041581c2c
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Thu, 27 Aug 2020 13:40:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:28 +02:00

mm/swap: Do not abuse the seqcount_t latching API

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

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/87y2pg9erj.fsf@vostro.fn.ogness.net
---
 mm/swap.c | 65 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index d16d65d..a1ec807 100644
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
