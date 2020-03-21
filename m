Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB1C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE941206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgC1Qpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:45:31 -0400
Received: from mx.sdf.org ([205.166.94.20]:50061 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgC1Qp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:45:28 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhL1V006742
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:21 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhLrR019851;
        Sat, 28 Mar 2020 16:43:21 GMT
Message-Id: <202003281643.02SGhLrR019851@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Sat, 21 Mar 2020 09:44:23 -0400
Subject: [RFC PATCH v1 37/50] random: Simplify locking of batched entropy
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b7d5dc21072c added a spin_lock_irqsave to prevent an
interrupt from re-entering the batched entropy extraction.

But this is heavier weight that we need or want.  There's no need
for multiprocessor locking on a per-cpu structure; the only part
of the locking we need is local_irq_save().

That disables preemption, allowing lock-free access to per-CPU
variables.

The only inter-CPU access is via invalidate_cached_entropy(),
and that's also easy to eliminate.  It's just a notification that
crng_init has changed, so delete it entirely and instead have each
reader invalidate itself if the global value changes from a shadow
copy kept in each batch structure.  (Each read operation already
reads the global crng_init value in warn_unseeded_randomness(),
so it's cache-hot.)

All necessary memory barriers (to ensure that extract_crng()
sees the new seed material after crng_init is changed) are taken
care of by the primary_crng.lock.

Since we're using it more places, make crng_init an explicit enum
for documentation's sake.  (And mark it __read_mostly.)

Code size -265 bytes (x86_64).

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c | 92 ++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 43c1eb9866de7..457b5204ffb99 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -493,17 +493,22 @@ static struct crng_state primary_crng = {
 };
 
 /*
- * crng_init =  0 --> Uninitialized
- *		1 --> Initialized
- *		2 --> Initialized from input_pool
+ * crng_init =  1 --> Uninitialized
+ *		2 --> Initialized by crng_fast_load()
+ *		3 --> Initialized from input_pool
  *
  * crng_init is protected by primary_crng->lock, and only increases
- * its value (from 0->1->2).
+ * its value (from 1->2->3).
  */
-static int crng_init = 0;
-#define crng_ready() (likely(crng_init > 1))
+static enum crng_init {
+	CRNG_INVALID,
+	CRNG_UNINITIALIZED,
+	CRNG_FAST_INIT,
+	CRNG_READY
+} crng_init __read_mostly = CRNG_UNINITIALIZED;
+#define crng_ready() likely(crng_init == CRNG_READY)
 static int crng_init_cnt = 0;
-static unsigned long crng_global_init_time = 0;
+static unsigned long crng_global_init_time __read_mostly = 0;
 #define CRNG_INIT_CNT_THRESH (2*CHACHA_KEY_SIZE)
 static void _extract_crng(struct crng_state *crng, __u8 out[CHACHA_BLOCK_SIZE]);
 static void _crng_backtrack_protect(struct crng_state *crng,
@@ -834,7 +839,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
 		struct entropy_store *other = &blocking_pool;
 
-		if (crng_init < 2) {
+		if (!crng_ready()) {
 			if (entropy_bits < 128)
 				return;
 			crng_reseed(&primary_crng, r);
@@ -899,7 +904,6 @@ static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct crng_state **crng_node_pool __read_mostly;
 #endif
 
-static void invalidate_batched_entropy(void);
 static void numa_crng_init(void);
 
 static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
@@ -930,9 +934,8 @@ static void crng_initialize(struct crng_state *crng)
 		crng->state[i] ^= rv;
 	}
 	if (trust_cpu && arch_init && crng == &primary_crng) {
-		invalidate_batched_entropy();
 		numa_crng_init();
-		crng_init = 2;
+		crng_init = CRNG_READY;
 		pr_notice("random: crng done (trusting CPU's manufacturer)\n");
 	}
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
@@ -982,7 +985,7 @@ static int crng_fast_load(const char *cp, size_t len)
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
-	if (crng_init != 0) {
+	if (crng_init != CRNG_UNINITIALIZED) {
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 		return 0;
 	}
@@ -993,8 +996,7 @@ static int crng_fast_load(const char *cp, size_t len)
 	}
 	spin_unlock_irqrestore(&primary_crng.lock, flags);
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
-		invalidate_batched_entropy();
-		crng_init = 1;
+		crng_init = CRNG_FAST_INIT;
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: fast init done\n");
 	}
@@ -1026,7 +1028,7 @@ static int crng_slow_load(const char *cp, size_t len)
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
-	if (crng_init != 0) {
+	if (crng_init != CRNG_UNINITIALIZED) {
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 		return 0;
 	}
@@ -1075,10 +1077,9 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 	memzero_explicit(&buf, sizeof(buf));
 	crng->init_time = jiffies;
 	spin_unlock_irqrestore(&crng->lock, flags);
-	if (crng == &primary_crng && crng_init < 2) {
-		invalidate_batched_entropy();
+	if (crng == &primary_crng && !crng_ready()) {
 		numa_crng_init();
-		crng_init = 2;
+		crng_init = CRNG_READY;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: crng init done\n");
@@ -1380,7 +1381,7 @@ void add_interrupt_randomness(int irq, int irq_flags)
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
 
-	if (unlikely(crng_init == 0)) {
+	if (unlikely(crng_init == CRNG_UNINITIALIZED)) {
 		if ((fast_pool->count >= 64) &&
 		    crng_fast_load((char *) fast_pool->pool,
 				   sizeof(fast_pool->pool))) {
@@ -1843,7 +1844,7 @@ static void try_to_generate_entropy(void)
  */
 int wait_for_random_bytes(void)
 {
-	if (likely(crng_ready()))
+	if (crng_ready())
 		return 0;
 
 	do {
@@ -2196,7 +2197,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case RNDRESEEDCRNG:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (crng_init < 2)
+		if (!crng_ready())
 			return -ENODATA;
 		crng_reseed(&primary_crng, NULL);
 		crng_global_init_time = jiffies - 1;
@@ -2406,7 +2407,7 @@ struct batched_entropy {
 		u8 position;	/* Offset of last consumed byte */
 				/* Fresh data starts at position + 1 */
 	};
-	spinlock_t batch_lock;
+	enum crng_init crng_init;
 };
 
 /*
@@ -2426,10 +2427,13 @@ struct batched_entropy {
  * Because we only fill it on demand, it's never completely full between
  * calls, and the first byte is re-used to store the offset of the
  * available data in the tail of the buffer.
+ *
+ * Each entropy batch is accessed only by its own processor, so inter-CPU
+ * locking is not required.  But we do need to (locally) block interrupts,
+ * to prevent reentrant calls from interrupt handlers.
  */
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy) = {
-	.position	= CHACHA_BLOCK_SIZE,
-	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy.lock)
+	.crng_init	= CRNG_INVALID
 };
 
 /**
@@ -2485,9 +2489,13 @@ u64 get_random_u64(void)
 
 	warn_unseeded_randomness(&previous);
 
-	batch = raw_cpu_ptr(&batched_entropy);
-	spin_lock_irqsave(&batch->batch_lock, flags);
+	local_irq_save(flags);	/* Disables preemption */
+	batch = this_cpu_ptr(&batched_entropy);
 	pos = batch->position;
+	if (unlikely(batch->crng_init != crng_init)) {
+		batch->crng_init = crng_init;
+		pos = CHACHA_BLOCK_SIZE - 1;
+	}
 	batch->position = (pos + sizeof(ret)) & (CHACHA_BLOCK_SIZE - 1);
 	/* First partial word (0..7 bytes used) */
 	pos &= -sizeof(ret);
@@ -2499,7 +2507,7 @@ u64 get_random_u64(void)
 	}
 	/* Second partial word (1..8 bytes used) */
 	ret ^= *(u64 *)(batch->entropy8 + pos);	/* XOR trick described above */
-	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u64);
@@ -2536,9 +2544,13 @@ u32 get_random_u32(void)
 
 	warn_unseeded_randomness(&previous);
 
-	batch = raw_cpu_ptr(&batched_entropy);
-	spin_lock_irqsave(&batch->batch_lock, flags);
+	local_irq_save(flags);	/* Disables preemption */
+	batch = this_cpu_ptr(&batched_entropy);
 	pos = batch->position;
+	if (unlikely(batch->crng_init != crng_init)) {
+		batch->crng_init = crng_init;
+		pos = CHACHA_BLOCK_SIZE;
+	}
 	batch->position = (pos + sizeof(ret)) & (CHACHA_BLOCK_SIZE - 1);
 	/* First partial word (0..7 bytes used) */
 	pos &= -sizeof(ret);
@@ -2551,29 +2563,11 @@ u32 get_random_u32(void)
 	}
 	/* Second partial word (1..8 bytes used) */
 	ret ^= *(u32 *)(batch->entropy8 + pos);
-	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u32);
 
-/* It's important to invalidate all potential batched entropy that might
- * be stored before the crng is initialized.
- */
-static void invalidate_batched_entropy(void)
-{
-	int cpu;
-
-	for_each_possible_cpu (cpu) {
-		struct batched_entropy *batch;
-		unsigned long flags;
-
-		batch = per_cpu_ptr(&batched_entropy, cpu);
-		spin_lock_irqsave(&batch->batch_lock, flags);
-		batch->position = CHACHA_BLOCK_SIZE - 1;
-		spin_unlock_irqrestore(&batch->batch_lock, flags);
-	}
-}
-
 /**
  * randomize_page - Generate a random, page aligned address
  * @start:	The smallest acceptable address the caller will take.
@@ -2616,7 +2610,7 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 {
 	struct entropy_store *poolp = &input_pool;
 
-	if (unlikely(crng_init == 0)) {
+	if (unlikely(crng_init == CRNG_UNINITIALIZED)) {
 		crng_fast_load(buffer, count);
 		return;
 	}
-- 
2.26.0

