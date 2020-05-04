Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968FFC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F01206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEDFYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 01:24:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:26822 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgEDFYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 01:24:18 -0400
IronPort-SDR: 8SAkRLyIZefCcBECzWIHxMr2SowRue5B1HN7yxR79shIeQhLRjs4PZjiYDYjetSAOr3tuKSrlM
 qk7tadh/MKVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 22:24:18 -0700
IronPort-SDR: NzvbNRHq6UBAlopwxxgTn8DqRhO3MZ+WvXLnxag1GcYjgoWzoU8q73WIVYyrSRLbwVzFSf9jpH
 S9ORNEppR9Sg==
X-IronPort-AV: E=Sophos;i="5.73,350,1583222400"; 
   d="scan'208";a="433985282"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 22:24:18 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 2/2] parisc/kmap: Remove duplicate kmap code
Date:   Sun,  3 May 2020 22:24:15 -0700
Message-Id: <20200504052415.984585-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200504052415.984585-1-ira.weiny@intel.com>
References: <20200504052415.984585-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

parisc reimplements the kmap calls except to flush it's dcache.  This is
arguably an abuse of kmap but regardless it is messy and confusing.

Remove the duplicate code and have parisc define
ARCH_HAS_FLUSH_ON_KUNMAP for a kunmap_flush_on_unmap() architecture
specific call to flush the cache.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/parisc/include/asm/cacheflush.h | 28 ++--------------------------
 include/linux/highmem.h              | 10 +++++++---
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 119c9a7681bc..99663fc1f997 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -100,35 +100,11 @@ flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vma
 	}
 }
 
-#include <asm/kmap_types.h>
-
-#define ARCH_HAS_KMAP
-
-static inline void *kmap(struct page *page)
-{
-	might_sleep();
-	return page_address(page);
-}
-
-static inline void kunmap(struct page *page)
-{
-	flush_kernel_dcache_page_addr(page_address(page));
-}
-
-static inline void *kmap_atomic(struct page *page)
-{
-	preempt_disable();
-	pagefault_disable();
-	return page_address(page);
-}
-
-static inline void kunmap_atomic_high(void *addr)
+#define ARCH_HAS_FLUSH_ON_KUNMAP
+static inline void kunmap_flush_on_unmap(void *addr)
 {
 	flush_kernel_dcache_page_addr(addr);
 }
 
-#define kmap_atomic_prot(page, prot)	kmap_atomic(page)
-#define kmap_atomic_pfn(pfn)	kmap_atomic(pfn_to_page(pfn))
-
 #endif /* _PARISC_CACHEFLUSH_H */
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 89838306f50d..cc0c3904e501 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -129,7 +129,6 @@ static inline struct page *kmap_to_page(void *addr)
 
 static inline unsigned long totalhigh_pages(void) { return 0UL; }
 
-#ifndef ARCH_HAS_KMAP
 static inline void *kmap(struct page *page)
 {
 	might_sleep();
@@ -138,6 +137,9 @@ static inline void *kmap(struct page *page)
 
 static inline void kunmap(struct page *page)
 {
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(page_address(page));
+#endif
 }
 
 static inline void *kmap_atomic(struct page *page)
@@ -150,14 +152,16 @@ static inline void *kmap_atomic(struct page *page)
 
 static inline void kunmap_atomic_high(void *addr)
 {
-	/* Nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
+	/* Mostly nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
 	 * handles re-enabling faults + preemption */
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(addr);
+#endif
 }
 
 #define kmap_atomic_pfn(pfn)	kmap_atomic(pfn_to_page(pfn))
 
 #define kmap_flush_unused()	do {} while(0)
-#endif
 
 #endif /* CONFIG_HIGHMEM */
 
-- 
2.25.1

