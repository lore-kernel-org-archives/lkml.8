Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD51CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1AE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7xAluTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgE1JIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:08:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25497 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgE1JIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590656917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nqBqr33l4NNMWZMOBpKdAAmzF/g/ZipZWnHqU2+36DA=;
        b=e7xAluTroxiKZV1ggFjQc6sdLDD5/ZVBMUkl3FaB8c7/pSVPCMSztx2T0B/nKaU2OlaZ+o
        T0ZHdcE573fGLkjfwxKLbNFdYZrZZ2f9FoVcpLu+9/oHnLsQ6AZ867HgXThUMkAbZHvC31
        Zeuy0YK/OWXcPN06EX2UfHdccz06ynU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-cIcsi-DGMjuMB1DMzAxkKA-1; Thu, 28 May 2020 05:08:35 -0400
X-MC-Unique: cIcsi-DGMjuMB1DMzAxkKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFC63474;
        Thu, 28 May 2020 09:08:34 +0000 (UTC)
Received: from localhost (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4BEE19D71;
        Thu, 28 May 2020 09:08:30 +0000 (UTC)
Date:   Thu, 28 May 2020 17:08:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>, rppt@linux.ibm.com
Cc:     mgorman@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages() =?ISO-8859-1?Q?=1B?=
Message-ID: <20200528090828.GA22153@MiWiFi-R3L-srv>
References: <20200528085933.GH20045@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528085933.GH20045@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/20 at 04:59pm, Baoquan He wrote:
> akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org, steve.wahl@hpe.com, 
> Bcc: bhe@redhat.com
> Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
>  fast_isolate_freepages()
> Reply-To: 
> In-Reply-To: <01beec81-565f-d335-5eff-22693fc09c0e@redhat.com>

Sorry, mail client mess up the mail header, have resent one. Please
ignore this one.

> 
> On 05/26/20 at 01:49pm, David Hildenbrand wrote:
> > On 26.05.20 13:32, Mike Rapoport wrote:
> > > Hello Baoquan,
> > > 
> > > On Tue, May 26, 2020 at 04:45:43PM +0800, Baoquan He wrote:
> > >> On 05/22/20 at 05:20pm, Mike Rapoport wrote:
> > >>> Hello Baoquan,
> > >>>
> > >>> On Fri, May 22, 2020 at 03:25:24PM +0800, Baoquan He wrote:
> > >>>> On 05/22/20 at 03:01pm, Baoquan He wrote:
> > >>>>>
> > >>>>> So let's add these unavailable ranges into memblock and reserve them
> > >>>>> in init_unavailable_range() instead. With this change, they will be added
> > >>>>> into appropriate node and zone in memmap_init(), and initialized in
> > >>>>> reserve_bootmem_region() just like any other memblock reserved regions.
> > >>>>
> > >>>> Seems this is not right. They can't get nid in init_unavailable_range().
> > >>>> Adding e820 ranges may let them get nid. But the hole range won't be
> > >>>> added to memblock, and still has the issue.
> > >>>>
> > >>>> Nack this one for now, still considering.
> > >>>
> > >>> Why won't we add  the e820 reserved ranges to memblock.memory during
> > >>> early boot as I suggested?
> > >>>
> > >>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > >>> index c5399e80c59c..b0940c618ed9 100644
> > >>> --- a/arch/x86/kernel/e820.c
> > >>> +++ b/arch/x86/kernel/e820.c
> > >>> @@ -1301,8 +1301,11 @@ void __init e820__memblock_setup(void)
> > >>>  		if (end != (resource_size_t)end)
> > >>>  			continue;
> > >>>  
> > >>> -		if (entry->type == E820_TYPE_SOFT_RESERVED)
> > >>> +		if (entry->type == E820_TYPE_SOFT_RESERVED ||
> > >>> +		    entry->type == E820_TYPE_RESERVED) {
> > >>> +			memblock_add(entry->addr, entry->size);
> > >>>  			memblock_reserve(entry->addr, entry->size);
> > >>> +		}
> > >>>  
> > >>>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > >>>  			continue;
> > >>>
> > >>> The setting of node later  in numa_init() will assign the proper node
> > >>> for these regions as it does for the usable memory.
> > >>
> > >> Yes, if it's only related to e820 reserved region, this truly works.
> > >>
> > >> However, it also has ACPI table regions. That's why I changed to call
> > >> the problematic area as firmware reserved ranges later.
> > >>
> > >> Bisides, you can see below line, there's another reserved region which only
> > >> occupies one page in one memory seciton. If adding to memblock.memory, we also
> > >> will build struct mem_section and the relevant struct pages for the whole
> > >> section. And then the holes around that page will be added and initialized in
> > >> init_unavailable_mem(). numa_init() will assign proper node for memblock.memory
> > >> and memblock.reserved, but won't assign proper node for the holes.
> > >>
> > >> ~~~
> > >> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> > >> ~~~
> > >>
> > >> So I still think we should not add firmware reserved range into
> > >> memblock for fixing this issue.
> > >>
> > >> And, the fix in the original patch seems necessary. You can see in
> > >> compaction code, the migration source is chosen from LRU pages or
> > >> movable pages, the migration target has to be got from Buddy. However,
> > >> only the min_pfn in fast_isolate_freepages(), it's calculated by
> > >> distance between cc->free_pfn - cc->migrate_pfn, we can't guarantee it's
> > >> safe, then use it as the target to handle.
> > > 
> > > I do not object to your original fix with careful check for pfn validity.
> > > 
> > > But I still think that the memory reserved by the firmware is still
> > > memory and it should be added to memblock.memory. This way the memory
> > 
> > If it's really memory that could be read/written, I think I agree.
> 
> I would say some of them may not be allowed to be read/written, if I
> understand it correctly. I roughly went through the x86 init code, there
> are some places where mem region is marked as E820_TYPE_RESERVED so that
> they are not touched after initialization. E.g:
> 
> 1) pfn 0
> In trim_bios_range(), we set the pfn 0 as E820_TYPE_RESERVED. You can
> see the code comment, this is a BIOS owned area, but not kernel RAM.
> 
> 2)GART reserved region
> In early_gart_iommu_check(), GART IOMMU firmware will reserve a region
> in an area, firmware designer won't map system RAM into that area.
> 
> And also intel_graphics_stolen(), arch_rmrr_sanity_check(), these
> regions are not system RAM backed area, reading from or writting into
> these area may cause error. 
> 
> Futhermore, there's a KASLR bug found by HPE, its triggering and root
> cause are written into below commit log. You can see that accessing to
> firmware reserved region caused BIOS to halt system when cpu doing
> speculative.
> 
> commit 2aa85f246c181b1fa89f27e8e20c5636426be624
> Author: Steve Wahl <steve.wahl@hpe.com>
> Date:   Tue Sep 24 16:03:55 2019 -0500
> 
>     x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area
>     
>     Our hardware (UV aka Superdome Flex) has address ranges marked
>     reserved by the BIOS. Access to these ranges is caught as an error,
>     causing the BIOS to halt the system.
> 
> > 
> > > map will be properly initialized from the very beginning and we won't
> > > need init_unavailable_mem() and alike workarounds and. Obviously, the patch
> > 
> > I remember init_unavailable_mem() is necessary for holes within
> > sections, where we actually *don't* have memory, but we still have have
> > a valid memmap (full section) that we have to initialize.
> > 
> > See the example from 4b094b7851bf ("mm/page_alloc.c: initialize memmap
> > of unavailable memory directly"). Our main memory ends within a section,
> > so we have to initialize the remaining parts because the whole section
> > will be marked valid/online.
> 
> Yes, memory hole need be handled in init_unavailable_mem(). Since we
> have created struct page for them, need initialize them. We can't
> discard init_unavailable_mem() for now.
> 
> > 
> > Any way to improve this handling is appreciated. In that patch I also
> > spelled out that we might want to mark such holes via a new page type,
> > e.g., PageHole(). Such a page is a memory hole, but has a valid memmap.
> > Any content in the memmap (zone/node) should be ignored.
> 
> As I said at above, I am a little conservative to add all those regions of
> E820_TYPE_RESERVED into memblock.memory and memblock.reserved, because
> most of them are firmware reserved region, they may be not backed by normal
> RAM.
> 
> I was thinking to step back to use mm_zero_struct_page() inside
> init_unavailable_range() as below. But it doesn't differ much
> from __init_single_page(), except of the _refcount and mapcount. 
> Zeroing struct page equals to putting them into node 0, zero 0.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3973b5fdfe3f..4e4b72cf5283 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6901,7 +6901,7 @@ static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
>  		 * (in memblock.reserved but not in memblock.memory) will
>  		 * get re-initialized via reserve_bootmem_region() later.
>  		 */
> -		__init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> +		mm_zero_struct_page(pfn_to_page(pfn));
>  		__SetPageReserved(pfn_to_page(pfn));
>  		pgcnt++;
>  	}
> 
> About adding these unavailable ranges into node/zone, in the old code,
> it just happened to add them into expected node/zone. You can see in
> early_pfn_in_nid(), if no nid found from memblock, the returned '-1'
> will make it true ironically. But that is not saying the bad thing
> always got good result. If the last zone of node 0 is DMA32 zone, the
> deferred init will skip the only chance to add some of unavailable
> rnages into expected node/zone. Means they were not always added into 
> appropriate node/zone before, the change of iterating memblock.memory in
> memmap_init() dones't introduce regression.
> 
> static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
> {
>         int nid;
> 
>         nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
>         if (nid >= 0 && nid != node)
>                 return false;
>         return true;
> }
> 
> So if no anybody need access them after boot, not adding them into any
> node/zone sounds better. Otherwise, better add them in the appropriate
> node/zone.
> 
> > 
> > But it's all quite confusing, especially across architectures and ...
> > 
> > > above is not enough, but it's a small step in this direction.
> > > 
> > > I believe that improving the early memory initialization would make many
> > > things simpler and more robust, but that's a different story :)
> > 
> > ... I second that.
> > 
> > -- 
> > Thanks,
> > 
> > David / dhildenb
> 
> 

