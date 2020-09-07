Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C56CC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA6A21D1A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgIGQkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:40:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730906AbgIGQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:36:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C425ACB5;
        Mon,  7 Sep 2020 16:36:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 4/5] mm, page_alloc: cache pageset high and batch in struct zone
Date:   Mon,  7 Sep 2020 18:36:27 +0200
Message-Id: <20200907163628.26495-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907163628.26495-1-vbabka@suse.cz>
References: <20200907163628.26495-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All per-cpu pagesets for a zone use the same high and batch values, that are
duplicated there just for performance (locality) reasons. This patch adds the
same variables also to struct zone as 'central' ones.

This will be useful later for making possible to disable pcplists temporarily
by setting high value to 0, while remembering the values for restoring them
later. But we can also immediately benefit from not updating pagesets of all
possible cpus in case the newly recalculated values (after sysctl change or
memory online/offline) are actually unchanged from the previous ones.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8379432f4f2f..15582ca368b9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -431,6 +431,8 @@ struct zone {
 #endif
 	struct pglist_data	*zone_pgdat;
 	struct per_cpu_pageset __percpu *pageset;
+	int pageset_high;
+	int pageset_batch;
 
 #ifndef CONFIG_SPARSEMEM
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a0cab2c6055e..004350a2b6ca 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5834,7 +5834,7 @@ static void build_zonelists(pg_data_t *pgdat)
  * not check if the processor is online before following the pageset pointer.
  * Other parts of the kernel may not check if the zone is available.
  */
-static void setup_pageset(struct per_cpu_pageset *p);
+static void pageset_init(struct per_cpu_pageset *p);
 static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
@@ -6237,7 +6237,7 @@ static void pageset_init(struct per_cpu_pageset *p)
 	pcp->batch  = 1;
 }
 
-static void zone_set_pageset_high_and_batch(struct zone *zone)
+static void zone_set_pageset_high_and_batch(struct zone *zone, bool force_update)
 {
 	unsigned long new_high;
 	unsigned long new_batch;
@@ -6256,6 +6256,14 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
 		new_batch = max(1UL, 1 * new_batch);
 	}
 
+	if (zone->pageset_high != new_high ||
+	    zone->pageset_batch != new_batch) {
+		zone->pageset_high = new_high;
+		zone->pageset_batch = new_batch;
+	} else if (!force_update) {
+		return;
+	}
+
 	for_each_possible_cpu(cpu) {
 		p = per_cpu_ptr(zone->pageset, cpu);
 		pageset_update(&p->pcp, new_high, new_batch);
@@ -6273,7 +6281,7 @@ void __meminit setup_zone_pageset(struct zone *zone)
 		pageset_init(p);
 	}
 
-	zone_set_pageset_high_and_batch(zone);
+	zone_set_pageset_high_and_batch(zone, true);
 }
 
 /*
@@ -8038,7 +8046,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 		goto out;
 
 	for_each_populated_zone(zone)
-		zone_set_pageset_high_and_batch(zone);
+		zone_set_pageset_high_and_batch(zone, false);
 out:
 	mutex_unlock(&pcp_batch_high_lock);
 	return ret;
@@ -8654,7 +8662,7 @@ EXPORT_SYMBOL(free_contig_range);
 void __meminit zone_pcp_update(struct zone *zone)
 {
 	mutex_lock(&pcp_batch_high_lock);
-	zone_set_pageset_high_and_batch(zone);
+	zone_set_pageset_high_and_batch(zone, false);
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-- 
2.28.0

