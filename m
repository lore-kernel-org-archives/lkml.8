Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C821EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78A32082D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgC1Qnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:40 -0400
Received: from mx.sdf.org ([205.166.94.20]:50178 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbgC1QnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:21 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGh88D023629
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:09 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGh8wx015662;
        Sat, 28 Mar 2020 16:43:08 GMT
Message-Id: <202003281643.02SGh8wx015662@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Mon, 18 Mar 2019 07:07:44 -0400
Subject: [RFC PATCH v1 07/50] mm/slab: Use simpler Fisher-Yates shuffle
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Thomas Garnier <thgarnie@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to using reciprocal_scale rather than %, use
the initialize-while-shuffling form of Fisher-Yates.

Rather than swapping list[i] and list[rand] immediately after
initializing list[i] = i, copy list[i] = list[rand] and then
initialize list[rand] = i.

Note that 0 <= rand <= i, so if rand == i, the first step copies
uninitialized memory to itself before the second step initializes it.

This whole pre-computed shuffle list algorithm really needs a more
extensive overhaul.  It's basically a very-special-purpose PRNG
created to amortize the overhead of get_random_int().  But there
are more efficient ways to use the 32 random bits that returns
than just choosing a random starting point modulo cachep->num.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/slab.c        | 25 +++++++++----------------
 mm/slab_common.c | 15 +++++++--------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index a89633603b2d7..d9499d54afa59 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2404,7 +2404,7 @@ static bool freelist_state_initialize(union freelist_init_state *state,
 	} else {
 		state->list = cachep->random_seq;
 		state->count = count;
-		state->pos = rand % count;
+		state->pos = reciprocal_scale(rand, count);
 		ret = true;
 	}
 	return ret;
@@ -2418,20 +2418,13 @@ static freelist_idx_t next_random_slot(union freelist_init_state *state)
 	return state->list[state->pos++];
 }
 
-/* Swap two freelist entries */
-static void swap_free_obj(struct page *page, unsigned int a, unsigned int b)
-{
-	swap(((freelist_idx_t *)page->freelist)[a],
-		((freelist_idx_t *)page->freelist)[b]);
-}
-
 /*
  * Shuffle the freelist initialization state based on pre-computed lists.
  * return true if the list was successfully shuffled, false otherwise.
  */
 static bool shuffle_freelist(struct kmem_cache *cachep, struct page *page)
 {
-	unsigned int objfreelist = 0, i, rand, count = cachep->num;
+	unsigned int objfreelist = 0, i, count = cachep->num;
 	union freelist_init_state state;
 	bool precomputed;
 
@@ -2456,14 +2449,14 @@ static bool shuffle_freelist(struct kmem_cache *cachep, struct page *page)
 	 * Later use a pre-computed list for speed.
 	 */
 	if (!precomputed) {
-		for (i = 0; i < count; i++)
-			set_free_obj(page, i, i);
-
 		/* Fisher-Yates shuffle */
-		for (i = count - 1; i > 0; i--) {
-			rand = prandom_u32_state(&state.rnd_state);
-			rand %= (i + 1);
-			swap_free_obj(page, i, rand);
+		set_free_obj(page, 0, 0);
+		for (i = 1; i < count; i++) {
+			unsigned int rand = prandom_u32_state(&state.rnd_state);
+
+			rand = reciprocal_scale(rand, i + 1);
+			set_free_obj(page, i, get_free_obj(page, rand));
+			set_free_obj(page, rand, i);
 		}
 	} else {
 		for (i = 0; i < count; i++)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0d95ddea13b0d..67908fc842d98 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1349,17 +1349,16 @@ EXPORT_SYMBOL(kmalloc_order_trace);
 static void freelist_randomize(struct rnd_state *state, unsigned int *list,
 			       unsigned int count)
 {
-	unsigned int rand;
 	unsigned int i;
 
-	for (i = 0; i < count; i++)
-		list[i] = i;
-
 	/* Fisher-Yates shuffle */
-	for (i = count - 1; i > 0; i--) {
-		rand = prandom_u32_state(state);
-		rand %= (i + 1);
-		swap(list[i], list[rand]);
+	list[0] = 0;
+	for (i = 1; i < count; i++) {
+		unsigned int rand = prandom_u32_state(state);
+
+		rand = reciprocal_scale(rand, i + 1);
+		list[i] = list[rand];
+		list[rand] = i;
 	}
 }
 
-- 
2.26.0

