Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F54C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EC3206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgC1Qpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:45:42 -0400
Received: from mx.sdf.org ([205.166.94.20]:50006 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgC1Qnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:33 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhGdv020471
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:16 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhF9R022227;
        Sat, 28 Mar 2020 16:43:15 GMT
Message-Id: <202003281643.02SGhF9R022227@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 3 Oct 2019 07:10:40 -0400
Subject: [RFC PATCH v1 23/50] prandom_seed_state(): Change to 32-bit seed
 type.
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It only uses 32 bits of the seed anyway, and the vast majority
of callers pass in 32-bit values.  The only exceptions are:
* Several self-tests used a fixed seed of 3141592653589793238ULL.
  Changed to 3141592653.
* arch/x86/mm/kaslr.c uses a seed from kaslr_get_random_long().
  It's already well-mixed, so truncating it is no worse than
  the previous xor-folding.

(We could use the folded equivalent 32-bit seed for the self-tests,
but we just changed the PRNG algorithm, so the self-tests will
change across these commits anyway.)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
---
 include/linux/random.h   | 9 +++------
 lib/interval_tree_test.c | 2 +-
 lib/rbtree_test.c        | 2 +-
 lib/test_bpf.c           | 2 +-
 lib/test_parman.c        | 2 +-
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 4a325f5cf298f..7956063253261 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -210,14 +210,11 @@ void prandom_seed_early(struct rnd_state *state, u32 seed, bool);
 /**
  * prandom_seed_state - set seed for prandom_u32_state().
  * @state: pointer to state structure to receive the seed.
- * @seed: arbitrary 64-bit value to use as a seed.
- *        (only 32 bits are actually used)
+ * @seed: arbitrary 32-bit value to use as a seed.
  */
-static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
+static inline void prandom_seed_state(struct rnd_state *state, u32 seed)
 {
-	u32 i = (seed >> 32) ^ (seed << 10) ^ seed;
-
-	prandom_seed_early(state, i, false);
+	prandom_seed_early(state, seed, false);
 }
 
 #ifdef CONFIG_ARCH_RANDOM
diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index 8c129c8c638b9..149bca1edbf0d 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -79,7 +79,7 @@ static int interval_tree_test_init(void)
 
 	printk(KERN_ALERT "interval tree insert/remove");
 
-	prandom_seed_state(&rnd, 3141592653589793238ULL);
+	prandom_seed_state(&rnd, 3141592653);
 	init();
 
 	time1 = get_cycles();
diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 41ae3c7570d39..129b653e6d702 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -251,7 +251,7 @@ static int __init rbtree_test_init(void)
 
 	printk(KERN_ALERT "rbtree testing");
 
-	prandom_seed_state(&rnd, 3141592653589793238ULL);
+	prandom_seed_state(&rnd, 3141592653);
 	init();
 
 	time1 = get_cycles();
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index cecb230833bed..76697e24ee206 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -134,7 +134,7 @@ static int bpf_fill_maxinsns3(struct bpf_test *self)
 	if (!insn)
 		return -ENOMEM;
 
-	prandom_seed_state(&rnd, 3141592653589793238ULL);
+	prandom_seed_state(&rnd, 3141592653);
 
 	for (i = 0; i < len - 1; i++) {
 		__u32 k = prandom_u32_state(&rnd);
diff --git a/lib/test_parman.c b/lib/test_parman.c
index 35e32243693c9..9db1fe1b45083 100644
--- a/lib/test_parman.c
+++ b/lib/test_parman.c
@@ -131,7 +131,7 @@ static const struct parman_ops test_parman_lsort_ops = {
 
 static void test_parman_rnd_init(struct test_parman *test_parman)
 {
-	prandom_seed_state(&test_parman->rnd, 3141592653589793238ULL);
+	prandom_seed_state(&test_parman->rnd, 3141592653);
 }
 
 static u32 test_parman_rnd_get(struct test_parman *test_parman)
-- 
2.26.0

