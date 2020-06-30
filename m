Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22425C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0098D2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgF3COn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:14:43 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47279 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgF3COn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:14:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U16sMPl_1593483280;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U16sMPl_1593483280)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Jun 2020 10:14:40 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     dan.j.williams@intel.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm/sparse: only sub-section aligned range would be populated
Date:   Tue, 30 Jun 2020 10:14:36 +0800
Message-Id: <20200630021436.43281-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two code path which invoke __populate_section_memmap()

  * sparse_init_nid()
  * sparse_add_section()

For both case, we are sure the memory range is sub-section aligned.

  * we pass PAGES_PER_SECTION to sparse_init_nid()
  * we check range by check_pfn_span() before calling
    sparse_add_section()

Also, the counterpart of __populate_section_memmap(), we don't do such
calculation and check since the range is checked by check_pfn_span() in
__remove_pages().

Clear the calculation and check to keep it simple and comply with its
counterpart.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/sparse-vmemmap.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 0db7738d76e9..24b01ebae111 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -247,20 +247,8 @@ int __meminit vmemmap_populate_basepages(unsigned long start,
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
-	unsigned long start;
-	unsigned long end;
-
-	/*
-	 * The minimum granularity of memmap extensions is
-	 * PAGES_PER_SUBSECTION as allocations are tracked in the
-	 * 'subsection_map' bitmap of the section.
-	 */
-	end = ALIGN(pfn + nr_pages, PAGES_PER_SUBSECTION);
-	pfn &= PAGE_SUBSECTION_MASK;
-	nr_pages = end - pfn;
-
-	start = (unsigned long) pfn_to_page(pfn);
-	end = start + nr_pages * sizeof(struct page);
+	unsigned long start = (unsigned long) pfn_to_page(pfn);
+	unsigned long end = start + nr_pages * sizeof(struct page);
 
 	if (vmemmap_populate(start, end, nid, altmap))
 		return NULL;
-- 
2.20.1 (Apple Git-117)

