Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B15C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B192920826
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2YWVWIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgGCNjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:39:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35416 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726048AbgGCNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFIJGKtM6VwVokH8Ga5bRfXr8MdIFlAYKMZ3yizveMM=;
        b=A2YWVWIR6mqhBBTmBggn1T165/WXjBpoXh/juY0WB3RjGSVKwA3Y/Y5f2bY2LvF5rFCEgI
        DjKtRA7vd04ebteWbJ4/SqBDbFkGkgfBsE/k/136223vJ9TtfagwPGlwRTgSg7M6yEfeAr
        yUD1TfXdUuuk687OU8jv6rA+5mbGJB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-dtpxDSbmOoW9xbObZr_6Xw-1; Fri, 03 Jul 2020 09:39:35 -0400
X-MC-Unique: dtpxDSbmOoW9xbObZr_6Xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B609107ACCA;
        Fri,  3 Jul 2020 13:39:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7943271690;
        Fri,  3 Jul 2020 13:39:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1 6/9] s390/vmem: cleanup empty page tables
Date:   Fri,  3 Jul 2020 15:39:14 +0200
Message-Id: <20200703133917.39045-7-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's cleanup empty page tables. Consider only page tables that fully
fall into the idendity mapping and the vmemmap range.

As there are no valid accesses to vmem/vmemmap within non-populated ranges,
the single tlb flush at the end should be sufficient.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 98 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index aa968f67d7f9f..5239130770b7b 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -63,6 +63,15 @@ pte_t __ref *vmem_pte_alloc(void)
 	return pte;
 }
 
+static void vmem_pte_free(unsigned long *table)
+{
+	/* We don't expect boot memory to be removed ever. */
+	if (!slab_is_available() ||
+	    WARN_ON_ONCE(PageReserved(virt_to_page(table))))
+		return;
+	page_table_free(&init_mm, table);
+}
+
 /*
  * Add a physical memory range to the 1:1 mapping.
  */
@@ -168,6 +177,21 @@ static void remove_pte_table(pmd_t *pmd, unsigned long addr,
 		update_page_count(PG_DIRECT_MAP_4K, -pages);
 }
 
+static void try_free_pte_table(pmd_t *pmd, unsigned long start)
+{
+	pte_t *pte;
+	int i;
+
+	/* We can safely assume this is fully in 1:1 mapping & vmemmap area */
+	pte = pte_offset_kernel(pmd, start);
+	for (i = 0; i < PTRS_PER_PTE; i++, pte++)
+		if (!pte_none(*pte))
+			return;
+
+	vmem_pte_free(__va(pmd_deref(*pmd)));
+	pmd_clear(pmd);
+}
+
 static void remove_pmd_table(pud_t *pud, unsigned long addr,
 			     unsigned long end, bool direct)
 {
@@ -194,12 +218,36 @@ static void remove_pmd_table(pud_t *pud, unsigned long addr,
 		}
 
 		remove_pte_table(pmd, addr, next, direct);
+		try_free_pte_table(pmd, addr & PMD_MASK);
 	}
 
 	if (direct)
 		update_page_count(PG_DIRECT_MAP_1M, -pages);
 }
 
+static void try_free_pmd_table(pud_t *pud, unsigned long start)
+{
+	const unsigned long end = start + PUD_SIZE;
+	pmd_t *pmd;
+	int i;
+
+	/* Don't mess with any tables not fully in 1:1 mapping & vmemmap area */
+	if (end > VMALLOC_START)
+		return;
+#ifdef CONFIG_KASAN
+	if (start < KASAN_SHADOW_END && KASAN_SHADOW_START > end)
+		return;
+#endif
+
+	pmd = pmd_offset(pud, start);
+	for (i = 0; i < PTRS_PER_PMD; i++, pmd++)
+		if (!pmd_none(*pmd))
+			return;
+
+	vmem_free_pages(pud_deref(*pud), CRST_ALLOC_ORDER);
+	pud_clear(pud);
+}
+
 static void remove_pud_table(p4d_t *p4d, unsigned long addr,
 			     unsigned long end, bool direct)
 {
@@ -224,12 +272,36 @@ static void remove_pud_table(p4d_t *p4d, unsigned long addr,
 		}
 
 		remove_pmd_table(pud, addr, next, direct);
+		try_free_pmd_table(pud, addr & PUD_MASK);
 	}
 
 	if (direct)
 		update_page_count(PG_DIRECT_MAP_2G, -pages);
 }
 
+static void try_free_pud_table(p4d_t *p4d, unsigned long start)
+{
+	const unsigned long end = start + P4D_SIZE;
+	pud_t *pud;
+	int i;
+
+	/* Don't mess with any tables not fully in 1:1 mapping & vmemmap area */
+	if (end > VMALLOC_START)
+		return;
+#ifdef CONFIG_KASAN
+	if (start < KASAN_SHADOW_END && KASAN_SHADOW_START > end)
+		return;
+#endif
+
+	pud = pud_offset(p4d, start);
+	for (i = 0; i < PTRS_PER_PUD; i++, pud++)
+		if (!pud_none(*pud))
+			return;
+
+	vmem_free_pages(p4d_deref(*p4d), CRST_ALLOC_ORDER);
+	p4d_clear(p4d);
+}
+
 static void remove_p4d_table(pgd_t *pgd, unsigned long addr,
 			     unsigned long end, bool direct)
 {
@@ -244,9 +316,33 @@ static void remove_p4d_table(pgd_t *pgd, unsigned long addr,
 			continue;
 
 		remove_pud_table(p4d, addr, next, direct);
+		try_free_pud_table(p4d, addr & P4D_MASK);
 	}
 }
 
+static void try_free_p4d_table(pgd_t *pgd, unsigned long start)
+{
+	const unsigned long end = start + PGDIR_SIZE;
+	p4d_t *p4d;
+	int i;
+
+	/* Don't mess with any tables not fully in 1:1 mapping & vmemmap area */
+	if (end > VMALLOC_START)
+		return;
+#ifdef CONFIG_KASAN
+	if (start < KASAN_SHADOW_END && KASAN_SHADOW_START > end)
+		return;
+#endif
+
+	p4d = p4d_offset(pgd, start);
+	for (i = 0; i < PTRS_PER_P4D; i++, p4d++)
+		if (!p4d_none(*p4d))
+			return;
+
+	vmem_free_pages(pgd_deref(*pgd), CRST_ALLOC_ORDER);
+	pgd_clear(pgd);
+}
+
 static void remove_pagetable(unsigned long start, unsigned long end,
 			     bool direct)
 {
@@ -264,6 +360,7 @@ static void remove_pagetable(unsigned long start, unsigned long end,
 			continue;
 
 		remove_p4d_table(pgd, addr, next, direct);
+		try_free_p4d_table(pgd, addr & PGDIR_MASK);
 	}
 
 	flush_tlb_kernel_range(start, end);
@@ -271,7 +368,6 @@ static void remove_pagetable(unsigned long start, unsigned long end,
 
 /*
  * Remove a physical memory range from the 1:1 mapping.
- * Currently only invalidates page table entries.
  */
 static void vmem_remove_range(unsigned long start, unsigned long size)
 {
-- 
2.26.2

