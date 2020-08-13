Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D7CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AB420768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHMKSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:18:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9801 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgHMKSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:18:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BDF048ECFECFBDC7F91F;
        Thu, 13 Aug 2020 18:18:49 +0800 (CST)
Received: from DESKTOP-A9S207P.china.huawei.com (10.174.179.61) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 13 Aug 2020 18:18:41 +0800
From:   <wuyun.wu@huawei.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <hewenliang4@huawei.com>, <hushiyuan@huawei.com>,
        Abel Wu <wuyun.wu@huawei.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/slub: branch optimization in free slowpath
Date:   Thu, 13 Aug 2020 18:18:08 +0800
Message-ID: <20200813101812.1617-1-wuyun.wu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Wu <wuyun.wu@huawei.com>

The two conditions are mutually exclusive and gcc compiler will
optimise this into if-else-like pattern. Given that the majority
of free_slowpath is free_frozen, let's provide some hint to the
compilers.

Tests (perf bench sched messaging -g 20 -l 400000, executed 10x
after reboot) are done and the summarized result:

	un-patched	patched
max.	192.316		189.851
min.	187.267		186.252
avg.	189.154		188.086
stdev.	1.37		0.99

Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
---
 mm/slub.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4f496ae5a820..f9182a760675 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2958,20 +2958,21 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 
 	if (likely(!n)) {
 
-		/*
-		 * If we just froze the page then put it onto the
-		 * per cpu partial list.
-		 */
-		if (new.frozen && !was_frozen) {
+		if (likely(was_frozen)) {
+			/*
+			 * The list lock was not taken therefore no list
+			 * activity can be necessary.
+			 */
+			stat(s, FREE_FROZEN);
+		} else if (new.frozen) {
+			/*
+			 * If we just froze the page then put it onto the
+			 * per cpu partial list.
+			 */
 			put_cpu_partial(s, page, 1);
 			stat(s, CPU_PARTIAL_FREE);
 		}
-		/*
-		 * The list lock was not taken therefore no list
-		 * activity can be necessary.
-		 */
-		if (was_frozen)
-			stat(s, FREE_FROZEN);
+
 		return;
 	}
 
-- 
2.28.0.windows.1

