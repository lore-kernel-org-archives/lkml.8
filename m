Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC8C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89252206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOup0pfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgHSKMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbgHSKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597831938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5BwOp0hs0cGirzCiMB7Wivc0LM0Y2eMEhvclJKfJbc=;
        b=dOup0pfWn1TFaW8cbinhXscCwarjSpdecGqTj1yC+nrm+RWTAZ0ST254TZjWSktAGdHyqS
        PgI4PgumUY5rSE4fkchujDaQpAgYolQKxU5fWSaJK4maSZ+WLFEPssghT2/NauQ2iZBffN
        vRkcNwqKJM5HpCj2Jyl4A3JutZH1eL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-hE5cNfm8NKCqttB_B-pqRQ-1; Wed, 19 Aug 2020 06:12:16 -0400
X-MC-Unique: hE5cNfm8NKCqttB_B-pqRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC934800466;
        Wed, 19 Aug 2020 10:12:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0277E16597;
        Wed, 19 Aug 2020 10:12:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 04/11] mm/memory_hotplug: simplify offlining of pages in offline_pages()
Date:   Wed, 19 Aug 2020 12:11:50 +0200
Message-Id: <20200819101157.12723-5-david@redhat.com>
In-Reply-To: <20200819101157.12723-1-david@redhat.com>
References: <20200819101157.12723-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We make sure that we cannot have any memory holes right at the beginning
of offline_pages(). We no longer need walk_system_ram_range() and can
call __offline_isolated_pages() directly.

offlined_pages always corresponds to nr_pages, so we can simplify that.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f64478349148d..50aa5df696e9d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1373,17 +1373,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	return ret;
 }
 
-/* Mark all sections offline and remove all free pages from the buddy. */
-static int
-offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
-			void *data)
-{
-	unsigned long *offlined_pages = (unsigned long *)data;
-
-	*offlined_pages += __offline_isolated_pages(start, start + nr_pages);
-	return 0;
-}
-
 static int __init cmdline_parse_movable_node(char *p)
 {
 	movable_node_enabled = true;
@@ -1470,7 +1459,7 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn, system_ram_pages = 0, offlined_pages = 0;
+	unsigned long pfn, system_ram_pages = 0;
 	int ret, node, nr_isolate_pageblock;
 	unsigned long flags;
 	struct zone *zone;
@@ -1570,11 +1559,10 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		}
 	} while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
 
-	/* Ok, all of our target is isolated.
-	   We cannot do rollback at this point. */
-	walk_system_ram_range(start_pfn, end_pfn - start_pfn,
-			      &offlined_pages, offline_isolated_pages_cb);
-	pr_info("Offlined Pages %ld\n", offlined_pages);
+	/* Mark all sections offline and remove free pages from the buddy. */
+	__offline_isolated_pages(start_pfn, end_pfn);
+	pr_info("Offlined Pages %ld\n", nr_pages);
+
 	/*
 	 * Onlining will reset pagetype flags and makes migrate type
 	 * MOVABLE, so just need to decrease the number of isolated
@@ -1585,11 +1573,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	/* removal success */
-	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
-	zone->present_pages -= offlined_pages;
+	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+	zone->present_pages -= nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
-	zone->zone_pgdat->node_present_pages -= offlined_pages;
+	zone->zone_pgdat->node_present_pages -= nr_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
 	init_per_zone_wmark_min();
-- 
2.26.2

