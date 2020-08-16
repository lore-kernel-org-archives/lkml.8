Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFCFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 03:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9CF2065C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 03:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgHPDsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 23:48:10 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48824 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbgHPDsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 23:48:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5s0mT9_1597549686;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5s0mT9_1597549686)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Aug 2020 11:48:07 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/pageblock: mitigation cmpxchg false sharing in pageblock flags
Date:   Sun, 16 Aug 2020 11:47:56 +0800
Message-Id: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pageblock_flags is used as long, since every pageblock_flags is just 4
bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
flags. It would cause long waiting for sync.

If we could change the pageblock_flags variable as char, we could use
char size cmpxchg, which just sync up with 2 pageblock flags. it could
relief much false sharing in cmpxchg.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mmzone.h          |  6 +++---
 include/linux/pageblock-flags.h |  2 +-
 mm/page_alloc.c                 | 24 +++++++++++++-----------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0ed520954843..c92d6d24527d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -438,7 +438,7 @@ struct zone {
 	 * Flags for a pageblock_nr_pages block. See pageblock-flags.h.
 	 * In SPARSEMEM, this map is stored in struct mem_section
 	 */
-	unsigned long		*pageblock_flags;
+	unsigned char		*pageblock_flags;
 #endif /* CONFIG_SPARSEMEM */
 
 	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
@@ -1159,7 +1159,7 @@ struct mem_section_usage {
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
 	/* See declaration of similar field in struct zone */
-	unsigned long pageblock_flags[0];
+	unsigned char	pageblock_flags[0];
 };
 
 void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
@@ -1212,7 +1212,7 @@ struct mem_section {
 extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
 #endif
 
-static inline unsigned long *section_to_usemap(struct mem_section *ms)
+static inline unsigned char *section_to_usemap(struct mem_section *ms)
 {
 	return ms->usage->pageblock_flags;
 }
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index fff52ad370c1..d189441568eb 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -54,7 +54,7 @@ enum pageblock_bits {
 /* Forward declaration */
 struct page;
 
-unsigned long get_pfnblock_flags_mask(struct page *page,
+unsigned char get_pfnblock_flags_mask(struct page *page,
 				unsigned long pfn,
 				unsigned long mask);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 66d45e9cc358..142803d1f49b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -447,7 +447,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 #endif
 
 /* Return a pointer to the bitmap storing bits affecting a block of pages */
-static inline unsigned long *get_pageblock_bitmap(struct page *page,
+static inline unsigned char *get_pageblock_bitmap(struct page *page,
 							unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
@@ -467,6 +467,8 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
 	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
 }
 
+#define BITS_PER_CHAR	8
+
 /**
  * get_pfnblock_flags_mask - Return the requested group of flags for the pageblock_nr_pages block of pages
  * @page: The page within the block of interest
@@ -476,24 +478,24 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
  * Return: pageblock_bits flags
  */
 static __always_inline
-unsigned long __get_pfnblock_flags_mask(struct page *page,
+unsigned char __get_pfnblock_flags_mask(struct page *page,
 					unsigned long pfn,
 					unsigned long mask)
 {
-	unsigned long *bitmap;
+	unsigned char *bitmap;
 	unsigned long bitidx, word_bitidx;
-	unsigned long word;
+	unsigned char word;
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
-	word_bitidx = bitidx / BITS_PER_LONG;
-	bitidx &= (BITS_PER_LONG-1);
+	word_bitidx = bitidx / BITS_PER_CHAR;
+	bitidx &= (BITS_PER_CHAR-1);
 
 	word = bitmap[word_bitidx];
 	return (word >> bitidx) & mask;
 }
 
-unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
+unsigned char get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
 					unsigned long mask)
 {
 	return __get_pfnblock_flags_mask(page, pfn, mask);
@@ -515,17 +517,17 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 					unsigned long pfn,
 					unsigned long mask)
 {
-	unsigned long *bitmap;
+	unsigned char *bitmap;
 	unsigned long bitidx, word_bitidx;
-	unsigned long old_word, word;
+	unsigned char old_word, word;
 
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
-	word_bitidx = bitidx / BITS_PER_LONG;
-	bitidx &= (BITS_PER_LONG-1);
+	word_bitidx = bitidx / BITS_PER_CHAR;
+	bitidx &= (BITS_PER_CHAR-1);
 
 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
-- 
1.8.3.1

