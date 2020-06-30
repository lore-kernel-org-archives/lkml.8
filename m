Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F14C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9D2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbgF3MNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:13:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:33636 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387472AbgF3MNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:13:05 -0400
IronPort-SDR: ipBrSnIzWSF1XqaJ8hFkLsm0by4fK+Z16FlHHW8a8UNCfuHtrfR9mdoUDEZ6W9GqFRjMq5R9ht
 eRrYL/xrNEEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="164223896"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="164223896"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 05:13:04 -0700
IronPort-SDR: 21wCZXE5dcWpOhMs8SS3CgqIIzPBVAd9zImwOAXO+sqtMZgrsnTnSLZBEI8xgor26bH2kdaQPe
 cCpMUW30pKgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="386680785"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2020 05:13:01 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 30 Jun 2020 15:13:00 +0300
Date:   Tue, 30 Jun 2020 15:13:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        juhapekka.heikkila@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resource: Do not exclude regions that are marked as
 MMIO in EFI memmap
Message-ID: <20200630121300.GO5180@lahna.fi.intel.com>
References: <20200302141451.18983-1-mika.westerberg@linux.intel.com>
 <20200626224344.GA1992137@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200626224344.GA1992137@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 05:43:44PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 02, 2020 at 05:14:51PM +0300, Mika Westerberg wrote:
> > Commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> > space") made the resource allocation code to avoid all regions that are
> > in E820 table. This prevents the kernel to assign MMIO resources to
> > regions that may be real RAM for example.
> > 
> > However, at least with Lenovo Yoca C940 and S740 this causes problems
> > when allocating resources for PCIe devices behind Thunderbolt port(s).
> > 
> > On Yoga S740 the E820 table contains an entry like this:
> > 
> >   BIOS-e820: [mem 0x000000002bc50000-0x00000000cfffffff] reserved
> > 
> > and ACPI _CRS method for the host bridge returns these windows:
> > 
> >   pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> >   pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> >   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> >   pci_bus 0000:00: root bus resource [mem 0x45400000-0xbfffffff window]
> >   pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
> > 
> > Note that the 0x45400000-0xbfffffff entry is also included in the E820
> > table and marked as "reserved".
> > 
> > When Thunderbolt device is connected and the PCIe gets tunneled PCI core
> > tries to allocate memory for the new devices but it fails because all
> > the resources are inside this reserved region so arch_remove_reservations()
> > clips them which makes the resource assignment fail as in below log:
> > 
> >   pci 0000:00:07.0: PCI bridge to [bus 01-2a]
> >   pci 0000:00:07.0:   bridge window [mem 0x46000000-0x521fffff]
> >   pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
> >   ...
> >   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 07-2a] add_size 100000 add_align 100000
> >   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 07-2a] add_size 100000 add_align 100000
> >   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 02-2a] add_size 100000 add_align 100000
> >   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 02-2a] add_size 100000 add_align 100000
> >   pci 0000:01:00.0: bridge window [io  0x1000-0x5fff] shrunken by 0x0000000000004000
> >   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff] extended by 0x000000000bd00000
> >   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] extended by 0x000000001bb00000
> >   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff] extended by 0x000000000bd00000
> >   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] extended by 0x000000001bb00000
> >   pci 0000:01:00.0: BAR 8: no space for [mem size 0x0c200000]
> >   pci 0000:01:00.0: BAR 8: failed to assign [mem size 0x0c200000]
> >   pci 0000:01:00.0: BAR 9: assigned [mem 0x6000000000-0x601bffffff 64bit pref]
> >   pci 0000:01:00.0: BAR 7: assigned [io  0x4000-0x4fff]
> > 
> > The 01:00.0 is the upstream port of the PCIe switch that is connected to
> > the PCIe root port (00:07.1) over Thunderbolt link.
> > 
> > If I add "efi=debug" to the command line I can see that the EFI memory
> > map actually contains several entries:
> > 
> >   [Reserved           |   |  |  |  |  |  |  | |   |WB|WT|WC|UC] range=[0x000000002bc50000-0x000000003fffffff] (323MB)
> >   [Reserved           |   |  |  |  |  |  |  | |   |WB|  |  |UC] range=[0x0000000040000000-0x0000000040ffffff] (16MB)
> >   [Reserved           |   |  |  |  |  |  |  | |   |  |  |  |  ] range=[0x0000000041000000-0x00000000453fffff] (68MB)
> >   [Memory Mapped I/O  |RUN|  |  |  |  |  |  | |   |  |  |  |UC] range=[0x0000000045400000-0x00000000cfffffff] (2220MB)
> > 
> > I think the EFI stub merges these consecutive entries into that single
> > E820 entry showed above. The last region marked as EFI_MEMORY_MAPPED_IO
> > actually covers the PCI host bridge window entirely. However, since
> > there is corresponding E820 type for this it is simply marked as
> > E820_TYPE_RESERVED.
> 
> Is this supposed to say "since there is *no* corresponding E820 type"?

Yes, I think it makes more sense that way :)

> I guess this refers to setup_e820()?  I see the switch case there that
> sets e820_type to E820_TYPE_RESERVED for EFI_MEMORY_MAPPED_IO.
> 
> I'm really not familiar with the EFI stub, but I guess that when
> booting with EFI, we basically build our own E820 table based on the
> EFI memory map, then use that constructed E820 table to initialize
> iomem_resource via e820__reserve_resources()?
> 
> I wonder why we don't just use the EFI memory map to initialize
> iomem_resource directly.  It seems like the EFI map -> E820 table ->
> iomem_resource path adds complication that makes issues like this more
> likely.
>
> IIUC, this patch allows Linux to use EFI_MEMORY_MAPPED_IO for PCI MMIO
> space, i.e., if "avail" is in a EFI_MEMORY_MAPPED_IO region, we don't
> need to consider it "reserved" and we can put PCI resources there.
> 
> UEFI v2.8, Table 30 (doc p 160, PDF p 233) says about
> EfiMemoryMappedIO that
> 
>   before ExitBootServices():
> 
>     Used by system firmware to request that a memory-mapped IO region
>     be mapped by the OS to a virtual address so it can be accessed by
>     EFI runtime services.
> 
>   after ExitBootServices():
> 
>     This memory is not used by the OS. All system memory-mapped IO
>     information should come from ACPI tables.
> 
> I would read that as basically saying that the OS must virtually map
> EfiMemoryMappedIO for use by EFI runtime services (I don't know if
> Linux uses any of those).
> 
> The "after ExitBootServices()" part doesn't seem very clear to me.
> "This memory is not used by the OS" isn't quite stated as a
> requirement for the OS.  And "All .. MMIO information should come from
> ACPI tables" sounds like the OS should *ignore* this EFI map in favor
> of ACPI.

It is not clear to me either and I'm not 100% sure the patch here is the
correct thing to do. I think we may need some help from x86 maintainers
for a proper fix.

> So I don't know how to fix this.  I just feel like this patch adds
> complication to an already very messy flow.  We may have to do that,
> but it always makes me sad ;)
> 
> > All in all, I think we can fix this by modifying arch_remove_reservations()
> > to check the EFI type as well and if it is EFI_MEMORY_MAPPED_IO skip the
> > clipping in that case.
> > 
> > Reported-by: Benoit Grégoire <benoitg@coeus.ca>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  arch/x86/kernel/resource.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> > index 9b9fb7882c20..c0bc9117dd7d 100644
> > --- a/arch/x86/kernel/resource.c
> > +++ b/arch/x86/kernel/resource.c
> > @@ -1,4 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <linux/efi.h>
> >  #include <linux/ioport.h>
> >  #include <asm/e820/api.h>
> >  
> > @@ -36,6 +37,36 @@ static void remove_e820_regions(struct resource *avail)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_EFI
> > +static bool efi_mmio_mem(const struct resource *avail)
> > +{
> > +	resource_size_t start, end;
> > +	efi_memory_desc_t desc;
> > +
> > +	if (!efi_enabled(EFI_MEMMAP) ||
> > +	    efi_mem_desc_lookup(avail->start, &desc))
> > +		return false;
> > +
> > +	start = desc.phys_addr;
> > +	end = desc.phys_addr + (desc.num_pages << EFI_PAGE_SHIFT) - 1;
> > +
> > +	/*
> > +	 * No need to clip the resource if it is fully contained in an
> > +	 * EFI memory mapped region.
> > +	 */
> > +	if (avail->start >= start && avail->end <= end &&
> > +	    desc.type == EFI_MEMORY_MAPPED_IO)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +#else
> > +static inline bool efi_mmio_mem(const struct resource *avail)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  void arch_remove_reservations(struct resource *avail)
> >  {
> >  	/*
> > @@ -46,6 +77,7 @@ void arch_remove_reservations(struct resource *avail)
> >  	if (avail->flags & IORESOURCE_MEM) {
> >  		resource_clip(avail, BIOS_ROM_BASE, BIOS_ROM_END);
> >  
> > -		remove_e820_regions(avail);
> > +		if (!efi_mmio_mem(avail))
> > +			remove_e820_regions(avail);
> >  	}
> >  }
> > -- 
> > 2.25.0
> > 
