Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD1C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30722082F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZCJDahz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgDGNyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:54:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728966AbgDGNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586267674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zia2yEK0ULLs2OuWDK7UiIqrQbcauP8f06twBGLL674=;
        b=ZZCJDahzTbojWHq9UpOF/eHGzunXZ4uXg3Wddwr2MHzCLL1Dzu1fjy1ne7uYwBy3xryNVN
        LO8AzEjHvk1RipcCHvkifpjHy++wa5oRTciYfzppq8Um7//6w1W/RpLd7d++D3xZHmEUbf
        24dVg+/0iYNGXsVE8UetdAc1kp1GTHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-K2B4E7D6O9uQfRouXt9wUA-1; Tue, 07 Apr 2020 09:54:30 -0400
X-MC-Unique: K2B4E7D6O9uQfRouXt9wUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F18019057A6;
        Tue,  7 Apr 2020 13:54:29 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB0847E303;
        Tue,  7 Apr 2020 13:54:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 2/2] mm/memory_hotplug: remove is_mem_section_removable()
Date:   Tue,  7 Apr 2020 15:54:16 +0200
Message-Id: <20200407135416.24093-3-david@redhat.com>
In-Reply-To: <20200407135416.24093-1-david@redhat.com>
References: <20200407135416.24093-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fortunately, all users of is_mem_section_removable() are gone. Get rid of
it, including some now unnecessary functions.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h |  7 ----
 mm/memory_hotplug.c            | 75 ----------------------------------
 2 files changed, 82 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index 93d9ada74ddd..7dca9cd6076b 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -314,19 +314,12 @@ static inline void pgdat_resize_init(struct pglist_=
data *pgdat) {}
=20
 #ifdef CONFIG_MEMORY_HOTREMOVE
=20
-extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr=
_pages);
 extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages=
);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
=20
 #else
-static inline bool is_mem_section_removable(unsigned long pfn,
-					unsigned long nr_pages)
-{
-	return false;
-}
-
 static inline void try_offline_node(int nid) {}
=20
 static inline int offline_pages(unsigned long start_pfn, unsigned long n=
r_pages)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 47cf6036eb31..4d338d546d52 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1112,81 +1112,6 @@ int add_memory(int nid, u64 start, u64 size)
 EXPORT_SYMBOL_GPL(add_memory);
=20
 #ifdef CONFIG_MEMORY_HOTREMOVE
-/*
- * A free page on the buddy free lists (not the per-cpu lists) has PageB=
uddy
- * set and the size of the free page is given by page_order(). Using thi=
s,
- * the function determines if the pageblock contains only free pages.
- * Due to buddy contraints, a free page at least the size of a pageblock=
 will
- * be located at the start of the pageblock
- */
-static inline int pageblock_free(struct page *page)
-{
-	return PageBuddy(page) && page_order(page) >=3D pageblock_order;
-}
-
-/* Return the pfn of the start of the next active pageblock after a give=
n pfn */
-static unsigned long next_active_pageblock(unsigned long pfn)
-{
-	struct page *page =3D pfn_to_page(pfn);
-
-	/* Ensure the starting page is pageblock-aligned */
-	BUG_ON(pfn & (pageblock_nr_pages - 1));
-
-	/* If the entire pageblock is free, move to the end of free page */
-	if (pageblock_free(page)) {
-		int order;
-		/* be careful. we don't have locks, page_order can be changed.*/
-		order =3D page_order(page);
-		if ((order < MAX_ORDER) && (order >=3D pageblock_order))
-			return pfn + (1 << order);
-	}
-
-	return pfn + pageblock_nr_pages;
-}
-
-static bool is_pageblock_removable_nolock(unsigned long pfn)
-{
-	struct page *page =3D pfn_to_page(pfn);
-	struct zone *zone;
-
-	/*
-	 * We have to be careful here because we are iterating over memory
-	 * sections which are not zone aware so we might end up outside of
-	 * the zone but still within the section.
-	 * We have to take care about the node as well. If the node is offline
-	 * its NODE_DATA will be NULL - see page_zone.
-	 */
-	if (!node_online(page_to_nid(page)))
-		return false;
-
-	zone =3D page_zone(page);
-	pfn =3D page_to_pfn(page);
-	if (!zone_spans_pfn(zone, pfn))
-		return false;
-
-	return !has_unmovable_pages(zone, page, MIGRATE_MOVABLE,
-				    MEMORY_OFFLINE);
-}
-
-/* Checks if this range of memory is likely to be hot-removable. */
-bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_=
pages)
-{
-	unsigned long end_pfn, pfn;
-
-	end_pfn =3D min(start_pfn + nr_pages,
-			zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
-
-	/* Check the starting page of each pageblock within the range */
-	for (pfn =3D start_pfn; pfn < end_pfn; pfn =3D next_active_pageblock(pf=
n)) {
-		if (!is_pageblock_removable_nolock(pfn))
-			return false;
-		cond_resched();
-	}
-
-	/* All pageblocks in the memory block are likely to be hot-removable */
-	return true;
-}
-
 /*
  * Confirm all pages in a range [start, end) belong to the same zone (sk=
ipping
  * memory holes). When true, return the zone.
--=20
2.25.1

