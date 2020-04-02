Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FB9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030CB2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgDBJb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:31:56 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:31:56 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MlO9r-1iuClr41qn-00lpBO for <linux-kernel@vger.kernel.org>; Thu, 02 Apr
 2020 11:31:55 +0200
Received: by mail-qt1-f177.google.com with SMTP id t17so2614184qtn.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:31:54 -0700 (PDT)
X-Gm-Message-State: AGi0PuZWrPDQm8FP6TAVP9EDtII0P2MN4xMOyeio7uQXE7oJs0Zf1vc6
        F6WmXD48cLJ2/g2BqCMrgxCbWDyr8PK0/0giSWc=
X-Google-Smtp-Source: APiQypIyue+WNACvV18x6JnZkYlMs/gOnvsaV2sZZDOWo0BguT88H770dmf7hJplDaKl5fSsfEZ3gDVMPZpGGw8NTyc=
X-Received: by 2002:ac8:7292:: with SMTP id v18mr1898092qto.304.1585819913839;
 Thu, 02 Apr 2020 02:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200331093241.3728-1-tesheng@andestech.com>
In-Reply-To: <20200331093241.3728-1-tesheng@andestech.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Apr 2020 11:31:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
Message-ID: <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
To:     Eric Lin <tesheng@andestech.com>
Cc:     linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Gary Guo <gary@garyguo.net>, alex@ghiti.fr,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, atish.patra@wdc.com,
        yash.shah@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <green.hu@gmail.com>, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mZH8CricPUBuTLMEoGKz3luhD0XBZqzmZPaec3uE5Oo1LZLiu9D
 nCes7BdOdjX+e4OPEKf6KJnl1GOMTQWYpTNxnTm7e2XtWAdpnk3Qge0D5jy17NzlI5A7ErB
 0DZe1ugkS5xHJdYyo7whtWwsJb0P2sRLo3xtJ42HTUNedx200T1rjTuzjh6B6K6GvRLe93K
 Jey3pyfWYCxxbcUy/IdLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UFvhvFuRUEE=:xw+s9AXkz80ZpQ1r/k1Xc7
 /gFz7NzfkWyb8X/hs4CYFW/8Sf4WKLQ7cvI9lhIcML19pgr/1xW6mgngfEkkfzZcedPeeU/2S
 kdpb3P2IDwB4Ukt/pA9PSLgLzfBJom56etCNtoM9Z/uAILL+VZRll1q8ZP1xepEL2droxQn8I
 jzVYrCjTg0RqfNKQFfqLJgXfU7E4Me3ZDpgIYHv2eI5TRPrZKW5qiZAsn94OnKSgij5kd43Ft
 aJ/S1H+JzBEqRF+DTESUzRetyEnsl3oXCHF3iplqAuujv4FUYbK7w9rUAoAuNukkwVefiAfGd
 a25eZzMtWI1wW/p6tkWm8HuPO97ANj6rYxBIgZlkFnMcj1H60EfAFx45eeYdXcAIorij5JIXN
 XQawJDhBTC9hW3GRl//0gFKNa4yOIgdzDgk1CzT1NIklw3Stt/E1UUI6x4UVWq27zjL6KrX57
 VvIHJKvpQy9seVy/UKS8nePKxtAVZbeoOC0Vxg/pDf3eaBk4xptWAL0pv4YXh0lDGYc7m11Ss
 i/oSjKRsqXgs+h9if94OkJPGhEN5oRdgA0ocSVBbiGMLT1LRnEn/Lydu/le8U5aM0/cfNgFys
 9QyXE1ETyGbGv2vxCoXQs+4aJF49I9i/A9o0wdnyTEstLzEc+SqD6FJZe25c+vWaZ9h+ZihDM
 96vDehiyngFz2iBHugjjVe14QTIie9j9+fxcjGG3GptYxQzDRWYzYxlA/fETfSB4/SG46oOQI
 Z6r8mAoAFHtvw6qrsBPIw1iQ6NorWFEDpV6bticRli0mN+qG/+VGsq/1mMOfYGAgrfburGbyG
 Adaelst6Wt7j0L2LwGoANwNB06b/bUC645myozAHpRYtlvJkSc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:34 AM Eric Lin <tesheng@andestech.com> wrote:
>
> With Highmem support, the kernel can map more than 1GB physical memory.
>
> This patchset implements Highmem for RV32, referencing to mostly nds32
> and others like arm and mips, and it has been tested on Andes A25MP platform.

I would much prefer to not see highmem added to new architectures at all
if possible, see https://lwn.net/Articles/813201/ for some background.

For the arm32 architecture, we are thinking about implementing a
VMPLIT_4G_4G option to replace highmem in the long run. The most
likely way this would turn out at the moment looks like:

- have a 256MB region for vmalloc space at the top of the 4GB address
  space, containing vmlinux, module, mmio mappings and vmalloc
  allocations

- have 3.75GB starting at address zero for either user space or the
  linear map.

- reserve one address space ID for kernel mappings to avoid tlb flushes
  during normal context switches

- On any kernel entry, switch the page table to the one with the linear
  mapping, and back to the user page table before returning to user space

- add a generic copy_from_user/copy_to_user implementation based
  on get_user_pages() in asm-generic/uaccess.h, using memcpy()
  to copy from/to the page in the linear map.

- possible have architectures override get_user/put_user to use a
  cheaper access based on a page table switch to read individual
  words if that is cheaper than get_user_pages().

There was an implementation of this for x86 a long time ago, but
it never got merged, mainly because there were no ASIDs on x86
at the time and the TLB flushing during context switch were really
expensive. As far as I can tell, all of the modern embedded cores
do have ASIDs, and unlike x86, most do not support more than 4GB
of physical RAM, so this scheme can work to replace highmem
in most of the remaining cases, and provide additional benefits
(larger user address range, higher separate of kernel/user addresses)
at a relatively small performance cost.

       Arnd
