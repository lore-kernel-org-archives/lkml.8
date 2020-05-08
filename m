Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F1BC47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1EC21974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="vQAFtSNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEHScj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgEHScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:32:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D4DC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:32:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so2613075qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJuCgdGkxri9O9i9NP/KXNDfKziAlbiYeA2e0yljems=;
        b=vQAFtSNfEXFc12lcmRHSrslBLWwrL9/3NL8nC2K0IdgACd51+qanHt6Urlnq1WUhwI
         JlMWMxShXW7YHbRJmcxBlCLEzY9XfmWvKgnISBWFAUfl0MT4yJw6cQYm+rvMs/tKASEQ
         UCyDKUKAOdMY/0jv68FVFWyaE94OedLnLjx9+FfgAe2Idzi+4XLQUxJl11mQk2JJeFI5
         nb1/R5trHh7mna8SiwpM5GOcV/UiXnRDLKbs1lZOV8wnWD65UG88MxcPsD+Q1GYLxJWT
         BoZXgKZVl1dt0idRIQlHUtff4hpoJUJCfpcfmOqVTcrIdjwhmtr11K1dLp8KH/uBoR8W
         EEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJuCgdGkxri9O9i9NP/KXNDfKziAlbiYeA2e0yljems=;
        b=sTfsKAM4Ns+mzZDv8wE+kYtOHUow0NuhwG/bfkshs3SFrcUovrcYA2C+oWon4oVXUb
         /YAu0aoRVnC5WdQCKFoxDtHO9bIlFVSMtB9E5ssc9iZvuCRDPvKtM/tvveCFjk8ou517
         gs6qU6e3fpEYKTWv32w3+l9wvgFUiNzG0nsdD1aQl8pZ0LBp8qi21YNy0H7mnmMWCJFg
         K8OafMjMyh/Y6vbMzIAlKcGAZWtkCQ8FkmUe+c06QtClhszeByeijyEhP4vXLVqsa+sK
         dX+IqpAzoFdyOdmB19WWkYAjfF+p4481bRO/aeNMpiEXoPFV0snuTuSGGW9HIhrdaZ9e
         W0IQ==
X-Gm-Message-State: AGi0PuYyeOYpLapytPQvqyz1Hia+yd5iObOLI6LnFjEZg1+Q1bxI2wKE
        d1D45/7m5qXqhaJcWs5zY/mf2g==
X-Google-Smtp-Source: APiQypIpzqmpD0rszP5jLG6wkpB0LTXe+PC8lP5EdHe8jySUT5DIu12pY4ZLhwARoj4ZwLkx8MQKAQ==
X-Received: by 2002:a05:620a:16db:: with SMTP id a27mr3878709qkn.441.1588962755453;
        Fri, 08 May 2020 11:32:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id k2sm2195385qta.39.2020.05.08.11.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:34 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 13/19] mm: memcontrol: drop unused try/commit/cancel charge API
Date:   Fri,  8 May 2020 14:31:00 -0400
Message-Id: <20200508183105.225460-14-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users. RIP in peace.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/memcontrol.h |  36 -----------
 mm/memcontrol.c            | 126 +++++--------------------------------
 2 files changed, 15 insertions(+), 147 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9b1054bf6d35..23608d3ee70f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -369,14 +369,6 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }
 
-int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp);
-int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp);
-void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
-			      bool lrucare);
-void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg);
-
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 		      bool lrucare);
 
@@ -867,34 +859,6 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 	return false;
 }
 
-static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
-					gfp_t gfp_mask,
-					struct mem_cgroup **memcgp)
-{
-	*memcgp = NULL;
-	return 0;
-}
-
-static inline int mem_cgroup_try_charge_delay(struct page *page,
-					      struct mm_struct *mm,
-					      gfp_t gfp_mask,
-					      struct mem_cgroup **memcgp)
-{
-	*memcgp = NULL;
-	return 0;
-}
-
-static inline void mem_cgroup_commit_charge(struct page *page,
-					    struct mem_cgroup *memcg,
-					    bool lrucare)
-{
-}
-
-static inline void mem_cgroup_cancel_charge(struct page *page,
-					    struct mem_cgroup *memcg)
-{
-}
-
 static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
 				    gfp_t gfp_mask, bool lrucare)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fd92c1c99e1f..7b9bb7ca0b44 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6432,29 +6432,26 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 }
 
 /**
- * mem_cgroup_try_charge - try charging a page
+ * mem_cgroup_charge - charge a newly allocated page to a cgroup
  * @page: page to charge
  * @mm: mm context of the victim
  * @gfp_mask: reclaim mode
- * @memcgp: charged memcg return
+ * @lrucare: page might be on the LRU already
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
  * pages according to @gfp_mask if necessary.
  *
- * Returns 0 on success, with *@memcgp pointing to the charged memcg.
- * Otherwise, an error code is returned.
- *
- * After page->mapping has been set up, the caller must finalize the
- * charge with mem_cgroup_commit_charge().  Or abort the transaction
- * with mem_cgroup_cancel_charge() in case page instantiation fails.
+ * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp)
+int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
+		      bool lrucare)
 {
 	unsigned int nr_pages = hpage_nr_pages(page);
 	struct mem_cgroup *memcg = NULL;
 	int ret = 0;
 
+	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
+
 	if (mem_cgroup_disabled())
 		goto out;
 
@@ -6486,56 +6483,8 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 		memcg = get_mem_cgroup_from_mm(mm);
 
 	ret = try_charge(memcg, gfp_mask, nr_pages);
-
-	css_put(&memcg->css);
-out:
-	*memcgp = memcg;
-	return ret;
-}
-
-int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp)
-{
-	int ret;
-
-	ret = mem_cgroup_try_charge(page, mm, gfp_mask, memcgp);
-	if (*memcgp)
-		cgroup_throttle_swaprate(page, gfp_mask);
-	return ret;
-}
-
-/**
- * mem_cgroup_commit_charge - commit a page charge
- * @page: page to charge
- * @memcg: memcg to charge the page to
- * @lrucare: page might be on LRU already
- *
- * Finalize a charge transaction started by mem_cgroup_try_charge(),
- * after page->mapping has been set up.  This must happen atomically
- * as part of the page instantiation, i.e. under the page table lock
- * for anonymous pages, under the page lock for page and swap cache.
- *
- * In addition, the page must not be on the LRU during the commit, to
- * prevent racing with task migration.  If it might be, use @lrucare.
- *
- * Use mem_cgroup_cancel_charge() to cancel the transaction instead.
- */
-void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
-			      bool lrucare)
-{
-	unsigned int nr_pages = hpage_nr_pages(page);
-
-	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
-
-	if (mem_cgroup_disabled())
-		return;
-	/*
-	 * Swap faults will attempt to charge the same page multiple
-	 * times.  But reuse_swap_page() might have removed the page
-	 * from swapcache already, so we can't check PageSwapCache().
-	 */
-	if (!memcg)
-		return;
+	if (ret)
+		goto out_put;
 
 	commit_charge(page, memcg, lrucare);
 
@@ -6553,55 +6502,11 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 		 */
 		mem_cgroup_uncharge_swap(entry, nr_pages);
 	}
-}
 
-/**
- * mem_cgroup_cancel_charge - cancel a page charge
- * @page: page to charge
- * @memcg: memcg to charge the page to
- *
- * Cancel a charge transaction started by mem_cgroup_try_charge().
- */
-void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg)
-{
-	unsigned int nr_pages = hpage_nr_pages(page);
-
-	if (mem_cgroup_disabled())
-		return;
-	/*
-	 * Swap faults will attempt to charge the same page multiple
-	 * times.  But reuse_swap_page() might have removed the page
-	 * from swapcache already, so we can't check PageSwapCache().
-	 */
-	if (!memcg)
-		return;
-
-	cancel_charge(memcg, nr_pages);
-}
-
-/**
- * mem_cgroup_charge - charge a newly allocated page to a cgroup
- * @page: page to charge
- * @mm: mm context of the victim
- * @gfp_mask: reclaim mode
- * @lrucare: page might be on the LRU already
- *
- * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
- *
- * Returns 0 on success. Otherwise, an error code is returned.
- */
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
-		      bool lrucare)
-{
-	struct mem_cgroup *memcg;
-	int ret;
-
-	ret = mem_cgroup_try_charge(page, mm, gfp_mask, &memcg);
-	if (ret)
-		return ret;
-	mem_cgroup_commit_charge(page, memcg, lrucare);
-	return 0;
+out_put:
+	css_put(&memcg->css);
+out:
+	return ret;
 }
 
 struct uncharge_gather {
@@ -6706,8 +6611,7 @@ static void uncharge_list(struct list_head *page_list)
  * mem_cgroup_uncharge - uncharge a page
  * @page: page to uncharge
  *
- * Uncharge a page previously charged with mem_cgroup_try_charge() and
- * mem_cgroup_commit_charge().
+ * Uncharge a page previously charged with mem_cgroup_charge().
  */
 void mem_cgroup_uncharge(struct page *page)
 {
@@ -6730,7 +6634,7 @@ void mem_cgroup_uncharge(struct page *page)
  * @page_list: list of pages to uncharge
  *
  * Uncharge a list of pages previously charged with
- * mem_cgroup_try_charge() and mem_cgroup_commit_charge().
+ * mem_cgroup_charge().
  */
 void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
-- 
2.26.2

