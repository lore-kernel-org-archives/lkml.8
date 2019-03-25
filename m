Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E55CC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6297B20857
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgC1Qnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:51 -0400
Received: from mx.sdf.org ([205.166.94.20]:50013 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbgC1Qnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:32 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhFgW020751
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:15 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhFHS018988;
        Sat, 28 Mar 2020 16:43:15 GMT
Message-Id: <202003281643.02SGhFHS018988@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Mon, 25 Mar 2019 01:22:12 -0400
Subject: [RFC PATCH v1 22/50] lib/random32: Use random_ready_callback for
 seeding.
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole seeding code was a mess, and triggered boot-time warnings
about crng_init=0.  Clean it up to use the random_ready_callback
exported from drivers/char/random.c.

Particular changes:
* prandom_reseed_late() was dead code
* All the locking in __prandom_reseed is unnecessary and deleted
* Moved __prandom_timer to a more logical place, in addition to
  other changes.  Sorry for the larger diff.
* Use round_jiffies on the reseed timer
* Use mod_timer is simpler to use than add_timer

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
---
 include/linux/random.h |   1 -
 lib/random32.c         | 157 +++++++++++++++++++----------------------
 2 files changed, 71 insertions(+), 87 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 9e30f0bb3e50b..4a325f5cf298f 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -112,7 +112,6 @@ unsigned long randomize_page(unsigned long start, unsigned long range);
 u32 prandom_u32(void);
 void prandom_bytes(void *buf, size_t nbytes);
 void prandom_seed(u32 seed);
-void prandom_reseed_late(void);
 
 struct rnd_state {
 	__u32 s[4];
diff --git a/lib/random32.c b/lib/random32.c
index 5d8483243c410..5191da383dd18 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -167,12 +167,17 @@ void prandom_bytes(void *buf, size_t bytes)
 }
 EXPORT_SYMBOL(prandom_bytes);
 
+/*
+ * Prefer arch_get_random_int (x86 RDRAND instruction) over
+ * arch_get_random_seed_int (x86 RDSEED) for this application,
+ * as it's good enough, and cheaper.
+ */
 static u32 __extract_hwseed(void)
 {
 	unsigned int val = 0;
 
-	(void)(arch_get_random_seed_int(&val) ||
-	       arch_get_random_int(&val));
+	(void)(arch_get_random_int(&val) ||
+	       arch_get_random_seed_int(&val));
 
 	return val;
 }
@@ -205,9 +210,7 @@ static u32 mix32(u32 x)
  *	@seed: seed value
  *	@mix_with_hwseed: flag enabling use of hardware entropy, if avaiable
  *
- *	This initializes the state without using the /dev/random pool
- *	(which is assumed to not be ready yet).  If @mix_with_hwseed is
- *	%false, the seeding is repeatable.
+ *	This avoids using /dev/urandom, which is not ready yet.
  *
  *	The test for an all-zero state is arguably pointless.  It is
  *	impossible if @mix_with_hwseed is %false, and has probability of
@@ -215,7 +218,7 @@ static u32 mix32(u32 x)
  */
 void prandom_seed_early(struct rnd_state *state, u32 seed, bool mix_with_hwseed)
 {
-	uint32_t bits;
+	u32 bits;
 
 	do {
 		int i;
@@ -231,6 +234,31 @@ void prandom_seed_early(struct rnd_state *state, u32 seed, bool mix_with_hwseed)
 }
 EXPORT_SYMBOL(prandom_seed_early);
 
+/**
+ *	prandom_init - Initial weak seeding of the prandom_u32() engine
+ */
+static int __init prandom_init(void)
+{
+	int i;
+
+	prandom_state_selftest();
+
+	for_each_possible_cpu(i) {
+		struct rnd_state *state = &per_cpu(net_rand_state, i);
+		u32 weak_seed = mix32(i + jiffies) ^ random_get_entropy();
+
+		prandom_seed_early(state, weak_seed, true);
+	}
+
+	return 0;
+}
+core_initcall(prandom_init);
+
+/*
+ * When /dev/urandom is ready, we reseed the generator completely, then
+ * do periodic minor reseeding.  The following code manages that.
+ */
+
 /**
  *	prandom_seed - add entropy to pseudo random number generator
  *	@entropy: entropy value
@@ -280,52 +308,6 @@ void prandom_seed(u32 entropy)
 }
 EXPORT_SYMBOL(prandom_seed);
 
-/*
- *	Generate some initially weak seeding values to allow
- *	to start the prandom_u32() engine.
- */
-static int __init prandom_init(void)
-{
-	int i;
-
-	prandom_state_selftest();
-
-	for_each_possible_cpu(i) {
-		struct rnd_state *state = &per_cpu(net_rand_state, i);
-		u32 weak_seed = (i + jiffies) ^ random_get_entropy();
-
-		prandom_seed_early(state, weak_seed, true);
-	}
-
-	return 0;
-}
-core_initcall(prandom_init);
-
-static void __prandom_timer(struct timer_list *unused);
-
-static DEFINE_TIMER(seed_timer, __prandom_timer);
-
-static void __prandom_timer(struct timer_list *unused)
-{
-	u32 entropy;
-	unsigned long expires;
-
-	get_random_bytes(&entropy, sizeof(entropy));
-	prandom_seed(entropy);
-
-	/* reseed every ~60 seconds, in [40 .. 80) interval with slack */
-	expires = 40 * HZ + prandom_u32_max(40 * HZ);
-	seed_timer.expires = jiffies + expires;
-
-	add_timer(&seed_timer);
-}
-
-static void __init __prandom_start_seed_timer(void)
-{
-	seed_timer.expires = jiffies + 40 * HZ;
-	add_timer(&seed_timer);
-}
-
 /**
  *	prandom_seed_full_state - Reseed PRNG with full entropy
  *	@pcpu_state: Per-CPU state to update
@@ -351,48 +333,51 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
 }
 EXPORT_SYMBOL(prandom_seed_full_state);
 
+static void __prandom_timer(struct timer_list *unused);
+
+static DEFINE_TIMER(seed_timer, __prandom_timer);
+
+static void __prandom_timer(struct timer_list *unused)
+{
+	unsigned long expires;
+	static bool seeded = false;
+
+	if (seeded) {
+		prandom_seed(get_random_u32());
+	} else if (rng_is_initialized()) {
+		/* First time, do a full reseed */
+		seeded = true;
+		prandom_seed_full_state(&net_rand_state);
+	}
+
+	/* reseed every ~60 seconds, in [40 .. 80) interval with slack */
+	expires = round_jiffies(jiffies + 40 * HZ + prandom_u32_max(40 * HZ));
+	mod_timer(&seed_timer, expires);
+}
+
 /*
- *	Generate better values after random number generator
- *	is fully initialized.
+ * The random ready callback can be called from almost any interrupt.
+ * To avoid worrying about whether it's safe to delay that interrupt
+ * long enough to seed all CPUs, just schedule an immediate timer event.
  */
-static void __prandom_reseed(bool late)
+static void prandom_timer_start(struct random_ready_callback *unused)
 {
-	unsigned long flags;
-	static bool latch = false;
-	static DEFINE_SPINLOCK(lock);
-
-	/* Asking for random bytes might result in bytes getting
-	 * moved into the nonblocking pool and thus marking it
-	 * as initialized. In this case we would double back into
-	 * this function and attempt to do a late reseed.
-	 * Ignore the pointless attempt to reseed again if we're
-	 * already waiting for bytes when the nonblocking pool
-	 * got initialized.
-	 */
-
-	/* only allow initial seeding (late == false) once */
-	if (!spin_trylock_irqsave(&lock, flags))
-		return;
-
-	if (latch && !late)
-		goto out;
-
-	latch = true;
-	prandom_seed_full_state(&net_rand_state);
-out:
-	spin_unlock_irqrestore(&lock, flags);
+	mod_timer(&seed_timer, jiffies);
 }
 
-void prandom_reseed_late(void)
-{
-	__prandom_reseed(true);
-}
+static struct random_ready_callback random_ready = {
+        .func = prandom_timer_start
+};
 
 static int __init prandom_reseed(void)
 {
-	__prandom_reseed(false);
-	__prandom_start_seed_timer();
-	return 0;
+	int ret = add_random_ready_callback(&random_ready);
+
+	if (ret == -EALREADY) {
+		prandom_timer_start(&random_ready);
+		ret = 0;
+	}
+	return ret;
 }
 late_initcall(prandom_reseed);
 
-- 
2.26.0

