Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E63C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F483207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgEUJgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:36:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:36876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgEUJgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:36:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08C3FABE4;
        Thu, 21 May 2020 09:36:12 +0000 (UTC)
Date:   Thu, 21 May 2020 10:36:06 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org,
        rppt@linux.ibm.com
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200521093606.GA7110@suse.de>
References: <20200521014407.29690-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200521014407.29690-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 09:44:07AM +0800, Baoquan He wrote:
> After investigation, it turns out that this is introduced by commit of
> linux-next: commit f6edbdb71877 ("mm: memmap_init: iterate over memblock
> regions rather that check each PFN").
> 
> After investigation, it turns out that this is introduced by commit of
> linux-next, the patch subject is:
>   "mm: memmap_init: iterate over memblock regions rather that check each PFN".
> 

Some repetition here. I assume it's because the commit ID is not stable
because it's in linux-next.

> Qian added debugging code. The debugging log shows that the fault page is
> 0x2a800000. From the system e820 map which is pasted at bottom, the page
> is in e820 reserved range:
> 	BIOS-e820: [mem 0x0000000029ffe000-0x000000002a80afff] reserved
> And it's in section [0x28000000, 0x2fffffff]. In that secion, there are
> several usable ranges and some e820 reserved ranges.
> 
> For this kind of e820 reserved range, it won't be added to memblock allocator.
> However, init_unavailable_mem() will initialize to add them into node 0,
> zone 0.

Why is it appropriate for init_unavailable_mem to add a e820 reserved
range to the zone at all? The bug being triggered indicates there is a
mismatch between the zone of a struct page and the PFN passed in.

> Before that commit, later, memmap_init() will add e820 reserved
> ranges into the zone where they are contained, because it can pass
> the checking of early_pfn_valid() and early_pfn_in_nid(). In this case,
> the e820 reserved range where fault page 0x2a800000 is located is added
> into DMA32 zone. After that commit, the e820 reserved rgions are kept
> in node 0, zone 0, since we iterate over memblock regions to iniatialize
> in memmap_init() instead, their node and zone won't be changed.
> 

This implies that we have struct pages that should never be used (e820
reserved) but exist somehow in a zone range but with broken linkages to
their node and zone.

> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/compaction.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 67fd317f78db..9ce4cff4d407 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1418,7 +1418,9 @@ fast_isolate_freepages(struct compact_control *cc)
>  				cc->free_pfn = highest;
>  			} else {
>  				if (cc->direct_compaction && pfn_valid(min_pfn)) {
> -					page = pfn_to_page(min_pfn);
> +					page = pageblock_pfn_to_page(min_pfn,
> +						pageblock_end_pfn(min_pfn),
> +						cc->zone);
>  					cc->free_pfn = min_pfn;
>  				}
>  			}

Why is the correct fix not to avoid creating struct pages for e820
ranges and make sure that struct pages that are reachable have proper
node and zone linkages?

-- 
Mel Gorman
SUSE Labs
