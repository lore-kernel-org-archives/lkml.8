Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F3A20658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrgbrLEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHSSC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:02:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41201 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726896AbgHSSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597860028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6M/4txVpmzggly54c+7+ZjVhSFjyStYrm8CCuTe7s+M=;
        b=RrgbrLEnJs4VQKnA63kEpgkxV6qWvRyv4H3nufbE6DKPt6WZpxL2GQsCAJzeQmFtnEaQbQ
        V3jFO7t24E+fCwgSxVKgrDfbxV/9BC6/STY2pJtfP4F0PSQssn/FelFKZWz2GUBHzerYHR
        5cWaSxXbk+EMlY+aLgFVs/9TxdHkoZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-pqQSExWnMviDTM6dJ6eoUQ-1; Wed, 19 Aug 2020 14:00:26 -0400
X-MC-Unique: pqQSExWnMviDTM6dJ6eoUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0E1BD1C40;
        Wed, 19 Aug 2020 18:00:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A26EE10023A5;
        Wed, 19 Aug 2020 18:00:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH v2 08/10] mm/page_alloc: drop stale pageblock comment in memmap_init_zone*()
Date:   Wed, 19 Aug 2020 19:59:55 +0200
Message-Id: <20200819175957.28465-9-david@redhat.com>
In-Reply-To: <20200819175957.28465-1-david@redhat.com>
References: <20200819175957.28465-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac5d2539b238 ("mm: meminit: reduce number of times pageblocks are
set during struct page init") moved the actual zone range check, leaving
only the alignment check for pageblocks.

Let's drop the stale comment and make the pageblock check easier to read.

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 848664352dfe2..5db0b35f95e20 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6022,13 +6022,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * to reserve their blocks rather than leaking throughout
 		 * the address space during boot when many long-lived
 		 * kernel allocations are made.
-		 *
-		 * bitmap is created for zone's valid pfn range. but memmap
-		 * can be created for invalid pages (for alignment)
-		 * check here not to call set_pageblock_migratetype() against
-		 * pfn out of zone.
 		 */
-		if (!(pfn & (pageblock_nr_pages - 1))) {
+		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 			cond_resched();
 		}
@@ -6091,15 +6086,10 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		 * the address space during boot when many long-lived
 		 * kernel allocations are made.
 		 *
-		 * bitmap is created for zone's valid pfn range. but memmap
-		 * can be created for invalid pages (for alignment)
-		 * check here not to call set_pageblock_migratetype() against
-		 * pfn out of zone.
-		 *
 		 * Please note that MEMMAP_HOTPLUG path doesn't clear memmap
 		 * because this is done early in section_activate()
 		 */
-		if (!(pfn & (pageblock_nr_pages - 1))) {
+		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 			cond_resched();
 		}
-- 
2.26.2

