Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE81BC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B5C206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgC1QnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:12 -0400
Received: from mx.sdf.org ([205.166.94.20]:50295 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgC1QnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:12 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhBkr028015
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:11 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhBxX000080;
        Sat, 28 Mar 2020 16:43:11 GMT
Message-Id: <202003281643.02SGhBxX000080@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Mon, 18 Mar 2019 02:46:05 -0400
Subject: [RFC PATCH v1 12/50] Treewide: Extirpate prandom_u32_state(rnd) %
 range
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Chris Wilson <chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no prandom_u32_state_max, so we're using reciprocal_scale()
here directly.

(Also add a missing "const" to drivers/gpu/drm/i915/selftests/scatterist.c)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
---
 drivers/gpu/drm/i915/selftests/scatterlist.c | 4 ++--
 lib/interval_tree_test.c                     | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index d599186d5b714..be9ff9d03eada 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -195,13 +195,13 @@ static unsigned int random_page_size_pages(unsigned long n,
 					   struct rnd_state *rnd)
 {
 	/* 4K, 64K, 2M */
-	static unsigned int page_count[] = {
+	static const unsigned int page_count[] = {
 		BIT(12) >> PAGE_SHIFT,
 		BIT(16) >> PAGE_SHIFT,
 		BIT(21) >> PAGE_SHIFT,
 	};
 
-	return page_count[(prandom_u32_state(rnd) % 3)];
+	return page_count[reciprocal_scale(prandom_u32_state(rnd), 3)];
 }
 
 static inline bool page_contiguous(struct page *first,
diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index f37f4d44faa90..8c129c8c638b9 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -43,8 +43,8 @@ static void init(void)
 	int i;
 
 	for (i = 0; i < nnodes; i++) {
-		u32 b = (prandom_u32_state(&rnd) >> 4) % max_endpoint;
-		u32 a = (prandom_u32_state(&rnd) >> 4) % b;
+		u32 b = reciprocal_scale(prandom_u32_state(&rnd), max_endpoint);
+		u32 a = reciprocal_scale(prandom_u32_state(&rnd), b);
 
 		nodes[i].start = a;
 		nodes[i].last = b;
@@ -56,7 +56,8 @@ static void init(void)
 	 * which is pointless.
 	 */
 	for (i = 0; i < nsearches; i++)
-		queries[i] = (prandom_u32_state(&rnd) >> 4) % max_endpoint;
+		queries[i] = reciprocal_scale(prandom_u32_state(&rnd),
+					      max_endpoint);
 }
 
 static int interval_tree_test_init(void)
-- 
2.26.0

