Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1620C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C3B207EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgIACug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:50:36 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1660 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgIACuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:50:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U7Txrtg_1598928621;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7Txrtg_1598928621)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 10:50:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Russell King <linux@armlinux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/3] mm/armv6: work around armv6 cmpxchg support issue
Date:   Tue,  1 Sep 2020 10:50:12 +0800
Message-Id: <1598928612-68996-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armv6 can not simulate cmpxchg1 func, so we have to use cmpxchg4 on it.

   arm-linux-gnueabi-ld: mm/page_alloc.o: in function `set_pfnblock_flags_mask':
   (.text+0x32b4): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld: (.text+0x32e0): undefined reference to `__bad_cmpxchg'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 include/linux/mmzone.h | 15 ++++++++++++---
 mm/page_alloc.c        | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index be676e659fb7..4c91ca807473 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -406,6 +406,15 @@ enum zone_type {
 
 #ifndef __GENERATING_BOUNDS_H
 
+/* cmpxchg only support 32-bits operands on ARMv6. */
+#ifdef CONFIG_CPU_V6
+#define BITS_PER_FLAGS	BITS_PER_LONG
+typedef unsigned long pageblockflags_t;
+#else
+#define BITS_PER_FLAGS	BITS_PER_BYTE
+typedef unsigned char pageblockflags_t;
+#endif
+
 struct zone {
 	/* Read-mostly fields */
 
@@ -437,7 +446,7 @@ struct zone {
 	 * Flags for a pageblock_nr_pages block. See pageblock-flags.h.
 	 * In SPARSEMEM, this map is stored in struct mem_section
 	 */
-	unsigned char		*pageblock_flags;
+	pageblockflags_t	*pageblock_flags;
 #endif /* CONFIG_SPARSEMEM */
 
 	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
@@ -1159,7 +1168,7 @@ struct mem_section_usage {
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
 	/* See declaration of similar field in struct zone */
-	unsigned char	pageblock_flags[0];
+	pageblockflags_t	pageblock_flags[0];
 };
 
 void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
@@ -1212,7 +1221,7 @@ struct mem_section {
 extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
 #endif
 
-static inline unsigned char *section_to_usemap(struct mem_section *ms)
+static inline pageblockflags_t *section_to_usemap(struct mem_section *ms)
 {
 	return ms->usage->pageblock_flags;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 60342e764090..9a41c5dc78eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -445,7 +445,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 #endif
 
 /* Return a pointer to the bitmap storing bits affecting a block of pages */
-static inline unsigned char *get_pageblock_bitmap(struct page *page,
+static inline pageblockflags_t *get_pageblock_bitmap(struct page *page,
 							unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
@@ -474,24 +474,24 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
  * Return: pageblock_bits flags
  */
 static __always_inline
-unsigned char __get_pfnblock_flags_mask(struct page *page,
+pageblockflags_t __get_pfnblock_flags_mask(struct page *page,
 					unsigned long pfn,
 					unsigned long mask)
 {
-	unsigned char *bitmap;
+	pageblockflags_t *bitmap;
 	unsigned long bitidx, byte_bitidx;
-	unsigned char byte;
+	pageblockflags_t byte;
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
-	byte_bitidx = bitidx / BITS_PER_BYTE;
-	bitidx &= (BITS_PER_BYTE-1);
+	byte_bitidx = bitidx / BITS_PER_FLAGS;
+	bitidx &= (BITS_PER_FLAGS - 1);
 
 	byte = bitmap[byte_bitidx];
 	return (byte >> bitidx) & mask;
 }
 
-unsigned char get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
+pageblockflags_t get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
 					unsigned long mask)
 {
 	return __get_pfnblock_flags_mask(page, pfn, mask);
@@ -513,17 +513,17 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 					unsigned long pfn,
 					unsigned long mask)
 {
-	unsigned char *bitmap;
+	pageblockflags_t *bitmap;
 	unsigned long bitidx, byte_bitidx;
-	unsigned char old_byte, byte;
+	pageblockflags_t old_byte, byte;
 
-	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != BITS_PER_BYTE);
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != BITS_PER_FLAGS);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
-	byte_bitidx = bitidx / BITS_PER_BYTE;
-	bitidx &= (BITS_PER_BYTE-1);
+	byte_bitidx = bitidx / BITS_PER_FLAGS;
+	bitidx &= (BITS_PER_FLAGS - 1);
 
 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
-- 
1.8.3.1

