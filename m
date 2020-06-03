Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D85206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgFCImM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:42:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5847 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbgFCImL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:42:11 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 11FBF637D0B8783E79BB;
        Wed,  3 Jun 2020 16:42:09 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.66) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 3 Jun 2020 16:41:58 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <guro@fb.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 1/2] mm: cma: fix the name of CMA areas
Date:   Wed, 3 Jun 2020 20:40:24 +1200
Message-ID: <20200603084025.62740-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
References: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if users give a name saved in stack, the current code will generate magic
pointer.
if users don't give a name(NULL), kasprintf() will always return NULL as
we are at the early stage. that means cma_init_reserved_mem() will return
-ENOMEM if users set name parameter as NULL.

Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 mm/cma.c | 13 ++++++-------
 mm/cma.h |  4 +++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 0463ad2ce06b..b24151fa2101 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -202,13 +202,12 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	 * subsystems (like slab allocator) are available.
 	 */
 	cma = &cma_areas[cma_area_count];
-	if (name) {
-		cma->name = name;
-	} else {
-		cma->name = kasprintf(GFP_KERNEL, "cma%d\n", cma_area_count);
-		if (!cma->name)
-			return -ENOMEM;
-	}
+
+	if (name)
+		snprintf(cma->name, CMA_MAX_NAME, name);
+	else
+		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
+
 	cma->base_pfn = PFN_DOWN(base);
 	cma->count = size >> PAGE_SHIFT;
 	cma->order_per_bit = order_per_bit;
diff --git a/mm/cma.h b/mm/cma.h
index 33c0b517733c..27d3f0e9f68f 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -2,6 +2,8 @@
 #ifndef __MM_CMA_H__
 #define __MM_CMA_H__
 
+#define CMA_MAX_NAME 64
+
 struct cma {
 	unsigned long   base_pfn;
 	unsigned long   count;
@@ -12,7 +14,7 @@ struct cma {
 	struct hlist_head mem_head;
 	spinlock_t mem_head_lock;
 #endif
-	const char *name;
+	char name[CMA_MAX_NAME];
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
-- 
2.23.0


