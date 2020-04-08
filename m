Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9307BC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565E120692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgDHOkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:40:36 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgDHOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:40:36 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MNKyQ-1jgUgr0nlq-00Ols8 for <linux-kernel@vger.kernel.org>; Wed, 08 Apr
 2020 16:40:35 +0200
Received: by mail-lj1-f181.google.com with SMTP id t17so7814867ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:40:35 -0700 (PDT)
X-Gm-Message-State: AGi0PubBHVuJd+22YejogtWoUQK3uozZiuL1hhgK1bcxTYT89srpsJOZ
        IMWzETjB2R5l9u+CTEJsEpeb9vz6X+qzW8sGZKw=
X-Google-Smtp-Source: APiQypLewTqfZcv6F/HmA6qKyW+AsRQU8geLrryZL5eYVp+qfIlNJmLNmarm8H7M8ujqQhceSXEm+lDo7WEA2aWGkDA=
X-Received: by 2002:a2e:9395:: with SMTP id g21mr5492407ljh.8.1586356834608;
 Wed, 08 Apr 2020 07:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200331093241.3728-1-tesheng@andestech.com> <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com>
In-Reply-To: <20200408035118.GA1451@andestech.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Apr 2020 16:40:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
Message-ID: <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
To:     Alan Kao <alankao@andestech.com>
Cc:     Eric Lin <tesheng@andestech.com>, Gary Guo <gary@garyguo.net>,
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
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zuqFSP6LlEtxXXPYw35KmR4nQjw6mbFgjdOLv0/+LfNubEKM4au
 QOj66QnOOjR8JAiP8TqyPFeMa5uuDC+WOWbnNw2irSkbmS+a0Q8NwOoF35kTepg/CMmYv1T
 VYVz+MfffBtXIeyoHuURk1wbDadWBfI5x7KjoZMFBq3zedk4T/qC3SyhYcLVTzJwhN76Zsl
 I8c14xRUEjEoPugjA82tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O5BcCLH0Gyc=:y6x3cMP4SgSkMqYbmxSh+B
 ff5+6UtHCKWmpcUG6PrFwu/M+l+t24LoNxWjErA3r4yE3S514qroW0Jy+L1mSGjG5R/n0KdIL
 5sl9hT4VY1IX6iEjY43uqxoO4A93nAPiyKioAvf+8xNzIqCUvvB2NsQIOuk5oong3XUV7ecca
 VHbMecN5ffkVXbX+z6ur1pSyI6dTNjyEFfK40jIH5mcTXYntT/WxM7IkFcIL4jpVi93umI021
 hWHkVUFKSxxuvb0Gnfb/fR/GjRDcNexNI+yQ9yX+gh9lR4L+1V4UzrUuIXPv3MINvE+j02yoU
 9jZLHT0llHQGFpW0B35xie1BS7MNTFQhR+/0aGHf2FoBdWzL2swBduFtwudJUNQl0RtEj7H+y
 fIiOM9AkzgcSKrbCDyN5QX6ciIJ4wLLDiC7DUSX7GeNnP983U5YcmIyUhiW8KEiWgNHP2NsVu
 XFhi97+3tnT9sJz2Y79u4+Fsjcy854NO7T3UGVMlsHg0ECkMrneINHGR/IGwiuynNHxa6SMlO
 iWxfaW866veAlwFn9haGffuFh2Hk3TuBknGuh+HYh+ORto1nUxOhFGs+mMn77g8CPKXqnN6KJ
 0WEQoEYPIL7iuACROO/o2V/XK0SWgwiXtaPbF6akklIdrY5PMNTCWQnhJ0SxDXI/xTw1O1vxi
 q+2oZiv9uNxoNXeyCcsKvmb6nIPvTeWfHpB3nY2KVEN8DNIf6w3wnLNNzEm/S/kVdq83/yuca
 ZYDgD1c7CkqnMkO2LnMz8F+QWT0Kfw2PalPoVmqqlEYVtX8XsvIjRdxkFxPcRjQKyYhy8b92q
 41PZfz8OzS7fX6sZTfEPRfaBiI0LomOwezOWM8zqgt3uoVTZ1U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 5:52 AM Alan Kao <alankao@andestech.com> wrote:
> On Thu, Apr 02, 2020 at 11:31:37AM +0200, Arnd Bergmann wrote:
> > On Tue, Mar 31, 2020 at 11:34 AM Eric Lin <tesheng@andestech.com> wrote:
> > For the arm32 architecture, we are thinking about implementing a
> > VMPLIT_4G_4G option to replace highmem in the long run. The most
> > likely way this would turn out at the moment looks like:
> >
>
> Thanks for sharing the status from ARM32.  Is there any available branch
> already?  It would be good to have a reference implementation.

No code yet, so far not much more than the ideas that I listed. We
are currently looking for someone interested in doing the work
or maybe sponsoring it if they have a strong interest.

If someone does it for RISC-V first, that would of course also help on ARM ;-)

> > - have a 256MB region for vmalloc space at the top of the 4GB address
> >   space, containing vmlinux, module, mmio mappings and vmalloc
> >   allocations
> >
> > - have 3.75GB starting at address zero for either user space or the
> >   linear map.
> >
> > - reserve one address space ID for kernel mappings to avoid tlb flushes
> >   during normal context switches
> >
> > - On any kernel entry, switch the page table to the one with the linear
> >   mapping, and back to the user page table before returning to user space
> >
>
> After some survey I found previous disccusion
> (https://lkml.org/lkml/2019/4/24/2110). The 5.2-based patch ended up not
> being merged.  But at least we will have something to start if we want to.

Ah, I see. What is the current requirement for ASIDs in hardware
implementations? If support for more than one address space is
optional, that would make the VMSPLIT_4G support fairly expensive
as it requires a full TLB flush for each context switch.

> Also interestingly, there was a PR for privileged spec that separates
> addressing modes (https://github.com/riscv/riscv-isa-manual/pull/128) as
> Sdas extension, but there was no progress afterwards.

Right, this sounds like the ideal implementation. This is what is done
in arch/s390 and probably a few of the others.

> Not very related to this thread, but there were some discussion about
> ASID design in RISC-V (https://github.com/riscv/riscv-isa-manual/issues/348).
> It is now in ratified 1.11 privileged spec.

Ok, so I suppose that would apply to about half the 32-bit implementations
and most of the future ones, but not the ones implementing the 1.10 spec
or earlier, right?

> It seems to me that VMSPLIT_4G_4G is quite different from other VMSPLITs,
> because it requires much more changes.
>
> Thanks for showing the stance of kernel community against HIGHMEM support.
> The cited discussion thread is comprehensive and clear.  Despite that RV32
> users cannot get upstream support for their large memory, mechnisms like
> VMSPLIT_4G_4G seems to be a promising way to go.  That being said, to
> support the theoretical 16G physical memory, eventually kmap* will still
> be needed.

I had not realized that Sv32 supports more than 4GB physical address
space at all. I agree that if someone puts that much RAM into a machine,
there are few alternatives to highmem (in theory one could use the
extra RAM for zswap/zram, but that's not a good replacement).

OTOH actually using more than 1GB or 2GB of physical memory on a
32-bit core is something that I expect to become completely obscure
in the future, as this is where using 32-bit cores tends to get
uneconomical. The situation that I observe across the currently supported
32-bit architectures in the kernel is that:

- There is an incentive to run 32-bit on machines with 1GB of RAM  or less
  if you have the choice, because of higher memory  consumption and
  cache utilization on 64-bit code. On systems  with 2GB or more, the
  cost of managing that memory using 32-bit  code usually outweighs
  the benefits and you should run at least a 64-bit kernel.

- The high end 32-bit cores (Arm Cortex-A15/A17, MIPS P5600,
  PowerPC 750, Intel Pentium 4, Andes A15/D15, ...) are all obsolete
  after the follow-on products use 64-bit cores on a smaller process
  node, which end up being more capable, faster *and* cheaper.

- The 32-bit cores that do survive are based on simpler in-order
  pipelines that are cheaper and can still beat the 64-bit cores in
  terms of cost (mostly chip area, sometimes royalties), but not
  performance. This includes Arm Cortex-A7, MIPS 24k and typical
  RV32 cores.

- On an SoC with a cheap and simple CPU core, there is no point
  in spending a lot of money/area/complexity on a high-end memory
  controller. On single-core 32-bit SoCs, you usually end up with single
  16 or 32-bit wide DDR2 memory controller, on an SMP system like
  most quad-Cortex-A7, you have a 32-bit wide DDR3 controller, but no
  DDR4 or LP-DDR3/4.

- The largest economical memory configuration on a 32-bit DDR3
  controller is to have two 256Mx16 chips for a total of 1GB. You can
  get 2GB with four chips using dual-channel controllers or 512Mx8
  memory, but anything beyond that is much more expensive than
  upgrading to a 64-bit SoC with LP-DDR4.

This is unlikely to change over time as 64-bit chips are also getting
cheaper and may replace more of the 32-bit chips we see today.
In particular, I expect to see multi-core chips moving to mostly
64-bit cores over time, while 32-bit chips keep using one or
occasionally two cores, further reducing the need for large and/or
fast memory.

        Arnd
