Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6A4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3504820759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Vfqtr1av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgETX0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgETX0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:07 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A732C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:07 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t25so4128020qtc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONzXxQJWlYS6v930NyblSl/dSH7byxuUjdizqQ76XH0=;
        b=Vfqtr1avu8tKcBmh9fQhTBFRNFDrzNK0PrK8D6jNEROiFm3/ZTM/m06At6b/4uXVsC
         1vbyQWxOIaVQr8yv2yXIoDgk7tZynHELSGHCvuW7WV2763JCx3aB8O33biCDlb137whD
         YgcWXGrAB+b+mPLNQFGRvhO6neIyhmoIE6bO5J0FYCYgv+ZTT/AzpiPnrIdTee7gBQia
         P+7xyDQehuBqMoq6DezkMOl7yYDOuW2DcBiYBvc3Qk4tEDxyOUsSSdzIzTake8NsBSF/
         +Cyv0HXlKg53qZ5z2nVOzPqKfeedvzJGjOYZSvaRrM8tSG1urxGtbkJMYtK/JbJy4hwa
         Xv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONzXxQJWlYS6v930NyblSl/dSH7byxuUjdizqQ76XH0=;
        b=K8d60Vh6WnTzUYR/coF1fhG36HN4ttyR5pzoiMTKm3Ne/Q7CH3uKQwkZ3yatqDi04z
         a5Ye7ssEz/CIiX4JvGEmhgpkEm5tMCZ3oNlwEgucAjhfrsspI8yWWypAnrmnEpmCo6KG
         wwMTAfwa7cidqidRYR/ASxK2vSqwUK6VdtamRmmoUCp7ZmTxSCVjMVOZtbggBnzEIuGB
         1ofabW60xQ8RwiC7QPENxA24ceaN8Y/3KL7gl1aDV6G3e+atq/ZOjwtdV4+Tc2pD8fhw
         k3tRuMrf0nuCTaLPA8mafm0xXnOjx59PJPJCKLuFAZ0ynzrLCBRuoQKKQkkdwV4r3HIY
         ToAA==
X-Gm-Message-State: AOAM5336BdAZUpxD3H0mhK4Pk6JWJVxgoE9LszFgoZ5scyAb3/XV/rEM
        zBtH3kV0qDihN227uBElzbJ8XlX7nyA=
X-Google-Smtp-Source: ABdhPJxWLrLCauEGOpU27uvVaRr+J6xURbThu0ApKi/WqsatFbaueRYa5w8NI0hkSOEFQm0hdHV3iw==
X-Received: by 2002:ac8:3fa4:: with SMTP id d33mr8066768qtk.376.1590017166387;
        Wed, 20 May 2020 16:26:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id p42sm3802559qtk.94.2020.05.20.16.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:05 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/14] mm: fold and remove lru_cache_add_anon() and lru_cache_add_file()
Date:   Wed, 20 May 2020 19:25:15 -0400
Message-Id: <20200520232525.798933-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They're the same function, and for the purpose of all callers they are
equivalent to lru_cache_add().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Rik van Riel <riel@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 fs/cifs/file.c       | 10 +++++-----
 fs/fuse/dev.c        |  2 +-
 include/linux/swap.h |  2 --
 mm/khugepaged.c      |  8 ++------
 mm/memory.c          |  2 +-
 mm/shmem.c           |  6 +++---
 mm/swap.c            | 38 ++++++++------------------------------
 mm/swap_state.c      |  2 +-
 8 files changed, 21 insertions(+), 49 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0b1528edebcf..169ab37bb3aa 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4162,7 +4162,7 @@ cifs_readv_complete(struct work_struct *work)
 	for (i = 0; i < rdata->nr_pages; i++) {
 		struct page *page = rdata->pages[i];
 
-		lru_cache_add_file(page);
+		lru_cache_add(page);
 
 		if (rdata->result == 0 ||
 		    (rdata->result == -EAGAIN && got_bytes)) {
@@ -4232,7 +4232,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 			 * fill them until the writes are flushed.
 			 */
 			zero_user(page, 0, PAGE_SIZE);
-			lru_cache_add_file(page);
+			lru_cache_add(page);
 			flush_dcache_page(page);
 			SetPageUptodate(page);
 			unlock_page(page);
@@ -4242,7 +4242,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 			continue;
 		} else {
 			/* no need to hold page hostage */
-			lru_cache_add_file(page);
+			lru_cache_add(page);
 			unlock_page(page);
 			put_page(page);
 			rdata->pages[i] = NULL;
@@ -4437,7 +4437,7 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 			/* best to give up if we're out of mem */
 			list_for_each_entry_safe(page, tpage, &tmplist, lru) {
 				list_del(&page->lru);
-				lru_cache_add_file(page);
+				lru_cache_add(page);
 				unlock_page(page);
 				put_page(page);
 			}
@@ -4475,7 +4475,7 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 			add_credits_and_wake_if(server, &rdata->credits, 0);
 			for (i = 0; i < rdata->nr_pages; i++) {
 				page = rdata->pages[i];
-				lru_cache_add_file(page);
+				lru_cache_add(page);
 				unlock_page(page);
 				put_page(page);
 			}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 97eec7522bf2..8c0cc79d8071 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -840,7 +840,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	get_page(newpage);
 
 	if (!(buf->flags & PIPE_BUF_FLAG_LRU))
-		lru_cache_add_file(newpage);
+		lru_cache_add(newpage);
 
 	err = 0;
 	spin_lock(&cs->req->waitq.lock);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b42fb47d8cbe..30fd4641890e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -334,8 +334,6 @@ extern unsigned long nr_free_pagecache_pages(void);
 
 /* linux/mm/swap.c */
 extern void lru_cache_add(struct page *);
-extern void lru_cache_add_anon(struct page *page);
-extern void lru_cache_add_file(struct page *page);
 extern void lru_add_page_tail(struct page *page, struct page *page_tail,
 			 struct lruvec *lruvec, struct list_head *head);
 extern void activate_page(struct page *);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f2e0a5e5cfbb..d458c61d6195 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1869,13 +1869,9 @@ static void collapse_file(struct mm_struct *mm,
 
 		SetPageUptodate(new_page);
 		page_ref_add(new_page, HPAGE_PMD_NR - 1);
-
-		if (is_shmem) {
+		if (is_shmem)
 			set_page_dirty(new_page);
-			lru_cache_add_anon(new_page);
-		} else {
-			lru_cache_add_file(new_page);
-		}
+		lru_cache_add(new_page);
 
 		/*
 		 * Remove pte page tables, so we can re-fault the page as huge.
diff --git a/mm/memory.c b/mm/memory.c
index b4efc125ae09..a1813ca388a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3139,7 +3139,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				if (err)
 					goto out_page;
 
-				lru_cache_add_anon(page);
+				lru_cache_add(page);
 				swap_readpage(page, true);
 			}
 		} else {
diff --git a/mm/shmem.c b/mm/shmem.c
index e83de27ce8f4..ea95a3e46fbb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1609,7 +1609,7 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 		 */
 		oldpage = newpage;
 	} else {
-		lru_cache_add_anon(newpage);
+		lru_cache_add(newpage);
 		*pagep = newpage;
 	}
 
@@ -1860,7 +1860,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 					charge_mm);
 	if (error)
 		goto unacct;
-	lru_cache_add_anon(page);
+	lru_cache_add(page);
 
 	spin_lock_irq(&info->lock);
 	info->alloced += compound_nr(page);
@@ -2376,7 +2376,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (!pte_none(*dst_pte))
 		goto out_release_unlock;
 
-	lru_cache_add_anon(page);
+	lru_cache_add(page);
 
 	spin_lock_irq(&info->lock);
 	info->alloced++;
diff --git a/mm/swap.c b/mm/swap.c
index 68eae1e2787a..c93a6c84464c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -403,35 +403,6 @@ void mark_page_accessed(struct page *page)
 }
 EXPORT_SYMBOL(mark_page_accessed);
 
-static void __lru_cache_add(struct page *page)
-{
-	struct pagevec *pvec = &get_cpu_var(lru_add_pvec);
-
-	get_page(page);
-	if (!pagevec_add(pvec, page) || PageCompound(page))
-		__pagevec_lru_add(pvec);
-	put_cpu_var(lru_add_pvec);
-}
-
-/**
- * lru_cache_add_anon - add a page to the page lists
- * @page: the page to add
- */
-void lru_cache_add_anon(struct page *page)
-{
-	if (PageActive(page))
-		ClearPageActive(page);
-	__lru_cache_add(page);
-}
-
-void lru_cache_add_file(struct page *page)
-{
-	if (PageActive(page))
-		ClearPageActive(page);
-	__lru_cache_add(page);
-}
-EXPORT_SYMBOL(lru_cache_add_file);
-
 /**
  * lru_cache_add - add a page to a page list
  * @page: the page to be added to the LRU.
@@ -443,10 +414,17 @@ EXPORT_SYMBOL(lru_cache_add_file);
  */
 void lru_cache_add(struct page *page)
 {
+	struct pagevec *pvec = &get_cpu_var(lru_add_pvec);
+
 	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
-	__lru_cache_add(page);
+
+	get_page(page);
+	if (!pagevec_add(pvec, page) || PageCompound(page))
+		__pagevec_lru_add(pvec);
+	put_cpu_var(lru_add_pvec);
 }
+EXPORT_SYMBOL(lru_cache_add);
 
 /**
  * lru_cache_add_active_or_unevictable
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 17123caec6dd..b5e08ff00e1e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -432,7 +432,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	/* Initiate read into locked page */
 	SetPageWorkingset(page);
-	lru_cache_add_anon(page);
+	lru_cache_add(page);
 	*new_page_allocated = true;
 	return page;
 
-- 
2.26.2

