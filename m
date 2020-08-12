Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAE2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF69420678
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ux5Uu8bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHLEGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgHLEGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:06:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B1AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:06:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g127so1424510ybf.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=FIDHeBVsxOsjTSA4w3NTw9Tbo6FlzORttBwxcXHesPo=;
        b=ux5Uu8bQKrzTp3HdJ4kJsnBlROLefp/k9fpAqAOEUdQCbrkbaMwDrum/ZlZvBSAvI0
         3g1wg6FghbYkoDYlmie3Tr8cLXl1nBR20e2mXExEEErvtoLGTMTuApukeAjegxF/R9o5
         Z01vMuGk80s052RBzwQFTGqcOU3yogmOINf/19ezFHhUypIDKY+kDHzsd+gh0CGMV+Qk
         s5OgPUsfbMCq1LG1HE/j+UxYS1/F6pbtcTkgoT+mBFvUn85xmd27KWsMdSiMZh0cBVjX
         I/cpckvsX2JUf+KAT/xtyVk8afH10m2yi3pgn0Lzz7kFDQEAflnCV5f0cN4XjIScOU2r
         Y8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=FIDHeBVsxOsjTSA4w3NTw9Tbo6FlzORttBwxcXHesPo=;
        b=shZok/yRUsAGNT49bQYNHQFVBccUknN0NoRSsj3nY1SF4UluoKL6CkJ/2nCPpVxY63
         rNMk0tg+0eVBPpKDmrZwLHDVoFtRYTzJ0Il9ngSb/xRCBBU0raRnWxoC6Ax2adcs0gQr
         IZZOMuGID9wR5QUv0lyDUwNtT05BUzJJVAmeTe10ZMNOGkWtp8fxKsSFSYWArbZSqtV8
         PVIyf6Ri8qVWN8ZiHJMBm4yRmI/1Ol2Zseg5/1fgZUybEGJlWdCqd9L7N5yoa3Gnkghr
         wja/FJcJdr2aPEdMceXbvL0a5R+LCf+lhHTjnXfkyxH+kNdIrNpPnU+yy4hhyBJz1TDY
         2uSA==
X-Gm-Message-State: AOAM530gyUYwt0BxmPu0RmDnwA0p19R1tm0JimC0aDV5L0wPlOZTmwbo
        ec992MKDeMEGonpD0dwmuvmsG2aBINo=
X-Google-Smtp-Source: ABdhPJzUzwFvnMR3FToe6QoDQuvIwCq7pGDkgNw1NnVna6H//Q1976w39eSM3NOkYmiN1L3BjTLJrLyy8rI=
X-Received: by 2002:a5b:70d:: with SMTP id g13mr52265619ybq.160.1597205193285;
 Tue, 11 Aug 2020 21:06:33 -0700 (PDT)
Reply-To: <20200812040454.2708263-1-yuzhao@google.com>
Date:   Tue, 11 Aug 2020 22:06:30 -0600
Message-Id: <20200812040630.2710064-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH 3/3] mm: remove superfluous __ClearPageWaiters()
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

Presumably __ClearPageWaiters() was added to follow the previously
removed __ClearPageActive() pattern.

Only flags that are in PAGE_FLAGS_CHECK_AT_FREE needs to be properly
cleared because otherwise we think there may be some kind of leak.
PG_waiters is not one of those flags and leaving the clearing to
PAGE_FLAGS_CHECK_AT_PREP is more appropriate.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/page-flags.h | 2 +-
 mm/filemap.c               | 2 ++
 mm/memremap.c              | 2 --
 mm/swap.c                  | 3 ---
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 6be1aa559b1e..dba80a2bdfba 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -318,7 +318,7 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
 	TESTSETFLAG_FALSE(uname) TESTCLEARFLAG_FALSE(uname)
 
 __PAGEFLAG(Locked, locked, PF_NO_TAIL)
-PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
+PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
 PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
 PAGEFLAG(Referenced, referenced, PF_HEAD)
 	TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
diff --git a/mm/filemap.c b/mm/filemap.c
index f2bb5ff0293d..8a096844ddad 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1079,6 +1079,8 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 		 * other pages on it.
 		 *
 		 * That's okay, it's a rare case. The next waker will clear it.
+		 * Otherwise the bit will be cleared by PAGE_FLAGS_CHECK_AT_PREP
+		 * when the page is being freed.
 		 */
 	}
 	spin_unlock_irqrestore(&q->lock, flags);
diff --git a/mm/memremap.c b/mm/memremap.c
index 3a06eb91cb59..a9d02ffaf9e3 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -451,8 +451,6 @@ void free_devmap_managed_page(struct page *page)
 		return;
 	}
 
-	__ClearPageWaiters(page);
-
 	mem_cgroup_uncharge(page);
 
 	/*
diff --git a/mm/swap.c b/mm/swap.c
index 1f223a02549d..6129692752a5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -90,7 +90,6 @@ static void __page_cache_release(struct page *page)
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
-	__ClearPageWaiters(page);
 }
 
 static void __put_single_page(struct page *page)
@@ -898,8 +897,6 @@ void release_pages(struct page **pages, int nr)
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
-		__ClearPageWaiters(page);
-
 		list_add(&page->lru, &pages_to_free);
 	}
 	if (locked_pgdat)
-- 
2.28.0.236.gb10cc79966-goog

