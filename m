Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C75C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EC3206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgC1Qpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:45:30 -0400
Received: from mx.sdf.org ([205.166.94.20]:50068 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgC1Qp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:45:28 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhLIs009854
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:21 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhLiv003379;
        Sat, 28 Mar 2020 16:43:21 GMT
Message-Id: <202003281643.02SGhLiv003379@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Sun, 8 Dec 2019 21:03:28 -0500
Subject: [RFC PATCH v1 36/50] random: Merge batched entropy buffers
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use just one batched entropy buffer for u32 and u64 results,
saving 72 bytes per CPU.  (On 32-bit platforms, the buffer is
also shrunk by 4 bytes.)

A further space-saving hack is to note that the buffer is never
completely full between calls, so the read position can be stored
in the first byte.

The only reason for having two buffers was to avoid dealing with
unaligned 64-bit fetches, particularly across a buffer refill
boundary.  This can be handled without increasing code size
(in fact, this patch saves 78 bytes of text on x86-64).

$ size drivers/char/random.o.*
   text    data     bss     dec     hex filename
  16966    1461     864   19291    4b5b drivers/char/random.o.old
  16888    1365     864   19117    4aad drivers/char/random.o.new
     78      96

The magic is an "XOR trick" for combining fresh (i.e. never exposed
to an attacker) and stale (previously exposed) random data.

If X and Y are both fresh, then X^Y and Y are also both fresh.
Exposing X^Y does not expose Y.

If X is stale, then X^Y is fresh, but after exposing it, Y is stale.

If X is part-fresh and part-stale, then the magic happens:
X^Y is all fresh, and the corresponding parts of Y become stale.

The effect is that we can fetch a fresh random word from an unaligned
buffer position by xoring two aligned words.

On some platforms, we could just do an unaligned fetch, but doing
it this way simplifies buffer underflow handling.

In fact, get_random_u32 could be simplified further since the
buffer is guaranteed 4-byte aligned, but it's written to allow
a future byte-aligned variant to be added.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c | 150 +++++++++++++++++++++++++++++++-----------
 1 file changed, 112 insertions(+), 38 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 52dbe0357520b..43c1eb9866de7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2400,28 +2400,76 @@ struct ctl_table random_table[] = {
 
 struct batched_entropy {
 	union {
-		u64 entropy_u64[CHACHA_BLOCK_SIZE / sizeof(u64)];
-		u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
+		u64 entropy64[CHACHA_BLOCK_SIZE / sizeof(u64)];
+		u32 entropy32[CHACHA_BLOCK_SIZE / sizeof(u32)];
+		u8 entropy8[CHACHA_BLOCK_SIZE];
+		u8 position;	/* Offset of last consumed byte */
+				/* Fresh data starts at position + 1 */
 	};
-	unsigned int position;
 	spinlock_t batch_lock;
 };
 
 /*
- * Get a random word for internal kernel use only. The quality of the random
- * number is either as good as RDRAND or as good as /dev/urandom, with the
- * goal of being quite fast and not depleting entropy. In order to ensure
- * that the randomness provided by this function is okay, the function
- * wait_for_random_bytes() should be called and return 0 at least once
- * at any point prior.
+ * Get a random word for applications which do not require forward
+ * secrecy.  There are many such applications in the kernel, which
+ * can be identified by the lack of a memzero_explicit() to ensure that
+ * the value remains secret after the kernel is done using it.
+ *
+ * The quality of the random numbers is either as good as RDRAND or
+ * as good as /dev/urandom, with the goal of being quite fast and not
+ * depleting entropy. In order to ensure that the randomness provided
+ * by these functions is okay, the function wait_for_random_bytes()
+ * should be called and return 0 at least once at any point prior.
+ *
+ * When RDRAND is not available, we use per-CPU "batched entropy" buffers
+ * which store up to CHACHA_BLOCK_SIZE bytes of precomputed CRNG output.
+ * Because we only fill it on demand, it's never completely full between
+ * calls, and the first byte is re-used to store the offset of the
+ * available data in the tail of the buffer.
  */
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
-	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy) = {
+	.position	= CHACHA_BLOCK_SIZE,
+	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy.lock)
 };
 
+/**
+ * get_random_u64 - Generate a random 64-bit value
+ *
+ * Return a cryptographically strong random number.  Unlike
+ * get_random_bytes(), this does not do (expensive!) backtracking
+ * protection; the value returned can be recovered by a later attacker
+ * who gains read access to kernel memory.  This is completely fine in
+ * the very common case that the secret derived from the value returned
+ * is stored in the kernel for as long as it is valuable.  (E.g. a hash
+ * salt, an authentication cookie, or a randomized address space.)
+ *
+ * It is perfectly safe to expose the output of this generator to
+ * hostile attackers; backtracking is only relevant to attackers who
+ * gain access to its input (its internal state).
+ *
+ * Uses (only!) the hardware RNG (e.g. RDRAND) if available.
+ *
+ * There's an XOR trick which is used in the implementation to deal with
+ * unaligned buffers without doing unaligned fetches.
+ *
+ * If X and Y are fresh random values, then X^Y and Y are also fresh
+ * random values.  You're not "using Y twice" in any sort of bad way.
+ *
+ * If X is a value known to an attacker (or even maliciously chosen
+ * by an attacker), then X^Y is still fresh.  (But after using it,
+ * Y is no longer fresh.)
+ *
+ * Combining these bytewise, If X is a partially-used word consisting
+ * of a prefix of attacker-known bytes, and a suffix of fresh bytes,
+ * then X^Y is fully random, *and* Y now has a prefix which has been
+ * exposed and a suffix which is still fresh.
+ *
+ * Return: A cryptographically strong 64-bit random value.
+ */
 u64 get_random_u64(void)
 {
 	u64 ret;
+	size_t pos;
 	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
@@ -2437,24 +2485,48 @@ u64 get_random_u64(void)
 
 	warn_unseeded_randomness(&previous);
 
-	batch = raw_cpu_ptr(&batched_entropy_u64);
+	batch = raw_cpu_ptr(&batched_entropy);
 	spin_lock_irqsave(&batch->batch_lock, flags);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
-		extract_crng((u8 *)batch->entropy_u64);
-		batch->position = 0;
+	pos = batch->position;
+	batch->position = (pos + sizeof(ret)) & (CHACHA_BLOCK_SIZE - 1);
+	/* First partial word (0..7 bytes used) */
+	pos &= -sizeof(ret);
+	ret = *(u64 *)(batch->entropy8 + pos);
+	pos += sizeof(ret);
+	if (pos == CHACHA_BLOCK_SIZE) {
+		extract_crng(batch->entropy8);
+		pos = 0;
 	}
-	ret = batch->entropy_u64[batch->position++];
+	/* Second partial word (1..8 bytes used) */
+	ret ^= *(u64 *)(batch->entropy8 + pos);	/* XOR trick described above */
 	spin_unlock_irqrestore(&batch->batch_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u64);
 
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
-	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
-};
+/**
+ * get_random_u32 - Generate a random 32-bit value
+ *
+ * Return a cryptographically strong random number.  Unlike
+ * get_random_bytes(), this does not do (expensive!) backtracking
+ * protection; the value returned can be recovered by a later attacker
+ * who gains read access to kernel memory.  This is completely fine in
+ * the very common case that the secret derived from the value returned
+ * is stored in the kernel for as long as it is valuable.  (E.g. a hash
+ * salt, an authentication cookie, or a randomized address space.)
+ *
+ * It is perfectly safe to expose the output of this generator to
+ * hostile attackers; backtracking is only relevant to attackers who
+ * gain access to its input (its internal state).
+ *
+ * Uses (only!) the hardware RNG (e.g. RDRAND) if available.
+ *
+ * Return: A cryptographically strong 32-bit random value.
+ */
 u32 get_random_u32(void)
 {
 	u32 ret;
+	size_t pos;
 	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
@@ -2464,39 +2536,41 @@ u32 get_random_u32(void)
 
 	warn_unseeded_randomness(&previous);
 
-	batch = raw_cpu_ptr(&batched_entropy_u32);
+	batch = raw_cpu_ptr(&batched_entropy);
 	spin_lock_irqsave(&batch->batch_lock, flags);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0) {
-		extract_crng((u8 *)batch->entropy_u32);
-		batch->position = 0;
+	pos = batch->position;
+	batch->position = (pos + sizeof(ret)) & (CHACHA_BLOCK_SIZE - 1);
+	/* First partial word (0..7 bytes used) */
+	pos &= -sizeof(ret);
+	ret = *(u32 *)(batch->entropy8 + pos);
+	pos += sizeof(ret);
+	/* unlikely is defined by gcc as 10% probable.  This is 1/16 */
+	if (unlikely(pos == CHACHA_BLOCK_SIZE)) {
+		extract_crng(batch->entropy8);
+		pos = 0;
 	}
-	ret = batch->entropy_u32[batch->position++];
+	/* Second partial word (1..8 bytes used) */
+	ret ^= *(u32 *)(batch->entropy8 + pos);
 	spin_unlock_irqrestore(&batch->batch_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u32);
 
 /* It's important to invalidate all potential batched entropy that might
- * be stored before the crng is initialized, which we can do lazily by
- * simply resetting the counter to zero so that it's re-extracted on the
- * next usage. */
+ * be stored before the crng is initialized.
+ */
 static void invalidate_batched_entropy(void)
 {
 	int cpu;
-	unsigned long flags;
 
 	for_each_possible_cpu (cpu) {
-		struct batched_entropy *batched_entropy;
+		struct batched_entropy *batch;
+		unsigned long flags;
 
-		batched_entropy = per_cpu_ptr(&batched_entropy_u32, cpu);
-		spin_lock_irqsave(&batched_entropy->batch_lock, flags);
-		batched_entropy->position = 0;
-		spin_unlock(&batched_entropy->batch_lock);
-
-		batched_entropy = per_cpu_ptr(&batched_entropy_u64, cpu);
-		spin_lock(&batched_entropy->batch_lock);
-		batched_entropy->position = 0;
-		spin_unlock_irqrestore(&batched_entropy->batch_lock, flags);
+		batch = per_cpu_ptr(&batched_entropy, cpu);
+		spin_lock_irqsave(&batch->batch_lock, flags);
+		batch->position = CHACHA_BLOCK_SIZE - 1;
+		spin_unlock_irqrestore(&batch->batch_lock, flags);
 	}
 }
 
-- 
2.26.0

