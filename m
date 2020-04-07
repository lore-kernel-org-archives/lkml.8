Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E00C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7692075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="A+y7Wiu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgDGRxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:53:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36190 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGRxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:53:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id i7so5192572edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fReP27+S8EmMViT0XclWb7BSpfuyZbaoShchCIlF6Rg=;
        b=A+y7Wiu9/0A8vN6mcp7HvaDsjMwJO9AiWFfp037z19Xog8YupjaaQW8koO92zoDEYp
         IIvfWWPYQvToilZuR266uHofWkFgFHJWE7gBge/mg1MdLy61ROA/rRkjTEZTs/OyOQks
         LvETkaIYIytm/YeFp9IKbufW09FRI3HnLkGFIvfTszWm6sCKqCpxOuSYGkRG/OvZpNEx
         CIziu9ZH1ri7BfmrVjIFn2ptCSb5niuwl/HDMTrp7jrlhx9ThbXOib0ikEeqIf/0SpOX
         H5TR1y52tUGQxOyggfm/7VC6rN0zsSX6nlmQLQkK0KC6I/goIFCY5WWX2d9uKCHzLsZP
         TE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fReP27+S8EmMViT0XclWb7BSpfuyZbaoShchCIlF6Rg=;
        b=eFFJxLLQdjSUBbWVlb+YdWb234rezZIbT4kPI+Oy67AwMeVoAwhaU3wVnL20MHkg7C
         7V9U8CUorLAaKKx0Zv9R+k1pV76/lLm+C7wanDCogSz9VpOEpMfTKa9ewKaPICQ4Sxy/
         S5UMKbOt2gLFSJZgSv7+KS7747l/lwQN0vZu7yiuqfzx0Z0LiYAWLY5I3gb2oIQGZ0Oh
         ipmspM10y9lRHqCW+5mEygDOBfKCl+yKDImr94J6zIVTalJr0xBBdXCyg+AWM91IpuH6
         GX8AJaT1c1GsCDvG+mG1DR5GUtuii9g6Cj8/uNlE/fqD4tLOWH80ManukKMM5JqGVYHM
         eGOg==
X-Gm-Message-State: AGi0PubzECKJOc3haBTokFh9ti9DjQCdQDH6DDZNWjeq84NrsnN7S30F
        FUWZobtoM4p1gcJGJqmko/SFYwnl+RMcyWZFaNYFfQ==
X-Google-Smtp-Source: APiQypJ57XlctB5m5vpEXm+L/8pvYvG+sfnlbPnmuml+0OdDWKFc7GxhEGybYQcVpM/HElMl+IAh2syFW1PO5P0sDow=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr3043907ejj.317.1586281990650;
 Tue, 07 Apr 2020 10:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Apr 2020 10:52:58 -0700
Message-ID: <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com>
Subject: Re: [PATCH] memcpy_flushcache: use cache flusing for larger lengths
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 8:02 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> [ resending this to x86 maintainers ]
>
> Hi
>
> I tested performance of various methods how to write to optane-based
> persistent memory, and found out that non-temporal stores achieve
> throughput 1.3 GB/s. 8 cached stores immediatelly followed by clflushopt
> or clwb achieve throughput 1.6 GB/s.
>
> memcpy_flushcache uses non-temporal stores, I modified it to use cached
> stores + clflushopt and it improved performance of the dm-writecache
> target significantly:
>
> dm-writecache throughput:
> (dd if=/dev/zero of=/dev/mapper/wc bs=64k oflag=direct)
> writecache block size   512             1024            2048            4096
> movnti                  496 MB/s        642 MB/s        725 MB/s        744 MB/s
> clflushopt              373 MB/s        688 MB/s        1.1 GB/s        1.2 GB/s
>
> For block size 512, movnti works better, for larger block sizes,
> clflushopt is better.

This should use clwb instead of clflushopt, the clwb macri
automatically converts back to clflushopt if clwb is not supported.

>
> I was also testing the novafs filesystem, it is not upstream, but it
> benefitted from similar change in __memcpy_flushcache and
> __copy_user_nocache:
> write throughput on big files - movnti: 662 MB/s, clwb: 1323 MB/s
> write throughput on small files - movnti: 621 MB/s, clwb: 1013 MB/s
>
>
> I submit this patch for __memcpy_flushcache that improves dm-writecache
> performance.
>
> Other ideas - should we introduce memcpy_to_pmem instead of modifying
> memcpy_flushcache and move this logic there? Or should I modify the
> dm-writecache target directly to use clflushopt with no change to the
> architecture-specific code?

This also needs to mention your analysis that showed that this can
have negative cache pollution effects [1], so I'm not sure how to
decide when to make the tradeoff. Once we have movdir64b the tradeoff
equation changes yet again:

[1]: https://lore.kernel.org/linux-nvdimm/alpine.LRH.2.02.2004010941310.23210@file01.intranet.prod.int.rdu2.redhat.com/


>
> Mikulas
>
>
>
>
> From: Mikulas Patocka <mpatocka@redhat.com>
>
> I tested dm-writecache performance on a machine with Optane nvdimm and it
> turned out that for larger writes, cached stores + cache flushing perform
> better than non-temporal stores. This is the throughput of dm-writecache
> measured with this command:
> dd if=/dev/zero of=/dev/mapper/wc bs=64 oflag=direct
>
> block size      512             1024            2048            4096
> movnti          496 MB/s        642 MB/s        725 MB/s        744 MB/s
> clflushopt      373 MB/s        688 MB/s        1.1 GB/s        1.2 GB/s
>
> We can see that for smaller block, movnti performs better, but for larger
> blocks, clflushopt has better performance.
>
> This patch changes the function __memcpy_flushcache accordingly, so that
> with size >= 768 it performs cached stores and cache flushing. Note that
> we must not use the new branch if the CPU doesn't have clflushopt - in
> that case, the kernel would use inefficient "clflush" instruction that has
> very bad performance.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>
> ---
>  arch/x86/lib/usercopy_64.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> Index: linux-2.6/arch/x86/lib/usercopy_64.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/lib/usercopy_64.c   2020-03-24 15:15:36.644945091 -0400
> +++ linux-2.6/arch/x86/lib/usercopy_64.c        2020-03-30 07:17:51.450290007 -0400
> @@ -152,6 +152,42 @@ void __memcpy_flushcache(void *_dst, con
>                         return;
>         }
>
> +       if (static_cpu_has(X86_FEATURE_CLFLUSHOPT) && size >= 768 && likely(boot_cpu_data.x86_clflush_size == 64)) {
> +               while (!IS_ALIGNED(dest, 64)) {
> +                       asm("movq    (%0), %%r8\n"
> +                           "movnti  %%r8,   (%1)\n"
> +                           :: "r" (source), "r" (dest)
> +                           : "memory", "r8");
> +                       dest += 8;
> +                       source += 8;
> +                       size -= 8;
> +               }
> +               do {
> +                       asm("movq    (%0), %%r8\n"
> +                           "movq   8(%0), %%r9\n"
> +                           "movq  16(%0), %%r10\n"
> +                           "movq  24(%0), %%r11\n"
> +                           "movq    %%r8,   (%1)\n"
> +                           "movq    %%r9,  8(%1)\n"
> +                           "movq   %%r10, 16(%1)\n"
> +                           "movq   %%r11, 24(%1)\n"
> +                           "movq  32(%0), %%r8\n"
> +                           "movq  40(%0), %%r9\n"
> +                           "movq  48(%0), %%r10\n"
> +                           "movq  56(%0), %%r11\n"
> +                           "movq    %%r8, 32(%1)\n"
> +                           "movq    %%r9, 40(%1)\n"
> +                           "movq   %%r10, 48(%1)\n"
> +                           "movq   %%r11, 56(%1)\n"
> +                           :: "r" (source), "r" (dest)
> +                           : "memory", "r8", "r9", "r10", "r11");
> +                       clflushopt((void *)dest);
> +                       dest += 64;
> +                       source += 64;
> +                       size -= 64;
> +               } while (size >= 64);
> +       }
> +
>         /* 4x8 movnti loop */
>         while (size >= 32) {
>                 asm("movq    (%0), %%r8\n"
>
