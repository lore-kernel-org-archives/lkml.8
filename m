Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C490DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCA52080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbgFWMmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:42:22 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39158 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729504AbgFWMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:42:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U0VwpCq_1592916133;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0VwpCq_1592916133)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 20:42:13 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mgorman@suse.de, akpm@linux-foundation.org,
        richard.weiyang@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm/page_alloc.c: remove unnecessary end_bitidx for [set|get]_pfnblock_flags_mask()
Date:   Tue, 23 Jun 2020 20:42:01 +0800
Message-Id: <20200623124201.8199-4-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200623124201.8199-1-richard.weiyang@linux.alibaba.com>
References: <20200623124201.8199-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After previous cleanup, the end_bitidx is not necessary any more.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/mmzone.h          |  3 +--
 include/linux/pageblock-flags.h |  8 +++-----
 mm/page_alloc.c                 | 15 +++++----------
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index eeb0da54ff5f..e55dd385c422 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -91,8 +91,7 @@ extern int page_group_by_mobility_disabled;
 #define MIGRATETYPE_MASK ((1UL << PB_migratetype_bits) - 1)
 
 #define get_pageblock_migratetype(page)					\
-	get_pfnblock_flags_mask(page, page_to_pfn(page),		\
-			PB_migrate_end, MIGRATETYPE_MASK)
+	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
 
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 6556e4474409..fff52ad370c1 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -56,27 +56,25 @@ struct page;
 
 unsigned long get_pfnblock_flags_mask(struct page *page,
 				unsigned long pfn,
-				unsigned long end_bitidx,
 				unsigned long mask);
 
 void set_pfnblock_flags_mask(struct page *page,
 				unsigned long flags,
 				unsigned long pfn,
-				unsigned long end_bitidx,
 				unsigned long mask);
 
 /* Declarations for getting and setting flags. See mm/page_alloc.c */
 #ifdef CONFIG_COMPACTION
 #define get_pageblock_skip(page) \
 	get_pfnblock_flags_mask(page, page_to_pfn(page),	\
-			PB_migrate_skip, (1 << (PB_migrate_skip)))
+			(1 << (PB_migrate_skip)))
 #define clear_pageblock_skip(page) \
 	set_pfnblock_flags_mask(page, 0, page_to_pfn(page),	\
-			PB_migrate_skip, (1 << PB_migrate_skip))
+			(1 << PB_migrate_skip))
 #define set_pageblock_skip(page) \
 	set_pfnblock_flags_mask(page, (1 << PB_migrate_skip),	\
 			page_to_pfn(page),			\
-			PB_migrate_skip, (1 << PB_migrate_skip))
+			(1 << PB_migrate_skip))
 #else
 static inline bool get_pageblock_skip(struct page *page)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9da416eec284..dabec744ceff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -469,14 +469,13 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
  * get_pfnblock_flags_mask - Return the requested group of flags for the pageblock_nr_pages block of pages
  * @page: The page within the block of interest
  * @pfn: The target page frame number
- * @end_bitidx: The last bit of interest to retrieve
  * @mask: mask of bits that the caller is interested in
  *
  * Return: pageblock_bits flags
  */
-static __always_inline unsigned long __get_pfnblock_flags_mask(struct page *page,
+static __always_inline
+unsigned long __get_pfnblock_flags_mask(struct page *page,
 					unsigned long pfn,
-					unsigned long end_bitidx,
 					unsigned long mask)
 {
 	unsigned long *bitmap;
@@ -493,15 +492,14 @@ static __always_inline unsigned long __get_pfnblock_flags_mask(struct page *page
 }
 
 unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
-					unsigned long end_bitidx,
 					unsigned long mask)
 {
-	return __get_pfnblock_flags_mask(page, pfn, end_bitidx, mask);
+	return __get_pfnblock_flags_mask(page, pfn, mask);
 }
 
 static __always_inline int get_pfnblock_migratetype(struct page *page, unsigned long pfn)
 {
-	return __get_pfnblock_flags_mask(page, pfn, PB_migrate_end, MIGRATETYPE_MASK);
+	return __get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
 }
 
 /**
@@ -509,12 +507,10 @@ static __always_inline int get_pfnblock_migratetype(struct page *page, unsigned
  * @page: The page within the block of interest
  * @flags: The flags to set
  * @pfn: The target page frame number
- * @end_bitidx: The last bit of interest
  * @mask: mask of bits that the caller is interested in
  */
 void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 					unsigned long pfn,
-					unsigned long end_bitidx,
 					unsigned long mask)
 {
 	unsigned long *bitmap;
@@ -550,8 +546,7 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
 		migratetype = MIGRATE_UNMOVABLE;
 
 	set_pfnblock_flags_mask(page, (unsigned long)migratetype,
-				page_to_pfn(page), PB_migrate_end,
-				MIGRATETYPE_MASK);
+				page_to_pfn(page), MIGRATETYPE_MASK);
 }
 
 #ifdef CONFIG_DEBUG_VM
-- 
2.20.1 (Apple Git-117)

