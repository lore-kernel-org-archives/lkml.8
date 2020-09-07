Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E066AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A616D2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgIGQma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:42:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:41660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbgIGQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:36:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31D97B019;
        Mon,  7 Sep 2020 16:36:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 3/5] mm, page_alloc(): remove setup_pageset()
Date:   Mon,  7 Sep 2020 18:36:26 +0200
Message-Id: <20200907163628.26495-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907163628.26495-1-vbabka@suse.cz>
References: <20200907163628.26495-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We initialize boot-time pagesets with setup_pageset(), which sets high and
batch values that effectively disable pcplists.

We can remove this wrapper if we just set these values for all pagesets in
pageset_init(). Non-boot pagesets then subsequently update them to specific
values.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f669a251f654..a0cab2c6055e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5902,7 +5902,7 @@ build_all_zonelists_init(void)
 	 * (a chicken-egg dilemma).
 	 */
 	for_each_possible_cpu(cpu)
-		setup_pageset(&per_cpu(boot_pageset, cpu));
+		pageset_init(&per_cpu(boot_pageset, cpu));
 
 	mminit_verify_zonelist();
 	cpuset_init_current_mems_allowed();
@@ -6228,12 +6228,13 @@ static void pageset_init(struct per_cpu_pageset *p)
 	pcp = &p->pcp;
 	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++)
 		INIT_LIST_HEAD(&pcp->lists[migratetype]);
-}
 
-static void setup_pageset(struct per_cpu_pageset *p)
-{
-	pageset_init(p);
-	pageset_update(&p->pcp, 0, 1);
+	/*
+	 * Set batch and high values safe for a boot pageset. Proper pageset's
+	 * initialization will update them.
+	 */
+	pcp->high = 0;
+	pcp->batch  = 1;
 }
 
 static void zone_set_pageset_high_and_batch(struct zone *zone)
-- 
2.28.0

