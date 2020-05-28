Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491DAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290FF20814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404038AbgE1PP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:15:29 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:23186 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404009AbgE1PP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:15:26 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SF9OZJ025668;
        Thu, 28 May 2020 15:15:13 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 319fgjx8r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 15:15:13 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 976C14F;
        Thu, 28 May 2020 15:15:12 +0000 (UTC)
Received: from raspberrypi (unknown [16.99.130.52])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 01F5648;
        Thu, 28 May 2020 15:15:10 +0000 (UTC)
Date:   Thu, 28 May 2020 10:15:10 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, mgorman@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org,
        steve.wahl@hpe.com
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200528151510.GA6154@raspberrypi>
References: <20200521092612.GP1059226@linux.ibm.com>
 <20200521155225.GA20045@MiWiFi-R3L-srv>
 <20200521171836.GU1059226@linux.ibm.com>
 <20200522070114.GE26955@MiWiFi-R3L-srv>
 <20200522072524.GF26955@MiWiFi-R3L-srv>
 <20200522142053.GW1059226@linux.ibm.com>
 <20200526084543.GG26955@MiWiFi-R3L-srv>
 <20200526113244.GH13212@linux.ibm.com>
 <01beec81-565f-d335-5eff-22693fc09c0e@redhat.com>
 <20200528090731.GI20045@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528090731.GI20045@MiWiFi-R3L-srv>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_03:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 cotscore=-2147483648 mlxscore=0
 phishscore=0 clxscore=1011 bulkscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=5 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 05:07:31PM +0800, Baoquan He wrote:
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

Thank you for CC'ing me.  Coming into the middle of the conversation,
I am trying to understand the implications of what's being discussed
here, but not being very successful at it.

For the HPE UV hardware, the addresses listed in the reserved range
must never be accessed, or (as we discovered) even be reachable by an
active page table entry.  Any active page table entry covering the
region allows the processor to issue speculative accesses to the
region, resulting in the BIOS halt mentioned.

I'm not sure if the discussion above about adding the region to
memblock.memory would result in an active mapping of the region or
not.  If it did, we'd have problems.

Thanks,

Steve Wahl, HPE


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
>                  * (in memblock.reserved but not in memblock.memory) will
>                  * get re-initialized via reserve_bootmem_region() later.
>                  */
> -               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> +               mm_zero_struct_page(pfn_to_page(pfn));
>                 __SetPageReserved(pfn_to_page(pfn));
>                 pgcnt++;
>         }
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
