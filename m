Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1466FC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3B421927
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgD2S3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:29:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:48103 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2S3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:29:52 -0400
IronPort-SDR: G/iJMikVYLRugUx2MPWMS+WNhgY5vuRNOOk/sqhOJNuLBYrEUns75uJIfi1LPgvSgq4E72g9Vj
 oQaa1Q372IYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 11:29:51 -0700
IronPort-SDR: oML/I7b8KBGVfCUfb08bypJJC5w9NogHC19eoyXv6UC9MjcNOe479FLrDHSMdHe2ortzeOaSHp
 rWVInb7F2ncw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="367889577"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2020 11:29:51 -0700
Date:   Wed, 29 Apr 2020 11:29:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 1/7] mm: Document x86 uses a linked list of pgds
Message-ID: <20200429182951.GA411423@iweiny-DESK2.sc.intel.com>
References: <20200428194449.22615-1-willy@infradead.org>
 <20200428194449.22615-2-willy@infradead.org>
 <20200428214109.GB406458@iweiny-DESK2.sc.intel.com>
 <20200428225251.GM29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428225251.GM29705@bombadil.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:52:51PM -0700, Matthew Wilcox wrote:
> On Tue, Apr 28, 2020 at 02:41:09PM -0700, Ira Weiny wrote:
> > On Tue, Apr 28, 2020 at 12:44:43PM -0700, Matthew Wilcox wrote:
> > > x86 uses page->lru of the pages used for pgds, but that's not immediately
> > > obvious to anyone looking to make changes.  Add a struct list_head to
> > > the union so it's clearly in use for pgds.
> > 
> > Shouldn't pgd_list_{add,del}() use this list head variable instead of lru to
> > complete the documentation?
> > 
> > Probably the list iteration loops arch/x86/* as well?
> 
> Yes, but I felt that was out of scope for this patchset.  Untangling the
> uses of struct page is a long and messy business; if we have to fix
> everything at once, we'll never get anywhere.  There's also the slab
> users of page->lru instead of page->slab_list.

But doesn't changing the use of lru with this new name in the code also help to
identify the users?

> 
> What I actually want to get to is:
> 
> struct page {
> 	unsigned long flags;
> 	union {
> 		struct file_page file;
> 		struct anon_page anon;
> 		struct pt_page pt;
> 		struct slab_page slab;
> 		struct tail_page tail;
> 		struct rcu_head rcu;
> 	};
> 	union {
> 		atomic_t _mapcount;
> 		...
> 	};
> 	atomic_t refcount;
> 	...
> };
> 
> and then we can refer to page->pt.list and so on.

Then later on we know exactly where page->pt.list needs to be inserted.

I'm not opposed to the patch as it is.  But as someone newer it seems like the
following documents the use of lru as much if not more.

Compile tested only but feel free to merge if you like.
Ira

From 63fa92a940fa17567ab45a64b7ac058d4d41a54d Mon Sep 17 00:00:00 2001
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 29 Apr 2020 11:10:59 -0700
Subject: [PATCH] mm: Complete documenting the use of lru for pgd_list

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/mm/fault.c          | 2 +-
 arch/x86/mm/init_64.c        | 4 ++--
 arch/x86/mm/pat/set_memory.c | 2 +-
 arch/x86/mm/pgtable.c        | 4 ++--
 arch/x86/xen/mmu_pv.c        | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a51df516b87b..f07d477f8787 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -203,7 +203,7 @@ static void vmalloc_sync(void)
 		struct page *page;
 
 		spin_lock(&pgd_lock);
-		list_for_each_entry(page, &pgd_list, lru) {
+		list_for_each_entry(page, &pgd_list, pgd_list) {
 			spinlock_t *pgt_lock;
 
 			/* the pgt_lock only for Xen */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3b289c2f75cd..e2ae3618a65d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -140,7 +140,7 @@ static void sync_global_pgds_l5(unsigned long start, unsigned long end)
 			continue;
 
 		spin_lock(&pgd_lock);
-		list_for_each_entry(page, &pgd_list, lru) {
+		list_for_each_entry(page, &pgd_list, pgd_list) {
 			pgd_t *pgd;
 			spinlock_t *pgt_lock;
 
@@ -181,7 +181,7 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
 			continue;
 
 		spin_lock(&pgd_lock);
-		list_for_each_entry(page, &pgd_list, lru) {
+		list_for_each_entry(page, &pgd_list, pgd_list) {
 			pgd_t *pgd;
 			p4d_t *p4d;
 			spinlock_t *pgt_lock;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 59eca6a94ce7..a1edfc593141 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -723,7 +723,7 @@ static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
 	if (!SHARED_KERNEL_PMD) {
 		struct page *page;
 
-		list_for_each_entry(page, &pgd_list, lru) {
+		list_for_each_entry(page, &pgd_list, pgd_list) {
 			pgd_t *pgd;
 			p4d_t *p4d;
 			pud_t *pud;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 8f4255662c5a..28ea8cc3f3a2 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -87,14 +87,14 @@ static inline void pgd_list_add(pgd_t *pgd)
 {
 	struct page *page = virt_to_page(pgd);
 
-	list_add(&page->lru, &pgd_list);
+	list_add(&page->pgd_list, &pgd_list);
 }
 
 static inline void pgd_list_del(pgd_t *pgd)
 {
 	struct page *page = virt_to_page(pgd);
 
-	list_del(&page->lru);
+	list_del(&page->pgd_list);
 	page->pt_mm = NULL;
 }
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index bbba8b17829a..df6592be3208 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -844,7 +844,7 @@ void xen_mm_pin_all(void)
 
 	spin_lock(&pgd_lock);
 
-	list_for_each_entry(page, &pgd_list, lru) {
+	list_for_each_entry(page, &pgd_list, pgd_list) {
 		if (!PagePinned(page)) {
 			__xen_pgd_pin(&init_mm, (pgd_t *)page_address(page));
 			SetPageSavePinned(page);
@@ -963,7 +963,7 @@ void xen_mm_unpin_all(void)
 
 	spin_lock(&pgd_lock);
 
-	list_for_each_entry(page, &pgd_list, lru) {
+	list_for_each_entry(page, &pgd_list, pgd_list) {
 		if (PageSavePinned(page)) {
 			BUG_ON(!PagePinned(page));
 			__xen_pgd_unpin(&init_mm, (pgd_t *)page_address(page));
-- 
2.25.1

