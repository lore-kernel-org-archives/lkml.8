Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF097C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8812620838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gbUvCPWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgCaVTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:19:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36769 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgCaVTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:19:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id i7so22099076edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyTO6009JTCfLd3UlfmmxMzroAfVBiq2wFtDZniOPoA=;
        b=gbUvCPWpTriQ8JHR5BxWvl+KYugoDEUDTX2hJiCCBDgiZUE0ATCo//xiJyGPU8R8OD
         FcKDYZchRH1ODRx3qEwcsQaJPYXbB5tpRl1A2HL5KTGTv/m0sxp12TTeoCCVHBXysSkx
         qn6KAN6urppZpJ8vU+epdSmVXOKoseFDYAv1OQipfovxYpXFMmUju27RoIUCbFGFLZ/A
         FFK9eEmr3Gs7vBD0GD2TihdoCmbLkeoF7Kt2Fo4d0Uc0wYw4uPcpkjfKwiBWoZ4owWv8
         MC9YqtFh2L8Kj2hP8p2X4f6EpHoS9v0cqT/bs2dZIRR6CEad2pDEJaXmcmvbIjZt4nSZ
         sR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyTO6009JTCfLd3UlfmmxMzroAfVBiq2wFtDZniOPoA=;
        b=jbKFt7u0Ws67RuUgCW4jqgmV7IGA+7ZRdt8hPLnPbPl3BHURJ44Sf/WFjxw00YIMET
         VgThXRTk8hZFjGHq1lISD1pnTSPCfESPK/NchC2PYfWumylPzs5qwuB3gMg87KbMsS9P
         6xwnKjIuNXaB5T0wHBfRT0DAwMvIRYN6PcK8j3XZXlBFuCii6nl+xRfkjfEvY1VqmvtL
         UBBsRFN1R0E7oRjhTiI6ANzsH1wHt7kgvdQKpxV507rpIKQ6RDVOGIQBMtEmiAL356HV
         QDKOEcIUIUAIFaO7QTDX0DYpZO5wH4YFMOSQjCxBqFO2cUAnPQnJV5h6fYxImnOFWoy/
         ezlQ==
X-Gm-Message-State: ANhLgQ0uEC90jvOItqEzsGGZfm7W6wAfHVSxBveWIEeMJcoFd+yCpK4z
        JIwVtBWkM7OuZnqBrZW0JysValJNHG6zelLnqYEj7w==
X-Google-Smtp-Source: ADFU+vtABgQXb+2PEWx0hDcyeb3463r13Md1qzkMGG01QQesWZLScUbpHISBuKxebdal1y7UNBfkFGiG0aFoj641FX8=
X-Received: by 2002:a50:d847:: with SMTP id v7mr17832750edj.154.1585689583161;
 Tue, 31 Mar 2020 14:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2003291625590.32108@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2003300729320.9938@file01.intranet.prod.int.rdu2.redhat.com>
 <CS1PR8401MB12377197482867F688BF93F7ABC80@CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM>
 <alpine.LRH.2.02.2003310709090.2117@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2003310709090.2117@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Mar 2020 14:19:32 -0700
Message-ID: <CAPcyv4ijR185RLmtT+A+WZxJs309qPfdqj5eUDEkMgFbxsV+uw@mail.gmail.com>
Subject: Re: [PATCH v2] memcpy_flushcache: use cache flusing for larger lengths
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add x86 and LKML ]

On Tue, Mar 31, 2020 at 5:27 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Tue, 31 Mar 2020, Elliott, Robert (Servers) wrote:
>
> >
> >
> > > -----Original Message-----
> > > From: Mikulas Patocka <mpatocka@redhat.com>
> > > Sent: Monday, March 30, 2020 6:32 AM
> > > To: Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> > > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Ira
> > > Weiny <ira.weiny@intel.com>; Mike Snitzer <msnitzer@redhat.com>
> > > Cc: linux-nvdimm@lists.01.org; dm-devel@redhat.com
> > > Subject: [PATCH v2] memcpy_flushcache: use cache flusing for larger
> > > lengths
> > >
> > > I tested dm-writecache performance on a machine with Optane nvdimm
> > > and it turned out that for larger writes, cached stores + cache
> > > flushing perform better than non-temporal stores. This is the
> > > throughput of dm- writecache measured with this command:
> > > dd if=/dev/zero of=/dev/mapper/wc bs=64 oflag=direct
> > >
> > > block size  512             1024            2048            4096
> > > movnti      496 MB/s        642 MB/s        725 MB/s        744 MB/s
> > > clflushopt  373 MB/s        688 MB/s        1.1 GB/s        1.2 GB/s
> > >
> > > We can see that for smaller block, movnti performs better, but for
> > > larger blocks, clflushopt has better performance.
> >
> > There are other interactions to consider... see threads from the last
> > few years on the linux-nvdimm list.
>
> dm-writecache is the only linux driver that uses memcpy_flushcache on
> persistent memory. There is also the btt driver, it uses the "do_io"
> method to write to persistent memory and I don't know where this method
> comes from.
>
> Anyway, if patching memcpy_flushcache conflicts with something else, we
> should introduce memcpy_flushcache_to_pmem.
>
> > For example, software generally expects that read()s take a long time and
> > avoids re-reading from disk; the normal pattern is to hold the data in
> > memory and read it from there. By using normal stores, CPU caches end up
> > holding a bunch of persistent memory data that is probably not going to
> > be read again any time soon, bumping out more useful data. In contrast,
> > movnti avoids filling the CPU caches.
>
> But if I write one cacheline and flush it immediatelly, it would consume
> just one associative entry in the cache.
>
> > Another option is the AVX vmovntdq instruction (if available), the
> > most recent of which does 64-byte (cache line) sized transfers to
> > zmm registers. There's a hefty context switching overhead (e.g.,
> > 304 clocks), and the CPU often runs AVX instructions at a slower
> > clock frequency, so it's hard to judge when it's worthwhile.
>
> The benchmark shows that 64-byte non-temporal avx512 vmovntdq is as good
> as 8, 16 or 32-bytes writes.
>                                          ram            nvdimm
> sequential write-nt 4 bytes              4.1 GB/s       1.3 GB/s
> sequential write-nt 8 bytes              4.1 GB/s       1.3 GB/s
> sequential write-nt 16 bytes (sse)       4.1 GB/s       1.3 GB/s
> sequential write-nt 32 bytes (avx)       4.2 GB/s       1.3 GB/s
> sequential write-nt 64 bytes (avx512)    4.1 GB/s       1.3 GB/s
>
> With cached writes (where each cache line is immediatelly followed by clwb
> or clflushopt), 8, 16 or 32-byte write performs better than non-temporal
> stores and avx512 performs worse.
>
> sequential write 8 + clwb                5.1 GB/s       1.6 GB/s
> sequential write 16 (sse) + clwb         5.1 GB/s       1.6 GB/s
> sequential write 32 (avx) + clwb         4.4 GB/s       1.5 GB/s
> sequential write 64 (avx512) + clwb      1.7 GB/s       0.6 GB/s

This is indeed compelling straight-line data. My concern, similar to
Robert's, is what it does to the rest of the system. In addition to
increasing cache pollution, which I agree is difficult to quantify, it
may also increase read-for-ownership traffic. Could you collect 'perf
stat' for this clwb vs nt comparison to check if any of this
incidental overhead effect shows up in the numbers? Here is a 'perf
stat' line that might capture that.

perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses
-r 5 $benchmark

In both cases nt and explicit clwb there's nothing that prevents the
dirty-cacheline, or the fill buffer from being written-back / flushed
before the full line is populated and maybe you are hitting that
scenario differently with the two approaches? I did not immediately
see a perf counter for events like this. Going forward I think this
gets better with the movdir64b instruction because that can guarantee
full-line-sized store-buffer writes.

Maybe the perf data can help make a decision about whether we go with
your patch in the near term?

>
>
> > In user space, glibc faces similar choices for its memcpy() functions;
> > glibc memcpy() uses non-temporal stores for transfers > 75% of the
> > L3 cache size divided by the number of cores. For example, with
> > glibc-2.216-16.fc27 (August 2017), on a Broadwell system with
> > E5-2699 36 cores 45 MiB L3 cache, non-temporal stores are used
> > for memcpy()s over 36 MiB.
>
> BTW. what does glibc do with reads? Does it flush them from the cache
> after they are consumed?
>
> AFAIK glibc doesn't support persistent memory - i.e. there is no function
> that flushes data and the user has to use inline assembly for that.

Yes, and I don't know of any copy routines that try to limit the cache
pollution of pulling the source data for a copy, only the destination.

> > It'd be nice if glibc, PMDK, and the kernel used the same algorithms.

Yes, it would. Although I think PMDK would make a different decision
than the kernel when optimizing for highest bandwidth for the local
application vs bandwidth efficiency across all applications.
