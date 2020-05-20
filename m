Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2B1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5BA20884
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590004284;
	bh=pPG+T3/3ZnRMz5ByuIrD4tHQfQ38hpQWkPl/H/gxpAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G5cLgm9zZxIZkWl8e6/ZlHoE+KOALSDCWxX5ZSrMF4CrhheUTnmCoN40S1zgXHNqS
	 0WL5Dyse4aVehl9weOVbmHMXZtpWkWjkJbxxs4YRzjM68sAYIwrpNTkxX3SbLaeqSN
	 POZ+6JPFD3tM50PIAqem1gWd4MlaYnZbmiomT0UY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgETTvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgETTvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:51:23 -0400
Received: from kernel.org (unknown [87.71.47.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C67207D8;
        Wed, 20 May 2020 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590004282;
        bh=pPG+T3/3ZnRMz5ByuIrD4tHQfQ38hpQWkPl/H/gxpAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehE7pE+YN6a/maaKRE4+w3aStl1T0E0T9NMpPVrAtHEE7YOOnof6onA+sx1L5zSOe
         Deii7lVgT8SP6+1WiWCxXV6LG3asjYRSQ5px3f+cm9U1TcSkuE5B/6caxLED+bPiAe
         /anXWe1bq5cyCSFb/YvUXRi7mMW3IfFRZFfqvq3Q=
Date:   Wed, 20 May 2020 22:51:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200520195110.GH1118872@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <20200520170306.GG1118872@kernel.org>
 <6034a1b5-d4f6-c836-142c-9b3b06db3246@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6034a1b5-d4f6-c836-142c-9b3b06db3246@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:03:31PM -0700, Guenter Roeck wrote:
> On 5/20/20 10:03 AM, Mike Rapoport wrote:
> > On Mon, May 18, 2020 at 09:37:15AM +0100, Will Deacon wrote:
> >> On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
> >>> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
> >>>> On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> >>>>> Now that the page table allocator can free page table allocations
> >>>>> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> >>>>> to avoid needlessly wasting memory.
> >>>>>
> >>>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>> Signed-off-by: Will Deacon <will@kernel.org>
> >>>>
> >>>> Something in the sparc32 patches in linux-next causes all my sparc32 emulations
> >>>> to crash. bisect points to this patch, but reverting it doesn't help, and neither
> >>>> does reverting the rest of the series.
> >>>>
> >>> Actually, turns out I see the same pattern (lots of scheduling while atomic
> >>> followed by 'killing interrupt handler' in cryptomgr_test) with several
> >>> powerpc boot tests.  I am currently bisecting those crashes. I'll report
> >>> the results here as well as soon as I have it.
> >>
> >> FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
> >> issues. However, linux-next is a different story, where I don't get very far
> >> at all:
> >>
> >> BUG: Bad page state in process swapper  pfn:005b4
> >  
> > This is caused by c03584e30534 ("mm: memmap_init: iterate over memblock
> > regions rather that check each PFN"). The commit sha is valid for
> > v5.7-rc6-mmots-2020-05-19-21-52, so it will change in a day or so :)
> > 
> > As it seems, sparc32 never registered the memory occupied by the kernel
> > image with memblock_add() and it only reserves this memory with
> > meblock_reserve(). 
> > 
> > I don't know what would happen on real HW, but with 
> > 
> > qemu-system-sparc -kernel /path/to/kernel
> > 
> > the memory occupied by the kernel is reserved in openbios and removed
> > from mem.available. The prom setup code in the kernel used mem.available
> > to set up the memory banks and essentially there is a hole for the
> > memory occupied by the kernel.
> > 
> > Later in bootmem_init() this memory is memblock_reserve()d.
> > 
> > Before the problematic commit, memmap initialization would call
> > __init_single_page() for the pages in that hole, the
> > free_low_memory_core_early() would mark them as resrved and everything
> > would be Ok.
> > 
> > After the change in memmap initialization, the hole is skipped and the
> > page structs for it are not inited. And when they are passed from
> > memblock to page allocator as reserved it gets confused.
> > 
> > Simply registering the memory occupied by the kernel with memblock_add()
> > resolves this issue, at least for qemu-system-arm and I cannot see how
> > it can harm any other setup.
> > 
> > If all that makes sense I'll send a proper patch :)
> > 
> > diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> > index 906eda1158b4..3cb3dffcbcdc 100644
> > --- a/arch/sparc/mm/init_32.c
> > +++ b/arch/sparc/mm/init_32.c
> > @@ -193,6 +193,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
> >  	/* Reserve the kernel text/data/bss. */
> >  	size = (start_pfn << PAGE_SHIFT) - phys_base;
> >  	memblock_reserve(phys_base, size);
> > +	memblock_add(phys_base, size);
> >  
> >  	size = memblock_phys_mem_size() - memblock_reserved_size();
> >  	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
> > 
> >> Will
> > 
> 
> With above patch applied on top of Ira's patch, I get:
> 
> BUG: spinlock recursion on CPU#0, S01syslogd/139
>  lock: 0xf5448350, .magic: dead4ead, .owner: S01syslogd/139, .owner_cpu: 0
> CPU: 0 PID: 139 Comm: S01syslogd Not tainted 5.7.0-rc6-next-20200518-00002-gb178d2d56f29-dirty #1
> [f0067a64 :
> do_raw_spin_lock+0xa8/0xd8 ]
> [f00d5034 :
> copy_page_range+0x328/0x804 ]
> [f0025be4 :
> dup_mm+0x334/0x434 ]
> [f0027124 :
> copy_process+0x1224/0x12b0 ]
> [f0027344 :
> _do_fork+0x54/0x30c ]
> [f0027670 :
> do_fork+0x5c/0x6c ]
> [f000de44 :
> sparc_do_fork+0x18/0x38 ]
> [f000b7f4 :
> do_syscall+0x34/0x40 ]
> [5010cd4c :
> 0x5010cd4c ]
> 
> Looks like yet another problem.

I've checked the patch above on top of the mmots which already has Ira's
patches and it booted fine. I've used sparc32_defconfig to build the
kernel and qemu-system-sparc with default machine and CPU. 

> I can not revert c03584e30534 because it results in a compile failure.

Here's the "revert" of c03584e30534:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d001d61e64d5..c9d9d3f9ebf4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5901,6 +5901,42 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
 	return false;
 }
 
+#ifdef CONFIG_SPARSEMEM
+/* Skip PFNs that belong to non-present sections */
+static inline __meminit unsigned long next_pfn(unsigned long pfn)
+{
+	const unsigned long section_nr = pfn_to_section_nr(++pfn);
+
+	if (present_section_nr(section_nr))
+		return pfn;
+	return section_nr_to_pfn(next_present_section_nr(section_nr));
+}
+#else
+static inline __meminit unsigned long next_pfn(unsigned long pfn)
+{
+	return pfn++;
+}
+#endif
+
+#ifdef CONFIG_NODES_SPAN_OTHER_NODES
+/* Only safe to use early in boot when initialisation is single-threaded */
+static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
+{
+	int nid;
+
+	nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
+	if (nid >= 0 && nid != node)
+		return false;
+	return true;
+}
+
+#else
+static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
+{
+	return true;
+}
+#endif
+
 /*
  * Initially all pages are reserved - free ones are freed
  * up by memblock_free_all() once the early boot process is
@@ -5940,6 +5976,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * function.  They do not exist on hotplugged memory.
 		 */
 		if (context == MEMMAP_EARLY) {
+			if (!early_pfn_valid(pfn)) {
+				pfn = next_pfn(pfn);
+				continue;
+			}
+			if (!early_pfn_in_nid(pfn, nid)) {
+				pfn++;
+				continue;
+			}
 			if (overlap_memmap_init(zone, &pfn))
 				continue;
 			if (defer_init(nid, pfn, end_pfn))
@@ -6055,23 +6099,9 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 }
 
 void __meminit __weak memmap_init(unsigned long size, int nid,
-				  unsigned long zone,
-				  unsigned long range_start_pfn)
+				  unsigned long zone, unsigned long start_pfn)
 {
-	unsigned long start_pfn, end_pfn;
-	unsigned long range_end_pfn = range_start_pfn + size;
-	int i;
-
-	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
-		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
-
-		if (end_pfn > start_pfn) {
-			size = end_pfn - start_pfn;
-			memmap_init_zone(size, nid, zone, start_pfn,
-					 MEMMAP_EARLY, NULL);
-		}
-	}
+	memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY, NULL);
 }
 
 static int zone_batchsize(struct zone *zone)

> Guenter

-- 
Sincerely yours,
Mike.
