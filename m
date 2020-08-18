Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF42C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F222320772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIx7kMWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHRSrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgHRSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:47:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8479FC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:47:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u189so23077270ybg.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bfVQLroskM5Wc4DhZMIyj9jgHc+j8RHZ/garHr4Fpmo=;
        b=CIx7kMWbB8VmYnYBEoD4nNQsaSQZt1zzWgyHBo9TmOh+81P13Aq4a+yETjPZEdKzHt
         6xhM+il6SYmrYbNG1IV7d069OMSWVqj57ViYi+dViNBbqPDo4foz1/sXg+neeEwOnROJ
         b3vK60iuFFWLcpf66/+S0SZnj2eh8Khpc1C4Awp23aYoNw3Hn2ktDyYyIqmyY/lLuNWy
         0KsGsEIVRDT/ZcJr7rljERS6QGsxhldWu58VpPBprIVTjCTNGFYgQ/jP9PX7jqtcNwYD
         yHdVBEoP2GYwds522u6f/lZ7QVEz357iUqWtZYvud/ZMRq5iE6U6JD54o1RFc5iL68P9
         PFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bfVQLroskM5Wc4DhZMIyj9jgHc+j8RHZ/garHr4Fpmo=;
        b=iY01raQyfOyZWtXtW7mLPCUfGvIk30Q8ZHmkVY7v8Hdhg5rEKetly4h5A8N43B39cY
         2h6yOf55FlrB2/VB6DLJcsnH/+awFeZRau0P6HYvEMOFj8zYIvtwJ6Nb9ygj/iLGavvM
         Nzv1cUp7SNBXxSsmlwBEgrRBGH9EvCR4wZBBq30uAeQXjo631MwMwfH44jelm/H/sJCs
         grIt7BWwrKYlSNdX1dPd6G5jPbU6buVDTPJR/W04EBqIJfOFwvckCm81crBWHjYCaaZH
         1eptPL9LUNzMHuWW0TKaqkfO5JZXkYr5M1mmCUH44vQDXe0OdCRnqIR/b0jExMW1i9mn
         f2uw==
X-Gm-Message-State: AOAM533UvWAmdLVzZPcw3IF2MezJO0sUQI3ThjIDfkKqCHXCwktMUO0d
        DpXo68L6uykMogK0prr9Q9Tf10fx9pM=
X-Google-Smtp-Source: ABdhPJxZwwFPlarZ3LoosIXt55p8uBBCrvGv9J5VLrCxYXf9wPeT384wi+a1vkBEDJm/7ct0Z09BbNo6pl0=
X-Received: by 2002:a25:a091:: with SMTP id y17mr28606051ybh.82.1597776434643;
 Tue, 18 Aug 2020 11:47:14 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:47:04 -0600
In-Reply-To: <20200818184704.3625199-1-yuzhao@google.com>
Message-Id: <20200818184704.3625199-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20200818184704.3625199-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 3/3] mm: remove superfluous __ClearPageWaiters()
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
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yu Zhao <yuzhao@google.com>
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
index 1aaea26556cc..75240c7ef73f 100644
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
index 999a84dbe12c..40bf20a75278 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -90,7 +90,6 @@ static void __page_cache_release(struct page *page)
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
-	__ClearPageWaiters(page);
 }
 
 static void __put_single_page(struct page *page)
@@ -900,8 +899,6 @@ void release_pages(struct page **pages, int nr)
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
-		__ClearPageWaiters(page);
-
 		list_add(&page->lru, &pages_to_free);
 	}
 	if (locked_pgdat)
-- 
2.28.0.220.ged08abb693-goog

