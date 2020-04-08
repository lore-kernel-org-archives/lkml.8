Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87BFC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6B6206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK+eAsFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgDHSyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:54:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55573 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727963AbgDHSyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586372057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91TsF2razSUU/bXVnfn+T8gt27hU+LnhQV4OA0J+59M=;
        b=bK+eAsFs223bTrX9NZ31puKxZDI5hY+MJpWgc1eOWFvFPOnFmAG40IEgxNcE2GuOQteWTx
        Z/w2OoWnlSRza1YxoLzFh04r6gwaAGu03h2nXJg3JDOmrscLhEKA5W1pBMgo7mzL+CU4II
        tTKW9GhO3iLNSZqpgi9doZHheqQseww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-z55h2yC-NFWY-uWxmwgqzw-1; Wed, 08 Apr 2020 14:54:13 -0400
X-MC-Unique: z55h2yC-NFWY-uWxmwgqzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CABAC8017F3;
        Wed,  8 Apr 2020 18:54:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6656B1001B3F;
        Wed,  8 Apr 2020 18:54:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 038Is7K3014828;
        Wed, 8 Apr 2020 14:54:07 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 038Is4f1014822;
        Wed, 8 Apr 2020 14:54:05 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 8 Apr 2020 14:54:04 -0400 (EDT)
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
In-Reply-To: <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Apr 2020, Dan Williams wrote:

> On Tue, Apr 7, 2020 at 8:02 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > [ resending this to x86 maintainers ]
> >
> > Hi
> >
> > I tested performance of various methods how to write to optane-based
> > persistent memory, and found out that non-temporal stores achieve
> > throughput 1.3 GB/s. 8 cached stores immediatelly followed by clflushopt
> > or clwb achieve throughput 1.6 GB/s.
> >
> > memcpy_flushcache uses non-temporal stores, I modified it to use cached
> > stores + clflushopt and it improved performance of the dm-writecache
> > target significantly:
> >
> > dm-writecache throughput:
> > (dd if=/dev/zero of=/dev/mapper/wc bs=64k oflag=direct)
> > writecache block size   512             1024            2048            4096
> > movnti                  496 MB/s        642 MB/s        725 MB/s        744 MB/s
> > clflushopt              373 MB/s        688 MB/s        1.1 GB/s        1.2 GB/s
> >
> > For block size 512, movnti works better, for larger block sizes,
> > clflushopt is better.
> 
> This should use clwb instead of clflushopt, the clwb macri
> automatically converts back to clflushopt if clwb is not supported.

But we want to invalidate cache, we do not expect CPU to access these data
anymore (it will be accessed by a DMA engine during writeback).

> > I was also testing the novafs filesystem, it is not upstream, but it
> > benefitted from similar change in __memcpy_flushcache and
> > __copy_user_nocache:
> > write throughput on big files - movnti: 662 MB/s, clwb: 1323 MB/s
> > write throughput on small files - movnti: 621 MB/s, clwb: 1013 MB/s
> >
> >
> > I submit this patch for __memcpy_flushcache that improves dm-writecache
> > performance.
> >
> > Other ideas - should we introduce memcpy_to_pmem instead of modifying
> > memcpy_flushcache and move this logic there? Or should I modify the
> > dm-writecache target directly to use clflushopt with no change to the
> > architecture-specific code?
> 
> This also needs to mention your analysis that showed that this can
> have negative cache pollution effects [1], so I'm not sure how to
> decide when to make the tradeoff. Once we have movdir64b the tradeoff
> equation changes yet again:
> 
> [1]: https://lore.kernel.org/linux-nvdimm/alpine.LRH.2.02.2004010941310.23210@file01.intranet.prod.int.rdu2.redhat.com/

I analyzed it some more. I have created this program that tests writecache 
w.r.t. cache pollution:

http://people.redhat.com/~mpatocka/testcases/pmem/misc/l1-test-2.c

It fills the cache with a chain of random pointers and then walks these 
pointers to evaluate cache pollution. Between the walks, it writes data to 
the dm-writecache target.

With the original kernel, the result is:
8503 - 11366
real    0m7.985s
user    0m0.585s
sys     0m7.390s

With dm-writecache hacked to use cached writes + clflushopt:
8513 - 11379
real    0m5.045s
user    0m0.670s
sys     0m4.365s

So, the hacked dm-writecache is significantly faster, while the cache 
micro-benchmark doesn't show any more cache pollution.

That's for dm-writecache. Are there some other significant users of 
memcpy_flushcache that need to be checked?

Mikulas

