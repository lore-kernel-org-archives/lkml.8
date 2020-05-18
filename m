Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05516C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A5B20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgERSMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:12:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:52605 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733191AbgERSL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:11:59 -0400
IronPort-SDR: J7lJHpi9Bn2FDwYipCbFVsWQctskGUN1RT5vtQ5XQXv11B6nf87aGpNXckkZB51/SLrwubZyKW
 qVSsxLYUdY1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 11:11:59 -0700
IronPort-SDR: ZuNQWmTQ1nLBxtu+5TE/j+AXF8rFdc6kEiAmzXEFcKTfs6vyQ9ShsZPXaT/ddSnQv64auWHBNE
 rrbMWn7+V4eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="373470912"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2020 11:11:59 -0700
Date:   Mon, 18 May 2020 11:11:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200518181158.GA3028105@iweiny-DESK2.sc.intel.com>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <418aa44b-6fb3-c3d8-a920-1a26e5edec62@roeck-us.net>
 <20200518142310.GC1118872@kernel.org>
 <20200518160811.GA66689@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518160811.GA66689@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:08:11AM -0700, Guenter Roeck wrote:
> On Mon, May 18, 2020 at 05:23:10PM +0300, Mike Rapoport wrote:
> > On Mon, May 18, 2020 at 02:48:18AM -0700, Guenter Roeck wrote:
> > > On 5/18/20 1:37 AM, Will Deacon wrote:
> > > > On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
> > > >> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
> > > >>> On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> > > >>>> Now that the page table allocator can free page table allocations
> > > >>>> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> > > >>>> to avoid needlessly wasting memory.
> > > >>>>
> > > >>>> Cc: "David S. Miller" <davem@davemloft.net>
> > > >>>> Cc: Peter Zijlstra <peterz@infradead.org>
> > > >>>> Signed-off-by: Will Deacon <will@kernel.org>
> > > >>>
> > > >>> Something in the sparc32 patches in linux-next causes all my sparc32 emulations
> > > >>> to crash. bisect points to this patch, but reverting it doesn't help, and neither
> > > >>> does reverting the rest of the series.
> > > >>>
> > > >> Actually, turns out I see the same pattern (lots of scheduling while atomic
> > > >> followed by 'killing interrupt handler' in cryptomgr_test) with several
> > > >> powerpc boot tests.  I am currently bisecting those crashes. I'll report
> > > >> the results here as well as soon as I have it.
> > > > 
> > > > FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
> > > > issues. However, linux-next is a different story, where I don't get very far
> > > > at all:
> > > > 
> > > > BUG: Bad page state in process swapper  pfn:005b4
> > 
> > This one seems to be due to commit 24aab577764f ("mm: memmap_init:
> > iterate over memblock regions rather that check each PFN") and reverting
> > it and partially reverting the next cleanup commits makes those
> > dissapear. sparc32 boot still fails on today's linux-next and mmotm for me with
> > 
> > Run /sbin/init as init process
> >   with arguments:
> >     /sbin/init
> >   with environment:
> >     HOME=/
> >     TERM=linux
> > Starting init: /sbin/init exists but couldn't execute it (error -14)
> > 
> 
> Interesting; that is also seen on microblazeel:petalogix-ml605. Bisect there
> suggests 'arch/kmap_atomic: consolidate duplicate code' as the culprit,
> which is part of Ira's series.
> 
> Today's -next is even worse, unfortunately; now all microblaze boot tests
> (both little and big endian) fail, plus everything that failed last
> time, plus new compile failures. Another round of bisects ...

I've found this bug in microblaze for sure still looking through the other archs...

commit 82c284b2bb74ca195dfcd35b70a175f010b9fd46 (HEAD -> lm-kmap17)
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Mon May 18 11:01:10 2020 -0700

    microblaze/kmap: Don't enable pagefault/preempt twice
    
    The kunmap_atomic clean up failed to remove the pagefault/preempt
    enables on this path.
    
    Fixes: bee2128a09e6 ("arch/kunmap_atomic: consolidate duplicate code")
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>

diff --git a/arch/microblaze/mm/highmem.c b/arch/microblaze/mm/highmem.c
index ee8a422b2b76..92e0890416c9 100644
--- a/arch/microblaze/mm/highmem.c
+++ b/arch/microblaze/mm/highmem.c
@@ -57,11 +57,8 @@ void kunmap_atomic_high(void *kvaddr)
        int type;
        unsigned int idx;
 
-       if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
-               pagefault_enable();
-               preempt_enable();
+       if (vaddr < __fix_to_virt(FIX_KMAP_END))
                return;
-       }
 
        type = kmap_atomic_idx();

