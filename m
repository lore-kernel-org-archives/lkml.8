Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50994C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3217B20658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzaCsIRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHSSAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbgHSSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597860012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fq+L0FZ4E9O8B1gKyErYfXmAA9+wPlbWuNN02iDq7Jw=;
        b=HzaCsIRbx1uLXamhqEMW1OIOPMyz+xnar+VAlVnU19OofvjJUIrZravyr2WHygfimFSP8f
        pNOTtQXoIfd6Sv9bqWGGJSvrP/frehOqUHotf54KvczJkFLOzJvZT04ImkZwj1btMWbMZk
        jfOA2899CPc3ZkRwoBYhXYtRaT1XXck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-EOCKc3dONAGr4GU_Uvxa4A-1; Wed, 19 Aug 2020 14:00:06 -0400
X-MC-Unique: EOCKc3dONAGr4GU_Uvxa4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 608308030AF;
        Wed, 19 Aug 2020 18:00:04 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E22F310027A6;
        Wed, 19 Aug 2020 17:59:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v2 00/10] mm/memory_hotplug: online_pages()/offline_pages() cleanups
Date:   Wed, 19 Aug 2020 19:59:47 +0200
Message-Id: <20200819175957.28465-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a bunch of cleanups for online_pages()/offline_pages() and
related code, mostly getting rid of memory hole handling that is no longer
necessary. There is only a single walk_system_ram_range() call left in
offline_pages(), to make sure we don't have any memory holes. I had some
of these patches lying around for a longer time but didn't have time to
polish them.

In addition, the last patch marks all pageblocks of memory to get onlined
MIGRATE_ISOLATE, so pages that have just been exposed to the buddy cannot
get allocated before onlining is complete. Once heavy lifting is done,
the pageblocks are set to MIGRATE_MOVABLE, such that allocations are
possible.

I played with DIMMs and virtio-mem on x86-64 and didn't spot any surprises.
I verified that the numer of isolated pageblocks is correctly handled when
onlining/offlining.

v1 -> v2:
- "mm/memory_hotplug: enforce section granularity when onlining/offlining"
-- Extended the patch description regarding alignment requirements
-- Fixed a typo
- Squashed "mm/memory_hotplug: simplify offlining of pages in
  offline_pages()" and "mm/memory_hotplug: simplify checking if all pages are
  isolated in offline_pages()", resulting in "mm/memory_hotplug: simplify page
  offlining"
- Added ACKs

David Hildenbrand (10):
  mm/memory_hotplug: inline __offline_pages() into offline_pages()
  mm/memory_hotplug: enforce section granularity when onlining/offlining
  mm/memory_hotplug: simplify page offlining
  mm/page_alloc: simplify __offline_isolated_pages()
  mm/memory_hotplug: drop nr_isolate_pageblock in offline_pages()
  mm/page_isolation: simplify return value of start_isolate_page_range()
  mm/memory_hotplug: simplify page onlining
  mm/page_alloc: drop stale pageblock comment in memmap_init_zone*()
  mm: pass migratetype into memmap_init_zone() and
    move_pfn_range_to_zone()
  mm/memory_hotplug: mark pageblocks MIGRATE_ISOLATE while onlining
    memory

 arch/ia64/mm/init.c            |   4 +-
 include/linux/memory_hotplug.h |   7 +-
 include/linux/mm.h             |   3 +-
 mm/Kconfig                     |   2 +-
 mm/memory_hotplug.c            | 156 ++++++++++++++-------------------
 mm/memremap.c                  |   3 +-
 mm/page_alloc.c                |  64 ++++----------
 mm/page_isolation.c            |   7 +-
 8 files changed, 98 insertions(+), 148 deletions(-)

-- 
2.26.2

