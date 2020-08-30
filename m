Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AF6C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCF02083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLgm8Hki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgH3VE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3VE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:04:57 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:04:56 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 185so2533481oie.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=coS1VgOeVvuW3zilDte6RopNvB+JCPXBV06ZRlXDP00=;
        b=mLgm8HkihKv7FyGuefBErbKi1q1X3jgYF1hFyRbkUtb+OlouRU6smur6+yj1xhcX5o
         mudVlzmxyk3BIsBQ+jxr0UGffsZM9yHUxOWGMJy6iP4fPeUNHnCpypxiDiDSe26OP8CP
         WaD1ejKPn5MwG679WL8r5CkBr4ucRNV4Fki7DfaAZdyGCroDviXtVHCUmZWgTa0ggtUP
         ifGpay17H5XsEl31i4ALDPfoMpW26ISN3x0V7bMmMeOak1enznroTYmgomSaLQ/7zVcH
         voFY5z0lGiViIVUs/JP2LEhQwAzltEAb9mLieOjaBjUcg+uiL5oPQeDt9Li8eYlhKfYv
         2cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=coS1VgOeVvuW3zilDte6RopNvB+JCPXBV06ZRlXDP00=;
        b=bqe0IrhF9KpId5pmPq91cVA9u3bM2QgPQYss3/aA9qqoHU/mi6aI/ibh0s+8HRtOcD
         nwyeCNX9pceC8ENFuJg+u9pEu9pRl45K+6FFbJNG4CVrw74GdtyarVFmNRupFndT/H/X
         zNWWMQ7gZPVIbYelBDTBSWEXkJ1Uy/aoNaPOGQFmJlrNwvu9XS9KuVVikndCw8jSAbn8
         jY9cXCRGjgmCLwMc4RL/xAznNVfzwKRWKSJrNSOgEilEWdZznl/wJ/CbtTBWXZCuA7UM
         GG3HJ1bHXALJiY6h8dQF1p/ab5tGKJfjTwrBsI3nhv4qqH8xC8fHBpvq5gpNEhD4lXz0
         PNFg==
X-Gm-Message-State: AOAM532vq68GQ5BaPAAINN28I4HjNKSlziNvP1YJtFivdcRZ+hsdV2L4
        O7VzXgVMaATlv6aK6aAUTDCSsA==
X-Google-Smtp-Source: ABdhPJyBDjSpD7vn8efGsx/WG5uLd+GklOI9Mc88ks1Nx40bsNuBq8J3UE90x7tcCu+8R+f7RbVQiQ==
X-Received: by 2002:a05:6808:b36:: with SMTP id t22mr1874161oij.159.1598821496074;
        Sun, 30 Aug 2020 14:04:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z10sm1362907otk.6.2020.08.30.14.04.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 14:04:55 -0700 (PDT)
Date:   Sun, 30 Aug 2020 14:04:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/5] shmem: shmem_writepage() split unlikely i915 THP
Message-ID: <alpine.LSU.2.11.2008301401390.5954@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/i915/gem/i915_gem_shmem.c contains a shmem_writeback()
which calls shmem_writepage() from a shrinker: that usually works well
enough; but if /sys/kernel/mm/transparent_hugepage/shmem_enabled has
been set to "force" (documented as "Force the huge option on for all -
very useful for testing"), shmem_writepage() is surprised to be called
with a huge page, and crashes on the VM_BUG_ON_PAGE(PageCompound) (I
did not find out where the crash happens when CONFIG_DEBUG_VM is off).

LRU page reclaim always splits the shmem huge page first: I'd prefer not
to demand that of i915, so check and split compound in shmem_writepage().

Fixes: 2d6692e642e7 ("drm/i915: Start writeback from the shrinker")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v5.3+
---
I've marked this for stable just for the info, but the number of users
affected is very probably 1, so please feel free to delete that marking.

 mm/shmem.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 5.9-rc2/mm/shmem.c	2020-08-16 17:32:50.693507198 -0700
+++ linux/mm/shmem.c	2020-08-28 17:35:08.326024349 -0700
@@ -1362,7 +1362,15 @@ static int shmem_writepage(struct page *
 	swp_entry_t swap;
 	pgoff_t index;
 
-	VM_BUG_ON_PAGE(PageCompound(page), page);
+	/*
+	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "force",
+	 * then drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
+	 * and its shmem_writeback() needs them to be split when swapping.
+	 */
+	if (PageTransCompound(page))
+		if (split_huge_page(page) < 0)
+			goto redirty;
+
 	BUG_ON(!PageLocked(page));
 	mapping = page->mapping;
 	index = page->index;
