Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE02C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF0E20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCQaYyhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgERQIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgERQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:08:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE7C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:08:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so5047004pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L19SO6KFpo5hAU+C0UieyEriotd0TE3tm5uYS4Vh/aQ=;
        b=rCQaYyhA0hu/Z1GP724RIFScS5ajB3NAVl+y996tQoI7gjify4lipbqHKmD01+6pB8
         8PZRBPml70HvBtUJEpMhjQ/+JYWZ0epgHUcmln5DGTLgVZsFxKnglVUfzTNctr8Aj8El
         vH3fCGHp7J8bOPS6fy1JkqRPhqGbBXuILsphvYms+NBOi56kl3ZmSxopUWvYVB69XKtQ
         D6a7Ymn/KKiEy0scP9YIhxKEAz9w/1simvHNXKo819hXJL7sHoexixIoqGlaxoEMNkby
         FXdGUE5304H6Cy4IAgam7GSk0AbECCgXbKqRfPnDrYQrsdkNCd2+cRqI9H2P1fuV3NVY
         neEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L19SO6KFpo5hAU+C0UieyEriotd0TE3tm5uYS4Vh/aQ=;
        b=lMtoxthVEkfxzLGCRNtxk6LGO3H4q6Qcp5E6+JoeIdkX63r+tM1v5+zfWpbQTb5Lx7
         w8fwBtt21z6kceEnROFIUpmy5rO4/TQ+8OH1zvDJK/cVmL5KWbX2BtHFaSWHt3q8NR58
         YrGaCf6g1ZT1YIjKDshjx8j5RqNM5oAP1D67pzDHPtDPjbIL57er0i3WOPhoPtimJYks
         ekVrFq2Hi0z2ui9Ex/8K+A5JEDMwmFLIjpRu3rZFl+DV7WaHUeDZbGUwDOkCMECqLZoY
         1jnU3XJm9NemZKpjZfv8ZG33RgjN35qofdWCoqBspMtIEBlAAoBTS78AAvzzpryYtA8Q
         YTbA==
X-Gm-Message-State: AOAM531M6Tz9CshKQeMNUy1bbfVYEaIVa5+aYdQPgttFQjlhePoY0Q4Q
        C2oqcJ0qwcJRGVsvFX3cgrw=
X-Google-Smtp-Source: ABdhPJwVPah5dUe/5W+EXe6x1kSIJiQfoZwiWjhe3lL7jkd0mLT49/LRTe91MAOCGTnlfrPRi7WSFA==
X-Received: by 2002:a62:8817:: with SMTP id l23mr17014735pfd.156.1589818092645;
        Mon, 18 May 2020 09:08:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 27sm7584pjc.41.2020.05.18.09.08.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 09:08:12 -0700 (PDT)
Date:   Mon, 18 May 2020 09:08:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200518160811.GA66689@roeck-us.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <418aa44b-6fb3-c3d8-a920-1a26e5edec62@roeck-us.net>
 <20200518142310.GC1118872@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518142310.GC1118872@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 05:23:10PM +0300, Mike Rapoport wrote:
> On Mon, May 18, 2020 at 02:48:18AM -0700, Guenter Roeck wrote:
> > On 5/18/20 1:37 AM, Will Deacon wrote:
> > > On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
> > >> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
> > >>> On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> > >>>> Now that the page table allocator can free page table allocations
> > >>>> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> > >>>> to avoid needlessly wasting memory.
> > >>>>
> > >>>> Cc: "David S. Miller" <davem@davemloft.net>
> > >>>> Cc: Peter Zijlstra <peterz@infradead.org>
> > >>>> Signed-off-by: Will Deacon <will@kernel.org>
> > >>>
> > >>> Something in the sparc32 patches in linux-next causes all my sparc32 emulations
> > >>> to crash. bisect points to this patch, but reverting it doesn't help, and neither
> > >>> does reverting the rest of the series.
> > >>>
> > >> Actually, turns out I see the same pattern (lots of scheduling while atomic
> > >> followed by 'killing interrupt handler' in cryptomgr_test) with several
> > >> powerpc boot tests.  I am currently bisecting those crashes. I'll report
> > >> the results here as well as soon as I have it.
> > > 
> > > FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
> > > issues. However, linux-next is a different story, where I don't get very far
> > > at all:
> > > 
> > > BUG: Bad page state in process swapper  pfn:005b4
> 
> This one seems to be due to commit 24aab577764f ("mm: memmap_init:
> iterate over memblock regions rather that check each PFN") and reverting
> it and partially reverting the next cleanup commits makes those
> dissapear. sparc32 boot still fails on today's linux-next and mmotm for me with
> 
> Run /sbin/init as init process
>   with arguments:
>     /sbin/init
>   with environment:
>     HOME=/
>     TERM=linux
> Starting init: /sbin/init exists but couldn't execute it (error -14)
> 

Interesting; that is also seen on microblazeel:petalogix-ml605. Bisect there
suggests 'arch/kmap_atomic: consolidate duplicate code' as the culprit,
which is part of Ira's series.

Today's -next is even worse, unfortunately; now all microblaze boot tests
(both little and big endian) fail, plus everything that failed last
time, plus new compile failures. Another round of bisects ...

Guenter

> I've tried to bisect mmotm and I've got the first bad commits in
> different places in the middle of arch/kmap series [1] so I've added Ira
> to CC as well :)
> 
> I'll continue to look into "bad page" on sparc32
> 
> [1] https://lore.kernel.org/dri-devel/20200507150004.1423069-11-ira.weiny@intel.com/
> 
> > Here are the bisect results for ppc:
> > 
> > # bad: [bdecf38f228bcca73b31ada98b5b7ba1215eb9c9] Add linux-next specific files for 20200515
> > # good: [2ef96a5bb12be62ef75b5828c0aab838ebb29cb8] Linux 5.7-rc5
> > git bisect start 'HEAD' 'v5.7-rc5'
> 
> ...
> 
> > # good: [9b5aa5b43f957f03a1f4a9aff5f7924e2ebbc011] arch-kmap_atomic-consolidate-duplicate-code-checkpatch-fixes
> > git bisect good 9b5aa5b43f957f03a1f4a9aff5f7924e2ebbc011
> > # bad: [89194ba5ee31567eeee9c81101b334c8e3248198] arch/kmap: define kmap_atomic_prot() for all arch's
> > git bisect bad 89194ba5ee31567eeee9c81101b334c8e3248198
> > # good: [022785d2bea99f8bc2a37b7b6c525eea26f6ac59] arch-kunmap_atomic-consolidate-duplicate-code-checkpatch-fixes
> > git bisect good 022785d2bea99f8bc2a37b7b6c525eea26f6ac59
> > # good: [a13c2f39e3f0519ddee57d26cc66ec70e3546106] arch/kmap: don't hard code kmap_prot values
> > git bisect good a13c2f39e3f0519ddee57d26cc66ec70e3546106
> > # first bad commit: [89194ba5ee31567eeee9c81101b334c8e3248198] arch/kmap: define kmap_atomic_prot() for all arch's
> > 
> > I don't know if that is accurate either. Maybe things are so broken
> > that bisect gets confused, or the problem is due to interaction
> > between different patch series.
> 
> My results with the workaround for sparc32 boot look similar:
> 
> # bad: [2bbf0589bfeb27800c730b76eacf34528eee5418] pci: test for unexpectedly disabled bridges
> git bisect bad 2bbf0589bfeb27800c730b76eacf34528eee5418
> # good: [2ef96a5bb12be62ef75b5828c0aab838ebb29cb8] Linux 5.7-rc5
> git bisect good 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8
> # bad: [e4592f53440c6fd2288e2dcb8c6f5b4d9d40fd35] mm-add-debug_wx-support-fix
> git bisect bad e4592f53440c6fd2288e2dcb8c6f5b4d9d40fd35
> # bad: [e4592f53440c6fd2288e2dcb8c6f5b4d9d40fd35] mm-add-debug_wx-support-fix
> git bisect bad e4592f53440c6fd2288e2dcb8c6f5b4d9d40fd35
> # good: [e27369856a2d42ae4d84bc2c4ddac1e696c40d7c] mm: remove the prot argument from vm_map_ram
> git bisect good e27369856a2d42ae4d84bc2c4ddac1e696c40d7c
> # good: [6911f2b29f6daae2c4b51e6a37f794056d8afabd] mm/page_alloc.c: clear out zone->lowmem_reserve[] if the zone is empty
> git bisect good 6911f2b29f6daae2c4b51e6a37f794056d8afabd
> # good: [8cef4726f20ae37c3cf3f7a449f5b8a088247a27] hugetlbfs: clean up command line processing
> git bisect good 8cef4726f20ae37c3cf3f7a449f5b8a088247a27
> # good: [94f38895e0a68ceac3ceece6528123ed3129cedd] arch/kmap: ensure kmap_prot visibility
> git bisect good 94f38895e0a68ceac3ceece6528123ed3129cedd
> # skip: [fcc77c28bf9155c681712b25c0f5e6125d10ba2e] kmap: consolidate kmap_prot definitions
> git bisect skip fcc77c28bf9155c681712b25c0f5e6125d10ba2e
> # bad: [175a67be7ee750b2aa2a4a2fedeff18fdce787ac] kmap-consolidate-kmap_prot-definitions-checkpatch-fixes
> git bisect bad 175a67be7ee750b2aa2a4a2fedeff18fdce787ac
> # bad: [54db8ed321d66a00b6c69bbd5bf7c59809b3fd42] drm: vmwgfx: include linux/highmem.h
> git bisect bad 54db8ed321d66a00b6c69bbd5bf7c59809b3fd42
> # bad: [6671299c829d19c6ceb0fd1a14b690f6115c6d3d] arch/kmap: define kmap_atomic_prot() for all arch's
> git bisect bad 6671299c829d19c6ceb0fd1a14b690f6115c6d3d
> # bad: [f800fb6e517710e04391821e4b1908606c8a6b24] arch/kmap: don't hard code kmap_prot values
> git bisect bad f800fb6e517710e04391821e4b1908606c8a6b24
> # first bad commit: [f800fb6e517710e04391821e4b1908606c8a6b24] arch/kmap: don't hard code kmap_prot values
> 
> 
> > Guenter
> 
> -- 
> Sincerely yours,
> Mike.
