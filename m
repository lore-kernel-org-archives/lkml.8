Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A48C11D0F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B10E2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN6B0qAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgBTQbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728354AbgBTQba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzxiNpJ74cm3apNvzVOkAuAMHa+8ebeRBqCgwj3NQos=;
        b=dN6B0qAaX+zw409QeYT+n3Zwt6yMO1cueoipM2Xgzd5orAzGLV+46WddGe0h3aLme2b9O1
        vIhLU6lEIvXkkn/IKn60wlW3Ur2eDyTAoRadrWLWrD4wYWRuWSfPwzIGdwhiey/49yLdzO
        BhNQ8MNa6lefKTRyDBgJkbRTgWOlwPw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-IwMc4V75NSy7u3Mg5dWRvg-1; Thu, 20 Feb 2020 11:31:26 -0500
X-MC-Unique: IwMc4V75NSy7u3Mg5dWRvg-1
Received: by mail-qk1-f197.google.com with SMTP id q123so3125788qkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzxiNpJ74cm3apNvzVOkAuAMHa+8ebeRBqCgwj3NQos=;
        b=eh3ASbTmV2snDknrekqrbZnkI5aBqizpw/2oxywNz4OekmjF0/vtkO9yac+5e4ncgb
         kUFanpXhVSCu6v7SigxAkJY7FeWiIRYMQBtkYOHXR74kgjgvIcXp408X6XvnE1D/HxoZ
         ocq3q0KQQBccGM9TdjYVxqrDvo1jJO2qOyp08S5hzdaWpM1jjSy+rjJm8ghi6ZJe97Qe
         pfmbgThjZSBldoaaE+S+F9SJdnhRZrpGMpSqVE9wugQQeJQuwk+XCWKclPBHY3MedSRt
         xL8ClbIQpd+opPTdgW9jmjLLN1ykH67ZhkI3kHoQ1rTKoBbjQwIPMxGsJ7L+vLPZSicI
         r5vw==
X-Gm-Message-State: APjAAAWKlgLsQ63AXV3xXAaUzngh+TWXj/GNatcmS5B6pOOm11D17Pq/
        zGUJH0rRHF0CMRGsHAIZiB8uhLSS/wM3j7Vr+WYhllNW7VpVCWjyTk0bYs53aD9PZYUHQl8saCd
        9DegEGPl0vBk/rZbjleRhhmRJ
X-Received: by 2002:ac8:cb:: with SMTP id d11mr27573197qtg.22.1582216286045;
        Thu, 20 Feb 2020 08:31:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyk1N7dL59sWammyS1kvLismOt/2QFhFT9Et6JVVWTW7b592VWkU5ILX5RvyRKdfYH5Z5TKNQ==
X-Received: by 2002:ac8:cb:: with SMTP id d11mr27573156qtg.22.1582216285648;
        Thu, 20 Feb 2020 08:31:25 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:24 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v6 06/19] mm: merge parameters for change_protection()
Date:   Thu, 20 Feb 2020 11:30:59 -0500
Message-Id: <20200220163112.11409-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change_protection() was used by either the NUMA or mprotect() code,
there's one parameter for each of the callers (dirty_accountable and
prot_numa).  Further, these parameters are passed along the calls:

  - change_protection_range()
  - change_p4d_range()
  - change_pud_range()
  - change_pmd_range()
  - ...

Now we introduce a flag for change_protect() and all these helpers to
replace these parameters.  Then we can avoid passing multiple parameters
multiple times along the way.

More importantly, it'll greatly simplify the work if we want to
introduce any new parameters to change_protection().  In the follow up
patches, a new parameter for userfaultfd write protection will be
introduced.

No functional change at all.

Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h |  2 +-
 include/linux/mm.h      | 14 +++++++++++++-
 mm/huge_memory.c        |  3 ++-
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 29 ++++++++++++++++-------------
 5 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5aca3d1bdb32..92220ec66862 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -46,7 +46,7 @@ extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			 pmd_t *old_pmd, pmd_t *new_pmd);
 extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, pgprot_t newprot,
-			int prot_numa);
+			unsigned long cp_flags);
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 enum transparent_hugepage_flag {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 51a886d50758..547c7415ff92 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1660,9 +1660,21 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
 		bool need_rmap_locks);
+
+/*
+ * Flags used by change_protection().  For now we make it a bitmap so
+ * that we can pass in multiple flags just like parameters.  However
+ * for now all the callers are only use one of the flags at the same
+ * time.
+ */
+/* Whether we should allow dirty bit accounting */
+#define  MM_CP_DIRTY_ACCT                  (1UL << 0)
+/* Whether this protection change is for NUMA hints */
+#define  MM_CP_PROT_NUMA                   (1UL << 1)
+
 extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
-			      int dirty_accountable, int prot_numa);
+			      unsigned long cp_flags);
 extern int mprotect_fixup(struct vm_area_struct *vma,
 			  struct vm_area_struct **pprev, unsigned long start,
 			  unsigned long end, unsigned long newflags);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..2b01765bee92 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1934,13 +1934,14 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
  *  - HPAGE_PMD_NR is protections changed and TLB flush necessary
  */
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, pgprot_t newprot, int prot_numa)
+		unsigned long addr, pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *ptl;
 	pmd_t entry;
 	bool preserve_write;
 	int ret;
+	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 
 	ptl = __pmd_trans_huge_lock(pmd, vma);
 	if (!ptl)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 977c641f78cf..2ea6c4c0579a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -598,7 +598,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 {
 	int nr_updated;
 
-	nr_updated = change_protection(vma, addr, end, PAGE_NONE, 0, 1);
+	nr_updated = change_protection(vma, addr, end, PAGE_NONE, MM_CP_PROT_NUMA);
 	if (nr_updated)
 		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7a8e84f86831..1565058ebcfc 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -37,12 +37,14 @@
 
 static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
-		int dirty_accountable, int prot_numa)
+		unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
 	unsigned long pages = 0;
 	int target_node = NUMA_NO_NODE;
+	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
+	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 
 	/*
 	 * Can be called with only the mmap_sem for reading by
@@ -163,7 +165,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -195,7 +197,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
-						newprot, prot_numa);
+							      newprot, cp_flags);
 
 				if (nr_ptes) {
 					if (nr_ptes == HPAGE_PMD_NR) {
@@ -210,7 +212,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			/* fall through, the trans huge pmd just split */
 		}
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+					      cp_flags);
 		pages += this_pages;
 next:
 		cond_resched();
@@ -226,7 +228,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		p4d_t *p4d, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -238,7 +240,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+					  cp_flags);
 	} while (pud++, addr = next, addr != end);
 
 	return pages;
@@ -246,7 +248,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 
 static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		pgd_t *pgd, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -258,7 +260,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(vma, p4d, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+					  cp_flags);
 	} while (p4d++, addr = next, addr != end);
 
 	return pages;
@@ -266,7 +268,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 
 static unsigned long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
-		int dirty_accountable, int prot_numa)
+		unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
@@ -283,7 +285,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(vma, pgd, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+					  cp_flags);
 	} while (pgd++, addr = next, addr != end);
 
 	/* Only flush the TLB if we actually modified any entries: */
@@ -296,14 +298,15 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 
 unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
-		       int dirty_accountable, int prot_numa)
+		       unsigned long cp_flags)
 {
 	unsigned long pages;
 
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot);
 	else
-		pages = change_protection_range(vma, start, end, newprot, dirty_accountable, prot_numa);
+		pages = change_protection_range(vma, start, end, newprot,
+						cp_flags);
 
 	return pages;
 }
@@ -425,7 +428,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	vma_set_page_prot(vma);
 
 	change_protection(vma, start, end, vma->vm_page_prot,
-			  dirty_accountable, 0);
+			  dirty_accountable ? MM_CP_DIRTY_ACCT : 0);
 
 	/*
 	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
-- 
2.24.1

