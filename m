Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7860DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D9220768
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQ79oX9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHLEGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgHLEGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:06:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA84C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:06:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l13so1448929ybf.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=iTZlcV/HDVMBUj3vIm/BeqimkSAgE6ss1JTWwnLuV7w=;
        b=PQ79oX9ptj1DcJboGkk/u9/eQM7QFOR6pkv9sTiA01Hwr5+qHsW4r3uy0R08hjkTKp
         /CGVUpYvsZpiJSP2BZd8pHrisgM8KQ/93wShpsQgZewNcxXZtwvTJy3EZbNkz8elsegd
         NrNHbhn5UVyj8Ud8kqsD+vrD4izt8H0g0wlNhXYkSPW8zXa+KuWeLMUpzZM+0UKzVpqh
         MLwOcLIFz/2gLQcW1Eq51kH5i8/duG99bp7CxDzAxr3VucjSC6RJ65ntwLr7r2S/87wm
         dLFTWtK0LNRLAYYEzUx75mVivIuScTZ7ZR55V1k1A/+PdAjWzSy97ogq+Qz9S1n1k4KA
         tA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=iTZlcV/HDVMBUj3vIm/BeqimkSAgE6ss1JTWwnLuV7w=;
        b=dWHJVTGUR9iptwKCyaLlk5eCAtefdRjkCCQR/wyxB4NLuXVFtaUvYv6n6hE3mQPcpL
         nPWvBJsGkYW3EfO3AyRzL3vvyzFAWLc938VSstHu0y/D5pjqrtagpYhy9PtP2qVmDI9r
         UeP8449+HtmKYndvQOExpVxmeDhiBjnFEELNjcGsXyRuvch1/a13EbVfDxwzSN4d+rJo
         qpLAu275N4it1CvH/9M+F4zPR3MgavyLvSZlAkHZW+0ta5aE2fNfkEWB/K8oYCWMMM9U
         WBujmOtst+yqFoAVvH1N3PVizLjHYpyxpG6WO4+l4jHC3c0YDWRWyvHGkIGVQBXZvP8h
         xFRQ==
X-Gm-Message-State: AOAM5302lZctDa40UXKgvHLoHJsMs1OEWShyVHMSy1C7O0q2TCh9V9jH
        00S/JoHtHD4R9qE56nZ0OEyLlHNaUhU=
X-Google-Smtp-Source: ABdhPJzfk920y7QXdilL0gnKVShIBZWvJH75i46mC6Pu2Hx2kdFQ86wy4FJrpeAKB11/nSfL2M/Q++UqnJY=
X-Received: by 2002:a25:bdc4:: with SMTP id g4mr52297610ybk.187.1597205166994;
 Tue, 11 Aug 2020 21:06:06 -0700 (PDT)
Reply-To: <20200812040454.2708263-1-yuzhao@google.com>
Date:   Tue, 11 Aug 2020 22:05:50 -0600
Message-Id: <20200812040550.2708444-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH 2/3] mm: remove superfluous __ClearPageActive()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To activate a page, mark_page_accessed() always holds a reference
on it. It either gets a new reference when adding a page to
lru_pvecs.activate_page or reuses an existing one it previously
got when it added a page to lru_pvecs.lru_add. So it can't call
SetPageActive() on a page that doesn't have any reference left.
Therefore, the race is impossible, not these days (I didn't brother
to dig into its history).

For other paths, namely reclaim and migration, a reference count is
always held while calling SetPageActive() on a page.

SetPageSlabPfmemalloc() also uses SetPageActive(), but it's irrelevant
to LRU pages.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/memremap.c | 2 --
 mm/swap.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 03e38b7a38f1..3a06eb91cb59 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -451,8 +451,6 @@ void free_devmap_managed_page(struct page *page)
 		return;
 	}
 
-	/* Clear Active bit in case of parallel mark_page_accessed */
-	__ClearPageActive(page);
 	__ClearPageWaiters(page);
 
 	mem_cgroup_uncharge(page);
diff --git a/mm/swap.c b/mm/swap.c
index de257c0a89b1..1f223a02549d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -898,8 +898,6 @@ void release_pages(struct page **pages, int nr)
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
-		/* Clear Active bit in case of parallel mark_page_accessed */
-		__ClearPageActive(page);
 		__ClearPageWaiters(page);
 
 		list_add(&page->lru, &pages_to_free);
-- 
2.28.0.236.gb10cc79966-goog

