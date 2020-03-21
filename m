Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248EBC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB45A206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgC1Qpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:45:32 -0400
Received: from mx.sdf.org ([205.166.94.20]:49580 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgC1Qpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:45:30 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhLSG024445
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:22 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhLP9019727;
        Sat, 28 Mar 2020 16:43:21 GMT
Message-Id: <202003281643.02SGhLP9019727@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Sat, 21 Mar 2020 14:03:23 -0400
Subject: [RFC PATCH v1 38/50] random: use chacha_permute() directly
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was triggered by noting that chacha20_block() uses a
temporary buffer which it doesn't memzero_explicit(), violating
the desired security properties of get_random_bytes().

Rather than simply fixing that, I decided to get rid of the
temporary buffer entirely.  It's only needed to support unaligned
output and a consistent byte order.  A CRNG doesn't care about
byte order and can easily allocate aligned buffers.

Similarly, incrementing the 64-bit sequence number in state
words 12 and 13 can be done in native byte order.

(The previous code already used native byte order for the
input constant "expand 32-byte k", so this is nothing new.)

Also perform several key operations long-at-a-time where
possible.  For backtrack protection, this just speeds them up,
but the old code in crng_init() and _extract_crng() would call
arch_get_random_long() and then only use the low 32 bits of
the (fairly expensive) HWRNG output.

Code simplification: factor out the "choose the crng" code shared
by the crng_extract() and crng_backtrack_protect() wrappers into
a default_crng() function.  In code paths where multiple calls
are made, call default_crng() once and cache the result.

This allowed the crng_backtrack_protect() wrapper to be
eliminated, so _crng_backtrack_protect lost its leading
ubnderscore.

Code simplification: in crng_backtrack_protect(), after ensuring
8x32-bit words of unused output are available, the old code would
use the first unused 8 words.  Instead, use the last 8 words in
the buffer, always.

Code size +3 bytes (x86-64).  No change to lib/crypto/chacha.o;
chacha_permute was not inlined.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/char/random.c   | 149 ++++++++++++++++++++--------------------
 include/crypto/chacha.h |   1 +
 lib/crypto/chacha.c     |   2 +-
 3 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 457b5204ffb99..b8c2f8b0be6f6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -482,8 +482,18 @@ static struct fasync_struct *fasync;
 static DEFINE_SPINLOCK(random_ready_list_lock);
 static LIST_HEAD(random_ready_list);
 
+/*
+ * This declaration is verbose enough that it's awkward in argument lists,
+ * so make a typedef.  8-byte aligned because we do one 64-bit opration
+ * (incrementing the sequence number in words 12 and 13) and several
+ * long operations (XORing keys).
+ */
+typedef u32 chacha_buf_t[CHACHA_BLOCK_SIZE / sizeof(u32)] __aligned(8);
+/* Access the long at a particular (aligned!) byte offset */
+#define LONG_AT(p, offset) *(unsigned long *)((char *)(p) + offset)
+
 struct crng_state {
-	__u32		state[16];
+	chacha_buf_t	state;
 	unsigned long	init_time;
 	spinlock_t	lock;
 };
@@ -510,9 +520,9 @@ static enum crng_init {
 static int crng_init_cnt = 0;
 static unsigned long crng_global_init_time __read_mostly = 0;
 #define CRNG_INIT_CNT_THRESH (2*CHACHA_KEY_SIZE)
-static void _extract_crng(struct crng_state *crng, __u8 out[CHACHA_BLOCK_SIZE]);
-static void _crng_backtrack_protect(struct crng_state *crng,
-				    __u8 tmp[CHACHA_BLOCK_SIZE], int used);
+static void _extract_crng(struct crng_state *crng, chacha_buf_t out);
+static void crng_backtrack_protect(struct crng_state *crng,
+				    chacha_buf_t tmp, int used);
 static void process_random_ready_list(void);
 static void _get_random_bytes(void *buf, int nbytes);
 
@@ -916,7 +926,7 @@ early_param("random.trust_cpu", parse_trust_cpu);
 static void crng_initialize(struct crng_state *crng)
 {
 	int		i;
-	int		arch_init = 1;
+	bool		arch_init = true;
 	unsigned long	rv;
 
 	memcpy(&crng->state[0], "expand 32-byte k", 16);
@@ -925,13 +935,13 @@ static void crng_initialize(struct crng_state *crng)
 				 sizeof(__u32) * 12, 0);
 	else
 		_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
-	for (i = 4; i < 16; i++) {
+	for (i = 16; i < CHACHA_BLOCK_SIZE; i += sizeof(long)) {
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv)) {
 			rv = random_get_entropy();
-			arch_init = 0;
+			arch_init = false;
 		}
-		crng->state[i] ^= rv;
+		LONG_AT(crng->state, i) ^= rv;
 	}
 	if (trust_cpu && arch_init && crng == &primary_crng) {
 		numa_crng_init();
@@ -1052,27 +1062,23 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 {
 	unsigned long	flags;
 	int		i, num;
-	union {
-		__u8	block[CHACHA_BLOCK_SIZE];
-		__u32	key[8];
-	} buf;
+	chacha_buf_t	buf;
 
 	if (r) {
 		num = extract_entropy(r, &buf, 32, 16, 0);
 		if (num == 0)
 			return;
 	} else {
-		_extract_crng(&primary_crng, buf.block);
-		_crng_backtrack_protect(&primary_crng, buf.block,
-					CHACHA_KEY_SIZE);
+		_extract_crng(&primary_crng, buf);
+		crng_backtrack_protect(&primary_crng, buf, CHACHA_KEY_SIZE);
 	}
 	spin_lock_irqsave(&crng->lock, flags);
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < CHACHA_KEY_SIZE; i += sizeof(long)) {
 		unsigned long	rv;
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv))
 			rv = random_get_entropy();
-		crng->state[i+4] ^= buf.key[i] ^ rv;
+		LONG_AT(crng->state + 4, i) ^= LONG_AT(buf, i) ^ rv;
 	}
 	memzero_explicit(&buf, sizeof(buf));
 	crng->init_time = jiffies;
@@ -1098,79 +1104,76 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 	}
 }
 
-static void _extract_crng(struct crng_state *crng,
-			  __u8 out[CHACHA_BLOCK_SIZE])
+static void _extract_crng(struct crng_state *crng, chacha_buf_t out)
 {
 	unsigned long v, flags;
+	int i;
 
 	if (crng_ready() &&
 	    (time_after(crng_global_init_time, crng->init_time) ||
 	     time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
 		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
+
 	spin_lock_irqsave(&crng->lock, flags);
 	if (arch_get_random_long(&v))
-		crng->state[14] ^= v;
-	chacha20_block(&crng->state[0], out);
-	if (crng->state[12] == 0)
-		crng->state[13]++;
+		*(long *)(crng->state + 14) ^= v;
+	memcpy(out, crng->state, CHACHA_BLOCK_SIZE);
+	chacha_permute(out, 20);
+	/*
+	 * Add input to permute output a long at a time.  This is
+	 * a minor deviation from the ChaCha spec (which specifies
+	 * 32-bit addition), cryptographically equivalent.
+	 */
+	for (i = 0; i < CHACHA_BLOCK_SIZE; i += sizeof(long))
+		LONG_AT(out, i) += LONG_AT(crng->state, i);
+	/* Increment 64-bit sequence number.  Native endianness is fine. */
+	*(u64 *)(crng->state + 12) += 1;
 	spin_unlock_irqrestore(&crng->lock, flags);
+
 }
 
-static void extract_crng(__u8 out[CHACHA_BLOCK_SIZE])
+/* Choose the default CRNG pool, which may depends on NUMA node */
+static struct crng_state *__pure default_crng(void)
 {
-	struct crng_state *crng = NULL;
-
 #ifdef CONFIG_NUMA
-	if (crng_node_pool)
-		crng = crng_node_pool[numa_node_id()];
-	if (crng == NULL)
+	if (crng_node_pool) {
+		struct crng_state *crng = crng_node_pool[numa_node_id()];
+		if (crng)
+			return crng;
+	}
 #endif
-		crng = &primary_crng;
-	_extract_crng(crng, out);
+	return &primary_crng;
+}
+
+static void extract_crng(chacha_buf_t out)
+{
+	_extract_crng(default_crng(), out);
 }
 
 /*
  * Use the leftover bytes from the CRNG block output (if there is
  * enough) to mutate the CRNG key to provide backtracking protection.
  */
-static void _crng_backtrack_protect(struct crng_state *crng,
-				    __u8 tmp[CHACHA_BLOCK_SIZE], int used)
+static void crng_backtrack_protect(struct crng_state *crng,
+				    chacha_buf_t tmp, int used)
 {
 	unsigned long	flags;
-	__u32		*s, *d;
 	int		i;
 
-	used = round_up(used, sizeof(__u32));
-	if (used + CHACHA_KEY_SIZE > CHACHA_BLOCK_SIZE) {
-		extract_crng(tmp);
-		used = 0;
-	}
+	if (used > CHACHA_BLOCK_SIZE - CHACHA_KEY_SIZE)
+		_extract_crng(crng, tmp);
 	spin_lock_irqsave(&crng->lock, flags);
-	s = (__u32 *) &tmp[used];
-	d = &crng->state[4];
-	for (i=0; i < 8; i++)
-		*d++ ^= *s++;
+	for (i = 0; i < CHACHA_KEY_SIZE; i += sizeof(long))
+		LONG_AT(crng->state + 4, i) ^= LONG_AT(tmp + 8, i);
 	spin_unlock_irqrestore(&crng->lock, flags);
 }
 
-static void crng_backtrack_protect(__u8 tmp[CHACHA_BLOCK_SIZE], int used)
-{
-	struct crng_state *crng = NULL;
-
-#ifdef CONFIG_NUMA
-	if (crng_node_pool)
-		crng = crng_node_pool[numa_node_id()];
-	if (crng == NULL)
-#endif
-		crng = &primary_crng;
-	_crng_backtrack_protect(crng, tmp, used);
-}
-
 static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
 {
 	ssize_t ret = 0, i = CHACHA_BLOCK_SIZE;
-	__u8 tmp[CHACHA_BLOCK_SIZE] __aligned(4);
+	chacha_buf_t tmp;
 	int large_request = (nbytes > 256);
+	struct crng_state *crng = default_crng();
 
 	while (nbytes) {
 		if (large_request && need_resched()) {
@@ -1182,7 +1185,7 @@ static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
 			schedule();
 		}
 
-		extract_crng(tmp);
+		_extract_crng(crng, tmp);
 		i = min_t(int, nbytes, CHACHA_BLOCK_SIZE);
 		if (copy_to_user(buf, tmp, i)) {
 			ret = -EFAULT;
@@ -1193,7 +1196,7 @@ static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
 		buf += i;
 		ret += i;
 	}
-	crng_backtrack_protect(tmp, i);
+	crng_backtrack_protect(crng, tmp, i);
 
 	/* Wipe data just written to memory */
 	memzero_explicit(tmp, sizeof(tmp));
@@ -1754,22 +1757,20 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
  */
 static void _get_random_bytes(void *buf, int nbytes)
 {
-	__u8 tmp[CHACHA_BLOCK_SIZE] __aligned(4);
+	chacha_buf_t tmp;
+	struct crng_state *crng;
 
 	trace_get_random_bytes(nbytes, _RET_IP_);
+	crng = default_crng();
 
-	while (nbytes >= CHACHA_BLOCK_SIZE) {
-		extract_crng(buf);
-		buf += CHACHA_BLOCK_SIZE;
-		nbytes -= CHACHA_BLOCK_SIZE;
+	for (;;) {
+		_extract_crng(crng, tmp);
+		if (nbytes <= CHACHA_BLOCK_SIZE)
+			break;
+		memcpy(buf, tmp, CHACHA_BLOCK_SIZE);
 	}
-
-	if (nbytes > 0) {
-		extract_crng(tmp);
-		memcpy(buf, tmp, nbytes);
-		crng_backtrack_protect(tmp, nbytes);
-	} else
-		crng_backtrack_protect(tmp, CHACHA_BLOCK_SIZE);
+	memcpy(buf, tmp, nbytes);
+	crng_backtrack_protect(crng, tmp, nbytes);
 	memzero_explicit(tmp, sizeof(tmp));
 }
 
@@ -2402,7 +2403,7 @@ struct ctl_table random_table[] = {
 struct batched_entropy {
 	union {
 		u64 entropy64[CHACHA_BLOCK_SIZE / sizeof(u64)];
-		u32 entropy32[CHACHA_BLOCK_SIZE / sizeof(u32)];
+		chacha_buf_t entropy32;
 		u8 entropy8[CHACHA_BLOCK_SIZE];
 		u8 position;	/* Offset of last consumed byte */
 				/* Fresh data starts at position + 1 */
@@ -2502,7 +2503,7 @@ u64 get_random_u64(void)
 	ret = *(u64 *)(batch->entropy8 + pos);
 	pos += sizeof(ret);
 	if (pos == CHACHA_BLOCK_SIZE) {
-		extract_crng(batch->entropy8);
+		extract_crng(batch->entropy32);
 		pos = 0;
 	}
 	/* Second partial word (1..8 bytes used) */
@@ -2558,7 +2559,7 @@ u32 get_random_u32(void)
 	pos += sizeof(ret);
 	/* unlikely is defined by gcc as 10% probable.  This is 1/16 */
 	if (unlikely(pos == CHACHA_BLOCK_SIZE)) {
-		extract_crng(batch->entropy8);
+		extract_crng(batch->entropy32);
 		pos = 0;
 	}
 	/* Second partial word (1..8 bytes used) */
diff --git a/include/crypto/chacha.h b/include/crypto/chacha.h
index 2676f4fbd4c16..bcd8d99819715 100644
--- a/include/crypto/chacha.h
+++ b/include/crypto/chacha.h
@@ -34,6 +34,7 @@
 /* 192-bit nonce, then 64-bit stream position */
 #define XCHACHA_IV_SIZE		32
 
+void chacha_permute(u32 x[CHACHA_BLOCK_SIZE/4], int nrounds);
 void chacha_block_generic(u32 *state, u8 *stream, int nrounds);
 static inline void chacha20_block(u32 *state, u8 *stream)
 {
diff --git a/lib/crypto/chacha.c b/lib/crypto/chacha.c
index 65ead6b0c7e00..166b3566b030b 100644
--- a/lib/crypto/chacha.c
+++ b/lib/crypto/chacha.c
@@ -14,7 +14,7 @@
 #include <asm/unaligned.h>
 #include <crypto/chacha.h>
 
-static void chacha_permute(u32 *x, int nrounds)
+void chacha_permute(u32 x[16], int nrounds)
 {
 	int i;
 
-- 
2.26.0

