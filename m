Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8B8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5251120658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htbJ0Rtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHSSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:02:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22910 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgHSSAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597860034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SsUQoSxqK3aAaX8fpNt8hR+9F86+Sjska5bDoEWIxPo=;
        b=htbJ0RtkPflskHeWnR9bGLlqF9u0WAzuGojn4VRNNBcWRElscqNoOxyJv5NnQT/NTBvrxx
        GVi6FkDl7yeARKVyoFbNXj4XYs6/wvGW7A9+aD8DPzNwdtB7bxuOifGEVLVbUtQKLhfTnc
        3Nsq7a0Rpgo2UZXmLq+U8h82kX09V0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-z2aFyqVvN0-48qdEPqxD_g-1; Wed, 19 Aug 2020 14:00:32 -0400
X-MC-Unique: z2aFyqVvN0-48qdEPqxD_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED911075605;
        Wed, 19 Aug 2020 18:00:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A423D10013C4;
        Wed, 19 Aug 2020 18:00:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH v2 10/10] mm/memory_hotplug: mark pageblocks MIGRATE_ISOLATE while onlining memory
Date:   Wed, 19 Aug 2020 19:59:57 +0200
Message-Id: <20200819175957.28465-11-david@redhat.com>
In-Reply-To: <20200819175957.28465-1-david@redhat.com>
References: <20200819175957.28465-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, it can happen that pages are allocated (and freed) via the buddy
before we finished basic memory onlining.

For example, pages are exposed to the buddy and can be allocated before
we actually mark the sections online. Allocated pages could suddenly
fail pfn_to_online_page() checks. We had similar issues with pcp
handling, when pages are allocated+freed before we reach
zone_pcp_update() in online_pages() [1].

Instead, mark all pageblocks MIGRATE_ISOLATE, such that allocations are
impossible. Once done with the heavy lifting, use
undo_isolate_page_range() to move the pages to the MIGRATE_MOVABLE
freelist, marking them ready for allocation. Similar to offline_pages(),
we have to manually adjust zone->nr_isolate_pageblock.

[1] https://lkml.kernel.org/r/1597150703-19003-1-git-send-email-charante@codeaurora.org

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Charan Teja Reddy <charante@codeaurora.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig          |  2 +-
 mm/memory_hotplug.c | 32 ++++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 6c974888f86f9..85a16ce1dbc49 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -152,6 +152,7 @@ config HAVE_BOOTMEM_INFO_NODE
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
+	select MEMORY_ISOLATION
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on 64BIT || BROKEN
@@ -178,7 +179,6 @@ config MEMORY_HOTPLUG_DEFAULT_ONLINE
 
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
-	select MEMORY_ISOLATION
 	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
 	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
 	depends on MIGRATION
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1c16a5def781e..35d56cbd3e45b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -805,7 +805,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	/* associate pfn range with the zone */
 	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
-	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_MOVABLE);
+	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
 
 	arg.start_pfn = pfn;
 	arg.nr_pages = nr_pages;
@@ -816,6 +816,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	if (ret)
 		goto failed_addition;
 
+	/*
+	 * Fixup the number of isolated pageblocks before marking the sections
+	 * onlining, such that undo_isolate_page_range() works correctly.
+	 */
+	spin_lock_irqsave(&zone->lock, flags);
+	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
+	spin_unlock_irqrestore(&zone->lock, flags);
+
 	/*
 	 * If this zone is not populated, then it is not in zonelist.
 	 * This means the page allocator ignores this zone.
@@ -833,21 +841,25 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone->zone_pgdat->node_present_pages += nr_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
+	node_states_set_node(nid, &arg);
+	if (need_zonelists_rebuild)
+		build_all_zonelists(NULL);
+	zone_pcp_update(zone);
+
+	/* Basic onlining is complete, allow allocation of onlined pages. */
+	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
+
 	/*
 	 * When exposing larger, physically contiguous memory areas to the
 	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
 	 * them either to the head or the tail of the freelist) is only helpful
 	 * for maintaining the shuffle, but not for creating the initial
 	 * shuffle. Shuffle the whole zone to make sure the just onlined pages
-	 * are properly distributed across the whole freelist.
+	 * are properly distributed across the whole freelist. Make sure to
+	 * shuffle once pageblocks are no longer isolated.
 	 */
 	shuffle_zone(zone);
 
-	node_states_set_node(nid, &arg);
-	if (need_zonelists_rebuild)
-		build_all_zonelists(NULL);
-	zone_pcp_update(zone);
-
 	init_per_zone_wmark_min();
 
 	kswapd_run(nid);
@@ -1550,9 +1562,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	pr_info("Offlined Pages %ld\n", nr_pages);
 
 	/*
-	 * Onlining will reset pagetype flags and makes migrate type
-	 * MOVABLE, so just need to decrease the number of isolated
-	 * pageblocks zone counter here.
+	 * The memory sections are marked offline, and the pageblock flags
+	 * effectively stale; nobody should be touching them. Fixup the number
+	 * of isolated pageblocks, memory onlining will properly revert this.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
-- 
2.26.2

