Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7912078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSUQhx7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgDIOg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:36:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27991 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727427AbgDIOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586442988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TJHwU4QCtIzWKDnuGZ53w2sGjc1k4Ozm7+sDhV1TpY=;
        b=cSUQhx7cxXFP7O8EM7uow1PprRfpUZdGeqwILI578Bgsz8G+IWxHIonZhboZzjr+zoj+z8
        Lz+JCPxsCbUNkPvsI7EK4v0rRXV2X2OnZhU/ytnMl5lkn/V07+QMGM1o7zDRz7VsfUTrP4
        +PWTzisxutaGPqlb1ur5AH3x6J3mrRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-71DlMV9PM0-K6HhJZMTCLA-1; Thu, 09 Apr 2020 10:36:24 -0400
X-MC-Unique: 71DlMV9PM0-K6HhJZMTCLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A774A1007275;
        Thu,  9 Apr 2020 14:36:22 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0C3719757;
        Thu,  9 Apr 2020 14:36:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 039EaJ0x021764;
        Thu, 9 Apr 2020 10:36:19 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 039EaHUd021758;
        Thu, 9 Apr 2020 10:36:17 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 9 Apr 2020 10:36:17 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH] memcpy_flushcache: use cache flusing for larger
 lengths
In-Reply-To: <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com> <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Apr 2020, Dan Williams wrote:

> On Wed, Apr 8, 2020 at 11:54 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> >
> > On Tue, 7 Apr 2020, Dan Williams wrote:
> >
> > > On Tue, Apr 7, 2020 at 8:02 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > > >
> > > This should use clwb instead of clflushopt, the clwb macri
> > > automatically converts back to clflushopt if clwb is not supported.
> >
> > But we want to invalidate cache, we do not expect CPU to access these data
> > anymore (it will be accessed by a DMA engine during writeback).
> 
> The cluflushopt and clwb instructions should have identical overhead,
> but clwb wins on the rare chance the written data is needed again
> soon. If it is never needed again then the cost of dropping a clean
> cache line is the same as if the line was invalidated in the first
> instance. In both cases (clflushopt and clwb) the snoop traffic
> overhead is still paid whether the written-back line is still present
> in the cache or not.

But my concern is that clflushopt removes the line from the cache and 
makes room for another line (this is desired behavior) - clwb keeps the 
line cached and the line would have to compete with other cache lines in 
the same associative set.

Do you know how does the CPU select the cache line to be replaced?

dm-writecache is intended to be used for workloads like database logs that 
need extra-low commit latency. The committed data is not read back during 
normal workload.

> > > > Other ideas - should we introduce memcpy_to_pmem instead of modifying
> > > > memcpy_flushcache and move this logic there? Or should I modify the
> > > > dm-writecache target directly to use clflushopt with no change to the
> > > > architecture-specific code?
> > >
> > > This also needs to mention your analysis that showed that this can
> > > have negative cache pollution effects [1], so I'm not sure how to
> > > decide when to make the tradeoff. Once we have movdir64b the tradeoff
> > > equation changes yet again:
> > >
> > > [1]: https://lore.kernel.org/linux-nvdimm/alpine.LRH.2.02.2004010941310.23210@file01.intranet.prod.int.rdu2.redhat.com/
> >
> > I analyzed it some more. I have created this program that tests writecache
> > w.r.t. cache pollution:
> >
> > http://people.redhat.com/~mpatocka/testcases/pmem/misc/l1-test-2.c
> >
> > It fills the cache with a chain of random pointers and then walks these
> > pointers to evaluate cache pollution. Between the walks, it writes data to
> > the dm-writecache target.
> >
> > With the original kernel, the result is:
> > 8503 - 11366
> > real    0m7.985s
> > user    0m0.585s
> > sys     0m7.390s
> >
> > With dm-writecache hacked to use cached writes + clflushopt:
> > 8513 - 11379
> > real    0m5.045s
> > user    0m0.670s
> > sys     0m4.365s
> >
> > So, the hacked dm-writecache is significantly faster, while the cache
> > micro-benchmark doesn't show any more cache pollution.
> 
> Nice. These are now the pmem numbers, or dram?

pmem


With dm-writecache on emulated pmem (with the memmap argument), we get

With the original kernel:
8508 - 11378
real    0m4.960s
user    0m0.638s
sys     0m4.312s

With dm-writecache hacked to use cached writes + clflushopt:
8505 - 11378
real    0m4.151s
user    0m0.560s
sys     0m3.582s

So - clflushopt is still slightly better.

> Otherwise, what changed that was making nt-writes on pmem perform better 
> compared to your previous test? I'm just trying to track the results.

I re-ran the previous test 
( http://people.redhat.com/~mpatocka/testcases/pmem/misc/l1-test.c )
and the result is this:

Write + clflushopt:
./l1-test /dev/ram0 f
8502 - 22616
./l1-test /dev/dax3.0 f
8502 - 22902
./l1-test /dev/dax4.0 f
8500 - 11970

Write + clwb:
./l1-test /dev/ram0 w
8502 - 22602
./l1-test /dev/dax3.0 w
8502 - 22454
./l1-test /dev/dax4.0 w
8502 - 11566

Non-temporal stores:
./l1-test /dev/ram0 n
8504 - 22162
./l1-test /dev/dax3.0 n
8502 - 12336
./l1-test /dev/dax4.0 n
8502 - 10662

(/dev/dax3.0 is the real persistent memory, /dev/dax4.0 is pmem emulated 
with the memmap parameter)

"./l1-test /dev/ram0 n" is slower than "./l1-test /dev/dax4.0 n" while 
both of these tests are on RAM. The pmem is mapped with large pages and 
mem map for ramdisk is not - perhaps this is making the difference?

"./l1-test /dev/dax3.0 n" is better than "./l1-test /dev/dax3.0 w" and 
"./l1-test /dev/dax3.0 f" - although the benchmaks done on dm-writecache 
show that cached writes + clflushopt perform better. I don't know why 
there is this disparity.

> > That's for dm-writecache. Are there some other significant users of
> > memcpy_flushcache that need to be checked?
> 
> The only other user is direct and dax-I/O to the pmem driver.

Mikulas

