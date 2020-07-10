Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7067BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A599206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGJA7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:59:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbgGJA7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 20:59:30 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B2835AE0537B2A909B2;
        Fri, 10 Jul 2020 08:59:28 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.26) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 08:59:21 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v4] mm/hugetlb: avoid hardcoding while checking if cma is enabled
Date:   Fri, 10 Jul 2020 12:57:26 +1200
Message-ID: <20200710005726.36068-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.26]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
enabled. gigantic pages might have been reserved on other nodes.
This patch fixes possible double reservation and CMA leak.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 v4: address linux-next issue;
     use hugetlb_cma_size to check if cma is enabled

 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..bc3304af40d0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -46,6 +46,7 @@ unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
 
 static struct cma *hugetlb_cma[MAX_NUMNODES];
+static unsigned long hugetlb_cma_size __initdata;
 
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
@@ -2571,7 +2572,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
+			if (hugetlb_cma_size) {
 				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
 				break;
 			}
@@ -5654,7 +5655,6 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 }
 
 #ifdef CONFIG_CMA
-static unsigned long hugetlb_cma_size __initdata;
 static bool cma_reserve_called __initdata;
 
 static int __init cmdline_parse_hugetlb_cma(char *p)
-- 
2.27.0


