Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22874C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0778D2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgGVJoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:44:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGVJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:44:10 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M3DeV-1jxLwj0sXt-003bxP for <linux-kernel@vger.kernel.org>; Wed, 22 Jul
 2020 11:44:08 +0200
Received: by mail-qt1-f174.google.com with SMTP id o22so1094451qtt.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:44:08 -0700 (PDT)
X-Gm-Message-State: AOAM532xPoNGxTTlGnE/1BHACRiL6bGtjvM/0Xc6QV3O1glN11ttle9s
        ALfjToL5QDcHRMh5YNg8oWp7yQYAq3bEznfkQ/0=
X-Google-Smtp-Source: ABdhPJxwkYMqqlMOkCtiDhkAnK0U1Z3J/eM92Y3pA2ZYfCjSxZxJC559Vt8UZd0LKulfbnhn81unz3J72RGNNuPEagQ=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr33522432qtq.304.1595411047084;
 Wed, 22 Jul 2020 02:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <7cb2285e-68ba-6827-5e61-e33a4b65ac03@ghiti.fr> <mhng-08bff01a-ca15-4bbc-8454-2ca3e823fef8@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-08bff01a-ca15-4bbc-8454-2ca3e823fef8@palmerdabbelt-glaptop1>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Jul 2020 11:43:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a34sT2bQbkZUjaxaShzCkn+s35pXxS0UNhqGFu+t2hZYw@mail.gmail.com>
Message-ID: <CAK8P3a34sT2bQbkZUjaxaShzCkn+s35pXxS0UNhqGFu+t2hZYw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux-MM <linux-mm@kvack.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Mackerras <paulus@samba.org>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UdL+knbubfZO1AGP4zdXTM6MPoW1ddEKSJ9gnTlGDCvNqCZOZEw
 h7xYd4Z82KexpL1F5SWl0llW+VV4zjyqCDMNJgmfoWPfeyfElOaHZbUNEPml4/4BVHj9NTd
 u9ZLALnOmGXCNNalKf5YntaxDIT7NGyXxFtlRqLPMC3f4VI8Yu/bPk3ndzTtLuwo7145vO8
 t7fnWFT+GXcm+NrVfwyeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rPhSp6j4HFc=:D0mTTq/+TBMJicx/ruZrBq
 prQE0fqVtH6TDtF3OUlsR7jsujvzoc645Jnvc3Vqje2ezGonwPEE4a7UIJpa8+yfSg5vrEN0a
 eK0BLZBXp95dHTewqa5V35SafwaZOLccXVxNl4S5cA+HH7hVvbONC2WmJBQRPZkr24wT+1tgx
 M2xPKgJOj1SlSHkALc1OZ1wAGpMqlFqFr8rrnwH0c2uaMvTfBbqWiMqV3ntjwvkvn77yd1bO+
 UsWyxG7WumXCbTvEKRgtOMy8T70Df2fvSgP9kerk6NmFLXyL3fmMNW7oiSqYrORTApMXuaI2m
 q+UAgYIU1UfyQzoyGo9xvBm2yF6Ecie2Ckh75gYP9lh5UkXIBMiKzMpvxQpZtd9LEo0S0YtWL
 fxmrC3gbJ696D8HDsDzwyVhLh3XjIBSpSXN7N/OW8TfaRsM+OLdmrCFAeZWXT9ZbmV1ybi4n4
 c5exjUWTWLCMRiDXddMkfJCIJzX+VYZui1Snp97S/wm4QvYKTty08WqzCYU64qnLHw/NyM0So
 ziKJpHbWO4fZfQvGW+NNdhxJLEc43WbXF9QFDZn50Vik9Qpt7QBGT726iuitsvLADAO0VH5dc
 10SsKjwPJ25UDm7XNV8gy+KIbO+JdTAOw+uobVWvSofgomKHzEnEH4sg8vAzUQTBMa+FKfhRs
 h5reHE1hloNRWlvs44zN0bsC42YgNtdYwtx6XRD1rfgpblqf1Dvx7Z/Z1A57f/VmP7gaDDu8i
 qBvIGAIHqG2vwQmP5Gop4pYDICQvWuNpYYH+PEYkJc00HJIGgQc1GPux7cEvG8f79Cz/Elj7l
 wxADClbXeRepMILenVuXdmwyNNkhK4vzg4qQub6j82lUlbI4wUi+3nfRwFeLLjybfUb6riuQ+
 FPMeGfR0QFe0hFF5laLv0ZCi2/dCI6gaK73A34Pp1CbY6yyfbgot8CukGda1vDGNX+eY4/t3N
 5r2cKbCbrUzQxEwylj+veETrpqYCgh8kSw505JfTHgJaoqdCvKwMv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 9:06 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 21 Jul 2020 11:36:10 PDT (-0700), alex@ghiti.fr wrote:
> > Let's try to make progress here: I add linux-mm in CC to get feedback on
> > this patch as it blocks sv48 support too.
>
> Sorry for being slow here.  I haven't replied because I hadn't really fleshed
> out the design yet, but just so everyone's on the same page my problems with
> this are:
>
> * We waste vmalloc space on 32-bit systems, where there isn't a lot of it.

There is actually an ongoing work to make 32-bit Arm kernels move
vmlinux into the vmalloc space, as part of the move to avoid highmem.

Overall, a 32-bit system would waste about 0.1% of its virtual address space
by having the kernel be located in both the linear map and the vmalloc area.
It's not zero, but not that bad either. With the typical split of 3072 MB user,
768MB linear and 256MB vmalloc, it's also around 1.5% of the available
vmalloc area (assuming a 4MB vmlinux in a typical 32-bit kernel), but the
boundaries can be changed arbitrarily if needed.

The eventual goal is to have a split of 3840MB for either user or linear map
plus and 256MB for vmalloc, including the kernel. Switching between linear
and user has a noticeable runtime overhead, but it relaxes both the limits
for user memory and lowmem, and it provides a somewhat stronger
address space isolation.

Another potential idea would be to completely randomize the physical
addresses underneath the kernel by using a random permutation of the
pages in the kernel image. This adds even more overhead (virt_to_phys
may need to call vmalloc_to_page or similar) and may cause problems
with DMA into kernel .data across page boundaries,

> * Sort out how to maintain a linear map as the canonical hole moves around
>   between the VA widths without adding a bunch of overhead to the virt2phys and
>   friends.  This is probably going to be the trickiest part, but I think if we
>   just change the page table code to essentially lie about VAs when an sv39
>   system runs an sv48+sv39 kernel we could make it work -- there'd be some
>   logical complexity involved, but it would remain fast.

I assume you can't use the trick that x86 has where all kernel addresses
are at the top of the 64-bit address space and user addresses are at the
bottom, regardless of the size of the page tables?

      Arnd
