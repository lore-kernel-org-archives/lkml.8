Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402F4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C78E20724
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgF1Hpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:45:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbgF1Hpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:45:43 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DE430D0BFC732EFC4BD1;
        Sun, 28 Jun 2020 15:45:37 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.102) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 15:45:28 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Aslan Bakirov <aslan@fb.com>, "Roman Gushchin" <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Rik van Riel" <riel@surriel.com>, Joonsoo Kim <js1304@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] mm/cma.c: use exact_nid true to fix possible per-numa cma leak
Date:   Sun, 28 Jun 2020 19:43:45 +1200
Message-ID: <20200628074345.27228-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.102]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling cma_declare_contiguous_nid() with false exact_nid for per-numa
reservation can easily cause cma leak and various confusion.
For example, mm/hugetlb.c is trying to reserve per-numa cma for gigantic
pages. But it can easily leak cma and make users confused when system has
memoryless nodes.

In case the system has 4 numa nodes, and only numa node0 has memory.
if we set hugetlb_cma=4G in bootargs, mm/hugetlb.c will get 4 cma areas
for 4 different numa nodes. since exact_nid=false in current code, all
4 numa nodes will get cma successfully from node0, but hugetlb_cma[1 to 3]
will never be available to hugepage will only allocate memory from
hugetlb_cma[0].

In case the system has 4 numa nodes, both numa node0&2 has memory, other
nodes have no memory.
if we set hugetlb_cma=4G in bootargs, mm/hugetlb.c will get 4 cma areas
for 4 different numa nodes. since exact_nid=false in current code, all
4 numa nodes will get cma successfully from node0 or 2, but hugetlb_cma[1]
and [3] will never be available to hugepage as mm/hugetlb.c will only
allocate memory from hugetlb_cma[0] and hugetlb_cma[2].
This causes permanent leak of the cma areas which are supposed to be
used by memoryless node.

Of cource we can workaround the issue by letting mm/hugetlb.c scan all
cma areas in alloc_gigantic_page() even node_mask includes node0 only.
that means when node_mask includes node0 only, we can get page from
hugetlb_cma[1] to hugetlb_cma[3]. But this will cause kernel crash in
free_gigantic_page() while it wants to free page by:
cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order)

On the other hand, exact_nid=false won't consider numa distance, it
might be not that useful to leverage cma areas on remote nodes.
I feel it is much simpler to make exact_nid true to make everything
clear. After that, memoryless nodes won't be able to reserve per-numa
CMA from other nodes which have memory.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Aslan Bakirov <aslan@fb.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andreas Schaufler <andreas.schaufler@gmx.de>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Joonsoo Kim <js1304@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 mm/cma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index b24151fa2101..f472f398026f 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -338,13 +338,13 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 		 */
 		if (base < highmem_start && limit > highmem_start) {
 			addr = memblock_alloc_range_nid(size, alignment,
-					highmem_start, limit, nid, false);
+					highmem_start, limit, nid, true);
 			limit = highmem_start;
 		}
 
 		if (!addr) {
 			addr = memblock_alloc_range_nid(size, alignment, base,
-					limit, nid, false);
+					limit, nid, true);
 			if (!addr) {
 				ret = -ENOMEM;
 				goto err;
-- 
2.27.0


