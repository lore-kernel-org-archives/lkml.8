Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C06C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0603B20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK7evnOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgFPLwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:52:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50343 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728344AbgFPLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592308352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ugu/lz/Ohiem/N+G3mekJ5cFi/CkmO5XsY98FkVNogA=;
        b=AK7evnOd3/eBlsCi7OydPjn43TJzmXOW5qleDlB1QGdCNDRk8w6qorWuuWbExbh3Zquy/f
        PILZJ0yMXsUhnDPLQQTMT8kSYMeLyDruRiZK4NihBMa04OvZuK/QpZ+kISFqsj8/F8ZCFl
        LTAkjkAWFFdJJmSZo/HNBnr1++uPzm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-3ERa-NW9N6ufK_1HQfPbtg-1; Tue, 16 Jun 2020 07:52:29 -0400
X-MC-Unique: 3ERa-NW9N6ufK_1HQfPbtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D45580F5CD;
        Tue, 16 Jun 2020 11:52:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-106.ams2.redhat.com [10.36.114.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0E087CAC2;
        Tue, 16 Jun 2020 11:52:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v1 2/3] mm/memory_hotplug: don't shuffle complete zone when onlining memory
Date:   Tue, 16 Jun 2020 13:52:12 +0200
Message-Id: <20200616115213.13109-3-david@redhat.com>
In-Reply-To: <20200616115213.13109-1-david@redhat.com>
References: <20200616115213.13109-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e900a918b098 ("mm: shuffle initial free memory to improve
memory-side-cache utilization") introduced shuffling of free pages
during system boot and whenever we online memory blocks.

However, whenever we online memory blocks, all pages that will be
exposed to the buddy end up getting freed via __free_one_page(). In the
general case, we free these pages in MAX_ORDER - 1 chunks, which
corresponds to the shuffle order.

Inside __free_one_page(), we will already shuffle the newly onlined pages
using "to_tail = shuffle_pick_tail();". Drop explicit zone shuffling on
memory hotplug.

Note: When hotplugging a DIMM, each memory block (e.g., 128MB .. 2G on
x86-64) will get onlined individually, resulting in a shuffle_zone() for
every memory block getting onlined.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c |  3 ---
 mm/shuffle.c        |  2 +-
 mm/shuffle.h        | 12 ------------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9b34e03e730a4..845a517649c71 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -40,7 +40,6 @@
 #include <asm/tlbflush.h>
 
 #include "internal.h"
-#include "shuffle.h"
 
 /*
  * online_page_callback contains pointer to current page onlining function.
@@ -822,8 +821,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone->zone_pgdat->node_present_pages += onlined_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
-	shuffle_zone(zone);
-
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
diff --git a/mm/shuffle.c b/mm/shuffle.c
index dd13ab851b3ee..609c26aa57db0 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -180,7 +180,7 @@ void __meminit __shuffle_free_memory(pg_data_t *pgdat)
 	struct zone *z;
 
 	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
-		shuffle_zone(z);
+		__shuffle_zone(z);
 }
 
 bool shuffle_pick_tail(void)
diff --git a/mm/shuffle.h b/mm/shuffle.h
index 4d79f03b6658f..657e2b9ec38dd 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -30,14 +30,6 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
 	__shuffle_free_memory(pgdat);
 }
 
-extern void __shuffle_zone(struct zone *z);
-static inline void shuffle_zone(struct zone *z)
-{
-	if (!static_branch_unlikely(&page_alloc_shuffle_key))
-		return;
-	__shuffle_zone(z);
-}
-
 static inline bool is_shuffle_order(int order)
 {
 	if (!static_branch_unlikely(&page_alloc_shuffle_key))
@@ -54,10 +46,6 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
 {
 }
 
-static inline void shuffle_zone(struct zone *z)
-{
-}
-
 static inline void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
 {
 }
-- 
2.26.2

