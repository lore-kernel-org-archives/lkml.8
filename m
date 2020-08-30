Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98428C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642E82083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4m50/xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgH3VJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3VJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:09:56 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47098C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:09:56 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id k13so652806oor.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oObpY48XdTvUxTDfJa2g2q0M3QkpTwHKIJDdTDdY8Dc=;
        b=i4m50/xw542tFUgH/mrLiPw3QaF7oJPHvcvyrQNdsD5PuIsn7W3hy9gvCOKFahZdG4
         x5wlT7nWsbtH0ybkl7rrV0P/j7CTpOv6XGZxnfKp7bIPvrdVPi5Kz6DUkWYiIyx6dm/9
         d6Bh1gdyGS+EtQl9F8IQcVaysU0gPaoNSzvW86KV3kxakcIB7/9zL38vCYITyJUr1nZt
         GzugCy2VRn7kA9ZpU/B/0BJ34vqlU8TURYZUieladRuszVW7ekPnkeSBcQO9DyHnNF0y
         K3Cqt7A7xgxdhqMkLo+CkA7qs8Nti70TWjutypOfPxq2Xfeq6UE/upeJjfXLJdwLgXAM
         NQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oObpY48XdTvUxTDfJa2g2q0M3QkpTwHKIJDdTDdY8Dc=;
        b=oFQVr/2UOP0VXM2gReMTXcuQU5FQ20jvyQ1JJ1Gl1g0eau5kxzVKSkNlb7jfHN74PJ
         S/3y6H+NB8OZuPSsEYd1x4woCLFHNnm1egRx+HLQS/eRphHl0jkRgGhrOzKWBE3FXhU/
         ZNNfDsfLuevNffXoDksL84Kx6/sXnirEruWqrHkuGz9pDgK2dVtXnRi8KB8b02usekk8
         vTBRlu3ck7A/CnRfy+BhjE1EQW1+Dn7xZxzCdlmzDtu8rP8vhRFZT/yqPSWNp2Dgmkn8
         T9jty8Keo6cFrWCWEEWL/YrIKCYc1v+KtnbXyjNSOZ6/2F9+N1I10RihPQ584TwgcYVI
         IsAw==
X-Gm-Message-State: AOAM5317Ylz0UNaD+GDXmNUZULMlnBk4/w4H4DKZSGV6JGVy8AgbOhFr
        P4gnK5yr9uYDzHLjcARx6WMijw==
X-Google-Smtp-Source: ABdhPJwMB1Gz3yryOwBzNp2wDtYJ5LUzxLS3b/PHz2HcPX4AOSw58hhGqnGTSjHBrof7blTxs0ABYg==
X-Received: by 2002:a4a:bb05:: with SMTP id f5mr3475000oop.5.1598821795429;
        Sun, 30 Aug 2020 14:09:55 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g4sm1363777otq.33.2020.08.30.14.09.53
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 14:09:54 -0700 (PDT)
Date:   Sun, 30 Aug 2020 14:09:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 5/5] mlock: fix unevictable_pgs event counts on THP
In-Reply-To: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008301408230.5954@eggly.anvils>
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.8 commit 5d91f31faf8e ("mm: swap: fix vmstats for huge page") has
established that vm_events should count every subpage of a THP,
including unevictable_pgs_culled and unevictable_pgs_rescued; but
lru_cache_add_inactive_or_unevictable() was not doing so for
unevictable_pgs_mlocked, and mm/mlock.c was not doing so for
unevictable_pgs mlocked, munlocked, cleared and stranded.

Fix them; but THPs don't go the pagevec way in mlock.c,
so no fixes needed on that path.

Fixes: 5d91f31faf8e ("mm: swap: fix vmstats for huge page")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
I've only checked UNEVICTABLEs: there may be more inconsistencies left.
The check_move_unevictable_pages() patch brought me to this one, but
this is more important because mlock works on all THPs, without needing
special testing "force".  But, it's still just monotonically increasing
event counts, so not all that important.

 mm/mlock.c |   24 +++++++++++++++---------
 mm/swap.c  |    6 +++---
 2 files changed, 18 insertions(+), 12 deletions(-)

--- 5.9-rc2/mm/mlock.c	2020-08-16 17:32:50.665507048 -0700
+++ linux/mm/mlock.c	2020-08-28 17:42:07.975278411 -0700
@@ -58,11 +58,14 @@ EXPORT_SYMBOL(can_do_mlock);
  */
 void clear_page_mlock(struct page *page)
 {
+	int nr_pages;
+
 	if (!TestClearPageMlocked(page))
 		return;
 
-	mod_zone_page_state(page_zone(page), NR_MLOCK, -thp_nr_pages(page));
-	count_vm_event(UNEVICTABLE_PGCLEARED);
+	nr_pages = thp_nr_pages(page);
+	mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+	count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
 	/*
 	 * The previous TestClearPageMlocked() corresponds to the smp_mb()
 	 * in __pagevec_lru_add_fn().
@@ -76,7 +79,7 @@ void clear_page_mlock(struct page *page)
 		 * We lost the race. the page already moved to evictable list.
 		 */
 		if (PageUnevictable(page))
-			count_vm_event(UNEVICTABLE_PGSTRANDED);
+			count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
 	}
 }
 
@@ -93,9 +96,10 @@ void mlock_vma_page(struct page *page)
 	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
 
 	if (!TestSetPageMlocked(page)) {
-		mod_zone_page_state(page_zone(page), NR_MLOCK,
-				    thp_nr_pages(page));
-		count_vm_event(UNEVICTABLE_PGMLOCKED);
+		int nr_pages = thp_nr_pages(page);
+
+		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
+		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 		if (!isolate_lru_page(page))
 			putback_lru_page(page);
 	}
@@ -138,7 +142,7 @@ static void __munlock_isolated_page(stru
 
 	/* Did try_to_unlock() succeed or punt? */
 	if (!PageMlocked(page))
-		count_vm_event(UNEVICTABLE_PGMUNLOCKED);
+		count_vm_events(UNEVICTABLE_PGMUNLOCKED, thp_nr_pages(page));
 
 	putback_lru_page(page);
 }
@@ -154,10 +158,12 @@ static void __munlock_isolated_page(stru
  */
 static void __munlock_isolation_failed(struct page *page)
 {
+	int nr_pages = thp_nr_pages(page);
+
 	if (PageUnevictable(page))
-		__count_vm_event(UNEVICTABLE_PGSTRANDED);
+		__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
 	else
-		__count_vm_event(UNEVICTABLE_PGMUNLOCKED);
+		__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 }
 
 /**
--- 5.9-rc2/mm/swap.c	2020-08-16 17:32:50.709507284 -0700
+++ linux/mm/swap.c	2020-08-28 17:42:07.975278411 -0700
@@ -494,14 +494,14 @@ void lru_cache_add_inactive_or_unevictab
 
 	unevictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED;
 	if (unlikely(unevictable) && !TestSetPageMlocked(page)) {
+		int nr_pages = thp_nr_pages(page);
 		/*
 		 * We use the irq-unsafe __mod_zone_page_stat because this
 		 * counter is not modified from interrupt context, and the pte
 		 * lock is held(spinlock), which implies preemption disabled.
 		 */
-		__mod_zone_page_state(page_zone(page), NR_MLOCK,
-				    thp_nr_pages(page));
-		count_vm_event(UNEVICTABLE_PGMLOCKED);
+		__mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
+		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 	}
 	lru_cache_add(page);
 }
