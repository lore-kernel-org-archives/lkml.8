Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514CCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B038206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwjV6pMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGCNjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:39:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39639 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726639AbgGCNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCIRYR9/1d5bZJoKL7hVEPxQR00IAiq+8x7oR+04P3o=;
        b=cwjV6pMgueXK9XCxDzYjno9jOVEQuVO1H/tpDZwxHNayZAy10FTgMpAQ/9YbCzQm2wfh33
        ixAbMxFHC7DBltM8PszUXi7vnEgCDbwKIqG8p1EsETJmkdXnujCOQNy4Vrj5hLEX+t3D6D
        o9NMBinxjDcrr0lbz9Y8Jo9ldcC5n0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-BuXHMa5yNOmYPHT6lB03KA-1; Fri, 03 Jul 2020 09:39:39 -0400
X-MC-Unique: BuXHMa5yNOmYPHT6lB03KA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8817107ACF5;
        Fri,  3 Jul 2020 13:39:37 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55ADB71690;
        Fri,  3 Jul 2020 13:39:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1 8/9] s390/vmemmap: remember unused sub-pmd ranges
Date:   Fri,  3 Jul 2020 15:39:16 +0200
Message-Id: <20200703133917.39045-9-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a memmap size of 56 bytes or 72 bytes per page, the memmap for a
256 MB section won't span full PMDs. As we populate single sections and
depopulate single sections, the depopulation step would not be able to
free all vmemmap pmds anymore.

Do it similarly to x86, marking the unused memmap ranges in a special way
(pad it with 0xFD).

This allows us to add/remove sections, cleaning up all allocated
vmemmap pages even if the memmap size is not multiple of 16 bytes per page.

A 56 byte memmap can, for example, be created with !CONFIG_MEMCG and
!CONFIG_SLUB.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b7fdb9536707f..a981ff5d47223 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -72,6 +72,42 @@ static void vmem_pte_free(unsigned long *table)
 	page_table_free(&init_mm, table);
 }
 
+#define PAGE_UNUSED 0xFD
+
+static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+{
+	/*
+	 * As we expect to add in the same granularity as we remove, it's
+	 * sufficient to mark only some piece used to block the memmap page from
+	 * getting removed (just in case the memmap never gets initialized,
+	 * e.g., because the memory block never gets onlined).
+	 */
+	memset(__va(start), 0, sizeof(struct page));
+}
+
+static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
+{
+	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
+
+	/* Could be our memmap page is filled with PAGE_UNUSED already ... */
+	vmemmap_use_sub_pmd(start, end);
+
+	/* Mark the unused parts of the new memmap page PAGE_UNUSED. */
+	if (!IS_ALIGNED(start, PMD_SIZE))
+		memset(page, PAGE_UNUSED, start - __pa(page));
+	if (!IS_ALIGNED(end, PMD_SIZE))
+		memset(__va(end), PAGE_UNUSED, __pa(page) + PMD_SIZE - end);
+}
+
+/* Returns true if the PMD is completely unused and can be freed. */
+static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
+{
+	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
+
+	memset(__va(start), PAGE_UNUSED, end - start);
+	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
+}
+
 /*
  * Add a physical memory range to the 1:1 mapping.
  */
@@ -213,6 +249,11 @@ static void remove_pmd_table(pud_t *pud, unsigned long addr,
 							get_order(PMD_SIZE));
 				pmd_clear(pmd);
 				pages++;
+			} else if (!direct &&
+				   vmemmap_unuse_sub_pmd(addr, next)) {
+				vmem_free_pages(pmd_deref(*pmd),
+						get_order(PMD_SIZE));
+				pmd_clear(pmd);
 			}
 			continue;
 		}
@@ -381,7 +422,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
 	unsigned long pgt_prot, sgt_prot;
-	unsigned long address = start;
+	unsigned long next, address = start;
 	pgd_t *pg_dir;
 	p4d_t *p4_dir;
 	pud_t *pu_dir;
@@ -425,16 +466,27 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		if (pmd_none(*pm_dir) && MACHINE_HAS_EDAT1) {
 			void *new_page;
 
-			/* Use 1MB frames for vmemmap if available. We always
+			/*
+			 * Use 1MB frames for vmemmap if available. We always
 			 * use large frames even if they are only partially
-			 * used.
+			 * used, and mark the unused parts using PAGE_UNUSED.
+			 *
+			 * This is only an issue in some setups. E.g.,
+			 * a full sections with 64 byte memmap per page need
+			 * 4 MB in total. However, with 56 byte, it's 3.5 MB.
+			 *
 			 * Otherwise we would have also page tables since
 			 * vmemmap_populate gets called for each section
-			 * separately. */
+			 * separately.
+			 */
 			new_page = vmemmap_alloc_block(PMD_SIZE, node);
 			if (new_page) {
 				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;
-				address = (address + PMD_SIZE) & PMD_MASK;
+				next = pmd_addr_end(address, end);
+				if (!IS_ALIGNED(next, PMD_SIZE) ||
+				    !IS_ALIGNED(address, PMD_SIZE))
+					vmemmap_use_new_sub_pmd(address, next);
+				address = next;
 				continue;
 			}
 		}
@@ -444,7 +496,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 				goto out;
 			pmd_populate(&init_mm, pm_dir, pt_dir);
 		} else if (pmd_large(*pm_dir)) {
-			address = (address + PMD_SIZE) & PMD_MASK;
+			next = pmd_addr_end(address, end);
+			vmemmap_use_sub_pmd(address, next);
+			address = next;
 			continue;
 		}
 
-- 
2.26.2

