Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B0EC433ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA9D207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfSXm92Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbgGVJqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:46:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730296AbgGVJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595411177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWmEAvMtLRyW6FumWRnQu4/MKfqp+8W/Vm8/HZZxPNw=;
        b=TfSXm92Z6eiRDu9MKXWaGWOw9ATq9bCiU+OfrgP0Vj/AAUzE2EALlqyUEWyyJk3ZQRtho7
        OgCJJGgC+h5AtICsmDcbHhSWq3N5fr9oM30wjYfJYBATrgHON+oJcSdXjhL5kL0t38f+Xb
        i4503QHcP9xnH5rc6ugSk0+2On8W5a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-yaQxaWZaPFusHwhA634BYw-1; Wed, 22 Jul 2020 05:46:13 -0400
X-MC-Unique: yaQxaWZaPFusHwhA634BYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 610DF18C63C1;
        Wed, 22 Jul 2020 09:46:12 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-254.ams2.redhat.com [10.36.113.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B14165D9CA;
        Wed, 22 Jul 2020 09:46:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v2 3/9] s390/vmemmap: extend modify_pagetable() to handle vmemmap
Date:   Wed, 22 Jul 2020 11:45:52 +0200
Message-Id: <20200722094558.9828-4-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend our shiny new modify_pagetable() to handle !direct (vmemmap)
mappings. Convert vmemmap_populate() and implement vmemmap_free().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 181 +++++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 105 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 177daf389d391..43fe1e2eb90ea 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -29,6 +29,15 @@ static void __ref *vmem_alloc_pages(unsigned int order)
 	return (void *) memblock_phys_alloc(size, size);
 }
 
+static void vmem_free_pages(unsigned long addr, int order)
+{
+	/* We don't expect boot memory to be removed ever. */
+	if (!slab_is_available() ||
+	    WARN_ON_ONCE(PageReserved(phys_to_page(addr))))
+		return;
+	free_pages(addr, order);
+}
+
 void *vmem_crst_alloc(unsigned long val)
 {
 	unsigned long *table;
@@ -54,10 +63,12 @@ pte_t __ref *vmem_pte_alloc(void)
 	return pte;
 }
 
-static void modify_pte_table(pmd_t *pmd, unsigned long addr, unsigned long end,
-			    bool add)
+/* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
+static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
+				  unsigned long end, bool add, bool direct)
 {
 	unsigned long prot, pages = 0;
+	int ret = -ENOMEM;
 	pte_t *pte;
 
 	prot = pgprot_val(PAGE_KERNEL);
@@ -69,20 +80,34 @@ static void modify_pte_table(pmd_t *pmd, unsigned long addr, unsigned long end,
 		if (!add) {
 			if (pte_none(*pte))
 				continue;
+			if (!direct)
+				vmem_free_pages(pfn_to_phys(pte_pfn(*pte)), 0);
 			pte_clear(&init_mm, addr, pte);
 		} else if (pte_none(*pte)) {
-			pte_val(*pte) = addr | prot;
+			if (!direct) {
+				void *new_page = vmemmap_alloc_block(PAGE_SIZE,
+								     NUMA_NO_NODE);
+
+				if (!new_page)
+					goto out;
+				pte_val(*pte) = __pa(new_page) | prot;
+			} else
+				pte_val(*pte) = addr | prot;
 		} else
 			continue;
 
 		pages++;
 	}
-
-	update_page_count(PG_DIRECT_MAP_4K, add ? pages : -pages);
+	ret = 0;
+out:
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_4K, add ? pages : -pages);
+	return ret;
 }
 
-static int modify_pmd_table(pud_t *pud, unsigned long addr, unsigned long end,
-			    bool add)
+/* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
+static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
+				  unsigned long end, bool add, bool direct)
 {
 	unsigned long next, prot, pages = 0;
 	int ret = -ENOMEM;
@@ -103,6 +128,9 @@ static int modify_pmd_table(pud_t *pud, unsigned long addr, unsigned long end,
 			if (pmd_large(*pmd) && !add) {
 				if (IS_ALIGNED(addr, PMD_SIZE) &&
 				    IS_ALIGNED(next, PMD_SIZE)) {
+					if (!direct)
+						vmem_free_pages(pmd_deref(*pmd),
+								get_order(PMD_SIZE));
 					pmd_clear(pmd);
 					pages++;
 				}
@@ -111,11 +139,27 @@ static int modify_pmd_table(pud_t *pud, unsigned long addr, unsigned long end,
 		} else if (pmd_none(*pmd)) {
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE) &&
-			    MACHINE_HAS_EDAT1 && addr &&
+			    MACHINE_HAS_EDAT1 && addr && direct &&
 			    !debug_pagealloc_enabled()) {
 				pmd_val(*pmd) = addr | prot;
 				pages++;
 				continue;
+			} else if (!direct && MACHINE_HAS_EDAT1) {
+				void *new_page;
+
+				/*
+				 * Use 1MB frames for vmemmap if available. We
+				 * always use large frames even if they are only
+				 * partially used. Otherwise we would have also
+				 * page tables since vmemmap_populate gets
+				 * called for each section separately.
+				 */
+				new_page = vmemmap_alloc_block(PMD_SIZE,
+							       NUMA_NO_NODE);
+				if (!new_page)
+					goto out;
+				pmd_val(*pmd) = __pa(new_page) | prot;
+				continue;
 			}
 			pte = vmem_pte_alloc();
 			if (!pte)
@@ -124,16 +168,19 @@ static int modify_pmd_table(pud_t *pud, unsigned long addr, unsigned long end,
 		} else if (pmd_large(*pmd))
 			continue;
 
-		modify_pte_table(pmd, addr, next, add);
+		ret = modify_pte_table(pmd, addr, next, add, direct);
+		if (ret)
+			goto out;
 	}
 	ret = 0;
 out:
-	update_page_count(PG_DIRECT_MAP_1M, add ? pages : -pages);
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_1M, add ? pages : -pages);
 	return ret;
 }
 
 static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
-			    bool add)
+			    bool add, bool direct)
 {
 	unsigned long next, prot, pages = 0;
 	int ret = -ENOMEM;
@@ -162,7 +209,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 		} else if (pud_none(*pud)) {
 			if (IS_ALIGNED(addr, PUD_SIZE) &&
 			    IS_ALIGNED(next, PUD_SIZE) &&
-			    MACHINE_HAS_EDAT2 && addr &&
+			    MACHINE_HAS_EDAT2 && addr && direct &&
 			    !debug_pagealloc_enabled()) {
 				pud_val(*pud) = addr | prot;
 				pages++;
@@ -175,18 +222,19 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 		} else if (pud_large(*pud))
 			continue;
 
-		ret = modify_pmd_table(pud, addr, next, add);
+		ret = modify_pmd_table(pud, addr, next, add, direct);
 		if (ret)
 			goto out;
 	}
 	ret = 0;
 out:
-	update_page_count(PG_DIRECT_MAP_2G, add ? pages : -pages);
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_2G, add ? pages : -pages);
 	return ret;
 }
 
 static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
-			    bool add)
+			    bool add, bool direct)
 {
 	unsigned long next;
 	int ret = -ENOMEM;
@@ -206,7 +254,7 @@ static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 				goto out;
 		}
 
-		ret = modify_pud_table(p4d, addr, next, add);
+		ret = modify_pud_table(p4d, addr, next, add, direct);
 		if (ret)
 			goto out;
 	}
@@ -215,7 +263,8 @@ static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return ret;
 }
 
-static int modify_pagetable(unsigned long start, unsigned long end, bool add)
+static int modify_pagetable(unsigned long start, unsigned long end, bool add,
+			    bool direct)
 {
 	unsigned long addr, next;
 	int ret = -ENOMEM;
@@ -239,7 +288,7 @@ static int modify_pagetable(unsigned long start, unsigned long end, bool add)
 			pgd_populate(&init_mm, pgd, p4d);
 		}
 
-		ret = modify_p4d_table(pgd, addr, next, add);
+		ret = modify_p4d_table(pgd, addr, next, add, direct);
 		if (ret)
 			goto out;
 	}
@@ -250,14 +299,14 @@ static int modify_pagetable(unsigned long start, unsigned long end, bool add)
 	return ret;
 }
 
-static int add_pagetable(unsigned long start, unsigned long end)
+static int add_pagetable(unsigned long start, unsigned long end, bool direct)
 {
-	return modify_pagetable(start, end, true);
+	return modify_pagetable(start, end, true, direct);
 }
 
-static int remove_pagetable(unsigned long start, unsigned long end)
+static int remove_pagetable(unsigned long start, unsigned long end, bool direct)
 {
-	return modify_pagetable(start, end, false);
+	return modify_pagetable(start, end, false, direct);
 }
 
 /*
@@ -265,7 +314,7 @@ static int remove_pagetable(unsigned long start, unsigned long end)
  */
 static int vmem_add_range(unsigned long start, unsigned long size)
 {
-	return add_pagetable(start, start + size);
+	return add_pagetable(start, start + size, true);
 }
 
 /*
@@ -274,7 +323,7 @@ static int vmem_add_range(unsigned long start, unsigned long size)
  */
 static void vmem_remove_range(unsigned long start, unsigned long size)
 {
-	remove_pagetable(start, start + size);
+	remove_pagetable(start, start + size, true);
 }
 
 /*
@@ -283,92 +332,14 @@ static void vmem_remove_range(unsigned long start, unsigned long size)
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-	unsigned long pgt_prot, sgt_prot;
-	unsigned long address = start;
-	pgd_t *pg_dir;
-	p4d_t *p4_dir;
-	pud_t *pu_dir;
-	pmd_t *pm_dir;
-	pte_t *pt_dir;
-	int ret = -ENOMEM;
-
-	pgt_prot = pgprot_val(PAGE_KERNEL);
-	sgt_prot = pgprot_val(SEGMENT_KERNEL);
-	if (!MACHINE_HAS_NX) {
-		pgt_prot &= ~_PAGE_NOEXEC;
-		sgt_prot &= ~_SEGMENT_ENTRY_NOEXEC;
-	}
-	for (address = start; address < end;) {
-		pg_dir = pgd_offset_k(address);
-		if (pgd_none(*pg_dir)) {
-			p4_dir = vmem_crst_alloc(_REGION2_ENTRY_EMPTY);
-			if (!p4_dir)
-				goto out;
-			pgd_populate(&init_mm, pg_dir, p4_dir);
-		}
-
-		p4_dir = p4d_offset(pg_dir, address);
-		if (p4d_none(*p4_dir)) {
-			pu_dir = vmem_crst_alloc(_REGION3_ENTRY_EMPTY);
-			if (!pu_dir)
-				goto out;
-			p4d_populate(&init_mm, p4_dir, pu_dir);
-		}
-
-		pu_dir = pud_offset(p4_dir, address);
-		if (pud_none(*pu_dir)) {
-			pm_dir = vmem_crst_alloc(_SEGMENT_ENTRY_EMPTY);
-			if (!pm_dir)
-				goto out;
-			pud_populate(&init_mm, pu_dir, pm_dir);
-		}
-
-		pm_dir = pmd_offset(pu_dir, address);
-		if (pmd_none(*pm_dir)) {
-			/* Use 1MB frames for vmemmap if available. We always
-			 * use large frames even if they are only partially
-			 * used.
-			 * Otherwise we would have also page tables since
-			 * vmemmap_populate gets called for each section
-			 * separately. */
-			if (MACHINE_HAS_EDAT1) {
-				void *new_page;
-
-				new_page = vmemmap_alloc_block(PMD_SIZE, node);
-				if (!new_page)
-					goto out;
-				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;
-				address = (address + PMD_SIZE) & PMD_MASK;
-				continue;
-			}
-			pt_dir = vmem_pte_alloc();
-			if (!pt_dir)
-				goto out;
-			pmd_populate(&init_mm, pm_dir, pt_dir);
-		} else if (pmd_large(*pm_dir)) {
-			address = (address + PMD_SIZE) & PMD_MASK;
-			continue;
-		}
-
-		pt_dir = pte_offset_kernel(pm_dir, address);
-		if (pte_none(*pt_dir)) {
-			void *new_page;
-
-			new_page = vmemmap_alloc_block(PAGE_SIZE, node);
-			if (!new_page)
-				goto out;
-			pte_val(*pt_dir) = __pa(new_page) | pgt_prot;
-		}
-		address += PAGE_SIZE;
-	}
-	ret = 0;
-out:
-	return ret;
+	/* We don't care about the node, just use NUMA_NO_NODE on allocations */
+	return add_pagetable(start, end, false);
 }
 
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+	remove_pagetable(start, end, false);
 }
 
 void vmem_remove_mapping(unsigned long start, unsigned long size)
-- 
2.26.2

