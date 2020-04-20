Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FFCC55183
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A968E20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="W9M8209L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgDTWML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgDTWMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:12:05 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:12:05 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c16so10067136qtv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ByVKo45aqE3C3DiOWQlsfGiXPD8l0eCrADnL4xHp3M=;
        b=W9M8209Lc67ASOYNxMxTQgqQ83SefdkGr4BMt3zVc2SbUfZkCY8RKITBaHT3GEOBhj
         N6lcEWc71w4InzGYzCXejgX6dB57cHmEO7jFYsstDdDGBjxMHjRaEeEgsw/FS7v0xboV
         8kJ9WEuhnEhURfAcJrMRRRUKtpl23ZrvvZG1L024jGU6N6WvFDqxir/r+ZLBe1XD77/C
         3Yaim4ynqkVQTMgEXcwAP2ozd6akgOygsfVgsn/eDTH8+9VGOpu5KStmyVSRak9cEonB
         pYfrKK3YsJB+eMlMlWfXLRjbHSdSuD96IhBn35BCOQyPlYBUk9zopL+9drvDv9A0RPCR
         e2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ByVKo45aqE3C3DiOWQlsfGiXPD8l0eCrADnL4xHp3M=;
        b=PAaH901s4TUaNly+NPvprlsbAzDCvbCdc8eurclT5dkRO9DvooXD7NLdlf3Ko/ynu8
         LAb47F4mVbSOH6vZZd1aG+NsFQIw54FRDICpscWr6SVm9O0nQQMQsWzMCr5ox2GNCg6l
         AGbgj7MMy/wris2E0xu8mMRHoOMSIO4Tcg5tWejaZVJsSdcsMa7muVwX3juGgS1v+0cl
         h5a36mEBwPTce0D301aR/ySUK8E6YjNbYEXOf6PxgUNfZ6ZOwZF+A9DAo/OLbLGXf1tX
         GhMz0Js0iDrkJA0xpdmHySn49vLlnRi84p/4+07kuJzItnkBKOhgK5/x7wVqo9wdVUrL
         LlOQ==
X-Gm-Message-State: AGi0Pua0Y6HfnKqJwRa4XmybZnSbXo3pg58exal44cL2CZzz8gk/rUHJ
        ss/F3TK+J3KJdWyqeIzOis7RIw==
X-Google-Smtp-Source: APiQypKo2DmYJKGiyL9AbVGNCrQ9cisUiwv9yX0i7x9v3iG5reuyNDJ7IGJ5vGas8mXirtHTbM036w==
X-Received: by 2002:ac8:1703:: with SMTP id w3mr18392750qtj.267.1587420724916;
        Mon, 20 Apr 2020 15:12:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id 31sm435219qta.56.2020.04.20.15.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:12:04 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 13/18] mm: memcontrol: drop unused try/commit/cancel charge API
Date:   Mon, 20 Apr 2020 18:11:21 -0400
Message-Id: <20200420221126.341272-14-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users. RIP in peace.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  36 -----------
 mm/memcontrol.c            | 126 +++++--------------------------------
 2 files changed, 15 insertions(+), 147 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9ac8122ec1cd..52eb6411cfee 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -357,14 +357,6 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg);
 
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
 
@@ -846,34 +838,6 @@ static inline enum mem_cgroup_protection mem_cgroup_protected(
 	return MEMCG_PROT_NONE;
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
index 7845a87b94d5..d5aee5577ff3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6431,29 +6431,26 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
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
 
@@ -6485,56 +6482,8 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
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
 
@@ -6552,55 +6501,11 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
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
@@ -6707,8 +6612,7 @@ static void uncharge_list(struct list_head *page_list)
  * mem_cgroup_uncharge - uncharge a page
  * @page: page to uncharge
  *
- * Uncharge a page previously charged with mem_cgroup_try_charge() and
- * mem_cgroup_commit_charge().
+ * Uncharge a page previously charged with mem_cgroup_charge().
  */
 void mem_cgroup_uncharge(struct page *page)
 {
@@ -6731,7 +6635,7 @@ void mem_cgroup_uncharge(struct page *page)
  * @page_list: list of pages to uncharge
  *
  * Uncharge a list of pages previously charged with
- * mem_cgroup_try_charge() and mem_cgroup_commit_charge().
+ * mem_cgroup_charge().
  */
 void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
-- 
2.26.0

