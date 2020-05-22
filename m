Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50441C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1C620679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W08j67Tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgEVHBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:01:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53979 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728181AbgEVHB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590130887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFWr7gpjYD9ttIAQ8TkDqEXM7t/nar6Qf5F2iEybFdM=;
        b=W08j67TqczEdPp8I2TD1HjPewrjCGDLSi0Mu3KmMXW6cS6JouY4/tr1XKMGhSfV74Jfqgf
        pEsiCiCON5EJrlnc0H+WhQ5EeqOC2LFBFVgmf6T35iECRRzAGCMwVBboxpo27iB+j6DA+C
        lTrVoUekoUEVHi9Hwe5E1E1dGZdJlwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-5QCcVnr6NtmIXnocHMvyEA-1; Fri, 22 May 2020 03:01:22 -0400
X-MC-Unique: 5QCcVnr6NtmIXnocHMvyEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6205A1853C61;
        Fri, 22 May 2020 07:01:21 +0000 (UTC)
Received: from localhost (ovpn-12-170.pek2.redhat.com [10.72.12.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D304E6E9F3;
        Fri, 22 May 2020 07:01:17 +0000 (UTC)
Date:   Fri, 22 May 2020 15:01:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200522070114.GE26955@MiWiFi-R3L-srv>
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521092612.GP1059226@linux.ibm.com>
 <20200521155225.GA20045@MiWiFi-R3L-srv>
 <20200521171836.GU1059226@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521171836.GU1059226@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/20 at 08:18pm, Mike Rapoport wrote:
> On Thu, May 21, 2020 at 11:52:25PM +0800, Baoquan He wrote:
> > On 05/21/20 at 12:26pm, Mike Rapoport wrote:
> > > > For this kind of e820 reserved range, it won't be added to memblock allocator.
> > > > However, init_unavailable_mem() will initialize to add them into node 0,
> > > > zone 0. Before that commit, later, memmap_init() will add e820 reserved
> > > > ranges into the zone where they are contained, because it can pass
> > > > the checking of early_pfn_valid() and early_pfn_in_nid(). In this case,
> > > > the e820 reserved range where fault page 0x2a800000 is located is added
> > > > into DMA32 zone. After that commit, the e820 reserved rgions are kept
> > > > in node 0, zone 0, since we iterate over memblock regions to iniatialize
> > > > in memmap_init() instead, their node and zone won't be changed.
> > > 
> > > I wonder why woudn't we add the reserved memory to memblock from the
> > > very beginning...
> > > I've tried to undestand why this was not done, but I couldn't find the
> > > reasoning behind that.
> > 
> > I have added some explanation when reply to Mel. Please check that in
> > that thread.
> 
> What I meant was that I've tried to find an explanation in the kernel logs
> for why the reserved areas are not added to memblock.memory on x86. I
> didn't mean that the your patch description lacks this explanation :)

Ah, I misunderstood it, sorry about that.

> 
> > As I said, the unavailable range includes firmware reserved ranges, and
> > holes inside one boot memory section, if that boot memory section haves
> > useable memory range, and firmware reserved ranges, and holes. Adding
> > them all into memblock seems a little unreasonable, since they are never
> > used by system in memblock, buddy or high level memory allocator. But I
> > can see that adding them into memblock may have the same effect as the
> > old code which is beofre your your patchset applied. Let's see if Mel or
> > other people have some saying. I pesonally would not suggest doing it
> > like this though.
> 
> Adding reserved regions to memblock.memory will not have the same effect
> as the old code. We anyway have to initialize struct page for these
> areas, but unlike the old code we don't need to run them by the
> early_pfn_in_nid() checks and we still get rid the
> CONFIG_NODES_SPAN_OTHER_NODES option.

Hmm, I mean adding them to memblock will let us have the same result,
they are added into the node, zone where they should be, and marked as
reserved, just as the old code did.

Rethink about this, seems adding them into memblock is doable. But
we may not need to add them from e820 reserved range, since that will
skip hole range which share the same section with usable range, and may
need to change code in different ARCHes. How about this:

We add them into memblock in init_unavailable_range(), memmap_init() will
add them into the right node and zone, reserve_bootmem_region() will
initialize them and mark them as Reserved.


From d019d0f9e7c958542dfcb142f93d07fcce6c7c22 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Fri, 22 May 2020 14:36:13 +0800
Subject: [PATCH] mm/page_alloc.c: Add unavailable ranges into memblock

These unavailable ranges shares the same section with the usable range
in boot memory, e.g the firmware reserved ranges, and holes.

Previously, they are added into node 0, zone 0 in function
init_unavailable_range(), and marked as Reserved. Later, in function
memmap_init(), they will be added to appropriate node and zone, where
they are covered.

However, after the patchset ("mm: rework free_area_init*() funcitons")
is applied, we change to iterate over memblock regions. These unavailable
ranges are skipped, and the node and zone adjustment won't be done any
more as the old code did. This cause a crash in compaction which is triggered
by VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn)).

So let's add these unavailable ranges into memblock and reserve them
in init_unavailable_range() instead. With this change, they will be added
into appropriate node and zone in memmap_init(), and initialized in
reserve_bootmem_region() just like any other memblock reserved regions.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 603187800628..3973b5fdfe3f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6925,7 +6925,7 @@ static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
 static void __init init_unavailable_mem(void)
 {
 	phys_addr_t start, end;
-	u64 i, pgcnt;
+	u64 i, pgcnt, size;
 	phys_addr_t next = 0;
 
 	/*
@@ -6934,9 +6934,11 @@ static void __init init_unavailable_mem(void)
 	pgcnt = 0;
 	for_each_mem_range(i, &memblock.memory, NULL,
 			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
-		if (next < start)
-			pgcnt += init_unavailable_range(PFN_DOWN(next),
-							PFN_UP(start));
+		if (next < start) {
+			size = PFN_UP(start) - PFN_DOWN(next);
+			memblock_add(PFN_DOWN(next), size);
+			memblock_reserve(PFN_DOWN(next), size);
+		}
 		next = end;
 	}
 
@@ -6947,8 +6949,11 @@ static void __init init_unavailable_mem(void)
 	 * considered initialized. Make sure that memmap has a well defined
 	 * state.
 	 */
-	pgcnt += init_unavailable_range(PFN_DOWN(next),
-					round_up(max_pfn, PAGES_PER_SECTION));
+	size = round_up(max_pfn, PAGES_PER_SECTION) - PFN_DOWN(next);
+	if (size) {
+		memblock_add(PFN_DOWN(next), size);
+		memblock_reserve(PFN_DOWN(next), size);
+	}
 
 	/*
 	 * Struct pages that do not have backing memory. This could be because
-- 
2.17.2

