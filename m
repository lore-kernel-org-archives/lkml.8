Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338F520888
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgHBLPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:15:46 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37088 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728211AbgHBLPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:15:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0U4T30D9_1596366934;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4T30D9_1596366934)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:34 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        tvrtko.ursulin@intel.com, mika.kuoppala@linux.intel.com,
        andi.shyti@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
Subject: [PATCH] drm/i915: Fix wrong return value
Date:   Sun,  2 Aug 2020 19:15:34 +0800
Message-Id: <20200802111534.5155-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function i915_active_acquire_preallocate_barrier(), not all
paths have the return value set correctly, and in case of memory
allocation failure, a negative error code should be returned.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/gpu/drm/i915/i915_active.c            | 4 ++--
 drivers/gpu/drm/i915/selftests/i915_request.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index d960d0be5bd2..cc017e3cc9c5 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -758,7 +758,7 @@ int i915_active_acquire_preallocate_barrier(struct i915_active *ref,
 	intel_engine_mask_t tmp, mask = engine->mask;
 	struct llist_node *first = NULL, *last = NULL;
 	struct intel_gt *gt = engine->gt;
-	int err;
+	int err = 0;
 
 	GEM_BUG_ON(i915_active_is_idle(ref));
 
@@ -782,7 +782,7 @@ int i915_active_acquire_preallocate_barrier(struct i915_active *ref,
 		if (!node) {
 			node = kmem_cache_alloc(global.slab_cache, GFP_KERNEL);
 			if (!node) {
-				err = ENOMEM;
+				err = -ENOMEM;
 				goto unwind;
 			}
 
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index 6014e8dfcbb1..dda801a87b8a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -326,7 +326,7 @@ static int __igt_breadcrumbs_smoketest(void *arg)
 		if (!wait) {
 			i915_sw_fence_commit(submit);
 			heap_fence_put(submit);
-			err = ENOMEM;
+			err = -ENOMEM;
 			break;
 		}
 
-- 
2.26.2

