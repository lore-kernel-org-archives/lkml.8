Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76CEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898E42073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgEDL1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:27:50 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgEDL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:27:50 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5CMP-1j3YFF0wSr-011DFF for <linux-kernel@vger.kernel.org>; Mon, 04 May
 2020 13:27:48 +0200
Received: by mail-qk1-f171.google.com with SMTP id i14so4852097qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 04:27:48 -0700 (PDT)
X-Gm-Message-State: AGi0PuZvXndvkmVdut3iGs0aopXJQvYMpBIXQIjJQlEOmI/Qrm5lyfYF
        4IKWuhQquyXEsungG+06+NLvNQeB7iJ2M9uoM2E=
X-Google-Smtp-Source: APiQypIIHoujLODItegRRgCsMaNglRK7LNUpimxq01cun2hB/w8fYeIm4nZCEGen6hYmmyMPRHB0gBdjFi2URrtAcZQ=
X-Received: by 2002:a37:a492:: with SMTP id n140mr16289220qke.352.1588591667069;
 Mon, 04 May 2020 04:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200331093241.3728-1-tesheng@andestech.com> <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com> <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc> <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc> <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com> <20200504091018.GA24897@afzalpc>
In-Reply-To: <20200504091018.GA24897@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 May 2020 13:27:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
Message-ID: <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alan Kao <alankao@andestech.com>,
        Eric Lin <tesheng@andestech.com>, Gary Guo <gary@garyguo.net>,
        alex@ghiti.fr, David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>, atish.patra@wdc.com,
        yash.shah@sifive.com, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <green.hu@gmail.com>, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-riscv@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:h8TK6tTY8IJxPzp2xKXu8vHec7/caLMkY2RIP/P9mLMkxvHhpnV
 TNe/DZbrW75p+bANVWhmSdm6gFNckfZ1xt+sYhark9ua3PTFyc6uLmnIYEMm0zVAh5XToit
 snzAVVynsnbO/Xb06UEOtuuTGbXFUr8J7Ugp0vt47SM30oxRvMEMgjfl5UbQb4cqp5R7AKu
 E60a40gmC+5WkGMpUUJbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:41GJnzizHjA=:6G4P0KRSZ2watz0fMnPHg/
 GBQWiNAt03J2AKbpF9rkhkNV1S6hMmptTR3S6ZnWfYLjJtoGPBc/A8PdBydod3gYyLKnmGWZ5
 7x6ypjbgyMwXFnLb2OVNoaiPfsR41Mm8iqAeOQ3qShv7IR7DCtsGxAsVtxrfeeBWxM2yG2ilc
 nI/qsFdjpnfpuMx/WjWU7XJlAaTFh2Sc7S4VMzew8S0i18NmBjptOI1WK56SCMETCYFxmFERZ
 u8MEuPclhyD66pzxwP3V45bqPhuZi5sFISWJT0mIGBc9xlVvjWB8oLe1NCBJfg8mDduLbSBOC
 GzgHvDHOAA5rMEG6kwPiHdw1ew9HJOvhvBmxYQIcFNaHL2k1RhWouxsQQeqW90fHyK4xkbsuZ
 OgY6fIpSJK90QPumlE7BZgZx1DTE0fnR1Hw/5QQGBO2osL2JmnVE4bKFqdpQ1D/gOmgn/fxc/
 Fxymm6VQwjkHN0sEWDn2OSeLRnjq21EX2adZBIw1OzB2W0fSpF+LtOrqjnIk/x+Zrn08zsg6F
 wY4IK1pWQgUlVxbPFqI0aYUVi/9LOgGDG/wzDjqT8x72waAH+pkJulJRLdm/dWcgQYaX8SKsD
 dQTXvbWKzV0drzViT5biWe+TETLThTB2Zc3kDBuah2ZrV3kbt1yVDJsSf5Y3WCucj6+5fRSCV
 3SwAWN2h8Aql0xTYKko4aoTkB8BuCcWiSwqK/qHmLHf6OTrMPgLSp7JzHt1j49pBmaUwUnuDG
 CLUHmm+VcGRQnsXl/Chvo8cSGTh0XYKj5WVY6jqouqXpjiJrwqculzN9tlsxMwJO7KhJR8ezV
 jl7LNYEl4hwzdeEU954jiNpJ2d3P/MoneBXrk3Z0YKB7wLAF1Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 11:10 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> [ +linux-arm-kernel
>
>   Context: This is regarding VMSPLIT_4G_4G support for 32-bit ARM as a
>   possible replacement to highmem. For that, initially, it is being
>   attempted to move static kernel mapping from lowmem to vmalloc space.
>
>   in next reply, i will remove everyone/list !ARM related ]
>
> Hi,
>
> On Sun, May 03, 2020 at 10:20:39PM +0200, Arnd Bergmann wrote:
>
> > Which SoC platform are you running this on? Just making
> > sure that this won't conflict with static mappings later.
>
> Versatile Express V2P-CA15 on qemu, qemu options include --smp 2 &
> 2GB memory.

Ok

> BTW, i could not convince myself why, except for DEBUG_LL, static io
> mappings are used.

I don't think vexpress uses it, but others have some 'struct map_desc'
instances mostly for historic reasons, e.g. to map some registers that
are needed at very early boot time, or from assembler files.

> > One problem I see immediately in arm_memblock_init()
>
> Earlier it went past arm_memblock_init(), issue was clearing the page
> tables from VMALLOC_START in devicemaps_init() thr' paging_init(),
> which was like cutting the sitting branch of the tree.
>
> Now it is crashing at debug_ll_io_init() of devicemap_init(), and
> printascii/earlycon was & is being used to debug :). Things are going
> wrong when it tries to create mapping for debug_ll. It looks like a
> conflict with static mapping, which you mentioned above, at the same
> time i am not seeing kernel static mapping in the same virtual
> address, need to dig deeper.
>
> Also tried removing DEBUG_LL, there is a deafening silence in the
> console ;)

I don't think there is any other mapping that would conflict with the
DEBUG_LL one, but you may be in a hole where the existing one
is not mapped. IIRC it first gets mapped in __create_page_tables()
in arch/arm/kernel/head.S, and later in debug_ll_io_init(), but if the
old page tables were just discarded, it won't work for a bit.

Using gdb to step through the code in qemu is often more reliable
than printing to the console, at least until you get to the point
when you have registered the real console.

> __virt_to_phys_nodebug() which does the actual work on __pa() invocation
> has been modifed to handle that case (ideas lifted from ARM64's
> implementation), though currently it is a hack as below (and applicable
> only for ARM_PATCH_PHYS_VIRT disabled case), other hacks being
> VMALLOC_OFFSET set to 0 and adjusting vmalloc size.
>
>         static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
>         {
>                 phys_addr_t __x = (phys_addr_t)x;
>
>                 if (__x >= 0xf0000000)
>                         return __x - KIMAGE_OFFSET + PHYS_OFFSET;
>                 else
>                         return __x - PAGE_OFFSET + PHYS_OFFSET;
>         }

Ok, makes sense.

     Arnd
