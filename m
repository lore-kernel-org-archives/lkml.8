Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F088C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0249521D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634262AbgDPL4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:56:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:21328 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634441AbgDPLzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:55:55 -0400
IronPort-SDR: Ry/mSWwhScbHXjW/4hYOfPRvNn2aH749AAA54qxRsoYnqX1AdlU8d8WVpi5aZOpg5318h6dOgn
 36ooTq+ZS+6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 04:55:48 -0700
IronPort-SDR: 6xbYQ7bm74P+/k++sH19edQ8IvZr3u8OVOUZTSYZxrg/ppO9a108MLvLFWS8LOQHLBIHjc5c0G
 A0XADJuXrQUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363976114"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 16 Apr 2020 04:55:45 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Apr 2020 14:55:44 +0300
Date:   Thu, 16 Apr 2020 14:55:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        juhapekka.heikkila@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resource: Do not exclude regions that are marked as
 MMIO in EFI memmap
Message-ID: <20200416115544.GY2586@lahna.fi.intel.com>
References: <20200302141451.18983-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302141451.18983-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 05:14:51PM +0300, Mika Westerberg wrote:
> Commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> space") made the resource allocation code to avoid all regions that are
> in E820 table. This prevents the kernel to assign MMIO resources to
> regions that may be real RAM for example.
> 
> However, at least with Lenovo Yoca C940 and S740 this causes problems
> when allocating resources for PCIe devices behind Thunderbolt port(s).
> 
> On Yoga S740 the E820 table contains an entry like this:
> 
>   BIOS-e820: [mem 0x000000002bc50000-0x00000000cfffffff] reserved
> 
> and ACPI _CRS method for the host bridge returns these windows:
> 
>   pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>   pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>   pci_bus 0000:00: root bus resource [mem 0x45400000-0xbfffffff window]
>   pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
> 
> Note that the 0x45400000-0xbfffffff entry is also included in the E820
> table and marked as "reserved".
> 
> When Thunderbolt device is connected and the PCIe gets tunneled PCI core
> tries to allocate memory for the new devices but it fails because all
> the resources are inside this reserved region so arch_remove_reservations()
> clips them which makes the resource assignment fail as in below log:
> 
>   pci 0000:00:07.0: PCI bridge to [bus 01-2a]
>   pci 0000:00:07.0:   bridge window [mem 0x46000000-0x521fffff]
>   pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
>   ...
>   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 07-2a] add_size 100000 add_align 100000
>   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 07-2a] add_size 100000 add_align 100000
>   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 02-2a] add_size 100000 add_align 100000
>   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 02-2a] add_size 100000 add_align 100000
>   pci 0000:01:00.0: bridge window [io  0x1000-0x5fff] shrunken by 0x0000000000004000
>   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff] extended by 0x000000000bd00000
>   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] extended by 0x000000001bb00000
>   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff] extended by 0x000000000bd00000
>   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] extended by 0x000000001bb00000
>   pci 0000:01:00.0: BAR 8: no space for [mem size 0x0c200000]
>   pci 0000:01:00.0: BAR 8: failed to assign [mem size 0x0c200000]
>   pci 0000:01:00.0: BAR 9: assigned [mem 0x6000000000-0x601bffffff 64bit pref]
>   pci 0000:01:00.0: BAR 7: assigned [io  0x4000-0x4fff]
> 
> The 01:00.0 is the upstream port of the PCIe switch that is connected to
> the PCIe root port (00:07.1) over Thunderbolt link.
> 
> If I add "efi=debug" to the command line I can see that the EFI memory
> map actually contains several entries:
> 
>   [Reserved           |   |  |  |  |  |  |  | |   |WB|WT|WC|UC] range=[0x000000002bc50000-0x000000003fffffff] (323MB)
>   [Reserved           |   |  |  |  |  |  |  | |   |WB|  |  |UC] range=[0x0000000040000000-0x0000000040ffffff] (16MB)
>   [Reserved           |   |  |  |  |  |  |  | |   |  |  |  |  ] range=[0x0000000041000000-0x00000000453fffff] (68MB)
>   [Memory Mapped I/O  |RUN|  |  |  |  |  |  | |   |  |  |  |UC] range=[0x0000000045400000-0x00000000cfffffff] (2220MB)
> 
> I think the EFI stub merges these consecutive entries into that single
> E820 entry showed above. The last region marked as EFI_MEMORY_MAPPED_IO
> actually covers the PCI host bridge window entirely. However, since
> there is corresponding E820 type for this it is simply marked as
> E820_TYPE_RESERVED.
> 
> All in all, I think we can fix this by modifying arch_remove_reservations()
> to check the EFI type as well and if it is EFI_MEMORY_MAPPED_IO skip the
> clipping in that case.
> 
> Reported-by: Benoit Grégoire <benoitg@coeus.ca>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Hello, any comments for this?
