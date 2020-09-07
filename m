Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78425C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4887320639
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgIGQki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:40:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:41684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730908AbgIGQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:36:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3200BB01D;
        Mon,  7 Sep 2020 16:36:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 1/5] mm, page_alloc: clean up pageset high and batch update
Date:   Mon,  7 Sep 2020 18:36:24 +0200
Message-Id: <20200907163628.26495-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907163628.26495-1-vbabka@suse.cz>
References: <20200907163628.26495-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The updates to pcplists' high and batch valued are handled by multiple
functions that make the calculations hard to follow. Consolidate everything
to pageset_set_high_and_batch() and remove pageset_set_batch() and
pageset_set_high() wrappers.

The only special case using one of the removed wrappers was:
build_all_zonelists_init()
  setup_pageset()
    pageset_set_batch()
which was hardcoding batch as 0, so we can just open-code a call to
pageset_update() with constant parameters instead.

No functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 51 +++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..0b516208afda 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5834,7 +5834,7 @@ static void build_zonelists(pg_data_t *pgdat)
  * not check if the processor is online before following the pageset pointer.
  * Other parts of the kernel may not check if the zone is available.
  */
-static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch);
+static void setup_pageset(struct per_cpu_pageset *p);
 static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
@@ -5902,7 +5902,7 @@ build_all_zonelists_init(void)
 	 * (a chicken-egg dilemma).
 	 */
 	for_each_possible_cpu(cpu)
-		setup_pageset(&per_cpu(boot_pageset, cpu), 0);
+		setup_pageset(&per_cpu(boot_pageset, cpu));
 
 	mminit_verify_zonelist();
 	cpuset_init_current_mems_allowed();
@@ -6218,12 +6218,6 @@ static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
 	pcp->batch = batch;
 }
 
-/* a companion to pageset_set_high() */
-static void pageset_set_batch(struct per_cpu_pageset *p, unsigned long batch)
-{
-	pageset_update(&p->pcp, 6 * batch, max(1UL, 1 * batch));
-}
-
 static void pageset_init(struct per_cpu_pageset *p)
 {
 	struct per_cpu_pages *pcp;
@@ -6236,35 +6230,30 @@ static void pageset_init(struct per_cpu_pageset *p)
 		INIT_LIST_HEAD(&pcp->lists[migratetype]);
 }
 
-static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
+static void setup_pageset(struct per_cpu_pageset *p)
 {
 	pageset_init(p);
-	pageset_set_batch(p, batch);
-}
-
-/*
- * pageset_set_high() sets the high water mark for hot per_cpu_pagelist
- * to the value high for the pageset p.
- */
-static void pageset_set_high(struct per_cpu_pageset *p,
-				unsigned long high)
-{
-	unsigned long batch = max(1UL, high / 4);
-	if ((high / 4) > (PAGE_SHIFT * 8))
-		batch = PAGE_SHIFT * 8;
-
-	pageset_update(&p->pcp, high, batch);
+	pageset_update(&p->pcp, 0, 1);
 }
 
 static void pageset_set_high_and_batch(struct zone *zone,
-				       struct per_cpu_pageset *pcp)
+				       struct per_cpu_pageset *p)
 {
-	if (percpu_pagelist_fraction)
-		pageset_set_high(pcp,
-			(zone_managed_pages(zone) /
-				percpu_pagelist_fraction));
-	else
-		pageset_set_batch(pcp, zone_batchsize(zone));
+	unsigned long new_high;
+	unsigned long new_batch;
+	int fraction = READ_ONCE(percpu_pagelist_fraction);
+
+	if (fraction) {
+		new_high = zone_managed_pages(zone) / fraction;
+		new_batch = max(1UL, new_high / 4);
+		if ((new_high / 4) > (PAGE_SHIFT * 8))
+			new_batch = PAGE_SHIFT * 8;
+	} else {
+		new_batch = zone_batchsize(zone);
+		new_high = 6 * new_batch;
+		new_batch = max(1UL, 1 * new_batch);
+	}
+	pageset_update(&p->pcp, new_high, new_batch);
 }
 
 static void __meminit zone_pageset_init(struct zone *zone, int cpu)
-- 
2.28.0

