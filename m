Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D4C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672F9207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgIGQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:42:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:41658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730907AbgIGQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:36:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D9AAB012;
        Mon,  7 Sep 2020 16:36:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 2/5] mm, page_alloc: calculate pageset high and batch once per zone
Date:   Mon,  7 Sep 2020 18:36:25 +0200
Message-Id: <20200907163628.26495-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907163628.26495-1-vbabka@suse.cz>
References: <20200907163628.26495-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently call pageset_set_high_and_batch() for each possible cpu,
which repeats the same calculations of high and batch values.

Instead call it once per zone, and it applies the calculated values
to all per-cpu pagesets of the zone.

This also allows removing zone_pageset_init() and __zone_pcp_update() wrappers.

No functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0b516208afda..f669a251f654 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6236,12 +6236,13 @@ static void setup_pageset(struct per_cpu_pageset *p)
 	pageset_update(&p->pcp, 0, 1);
 }
 
-static void pageset_set_high_and_batch(struct zone *zone,
-				       struct per_cpu_pageset *p)
+static void zone_set_pageset_high_and_batch(struct zone *zone)
 {
 	unsigned long new_high;
 	unsigned long new_batch;
 	int fraction = READ_ONCE(percpu_pagelist_fraction);
+	int cpu;
+	struct per_cpu_pageset *p;
 
 	if (fraction) {
 		new_high = zone_managed_pages(zone) / fraction;
@@ -6253,23 +6254,25 @@ static void pageset_set_high_and_batch(struct zone *zone,
 		new_high = 6 * new_batch;
 		new_batch = max(1UL, 1 * new_batch);
 	}
-	pageset_update(&p->pcp, new_high, new_batch);
-}
-
-static void __meminit zone_pageset_init(struct zone *zone, int cpu)
-{
-	struct per_cpu_pageset *pcp = per_cpu_ptr(zone->pageset, cpu);
 
-	pageset_init(pcp);
-	pageset_set_high_and_batch(zone, pcp);
+	for_each_possible_cpu(cpu) {
+		p = per_cpu_ptr(zone->pageset, cpu);
+		pageset_update(&p->pcp, new_high, new_batch);
+	}
 }
 
 void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
+	struct per_cpu_pageset *p;
+
 	zone->pageset = alloc_percpu(struct per_cpu_pageset);
-	for_each_possible_cpu(cpu)
-		zone_pageset_init(zone, cpu);
+	for_each_possible_cpu(cpu) {
+		p = per_cpu_ptr(zone->pageset, cpu);
+		pageset_init(p);
+	}
+
+	zone_set_pageset_high_and_batch(zone);
 }
 
 /*
@@ -8002,15 +8005,6 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-static void __zone_pcp_update(struct zone *zone)
-{
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu)
-		pageset_set_high_and_batch(zone,
-				per_cpu_ptr(zone->pageset, cpu));
-}
-
 /*
  * percpu_pagelist_fraction - changes the pcp->high for each zone on each
  * cpu.  It is the fraction of total pages in each zone that a hot per cpu
@@ -8043,7 +8037,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 		goto out;
 
 	for_each_populated_zone(zone)
-		__zone_pcp_update(zone);
+		zone_set_pageset_high_and_batch(zone);
 out:
 	mutex_unlock(&pcp_batch_high_lock);
 	return ret;
@@ -8659,7 +8653,7 @@ EXPORT_SYMBOL(free_contig_range);
 void __meminit zone_pcp_update(struct zone *zone)
 {
 	mutex_lock(&pcp_batch_high_lock);
-	__zone_pcp_update(zone);
+	zone_set_pageset_high_and_batch(zone);
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-- 
2.28.0

