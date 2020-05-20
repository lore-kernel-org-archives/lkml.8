Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3A2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D17F20709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589994199;
	bh=ONZaSMeLX8fRQJPENnjkYE5Bn+Jf4NeirGru2bBXRDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ARd7gGQ6ed6YupSKMyH4q9KwxVpHt8o4ynp5noHbTY/A4afp6gD3fcU/82FN/cW8d
	 /7S8TIftc2ZGunyUot5xAnaoAoCaw80pSM0/fAAsniER1AiULn5tzge91NA2YEUd3I
	 jjKjJcf/5pnsnyER8SOvR9SazDCUGLhd1P9QH3NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgETRDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETRDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:03:18 -0400
Received: from kernel.org (unknown [87.71.47.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35106206B6;
        Wed, 20 May 2020 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589994197;
        bh=ONZaSMeLX8fRQJPENnjkYE5Bn+Jf4NeirGru2bBXRDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUrSJV5xKXVV0s1fYwg9cGFegeLkEHaM6d0aFvOI8hlVIOiXsWJYaqjOS7cc1eEKS
         EXSzhmWWo8pysh77dAM6KaAIr3jnafUN5Kw/Duo81bTHugKYDwkUR7OICd2g48gW6S
         txl0SbSQHMjT6doCtjC1WTb7rMFq8+9eg1u/1HF0=
Date:   Wed, 20 May 2020 20:03:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200520170306.GG1118872@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518083715.GA31383@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:37:15AM +0100, Will Deacon wrote:
> On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
> > On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
> > > On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> > > > Now that the page table allocator can free page table allocations
> > > > smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> > > > to avoid needlessly wasting memory.
> > > > 
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > 
> > > Something in the sparc32 patches in linux-next causes all my sparc32 emulations
> > > to crash. bisect points to this patch, but reverting it doesn't help, and neither
> > > does reverting the rest of the series.
> > > 
> > Actually, turns out I see the same pattern (lots of scheduling while atomic
> > followed by 'killing interrupt handler' in cryptomgr_test) with several
> > powerpc boot tests.  I am currently bisecting those crashes. I'll report
> > the results here as well as soon as I have it.
> 
> FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
> issues. However, linux-next is a different story, where I don't get very far
> at all:
> 
> BUG: Bad page state in process swapper  pfn:005b4
 
This is caused by c03584e30534 ("mm: memmap_init: iterate over memblock
regions rather that check each PFN"). The commit sha is valid for
v5.7-rc6-mmots-2020-05-19-21-52, so it will change in a day or so :)

As it seems, sparc32 never registered the memory occupied by the kernel
image with memblock_add() and it only reserves this memory with
meblock_reserve(). 

I don't know what would happen on real HW, but with 

qemu-system-sparc -kernel /path/to/kernel

the memory occupied by the kernel is reserved in openbios and removed
from mem.available. The prom setup code in the kernel used mem.available
to set up the memory banks and essentially there is a hole for the
memory occupied by the kernel.

Later in bootmem_init() this memory is memblock_reserve()d.

Before the problematic commit, memmap initialization would call
__init_single_page() for the pages in that hole, the
free_low_memory_core_early() would mark them as resrved and everything
would be Ok.

After the change in memmap initialization, the hole is skipped and the
page structs for it are not inited. And when they are passed from
memblock to page allocator as reserved it gets confused.

Simply registering the memory occupied by the kernel with memblock_add()
resolves this issue, at least for qemu-system-arm and I cannot see how
it can harm any other setup.

If all that makes sense I'll send a proper patch :)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 906eda1158b4..3cb3dffcbcdc 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -193,6 +193,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
 	memblock_reserve(phys_base, size);
+	memblock_add(phys_base, size);
 
 	size = memblock_phys_mem_size() - memblock_reserved_size();
 	*pages_avail = (size >> PAGE_SHIFT) - high_pages;

> Will

-- 
Sincerely yours,
Mike.
