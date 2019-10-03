Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3200C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8761B206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgC1QqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:46:13 -0400
Received: from mx.sdf.org ([205.166.94.20]:50106 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbgC1QnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:25 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhKv0008118
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:20 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhKpM009093;
        Sat, 28 Mar 2020 16:43:20 GMT
Message-Id: <202003281643.02SGhKpM009093@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 3 Oct 2019 04:55:27 -0400
Subject: [RFC PATCH v1 34/50] mm/slub.c: Use cheaper prandom source in
 shuffle_freelist
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Thomas Garnier <thgarnie@chromium.org>,
        Yu Zhao <yuzhao@google.com>, Sean Rees <sean@erifax.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pre-generated permutation which we're choosing a random starting
offset into was itself generated with prandom (in freelist_randomize()),
so there's not much point using a crypto-quality generator here.

Also, prandom_u32_max() uses a multiplicative algorithm for generating
random integers in a range, which is faster than modulo.

TODO: Figure out a better algorithm for the whole thing.  A single
permutation with a random starting point is a bit limiting.
Can we make a full shuffle fast enough. or do we need to stick
with something less general?

We could easily add an outer offset: off2 + random_seq[off1 + i]

Perhaps instead of just a random starting point, a random start
and step?  Unfortunately, the step must be relatively prime to the
count, and the latter is not chosen to make things convenient.
But it's easy enough to precompute a list of possible steps.
Or we could at least allow steps of +1 and -1.

Should random_seq be changed periodically?  It's a separately
allocated structure, so it's easy to allocate a new one and swap
it out atomically.

or even an Enigma-style double rotor:
page[i] = off3 + random_seq2[off2 + random_seq1[off1 + i]]

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Sean Rees <sean@erifax.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8eafccf759409..94d765666cff0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1580,7 +1580,7 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
 		return false;
 
 	freelist_count = oo_objects(s->oo);
-	pos = get_random_int() % freelist_count;
+	pos = prandom_u32_max(freelist_count);
 
 	page_limit = page->objects * s->size;
 	start = fixup_red_left(s, page_address(page));
-- 
2.26.0

