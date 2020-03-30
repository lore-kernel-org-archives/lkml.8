Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA92C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A9420786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arJ+2m5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgC3GGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:06:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54251 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728642AbgC3GGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585548375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Z8MUb22p7ZiJoFtWbH8w9GnxOVCEYWuXorysUeb7ac=;
        b=arJ+2m5XmphN3zfVUnEZdbbG9rWLUk+WROsNbozeX/chWmq4p3bodCmXrDy8CfLeGf2heh
        CSTH4TCf76mbBU3Sw+6aD3tEPeOTKZkXKW2dYTC2YCxJqgxwA9LefDm2MwMqD/U9eXuUiL
        Qsh0bOpETvDgD9pGwkirqWwB3sFvvlM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-t1OW0_brOvWEnumgD1wIMQ-1; Mon, 30 Mar 2020 02:06:13 -0400
X-MC-Unique: t1OW0_brOvWEnumgD1wIMQ-1
Received: by mail-il1-f200.google.com with SMTP id g79so15698450ild.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 23:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Z8MUb22p7ZiJoFtWbH8w9GnxOVCEYWuXorysUeb7ac=;
        b=W8bdLtLAq9NXTLBcfMapt3J3coPDNnUNeL1RywVg4pmHF8r8nxY9oiY/0KHBZikaJi
         KOHUwBtiGD9mUnZINIRSfxXa57q5eQap0MC1Nwx3Rtt9li6hFChfjr4hOxJ65/2DQa88
         xIXkck6LXmcY2U8vFxCjQvvk3T5PpGcokKLwN68/OUgG9K389IyZDJvW6iC/rhIqX6DK
         d/tEJ3qmoZxEeLK+BDvWeIdVOhfPz3Mk/fFpRDoFTrClpD3BfTh0SMXzAFuE7pKjAPFQ
         D7AnAnwXRk7FbOkeouP47NwR1Ofdmj5gm2+ZC66lqHGx8dQdxWp0tnjZjj6akyPObn1y
         qb/g==
X-Gm-Message-State: ANhLgQ0+kMfFoILg9GcMg2mbpt8q4zlOIvPeY5pyYBeCcJ+fIt+ot+9c
        o66Fd2iaxajZRK4P21y4TwA+dd9C1iXddBlTNx8pwhua7NMcyeAymwU7toJO+XJrHR1KDIhcWAF
        9NEfHDpBidlxT9BWW/vo0vlCHNxKR5kgnyPVFCaiO
X-Received: by 2002:a02:5886:: with SMTP id f128mr9562948jab.90.1585548372560;
        Sun, 29 Mar 2020 23:06:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQT+OkauKtqxjcWqTugG3mPUS6iL3wOenAWEe+VQEhGQWTDfa7ppRS6Xx7Lin8b0dyX9tsWAk//LPtcMD1AbA=
X-Received: by 2002:a02:5886:: with SMTP id f128mr9562920jab.90.1585548372218;
 Sun, 29 Mar 2020 23:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200326162922.27085-1-graf@amazon.com> <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 30 Mar 2020 14:06:01 +0800
Message-ID: <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
To:     Dave Young <dyoung@redhat.com>
Cc:     Alexander Graf <graf@amazon.com>, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dwmw@amazon.com,
        benh@amazon.com, Jan Kiszka <jan.kiszka@siemens.com>,
        alcioa@amazon.com, aggh@amazon.com, aagch@amazon.com,
        dhr@amazon.com, Laszlo Ersek <lersek@redhat.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        brijesh.singh@amd.com,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 03/26/20 at 05:29pm, Alexander Graf wrote:
> > The swiotlb is a very convenient fallback mechanism for bounce buffering of
> > DMAable data. It is usually used for the compatibility case where devices
> > can only DMA to a "low region".
> >
> > However, in some scenarios this "low region" may be bound even more
> > heavily. For example, there are embedded system where only an SRAM region
> > is shared between device and CPU. There are also heterogeneous computing
> > scenarios where only a subset of RAM is cache coherent between the
> > components of the system. There are partitioning hypervisors, where
> > a "control VM" that implements device emulation has limited view into a
> > partition's memory for DMA capabilities due to safety concerns.
> >
> > This patch adds a command line driven mechanism to move all DMA memory into
> > a predefined shared memory region which may or may not be part of the
> > physical address layout of the Operating System.
> >
> > Ideally, the typical path to set this configuration would be through Device
> > Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> > in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> > instead configure the system purely through kernel command line options.
> >
> > I'm sure other people will find the functionality useful going forward
> > though and extend it to be triggered by DT/ACPI in the future.
>
> Hmm, we have a use case for kdump, this maybe useful.  For example
> swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
> kernel we have to increase the crashkernel reserved size for the extra
> swiotlb requirement.  I wonder if we can just reuse the old kernel's
> swiotlb region and pass the addr to kdump kernel.
>

Yes, definitely helpful for kdump kernel. This can help reduce the
crashkernel value.

Previously I was thinking about something similar, play around the
e820 entry passed to kdump and let it place swiotlb in wanted region.
Simply remap it like in this patch looks much cleaner.

If this patch is acceptable, one more patch is needed to expose the
swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
second kernel.

> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  3 +-
> >  Documentation/x86/x86_64/boot-options.rst       |  4 ++-
> >  kernel/dma/swiotlb.c                            | 46 +++++++++++++++++++++++--
> >  3 files changed, 49 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index c07815d230bc..d085d55c3cbe 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4785,11 +4785,12 @@
> >                       it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
> >
> >       swiotlb=        [ARM,IA-64,PPC,MIPS,X86]
> > -                     Format: { <int> | force | noforce }
> > +                     Format: { <int> | force | noforce | addr=<phys addr> }
> >                       <int> -- Number of I/O TLB slabs
> >                       force -- force using of bounce buffers even if they
> >                                wouldn't be automatically used by the kernel
> >                       noforce -- Never use bounce buffers (for debugging)
> > +                     addr=<phys addr> -- Try to allocate SWIOTLB at defined address
> >
> >       switches=       [HW,M68k]
> >
> > diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
> > index 2b98efb5ba7f..ca46c57b68c9 100644
> > --- a/Documentation/x86/x86_64/boot-options.rst
> > +++ b/Documentation/x86/x86_64/boot-options.rst
> > @@ -297,11 +297,13 @@ iommu options only relevant to the AMD GART hardware IOMMU:
> >  iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
> >  implementation:
> >
> > -    swiotlb=<pages>[,force]
> > +    swiotlb=<pages>[,force][,addr=<phys addr>]
> >        <pages>
> >          Prereserve that many 128K pages for the software IO bounce buffering.
> >        force
> >          Force all IO through the software TLB.
> > +      addr=<phys addr>
> > +        Try to allocate SWIOTLB at defined address
> >
> >  Settings for the IBM Calgary hardware IOMMU currently found in IBM
> >  pSeries and xSeries machines
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index c19379fabd20..83da0caa2f93 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -46,6 +46,7 @@
> >  #include <linux/init.h>
> >  #include <linux/memblock.h>
> >  #include <linux/iommu-helper.h>
> > +#include <linux/io.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/swiotlb.h>
> > @@ -102,6 +103,12 @@ unsigned int max_segment;
> >  #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
> >  static phys_addr_t *io_tlb_orig_addr;
> >
> > +/*
> > + * The TLB phys addr may be defined on the command line. Store it here if it is.
> > + */
> > +static phys_addr_t io_tlb_addr = INVALID_PHYS_ADDR;
> > +
> > +
> >  /*
> >   * Protect the above data structures in the map and unmap calls
> >   */
> > @@ -119,11 +126,23 @@ setup_io_tlb_npages(char *str)
> >       }
> >       if (*str == ',')
> >               ++str;
> > -     if (!strcmp(str, "force")) {
> > +     if (!strncmp(str, "force", 5)) {
> >               swiotlb_force = SWIOTLB_FORCE;
> > -     } else if (!strcmp(str, "noforce")) {
> > +             str += 5;
> > +     } else if (!strncmp(str, "noforce", 7)) {
> >               swiotlb_force = SWIOTLB_NO_FORCE;
> >               io_tlb_nslabs = 1;
> > +             str += 7;
> > +     }
> > +
> > +     if (*str == ',')
> > +             ++str;
> > +     if (!strncmp(str, "addr=", 5)) {
> > +             char *addrstr = str + 5;
> > +
> > +             io_tlb_addr = kstrtoul(addrstr, 0, &str);
> > +             if (addrstr == str)
> > +                     io_tlb_addr = INVALID_PHYS_ADDR;
> >       }
> >
> >       return 0;
> > @@ -239,6 +258,25 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> >       return 0;
> >  }
> >
> > +static int __init swiotlb_init_io(int verbose, unsigned long bytes)
> > +{
> > +     unsigned __iomem char *vstart;
> > +
> > +     if (io_tlb_addr == INVALID_PHYS_ADDR)
> > +             return -EINVAL;
> > +
> > +     vstart = memremap(io_tlb_addr, bytes, MEMREMAP_WB);
> > +     if (!vstart)
> > +             return -EINVAL;
> > +
> > +     if (swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose)) {
> > +             memunmap(vstart);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Statically reserve bounce buffer space and initialize bounce buffer data
> >   * structures for the software IO TLB used to implement the DMA API.
> > @@ -257,6 +295,10 @@ swiotlb_init(int verbose)
> >
> >       bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> >
> > +     /* Map IO TLB from device memory */
> > +     if (!swiotlb_init_io(verbose, bytes))
> > +             return;
> > +
> >       /* Get IO TLB memory from the low pages */
> >       vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
> >       if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
> > --
> > 2.16.4
> >
> >
> >
> >
> > Amazon Development Center Germany GmbH
> > Krausenstr. 38
> > 10117 Berlin
> > Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> > Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> > Sitz: Berlin
> > Ust-ID: DE 289 237 879
> >
> >
> >
>
> Thanks
> Dave
>


-- 
Best Regards,
Kairui Song

