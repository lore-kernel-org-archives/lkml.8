Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB012C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BCF20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O65CFHwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgH1Lko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:40:44 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:14312 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgH1Lk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598614825; x=1630150825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=qpu0feKwOcymvYtWLTKyhyFtGGbT1hSlzhSdO90X9SQ=;
  b=O65CFHwLn+OpUEeTNuZX2XKH+XnL5SFCc+WgKZ7lJ0JDBgI9R8HmoZJa
   8J6oCU5bUdTLdlmZ580u6va2+WGZFUNPoowU9PQb3310SEWznWa9pGAqn
   10ra+ELqx5auRiN4JJRmzRLrHpzpLOUP9VlO6XzIhhx3aAO5AqxI15upJ
   8=;
X-IronPort-AV: E=Sophos;i="5.76,363,1592870400"; 
   d="scan'208";a="50525029"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Aug 2020 11:40:09 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id EC561282E6F;
        Fri, 28 Aug 2020 11:39:57 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.244) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 28 Aug 2020 11:39:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Alkaid <zgf574564920@gmail.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <david@redhat.com>, <dwmw@amazon.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.com>
Subject: Re: [RFC v7 06/10] mm/damon: Implement callbacks for physical memory monitoring
Date:   Fri, 28 Aug 2020 13:39:21 +0200
Message-ID: <20200828113921.15279-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828095315.27210-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.244]
X-ClientProxiedBy: EX13D40UWC004.ant.amazon.com (10.43.162.175) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 11:53:15 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> On Fri, 28 Aug 2020 04:11:56 -0400 Alkaid <zgf574564920@gmail.com> wrote:
> 
> > 
> > [-- Attachment #1: Type: text/plain, Size: 2677 bytes --]
> > 
> > Hi SeongJae,
> > 
> > I think there are potential memory leaks in the following execution paths
> 
> Agreed, definitely memory leaks exists.  Thank you for let me know this!  I
> will post a patch for this soon.

And, below is the patch.  The complete tree is available at:

    https://github.com/sjp38/linux/tree/damon/next


Thanks,
SeongJae Park


==================================== >8 =======================================
From 8f605d807c55b536ab5b0f87306ac78033dc4499 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sjpark@amazon.de>
Date: Fri, 28 Aug 2020 11:29:30 +0000
Subject: [PATCH] mm/damon/paddr: Add missed 'put_page()' calls

Exceptional cases handlings in 'damon_phys_mkold()' and
'damon_phys_young()' doesn't properly put pages.  This commit fixes the
problem by adding the 'put_page()' call.

Reported-by: Alkaid <zgf574564920@gmail.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 53 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index d0d55656553b..74a10ea54958 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -836,12 +836,16 @@ unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
 /* access check functions for physical address based regions */
 
 /*
- * Get a page by pfn if it is in the LRU list.  Otherwise, returns NULL.
+ * Get a page by @pfn if it is in the LRU list and mapped.  If the page needs
+ * locked, do the lock and save the result in @locked.  Otherwise, returns
+ * NULL.
  *
- * The body of this function is stollen from the 'page_idle_get_page()'.  We
- * steal rather than reuse it because the code is quite simple .
+ * The body of this function is mostly stollen from the 'page_idle_get_page()'
+ * and 'page_idle_clear_pte_refs()'.  We steal rather than reuse it not because
+ * we are great artists but the code is quite simple and we need to unify parts
+ * of the two functions.
  */
-static struct page *damon_phys_get_page(unsigned long pfn)
+static struct page *damon_phys_get_page(unsigned long pfn, bool *locked)
 {
 	struct page *page = pfn_to_online_page(pfn);
 	pg_data_t *pgdat;
@@ -854,9 +858,22 @@ static struct page *damon_phys_get_page(unsigned long pfn)
 	spin_lock_irq(&pgdat->lru_lock);
 	if (unlikely(!PageLRU(page))) {
 		put_page(page);
-		page = NULL;
+		spin_unlock_irq(&pgdat->lru_lock);
+		return NULL;
 	}
 	spin_unlock_irq(&pgdat->lru_lock);
+
+	if (!page_mapped(page) || !page_rmapping(page)) {
+		put_page(page);
+		return NULL;
+	}
+
+	*locked = !PageAnon(page) || PageKsm(page);
+	if (*locked && !trylock_page(page)) {
+		put_page(page);
+		return NULL;
+	}
+
 	return page;
 }
 
@@ -869,26 +886,19 @@ static bool damon_page_mkold(struct page *page, struct vm_area_struct *vma,
 
 static void damon_phys_mkold(unsigned long paddr)
 {
-	struct page *page = damon_phys_get_page(PHYS_PFN(paddr));
+	bool locked;
+	struct page *page = damon_phys_get_page(PHYS_PFN(paddr), &locked);
 	struct rmap_walk_control rwc = {
 		.rmap_one = damon_page_mkold,
 		.anon_lock = page_lock_anon_vma_read,
 	};
-	bool need_lock;
 
 	if (!page)
 		return;
 
-	if (!page_mapped(page) || !page_rmapping(page))
-		return;
-
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page))
-		return;
-
 	rmap_walk(page, &rwc);
 
-	if (need_lock)
+	if (locked)
 		unlock_page(page);
 	put_page(page);
 }
@@ -930,7 +940,8 @@ static bool damon_page_accessed(struct page *page, struct vm_area_struct *vma,
 
 static bool damon_phys_young(unsigned long paddr, unsigned long *page_sz)
 {
-	struct page *page = damon_phys_get_page(PHYS_PFN(paddr));
+	bool locked;
+	struct page *page = damon_phys_get_page(PHYS_PFN(paddr), &locked);
 	struct damon_phys_access_chk_result result = {
 		.page_sz = PAGE_SIZE,
 		.accessed = false,
@@ -940,21 +951,13 @@ static bool damon_phys_young(unsigned long paddr, unsigned long *page_sz)
 		.rmap_one = damon_page_accessed,
 		.anon_lock = page_lock_anon_vma_read,
 	};
-	bool need_lock;
 
 	if (!page)
 		return false;
 
-	if (!page_mapped(page) || !page_rmapping(page))
-		return false;
-
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page))
-		return false;
-
 	rmap_walk(page, &rwc);
 
-	if (need_lock)
+	if (locked)
 		unlock_page(page);
 	put_page(page);
 
-- 
2.17.1

