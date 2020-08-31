Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1927C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FEA2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHaIk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:40:58 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:37162 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgHaIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:40:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U7NNbUi_1598863253;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7NNbUi_1598863253)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 16:40:54 +0800
Subject: Re: [PATCH v2 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <8ec2a4b0-9e51-abf9-fa7a-29989d3f1fac@arm.com>
 <01c846d4-2fe4-eeef-6c79-e71fda1f9a39@linux.alibaba.com>
 <20200830101823.GY14765@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <f9c303f3-4d99-a1c6-636e-81755f125920@linux.alibaba.com>
Date:   Mon, 31 Aug 2020 16:40:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200830101823.GY14765@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/8/30 ÏÂÎç6:18, Matthew Wilcox Ð´µÀ:
> On Sun, Aug 30, 2020 at 06:14:33PM +0800, Alex Shi wrote:
>> +++ b/mm/page_alloc.c
>> @@ -532,9 +536,18 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>>  	mask <<= bitidx;
>>  	flags <<= bitidx;
>>  
>> +#ifdef	CONFIG_CPU_V6
>> +	byte = (unsigned long)READ_ONCE(bitmap[byte_bitidx]);
>> +#else
>>  	byte = READ_ONCE(bitmap[byte_bitidx]);
>> +#endif
>>  	for (;;) {
>> +#ifdef	CONFIG_CPU_V6
>> +		/* arm v6 has no cmpxchgb function, so still false sharing long word */
>> +		old_byte = cmpxchg((unsigned long*)&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
>> +#else
>>  		old_byte = cmpxchg(&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
>> +#endif
> 
> Good grief, no.  Either come up with an appropriate abstraction or
> abandon this patch.  We can't possibly put this kind of ifdef in the
> memory allocator!
> 

Hi Matthew,

Thanks a lot for comments! How about the following patch?

From 5f61b91351461084c5bb410025965a3b4d2f7206 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Mon, 31 Aug 2020 15:41:20 +0800
Subject: [PATCH 3/3] mm/armv6: work around armv6 cmpxchg support issue

Armv6 can not simulate cmpxchg1 func, so we have to use cmpxchg4 on it.

   arm-linux-gnueabi-ld: mm/page_alloc.o: in function `set_pfnblock_flags_mask':
   (.text+0x32b4): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld: (.text+0x32e0): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld:drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.o: in function
   `hw_atl_b0_get_mac_temp':   hw_atl_b0.c:(.text+0x30fc): undefined reference to `__bad_udelay'

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
index be676e659fb7..c1bb904bcad8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -406,6 +406,15 @@ enum zone_type {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#ifdef CONFIG_CPU_V6
+/* cmpxchg only support 32-bits operands on ARMv6. */
+typedef unsigned long pageblockflags_t;
+#define BITS_PER_FLAGS	BITS_PER_LONG
+#else
+typedef unsigned char pageblockflags_t;
+#define BITS_PER_FLAGS	BITS_PER_BYTE
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

