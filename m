Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8714EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8FB208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgHUIu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:50:29 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:55722 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728182AbgHUIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:50:27 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 22195099-1500050 
        for multiple; Fri, 21 Aug 2020 09:50:15 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 3/4] drm/i915/gem: Use set_pte_at() for assigning the vmapped PTE
Date:   Fri, 21 Aug 2020 09:50:10 +0100
Message-Id: <20200821085011.28878-3-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821085011.28878-1-chris@chris-wilson.co.uk>
References: <20200821085011.28878-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use set_pte_at() to assign the PTE pointer returned by alloc_vm_area(),
rather than a direct assignment.

Fixes: 6056e50033d9 ("drm/i915/gem: Support discontiguous lmem object maps")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 0fee67f34d74..6838cf9bdae6 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -286,23 +286,34 @@ static void *i915_gem_object_map(struct drm_i915_gem_object *obj,
 	}
 
 	if (i915_gem_object_has_struct_page(obj)) {
+		unsigned long addr = (unsigned long)area->addr;
 		struct sgt_iter iter;
 		struct page *page;
 		pte_t **ptes = mem;
 
-		for_each_sgt_page(page, iter, sgt)
-			**ptes++ = mk_pte(page, pgprot);
+		for_each_sgt_page(page, iter, sgt) {
+			set_pte_at(&init_mm, addr, *ptes, mk_pte(page, pgprot));
+			addr += PAGE_SIZE;
+			ptes++;
+		}
+		GEM_BUG_ON(addr != (unsigned long)area->addr + obj->base.size);
 	} else {
+		unsigned long addr = (unsigned long)area->addr;
 		resource_size_t iomap;
 		struct sgt_iter iter;
 		pte_t **ptes = mem;
-		dma_addr_t addr;
+		dma_addr_t offset;
 
 		iomap = obj->mm.region->iomap.base;
 		iomap -= obj->mm.region->region.start;
 
-		for_each_sgt_daddr(addr, iter, sgt)
-			**ptes++ = iomap_pte(iomap, addr, pgprot);
+		for_each_sgt_daddr(offset, iter, sgt) {
+			set_pte_at(&init_mm, addr, *ptes,
+				   iomap_pte(iomap, offset, pgprot));
+			addr += PAGE_SIZE;
+			ptes++;
+		}
+		GEM_BUG_ON(addr != (unsigned long)area->addr + obj->base.size);
 	}
 	flush_vm_area(area);
 
-- 
2.20.1

