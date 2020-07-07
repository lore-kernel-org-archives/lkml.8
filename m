Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E9AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7377206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGGEEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:04:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbgGGEEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:04:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CA0DBDA3F0266F168FF6;
        Tue,  7 Jul 2020 12:04:03 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.253) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 12:03:55 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma is enable
Date:   Tue, 7 Jul 2020 16:02:04 +1200
Message-ID: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
enabled. gigantic pages might have been reserved on other nodes.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v3: add acked-by; make code more canonical 

 mm/hugetlb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..d293c823121e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2546,6 +2546,20 @@ static void __init gather_bootmem_prealloc(void)
 	}
 }
 
+bool __init hugetlb_cma_enabled(void)
+{
+#ifdef CONFIG_CMA
+	int node;
+
+	for_each_online_node(node) {
+		if (hugetlb_cma[node])
+			return true;
+	}
+#endif
+
+	return false;
+}
+
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
@@ -2571,7 +2585,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
+			if (hugetlb_cma_enabled()) {
 				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
 				break;
 			}
-- 
2.27.0


