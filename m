Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03966C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D473920826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul6fL4+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgEUPll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:41:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52076 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgEUPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590075698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CMvnLhh5lyjI/HLoNPSZUinybXlEONxIuzZuzJHmfeE=;
        b=Ul6fL4+AJOXejY4Ws1QTSDxJgUDEkKoCAc8FPpCdwwMb8IHgB7YhoMj4U3I4bKJxdzb7SM
        bLaRzk5q09JHDThx6PO7Trdu4BzPmiHYAbAUxhhMdUY8TFf2z7ONInf6R1VBSaj1z41rcn
        MAHTmeukrnc448demKXTnR3IiT5DGBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-xzdjKymbPYCPLkzjW2RvGg-1; Thu, 21 May 2020 11:41:34 -0400
X-MC-Unique: xzdjKymbPYCPLkzjW2RvGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26C50107ACCA;
        Thu, 21 May 2020 15:41:33 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65DFB64446;
        Thu, 21 May 2020 15:41:32 +0000 (UTC)
Date:   Thu, 21 May 2020 23:41:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org,
        rppt@linux.ibm.com
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200521154129.GB26955@MiWiFi-R3L-srv>
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521093606.GA7110@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521093606.GA7110@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/20 at 10:36am, Mel Gorman wrote:
> On Thu, May 21, 2020 at 09:44:07AM +0800, Baoquan He wrote:
> > After investigation, it turns out that this is introduced by commit of
> > linux-next: commit f6edbdb71877 ("mm: memmap_init: iterate over memblock
> > regions rather that check each PFN").
> > 
> > After investigation, it turns out that this is introduced by commit of
> > linux-next, the patch subject is:
> >   "mm: memmap_init: iterate over memblock regions rather that check each PFN".
> > 
> 
> Some repetition here. I assume it's because the commit ID is not stable
> because it's in linux-next.

Yes, I plan to remove the temporary commit id of linux-next, but
forgot cleaning up it.

> 
> > Qian added debugging code. The debugging log shows that the fault page is
> > 0x2a800000. From the system e820 map which is pasted at bottom, the page
> > is in e820 reserved range:
> > 	BIOS-e820: [mem 0x0000000029ffe000-0x000000002a80afff] reserved
> > And it's in section [0x28000000, 0x2fffffff]. In that secion, there are
> > several usable ranges and some e820 reserved ranges.
> > 
> > For this kind of e820 reserved range, it won't be added to memblock allocator.
> > However, init_unavailable_mem() will initialize to add them into node 0,
> > zone 0.
> 
> Why is it appropriate for init_unavailable_mem to add a e820 reserved
> range to the zone at all? The bug being triggered indicates there is a
> mismatch between the zone of a struct page and the PFN passed in.

Read the patch log again and reviewing comments, realize I could make
the log misleading with inaccurate explanation. The root cause is not
about e820 reserved only, it's about any unavailable range inside boot
mem section. The unavailable ranges include firmware reserved ranges,
and holes. Before Mike's below patchset, we call init_unavailable_mem()
to initialize the unavailable ranges into node 0, zone 0, and mark pages
inside the unvailable ranges as Reserved. Later in memmap_init_zone(),
we will add the unvaiable ranges into zone which start and end cover them.
Because the early_pfn_valid() and early_pfn_in_nid() incorrectly return
true for these unavailable pages. This looks unreasonable, right? But it
doesn't cause problem, because they are not added into buddy and is
Reserved.

After Mike's patchset applied, one of them is patch 15/21, it will
iterate over memblock regions. These unavailable ranges are not added
into memblock allocator, so they won't be added into zone which start
and end cover them, but kept in node 0, zone 0. Then this issue is
triggered by VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn)).

Note that init_unavailable_mem(), memmap_init(), they are all in generic
MM code, not in a certain ARCH only. So I think the fix in this patch 
is needed, no matter whether we will fix the issue that unavailable
rangs have struct page, and are added into node 0, zone 0.

[PATCH 00/21] mm: rework free_area_init*() funcitons
http://lkml.kernel.org/r/20200412194859.12663-1-rppt@kernel.org

[PATCH 15/21] mm: memmap_init: iterate over memblock regions rather that check each PFN

> 
> > Before that commit, later, memmap_init() will add e820 reserved
> > ranges into the zone where they are contained, because it can pass
> > the checking of early_pfn_valid() and early_pfn_in_nid(). In this case,
> > the e820 reserved range where fault page 0x2a800000 is located is added
> > into DMA32 zone. After that commit, the e820 reserved rgions are kept
> > in node 0, zone 0, since we iterate over memblock regions to iniatialize
> > in memmap_init() instead, their node and zone won't be changed.
> > 
> 
> This implies that we have struct pages that should never be used (e820
> reserved) but exist somehow in a zone range but with broken linkages to
> their node and zone.

Yes, in one boot memory section, if it includes usable RAM, and
unavailable ranges, like firmware reserved range, holes, these
unavailable ranges will be added into node 0, zone 0, and have struct
page, they are never used by system.

> 
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/compaction.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 67fd317f78db..9ce4cff4d407 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1418,7 +1418,9 @@ fast_isolate_freepages(struct compact_control *cc)
> >  				cc->free_pfn = highest;
> >  			} else {
> >  				if (cc->direct_compaction && pfn_valid(min_pfn)) {
> > -					page = pfn_to_page(min_pfn);
> > +					page = pageblock_pfn_to_page(min_pfn,
> > +						pageblock_end_pfn(min_pfn),
> > +						cc->zone);
> >  					cc->free_pfn = min_pfn;
> >  				}
> >  			}
> 
> Why is the correct fix not to avoid creating struct pages for e820
> ranges and make sure that struct pages that are reachable have proper
> node and zone linkages?

Seems we can't avoid to create struct page for them, surely as I
explained at above, they are not only e820 reserved ranges, there are
also holes and other firmware reserved ranges.


