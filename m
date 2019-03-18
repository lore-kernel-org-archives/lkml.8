Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3241DC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE1C2073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgC1Qnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:51 -0400
Received: from mx.sdf.org ([205.166.94.20]:50019 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbgC1Qnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:32 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhEg3025206
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:14 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhES8009024;
        Sat, 28 Mar 2020 16:43:14 GMT
Message-Id: <202003281643.02SGhES8009024@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Mon, 18 Mar 2019 14:56:15 -0400
Subject: [RFC PATCH v1 20/50] lib/random32: Move prandom_warmup() inside
 prandom_seed_early()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They're always called as a pair, so shrink the code.

Also, unrolling prandom_warmup() is just a waste of code space.
Write it as a loop.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
---
 lib/random32.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/lib/random32.c b/lib/random32.c
index fc369f4e550c2..340696decc3bb 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -138,17 +138,10 @@ EXPORT_SYMBOL(prandom_bytes);
 
 static void prandom_warmup(struct rnd_state *state)
 {
+	int i;
 	/* Calling RNG ten times to satisfy recurrence condition */
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
+	for (i = 0; i < 10; i++)
+		prandom_u32_state(state);
 }
 
 static u32 __extract_hwseed(void)
@@ -170,6 +163,7 @@ static void prandom_seed_early(struct rnd_state *state, u32 seed,
 	state->s2 = __seed(HWSEED() ^ LCG(state->s1),   8U);
 	state->s3 = __seed(HWSEED() ^ LCG(state->s2),  16U);
 	state->s4 = __seed(HWSEED() ^ LCG(state->s3), 128U);
+	prandom_warmup(state);
 }
 
 /**
@@ -209,7 +203,6 @@ static int __init prandom_init(void)
 		u32 weak_seed = (i + jiffies) ^ random_get_entropy();
 
 		prandom_seed_early(state, weak_seed, true);
-		prandom_warmup(state);
 	}
 
 	return 0;
@@ -433,7 +426,6 @@ static void __init prandom_state_selftest(void)
 		struct rnd_state state;
 
 		prandom_seed_early(&state, test1[i].seed, false);
-		prandom_warmup(&state);
 
 		if (test1[i].result != prandom_u32_state(&state))
 			error = true;
@@ -448,7 +440,6 @@ static void __init prandom_state_selftest(void)
 		struct rnd_state state;
 
 		prandom_seed_early(&state, test2[i].seed, false);
-		prandom_warmup(&state);
 
 		for (j = 0; j < test2[i].iteration - 1; j++)
 			prandom_u32_state(&state);
-- 
2.26.0

