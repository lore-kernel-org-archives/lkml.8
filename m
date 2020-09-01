Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9C7C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6430C2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIAGa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:30:59 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50413 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgIAGa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:30:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U7VD5SL_1598941853;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7VD5SL_1598941853)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 14:30:53 +0800
Subject: Re: [PATCH v3 3/3] mm/armv6: work around armv6 cmpxchg support issue
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Russell King <linux@armlinux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598928612-68996-3-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <ffa89b09-995a-77d8-03c6-2c1234a5474a@linux.alibaba.com>
Date:   Tue, 1 Sep 2020 14:30:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1598928612-68996-3-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seems there are couples archs can not do cmpxchg1
So update the patch here. And it's easy to fix if more arch issue find here.

From cdf98ae7b5e83bb7210c927d4749f62fee4ed115 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Mon, 31 Aug 2020 15:41:20 +0800
Subject: [PATCH v4 3/3] mm/pageblock: work around multiple arch's cmpxchg
 support issue

Armv6, sh2, sparc32 and xtensa can not do cmpxchg1, so we have to use
cmpxchg4 on it.

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
 include/linux/mmzone.h | 20 +++++++++++++++++---
 mm/page_alloc.c        | 24 ++++++++++++------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index be676e659fb7..364b29ed99b3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -406,6 +406,20 @@ enum zone_type {
 
 #ifndef __GENERATING_BOUNDS_H
 
+/*
+ * cmpxchg only support 32-bits operands on the following archs ARMv6, SPARC32
+ * sh2, XTENSA.
+ */
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_SH2) || \
+	defined(CONFIG_SPARC32) || defined(CONFIG_XTENSA)
+
+#define BITS_PER_FLAGS	BITS_PER_LONG
+typedef unsigned long pageblockflags_t;
+#else
+#define BITS_PER_FLAGS	BITS_PER_BYTE
+typedef unsigned char pageblockflags_t;
+#endif
+
 struct zone {
 	/* Read-mostly fields */
 
@@ -437,7 +451,7 @@ struct zone {
 	 * Flags for a pageblock_nr_pages block. See pageblock-flags.h.
 	 * In SPARSEMEM, this map is stored in struct mem_section
 	 */
-	unsigned char		*pageblock_flags;
+	pageblockflags_t	*pageblock_flags;
 #endif /* CONFIG_SPARSEMEM */
 
 	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
@@ -1159,7 +1173,7 @@ struct mem_section_usage {
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
 	/* See declaration of similar field in struct zone */
-	unsigned char	pageblock_flags[0];
+	pageblockflags_t	pageblock_flags[0];
 };
 
 void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
@@ -1212,7 +1226,7 @@ struct mem_section {
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

