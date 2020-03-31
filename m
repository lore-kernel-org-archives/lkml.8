Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4592EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206AC20757
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgCaFKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:10:51 -0400
Received: from foss.arm.com ([217.140.110.172]:43708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgCaFKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:10:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F354B1FB;
        Mon, 30 Mar 2020 22:10:49 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA48B3F71E;
        Mon, 30 Mar 2020 22:10:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     robin.murphy@arm.com, dan.j.williams@intel.com, jglisse@redhat.com,
        jgg@mellanox.com, rcampbell@nvidia.com, aneesh.kumar@linux.ibm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] mm/sparsemem: Enable vmem_altmap support in vmemmap_alloc_block_buf()
Date:   Tue, 31 Mar 2020 10:39:46 +0530
Message-Id: <1585631387-18819-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585631387-18819-1-git-send-email-anshuman.khandual@arm.com>
References: <1585631387-18819-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many instances where vmemap allocation is often switched between
regular memory and device memory just based on whether altmap is available
or not. vmemmap_alloc_block_buf() is used in various platforms to allocate
vmemmap mappings. Lets also enable it to handle altmap based device memory
allocation along with existing regular memory allocations. This will help
in avoiding the altmap based allocation switch in many places.

While here also implement a regular memory allocation fallback mechanism
when the first preferred device memory allocation fails. This will ensure
preserving the existing semantics on powerpc platform. To summarize there
are three different methods to call vmemmap_alloc_block_buf().

(., NULL,   false) /* Allocate from system RAM */
(., altmap, false) /* Allocate from altmap without any fallback */
(., altmap, true)  /* Allocate from altmap with fallback (system RAM) */

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c       |  3 ++-
 arch/powerpc/mm/init_64.c | 10 +++++-----
 arch/x86/mm/init_64.c     |  6 ++----
 include/linux/mm.h        |  3 ++-
 mm/sparse-vmemmap.c       | 30 ++++++++++++++++++++++++------
 5 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2feed38106d6..81f88c88484f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1063,7 +1063,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		if (pmd_none(READ_ONCE(*pmdp))) {
 			void *p = NULL;
 
-			p = vmemmap_alloc_block_buf(PMD_SIZE, node);
+			p = vmemmap_alloc_block_buf(PMD_SIZE, node,
+						    NULL, false);
 			if (!p)
 				return -ENOMEM;
 
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 4002ced3596f..f67f2b909fe5 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -226,12 +226,12 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		 * fall back to system memory if the altmap allocation fail.
 		 */
 		if (altmap && !altmap_cross_boundary(altmap, start, page_size)) {
-			p = altmap_alloc_block_buf(page_size, altmap);
-			if (!p)
-				pr_debug("altmap block allocation failed, falling back to system memory");
+			p = vmemmap_alloc_block_buf(page_size, node,
+						    altmap, true);
+		} else {
+			p = vmemmap_alloc_block_buf(page_size, node,
+						    NULL, false);
 		}
-		if (!p)
-			p = vmemmap_alloc_block_buf(page_size, node);
 		if (!p)
 			return -ENOMEM;
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index c22677571619..35cc0c9d9578 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1444,10 +1444,8 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 		if (pmd_none(*pmd)) {
 			void *p;
 
-			if (altmap)
-				p = altmap_alloc_block_buf(PMD_SIZE, altmap);
-			else
-				p = vmemmap_alloc_block_buf(PMD_SIZE, node);
+			p = vmemmap_alloc_block_buf(PMD_SIZE, node,
+						    altmap, false);
 			if (p) {
 				pte_t entry;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 955be0331833..b8d3d90c9c47 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2991,7 +2991,8 @@ pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 			    struct vmem_altmap *altmap);
 void *vmemmap_alloc_block(unsigned long size, int node);
 struct vmem_altmap;
-void *vmemmap_alloc_block_buf(unsigned long size, int node);
+void *vmemmap_alloc_block_buf(unsigned long size, int node,
+			      struct vmem_altmap *altmap, bool sysram_fallback);
 void *altmap_alloc_block_buf(unsigned long size, struct vmem_altmap *altmap);
 void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
 int vmemmap_populate_basepages(unsigned long start, unsigned long end,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a407abc9b46c..ff5adc233e38 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -71,10 +71,31 @@ void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 }
 
 /* need to make sure size is all the same during early stage */
-void * __meminit vmemmap_alloc_block_buf(unsigned long size, int node)
+void * __meminit vmemmap_alloc_block_buf(unsigned long size, int node,
+					 struct vmem_altmap *altmap,
+					 bool sysram_fallback)
 {
-	void *ptr = sparse_buffer_alloc(size);
+	void *ptr;
 
+	/*
+	 * There is no point in asking for sysram fallback
+	 * without an altmap request to begin with. So just
+	 * warn here to catch potential call sites that may
+	 * be violating this.
+	 */
+	WARN_ON(!altmap && sysram_fallback);
+
+	if (altmap) {
+		ptr = altmap_alloc_block_buf(size, altmap);
+		if (ptr)
+			return ptr;
+		pr_debug("altmap block allocation failed\n");
+		if (!sysram_fallback)
+			return NULL;
+		pr_debug("falling back to system memory\n");
+	}
+
+	ptr = sparse_buffer_alloc(size);
 	if (!ptr)
 		ptr = vmemmap_alloc_block(size, node);
 	return ptr;
@@ -148,10 +169,7 @@ pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 		pte_t entry;
 		void *p;
 
-		if (altmap)
-			p = altmap_alloc_block_buf(PAGE_SIZE, altmap);
-		else
-			p = vmemmap_alloc_block_buf(PAGE_SIZE, node);
+		p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap, false);
 		if (!p)
 			return NULL;
 		entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
-- 
2.20.1

