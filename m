Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071E5C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4EE22D04
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgHUIud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:50:33 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:55731 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727868AbgHUIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:50:28 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 22195098-1500050 
        for multiple; Fri, 21 Aug 2020 09:50:15 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
Subject: [PATCH 2/4] drm/i915/gem: Sync the vmap PTEs upon construction
Date:   Fri, 21 Aug 2020 09:50:09 +0100
Message-Id: <20200821085011.28878-2-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821085011.28878-1-chris@chris-wilson.co.uk>
References: <20200821085011.28878-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since synchronising the PTE after assignment is a manual step, use the
newly exported interface to flush the PTE after assigning via
alloc_vm_area().

Reported-by: Pavel Machek <pavel@ucw.cz>
References: 2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: <stable@vger.kernel.org> # v5.8+
---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 7050519c87a4..0fee67f34d74 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -304,6 +304,7 @@ static void *i915_gem_object_map(struct drm_i915_gem_object *obj,
 		for_each_sgt_daddr(addr, iter, sgt)
 			**ptes++ = iomap_pte(iomap, addr, pgprot);
 	}
+	flush_vm_area(area);
 
 	if (mem != stack)
 		kvfree(mem);
-- 
2.20.1

