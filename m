Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C26C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED40620772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWBpHU0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgFANcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:32:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725847AbgFANcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591018335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RPcRYZe1V8/fhJjD1pHfQCmlD5i9DFH7zRa/JSmA734=;
        b=bWBpHU0VibRp8UiTYPRSOJMriUD2Ucii78V1Jgv0NxDe9a7OXK7zbS//cqhb8dGux83kGk
        Vls6y/GtQMmH4YIzDlgftlT5annLhWDvnnzuvJw8EKmLYVlTPG7OMr2rtM5tnPc3jG5wWR
        l25tMFpeXWiRxHok5IScTTvCkQgp7sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-HEeVRos-PhCgHGJALX81KQ-1; Mon, 01 Jun 2020 09:32:13 -0400
X-MC-Unique: HEeVRos-PhCgHGJALX81KQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D463C1052502;
        Mon,  1 Jun 2020 13:32:02 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC8167A8B5;
        Mon,  1 Jun 2020 13:32:01 +0000 (UTC)
Date:   Mon, 1 Jun 2020 21:31:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        David Hildenbrand <david@redhat.com>, mgorman@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200601133159.GM26955@MiWiFi-R3L-srv>
References: <20200521171836.GU1059226@linux.ibm.com>
 <20200522070114.GE26955@MiWiFi-R3L-srv>
 <20200522072524.GF26955@MiWiFi-R3L-srv>
 <20200522142053.GW1059226@linux.ibm.com>
 <20200526084543.GG26955@MiWiFi-R3L-srv>
 <20200526113244.GH13212@linux.ibm.com>
 <01beec81-565f-d335-5eff-22693fc09c0e@redhat.com>
 <20200528090731.GI20045@MiWiFi-R3L-srv>
 <20200528151510.GA6154@raspberrypi>
 <20200601114246.GC8502@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601114246.GC8502@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/20 at 02:42pm, Mike Rapoport wrote:
> On Thu, May 28, 2020 at 10:15:10AM -0500, Steve Wahl wrote:
> > On Thu, May 28, 2020 at 05:07:31PM +0800, Baoquan He wrote:
> > > On 05/26/20 at 01:49pm, David Hildenbrand wrote:
> > > > On 26.05.20 13:32, Mike Rapoport wrote:
> > > > > Hello Baoquan,
> > > > > 
> > > > > I do not object to your original fix with careful check for pfn validity.
> > > > > 
> > > > > But I still think that the memory reserved by the firmware is still
> > > > > memory and it should be added to memblock.memory. This way the memory
> > > > 
> > > > If it's really memory that could be read/written, I think I agree.
> > > 
> > > I would say some of them may not be allowed to be read/written, if I
> > > understand it correctly. I roughly went through the x86 init code, there
> > > are some places where mem region is marked as E820_TYPE_RESERVED so that
> > > they are not touched after initialization. E.g:
> > > 
> > > 1) pfn 0
> > > In trim_bios_range(), we set the pfn 0 as E820_TYPE_RESERVED. You can
> > > see the code comment, this is a BIOS owned area, but not kernel RAM.
> > > 
> > > 2)GART reserved region
> > > In early_gart_iommu_check(), GART IOMMU firmware will reserve a region
> > > in an area, firmware designer won't map system RAM into that area.
> > > 
> > > And also intel_graphics_stolen(), arch_rmrr_sanity_check(), these
> > > regions are not system RAM backed area, reading from or writting into
> > > these area may cause error.
> > > 
> > > Futhermore, there's a KASLR bug found by HPE, its triggering and root
> > > cause are written into below commit log. You can see that accessing to
> > > firmware reserved region caused BIOS to halt system when cpu doing
> > > speculative.
> > > 
> > > commit 2aa85f246c181b1fa89f27e8e20c5636426be624
> > > Author: Steve Wahl <steve.wahl@hpe.com>
> > > Date:   Tue Sep 24 16:03:55 2019 -0500
> > > 
> > >     x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area
> > > 
> > >     Our hardware (UV aka Superdome Flex) has address ranges marked
> > >     reserved by the BIOS. Access to these ranges is caught as an error,
> > >     causing the BIOS to halt the system.
> > 
> > Thank you for CC'ing me.  Coming into the middle of the conversation,
> > I am trying to understand the implications of what's being discussed
> > here, but not being very successful at it.
> > 
> > For the HPE UV hardware, the addresses listed in the reserved range
> > must never be accessed, or (as we discovered) even be reachable by an
> > active page table entry.  Any active page table entry covering the
> > region allows the processor to issue speculative accesses to the
> > region, resulting in the BIOS halt mentioned.
> > 
> > I'm not sure if the discussion above about adding the region to
> > memblock.memory would result in an active mapping of the region or
> > not.  If it did, we'd have problems.
> 
> The discussion is whether regions marked as E820_RESERVED should be
> considered as RAM or not.

IMHO, the discussion is about whether firmware reserved regions like
E820_TYPE_RESERVED should be added into memory allocators.

> 
> For the hardware that cannot tolerate acceses to these areas like HPE
> UV, it should not :)
> 
> I still think that keeping them only in memblock.reserved creates more
> problems than it solves, but simply adding E820_RESERVED areas to
> memblock.memory just won't work.

Currently, we hardly add E820_RESERVED into memblock, including
memblock.memmory and memblock.reserved. But, in several places, people
add them to memblock.reserved when they have marked them as
E820_TYPE_RESERVED.

I agree with David that these pages aren't available for any later
memory allocator. "the node/zone is just completely irrelevant for
these pages". Keeping them out of the memory management system is safer
so that nobody won't touch them. I tried to mark them out with a new
type PageUnavail as David suggested, am still struggling to think of
where I should detect and exclude them.

Below is a draft patch about my attempt on marking out unavailable pages.
Any comment or suggestions are welcomed. Of course for any better idea
with code change, I would like to test and review. Hope we can finally fix
this issue after its exposure. 

From 25ca041258a40bb315f94a23f0465b510b1614a0 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Fri, 29 May 2020 20:23:13 +0800
Subject: [RFC PATCH] mm: Add a new page type to mark unavailable pages

Firstly, the last user of early_pfn_valid() is memmap_init_zone(), but that code
has been optimized away. Let's remove it.

Secondly, add a new page type to mark unavailale pages.

Thirdly, add a new early_pfn_valid() so that init_unavailable_range()
can initialize those pages in memblock.reserved.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/mmzone_32.h |  2 --
 include/linux/mmzone.h           | 18 ++++++++++--------
 include/linux/page-flags.h       |  8 ++++++++
 mm/page_alloc.c                  |  3 ++-
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mmzone_32.h b/arch/x86/include/asm/mmzone_32.h
index 73d8dd14dda2..4da45eff2942 100644
--- a/arch/x86/include/asm/mmzone_32.h
+++ b/arch/x86/include/asm/mmzone_32.h
@@ -49,8 +49,6 @@ static inline int pfn_valid(int pfn)
 	return 0;
 }
 
-#define early_pfn_valid(pfn)	pfn_valid((pfn))
-
 #endif /* CONFIG_DISCONTIGMEM */
 
 #endif /* _ASM_X86_MMZONE_32_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e8d7d0b0acf4..47d09be73dca 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1315,20 +1315,23 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 #endif
 
 #ifndef CONFIG_HAVE_ARCH_PFN_VALID
-static inline int pfn_valid(unsigned long pfn)
+static inline int early_pfn_valid(unsigned long pfn)
 {
-	struct mem_section *ms;
-
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
-	ms = __nr_to_section(pfn_to_section_nr(pfn));
-	if (!valid_section(ms))
+	return valid_section(__pfn_to_section(pfn))
+}
+
+static inline int pfn_valid(unsigned long pfn)
+{
+	if (!early_pfn_valid(pfn))
 		return 0;
 	/*
 	 * Traditionally early sections always returned pfn_valid() for
 	 * the entire section-sized span.
 	 */
-	return early_section(ms) || pfn_section_valid(ms, pfn);
+	return (early_section(ms) && PageUnavail(pfn_to_page(pfn))) ||
+	       pfn_section_valid(ms, pfn);
 }
 #endif
 
@@ -1364,7 +1367,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #define pfn_to_nid(pfn)		(0)
 #endif
 
-#define early_pfn_valid(pfn)	pfn_valid(pfn)
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
@@ -1385,7 +1387,7 @@ struct mminit_pfnnid_cache {
 };
 
 #ifndef early_pfn_valid
-#define early_pfn_valid(pfn)	(1)
+#define early_pfn_valid(pfn)	pfn_valid(pfn)
 #endif
 
 void memory_present(int nid, unsigned long start, unsigned long end);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 222f6f7b2bb3..1c011008100c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -740,6 +740,7 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PG_kmemcg	0x00000200
 #define PG_table	0x00000400
 #define PG_guard	0x00000800
+#define PG_unavail	0x00001000
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -796,6 +797,13 @@ PAGE_TYPE_OPS(Table, table)
  */
 PAGE_TYPE_OPS(Guard, guard)
 
+/*
+ *  Mark pages which are unavailable to memory allocators after boot.
+ *  They includes pages reserved by firmware pre-boot or during boot,
+ *  holes which share the same setcion with usable RAM.
+ */
+PAGE_TYPE_OPS(Unavail, unavail)
+
 extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 940cdce96864..e9ebef6ffbec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6972,7 +6972,8 @@ static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
 		 * (in memblock.reserved but not in memblock.memory) will
 		 * get re-initialized via reserve_bootmem_region() later.
 		 */
-		__init_single_page(pfn_to_page(pfn), pfn, 0, 0);
+		mm_zero_struct_page(pfn_to_page(pfn));
+		__SetPageUnavail(pfn_to_page(pfn));
 		__SetPageReserved(pfn_to_page(pfn));
 		pgcnt++;
 	}
-- 
2.17.2


