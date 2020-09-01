Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2692C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF252083E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIACu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:50:26 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33885 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgIACu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:50:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U7Txrtg_1598928621;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7Txrtg_1598928621)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 10:50:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 2/3] mm/pageblock: remove false sharing in pageblock_flags
Date:   Tue,  1 Sep 2020 10:50:11 +0800
Message-Id: <1598928612-68996-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current pageblock_flags is only 4 bits, so it has to share a char size
in cmpxchg when get set, the false sharing cause perf drop.

If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
the only cost is half char per pageblock, which is half char per 128MB
on x86, 4 chars in 1 GB.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/pageblock-flags.h | 2 +-
 mm/page_alloc.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index d189441568eb..f785c9d6d68c 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -25,7 +25,7 @@ enum pageblock_bits {
 	 * Assume the bits will always align on a word. If this assumption
 	 * changes then get/set pageblock needs updating.
 	 */
-	NR_PAGEBLOCK_BITS
+	NR_PAGEBLOCK_BITS = BITS_PER_BYTE
 };
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 81e96d4d9c42..60342e764090 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -517,7 +517,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	unsigned long bitidx, byte_bitidx;
 	unsigned char old_byte, byte;
 
-	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != BITS_PER_BYTE);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
-- 
1.8.3.1

