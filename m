Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DE4C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27142137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgDQIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:37:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:53860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbgDQIhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:37:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0C40BADE2;
        Fri, 17 Apr 2020 08:37:16 +0000 (UTC)
Subject: Re: [PATCH RFC] mm: compaction: avoid migrating non-cma pages to a
 cma area
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Qian Cai <cai@lca.pw>, Andrea Arcangeli <aarcange@redhat.com>,
        Joonsoo Kim <js1304@gmail.com>
References: <20200408194119.1076232-1-guro@fb.com>
 <225868db-b9b0-3614-de0f-4b264023df2b@suse.cz>
 <20200414154204.GC42877@carbon.lan>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c60fc30f-463c-31cd-0100-d26a92b83c9d@suse.cz>
Date:   Fri, 17 Apr 2020 10:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414154204.GC42877@carbon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 5:42 PM, Roman Gushchin wrote:
> On Tue, Apr 14, 2020 at 01:49:45PM +0200, Vlastimil Babka wrote:
> 
> Hello, Vlastimil!
> 
> Thank you for looking  into it.
> 
>> Hm I think I'd rather make such pages really unmovable (by a pin?) than deny the
>> whole CMA area to compaction. Would it be feasible?
> 
> Well, it's an option too, however I'm not sure it's the best one.
> First, because these pages can be moved quite often, making
> them completely unmovable will make the compaction less efficient.
> Second, because it's not only about these pages, but in general
> about migrating pages into a cma area without a clear need.
> 
> As I wrote in the commit log, if a cma area is located close to end
> of a node (which seems to be default at least on x86 without a movable
> zone), compaction can fill it quite aggressively. And it might bring
> some hot pages (e.g. executable pagecache pages), which will cause
> cma allocation failures. I've seen something like this in our prod.

Hmm, I see.

>> 
>> > Compaction moves them to the hugetlb_cma area, and then sometimes
>> > the cma allocator fails to move them back from the cma area. It
>> > results in failures of gigantic hugepages allocations.
>> > 
>> > Also in general cma areas are reserved close to the end of a zone,
>> > and it's where compaction tries to migrate pages. It means
>> > compaction will aggressively fill cma areas, which makes not much
>> > sense.
>> 
>> So now the free page scanner will have to skip those areas, which is not much
>> effective. But I suspect a worse problem in __compaction_suitable() which will
>> now falsely report that there are enough free pages, so compaction will start
>> but fail to do anytning. Minimally the __zone_watermark_ok() check there would
>> have to lose ALLOC_CMA, but there might be other similar checks that would need
>> adjusting.
> 
> A really good point! I've looked around for any other checks, but haven't found
> anything. Please, find an updated version of the patch below.

Technically there's also __isolate_free_page() using ALLOC_CMA for watermark
check, but it's shared by compaction and alloc_contig_range(), so we can't just
remove ALLOC_CMA from there. It's probably not worth to complicate it though. If
we pass compaction_suitable() without ALLOC_CMA and then reach
__isolate_free_page() and meanwhile watermarks changed so we wouldn't pass
without ALLOC_CMA anymore, it should be rare hopefully and not cause us deplete
non-CMA free pages too badly.

But I've only now also realized how dynamic setting cc->cma is. So in case a
zone consists mostly of CMA blocks, removing ALLOC_CMA in
__compaction_suitable() would be actually wrong and prevent compaction from
doing any work? Sigh. Any idea about that?

>> 
>> And long-term what happens if the "CMA using ZONE_MOVABLE" approach is merged
>> and there are not more CMA migratetypes to test? Might this change actually also
>> avoid your issue, as said pages without __GFP_MOVABLE won't end up in a
>> ZONE_MOVABLE?
> 
> Yeah, this is what I was thinking about. Basically I want to mimic this behavior
> right now. Once this approach will be implemented and merged, it will happen
> automatically: obviously, compaction won't move pages between different zones.

That will be much better. Can't wait, then :)

> Thank you!
> 
> --
> 
> From f4a0cfff41c7acab78116478e8e69ae8773b405c Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 8 Apr 2020 11:16:38 -0700
> Subject: [PATCH v2] mm: compaction: avoid migrating non-cma pages to a cma
>  area
> 
> Compaction does treat cma pageblocks on pair with any movable
> pageblocks. It means it can easily move non-cma pages into a cma zone.
> 
> It can create problems for the cma allocator.
> 
> The particular problem I'm looking at is related to btrfs metadata
> pages, which are allocated without __GFP_MOVABLE, but beside that
> are generic pagecache pages. In fact, they are sometimes movable
> and sometimes not, depending on whether they are dirty and also
> on the extent buffer reference counter.
> 
> Compaction moves them to the hugetlb_cma area, and then sometimes
> the cma allocator fails to move them back from the cma area. It
> results in failures of gigantic hugepages allocations.
> 
> Also in general cma areas are reserved close to the end of a zone,
> and it's where compaction tries to migrate pages. It means
> compaction will aggressively fill cma areas, which makes not much
> sense.
> 
> So to avoid it, let's preserve non-cma pages from being moved into
> a cma area. Because cma areas are usually quite large and the number
> of areas is small, it should not significantly affect the memory
> fragmentation.
> 
> v2:
>   1) adjusted the __zone_watermark_ok() check, suggested by
>      Vlastimil Babka
>   2) fixed a typo in a comment
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>>
> ---
>  mm/compaction.c | 10 ++++++++--
>  mm/internal.h   |  1 +
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 46f0fcc93081..9ca036cb148a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1159,6 +1159,10 @@ static bool suitable_migration_target(struct compact_control *cc,
>  			return false;
>  	}
>  
> +	/* Do not bring non-cma pages into a cma area */
> +	if (is_migrate_cma(get_pageblock_migratetype(page)) && !cc->cma)

Nit: probably reverse this as the second test is cheaper?

> +		return false;
> +
>  	if (cc->ignore_block_suitable)
>  		return true;
>  
