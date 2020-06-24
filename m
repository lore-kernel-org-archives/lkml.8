Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DFFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FE1212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbgFXID1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:03:27 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62453 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387606AbgFXID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:03:27 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 21599206-1500050 
        for multiple; Wed, 24 Jun 2020 09:03:20 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 2/2] drm/i915/gem: Use mmu_notifier_range_mayfail() to avoid waiting inside reclaim
Date:   Wed, 24 Jun 2020 09:02:48 +0100
Message-Id: <20200624080248.3701-2-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624080248.3701-1-chris@chris-wilson.co.uk>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The direct reclaim path may trigger the mmu_notifier callback as part of
try_to_unmap_one. As this is purely an opportunitistic attempt to
reclaim pages, and will be called from any allocation context under
unknown conditions (that include attempting to allocate pages for the
userptr object itself and subsequently trying to reclaim parts of the
partially acquired object) we have to be careful never to wait on
anything being held by the calling context. Since that is unknown, we
have to avoid waiting from inside direct reclaim.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 9c53eb883400..72cfb91230ea 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -103,6 +103,7 @@ userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 	it = interval_tree_iter_first(&mn->objects, range->start, end);
 	while (it) {
 		struct drm_i915_gem_object *obj;
+		unsigned int flags;
 
 		if (!mmu_notifier_range_blockable(range)) {
 			ret = -EAGAIN;
@@ -126,9 +127,12 @@ userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 		}
 		spin_unlock(&mn->lock);
 
-		ret = i915_gem_object_unbind(obj,
-					     I915_GEM_OBJECT_UNBIND_ACTIVE |
-					     I915_GEM_OBJECT_UNBIND_BARRIER);
+		flags = (I915_GEM_OBJECT_UNBIND_ACTIVE |
+			 I915_GEM_OBJECT_UNBIND_BARRIER);
+		if (mmu_notifier_range_mayfail(range))
+			flags = 0;
+
+		ret = i915_gem_object_unbind(obj, flags);
 		if (ret == 0)
 			ret = __i915_gem_object_put_pages(obj);
 		i915_gem_object_put(obj);
-- 
2.20.1

