Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B870C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D1824691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582803137;
	bh=HU09JxLn5bTho5NWXLn1P6vFZOqsLfYaVQjriqt+Uvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WcCwa64zXkm7hP8MBJNt4RiovZ1AFzy9MwsbyXrNnXtD9cbrOvISNoaELxOWXVvkj
	 wvOyYt+BrCokn7GQhHEOXz4xWBmpZV3ytuBD2A8C9ud/QkAJCnPcSeaEDYI6X3Rorq
	 WwL+8jeAid+rVxXsS1vKALLk5N+zp9Sh3j+n2XIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgB0LcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:32:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39524 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgB0LcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:32:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so2870190wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 03:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C4esCCEXzA9O/ZWJZ5LBenzR34LsnG7TIkAp2w+tRTM=;
        b=sK4C8W8nGWw8WmwKArw/oh8d5lDI4YVuIPEQcaRbJCSzVOkYztuuivz4F1O0XHYrty
         P/nk8m8GH8Uf5c4PkKWQ5iBpzLIq2JKad1ECnfJx8/CSl2FWmoVxXqxJezgfgRHD+RyW
         vMoVDGK5pljbZHaAZApapCcvWNbzgXpJ6/Hy49xfE0RCE8BSZ4/Ec9fKNK79TheW2RVD
         z5xJY3fPwwWxPaQ/UQBCdV5MnP38+d7fAFvO5y/2eonyTbMbaviPja7whbl/kCBQv6I2
         YDJi9Fauw74jjICLjp2YdapVgMaoCIb0ss/ARQeWxpVs97lGpQODNDSyZl1imkK3Q97z
         Fvbw==
X-Gm-Message-State: APjAAAVQfZdrPdT3u9pUGg3pK0wuDvQ1HbkFe8w4x/iPCP5WrlVUC+jE
        7ZdJQ65Odz9NYYd4gAHfJYk=
X-Google-Smtp-Source: APXvYqxYQsN1KKyRDZ2jPgkUFn3+5Dd9zj5m3oXsYgzv4NiBvZWTQ2RmCkjWlA7nmJAyFubcaEd91g==
X-Received: by 2002:a5d:4584:: with SMTP id p4mr4705494wrq.25.1582803120512;
        Thu, 27 Feb 2020 03:32:00 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y12sm1541133wrq.0.2020.02.27.03.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 03:31:58 -0800 (PST)
Date:   Thu, 27 Feb 2020 12:31:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-mm@molgen.mpg.de
Subject: Re: kernel BUG at mm/vmscan.c:1740! in `isolate_lru_pages()`
Message-ID: <20200227113157.GC3771@dhcp22.suse.cz>
References: <ac86ad84-f3ad-8cf4-916d-21cb2839df82@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac86ad84-f3ad-8cf4-916d-21cb2839df82@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-02-20 11:49:33, Paul Menzel wrote:
> Dear Andrew folks, dear Linux folks,
> 
> 
> On a four socket Dell PowerEdge R815 with AMD Opterons 6276, Linux 5.4.14
> hit the kernel bug below. We were *not* able to reproduce it yet.

Can you reproduce this problem? If yes, do you see the same with vanilla
5.4 kernel or 5.5 resp. current Linus' git tree?

For the record the BUG() is triggered because __isolate_lru_page has
returned an unexpected error. The RAX says it is EINVAL which suggests
that the given page is not PageLRU() and that shouldn't really happen
because the function is isolating pages on the LRU list or it is
unevictable. Both suggest an unexpected/corrupted LRU list state.
820729629730 ("mm: fix trying to reclaim unevictable lru page when
calling madvise_pageout") was dealing with a problem similar to the
later one but from a completely different path and it already is 5.4.
I believe that seeing the full page state might help.

Something like

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c05eb9efec07..8db9e8103094 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1688,6 +1688,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 			continue;
 
 		default:
+			dump_page(page, NULL);
 			BUG();
 		}
 	}
 
> [10834.604899] ------------[ cut here ]------------
> [10834.604906] kernel BUG at mm/vmscan.c:1740!
> [10834.604917] invalid opcode: 0000 [#1] SMP NOPTI
> [10834.609485] CPU: 46 PID: 409 Comm: kswapd3 Kdump: loaded Not tainted 5.4.14.mx64.317 #1
> [10834.617505] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [10834.625014] RIP: 0010:isolate_lru_pages+0x367/0x370
> [10834.629904] Code: e9 53 4d 89 f8 41 54 48 8b 4c 24 18 8b 54 24 28 8b 74 24 40 e8 4a 3b c4 00 49 8b 06 48 83 c4 18 48 85 c0 75 d0 e9 c4 fe ff ff <0f> 0b e8 42 c0 ea ff 66 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54
> [10834.648716] RSP: 0018:ffffc9000d407ae0 EFLAGS: 00010082
> [10834.653955] RAX: 00000000ffffffea RBX: ffffea00e0800008 RCX: ffff88bfdc595420
> [10834.661103] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea00e0800000
> [10834.668253] RBP: ffffc9000d407de8 R08: ffffc9000d407de8 R09: 0000000000000020
> [10834.675401] R10: 00000000f0000000 R11: 0000000000000000 R12: ffff88bfdc595420
> [10834.682549] R13: 0000000000000001 R14: 0000000000000010 R15: 0000000000000010
> [10834.689698] FS:  0000000000000000(0000) GS:ffff88bfdfb80000(0000) knlGS:0000000000000000
> [10834.697802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [10834.703559] CR2: 000000000060d348 CR3: 0000004fd3876000 CR4: 00000000000406e0
> [10834.710709] Call Trace:
> [10834.713170]  shrink_inactive_list+0x113/0x3d0
> [10834.717543]  shrink_node_memcg+0x3c8/0x800
> [10834.721655]  ? shrink_slab+0x295/0x2c0
> [10834.725417]  ? shrink_slab+0x295/0x2c0
> [10834.729179]  ? shrink_node+0xb6/0x420
> [10834.732866]  shrink_node+0xb6/0x420
> [10834.736367]  balance_pgdat+0x250/0x550
> [10834.740130]  kswapd+0x15d/0x3f0
> [10834.743286]  ? wait_woken+0x80/0x80
> [10834.746785]  ? balance_pgdat+0x550/0x550
> [10834.750724]  kthread+0x117/0x130
> [10834.753968]  ? kthread_create_worker_on_cpu+0x70/0x70
> [10834.759039]  ret_from_fork+0x22/0x40
> [10834.762627] Modules linked in: nfsv4 nfs rpcsec_gss_krb5 ext4 mbcache jbd2 8021q garp stp mrp llc input_leds led_class mgag200 drm_vram_helper ttm kvm_amd drm_kms_helper kvm drm fb_sys_fops syscopyarea sysfillrect sysimgblt ixgbe irqbypass 3w_9xxx crc32c_intel acpi_cpufreq nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc ip_tables x_tables unix ipv6 nf_defrag_ipv6 autofs4
> [10834.796386] ---[ end trace 28611096f6473c90 ]---
> 
> More traces follow in the log. Please find the full log attached.
> 
> Here is the code in question from `mm/vmscan.c`:
> 
> 1699         while (scan < nr_to_scan && !list_empty(src)) {
> 1700                 struct page *page;
> 1701 
> 1702                 page = lru_to_page(src);
> 1703                 prefetchw_prev_lru_page(page, src, flags);
> 1704 
> 1705                 VM_BUG_ON_PAGE(!PageLRU(page), page);
> 1706 
> 1707                 nr_pages = compound_nr(page);
> 1708                 total_scan += nr_pages;
> 1709 
> 1710                 if (page_zonenum(page) > sc->reclaim_idx) {
> 1711                         list_move(&page->lru, &pages_skipped);
> 1712                         nr_skipped[page_zonenum(page)] += nr_pages;
> 1713                         continue;
> 1714                 }
> 1715 
> 1716                 /*
> 1717                  * Do not count skipped pages because that makes the function
> 1718                  * return with no isolated pages if the LRU mostly contains
> 1719                  * ineligible pages.  This causes the VM to not reclaim any
> 1720                  * pages, triggering a premature OOM.
> 1721                  *
> 1722                  * Account all tail pages of THP.  This would not cause
> 1723                  * premature OOM since __isolate_lru_page() returns -EBUSY
> 1724                  * only when the page is being freed somewhere else.
> 1725                  */
> 1726                 scan += nr_pages;
> 1727                 switch (__isolate_lru_page(page, mode)) {
> 1728                 case 0:
> 1729                         nr_taken += nr_pages;
> 1730                         nr_zone_taken[page_zonenum(page)] += nr_pages;
> 1731                         list_move(&page->lru, dst);
> 1732                         break;
> 1733 
> 1734                 case -EBUSY:
> 1735                         /* else it is being freed elsewhere */
> 1736                         list_move(&page->lru, src);
> 1737                         continue;
> 1738 
> 1739                 default:
> 1740                         BUG();
> 1741                 }
> 1742         }
> 
> We haven’t seen this before with Linux versions up to 4.19.57, but
> also only started to use this system as a cluster node now. Before
> it was used interactively.
> 
> Could this be a regression from 4.19.x to 5.4?
> 
> 
> Kind regards,
> 
> Paul

> [    0.000000] Linux version 5.4.14.mx64.317 (root@thebiglebowserver.molgen.mpg.de) (gcc version 7.5.0 (GCC)) #1 SMP Thu Jan 23 14:24:25 CET 2020
> [    0.000000] Command line: BOOT_IMAGE=/boot/bzImage.x86_64 root=LABEL=root ro crashkernel=256M console=ttyS1,115200n8 console=tty0 init=/bin/systemd audit=0 random.trust_cpu=on
> [    0.000000] random: get_random_u32 called from bsp_init_amd+0x1be/0x2e0 with crng_init=0
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000df678fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000df679000-0x00000000df68efff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000df68f000-0x00000000df6cdfff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000df6ce000-0x00000000dfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fec8ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec94000-0x00000000feccffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fecd4000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000801effffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.6 present.
> [    0.000000] DMI: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2300.046 MHz processor
> [    0.009143] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.009145] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.017164] AGP: No AGP bridge found
> [    0.017314] last_pfn = 0x801f000 max_arch_pfn = 0x400000000
> [    0.017321] MTRR default type: uncachable
> [    0.017322] MTRR fixed ranges enabled:
> [    0.017323]   00000-9FFFF write-back
> [    0.017324]   A0000-BFFFF uncachable
> [    0.017325]   C0000-CBFFF write-protect
> [    0.017326]   CC000-EBFFF uncachable
> [    0.017327]   EC000-FFFFF write-protect
> [    0.017328] MTRR variable ranges enabled:
> [    0.017330]   0 base 000000000000 mask FF8000000000 write-back
> [    0.017332]   1 base 008000000000 mask FFFFF0000000 write-back
> [    0.017333]   2 base 008010000000 mask FFFFF8000000 write-back
> [    0.017334]   3 base 008018000000 mask FFFFFC000000 write-back
> [    0.017335]   4 base 0000E0000000 mask FFFFE0000000 uncachable
> [    0.017336]   5 disabled
> [    0.017337]   6 disabled
> [    0.017337]   7 disabled
> [    0.017339] TOM2: 000000801f000000 aka 524784M
> [    0.019624] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.019777] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
> [    0.019781] last_pfn = 0xdf679 max_arch_pfn = 0x400000000
> [    0.026307] found SMP MP-table at [mem 0x000fe710-0x000fe71f]
> [    0.026322] Using GB pages for direct mapping
> [    0.026325] BRK [0x02c01000, 0x02c01fff] PGTABLE
> [    0.026328] BRK [0x02c02000, 0x02c02fff] PGTABLE
> [    0.026329] BRK [0x02c03000, 0x02c03fff] PGTABLE
> [    0.026366] BRK [0x02c04000, 0x02c04fff] PGTABLE
> [    0.026367] BRK [0x02c05000, 0x02c05fff] PGTABLE
> [    0.026717] RAMDISK: [mem 0x375e7000-0x37aeafff]
> [    0.026722] ACPI: Early table checksum verification disabled
> [    0.026726] ACPI: RSDP 0x00000000000F11D0 000024 (v02 DELL  )
> [    0.026731] ACPI: XSDT 0x00000000000F1258 0000A4 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026737] ACPI: FACP 0x00000000DF6AC250 0000F4 (v03 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026743] ACPI BIOS Warning (bug): Invalid length for FADT/Pm2ControlBlock: 16, using default 8 (20190816/tbfadt-674)
> [    0.026748] ACPI: DSDT 0x00000000DF68F000 008D78 (v01 DELL   PE_SC3   00000001 INTL 20050624)
> [    0.026752] ACPI: FACS 0x00000000DF6AE000 000040
> [    0.026755] ACPI: FACS 0x00000000DF6AE000 000040
> [    0.026758] ACPI: APIC 0x00000000DF6AB478 000260 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026762] ACPI: SPCR 0x00000000DF6AB6DC 000050 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026766] ACPI: HPET 0x00000000DF6AB730 000038 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026769] ACPI: MCFG 0x00000000DF6AB76C 00003C (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026772] ACPI: WD__ 0x00000000DF6AB7AC 000134 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026776] ACPI: SLIC 0x00000000DF6AB8E4 000024 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026780] ACPI: ERST 0x00000000DF697F18 000270 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026783] ACPI: HEST 0x00000000DF698188 000354 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026787] ACPI: BERT 0x00000000DF697D78 000030 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026790] ACPI: EINJ 0x00000000DF697DA8 000170 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026794] ACPI: IV__ 0x00000000DF6ABA68 000030 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026797] ACPI: SRAT 0x00000000DF6ABA9C 0005C0 (v02 AMD    AGESA    00000001 AMD  00000001)
> [    0.026801] ACPI: SLIT 0x00000000DF6AC178 00006C (v01 AMD    AGESA    00000001 AMD  00000001)
> [    0.026804] ACPI: SSDT 0x00000000DF6AF000 00B7A4 (v01 AMD    POWERNOW 00000001 AMD  00000001)
> [    0.026808] ACPI: TCPA 0x00000000DF6AC1E8 000064 (v02 DELL   PE_SC3   00000001 DELL 00000001)
> [    0.026817] ACPI: Local APIC address 0xfee00000
> [    0.026864] SRAT: PXM 0 -> APIC 0x00 -> Node 0
> [    0.026866] SRAT: PXM 0 -> APIC 0x01 -> Node 0
> [    0.026867] SRAT: PXM 0 -> APIC 0x02 -> Node 0
> [    0.026868] SRAT: PXM 0 -> APIC 0x03 -> Node 0
> [    0.026869] SRAT: PXM 0 -> APIC 0x04 -> Node 0
> [    0.026871] SRAT: PXM 0 -> APIC 0x05 -> Node 0
> [    0.026872] SRAT: PXM 0 -> APIC 0x06 -> Node 0
> [    0.026873] SRAT: PXM 0 -> APIC 0x07 -> Node 0
> [    0.026874] SRAT: PXM 1 -> APIC 0x08 -> Node 1
> [    0.026875] SRAT: PXM 1 -> APIC 0x09 -> Node 1
> [    0.026877] SRAT: PXM 1 -> APIC 0x0a -> Node 1
> [    0.026878] SRAT: PXM 1 -> APIC 0x0b -> Node 1
> [    0.026879] SRAT: PXM 1 -> APIC 0x0c -> Node 1
> [    0.026880] SRAT: PXM 1 -> APIC 0x0d -> Node 1
> [    0.026881] SRAT: PXM 1 -> APIC 0x0e -> Node 1
> [    0.026882] SRAT: PXM 1 -> APIC 0x0f -> Node 1
> [    0.026884] SRAT: PXM 2 -> APIC 0x20 -> Node 2
> [    0.026885] SRAT: PXM 2 -> APIC 0x21 -> Node 2
> [    0.026886] SRAT: PXM 2 -> APIC 0x22 -> Node 2
> [    0.026887] SRAT: PXM 2 -> APIC 0x23 -> Node 2
> [    0.026888] SRAT: PXM 2 -> APIC 0x24 -> Node 2
> [    0.026889] SRAT: PXM 2 -> APIC 0x25 -> Node 2
> [    0.026891] SRAT: PXM 2 -> APIC 0x26 -> Node 2
> [    0.026892] SRAT: PXM 2 -> APIC 0x27 -> Node 2
> [    0.026893] SRAT: PXM 3 -> APIC 0x28 -> Node 3
> [    0.026894] SRAT: PXM 3 -> APIC 0x29 -> Node 3
> [    0.026895] SRAT: PXM 3 -> APIC 0x2a -> Node 3
> [    0.026896] SRAT: PXM 3 -> APIC 0x2b -> Node 3
> [    0.026898] SRAT: PXM 3 -> APIC 0x2c -> Node 3
> [    0.026899] SRAT: PXM 3 -> APIC 0x2d -> Node 3
> [    0.026900] SRAT: PXM 3 -> APIC 0x2e -> Node 3
> [    0.026901] SRAT: PXM 3 -> APIC 0x2f -> Node 3
> [    0.026902] SRAT: PXM 4 -> APIC 0x40 -> Node 4
> [    0.026903] SRAT: PXM 4 -> APIC 0x41 -> Node 4
> [    0.026904] SRAT: PXM 4 -> APIC 0x42 -> Node 4
> [    0.026906] SRAT: PXM 4 -> APIC 0x43 -> Node 4
> [    0.026907] SRAT: PXM 4 -> APIC 0x44 -> Node 4
> [    0.026908] SRAT: PXM 4 -> APIC 0x45 -> Node 4
> [    0.026909] SRAT: PXM 4 -> APIC 0x46 -> Node 4
> [    0.026910] SRAT: PXM 4 -> APIC 0x47 -> Node 4
> [    0.026911] SRAT: PXM 5 -> APIC 0x48 -> Node 5
> [    0.026913] SRAT: PXM 5 -> APIC 0x49 -> Node 5
> [    0.026914] SRAT: PXM 5 -> APIC 0x4a -> Node 5
> [    0.026915] SRAT: PXM 5 -> APIC 0x4b -> Node 5
> [    0.026916] SRAT: PXM 5 -> APIC 0x4c -> Node 5
> [    0.026917] SRAT: PXM 5 -> APIC 0x4d -> Node 5
> [    0.026918] SRAT: PXM 5 -> APIC 0x4e -> Node 5
> [    0.026919] SRAT: PXM 5 -> APIC 0x4f -> Node 5
> [    0.026921] SRAT: PXM 6 -> APIC 0x60 -> Node 6
> [    0.026922] SRAT: PXM 6 -> APIC 0x61 -> Node 6
> [    0.026923] SRAT: PXM 6 -> APIC 0x62 -> Node 6
> [    0.026924] SRAT: PXM 6 -> APIC 0x63 -> Node 6
> [    0.026925] SRAT: PXM 6 -> APIC 0x64 -> Node 6
> [    0.026926] SRAT: PXM 6 -> APIC 0x65 -> Node 6
> [    0.026928] SRAT: PXM 6 -> APIC 0x66 -> Node 6
> [    0.026929] SRAT: PXM 6 -> APIC 0x67 -> Node 6
> [    0.026930] SRAT: PXM 7 -> APIC 0x68 -> Node 7
> [    0.026931] SRAT: PXM 7 -> APIC 0x69 -> Node 7
> [    0.026932] SRAT: PXM 7 -> APIC 0x6a -> Node 7
> [    0.026933] SRAT: PXM 7 -> APIC 0x6b -> Node 7
> [    0.026935] SRAT: PXM 7 -> APIC 0x6c -> Node 7
> [    0.026936] SRAT: PXM 7 -> APIC 0x6d -> Node 7
> [    0.026937] SRAT: PXM 7 -> APIC 0x6e -> Node 7
> [    0.026938] SRAT: PXM 7 -> APIC 0x6f -> Node 7
> [    0.026941] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
> [    0.026943] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xdfffffff]
> [    0.026945] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x101fffffff]
> [    0.026947] ACPI: SRAT: Node 1 PXM 1 [mem 0x1020000000-0x201fffffff]
> [    0.026948] ACPI: SRAT: Node 2 PXM 2 [mem 0x2020000000-0x301fffffff]
> [    0.026950] ACPI: SRAT: Node 3 PXM 3 [mem 0x3020000000-0x401fffffff]
> [    0.026951] ACPI: SRAT: Node 4 PXM 4 [mem 0x4020000000-0x501fffffff]
> [    0.026952] ACPI: SRAT: Node 5 PXM 5 [mem 0x5020000000-0x601fffffff]
> [    0.026954] ACPI: SRAT: Node 6 PXM 6 [mem 0x6020000000-0x701fffffff]
> [    0.026955] ACPI: SRAT: Node 7 PXM 7 [mem 0x7020000000-0x801effffff]
> [    0.026960] NUMA: Initialized distance table, cnt=8
> [    0.026964] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xdfffffff] -> [mem 0x00000000-0xdfffffff]
> [    0.026966] NUMA: Node 0 [mem 0x00000000-0xdfffffff] + [mem 0x100000000-0x101fffffff] -> [mem 0x00000000-0x101fffffff]
> [    0.026974] NODE_DATA(0) allocated [mem 0x101fffc000-0x101fffffff]
> [    0.026979] NODE_DATA(1) allocated [mem 0x201fffc000-0x201fffffff]
> [    0.026984] NODE_DATA(2) allocated [mem 0x301fffc000-0x301fffffff]
> [    0.026990] NODE_DATA(3) allocated [mem 0x401fffc000-0x401fffffff]
> [    0.026996] NODE_DATA(4) allocated [mem 0x501fffc000-0x501fffffff]
> [    0.027003] NODE_DATA(5) allocated [mem 0x601fffc000-0x601fffffff]
> [    0.027009] NODE_DATA(6) allocated [mem 0x701fffc000-0x701fffffff]
> [    0.027016] NODE_DATA(7) allocated [mem 0x801eff9000-0x801effcfff]
> [    0.027033] Reserving 256MB of memory at 3312MB for crashkernel (System RAM: 524262MB)
> [    0.027701] Zone ranges:
> [    0.027702]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.027704]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.027706]   Normal   [mem 0x0000000100000000-0x000000801effffff]
> [    0.027708] Movable zone start for each node
> [    0.027709] Early memory node ranges
> [    0.027711]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
> [    0.027713]   node   0: [mem 0x0000000000100000-0x00000000df678fff]
> [    0.027715]   node   0: [mem 0x0000000100000000-0x000000101fffffff]
> [    0.027723]   node   1: [mem 0x0000001020000000-0x000000201fffffff]
> [    0.027731]   node   2: [mem 0x0000002020000000-0x000000301fffffff]
> [    0.027740]   node   3: [mem 0x0000003020000000-0x000000401fffffff]
> [    0.027749]   node   4: [mem 0x0000004020000000-0x000000501fffffff]
> [    0.027757]   node   5: [mem 0x0000005020000000-0x000000601fffffff]
> [    0.027766]   node   6: [mem 0x0000006020000000-0x000000701fffffff]
> [    0.027774]   node   7: [mem 0x0000007020000000-0x000000801effffff]
> [    0.027821] Zeroed struct page in unavailable ranges: 2538 pages
> [    0.027823] Initmem setup node 0 [mem 0x0000000000001000-0x000000101fffffff]
> [    0.027825] On node 0 totalpages: 16774678
> [    0.027826]   DMA zone: 64 pages used for memmap
> [    0.027827]   DMA zone: 21 pages reserved
> [    0.027828]   DMA zone: 3997 pages, LIFO batch:0
> [    0.027912]   DMA32 zone: 14234 pages used for memmap
> [    0.027913]   DMA32 zone: 910969 pages, LIFO batch:63
> [    0.046593]   Normal zone: 247808 pages used for memmap
> [    0.046595]   Normal zone: 15859712 pages, LIFO batch:63
> [    0.358727] Initmem setup node 1 [mem 0x0000001020000000-0x000000201fffffff]
> [    0.358730] On node 1 totalpages: 16777216
> [    0.358732]   Normal zone: 262144 pages used for memmap
> [    0.358733]   Normal zone: 16777216 pages, LIFO batch:63
> [    0.738971] Initmem setup node 2 [mem 0x0000002020000000-0x000000301fffffff]
> [    0.738974] On node 2 totalpages: 16777216
> [    0.738976]   Normal zone: 262144 pages used for memmap
> [    0.738977]   Normal zone: 16777216 pages, LIFO batch:63
> [    1.151301] Initmem setup node 3 [mem 0x0000003020000000-0x000000401fffffff]
> [    1.151304] On node 3 totalpages: 16777216
> [    1.151306]   Normal zone: 262144 pages used for memmap
> [    1.151307]   Normal zone: 16777216 pages, LIFO batch:63
> [    1.698906] Initmem setup node 4 [mem 0x0000004020000000-0x000000501fffffff]
> [    1.698910] On node 4 totalpages: 16777216
> [    1.698912]   Normal zone: 262144 pages used for memmap
> [    1.698913]   Normal zone: 16777216 pages, LIFO batch:63
> [    2.136888] Initmem setup node 5 [mem 0x0000005020000000-0x000000601fffffff]
> [    2.136892] On node 5 totalpages: 16777216
> [    2.136894]   Normal zone: 262144 pages used for memmap
> [    2.136895]   Normal zone: 16777216 pages, LIFO batch:63
> [    2.699839] Initmem setup node 6 [mem 0x0000006020000000-0x000000701fffffff]
> [    2.699844] On node 6 totalpages: 16777216
> [    2.699845]   Normal zone: 262144 pages used for memmap
> [    2.699846]   Normal zone: 16777216 pages, LIFO batch:63
> [    3.129131] Initmem setup node 7 [mem 0x0000007020000000-0x000000801effffff]
> [    3.129135] On node 7 totalpages: 16773120
> [    3.129138]   Normal zone: 262080 pages used for memmap
> [    3.129138]   Normal zone: 16773120 pages, LIFO batch:63
> [    3.716904] ACPI: PM-Timer IO Port: 0x808
> [    3.716909] ACPI: Local APIC address 0xfee00000
> [    3.716925] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    3.716938] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
> [    3.716942] IOAPIC[1]: apic_id 1, version 33, address 0xfec80000, GSI 24-55
> [    3.716946] IOAPIC[2]: apic_id 2, version 33, address 0xfecc0000, GSI 56-87
> [    3.716949] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    3.716951] ACPI: IRQ0 used by override.
> [    3.716952] ACPI: IRQ9 used by override.
> [    3.716954] Using ACPI (MADT) for SMP configuration information
> [    3.716956] ACPI: HPET id: 0x43538301 base: 0xfed00000
> [    3.716961] ACPI: SPCR: SPCR table version 1
> [    3.716962] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
> [    3.716963] ACPI: SPCR: console: uart,mmio,0x0
> [    3.716966] smpboot: Allowing 64 CPUs, 0 hotplug CPUs
> [    3.716987] [mem 0xe0000000-0xefffffff] available for PCI devices
> [    3.716991] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    3.885762] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:64 nr_node_ids:8
> [    3.895018] percpu: Embedded 51 pages/cpu s170968 r8192 d29736 u262144
> [    3.895033] pcpu-alloc: s170968 r8192 d29736 u262144 alloc=1*2097152
> [    3.895035] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [1] 08 09 10 11 12 13 14 15 
> [    3.895040] pcpu-alloc: [2] 16 17 18 19 20 21 22 23 [3] 24 25 26 27 28 29 30 31 
> [    3.895045] pcpu-alloc: [4] 32 33 34 35 36 37 38 39 [5] 40 41 42 43 44 45 46 47 
> [    3.895049] pcpu-alloc: [6] 48 49 50 51 52 53 54 55 [7] 56 57 58 59 60 61 62 63 
> [    3.895121] Built 8 zonelists, mobility grouping on.  Total pages: 132114023
> [    3.895123] Policy zone: Normal
> [    3.895125] Kernel command line: BOOT_IMAGE=/boot/bzImage.x86_64 root=LABEL=root ro crashkernel=256M console=ttyS1,115200n8 console=tty0 init=/bin/systemd audit=0 random.trust_cpu=on
> [    3.895252] audit: disabled (until reboot)
> [    3.895283] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [    3.895284] printk: log_buf_len total cpu_extra contributions: 258048 bytes
> [    3.895285] printk: log_buf_len min size: 131072 bytes
> [    3.895584] printk: log_buf_len: 524288 bytes
> [    3.895585] printk: early log buf free: 114524(87%)
> [    3.895909] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    3.909679] AGP: Checking aperture...
> [    3.917694] AGP: No AGP bridge found
> [    3.917698] AGP: Node 0: aperture [bus addr 0x3c96000000-0x3c97ffffff] (32MB)
> [    3.917699] Aperture beyond 4GB. Ignoring.
> [    3.917700] AGP: Your BIOS doesn't leave an aperture memory hole
> [    3.917701] AGP: Please enable the IOMMU option in the BIOS setup
> [    3.917702] AGP: This costs you 64MB of RAM
> [    3.917708] AGP: Mapping aperture over RAM [mem 0xc4000000-0xc7ffffff] (65536KB)
> [    7.808793] Memory: 528014216K/536844376K available (14340K kernel code, 1518K rwdata, 3648K rodata, 1620K init, 980K bss, 8830160K reserved, 0K cma-reserved)
> [    7.809639] ftrace: allocating 40890 entries in 160 pages
> [    7.837715] rcu: Hierarchical RCU implementation.
> [    7.837718] rcu: 	RCU event tracing is enabled.
> [    7.837719] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=64.
> [    7.837721] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    7.837722] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=64
> [    7.842212] NR_IRQS: 16640, nr_irqs: 2024, preallocated irqs: 16
> [    7.842806] spurious 8259A interrupt: IRQ7.
> [    7.849319] Console: colour VGA+ 80x25
> [    7.883974] printk: console [tty0] enabled
> [    9.156943] printk: console [ttyS1] enabled
> [    9.161500] ACPI: Core revision 20190816
> [    9.165882] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    9.175259] APIC: Switch to symmetric I/O mode setup
> [    9.180363] Switched APIC routing to physical flat.
> [    9.186098] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    9.197258] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2127609b296, max_idle_ns: 440795270637 ns
> [    9.208001] Calibrating delay loop (skipped), value calculated using timer frequency.. 4600.09 BogoMIPS (lpj=2300046)
> [    9.209002] pid_max: default: 65536 minimum: 512
> [    9.266902] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc)
> [    9.295703] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc)
> [    9.297035] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> [    9.298883] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> [    9.300534] LVT offset 1 assigned for vector 0xf9
> [    9.301008] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
> [    9.302002] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
> [    9.303002] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    9.304002] Spectre V2 : Mitigation: Full AMD retpoline
> [    9.305001] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    9.306002] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    9.307296] Freeing SMP alternatives memory: 44K
> [    9.411247] smpboot: CPU0: AMD Opteron(TM) Processor 6276 (family: 0x15, model: 0x1, stepping: 0x2)
> [    9.412263] Performance Events: Fam15h core perfctr, AMD PMU driver.
> [    9.413002] ... version:                0
> [    9.414002] ... bit width:              48
> [    9.415001] ... generic registers:      6
> [    9.416002] ... value mask:             0000ffffffffffff
> [    9.417002] ... max period:             00007fffffffffff
> [    9.418001] ... fixed-purpose events:   0
> [    9.419001] ... event mask:             000000000000003f
> [    9.420129] rcu: Hierarchical SRCU implementation.
> [    9.421740] MCE: In-kernel MCE decoding enabled.
> [    9.423716] smp: Bringing up secondary CPUs ...
> [    9.424260] x86: Booting SMP configuration:
> [    9.425002] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
> [    9.443004] .... node  #1, CPUs:    #8  #9 #10 #11 #12 #13 #14 #15
> [    9.465004] .... node  #6, CPUs:   #16
> [    1.357381] smpboot: CPU 16 Converting physical 3 to logical package 1
> [    1.357381] smpboot: CPU 16 Converting physical 0 to logical die 1
> [    9.543353]  #17 #18 #19 #20 #21 #22 #23
> [    9.563002] .... node  #7, CPUs:   #24 #25 #26 #27 #28 #29 #30 #31
> [    9.586003] .... node  #2, CPUs:   #32
> [    1.357381] smpboot: CPU 32 Converting physical 1 to logical package 2
> [    1.357381] smpboot: CPU 32 Converting physical 0 to logical die 2
> [    9.665336]  #33 #34 #35 #36 #37 #38 #39
> [    9.685004] .... node  #3, CPUs:   #40 #41 #42 #43 #44 #45 #46 #47
> [    9.709002] .... node  #4, CPUs:   #48
> [    1.357381] smpboot: CPU 48 Converting physical 2 to logical package 3
> [    1.357381] smpboot: CPU 48 Converting physical 0 to logical die 3
> [    9.788345]  #49 #50 #51 #52 #53 #54 #55
> [    9.809002] .... node  #5, CPUs:   #56 #57 #58 #59 #60 #61 #62 #63
> [    9.831254] smp: Brought up 8 nodes, 64 CPUs
> [    9.833002] smpboot: Max logical packages: 4
> [    9.834013] smpboot: Total of 64 processors activated (294387.58 BogoMIPS)
> [    9.883360] devtmpfs: initialized
> [    9.885429] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    9.886055] futex hash table entries: 16384 (order: 8, 1048576 bytes, vmalloc)
> [    9.888271] xor: automatically using best checksumming function   avx       
> [    9.889484] NET: Registered protocol family 16
> [    9.890345] cpuidle: using governor menu
> [    9.896132] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    9.904004] ACPI: bus type PCI registered
> [    9.908065] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
> [    9.917005] PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in E820
> [    9.924012] pmd_set_huge: Cannot satisfy [mem 0xf0000000-0xf0200000] with a huge-page mapping due to MTRR override.
> [    9.935126] PCI: Using configuration type 1 for base access
> [    9.943040] mtrr: your CPUs had inconsistent fixed MTRR settings
> [    9.949002] mtrr: probably your BIOS does not setup all CPUs.
> [    9.955003] mtrr: corrected configuration.
> [    9.964040] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    9.990452] raid6: sse2x4   gen()  3308 MB/s
> [   10.011452] raid6: sse2x4   xor()  2111 MB/s
> [   10.032456] raid6: sse2x2   gen()  4878 MB/s
> [   10.053454] raid6: sse2x2   xor()  4972 MB/s
> [   10.074464] raid6: sse2x1   gen()  3199 MB/s
> [   10.095448] raid6: sse2x1   xor()  3365 MB/s
> [   10.100002] raid6: using algorithm sse2x2 gen() 4878 MB/s
> [   10.105004] raid6: .... xor() 4972 MB/s, rmw enabled
> [   10.111002] raid6: using ssse3x2 recovery algorithm
> [   10.116386] ACPI: Added _OSI(Module Device)
> [   10.120005] ACPI: Added _OSI(Processor Device)
> [   10.125007] ACPI: Added _OSI(3.0 _SCP Extensions)
> [   10.130012] ACPI: Added _OSI(Processor Aggregator Device)
> [   10.135011] ACPI: Added _OSI(Linux-Dell-Video)
> [   10.140006] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [   10.145003] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [   10.165624] ACPI: 2 ACPI AML tables successfully acquired and loaded
> [   10.174428] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [   10.183514] ACPI: Interpreter enabled
> [   10.187015] ACPI: (supports S0 S5)
> [   10.190004] ACPI: Using IOAPIC for interrupt routing
> [   10.196023] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [   10.205500] ACPI: Enabled 2 GPEs in block 00 to 1F
> [   10.238151] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1e])
> [   10.244009] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   10.254264] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]
> [   10.261003] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [   10.271814] PCI host bridge to bus 0000:00
> [   10.276005] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
> [   10.283003] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
> [   10.289003] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
> [   10.296003] pci_bus 0000:00: root bus resource [io  0xd000-0xffff window]
> [   10.303003] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
> [   10.310003] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [   10.318003] pci_bus 0000:00: root bus resource [mem 0xfec00000-0xfec7ffff window]
> [   10.326003] pci_bus 0000:00: root bus resource [mem 0xfec80000-0xfecbffff window]
> [   10.333005] pci_bus 0000:00: root bus resource [mem 0xe6000000-0xef4fffff window]
> [   10.341006] pci_bus 0000:00: root bus resource [mem 0xe2000000-0xe47fffff window]
> [   10.349003] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
> [   10.357003] pci_bus 0000:00: root bus resource [bus 00-1e]
> [   10.362056] pci 0000:00:00.0: [1002:5a13] type 00 class 0x060000
> [   10.368146] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
> [   10.375026] pci 0000:00:02.0: enabling Extended Tags
> [   10.380031] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
> [   10.386128] pci 0000:00:03.0: [1002:5a17] type 01 class 0x060400
> [   10.392023] pci 0000:00:03.0: enabling Extended Tags
> [   10.397030] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> [   10.404124] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
> [   10.410024] pci 0000:00:04.0: enabling Extended Tags
> [   10.415029] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
> [   10.422018] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
> [   10.428023] pci 0000:00:09.0: enabling Extended Tags
> [   10.433032] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
> [   10.439134] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
> [   10.445020] pci 0000:00:12.0: reg 0x10: [mem 0xef4fb000-0xef4fbfff]
> [   10.452150] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
> [   10.458020] pci 0000:00:12.1: reg 0x10: [mem 0xef4fc000-0xef4fcfff]
> [   10.465148] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
> [   10.471025] pci 0000:00:12.2: reg 0x10: [mem 0xef4ffe00-0xef4ffeff]
> [   10.477086] pci 0000:00:12.2: supports D1 D2
> [   10.482005] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
> [   10.488102] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
> [   10.494021] pci 0000:00:13.0: reg 0x10: [mem 0xef4fd000-0xef4fdfff]
> [   10.501140] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
> [   10.507020] pci 0000:00:13.1: reg 0x10: [mem 0xef4fe000-0xef4fefff]
> [   10.513143] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
> [   10.520023] pci 0000:00:13.2: reg 0x10: [mem 0xef4fff00-0xef4fffff]
> [   10.526088] pci 0000:00:13.2: supports D1 D2
> [   10.531003] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
> [   10.537102] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
> [   10.543178] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
> [   10.549180] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
> [   10.556154] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
> [   10.562101] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
> [   10.568115] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
> [   10.575010] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
> [   10.581093] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
> [   10.587097] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
> [   10.593103] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
> [   10.600015] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
> [   10.606093] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
> [   10.612091] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
> [   10.618098] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
> [   10.625007] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
> [   10.631098] pci 0000:00:1a.0: [1022:1600] type 00 class 0x060000
> [   10.637103] pci 0000:00:1a.1: [1022:1601] type 00 class 0x060000
> [   10.643096] pci 0000:00:1a.2: [1022:1602] type 00 class 0x060000
> [   10.650005] pci 0000:00:1a.3: [1022:1603] type 00 class 0x060000
> [   10.656099] pci 0000:00:1a.4: [1022:1604] type 00 class 0x060000
> [   10.662097] pci 0000:00:1a.5: [1022:1605] type 00 class 0x060000
> [   10.668094] pci 0000:00:1b.0: [1022:1600] type 00 class 0x060000
> [   10.675018] pci 0000:00:1b.1: [1022:1601] type 00 class 0x060000
> [   10.681093] pci 0000:00:1b.2: [1022:1602] type 00 class 0x060000
> [   10.687094] pci 0000:00:1b.3: [1022:1603] type 00 class 0x060000
> [   10.693099] pci 0000:00:1b.4: [1022:1604] type 00 class 0x060000
> [   10.700013] pci 0000:00:1b.5: [1022:1605] type 00 class 0x060000
> [   10.706096] pci 0000:00:1c.0: [1022:1600] type 00 class 0x060000
> [   10.712104] pci 0000:00:1c.1: [1022:1601] type 00 class 0x060000
> [   10.718093] pci 0000:00:1c.2: [1022:1602] type 00 class 0x060000
> [   10.725024] pci 0000:00:1c.3: [1022:1603] type 00 class 0x060000
> [   10.731102] pci 0000:00:1c.4: [1022:1604] type 00 class 0x060000
> [   10.737104] pci 0000:00:1c.5: [1022:1605] type 00 class 0x060000
> [   10.743097] pci 0000:00:1d.0: [1022:1600] type 00 class 0x060000
> [   10.750058] pci 0000:00:1d.1: [1022:1601] type 00 class 0x060000
> [   10.756097] pci 0000:00:1d.2: [1022:1602] type 00 class 0x060000
> [   10.762096] pci 0000:00:1d.3: [1022:1603] type 00 class 0x060000
> [   10.768098] pci 0000:00:1d.4: [1022:1604] type 00 class 0x060000
> [   10.775056] pci 0000:00:1d.5: [1022:1605] type 00 class 0x060000
> [   10.781100] pci 0000:00:1e.0: [1022:1600] type 00 class 0x060000
> [   10.787108] pci 0000:00:1e.1: [1022:1601] type 00 class 0x060000
> [   10.793097] pci 0000:00:1e.2: [1022:1602] type 00 class 0x060000
> [   10.800066] pci 0000:00:1e.3: [1022:1603] type 00 class 0x060000
> [   10.806099] pci 0000:00:1e.4: [1022:1604] type 00 class 0x060000
> [   10.812103] pci 0000:00:1e.5: [1022:1605] type 00 class 0x060000
> [   10.818097] pci 0000:00:1f.0: [1022:1600] type 00 class 0x060000
> [   10.825074] pci 0000:00:1f.1: [1022:1601] type 00 class 0x060000
> [   10.831095] pci 0000:00:1f.2: [1022:1602] type 00 class 0x060000
> [   10.837099] pci 0000:00:1f.3: [1022:1603] type 00 class 0x060000
> [   10.843103] pci 0000:00:1f.4: [1022:1604] type 00 class 0x060000
> [   10.850075] pci 0000:00:1f.5: [1022:1605] type 00 class 0x060000
> [   10.856145] pci 0000:01:00.0: [14e4:1639] type 00 class 0x020000
> [   10.862024] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe7ffffff 64bit]
> [   10.869103] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [   10.875085] pci 0000:01:00.1: [14e4:1639] type 00 class 0x020000
> [   10.882025] pci 0000:01:00.1: reg 0x10: [mem 0xe8000000-0xe9ffffff 64bit]
> [   10.889096] pci 0000:01:00.1: PME# supported from D0 D3hot D3cold
> [   10.895093] pci 0000:00:02.0: PCI bridge to [bus 01]
> [   10.900007] pci 0000:00:02.0:   bridge window [mem 0xe6000000-0xe9ffffff]
> [   10.907051] pci 0000:02:00.0: [14e4:1639] type 00 class 0x020000
> [   10.913023] pci 0000:02:00.0: reg 0x10: [mem 0xea000000-0xebffffff 64bit]
> [   10.920096] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [   10.927014] pci 0000:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x2 link at 0000:00:03.0 (capable of 16.000 Gb/s with 5 GT/s x4 link)
> [   10.941058] pci 0000:02:00.1: [14e4:1639] type 00 class 0x020000
> [   10.947024] pci 0000:02:00.1: reg 0x10: [mem 0xec000000-0xedffffff 64bit]
> [   10.954095] pci 0000:02:00.1: PME# supported from D0 D3hot D3cold
> [   10.960173] pci 0000:00:03.0: PCI bridge to [bus 02]
> [   10.965007] pci 0000:00:03.0:   bridge window [mem 0xea000000-0xedffffff]
> [   10.972046] pci 0000:03:00.0: [10b5:8624] type 01 class 0x060400
> [   10.978021] pci 0000:03:00.0: reg 0x10: [mem 0xef3e0000-0xef3fffff]
> [   10.985090] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
> [   10.994018] pci 0000:00:04.0: PCI bridge to [bus 03-08]
> [   10.999006] pci 0000:00:04.0:   bridge window [io  0xe000-0xffff]
> [   11.005004] pci 0000:00:04.0:   bridge window [mem 0xef000000-0xef3fffff]
> [   11.012005] pci 0000:00:04.0:   bridge window [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   11.020057] pci 0000:04:00.0: [10b5:8624] type 01 class 0x060400
> [   11.026101] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> [   11.033078] pci 0000:04:01.0: [10b5:8624] type 01 class 0x060400
> [   11.039094] pci 0000:04:01.0: PME# supported from D0 D3hot D3cold
> [   11.045076] pci 0000:04:04.0: [10b5:8624] type 01 class 0x060400
> [   11.051094] pci 0000:04:04.0: PME# supported from D0 D3hot D3cold
> [   11.058077] pci 0000:04:05.0: [10b5:8624] type 01 class 0x060400
> [   11.064095] pci 0000:04:05.0: PME# supported from D0 D3hot D3cold
> [   11.070084] pci 0000:03:00.0: PCI bridge to [bus 04-08]
> [   11.077006] pci 0000:03:00.0:   bridge window [io  0xe000-0xffff]
> [   11.084005] pci 0000:03:00.0:   bridge window [mem 0xef000000-0xef2fffff]
> [   11.090006] pci 0000:03:00.0:   bridge window [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   11.098050] pci 0000:05:00.0: [1000:0072] type 00 class 0x010700
> [   11.105021] pci 0000:05:00.0: reg 0x10: [io  0xfc00-0xfcff]
> [   11.110015] pci 0000:05:00.0: reg 0x14: [mem 0xef1f0000-0xef1fffff 64bit]
> [   11.117014] pci 0000:05:00.0: reg 0x1c: [mem 0xef180000-0xef1bffff 64bit]
> [   11.124019] pci 0000:05:00.0: reg 0x30: [mem 0xef000000-0xef0fffff pref]
> [   11.131013] pci 0000:05:00.0: enabling Extended Tags
> [   11.136059] pci 0000:05:00.0: supports D1 D2
> [   11.141029] pci 0000:05:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:04:00.0 (capable of 32.000 Gb/s with 5 GT/s x8 link)
> [   11.158020] pci 0000:04:00.0: PCI bridge to [bus 05]
> [   11.163007] pci 0000:04:00.0:   bridge window [io  0xf000-0xffff]
> [   11.169004] pci 0000:04:00.0:   bridge window [mem 0xef000000-0xef1fffff]
> [   11.176052] pci 0000:04:01.0: PCI bridge to [bus 06]
> [   11.181046] pci 0000:04:04.0: PCI bridge to [bus 07]
> [   11.186064] pci 0000:08:00.0: [13c1:1005] type 00 class 0x010400
> [   11.192025] pci 0000:08:00.0: reg 0x10: [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   11.200015] pci 0000:08:00.0: reg 0x18: [mem 0xef2ff000-0xef2fffff 64bit]
> [   11.207010] pci 0000:08:00.0: reg 0x20: [io  0xec00-0xecff]
> [   11.213015] pci 0000:08:00.0: reg 0x30: [mem 0xef2c0000-0xef2dffff pref]
> [   11.219051] pci 0000:08:00.0: supports D1 D2
> [   11.227019] pci 0000:04:05.0: PCI bridge to [bus 08]
> [   11.232009] pci 0000:04:05.0:   bridge window [io  0xe000-0xefff]
> [   11.238004] pci 0000:04:05.0:   bridge window [mem 0xef200000-0xef2fffff]
> [   11.245008] pci 0000:04:05.0:   bridge window [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   11.253057] pci 0000:00:09.0: PCI bridge to [bus 09]
> [   11.258019] pci_bus 0000:0a: extended config space not accessible
> [   11.264035] pci 0000:0a:03.0: [102b:0532] type 00 class 0x030000
> [   11.270023] pci 0000:0a:03.0: reg 0x10: [mem 0xe4000000-0xe47fffff pref]
> [   11.277018] pci 0000:0a:03.0: reg 0x14: [mem 0xeeffc000-0xeeffffff]
> [   11.284013] pci 0000:0a:03.0: reg 0x18: [mem 0xee000000-0xee7fffff]
> [   11.290051] pci 0000:0a:03.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [   11.297139] pci 0000:00:14.4: PCI bridge to [bus 0a] (subtractive decode)
> [   11.304010] pci 0000:00:14.4:   bridge window [mem 0xee000000-0xeeffffff]
> [   11.311006] pci 0000:00:14.4:   bridge window [mem 0xe4000000-0xe47fffff pref]
> [   11.319004] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
> [   11.327003] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
> [   11.336004] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
> [   11.345003] pci 0000:00:14.4:   bridge window [io  0xd000-0xffff window] (subtractive decode)
> [   11.354005] pci 0000:00:14.4:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
> [   11.362003] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> [   11.372003] pci 0000:00:14.4:   bridge window [mem 0xfec00000-0xfec7ffff window] (subtractive decode)
> [   11.381004] pci 0000:00:14.4:   bridge window [mem 0xfec80000-0xfecbffff window] (subtractive decode)
> [   11.391005] pci 0000:00:14.4:   bridge window [mem 0xe6000000-0xef4fffff window] (subtractive decode)
> [   11.400003] pci 0000:00:14.4:   bridge window [mem 0xe2000000-0xe47fffff window] (subtractive decode)
> [   11.410005] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff window] (subtractive decode)
> [   11.423551] ACPI: PCI Interrupt Link [LN24] (IRQs *24)
> [   11.430077] ACPI: PCI Interrupt Link [LN25] (IRQs *25)
> [   11.435077] ACPI: PCI Interrupt Link [LN26] (IRQs *26)
> [   11.440080] ACPI: PCI Interrupt Link [LN27] (IRQs *27)
> [   11.446074] ACPI: PCI Interrupt Link [LN28] (IRQs *28)
> [   11.451076] ACPI: PCI Interrupt Link [LN29] (IRQs *29)
> [   11.456077] ACPI: PCI Interrupt Link [LN30] (IRQs *30)
> [   11.462074] ACPI: PCI Interrupt Link [LN31] (IRQs *31)
> [   11.467076] ACPI: PCI Interrupt Link [LN32] (IRQs *32)
> [   11.473014] ACPI: PCI Interrupt Link [LN33] (IRQs *33)
> [   11.478072] ACPI: PCI Interrupt Link [LN34] (IRQs *34)
> [   11.483077] ACPI: PCI Interrupt Link [LN35] (IRQs *35)
> [   11.489074] ACPI: PCI Interrupt Link [LN36] (IRQs *36)
> [   11.494073] ACPI: PCI Interrupt Link [LN37] (IRQs *37)
> [   11.499078] ACPI: PCI Interrupt Link [LN38] (IRQs *38)
> [   11.505074] ACPI: PCI Interrupt Link [LN39] (IRQs *39)
> [   11.510073] ACPI: PCI Interrupt Link [LN40] (IRQs *40)
> [   11.515077] ACPI: PCI Interrupt Link [LN41] (IRQs *41)
> [   11.521075] ACPI: PCI Interrupt Link [LN42] (IRQs *42)
> [   11.526076] ACPI: PCI Interrupt Link [LN43] (IRQs *43)
> [   11.531074] ACPI: PCI Interrupt Link [LN44] (IRQs *44)
> [   11.537075] ACPI: PCI Interrupt Link [LN45] (IRQs *45)
> [   11.542072] ACPI: PCI Interrupt Link [LN46] (IRQs *46)
> [   11.548004] ACPI: PCI Interrupt Link [LN47] (IRQs *47)
> [   11.553073] ACPI: PCI Interrupt Link [LN48] (IRQs *48)
> [   11.558073] ACPI: PCI Interrupt Link [LN49] (IRQs *49)
> [   11.564070] ACPI: PCI Interrupt Link [LN50] (IRQs *50)
> [   11.569074] ACPI: PCI Interrupt Link [LN51] (IRQs *51)
> [   11.574072] ACPI: PCI Interrupt Link [LN52] (IRQs *52)
> [   11.580077] ACPI: PCI Interrupt Link [LN53] (IRQs *53)
> [   11.585079] ACPI: PCI Interrupt Link [LN54] (IRQs *54)
> [   11.590073] ACPI: PCI Interrupt Link [LN55] (IRQs *55)
> [   11.597699] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 20-3e])
> [   11.604007] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   11.613491] acpi PNP0A08:01: _OSC: OS now controls [PME AER PCIeCapability LTR]
> [   11.621003] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
> [   11.629008] acpi PNP0A08:01: [Firmware Bug]: no _PXM; falling back to node 6 from hardware (may be inconsistent with ACPI node numbers)
> [   11.643765] PCI host bridge to bus 0000:20
> [   11.648004] pci_bus 0000:20: root bus resource [io  0xc000-0xcfff window]
> [   11.654003] pci_bus 0000:20: root bus resource [mem 0xfecc0000-0xfecfffff window]
> [   11.662003] pci_bus 0000:20: root bus resource [mem 0xe1e00000-0xe1ffffff window]
> [   11.670007] pci_bus 0000:20: root bus resource [bus 20-3e]
> [   11.676054] pci 0000:20:00.0: [1002:5a12] type 00 class 0x060000
> [   11.682128] pci 0000:20:02.0: [1002:5a16] type 01 class 0x060400
> [   11.688027] pci 0000:20:02.0: enabling Extended Tags
> [   11.693032] pci 0000:20:02.0: PME# supported from D0 D3hot D3cold
> [   11.700014] pci 0000:20:03.0: [1002:5a17] type 01 class 0x060400
> [   11.706026] pci 0000:20:03.0: enabling Extended Tags
> [   11.711032] pci 0000:20:03.0: PME# supported from D0 D3hot D3cold
> [   11.717121] pci 0000:20:0b.0: [1002:5a1f] type 01 class 0x060400
> [   11.723026] pci 0000:20:0b.0: enabling Extended Tags
> [   11.728032] pci 0000:20:0b.0: PME# supported from D0 D3hot D3cold
> [   11.735158] pci 0000:20:02.0: PCI bridge to [bus 21]
> [   11.740058] pci 0000:22:00.0: [8086:10fb] type 00 class 0x020000
> [   11.746023] pci 0000:22:00.0: reg 0x10: [mem 0xe1e00000-0xe1e7ffff 64bit]
> [   11.753008] pci 0000:22:00.0: reg 0x18: [io  0xccc0-0xccdf]
> [   11.759016] pci 0000:22:00.0: reg 0x20: [mem 0xe1ff8000-0xe1ffbfff 64bit]
> [   11.766008] pci 0000:22:00.0: reg 0x30: [mem 0xe1f00000-0xe1f7ffff pref]
> [   11.773053] pci 0000:22:00.0: PME# supported from D0 D3hot
> [   11.778026] pci 0000:22:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
> [   11.785004] pci 0000:22:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
> [   11.796014] pci 0000:22:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
> [   11.803003] pci 0000:22:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR3 for 64 VFs)
> [   11.813181] pci 0000:22:00.1: [8086:10fb] type 00 class 0x020000
> [   11.819021] pci 0000:22:00.1: reg 0x10: [mem 0xe1e80000-0xe1efffff 64bit]
> [   11.826010] pci 0000:22:00.1: reg 0x18: [io  0xcce0-0xccff]
> [   11.832017] pci 0000:22:00.1: reg 0x20: [mem 0xe1ffc000-0xe1ffffff 64bit]
> [   11.839008] pci 0000:22:00.1: reg 0x30: [mem 0xe1f00000-0xe1f7ffff pref]
> [   11.845052] pci 0000:22:00.1: PME# supported from D0 D3hot
> [   11.851023] pci 0000:22:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
> [   11.858009] pci 0000:22:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
> [   11.868014] pci 0000:22:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
> [   11.875004] pci 0000:22:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR3 for 64 VFs)
> [   11.885183] pci 0000:20:03.0: PCI bridge to [bus 22]
> [   11.891010] pci 0000:20:03.0:   bridge window [io  0xc000-0xcfff]
> [   11.897004] pci 0000:20:03.0:   bridge window [mem 0xe1e00000-0xe1ffffff]
> [   11.904036] pci 0000:20:0b.0: PCI bridge to [bus 23]
> [   11.909136] ACPI: PCI Interrupt Link [LN56] (IRQs *56)
> [   11.914078] ACPI: PCI Interrupt Link [LN57] (IRQs *57)
> [   11.920095] ACPI: PCI Interrupt Link [LN58] (IRQs *58)
> [   11.925076] ACPI: PCI Interrupt Link [LN59] (IRQs *59)
> [   11.930077] ACPI: PCI Interrupt Link [LN60] (IRQs *60)
> [   11.936076] ACPI: PCI Interrupt Link [LN61] (IRQs *61)
> [   11.941077] ACPI: PCI Interrupt Link [LN62] (IRQs *62)
> [   11.947067] ACPI: PCI Interrupt Link [LN63] (IRQs *63)
> [   11.952075] ACPI: PCI Interrupt Link [LN64] (IRQs *64)
> [   11.957073] ACPI: PCI Interrupt Link [LN65] (IRQs *65)
> [   11.963081] ACPI: PCI Interrupt Link [LN66] (IRQs *66)
> [   11.968084] ACPI: PCI Interrupt Link [LN67] (IRQs *67)
> [   11.973074] ACPI: PCI Interrupt Link [LN68] (IRQs *68)
> [   11.979074] ACPI: PCI Interrupt Link [LN69] (IRQs *69)
> [   11.984077] ACPI: PCI Interrupt Link [LN70] (IRQs *70)
> [   11.989073] ACPI: PCI Interrupt Link [LN71] (IRQs *71)
> [   11.995074] ACPI: PCI Interrupt Link [LN72] (IRQs *72)
> [   12.000073] ACPI: PCI Interrupt Link [LN73] (IRQs *73)
> [   12.005077] ACPI: PCI Interrupt Link [LN74] (IRQs *74)
> [   12.011074] ACPI: PCI Interrupt Link [LN75] (IRQs *75)
> [   12.016076] ACPI: PCI Interrupt Link [LN76] (IRQs *76)
> [   12.022063] ACPI: PCI Interrupt Link [LN77] (IRQs *77)
> [   12.027075] ACPI: PCI Interrupt Link [LN78] (IRQs *78)
> [   12.032074] ACPI: PCI Interrupt Link [LN79] (IRQs *79)
> [   12.038073] ACPI: PCI Interrupt Link [LN80] (IRQs *80)
> [   12.043072] ACPI: PCI Interrupt Link [LN81] (IRQs *81)
> [   12.048076] ACPI: PCI Interrupt Link [LN82] (IRQs *82)
> [   12.054072] ACPI: PCI Interrupt Link [LN83] (IRQs *83)
> [   12.059078] ACPI: PCI Interrupt Link [LN84] (IRQs *84)
> [   12.064077] ACPI: PCI Interrupt Link [LN85] (IRQs *85)
> [   12.071077] ACPI: PCI Interrupt Link [LN86] (IRQs *86)
> [   12.077074] ACPI: PCI Interrupt Link [LN87] (IRQs *87)
> [   12.082212] ACPI: PCI Interrupt Link [LK00] (IRQs 3 4 5 6 7 10 11 *14 15)
> [   12.089118] ACPI: PCI Interrupt Link [LK01] (IRQs 3 4 5 6 7 10 *11 14 15)
> [   12.096111] ACPI: PCI Interrupt Link [LK02] (IRQs 3 4 5 6 7 *10 11 14 15)
> [   12.103112] ACPI: PCI Interrupt Link [LK03] (IRQs 3 4 5 *6 7 10 11 14 15)
> [   12.110115] ACPI: PCI Interrupt Link [LK04] (IRQs 3 4 *5 6 7 10 11 14 15)
> [   12.117109] ACPI: PCI Interrupt Link [LK05] (IRQs 3 4 5 6 7 10 11 14 *15)
> [   12.124112] ACPI: PCI Interrupt Link [LK06] (IRQs 3 4 5 6 7 10 11 14 *15)
> [   12.131110] ACPI: PCI Interrupt Link [LK07] (IRQs 3 4 5 6 7 10 11 14 15) *0
> [   12.139355] iommu: Default domain type: Translated 
> [   12.144037] pci 0000:0a:03.0: vgaarb: setting as boot VGA device
> [   12.145000] pci 0000:0a:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [   12.159005] pci 0000:0a:03.0: vgaarb: bridge control possible
> [   12.165002] vgaarb: loaded
> [   12.168136] SCSI subsystem initialized
> [   12.172185] libata version 3.00 loaded.
> [   12.172185] ACPI: bus type USB registered
> [   12.176039] usbcore: registered new interface driver usbfs
> [   12.182014] usbcore: registered new interface driver hub
> [   12.188037] usbcore: registered new device driver usb
> [   12.193027] pps_core: LinuxPPS API ver. 1 registered
> [   12.198002] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [   12.207011] PTP clock support registered
> [   12.212161] EDAC MC: Ver: 3.0.0
> [   12.215160] PCI: Using ACPI for IRQ routing
> [   12.221261] PCI: pci_cache_line_size set to 64 bytes
> [   12.221373] Expanded resource Reserved due to conflict with PCI Bus 0000:00
> [   12.228002] Expanded resource Reserved due to conflict with Reserved
> [   12.235002] Expanded resource Reserved due to conflict with PCI Bus 0000:20
> [   12.242002] Expanded resource Reserved due to conflict with Reserved
> [   12.248002] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [   12.248004] e820: reserve RAM buffer [mem 0xdf679000-0xdfffffff]
> [   12.248006] e820: reserve RAM buffer [mem 0x801f000000-0x801fffffff]
> [   12.248185] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [   12.254004] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
> [   12.262609] clocksource: Switched to clocksource tsc-early
> [   12.313191] VFS: Disk quotas dquot_6.6.0
> [   12.317329] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [   12.324486] FS-Cache: Loaded
> [   12.327661] CacheFiles: Loaded
> [   12.330875] pnp: PnP ACPI init
> [   12.334333] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [   12.334388] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
> [   12.334749] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
> [   12.335069] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
> [   12.339049] system 00:04: [io  0x0800-0x087f] has been reserved
> [   12.345105] system 00:04: [io  0x0900-0x093f] has been reserved
> [   12.351164] system 00:04: [io  0x0d00-0x0dfe] has been reserved
> [   12.357221] system 00:04: [io  0x0dff] has been reserved
> [   12.362670] system 00:04: [io  0x0e00-0x0efe] has been reserved
> [   12.368729] system 00:04: [io  0x0eff] has been reserved
> [   12.374175] system 00:04: [io  0x040b] has been reserved
> [   12.379622] system 00:04: [io  0x04d6] has been reserved
> [   12.385072] system 00:04: [io  0x04d0-0x04d1] has been reserved
> [   12.391130] system 00:04: [io  0x0c00-0x0c01] has been reserved
> [   12.397187] system 00:04: [io  0x0c14] has been reserved
> [   12.402635] system 00:04: [io  0x0c50-0x0c52] has been reserved
> [   12.408693] system 00:04: [io  0x0c6c] has been reserved
> [   12.414141] system 00:04: [io  0x0c6f] has been reserved
> [   12.419592] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
> [   12.425648] system 00:04: [io  0x0cd8-0x0cdb] has been reserved
> [   12.431704] system 00:04: [io  0x0cdc-0x0cdf] has been reserved
> [   12.437762] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
> [   12.443817] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
> [   12.449875] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
> [   12.455932] system 00:04: [io  0x0ca0-0x0ca7] has been reserved
> [   12.461990] system 00:04: [io  0x0ca9-0x0cab] has been reserved
> [   12.468050] system 00:04: [io  0x0cad-0x0caf] has been reserved
> [   12.474105] system 00:04: [io  0x0cb0-0x0cb7] has been reserved
> [   12.480162] system 00:04: [io  0x0950] has been reserved
> [   12.485614] system 00:04: Plug and Play ACPI device, IDs PNP0c01 (active)
> [   12.485684] pnp 00:05: [irq 0 disabled]
> [   12.485731] system 00:05: [io  0x0ca8] has been reserved
> [   12.491186] system 00:05: [io  0x0cac] has been reserved
> [   12.496640] system 00:05: Plug and Play ACPI device, IDs IPI0001 PNP0c01 (active)
> [   12.500499] pnp: PnP ACPI: found 6 devices
> [   12.507178] thermal_sys: Registered thermal governor 'step_wise'
> [   12.507179] thermal_sys: Registered thermal governor 'user_space'
> [   12.517863] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [   12.533199] pci 0000:22:00.1: can't claim BAR 6 [mem 0xe1f00000-0xe1f7ffff pref]: address conflict with 0000:22:00.0 [mem 0xe1f00000-0xe1f7ffff pref]
> [   12.546824] pci 0000:00:02.0: PCI bridge to [bus 01]
> [   12.551927] pci 0000:00:02.0:   bridge window [mem 0xe6000000-0xe9ffffff]
> [   12.558857] pci 0000:00:03.0: PCI bridge to [bus 02]
> [   12.563959] pci 0000:00:03.0:   bridge window [mem 0xea000000-0xedffffff]
> [   12.570888] pci 0000:04:00.0: PCI bridge to [bus 05]
> [   12.575987] pci 0000:04:00.0:   bridge window [io  0xf000-0xffff]
> [   12.582219] pci 0000:04:00.0:   bridge window [mem 0xef000000-0xef1fffff]
> [   12.589148] pci 0000:04:01.0: PCI bridge to [bus 06]
> [   12.594255] pci 0000:04:04.0: PCI bridge to [bus 07]
> [   12.599364] pci 0000:04:05.0: PCI bridge to [bus 08]
> [   12.604465] pci 0000:04:05.0:   bridge window [io  0xe000-0xefff]
> [   12.610697] pci 0000:04:05.0:   bridge window [mem 0xef200000-0xef2fffff]
> [   12.617624] pci 0000:04:05.0:   bridge window [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   12.625589] pci 0000:03:00.0: PCI bridge to [bus 04-08]
> [   12.630948] pci 0000:03:00.0:   bridge window [io  0xe000-0xffff]
> [   12.637180] pci 0000:03:00.0:   bridge window [mem 0xef000000-0xef2fffff]
> [   12.644109] pci 0000:03:00.0:   bridge window [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   12.652072] pci 0000:00:04.0: PCI bridge to [bus 03-08]
> [   12.657434] pci 0000:00:04.0:   bridge window [io  0xe000-0xffff]
> [   12.663665] pci 0000:00:04.0:   bridge window [mem 0xef000000-0xef3fffff]
> [   12.670593] pci 0000:00:04.0:   bridge window [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   12.678556] pci 0000:00:09.0: PCI bridge to [bus 09]
> [   12.683663] pci 0000:0a:03.0: BAR 6: assigned [mem 0xee800000-0xee80ffff pref]
> [   12.691103] pci 0000:00:14.4: PCI bridge to [bus 0a]
> [   12.696207] pci 0000:00:14.4:   bridge window [mem 0xee000000-0xeeffffff]
> [   12.703132] pci 0000:00:14.4:   bridge window [mem 0xe4000000-0xe47fffff pref]
> [   12.710582] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
> [   12.716897] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
> [   12.723215] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
> [   12.729533] pci_bus 0000:00: resource 7 [io  0xd000-0xffff window]
> [   12.735850] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
> [   12.742167] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
> [   12.749181] pci_bus 0000:00: resource 10 [mem 0xfec00000-0xfec7ffff window]
> [   12.756281] pci_bus 0000:00: resource 11 [mem 0xfec80000-0xfecbffff window]
> [   12.763385] pci_bus 0000:00: resource 12 [mem 0xe6000000-0xef4fffff window]
> [   12.770485] pci_bus 0000:00: resource 13 [mem 0xe2000000-0xe47fffff window]
> [   12.777585] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed44fff window]
> [   12.784686] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe9ffffff]
> [   12.791091] pci_bus 0000:02: resource 1 [mem 0xea000000-0xedffffff]
> [   12.797498] pci_bus 0000:03: resource 0 [io  0xe000-0xffff]
> [   12.803206] pci_bus 0000:03: resource 1 [mem 0xef000000-0xef3fffff]
> [   12.809608] pci_bus 0000:03: resource 2 [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   12.817048] pci_bus 0000:04: resource 0 [io  0xe000-0xffff]
> [   12.822756] pci_bus 0000:04: resource 1 [mem 0xef000000-0xef2fffff]
> [   12.829160] pci_bus 0000:04: resource 2 [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   12.836599] pci_bus 0000:05: resource 0 [io  0xf000-0xffff]
> [   12.842314] pci_bus 0000:05: resource 1 [mem 0xef000000-0xef1fffff]
> [   12.848718] pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
> [   12.854425] pci_bus 0000:08: resource 1 [mem 0xef200000-0xef2fffff]
> [   12.860827] pci_bus 0000:08: resource 2 [mem 0xe2000000-0xe3ffffff 64bit pref]
> [   12.868273] pci_bus 0000:0a: resource 1 [mem 0xee000000-0xeeffffff]
> [   12.874674] pci_bus 0000:0a: resource 2 [mem 0xe4000000-0xe47fffff pref]
> [   12.881514] pci_bus 0000:0a: resource 4 [io  0x0000-0x03af window]
> [   12.887830] pci_bus 0000:0a: resource 5 [io  0x03e0-0x0cf7 window]
> [   12.894147] pci_bus 0000:0a: resource 6 [io  0x03b0-0x03df window]
> [   12.900464] pci_bus 0000:0a: resource 7 [io  0xd000-0xffff window]
> [   12.906780] pci_bus 0000:0a: resource 8 [io  0x0d00-0x0fff window]
> [   12.913098] pci_bus 0000:0a: resource 9 [mem 0x000a0000-0x000bffff window]
> [   12.920111] pci_bus 0000:0a: resource 10 [mem 0xfec00000-0xfec7ffff window]
> [   12.927212] pci_bus 0000:0a: resource 11 [mem 0xfec80000-0xfecbffff window]
> [   12.934317] pci_bus 0000:0a: resource 12 [mem 0xe6000000-0xef4fffff window]
> [   12.941417] pci_bus 0000:0a: resource 13 [mem 0xe2000000-0xe47fffff window]
> [   12.948519] pci_bus 0000:0a: resource 14 [mem 0xfed40000-0xfed44fff window]
> [   12.955680] pci 0000:20:02.0: PCI bridge to [bus 21]
> [   12.960789] pci 0000:22:00.1: BAR 6: no space for [mem size 0x00080000 pref]
> [   12.967977] pci 0000:22:00.1: BAR 6: failed to assign [mem size 0x00080000 pref]
> [   12.975588] pci 0000:22:00.0: BAR 7: no space for [mem size 0x00100000 64bit]
> [   12.982862] pci 0000:22:00.0: BAR 7: failed to assign [mem size 0x00100000 64bit]
> [   12.990562] pci 0000:22:00.0: BAR 10: no space for [mem size 0x00100000 64bit]
> [   12.998004] pci 0000:22:00.0: BAR 10: failed to assign [mem size 0x00100000 64bit]
> [   13.005791] pci 0000:22:00.1: BAR 7: no space for [mem size 0x00100000 64bit]
> [   13.013065] pci 0000:22:00.1: BAR 7: failed to assign [mem size 0x00100000 64bit]
> [   13.020766] pci 0000:22:00.1: BAR 10: no space for [mem size 0x00100000 64bit]
> [   13.028207] pci 0000:22:00.1: BAR 10: failed to assign [mem size 0x00100000 64bit]
> [   13.035994] pci 0000:20:03.0: PCI bridge to [bus 22]
> [   13.041096] pci 0000:20:03.0:   bridge window [io  0xc000-0xcfff]
> [   13.047328] pci 0000:20:03.0:   bridge window [mem 0xe1e00000-0xe1ffffff]
> [   13.054256] pci 0000:20:0b.0: PCI bridge to [bus 23]
> [   13.059357] pci_bus 0000:20: Some PCI device resources are unassigned, try booting with pci=realloc
> [   13.068620] pci_bus 0000:20: resource 4 [io  0xc000-0xcfff window]
> [   13.074938] pci_bus 0000:20: resource 5 [mem 0xfecc0000-0xfecfffff window]
> [   13.081957] pci_bus 0000:20: resource 6 [mem 0xe1e00000-0xe1ffffff window]
> [   13.088969] pci_bus 0000:22: resource 0 [io  0xc000-0xcfff]
> [   13.094677] pci_bus 0000:22: resource 1 [mem 0xe1e00000-0xe1ffffff]
> [   13.101287] NET: Registered protocol family 2
> [   13.106437] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
> [   13.116366] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
> [   13.127330] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
> [   13.136904] TCP: Hash tables configured (established 524288 bind 65536)
> [   13.143916] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> [   13.152024] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> [   13.237183] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x690 took 74542 usecs
> [   13.245965] pci 0000:0a:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [   13.254559] PCI: CLS 64 bytes, default 64
> [   13.258771] Trying to unpack rootfs image as initramfs...
> [   13.373303] Freeing initrd memory: 5136K
> [   13.379129] PCI-DMA: Disabling AGP.
> [   13.383000] PCI-DMA: aperture base @ c4000000 size 65536 KB
> [   13.388713] PCI-DMA: using GART IOMMU.
> [   13.392632] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> [   13.403134] amd_uncore: AMD NB counters detected
> [   13.410789] LVT offset 0 assigned for vector 0x400
> [   13.416985] perf: AMD IBS detected (0x000000ff)
> [   13.423782] workingset: timestamp_bits=40 max_order=27 bucket_order=0
> [   13.431861] SGI XFS with ACLs, security attributes, realtime, no debug enabled
> [   13.440726] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
> [   13.448808] io scheduler mq-deadline registered
> [   13.453475] io scheduler kyber registered
> [   13.459211] PCI Interrupt Link [LN52] enabled at IRQ 52
> [   13.464685] pcieport 0000:00:02.0: PME: Signaling with IRQ 25
> [   13.470695] pcieport 0000:00:02.0: AER: enabled with IRQ 25
> [   13.476604] pcieport 0000:00:03.0: PME: Signaling with IRQ 26
> [   13.482585] pcieport 0000:00:03.0: AER: enabled with IRQ 26
> [   13.488478] pcieport 0000:00:04.0: PME: Signaling with IRQ 27
> [   13.494483] pcieport 0000:00:04.0: AER: enabled with IRQ 27
> [   13.500367] PCI Interrupt Link [LN53] enabled at IRQ 53
> [   13.505797] pcieport 0000:00:09.0: PME: Signaling with IRQ 29
> [   13.511780] pcieport 0000:00:09.0: AER: enabled with IRQ 29
> [   13.517684] PCI Interrupt Link [LN44] enabled at IRQ 44
> [   13.523434] PCI Interrupt Link [LN45] enabled at IRQ 45
> [   13.529480] PCI Interrupt Link [LN84] enabled at IRQ 84
> [   13.535025] pcieport 0000:20:02.0: PME: Signaling with IRQ 38
> [   13.541037] pcieport 0000:20:02.0: AER: enabled with IRQ 38
> [   13.546959] pcieport 0000:20:03.0: PME: Signaling with IRQ 39
> [   13.552952] pcieport 0000:20:03.0: AER: enabled with IRQ 39
> [   13.558844] PCI Interrupt Link [LN86] enabled at IRQ 86
> [   13.564285] pcieport 0000:20:0b.0: PME: Signaling with IRQ 41
> [   13.570276] pcieport 0000:20:0b.0: AER: enabled with IRQ 41
> [   13.576106] IPMI message handler: version 39.2
> [   13.580700] ipmi device interface
> [   13.584190] ipmi_si: IPMI System Interface driver
> [   13.589036] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [   13.595531] ipmi_si dmi-ipmi-si.0: IRQ index 0 not found
> [   13.600980] ipmi_platform: ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 0
> [   13.608425] ipmi_si: Adding SMBIOS-specified kcs state machine
> [   13.614441] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca8, slave address 0x20, irq 0
> [   13.719025] ipmi_si dmi-ipmi-si.0: IPMI message handler: Found new BMC (man_id: 0x0002a2, prod_id: 0x0100, dev_id: 0x20)
> [   13.850173] ipmi_si dmi-ipmi-si.0: IPMI kcs interface initialized
> [   13.859889] IPMI Watchdog: driver initialized
> [   13.864384] IPMI poweroff: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot
> [   13.881130] IPMI poweroff: ATCA Detect mfg 0x2A2 prod 0x100
> [   13.886841] IPMI poweroff: Found a chassis style poweroff function
> [   13.893324] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [   13.901038] ACPI: Power Button [PWRF]
> [   13.911139] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [   13.938238] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   13.966495] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [   13.974870] lp: driver loaded but no devices found
> [   13.980046] Linux agpgart interface v0.103
> [   13.999315] brd: module loaded
> [   14.012590] loop: module loaded
> [   14.037775] drbd: initialized. Version: 8.4.11 (api:1/proto:86-101)
> [   14.044183] drbd: built-in
> [   14.047021] drbd: registered as block device major 147
> [   14.052422] Uniform Multi-Platform E-IDE driver
> [   14.057400] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
> [   14.067373] legacy IDE will be removed in 2021, please switch to libata
> [   14.067373] Report any missing HW support to linux-ide@vger.kernel.org
> [   14.080734] Probing IDE interface ide0...
> [   14.478135] tsc: Refined TSC clocksource calibration: 2300.027 MHz
> [   14.484532] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x21274ea066d, max_idle_ns: 440795221700 ns
> [   14.495544] clocksource: Switched to clocksource tsc
> [   14.603225] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [   14.607930] legacy IDE will be removed in 2021, please switch to libata
> [   14.607930] Report any missing HW support to linux-ide@vger.kernel.org
> [   14.621288] Probing IDE interface ide1...
> [   15.144217] ide1 at 0x170-0x177,0x376 on irq 15
> [   15.148905] ide-gd driver 1.18
> [   15.152097] ide-cd driver 5.00
> [   15.155629] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
> [   15.163311] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
> [   15.170436] megasas: 07.710.50.00-rc1
> [   15.174266] mpt3sas version 31.100.00.00 loaded
> [   15.179223] mpt3sas 0000:05:00.0: can't disable ASPM; OS doesn't have ASPM control
> [   15.187533] mpt2sas_cm0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (528085316 kB)
> [   15.254376] mpt2sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
> [   15.262624] mpt2sas_cm0: MSI-X vectors supported: 1
> [   15.267643] 	 no of cores: 64, max_msix_vectors: -1
> [   15.272653] mpt2sas_cm0:  0 1
> [   15.275841] mpt2sas_cm0: High IOPs queues : disabled
> [   15.280939] mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 42
> [   15.286124] mpt2sas_cm0: iomem(0x00000000ef1f0000), mapped(0x(____ptrval____)), size(65536)
> [   15.294693] mpt2sas_cm0: ioport(0x000000000000fc00), size(256)
> [   15.359374] mpt2sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
> [   15.367622] mpt2sas_cm0: sending diag reset !!
> [   16.696995] mpt2sas_cm0: diag reset: SUCCESS
> [   16.737401] mpt2sas_cm0: Allocated physical memory: size(1283 kB)
> [   16.743635] mpt2sas_cm0: Current Controller Queue Depth(2552),Max Controller Queue Depth(2607)
> [   16.752461] mpt2sas_cm0: Scatter Gather Elements per IO(128)
> [   16.806307] mpt2sas_cm0: log_info(0x30030100): originator(IOP), code(0x03), sub_code(0x0100)
> [   16.814008] mpt2sas_cm0: log_info(0x30030100): originator(IOP), code(0x03), sub_code(0x0100)
> [   16.815113] mpt2sas_cm0: LSISAS2008: FWVersion(07.15.08.00), ChipRevision(0x03), BiosVersion(07.11.10.00)
> [   16.833469] mpt2sas_cm0: Protocol=(Initiator,Target), Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
> [   16.845960] scsi host0: Fusion MPT SAS Host
> [   16.851414] mpt2sas_cm0: sending port enable !!
> [   16.853069] tun: Universal TUN/TAP device driver, 1.6
> [   16.861555] bnx2: QLogic bnx2 Gigabit Ethernet Driver v2.2.6 (January 29, 2014)
> [   16.869250] PCI Interrupt Link [LN24] enabled at IRQ 24
> [   16.875094] bnx2 0000:01:00.0 eth0: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem e6000000, IRQ 43, node addr d4:ae:52:e7:19:3e
> [   16.889219] PCI Interrupt Link [LN25] enabled at IRQ 25
> [   16.895071] bnx2 0000:01:00.1 eth1: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem e8000000, IRQ 44, node addr d4:ae:52:e7:19:40
> [   16.909195] PCI Interrupt Link [LN28] enabled at IRQ 28
> [   16.915006] bnx2 0000:02:00.0 eth2: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem ea000000, IRQ 45, node addr d4:ae:52:e7:19:42
> [   16.929083] PCI Interrupt Link [LN29] enabled at IRQ 29
> [   16.934889] bnx2 0000:02:00.1 eth3: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem ec000000, IRQ 46, node addr d4:ae:52:e7:19:44
> [   16.948886] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.713.36-0 (2014/02/10)
> [   16.958532] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> [   16.964764] e100: Copyright(c) 1999-2006 Intel Corporation
> [   16.970410] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [   16.977593] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [   16.983501] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [   16.989467] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   16.995553] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
> [   17.002659] igb: Copyright (c) 2007-2014 Intel Corporation.
> [   17.008393] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
> [   17.016436] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [   17.022537] sky2: driver version 1.30
> [   17.026570] Fusion MPT base driver 3.04.20
> [   17.030799] Copyright (c) 1999-2008 LSI Corporation
> [   17.035816] Fusion MPT SPI Host driver 3.04.20
> [   17.040418] Fusion MPT FC Host driver 3.04.20
> [   17.044931] Fusion MPT SAS Host driver 3.04.20
> [   17.049533] Fusion MPT misc device (ioctl) driver 3.04.20
> [   17.055192] mptctl: Registered with Fusion MPT base driver
> [   17.060816] mptctl: /dev/mptctl @ (major,minor=10,220)
> [   17.066102] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [   17.072776] ehci-pci: EHCI PCI platform driver
> [   17.077608] ehci-pci 0000:00:12.2: EHCI Host Controller
> [   17.082979] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
> [   17.090590] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [   17.099517] ehci-pci 0000:00:12.2: debug port 1
> [   17.104234] ehci-pci 0000:00:12.2: irq 17, io mem 0xef4ffe00
> [   17.117130] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
> [   17.123285] hub 1-0:1.0: USB hub found
> [   17.127177] hub 1-0:1.0: 6 ports detected
> [   17.131767] ehci-pci 0000:00:13.2: EHCI Host Controller
> [   17.138633] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
> [   17.146247] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [   17.155175] ehci-pci 0000:00:13.2: debug port 1
> [   17.159884] ehci-pci 0000:00:13.2: irq 19, io mem 0xef4fff00
> [   17.172132] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
> [   17.178276] hub 2-0:1.0: USB hub found
> [   17.182166] hub 2-0:1.0: 6 ports detected
> [   17.186658] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [   17.193004] ohci-pci: OHCI PCI platform driver
> [   17.197784] ohci-pci 0000:00:12.0: OHCI PCI host controller
> [   17.203502] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
> [   17.211150] ohci-pci 0000:00:12.0: irq 16, io mem 0xef4fb000
> [   17.272383] hub 3-0:1.0: USB hub found
> [   17.276279] hub 3-0:1.0: 3 ports detected
> [   17.280764] ohci-pci 0000:00:12.1: OHCI PCI host controller
> [   17.286478] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 4
> [   17.294115] ohci-pci 0000:00:12.1: irq 16, io mem 0xef4fc000
> [   17.355384] hub 4-0:1.0: USB hub found
> [   17.359279] hub 4-0:1.0: 3 ports detected
> [   17.363772] ohci-pci 0000:00:13.0: OHCI PCI host controller
> [   17.369485] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
> [   17.377132] ohci-pci 0000:00:13.0: irq 18, io mem 0xef4fd000
> [   17.404317] ide0: unexpected interrupt, status=0xff, count=1
> [   17.438382] hub 5-0:1.0: USB hub found
> [   17.442275] hub 5-0:1.0: 3 ports detected
> [   17.446782] ohci-pci 0000:00:13.1: OHCI PCI host controller
> [   17.452496] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 6
> [   17.460131] ohci-pci 0000:00:13.1: irq 18, io mem 0xef4fe000
> [   17.521166] usb 2-2: new high-speed USB device number 2 using ehci-pci
> [   17.528090] hub 6-0:1.0: USB hub found
> [   17.531990] hub 6-0:1.0: 3 ports detected
> [   17.536437] uhci_hcd: USB Universal Host Controller Interface driver
> [   17.543059] usbcore: registered new interface driver usb-storage
> [   17.544055] hub 2-2:1.0: USB hub found
> [   17.549236] usbcore: registered new interface driver ftdi_sio
> [   17.553522] hub 2-2:1.0: 4 ports detected
> [   17.559005] usbserial: USB Serial support registered for FTDI USB Serial Device
> [   17.570718] usbcore: registered new interface driver omninet
> [   17.576517] usbserial: USB Serial support registered for ZyXEL - omni.net lcd plus usb
> [   17.584690] i8042: PNP: No PS/2 controller found.
> [   17.589527] i8042: Probing ports directly.
> [   17.596704] serio: i8042 KBD port at 0x60,0x64 irq 1
> [   17.601812] serio: i8042 AUX port at 0x60,0x64 irq 12
> [   17.607346] rtc_cmos 00:01: RTC can wake from S4
> [   17.612278] rtc_cmos 00:01: registered as rtc0
> [   17.616875] rtc_cmos 00:01: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
> [   17.624730] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0x900, revision 0
> [   17.632381] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0x920
> [   17.640091] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [   17.645806] iTCO_vendor_support: vendor-support=0
> [   17.650674] nv_tco: NV TCO WatchDog Timer Driver v0.01
> [   17.656687] EDAC amd64: Node 0: DRAM ECC enabled.
> [   17.661966] EDAC amd64: F15h detected (node 0).
> [   17.666690] EDAC MC: DCT0 chip selects:
> [   17.666691] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.671528] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.676376] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.681215] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.686053] EDAC MC: DCT1 chip selects:
> [   17.686054] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.690914] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.695752] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.700592] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.705440] EDAC amd64: using x8 syndromes.
> [   17.709767] EDAC amd64: MCT channel count: 2
> [   17.710026] usb 4-1: new full-speed USB device number 2 using ohci-pci
> [   17.714572] EDAC MC0: Giving out device to module amd64_edac controller F15h: DEV 0000:00:18.3 (INTERRUPT)
> [   17.730872] EDAC amd64: Node 1: DRAM ECC enabled.
> [   17.735717] EDAC amd64: F15h detected (node 1).
> [   17.740443] EDAC MC: DCT0 chip selects:
> [   17.740444] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.745285] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.750130] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.754969] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.759812] EDAC MC: DCT1 chip selects:
> [   17.759813] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.764656] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.769494] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.774336] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.779179] EDAC amd64: using x8 syndromes.
> [   17.783495] EDAC amd64: MCT channel count: 2
> [   17.788046] EDAC MC1: Giving out device to module amd64_edac controller F15h: DEV 0000:00:19.3 (INTERRUPT)
> [   17.798020] EDAC amd64: Node 2: DRAM ECC enabled.
> [   17.802858] EDAC amd64: F15h detected (node 2).
> [   17.807579] EDAC MC: DCT0 chip selects:
> [   17.807580] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.812417] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.817255] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.822094] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.826930] EDAC MC: DCT1 chip selects:
> [   17.826931] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.831771] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.836608] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.841453] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.846292] EDAC amd64: using x8 syndromes.
> [   17.850609] EDAC amd64: MCT channel count: 2
> [   17.855162] EDAC MC2: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1a.3 (INTERRUPT)
> [   17.865146] EDAC amd64: Node 3: DRAM ECC enabled.
> [   17.869986] EDAC amd64: F15h detected (node 3).
> [   17.874723] EDAC MC: DCT0 chip selects:
> [   17.874724] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.879566] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.884407] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.889251] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.894093] EDAC MC: DCT1 chip selects:
> [   17.894094] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.898939] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.903776] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.908613] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.913448] EDAC amd64: using x8 syndromes.
> [   17.917762] EDAC amd64: MCT channel count: 2
> [   17.922310] EDAC MC3: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1b.3 (INTERRUPT)
> [   17.932288] EDAC amd64: Node 4: DRAM ECC enabled.
> [   17.937138] EDAC amd64: F15h detected (node 4).
> [   17.941861] EDAC MC: DCT0 chip selects:
> [   17.941862] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.946697] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.951536] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.956373] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.961209] EDAC MC: DCT1 chip selects:
> [   17.961210] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   17.966046] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   17.970885] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   17.975722] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   17.980559] EDAC amd64: using x8 syndromes.
> [   17.984875] EDAC amd64: MCT channel count: 2
> [   17.989426] EDAC MC4: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1c.3 (INTERRUPT)
> [   17.999407] EDAC amd64: Node 5: DRAM ECC enabled.
> [   18.004252] EDAC amd64: F15h detected (node 5).
> [   18.008981] EDAC MC: DCT0 chip selects:
> [   18.008981] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   18.013822] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   18.018660] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   18.023496] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   18.028332] EDAC MC: DCT1 chip selects:
> [   18.028333] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   18.033173] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   18.038011] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   18.042847] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   18.047683] EDAC amd64: using x8 syndromes.
> [   18.052000] EDAC amd64: MCT channel count: 2
> [   18.056551] EDAC MC5: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1d.3 (INTERRUPT)
> [   18.066525] EDAC amd64: Node 6: DRAM ECC enabled.
> [   18.071365] EDAC amd64: F15h detected (node 6).
> [   18.076090] EDAC MC: DCT0 chip selects:
> [   18.076091] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   18.080930] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   18.085767] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   18.090607] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   18.095447] EDAC MC: DCT1 chip selects:
> [   18.095448] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   18.100287] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   18.105124] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   18.109959] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   18.114796] EDAC amd64: using x8 syndromes.
> [   18.119111] EDAC amd64: MCT channel count: 2
> [   18.123674] EDAC MC6: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1e.3 (INTERRUPT)
> [   18.133646] EDAC amd64: Node 7: DRAM ECC enabled.
> [   18.138490] EDAC amd64: F15h detected (node 7).
> [   18.143221] EDAC MC: DCT0 chip selects:
> [   18.143222] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   18.148061] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   18.152897] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   18.157732] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   18.162572] EDAC MC: DCT1 chip selects:
> [   18.162573] EDAC amd64: MC: 0:  8192MB 1:  8192MB
> [   18.167409] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [   18.172246] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   18.177082] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   18.181919] EDAC amd64: using x8 syndromes.
> [   18.186233] EDAC amd64: MCT channel count: 2
> [   18.190781] EDAC MC7: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1f.3 (INTERRUPT)
> [   18.200663] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
> [   18.211666] AMD64 EDAC driver v3.5.0
> [   18.215388] hidraw: raw HID events driver (C) Jiri Kosina
> [   18.226839] input: Peppercon AG Multidevice as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.0/0003:14DD:0002.0001/input/input4
> [   18.292355] hid-generic 0003:14DD:0002.0001: input,hidraw0: USB HID v1.01 Keyboard [Peppercon AG Multidevice] on usb-0000:00:12.1-1/input0
> [   18.310747] input: Peppercon AG Multidevice as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:14DD:0002.0002/input/input5
> [   18.322790] hid-generic 0003:14DD:0002.0002: input,hidraw1: USB HID v1.01 Mouse [Peppercon AG Multidevice] on usb-0000:00:12.1-1/input1
> [   18.335210] usbcore: registered new interface driver usbhid
> [   18.340916] usbhid: USB HID core driver
> [   18.344906] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
> [   18.353434] drop_monitor: Initializing network drop monitor service
> [   18.359932] Key type dns_resolver registered
> [   18.371495] microcode: CPU0: patch_level=0x0600063d
> [   18.376531] microcode: CPU1: patch_level=0x0600063d
> [   18.381633] microcode: CPU2: patch_level=0x0600063d
> [   18.386667] microcode: CPU3: patch_level=0x0600063d
> [   18.391684] microcode: CPU4: patch_level=0x0600063d
> [   18.396704] microcode: CPU5: patch_level=0x0600063d
> [   18.401803] microcode: CPU6: patch_level=0x0600063d
> [   18.406825] microcode: CPU7: patch_level=0x0600063d
> [   18.411925] microcode: CPU8: patch_level=0x0600063d
> [   18.416951] microcode: CPU9: patch_level=0x0600063d
> [   18.422053] microcode: CPU10: patch_level=0x0600063d
> [   18.427166] microcode: CPU11: patch_level=0x0600063d
> [   18.432354] microcode: CPU12: patch_level=0x0600063d
> [   18.437472] microcode: CPU13: patch_level=0x0600063d
> [   18.442659] microcode: CPU14: patch_level=0x0600063d
> [   18.447770] microcode: CPU15: patch_level=0x0600063d
> [   18.452953] microcode: CPU16: patch_level=0x0600063d
> [   18.458078] microcode: CPU17: patch_level=0x0600063d
> [   18.463266] microcode: CPU18: patch_level=0x0600063d
> [   18.468380] microcode: CPU19: patch_level=0x0600063d
> [   18.473565] microcode: CPU20: patch_level=0x0600063d
> [   18.477113] random: fast init done
> [   18.478676] microcode: CPU21: patch_level=0x0600063d
> [   18.482469] mpt2sas_cm0: host_add: handle(0x0001), sas_addr(0x5d4ae520b63a7d00), phys(8)
> [   18.487397] microcode: CPU22: patch_level=0x0600063d
> [   18.500759] microcode: CPU23: patch_level=0x0600063d
> [   18.505945] microcode: CPU24: patch_level=0x0600063d
> [   18.511070] microcode: CPU25: patch_level=0x0600063d
> [   18.516256] microcode: CPU26: patch_level=0x0600063d
> [   18.521377] microcode: CPU27: patch_level=0x0600063d
> [   18.526565] microcode: CPU28: patch_level=0x0600063d
> [   18.531680] microcode: CPU29: patch_level=0x0600063d
> [   18.536864] microcode: CPU30: patch_level=0x0600063d
> [   18.541978] microcode: CPU31: patch_level=0x0600063d
> [   18.547164] microcode: CPU32: patch_level=0x0600063d
> [   18.552286] microcode: CPU33: patch_level=0x0600063d
> [   18.557482] microcode: CPU34: patch_level=0x0600063d
> [   18.562596] microcode: CPU35: patch_level=0x0600063d
> [   18.567782] microcode: CPU36: patch_level=0x0600063d
> [   18.572893] microcode: CPU37: patch_level=0x0600063d
> [   18.578079] microcode: CPU38: patch_level=0x0600063d
> [   18.583192] microcode: CPU39: patch_level=0x0600063d
> [   18.588385] microcode: CPU40: patch_level=0x0600063d
> [   18.593514] microcode: CPU41: patch_level=0x0600063d
> [   18.598711] microcode: CPU42: patch_level=0x0600063d
> [   18.603832] microcode: CPU43: patch_level=0x0600063d
> [   18.609026] microcode: CPU44: patch_level=0x0600063d
> [   18.614144] microcode: CPU45: patch_level=0x0600063d
> [   18.619340] microcode: CPU46: patch_level=0x0600063d
> [   18.624455] microcode: CPU47: patch_level=0x0600063d
> [   18.629645] microcode: CPU48: patch_level=0x0600063d
> [   18.634767] microcode: CPU49: patch_level=0x0600063d
> [   18.639961] microcode: CPU50: patch_level=0x0600063d
> [   18.645073] microcode: CPU51: patch_level=0x0600063d
> [   18.650265] microcode: CPU52: patch_level=0x0600063d
> [   18.655378] microcode: CPU53: patch_level=0x0600063d
> [   18.660568] microcode: CPU54: patch_level=0x0600063d
> [   18.665681] microcode: CPU55: patch_level=0x0600063d
> [   18.670878] microcode: CPU56: patch_level=0x0600063d
> [   18.675993] microcode: CPU57: patch_level=0x0600063d
> [   18.681188] microcode: CPU58: patch_level=0x0600063d
> [   18.686301] microcode: CPU59: patch_level=0x0600063d
> [   18.691492] microcode: CPU60: patch_level=0x0600063d
> [   18.696606] microcode: CPU61: patch_level=0x0600063d
> [   18.701793] microcode: CPU62: patch_level=0x0600063d
> [   18.706910] microcode: CPU63: patch_level=0x0600063d
> [   18.712018] microcode: Microcode Update Driver: v2.2.
> [   18.712022] IPI shorthand broadcast: enabled
> [   18.721622] sched_clock: Marking stable (17365226192, 1356381533)->(19224558299, -502950574)
> [   18.730462] registered taskstats version 1
> [   18.735492] rtc_cmos 00:01: setting system clock to 2020-02-26T13:41:02 UTC (1582724462)
> [   24.610126] mpt2sas_cm0: port enable: SUCCESS
> [   24.616600] scsi 0:0:0:0: Direct-Access     ATA      ST9500620NS      AA08 PQ: 0 ANSI: 5
> [   24.624922] scsi 0:0:0:0: SATA: handle(0x000b), sas_addr(0x4433221107000000), phy(7), device_name(0xc500500013104e89)
> [   24.635748] scsi 0:0:0:0: enclosure logical id (0x5d4ae520b63a7d00), slot(0) 
> [   24.643205] scsi 0:0:0:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [   24.736284] scsi 0:0:1:0: Direct-Access     ATA      ST1000LX015-1U71 SDM1 PQ: 0 ANSI: 5
> [   24.744620] scsi 0:0:1:0: SATA: handle(0x000a), sas_addr(0x4433221106000000), phy(6), device_name(0xc5005000a0cec450)
> [   24.755448] scsi 0:0:1:0: enclosure logical id (0x5d4ae520b63a7d00), slot(1) 
> [   24.762887] scsi 0:0:1:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [   24.901740] scsi 0:0:0:0: Attached scsi generic sg0 type 0
> [   24.903798] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [   24.907679] scsi 0:0:1:0: Attached scsi generic sg1 type 0
> [   24.945209] sd 0:0:1:0: [sdb] physical block alignment offset: 4096
> [   25.004345] sd 0:0:0:0: [sda] Write Protect is off
> [   25.009284] sd 0:0:0:0: [sda] Mode Sense: 7f 00 00 08
> [   25.010520] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   25.077163] sd 0:0:1:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [   25.085065] sd 0:0:1:0: [sdb] 4096-byte physical blocks
> [   25.114167]  sda: sda1 sda2 sda3
> [   25.214279] sd 0:0:0:0: [sda] Attached SCSI disk
> [   25.231754] sd 0:0:1:0: [sdb] Write Protect is off
> [   25.236694] sd 0:0:1:0: [sdb] Mode Sense: 7f 00 00 08
> [   25.319092] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   26.407769] sd 0:0:1:0: [sdb] Attached SCSI disk
> [   26.415517] Freeing unused kernel image memory: 1620K
> [   26.420726] Write protecting the kernel read-only data: 20480k
> [   26.428057] Freeing unused kernel image memory: 2012K
> [   26.433809] Freeing unused kernel image memory: 448K
> [   26.438911] Run /init as init process
> [   26.736424] REISERFS (device sda1): found reiserfs format "3.6" with standard journal
> [   26.744541] REISERFS (device sda1): using ordered data mode
> [   26.750254] reiserfs: using flush barriers
> [   26.774588] REISERFS (device sda1): journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   26.790467] REISERFS (device sda1): checking transaction log (sda1)
> [   26.837770] REISERFS (device sda1): Using r5 hash to sort names
> [   27.259924] random: crng init done
> [   28.180970] NET: Registered protocol family 10
> [   28.186621] Segment Routing with IPv6
> [   28.255949] NET: Registered protocol family 1
> [   30.276223] RPC: Registered named UNIX socket transport module.
> [   30.282288] RPC: Registered udp transport module.
> [   30.287130] RPC: Registered tcp transport module.
> [   30.291979] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [   31.067402] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [   31.235841] reiserfs: enabling write barrier flush mode
> [   33.407424] acpi_cpufreq: overriding BIOS provided _PSD data
> [   33.537979] 3ware 9000 Storage Controller device driver for Linux v2.26.02.014.
> [   33.792779] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
> [   33.800713] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [   33.806021] 3w-9xxx: scsi1: AEN: INFO (0x04:0x0053): Battery capacity test is overdue:.
> [   33.807122] PCI Interrupt Link [LN60] enabled at IRQ 60
> [   33.918052] scsi host1: 3ware 9000 Storage Controller
> [   33.923468] 3w-9xxx: scsi1: Found a 3ware 9000 Storage Controller at 0xef2ff000, IRQ: 33.
> [   33.980609] ixgbe 0000:22:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
> [   33.991408] ixgbe 0000:22:00.0: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> [   33.999851] ixgbe 0000:22:00.0: MAC: 2, PHY: 20, SFP+: 5, PBA No: G18786-001
> [   34.007049] ixgbe 0000:22:00.0: 90:e2:ba:29:c5:64
> [   34.013851] ixgbe 0000:22:00.0: Intel(R) 10 Gigabit Network Connection
> [   34.020869] libphy: ixgbe-mdio: probed
> [   34.025106] PCI Interrupt Link [LN61] enabled at IRQ 61
> [   34.248118] 3w-9xxx: scsi1: Firmware FH9X 4.10.00.027, BIOS BE9X 4.08.00.004, Ports: 128.
> [   34.257279] scsi 1:0:0:0: Direct-Access     AMCC     9690SA-8E  DISK  4.10 PQ: 0 ANSI: 5
> [   34.277535] sd 1:0:0:0: Attached scsi generic sg2 type 0
> [   34.277930] sd 1:0:0:0: [sdc] 54687195136 512-byte logical blocks: (28.0 TB/25.5 TiB)
> [   34.291964] sd 1:0:0:0: [sdc] Write Protect is off
> [   34.296902] sd 1:0:0:0: [sdc] Mode Sense: 23 00 10 00
> [   34.298787] sd 1:0:0:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [   34.321474] sd 1:0:0:0: [sdc] Attached SCSI disk
> [   34.674220] kvm: Nested Virtualization enabled
> [   34.678845] kvm: Nested Paging enabled
> [   34.817754] mgag200 0000:0a:03.0: remove_conflicting_pci_framebuffers: bar 0: 0xe4000000 -> 0xe47fffff
> [   34.827341] mgag200 0000:0a:03.0: remove_conflicting_pci_framebuffers: bar 1: 0xeeffc000 -> 0xeeffffff
> [   34.836879] mgag200 0000:0a:03.0: remove_conflicting_pci_framebuffers: bar 2: 0xee000000 -> 0xee7fffff
> [   34.846416] mgag200 0000:0a:03.0: vgaarb: deactivate vga console
> [   34.854020] Console: switching to colour dummy device 80x25
> [   34.864389] [TTM] Zone  kernel: Available graphics memory: 264044698 KiB
> [   34.871091] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [   34.877625] [TTM] Initializing pool allocator
> [   34.881992] [TTM] Initializing DMA pool allocator
> [   34.921359] fbcon: mgag200drmfb (fb0) is primary device
> [   35.055137] Console: switching to colour frame buffer device 128x48
> [   35.068706] mgag200 0000:0a:03.0: fb0: mgag200drmfb frame buffer device
> [   35.166606] ixgbe 0000:22:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
> [   35.177511] ixgbe 0000:22:00.1: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> [   35.182160] [drm] Initialized mgag200 1.0.0 20110418 for 0000:0a:03.0 on minor 0
> [   35.190230] ixgbe 0000:22:00.1: MAC: 2, PHY: 1, PBA No: G18786-001
> [   35.203521] ixgbe 0000:22:00.1: 90:e2:ba:29:c5:65
> [   35.216639] ixgbe 0000:22:00.1: Intel(R) 10 Gigabit Network Connection
> [   35.224312] libphy: ixgbe-mdio: probed
> [   35.472259] ide0: unexpected interrupt, status=0xff, count=43
> [   36.139723] bnx2 0000:01:00.0 net00: renamed from eth0
> [   36.254989] bnx2 0000:01:00.1 net01: renamed from eth1
> [   36.356941] bnx2 0000:02:00.0 net02: renamed from eth2
> [   36.465943] bnx2 0000:02:00.1 net03: renamed from eth3
> [   36.571064] ixgbe 0000:22:00.0 net04: renamed from eth4
> [   36.675925] ixgbe 0000:22:00.1 net05: renamed from eth5
> [   37.965837] ixgbe 0000:22:00.0: registered PHC device on net04
> [   38.168759] ixgbe 0000:22:00.0 net04: detected SFP+: 5
> [   38.430243] ixgbe 0000:22:00.0 net04: NIC Link is Up 10 Gbps, Flow Control: RX/TX
> [   38.446742] 8021q: 802.1Q VLAN Support v1.8
> [   38.446759] 8021q: adding VLAN 0 to HW filter on device net04
> [   39.286874] REISERFS (device sda2): found reiserfs format "3.6" with standard journal
> [   39.286885] REISERFS (device sda2): using ordered data mode
> [   39.286886] reiserfs: using flush barriers
> [   39.302928] REISERFS (device sda2): journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   39.303341] REISERFS (device sda2): checking transaction log (sda2)
> [   39.387036] REISERFS (device sda2): Using r5 hash to sort names
> [   39.461578] XFS (sdc): Mounting V4 Filesystem
> [   39.873345] XFS (sdc): Ending clean mount
> [   39.873426] xfs filesystem being mounted at /amd/enemenemuh/X/X2054 supports timestamps until 2038 (0x7fffffff)
> [   50.331767] NFSD: Using UMH upcall client tracking operations.
> [   50.331769] NFSD: starting 90-second grace period (net f0000098)
> [  100.052322] xfs filesystem being mounted at /amd/enemenemuh/X/X2054 supports timestamps until 2038 (0x7fffffff)
> [  103.562546] xfs filesystem being mounted at /amd/enemenemuh/X/X2054 supports timestamps until 2038 (0x7fffffff)
> [  107.624503] EXT4-fs (sdb): mounted filesystem with ordered data mode. Opts: (null)
> [  107.629928] xfs filesystem being mounted at /amd/enemenemuh/X/X2054 supports timestamps until 2038 (0x7fffffff)
> [  330.171961] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [  330.364048] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [  330.408828] FS-Cache: Netfs 'nfs' registered for caching
> [  330.564206] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [  330.867581] NFS: Registering the id_resolver key type
> [  330.867588] Key type id_resolver registered
> [  330.867589] Key type id_legacy registered
> [  330.908518] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 1879.973759] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 1880.216072] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 1880.440026] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 1880.721255] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 1922.996670] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 1923.235098] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 1923.813122] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 1924.050350] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 1975.639397] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 1975.865557] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 1976.105644] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 1990.596559] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2052.887547] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2053.135651] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2053.387819] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2130.331504] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2130.582973] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2130.842038] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2131.413368] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2161.914820] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2162.848200] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2163.107606] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2193.445501] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2193.617775] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [ 2193.768871] EXT4-fs (loop5): mounted filesystem without journal. Opts: (null)
> [ 2193.940564] EXT4-fs (loop6): mounted filesystem without journal. Opts: (null)
> [ 2236.255005] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2236.583514] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2236.887315] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2431.109670] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2431.396735] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2431.623741] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2431.883026] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2461.853834] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2462.818846] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2464.739816] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2465.014016] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2548.584979] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2548.848438] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2549.085581] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2551.174372] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2580.743912] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2582.931989] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2636.056742] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2636.308851] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2636.573645] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2636.847165] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2751.210164] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2751.473572] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2751.714707] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 2826.230114] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2826.380668] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2899.243523] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 2899.472733] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 2899.699152] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 2899.959221] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 3323.459727] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 3323.588437] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 3323.716334] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 3323.834246] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 3323.973186] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [ 3324.102039] EXT4-fs (loop5): mounted filesystem without journal. Opts: (null)
> [ 3335.477351] EXT4-fs (loop6): mounted filesystem without journal. Opts: (null)
> [ 5760.186694] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 6223.166589] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 6223.305418] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 6843.632761] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 6843.760486] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 6843.889286] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 6844.047031] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 6844.208720] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [ 6885.771766] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 6885.899528] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 6896.708858] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 6937.844563] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 6937.994292] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 6938.134477] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 6979.437807] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 6979.588375] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 6979.728250] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 7165.162952] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 7247.345476] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 7247.506195] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 7247.678862] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 7247.891593] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 7248.053440] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [ 7910.458108] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 7983.546279] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 7983.872866] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 8838.815752] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 8869.698316] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 8900.207080] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 8930.712975] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 8941.485336] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 8971.576833] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 8982.387165] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 9012.422927] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 9033.862487] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 9034.046172] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 9053.294381] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 9075.621509] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 9075.845268] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 9076.029057] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 9127.669343] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [ 9148.809037] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [ 9148.970757] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [ 9149.120802] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [ 9149.285027] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [ 9149.434962] EXT4-fs (loop5): mounted filesystem without journal. Opts: (null)
> [ 9149.586083] EXT4-fs (loop6): mounted filesystem without journal. Opts: (null)
> [ 9149.757932] EXT4-fs (loop7): mounted filesystem without journal. Opts: (null)
> [ 9149.942678] EXT4-fs (loop8): mounted filesystem without journal. Opts: (null)
> [ 9328.921587] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10168.107613] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10168.381688] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [10168.677993] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10169.010012] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [10215.256390] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10215.417190] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [10215.601246] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10215.786988] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [10215.970629] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [10216.142469] EXT4-fs (loop5): mounted filesystem without journal. Opts: (null)
> [10226.941786] EXT4-fs (loop6): mounted filesystem without journal. Opts: (null)
> [10237.762356] EXT4-fs (loop7): mounted filesystem without journal. Opts: (null)
> [10237.957176] EXT4-fs (loop8): mounted filesystem without journal. Opts: (null)
> [10238.184828] EXT4-fs (loop9): mounted filesystem without journal. Opts: (null)
> [10246.336988] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10246.615565] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [10246.853447] EXT4-fs (loop10): mounted filesystem without journal. Opts: (null)
> [10247.400201] EXT4-fs (loop11): mounted filesystem without journal. Opts: (null)
> [10269.474719] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [10269.646741] EXT4-fs (loop5): mounted filesystem without journal. Opts: (null)
> [10291.395209] EXT4-fs (loop6): mounted filesystem without journal. Opts: (null)
> [10349.414432] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10349.620220] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [10349.792202] EXT4-fs (loop5): mounted filesystem without journal. Opts: (null)
> [10397.083209] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10397.390831] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10397.732371] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [10398.256019] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [10398.439843] EXT4-fs (loop6): mounted filesystem without journal. Opts: (null)
> [10398.655644] EXT4-fs (loop7): mounted filesystem without journal. Opts: (null)
> [10427.953922] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10428.137738] EXT4-fs (loop8): mounted filesystem without journal. Opts: (null)
> [10439.821154] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10440.015235] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [10440.154794] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [10440.316671] EXT4-fs (loop6): mounted filesystem without journal. Opts: (null)
> [10451.115554] EXT4-fs (loop9): mounted filesystem without journal. Opts: (null)
> [10459.747000] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10471.025292] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10471.187335] EXT4-fs (loop8): mounted filesystem without journal. Opts: (null)
> [10492.469733] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10521.035681] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10535.324395] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10567.824181] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10567.974117] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10665.816027] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10666.021675] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10716.754043] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10758.563099] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [10758.757998] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10758.940871] EXT4-fs (loop3): mounted filesystem without journal. Opts: (null)
> [10770.206470] EXT4-fs (loop4): mounted filesystem without journal. Opts: (null)
> [10770.379344] EXT4-fs (loop5): mounted filesystem without journal. Opts: (null)
> [10770.614062] EXT4-fs (loop6): mounted filesystem without journal. Opts: (null)
> [10770.819821] EXT4-fs (loop7): mounted filesystem without journal. Opts: (null)
> [10771.443393] EXT4-fs (loop8): mounted filesystem without journal. Opts: (null)
> [10771.771827] EXT4-fs (loop9): mounted filesystem without journal. Opts: (null)
> [10772.274271] EXT4-fs (loop10): mounted filesystem without journal. Opts: (null)
> [10780.901473] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> [10792.190184] EXT4-fs (loop1): mounted filesystem without journal. Opts: (null)
> [10816.520551] EXT4-fs (loop2): mounted filesystem without journal. Opts: (null)
> [10834.604899] ------------[ cut here ]------------
> [10834.604906] kernel BUG at mm/vmscan.c:1740!
> [10834.604917] invalid opcode: 0000 [#1] SMP NOPTI
> [10834.609485] CPU: 46 PID: 409 Comm: kswapd3 Kdump: loaded Not tainted 5.4.14.mx64.317 #1
> [10834.617505] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [10834.625014] RIP: 0010:isolate_lru_pages+0x367/0x370
> [10834.629904] Code: e9 53 4d 89 f8 41 54 48 8b 4c 24 18 8b 54 24 28 8b 74 24 40 e8 4a 3b c4 00 49 8b 06 48 83 c4 18 48 85 c0 75 d0 e9 c4 fe ff ff <0f> 0b e8 42 c0 ea ff 66 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54
> [10834.648716] RSP: 0018:ffffc9000d407ae0 EFLAGS: 00010082
> [10834.653955] RAX: 00000000ffffffea RBX: ffffea00e0800008 RCX: ffff88bfdc595420
> [10834.661103] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea00e0800000
> [10834.668253] RBP: ffffc9000d407de8 R08: ffffc9000d407de8 R09: 0000000000000020
> [10834.675401] R10: 00000000f0000000 R11: 0000000000000000 R12: ffff88bfdc595420
> [10834.682549] R13: 0000000000000001 R14: 0000000000000010 R15: 0000000000000010
> [10834.689698] FS:  0000000000000000(0000) GS:ffff88bfdfb80000(0000) knlGS:0000000000000000
> [10834.697802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [10834.703559] CR2: 000000000060d348 CR3: 0000004fd3876000 CR4: 00000000000406e0
> [10834.710709] Call Trace:
> [10834.713170]  shrink_inactive_list+0x113/0x3d0
> [10834.717543]  shrink_node_memcg+0x3c8/0x800
> [10834.721655]  ? shrink_slab+0x295/0x2c0
> [10834.725417]  ? shrink_slab+0x295/0x2c0
> [10834.729179]  ? shrink_node+0xb6/0x420
> [10834.732866]  shrink_node+0xb6/0x420
> [10834.736367]  balance_pgdat+0x250/0x550
> [10834.740130]  kswapd+0x15d/0x3f0
> [10834.743286]  ? wait_woken+0x80/0x80
> [10834.746785]  ? balance_pgdat+0x550/0x550
> [10834.750724]  kthread+0x117/0x130
> [10834.753968]  ? kthread_create_worker_on_cpu+0x70/0x70
> [10834.759039]  ret_from_fork+0x22/0x40
> [10834.762627] Modules linked in: nfsv4 nfs rpcsec_gss_krb5 ext4 mbcache jbd2 8021q garp stp mrp llc input_leds led_class mgag200 drm_vram_helper ttm kvm_amd drm_kms_helper kvm drm fb_sys_fops syscopyarea sysfillrect sysimgblt ixgbe irqbypass 3w_9xxx crc32c_intel acpi_cpufreq nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc ip_tables x_tables unix ipv6 nf_defrag_ipv6 autofs4
> [10834.796386] ---[ end trace 28611096f6473c90 ]---
> [10834.801021] RIP: 0010:isolate_lru_pages+0x367/0x370
> [10834.805916] Code: e9 53 4d 89 f8 41 54 48 8b 4c 24 18 8b 54 24 28 8b 74 24 40 e8 4a 3b c4 00 49 8b 06 48 83 c4 18 48 85 c0 75 d0 e9 c4 fe ff ff <0f> 0b e8 42 c0 ea ff 66 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54
> [10834.824748] RSP: 0018:ffffc9000d407ae0 EFLAGS: 00010082
> [10834.829991] RAX: 00000000ffffffea RBX: ffffea00e0800008 RCX: ffff88bfdc595420
> [10834.837147] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea00e0800000
> [10834.844304] RBP: ffffc9000d407de8 R08: ffffc9000d407de8 R09: 0000000000000020
> [10834.851461] R10: 00000000f0000000 R11: 0000000000000000 R12: ffff88bfdc595420
> [10834.858619] R13: 0000000000000001 R14: 0000000000000010 R15: 0000000000000010
> [10834.865777] FS:  0000000000000000(0000) GS:ffff88bfdfb80000(0000) knlGS:0000000000000000
> [10834.875123] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [10834.882114] CR2: 000000000060d348 CR3: 0000004fd3876000 CR4: 00000000000406e0
> [10894.892270] rcu: INFO: rcu_sched self-detected stall on CPU
> [10894.899177] rcu: 	46-....: (60000 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=13285 
> [10894.910728] 	(t=60019 jiffies g=2794673 q=53832)
> [10894.916845] Sending NMI from CPU 46 to CPUs 5:
> [10894.923575] NMI backtrace for cpu 5
> [10894.923576] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [10894.923577] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [10894.923577] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [10894.923578] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [10894.923579] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [10894.923580] RAX: 0000000000840101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [10894.923581] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [10894.923582] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [10894.923582] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [10894.923583] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [10894.923584] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [10894.923584] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [10894.923585] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [10894.923585] Call Trace:
> [10894.923586]  _raw_spin_lock_irqsave+0x22/0x30
> [10894.923586]  pagevec_lru_move_fn+0x6c/0xd0
> [10894.923586]  activate_page+0xb5/0xc0
> [10894.923587]  mark_page_accessed+0x7a/0x130
> [10894.923587]  generic_file_read_iter+0x4c8/0xae0
> [10894.923588]  ? generic_update_time+0x9c/0xc0
> [10894.923588]  ? pipe_write+0x286/0x400
> [10894.923589]  new_sync_read+0x114/0x1a0
> [10894.923589]  vfs_read+0x89/0x130
> [10894.923589]  ksys_read+0xa1/0xe0
> [10894.923590]  do_syscall_64+0x48/0x130
> [10894.923590]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [10894.923591] RIP: 0033:0x7fc44b933d71
> [10894.923592] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [10894.923593] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [10894.923594] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [10894.923594] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [10894.923595] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [10894.923596] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [10894.923596] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [10894.923621] NMI backtrace for cpu 46
> [10895.201507] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [10895.212597] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [10895.221378] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [10895.229193] Call Trace:
> [10895.232828]  <IRQ>
> [10895.236046]  dump_stack+0x50/0x6b
> [10895.240412]  nmi_cpu_backtrace+0x89/0x90
> [10895.245299]  ? lapic_can_unplug_cpu+0x90/0x90
> [10895.250482]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [10895.256307]  rcu_dump_cpu_stacks+0x99/0xd0
> [10895.261375]  rcu_sched_clock_irq+0x502/0x770
> [10895.266469]  ? tick_sched_do_timer+0x60/0x60
> [10895.271540]  update_process_times+0x24/0x50
> [10895.276703]  tick_sched_timer+0x37/0x70
> [10895.281375]  __hrtimer_run_queues+0x11f/0x2b0
> [10895.286480]  hrtimer_interrupt+0xe5/0x240
> [10895.291224]  smp_apic_timer_interrupt+0x6f/0x130
> [10895.296672]  apic_timer_interrupt+0xf/0x20
> [10895.301560]  </IRQ>
> [10895.304378] RIP: 0010:smp_call_function_many+0x22f/0x260
> [10895.310532] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [10895.330930] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [10895.339299] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [10895.347320] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [10895.355370] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [10895.363408] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [10895.371480] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [10895.379556]  ? native_set_ldt.part.10+0xc0/0xc0
> [10895.385040]  ? smp_call_function_many+0x20a/0x260
> [10895.390518]  ? native_set_ldt.part.10+0xc0/0xc0
> [10895.395822]  on_each_cpu+0x28/0x40
> [10895.400181]  flush_tlb_kernel_range+0x79/0x80
> [10895.405477]  pmd_free_pte_page+0x41/0x60
> [10895.410182]  ioremap_page_range+0x30f/0x560
> [10895.415158]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [10895.420343]  __ioremap_caller.constprop.18+0x1a8/0x300
> [10895.426410]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [10895.431303]  ? _cond_resched+0x15/0x40
> [10895.435956]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [10895.442028]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [10895.448262]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [10895.455249]  drm_gem_vmap+0x1f/0x60 [drm]
> [10895.460118]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [10895.465918]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [10895.472771]  process_one_work+0x1e5/0x410
> [10895.477603]  worker_thread+0x2d/0x3c0
> [10895.482020]  ? cancel_delayed_work+0x90/0x90
> [10895.487026]  kthread+0x117/0x130
> [10895.491024]  ? kthread_create_worker_on_cpu+0x70/0x70
> [10895.496844]  ret_from_fork+0x22/0x40
> [11074.895632] rcu: INFO: rcu_sched self-detected stall on CPU
> [11074.902146] rcu: 	46-....: (239396 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=50485 
> [11074.913260] 	(t=240021 jiffies g=2794673 q=187140)
> [11074.918932] Sending NMI from CPU 46 to CPUs 5:
> [11074.925262] NMI backtrace for cpu 5
> [11074.925263] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11074.925264] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11074.925264] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [11074.925265] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [11074.925266] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [11074.925267] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [11074.925268] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [11074.925269] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [11074.925269] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [11074.925270] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [11074.925270] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [11074.925271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11074.925271] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [11074.925272] Call Trace:
> [11074.925272]  _raw_spin_lock_irqsave+0x22/0x30
> [11074.925273]  pagevec_lru_move_fn+0x6c/0xd0
> [11074.925273]  activate_page+0xb5/0xc0
> [11074.925274]  mark_page_accessed+0x7a/0x130
> [11074.925274]  generic_file_read_iter+0x4c8/0xae0
> [11074.925274]  ? generic_update_time+0x9c/0xc0
> [11074.925275]  ? pipe_write+0x286/0x400
> [11074.925275]  new_sync_read+0x114/0x1a0
> [11074.925276]  vfs_read+0x89/0x130
> [11074.925276]  ksys_read+0xa1/0xe0
> [11074.925276]  do_syscall_64+0x48/0x130
> [11074.925277]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [11074.925278] RIP: 0033:0x7fc44b933d71
> [11074.925279] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [11074.925279] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [11074.925280] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [11074.925281] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [11074.925281] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [11074.925282] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [11074.925283] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [11074.925306] NMI backtrace for cpu 46
> [11075.188431] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11075.199383] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11075.207883] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [11075.215585] Call Trace:
> [11075.219100]  <IRQ>
> [11075.222130]  dump_stack+0x50/0x6b
> [11075.226512]  nmi_cpu_backtrace+0x89/0x90
> [11075.231449]  ? lapic_can_unplug_cpu+0x90/0x90
> [11075.236778]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [11075.242730]  rcu_dump_cpu_stacks+0x99/0xd0
> [11075.247803]  rcu_sched_clock_irq+0x502/0x770
> [11075.253076]  ? tick_sched_do_timer+0x60/0x60
> [11075.258292]  update_process_times+0x24/0x50
> [11075.263449]  tick_sched_timer+0x37/0x70
> [11075.268178]  __hrtimer_run_queues+0x11f/0x2b0
> [11075.273455]  hrtimer_interrupt+0xe5/0x240
> [11075.278322]  smp_apic_timer_interrupt+0x6f/0x130
> [11075.283839]  apic_timer_interrupt+0xf/0x20
> [11075.288833]  </IRQ>
> [11075.291756] RIP: 0010:smp_call_function_many+0x22f/0x260
> [11075.297955] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [11075.318520] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [11075.327011] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [11075.335022] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [11075.343031] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [11075.351043] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [11075.359057] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [11075.367077]  ? native_set_ldt.part.10+0xc0/0xc0
> [11075.372501]  ? smp_call_function_many+0x20a/0x260
> [11075.378149]  ? native_set_ldt.part.10+0xc0/0xc0
> [11075.383634]  on_each_cpu+0x28/0x40
> [11075.387984]  flush_tlb_kernel_range+0x79/0x80
> [11075.393308]  pmd_free_pte_page+0x41/0x60
> [11075.398139]  ioremap_page_range+0x30f/0x560
> [11075.403298]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11075.408492]  __ioremap_caller.constprop.18+0x1a8/0x300
> [11075.414594]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11075.419638]  ? _cond_resched+0x15/0x40
> [11075.424334]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [11075.430406]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [11075.436811]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [11075.443766]  drm_gem_vmap+0x1f/0x60 [drm]
> [11075.448731]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [11075.454494]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [11075.461512]  process_one_work+0x1e5/0x410
> [11075.466429]  worker_thread+0x2d/0x3c0
> [11075.471026]  ? cancel_delayed_work+0x90/0x90
> [11075.476142]  kthread+0x117/0x130
> [11075.480249]  ? kthread_create_worker_on_cpu+0x70/0x70
> [11075.486177]  ret_from_fork+0x22/0x40
> [11254.898992] rcu: INFO: rcu_sched self-detected stall on CPU
> [11254.905740] rcu: 	46-....: (418805 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=88644 
> [11254.916963] 	(t=420024 jiffies g=2794673 q=315013)
> [11254.922801] Sending NMI from CPU 46 to CPUs 5:
> [11254.929296] NMI backtrace for cpu 5
> [11254.929297] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11254.929297] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11254.929298] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [11254.929299] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [11254.929300] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [11254.929301] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [11254.929302] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [11254.929302] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [11254.929303] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [11254.929304] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [11254.929304] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [11254.929305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11254.929305] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [11254.929306] Call Trace:
> [11254.929306]  _raw_spin_lock_irqsave+0x22/0x30
> [11254.929307]  pagevec_lru_move_fn+0x6c/0xd0
> [11254.929307]  activate_page+0xb5/0xc0
> [11254.929307]  mark_page_accessed+0x7a/0x130
> [11254.929308]  generic_file_read_iter+0x4c8/0xae0
> [11254.929308]  ? generic_update_time+0x9c/0xc0
> [11254.929309]  ? pipe_write+0x286/0x400
> [11254.929309]  new_sync_read+0x114/0x1a0
> [11254.929310]  vfs_read+0x89/0x130
> [11254.929310]  ksys_read+0xa1/0xe0
> [11254.929310]  do_syscall_64+0x48/0x130
> [11254.929311]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [11254.929311] RIP: 0033:0x7fc44b933d71
> [11254.929313] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [11254.929313] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [11254.929314] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [11254.929315] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [11254.929315] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [11254.929316] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [11254.929317] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [11254.929341] NMI backtrace for cpu 46
> [11255.196685] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11255.207723] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11255.216343] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [11255.224101] Call Trace:
> [11255.227662]  <IRQ>
> [11255.230771]  dump_stack+0x50/0x6b
> [11255.235153]  nmi_cpu_backtrace+0x89/0x90
> [11255.240118]  ? lapic_can_unplug_cpu+0x90/0x90
> [11255.245499]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [11255.251484]  rcu_dump_cpu_stacks+0x99/0xd0
> [11255.256602]  rcu_sched_clock_irq+0x502/0x770
> [11255.261882]  ? tick_sched_do_timer+0x60/0x60
> [11255.267136]  update_process_times+0x24/0x50
> [11255.272292]  tick_sched_timer+0x37/0x70
> [11255.277097]  __hrtimer_run_queues+0x11f/0x2b0
> [11255.282371]  hrtimer_interrupt+0xe5/0x240
> [11255.287283]  smp_apic_timer_interrupt+0x6f/0x130
> [11255.292797]  apic_timer_interrupt+0xf/0x20
> [11255.297788]  </IRQ>
> [11255.300773] RIP: 0010:smp_call_function_many+0x22d/0x260
> [11255.306973] Code: 89 c7 e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a <f3> 90 8b 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2
> [11255.327592] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [11255.336100] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [11255.344208] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [11255.352275] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [11255.360346] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [11255.368415] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [11255.376494]  ? native_set_ldt.part.10+0xc0/0xc0
> [11255.381976]  ? smp_call_function_many+0x20a/0x260
> [11255.387637]  ? native_set_ldt.part.10+0xc0/0xc0
> [11255.393124]  on_each_cpu+0x28/0x40
> [11255.397484]  flush_tlb_kernel_range+0x79/0x80
> [11255.402803]  pmd_free_pte_page+0x41/0x60
> [11255.407692]  ioremap_page_range+0x30f/0x560
> [11255.412851]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11255.418105]  __ioremap_caller.constprop.18+0x1a8/0x300
> [11255.424227]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11255.429306]  ? _cond_resched+0x15/0x40
> [11255.434005]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [11255.440101]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [11255.446506]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [11255.453521]  drm_gem_vmap+0x1f/0x60 [drm]
> [11255.458445]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [11255.464252]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [11255.471284]  process_one_work+0x1e5/0x410
> [11255.476236]  worker_thread+0x2d/0x3c0
> [11255.480825]  ? cancel_delayed_work+0x90/0x90
> [11255.486002]  kthread+0x117/0x130
> [11255.490114]  ? kthread_create_worker_on_cpu+0x70/0x70
> [11255.496043]  ret_from_fork+0x22/0x40
> [11434.902340] rcu: INFO: rcu_sched self-detected stall on CPU
> [11434.909101] rcu: 	46-....: (598208 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=127239 
> [11434.920466] 	(t=600028 jiffies g=2794673 q=444180)
> [11434.926342] Sending NMI from CPU 46 to CPUs 5:
> [11434.932882] NMI backtrace for cpu 5
> [11434.932882] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11434.932883] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11434.932884] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [11434.932885] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [11434.932886] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [11434.932891] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [11434.932892] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [11434.932892] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [11434.932893] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [11434.932894] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [11434.932894] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [11434.932895] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11434.932895] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [11434.932896] Call Trace:
> [11434.932896]  _raw_spin_lock_irqsave+0x22/0x30
> [11434.932897]  pagevec_lru_move_fn+0x6c/0xd0
> [11434.932897]  activate_page+0xb5/0xc0
> [11434.932897]  mark_page_accessed+0x7a/0x130
> [11434.932898]  generic_file_read_iter+0x4c8/0xae0
> [11434.932898]  ? generic_update_time+0x9c/0xc0
> [11434.932899]  ? pipe_write+0x286/0x400
> [11434.932899]  new_sync_read+0x114/0x1a0
> [11434.932900]  vfs_read+0x89/0x130
> [11434.932900]  ksys_read+0xa1/0xe0
> [11434.932900]  do_syscall_64+0x48/0x130
> [11434.932901]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [11434.932901] RIP: 0033:0x7fc44b933d71
> [11434.932903] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [11434.932903] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [11434.932904] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [11434.932905] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [11434.932905] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [11434.932906] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [11434.932906] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [11434.932931] NMI backtrace for cpu 46
> [11435.199676] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11435.210666] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11435.219282] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [11435.226975] Call Trace:
> [11435.230544]  <IRQ>
> [11435.233648]  dump_stack+0x50/0x6b
> [11435.237977]  nmi_cpu_backtrace+0x89/0x90
> [11435.242894]  ? lapic_can_unplug_cpu+0x90/0x90
> [11435.248269]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [11435.254225]  rcu_dump_cpu_stacks+0x99/0xd0
> [11435.259302]  rcu_sched_clock_irq+0x502/0x770
> [11435.264545]  ? tick_sched_do_timer+0x60/0x60
> [11435.269798]  update_process_times+0x24/0x50
> [11435.274895]  tick_sched_timer+0x37/0x70
> [11435.279671]  __hrtimer_run_queues+0x11f/0x2b0
> [11435.284895]  hrtimer_interrupt+0xe5/0x240
> [11435.289810]  smp_apic_timer_interrupt+0x6f/0x130
> [11435.295278]  apic_timer_interrupt+0xf/0x20
> [11435.300261]  </IRQ>
> [11435.303216] RIP: 0010:smp_call_function_many+0x22f/0x260
> [11435.309443] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [11435.330006] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [11435.338461] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [11435.346560] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [11435.354626] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [11435.362701] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [11435.370772] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [11435.378850]  ? native_set_ldt.part.10+0xc0/0xc0
> [11435.384342]  ? smp_call_function_many+0x20a/0x260
> [11435.389987]  ? native_set_ldt.part.10+0xc0/0xc0
> [11435.395440]  on_each_cpu+0x28/0x40
> [11435.399752]  flush_tlb_kernel_range+0x79/0x80
> [11435.405017]  pmd_free_pte_page+0x41/0x60
> [11435.409911]  ioremap_page_range+0x30f/0x560
> [11435.415018]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11435.420269]  __ioremap_caller.constprop.18+0x1a8/0x300
> [11435.426364]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11435.431452]  ? _cond_resched+0x15/0x40
> [11435.436108]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [11435.442124]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [11435.448468]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [11435.455528]  drm_gem_vmap+0x1f/0x60 [drm]
> [11435.460465]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [11435.466311]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [11435.473323]  process_one_work+0x1e5/0x410
> [11435.478249]  worker_thread+0x2d/0x3c0
> [11435.482806]  ? cancel_delayed_work+0x90/0x90
> [11435.487988]  kthread+0x117/0x130
> [11435.492048]  ? kthread_create_worker_on_cpu+0x70/0x70
> [11435.497919]  ret_from_fork+0x22/0x40
> [11614.905694] rcu: INFO: rcu_sched self-detected stall on CPU
> [11614.912550] rcu: 	46-....: (777612 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=166667 
> [11614.923888] 	(t=780031 jiffies g=2794673 q=570268)
> [11614.929817] Sending NMI from CPU 46 to CPUs 5:
> [11614.936346] NMI backtrace for cpu 5
> [11614.936347] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11614.936348] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11614.936348] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [11614.936350] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [11614.936350] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [11614.936351] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [11614.936352] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [11614.936353] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [11614.936353] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [11614.936354] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [11614.936354] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [11614.936355] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11614.936356] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [11614.936356] Call Trace:
> [11614.936356]  _raw_spin_lock_irqsave+0x22/0x30
> [11614.936357]  pagevec_lru_move_fn+0x6c/0xd0
> [11614.936357]  activate_page+0xb5/0xc0
> [11614.936358]  mark_page_accessed+0x7a/0x130
> [11614.936358]  generic_file_read_iter+0x4c8/0xae0
> [11614.936359]  ? generic_update_time+0x9c/0xc0
> [11614.936359]  ? pipe_write+0x286/0x400
> [11614.936360]  new_sync_read+0x114/0x1a0
> [11614.936360]  vfs_read+0x89/0x130
> [11614.936360]  ksys_read+0xa1/0xe0
> [11614.936361]  do_syscall_64+0x48/0x130
> [11614.936361]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [11614.936362] RIP: 0033:0x7fc44b933d71
> [11614.936363] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [11614.936364] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [11614.936365] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [11614.936365] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [11614.936366] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [11614.936366] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [11614.936367] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [11614.936391] NMI backtrace for cpu 46
> [11615.203813] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11615.214873] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11615.223426] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [11615.231090] Call Trace:
> [11615.234572]  <IRQ>
> [11615.237632]  dump_stack+0x50/0x6b
> [11615.241988]  nmi_cpu_backtrace+0x89/0x90
> [11615.246957]  ? lapic_can_unplug_cpu+0x90/0x90
> [11615.252275]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [11615.258261]  rcu_dump_cpu_stacks+0x99/0xd0
> [11615.263376]  rcu_sched_clock_irq+0x502/0x770
> [11615.268593]  ? tick_sched_do_timer+0x60/0x60
> [11615.273826]  update_process_times+0x24/0x50
> [11615.278979]  tick_sched_timer+0x37/0x70
> [11615.283703]  __hrtimer_run_queues+0x11f/0x2b0
> [11615.288968]  hrtimer_interrupt+0xe5/0x240
> [11615.293824]  smp_apic_timer_interrupt+0x6f/0x130
> [11615.299342]  apic_timer_interrupt+0xf/0x20
> [11615.304275]  </IRQ>
> [11615.307257] RIP: 0010:smp_call_function_many+0x22f/0x260
> [11615.313398] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [11615.333964] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [11615.342465] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [11615.350535] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [11615.358602] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [11615.366663] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [11615.374711] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [11615.382793]  ? native_set_ldt.part.10+0xc0/0xc0
> [11615.388233]  ? smp_call_function_many+0x20a/0x260
> [11615.393893]  ? native_set_ldt.part.10+0xc0/0xc0
> [11615.399377]  on_each_cpu+0x28/0x40
> [11615.403676]  flush_tlb_kernel_range+0x79/0x80
> [11615.408980]  pmd_free_pte_page+0x41/0x60
> [11615.413818]  ioremap_page_range+0x30f/0x560
> [11615.418973]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11615.424166]  __ioremap_caller.constprop.18+0x1a8/0x300
> [11615.430290]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11615.435367]  ? _cond_resched+0x15/0x40
> [11615.440015]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [11615.446082]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [11615.452485]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [11615.459499]  drm_gem_vmap+0x1f/0x60 [drm]
> [11615.464372]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [11615.470178]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [11615.477207]  process_one_work+0x1e5/0x410
> [11615.482099]  worker_thread+0x2d/0x3c0
> [11615.486690]  ? cancel_delayed_work+0x90/0x90
> [11615.491847]  kthread+0x117/0x130
> [11615.495956]  ? kthread_create_worker_on_cpu+0x70/0x70
> [11615.501884]  ret_from_fork+0x22/0x40
> [11794.909044] rcu: INFO: rcu_sched self-detected stall on CPU
> [11794.915516] rcu: 	46-....: (957016 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=206828 
> [11794.926671] 	(t=960033 jiffies g=2794673 q=696506)
> [11794.932404] Sending NMI from CPU 46 to CPUs 5:
> [11794.938795] NMI backtrace for cpu 5
> [11794.938796] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11794.938797] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11794.938797] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [11794.938798] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [11794.938799] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [11794.938800] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [11794.938801] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [11794.938801] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [11794.938802] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [11794.938803] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [11794.938803] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [11794.938804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11794.938804] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [11794.938805] Call Trace:
> [11794.938805]  _raw_spin_lock_irqsave+0x22/0x30
> [11794.938806]  pagevec_lru_move_fn+0x6c/0xd0
> [11794.938806]  activate_page+0xb5/0xc0
> [11794.938806]  mark_page_accessed+0x7a/0x130
> [11794.938807]  generic_file_read_iter+0x4c8/0xae0
> [11794.938807]  ? generic_update_time+0x9c/0xc0
> [11794.938808]  ? pipe_write+0x286/0x400
> [11794.938808]  new_sync_read+0x114/0x1a0
> [11794.938809]  vfs_read+0x89/0x130
> [11794.938809]  ksys_read+0xa1/0xe0
> [11794.938809]  do_syscall_64+0x48/0x130
> [11794.938811]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [11794.938811] RIP: 0033:0x7fc44b933d71
> [11794.938812] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [11794.938813] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [11794.938814] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [11794.938814] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [11794.938815] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [11794.938815] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [11794.938816] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [11794.938839] NMI backtrace for cpu 46
> [11795.201830] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11795.212745] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11795.221311] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [11795.228958] Call Trace:
> [11795.232456]  <IRQ>
> [11795.235546]  dump_stack+0x50/0x6b
> [11795.239873]  nmi_cpu_backtrace+0x89/0x90
> [11795.244786]  ? lapic_can_unplug_cpu+0x90/0x90
> [11795.250173]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [11795.256171]  rcu_dump_cpu_stacks+0x99/0xd0
> [11795.261284]  rcu_sched_clock_irq+0x502/0x770
> [11795.266500]  ? tick_sched_do_timer+0x60/0x60
> [11795.271750]  update_process_times+0x24/0x50
> [11795.276848]  tick_sched_timer+0x37/0x70
> [11795.281636]  __hrtimer_run_queues+0x11f/0x2b0
> [11795.286857]  hrtimer_interrupt+0xe5/0x240
> [11795.291768]  smp_apic_timer_interrupt+0x6f/0x130
> [11795.297227]  apic_timer_interrupt+0xf/0x20
> [11795.302172]  </IRQ>
> [11795.305161] RIP: 0010:smp_call_function_many+0x22f/0x260
> [11795.311319] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [11795.331883] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [11795.340336] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [11795.348403] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [11795.356466] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [11795.364537] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [11795.372604] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [11795.380684]  ? native_set_ldt.part.10+0xc0/0xc0
> [11795.386175]  ? smp_call_function_many+0x20a/0x260
> [11795.391842]  ? native_set_ldt.part.10+0xc0/0xc0
> [11795.397270]  on_each_cpu+0x28/0x40
> [11795.401570]  flush_tlb_kernel_range+0x79/0x80
> [11795.406837]  pmd_free_pte_page+0x41/0x60
> [11795.411733]  ioremap_page_range+0x30f/0x560
> [11795.416833]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11795.422090]  __ioremap_caller.constprop.18+0x1a8/0x300
> [11795.428205]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11795.433279]  ? _cond_resched+0x15/0x40
> [11795.437923]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [11795.443949]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [11795.450315]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [11795.457327]  drm_gem_vmap+0x1f/0x60 [drm]
> [11795.462194]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [11795.468017]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [11795.475027]  process_one_work+0x1e5/0x410
> [11795.479953]  worker_thread+0x2d/0x3c0
> [11795.484503]  ? cancel_delayed_work+0x90/0x90
> [11795.489677]  kthread+0x117/0x130
> [11795.493727]  ? kthread_create_worker_on_cpu+0x70/0x70
> [11795.499599]  ret_from_fork+0x22/0x40
> [11974.912398] rcu: INFO: rcu_sched self-detected stall on CPU
> [11974.918948] rcu: 	46-....: (1136426 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=245810 
> [11974.930233] 	(t=1140036 jiffies g=2794673 q=828007)
> [11974.936053] Sending NMI from CPU 46 to CPUs 5:
> [11974.942444] NMI backtrace for cpu 5
> [11974.942445] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11974.942446] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11974.942447] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [11974.942448] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [11974.942448] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [11974.942449] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [11974.942450] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [11974.942451] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [11974.942451] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [11974.942452] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [11974.942453] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [11974.942453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11974.942454] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [11974.942454] Call Trace:
> [11974.942455]  _raw_spin_lock_irqsave+0x22/0x30
> [11974.942455]  pagevec_lru_move_fn+0x6c/0xd0
> [11974.942455]  activate_page+0xb5/0xc0
> [11974.942456]  mark_page_accessed+0x7a/0x130
> [11974.942456]  generic_file_read_iter+0x4c8/0xae0
> [11974.942457]  ? generic_update_time+0x9c/0xc0
> [11974.942457]  ? pipe_write+0x286/0x400
> [11974.942458]  new_sync_read+0x114/0x1a0
> [11974.942458]  vfs_read+0x89/0x130
> [11974.942458]  ksys_read+0xa1/0xe0
> [11974.942459]  do_syscall_64+0x48/0x130
> [11974.942464]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [11974.942464] RIP: 0033:0x7fc44b933d71
> [11974.942465] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [11974.942466] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [11974.942467] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [11974.942468] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [11974.942468] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [11974.942469] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [11974.942469] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [11974.942500] NMI backtrace for cpu 46
> [11975.206941] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [11975.217921] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [11975.226520] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [11975.234222] Call Trace:
> [11975.237761]  <IRQ>
> [11975.240857]  dump_stack+0x50/0x6b
> [11975.245239]  nmi_cpu_backtrace+0x89/0x90
> [11975.250209]  ? lapic_can_unplug_cpu+0x90/0x90
> [11975.255587]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [11975.261577]  rcu_dump_cpu_stacks+0x99/0xd0
> [11975.266699]  rcu_sched_clock_irq+0x502/0x770
> [11975.271973]  ? tick_sched_do_timer+0x60/0x60
> [11975.277229]  update_process_times+0x24/0x50
> [11975.282397]  tick_sched_timer+0x37/0x70
> [11975.287175]  __hrtimer_run_queues+0x11f/0x2b0
> [11975.292453]  hrtimer_interrupt+0xe5/0x240
> [11975.297363]  smp_apic_timer_interrupt+0x6f/0x130
> [11975.302878]  apic_timer_interrupt+0xf/0x20
> [11975.307870]  </IRQ>
> [11975.310855] RIP: 0010:smp_call_function_many+0x22f/0x260
> [11975.317053] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [11975.337670] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [11975.346172] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [11975.354240] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [11975.362308] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [11975.370382] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [11975.378458] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [11975.386539]  ? native_set_ldt.part.10+0xc0/0xc0
> [11975.392026]  ? smp_call_function_many+0x20a/0x260
> [11975.397690]  ? native_set_ldt.part.10+0xc0/0xc0
> [11975.403178]  on_each_cpu+0x28/0x40
> [11975.407538]  flush_tlb_kernel_range+0x79/0x80
> [11975.412859]  pmd_free_pte_page+0x41/0x60
> [11975.417748]  ioremap_page_range+0x30f/0x560
> [11975.422913]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11975.428161]  __ioremap_caller.constprop.18+0x1a8/0x300
> [11975.434283]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [11975.439360]  ? _cond_resched+0x15/0x40
> [11975.444064]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [11975.450133]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [11975.456538]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [11975.463591]  drm_gem_vmap+0x1f/0x60 [drm]
> [11975.468523]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [11975.474375]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [11975.481403]  process_one_work+0x1e5/0x410
> [11975.486357]  worker_thread+0x2d/0x3c0
> [11975.490945]  ? cancel_delayed_work+0x90/0x90
> [11975.496120]  kthread+0x117/0x130
> [11975.500233]  ? kthread_create_worker_on_cpu+0x70/0x70
> [11975.506162]  ret_from_fork+0x22/0x40
> [12154.915752] rcu: INFO: rcu_sched self-detected stall on CPU
> [12154.922280] rcu: 	46-....: (1315832 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=285576 
> [12154.933573] 	(t=1320039 jiffies g=2794673 q=955315)
> [12154.939399] Sending NMI from CPU 46 to CPUs 5:
> [12154.945793] NMI backtrace for cpu 5
> [12154.945793] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12154.945794] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12154.945795] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [12154.945797] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [12154.945797] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [12154.945798] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [12154.945799] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [12154.945800] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [12154.945800] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [12154.945801] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [12154.945801] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [12154.945802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12154.945802] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [12154.945803] Call Trace:
> [12154.945803]  _raw_spin_lock_irqsave+0x22/0x30
> [12154.945804]  pagevec_lru_move_fn+0x6c/0xd0
> [12154.945804]  activate_page+0xb5/0xc0
> [12154.945805]  mark_page_accessed+0x7a/0x130
> [12154.945805]  generic_file_read_iter+0x4c8/0xae0
> [12154.945806]  ? generic_update_time+0x9c/0xc0
> [12154.945806]  ? pipe_write+0x286/0x400
> [12154.945806]  new_sync_read+0x114/0x1a0
> [12154.945807]  vfs_read+0x89/0x130
> [12154.945807]  ksys_read+0xa1/0xe0
> [12154.945808]  do_syscall_64+0x48/0x130
> [12154.945808]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [12154.945809] RIP: 0033:0x7fc44b933d71
> [12154.945810] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [12154.945810] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [12154.945811] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [12154.945812] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [12154.945813] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [12154.945813] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [12154.945814] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [12154.945840] NMI backtrace for cpu 46
> [12155.210311] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12155.221291] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12155.229875] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [12155.237584] Call Trace:
> [12155.241122]  <IRQ>
> [12155.244214]  dump_stack+0x50/0x6b
> [12155.248604]  nmi_cpu_backtrace+0x89/0x90
> [12155.253575]  ? lapic_can_unplug_cpu+0x90/0x90
> [12155.258954]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [12155.264943]  rcu_dump_cpu_stacks+0x99/0xd0
> [12155.270058]  rcu_sched_clock_irq+0x502/0x770
> [12155.275341]  ? tick_sched_do_timer+0x60/0x60
> [12155.280595]  update_process_times+0x24/0x50
> [12155.285753]  tick_sched_timer+0x37/0x70
> [12155.290533]  __hrtimer_run_queues+0x11f/0x2b0
> [12155.295808]  hrtimer_interrupt+0xe5/0x240
> [12155.300722]  smp_apic_timer_interrupt+0x6f/0x130
> [12155.306240]  apic_timer_interrupt+0xf/0x20
> [12155.311235]  </IRQ>
> [12155.314222] RIP: 0010:smp_call_function_many+0x22f/0x260
> [12155.320424] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [12155.341046] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [12155.349547] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [12155.357616] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [12155.365683] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [12155.373757] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [12155.381857] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [12155.389980]  ? native_set_ldt.part.10+0xc0/0xc0
> [12155.395467]  ? smp_call_function_many+0x20a/0x260
> [12155.401127]  ? native_set_ldt.part.10+0xc0/0xc0
> [12155.406611]  on_each_cpu+0x28/0x40
> [12155.410968]  flush_tlb_kernel_range+0x79/0x80
> [12155.416289]  pmd_free_pte_page+0x41/0x60
> [12155.421184]  ioremap_page_range+0x30f/0x560
> [12155.426341]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12155.431596]  __ioremap_caller.constprop.18+0x1a8/0x300
> [12155.437717]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12155.442795]  ? _cond_resched+0x15/0x40
> [12155.447496]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [12155.453568]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [12155.459974]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [12155.466990]  drm_gem_vmap+0x1f/0x60 [drm]
> [12155.471913]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [12155.477729]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [12155.484758]  process_one_work+0x1e5/0x410
> [12155.489707]  worker_thread+0x2d/0x3c0
> [12155.494293]  ? cancel_delayed_work+0x90/0x90
> [12155.499470]  kthread+0x117/0x130
> [12155.503582]  ? kthread_create_worker_on_cpu+0x70/0x70
> [12155.509511]  ret_from_fork+0x22/0x40
> [12334.919080] rcu: INFO: rcu_sched self-detected stall on CPU
> [12334.925578] rcu: 	46-....: (1495238 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=325078 
> [12334.936810] 	(t=1500042 jiffies g=2794673 q=1082957)
> [12334.942736] Sending NMI from CPU 46 to CPUs 5:
> [12334.949131] NMI backtrace for cpu 5
> [12334.949132] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12334.949133] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12334.949133] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [12334.949135] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [12334.949135] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [12334.949136] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [12334.949137] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [12334.949137] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [12334.949138] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [12334.949139] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [12334.949139] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [12334.949140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12334.949141] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [12334.949141] Call Trace:
> [12334.949141]  _raw_spin_lock_irqsave+0x22/0x30
> [12334.949142]  pagevec_lru_move_fn+0x6c/0xd0
> [12334.949142]  activate_page+0xb5/0xc0
> [12334.949143]  mark_page_accessed+0x7a/0x130
> [12334.949143]  generic_file_read_iter+0x4c8/0xae0
> [12334.949144]  ? generic_update_time+0x9c/0xc0
> [12334.949144]  ? pipe_write+0x286/0x400
> [12334.949145]  new_sync_read+0x114/0x1a0
> [12334.949145]  vfs_read+0x89/0x130
> [12334.949145]  ksys_read+0xa1/0xe0
> [12334.949146]  do_syscall_64+0x48/0x130
> [12334.949147]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [12334.949147] RIP: 0033:0x7fc44b933d71
> [12334.949148] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [12334.949149] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [12334.949150] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [12334.949150] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [12334.949151] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [12334.949151] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [12334.949152] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [12334.949181] NMI backtrace for cpu 46
> [12335.212230] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12335.223204] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12335.231720] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [12335.239371] Call Trace:
> [12335.242852]  <IRQ>
> [12335.245934]  dump_stack+0x50/0x6b
> [12335.250270]  nmi_cpu_backtrace+0x89/0x90
> [12335.255238]  ? lapic_can_unplug_cpu+0x90/0x90
> [12335.260564]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [12335.266546]  rcu_dump_cpu_stacks+0x99/0xd0
> [12335.271665]  rcu_sched_clock_irq+0x502/0x770
> [12335.276884]  ? tick_sched_do_timer+0x60/0x60
> [12335.282141]  update_process_times+0x24/0x50
> [12335.287298]  tick_sched_timer+0x37/0x70
> [12335.292020]  __hrtimer_run_queues+0x11f/0x2b0
> [12335.297277]  ? ixgbe_msix_clean_rings+0x19/0x40 [ixgbe]
> [12335.303410]  hrtimer_interrupt+0xe5/0x240
> [12335.308275]  smp_apic_timer_interrupt+0x6f/0x130
> [12335.313796]  apic_timer_interrupt+0xf/0x20
> [12335.318733]  </IRQ>
> [12335.321721] RIP: 0010:smp_call_function_many+0x22f/0x260
> [12335.327871] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [12335.348419] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [12335.356920] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [12335.364988] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [12335.373055] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [12335.381112] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [12335.389196] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [12335.397236]  ? native_set_ldt.part.10+0xc0/0xc0
> [12335.402720]  ? smp_call_function_many+0x20a/0x260
> [12335.408386]  ? native_set_ldt.part.10+0xc0/0xc0
> [12335.413880]  on_each_cpu+0x28/0x40
> [12335.418207]  flush_tlb_kernel_range+0x79/0x80
> [12335.423541]  pmd_free_pte_page+0x41/0x60
> [12335.428393]  ioremap_page_range+0x30f/0x560
> [12335.433562]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12335.438762]  __ioremap_caller.constprop.18+0x1a8/0x300
> [12335.444890]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12335.449952]  ? _cond_resched+0x15/0x40
> [12335.454589]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [12335.460645]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [12335.467047]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [12335.474051]  drm_gem_vmap+0x1f/0x60 [drm]
> [12335.478974]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [12335.484788]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [12335.491832]  process_one_work+0x1e5/0x410
> [12335.496726]  worker_thread+0x2d/0x3c0
> [12335.501301]  ? cancel_delayed_work+0x90/0x90
> [12335.506452]  kthread+0x117/0x130
> [12335.510558]  ? kthread_create_worker_on_cpu+0x70/0x70
> [12335.516484]  ret_from_fork+0x22/0x40
> [12514.922353] rcu: INFO: rcu_sched self-detected stall on CPU
> [12514.928885] rcu: 	46-....: (1674641 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=365663 
> [12514.940183] 	(t=1680045 jiffies g=2794673 q=1211647)
> [12514.946057] Sending NMI from CPU 46 to CPUs 5:
> [12514.952398] NMI backtrace for cpu 5
> [12514.952399] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12514.952400] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12514.952400] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [12514.952401] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [12514.952402] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [12514.952403] RAX: 00000000009c0101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [12514.952404] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [12514.952404] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [12514.952405] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [12514.952405] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [12514.952406] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [12514.952406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12514.952407] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [12514.952407] Call Trace:
> [12514.952407]  _raw_spin_lock_irqsave+0x22/0x30
> [12514.952408]  pagevec_lru_move_fn+0x6c/0xd0
> [12514.952408]  activate_page+0xb5/0xc0
> [12514.952408]  mark_page_accessed+0x7a/0x130
> [12514.952409]  generic_file_read_iter+0x4c8/0xae0
> [12514.952409]  ? generic_update_time+0x9c/0xc0
> [12514.952410]  ? pipe_write+0x286/0x400
> [12514.952410]  new_sync_read+0x114/0x1a0
> [12514.952410]  vfs_read+0x89/0x130
> [12514.952411]  ksys_read+0xa1/0xe0
> [12514.952411]  do_syscall_64+0x48/0x130
> [12514.952412]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [12514.952412] RIP: 0033:0x7fc44b933d71
> [12514.952413] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [12514.952413] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [12514.952414] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [12514.952417] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [12514.952417] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [12514.952417] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [12514.952418] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [12514.952441] NMI backtrace for cpu 46
> [12515.215914] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12515.226832] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12515.235397] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [12515.243064] Call Trace:
> [12515.246597]  <IRQ>
> [12515.249686]  dump_stack+0x50/0x6b
> [12515.254012]  nmi_cpu_backtrace+0x89/0x90
> [12515.259273]  ? lapic_can_unplug_cpu+0x90/0x90
> [12515.264926]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [12515.271223]  rcu_dump_cpu_stacks+0x99/0xd0
> [12515.276615]  rcu_sched_clock_irq+0x502/0x770
> [12515.282219]  ? tick_sched_do_timer+0x60/0x60
> [12515.287738]  update_process_times+0x24/0x50
> [12515.293146]  tick_sched_timer+0x37/0x70
> [12515.298188]  __hrtimer_run_queues+0x11f/0x2b0
> [12515.303710]  hrtimer_interrupt+0xe5/0x240
> [12515.308859]  smp_apic_timer_interrupt+0x6f/0x130
> [12515.314665]  apic_timer_interrupt+0xf/0x20
> [12515.319928]  </IRQ>
> [12515.323148] RIP: 0010:smp_call_function_many+0x22f/0x260
> [12515.329607] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [12515.350807] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [12515.359631] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [12515.367961] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [12515.376288] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [12515.384649] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [12515.393038] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [12515.401410]  ? native_set_ldt.part.10+0xc0/0xc0
> [12515.407157]  ? smp_call_function_many+0x20a/0x260
> [12515.413079]  ? native_set_ldt.part.10+0xc0/0xc0
> [12515.418846]  on_each_cpu+0x28/0x40
> [12515.423530]  flush_tlb_kernel_range+0x79/0x80
> [12515.429117]  pmd_free_pte_page+0x41/0x60
> [12515.434282]  ioremap_page_range+0x30f/0x560
> [12515.439741]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12515.445266]  __ioremap_caller.constprop.18+0x1a8/0x300
> [12515.451663]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12515.457015]  ? _cond_resched+0x15/0x40
> [12515.462007]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [12515.468322]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [12515.475014]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [12515.482319]  drm_gem_vmap+0x1f/0x60 [drm]
> [12515.487528]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [12515.493584]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [12515.500863]  process_one_work+0x1e5/0x410
> [12515.506136]  worker_thread+0x2d/0x3c0
> [12515.510977]  ? cancel_delayed_work+0x90/0x90
> [12515.516476]  kthread+0x117/0x130
> [12515.520887]  ? kthread_create_worker_on_cpu+0x70/0x70
> [12515.527118]  ret_from_fork+0x22/0x40
> [12613.607632] nfs: server afk not responding, timed out
> [12634.087671] nfs: server botanophobie not responding, timed out
> [12634.087675] nfs: server aquaphobie not responding, timed out
> [12634.087681] nfs: server gula not responding, timed out
> [12638.182682] nfs: server pappnase not responding, timed out
> [12694.925633] rcu: INFO: rcu_sched self-detected stall on CPU
> [12694.932572] rcu: 	46-....: (1854036 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=404554 
> [12694.944179] 	(t=1860049 jiffies g=2794673 q=1238011)
> [12694.950373] Sending NMI from CPU 46 to CPUs 5:
> [12694.957002] NMI backtrace for cpu 5
> [12694.957003] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12694.957004] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12694.957005] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [12694.957006] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [12694.957006] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [12694.957007] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [12694.957008] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [12694.957009] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [12694.957009] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [12694.957010] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [12694.957010] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [12694.957011] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12694.957011] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [12694.957012] Call Trace:
> [12694.957012]  _raw_spin_lock_irqsave+0x22/0x30
> [12694.957013]  pagevec_lru_move_fn+0x6c/0xd0
> [12694.957013]  activate_page+0xb5/0xc0
> [12694.957014]  mark_page_accessed+0x7a/0x130
> [12694.957014]  generic_file_read_iter+0x4c8/0xae0
> [12694.957014]  ? generic_update_time+0x9c/0xc0
> [12694.957015]  ? pipe_write+0x286/0x400
> [12694.957015]  new_sync_read+0x114/0x1a0
> [12694.957016]  vfs_read+0x89/0x130
> [12694.957016]  ksys_read+0xa1/0xe0
> [12694.957017]  do_syscall_64+0x48/0x130
> [12694.957017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [12694.957018] RIP: 0033:0x7fc44b933d71
> [12694.957019] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [12694.957019] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [12694.957020] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [12694.957021] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [12694.957021] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [12694.957022] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [12694.957023] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [12694.957046] NMI backtrace for cpu 46
> [12695.232648] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12695.243969] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12695.252835] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [12695.260901] Call Trace:
> [12695.264796]  <IRQ>
> [12695.268244]  dump_stack+0x50/0x6b
> [12695.272932]  nmi_cpu_backtrace+0x89/0x90
> [12695.278251]  ? lapic_can_unplug_cpu+0x90/0x90
> [12695.283911]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [12695.290185]  rcu_dump_cpu_stacks+0x99/0xd0
> [12695.295582]  rcu_sched_clock_irq+0x502/0x770
> [12695.301133]  ? tick_sched_do_timer+0x60/0x60
> [12695.306735]  update_process_times+0x24/0x50
> [12695.312220]  tick_sched_timer+0x37/0x70
> [12695.317226]  __hrtimer_run_queues+0x11f/0x2b0
> [12695.322794]  hrtimer_interrupt+0xe5/0x240
> [12695.327973]  smp_apic_timer_interrupt+0x6f/0x130
> [12695.333730]  apic_timer_interrupt+0xf/0x20
> [12695.338960]  </IRQ>
> [12695.342237] RIP: 0010:smp_call_function_many+0x22f/0x260
> [12695.348680] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [12695.369876] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [12695.378643] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [12695.387017] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [12695.395404] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [12695.403754] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [12695.412085] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [12695.420430]  ? native_set_ldt.part.10+0xc0/0xc0
> [12695.426178]  ? smp_call_function_many+0x20a/0x260
> [12695.432100]  ? native_set_ldt.part.10+0xc0/0xc0
> [12695.437853]  on_each_cpu+0x28/0x40
> [12695.442458]  flush_tlb_kernel_range+0x79/0x80
> [12695.448087]  pmd_free_pte_page+0x41/0x60
> [12695.453225]  ioremap_page_range+0x30f/0x560
> [12695.458680]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12695.464257]  __ioremap_caller.constprop.18+0x1a8/0x300
> [12695.470649]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12695.476024]  ? _cond_resched+0x15/0x40
> [12695.480996]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [12695.487374]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [12695.494059]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [12695.501327]  drm_gem_vmap+0x1f/0x60 [drm]
> [12695.506529]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [12695.512609]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [12695.519942]  process_one_work+0x1e5/0x410
> [12695.525149]  worker_thread+0x2d/0x3c0
> [12695.530059]  ? cancel_delayed_work+0x90/0x90
> [12695.535485]  kthread+0x117/0x130
> [12695.539856]  ? kthread_create_worker_on_cpu+0x70/0x70
> [12695.546027]  ret_from_fork+0x22/0x40
> [12793.830947] nfs: server afk not responding, timed out
> [12798.758936] nfs: server afk not responding, timed out
> [12814.310989] nfs: server gula not responding, timed out
> [12814.310998] nfs: server aquaphobie not responding, timed out
> [12814.311946] nfs: server botanophobie not responding, timed out
> [12818.408064] nfs: server pappnase not responding, timed out
> [12819.239975] nfs: server botanophobie not responding, timed out
> [12819.239979] nfs: server aquaphobie not responding, timed out
> [12819.239985] nfs: server gula not responding, timed out
> [12823.335000] nfs: server pappnase not responding, timed out
> [12874.928928] rcu: INFO: rcu_sched self-detected stall on CPU
> [12874.935929] rcu: 	46-....: (2033415 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=443471 
> [12874.947518] 	(t=2040052 jiffies g=2794673 q=1239345)
> [12874.953744] Sending NMI from CPU 46 to CPUs 5:
> [12874.960406] NMI backtrace for cpu 5
> [12874.960407] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12874.960408] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12874.960409] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [12874.960410] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [12874.960411] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [12874.960412] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [12874.960412] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [12874.960413] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [12874.960413] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [12874.960414] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [12874.960415] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [12874.960415] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12874.960416] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [12874.960416] Call Trace:
> [12874.960417]  _raw_spin_lock_irqsave+0x22/0x30
> [12874.960417]  pagevec_lru_move_fn+0x6c/0xd0
> [12874.960417]  activate_page+0xb5/0xc0
> [12874.960418]  mark_page_accessed+0x7a/0x130
> [12874.960418]  generic_file_read_iter+0x4c8/0xae0
> [12874.960419]  ? generic_update_time+0x9c/0xc0
> [12874.960419]  ? pipe_write+0x286/0x400
> [12874.960420]  new_sync_read+0x114/0x1a0
> [12874.960420]  vfs_read+0x89/0x130
> [12874.960420]  ksys_read+0xa1/0xe0
> [12874.960421]  do_syscall_64+0x48/0x130
> [12874.960421]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [12874.960422] RIP: 0033:0x7fc44b933d71
> [12874.960423] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [12874.960424] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [12874.960425] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [12874.960425] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [12874.960426] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [12874.960426] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [12874.960427] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [12874.960457] NMI backtrace for cpu 46
> [12875.235180] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [12875.246496] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [12875.255347] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [12875.263398] Call Trace:
> [12875.267264]  <IRQ>
> [12875.270691]  dump_stack+0x50/0x6b
> [12875.275376]  nmi_cpu_backtrace+0x89/0x90
> [12875.280688]  ? lapic_can_unplug_cpu+0x90/0x90
> [12875.286379]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [12875.292650]  rcu_dump_cpu_stacks+0x99/0xd0
> [12875.298044]  rcu_sched_clock_irq+0x502/0x770
> [12875.303577]  ? tick_sched_do_timer+0x60/0x60
> [12875.309127]  update_process_times+0x24/0x50
> [12875.314601]  tick_sched_timer+0x37/0x70
> [12875.319622]  __hrtimer_run_queues+0x11f/0x2b0
> [12875.325176]  hrtimer_interrupt+0xe5/0x240
> [12875.330380]  smp_apic_timer_interrupt+0x6f/0x130
> [12875.336114]  apic_timer_interrupt+0xf/0x20
> [12875.341332]  </IRQ>
> [12875.344611] RIP: 0010:smp_call_function_many+0x22f/0x260
> [12875.351053] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [12875.372251] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [12875.381050] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [12875.389438] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [12875.397828] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [12875.406161] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [12875.414489] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [12875.422831]  ? native_set_ldt.part.10+0xc0/0xc0
> [12875.428584]  ? smp_call_function_many+0x20a/0x260
> [12875.434498]  ? native_set_ldt.part.10+0xc0/0xc0
> [12875.440252]  on_each_cpu+0x28/0x40
> [12875.444877]  flush_tlb_kernel_range+0x79/0x80
> [12875.450498]  pmd_free_pte_page+0x41/0x60
> [12875.455659]  ioremap_page_range+0x30f/0x560
> [12875.461105]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12875.466684]  __ioremap_caller.constprop.18+0x1a8/0x300
> [12875.473074]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [12875.478477]  ? _cond_resched+0x15/0x40
> [12875.483444]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [12875.489835]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [12875.496515]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [12875.503781]  drm_gem_vmap+0x1f/0x60 [drm]
> [12875.508964]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [12875.515072]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [12875.522406]  process_one_work+0x1e5/0x410
> [12875.527624]  worker_thread+0x2d/0x3c0
> [12875.532508]  ? cancel_delayed_work+0x90/0x90
> [12875.537941]  kthread+0x117/0x130
> [12875.542296]  ? kthread_create_worker_on_cpu+0x70/0x70
> [12875.548469]  ret_from_fork+0x22/0x40
> [12974.056225] nfs: server afk not responding, timed out
> [12984.296243] nfs: server afk not responding, timed out
> [12994.535271] nfs: server gula not responding, timed out
> [12994.535282] nfs: server botanophobie not responding, timed out
> [12994.535290] nfs: server aquaphobie not responding, timed out
> [12998.631275] nfs: server pappnase not responding, timed out
> [13004.775288] nfs: server gula not responding, timed out
> [13004.775292] nfs: server aquaphobie not responding, timed out
> [13004.776281] nfs: server botanophobie not responding, timed out
> [13008.871296] nfs: server pappnase not responding, timed out
> [13054.932230] rcu: INFO: rcu_sched self-detected stall on CPU
> [13054.939235] rcu: 	46-....: (2212795 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=484794 
> [13054.950861] 	(t=2220055 jiffies g=2794673 q=1240589)
> [13054.957103] Sending NMI from CPU 46 to CPUs 5:
> [13054.963823] NMI backtrace for cpu 5
> [13054.963824] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13054.963825] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13054.963826] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [13054.963827] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [13054.963828] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [13054.963829] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [13054.963829] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [13054.963830] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [13054.963830] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [13054.963831] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [13054.963832] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [13054.963832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13054.963833] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [13054.963833] Call Trace:
> [13054.963834]  _raw_spin_lock_irqsave+0x22/0x30
> [13054.963834]  pagevec_lru_move_fn+0x6c/0xd0
> [13054.963835]  activate_page+0xb5/0xc0
> [13054.963835]  mark_page_accessed+0x7a/0x130
> [13054.963836]  generic_file_read_iter+0x4c8/0xae0
> [13054.963836]  ? generic_update_time+0x9c/0xc0
> [13054.963836]  ? pipe_write+0x286/0x400
> [13054.963837]  new_sync_read+0x114/0x1a0
> [13054.963837]  vfs_read+0x89/0x130
> [13054.963838]  ksys_read+0xa1/0xe0
> [13054.963838]  do_syscall_64+0x48/0x130
> [13054.963839]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [13054.963839] RIP: 0033:0x7fc44b933d71
> [13054.963840] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [13054.963841] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [13054.963842] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [13054.963842] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [13054.963843] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [13054.963844] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [13054.963844] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [13054.963880] NMI backtrace for cpu 46
> [13055.239840] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13055.251230] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13055.260153] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [13055.268228] Call Trace:
> [13055.272124]  <IRQ>
> [13055.275572]  dump_stack+0x50/0x6b
> [13055.280333]  nmi_cpu_backtrace+0x89/0x90
> [13055.285652]  ? lapic_can_unplug_cpu+0x90/0x90
> [13055.291364]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [13055.297685]  rcu_dump_cpu_stacks+0x99/0xd0
> [13055.303140]  rcu_sched_clock_irq+0x502/0x770
> [13055.308749]  ? tick_sched_do_timer+0x60/0x60
> [13055.314348]  update_process_times+0x24/0x50
> [13055.319824]  tick_sched_timer+0x37/0x70
> [13055.324914]  __hrtimer_run_queues+0x11f/0x2b0
> [13055.330497]  ? ixgbe_msix_clean_rings+0x19/0x40 [ixgbe]
> [13055.336930]  hrtimer_interrupt+0xe5/0x240
> [13055.342135]  smp_apic_timer_interrupt+0x6f/0x130
> [13055.347958]  apic_timer_interrupt+0xf/0x20
> [13055.353251]  </IRQ>
> [13055.356527] RIP: 0010:smp_call_function_many+0x22f/0x260
> [13055.363021] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [13055.384269] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [13055.393087] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [13055.401468] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [13055.409865] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [13055.418268] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [13055.426658] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [13055.435074]  ? native_set_ldt.part.10+0xc0/0xc0
> [13055.440893]  ? smp_call_function_many+0x20a/0x260
> [13055.446883]  ? native_set_ldt.part.10+0xc0/0xc0
> [13055.452705]  on_each_cpu+0x28/0x40
> [13055.457392]  flush_tlb_kernel_range+0x79/0x80
> [13055.463048]  pmd_free_pte_page+0x41/0x60
> [13055.468284]  ioremap_page_range+0x30f/0x560
> [13055.473784]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13055.479374]  __ioremap_caller.constprop.18+0x1a8/0x300
> [13055.485832]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13055.491191]  ? _cond_resched+0x15/0x40
> [13055.496180]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [13055.502546]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [13055.509255]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [13055.516581]  drm_gem_vmap+0x1f/0x60 [drm]
> [13055.521836]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [13055.527966]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [13055.535351]  process_one_work+0x1e5/0x410
> [13055.540611]  worker_thread+0x2d/0x3c0
> [13055.545499]  ? cancel_delayed_work+0x90/0x90
> [13055.550966]  kthread+0x117/0x130
> [13055.555352]  ? kthread_create_worker_on_cpu+0x70/0x70
> [13055.561569]  ret_from_fork+0x22/0x40
> [13154.280536] nfs: server afk not responding, timed out
> [13169.640564] nfs: server afk not responding, timed out
> [13174.759579] nfs: server gula not responding, timed out
> [13174.759589] nfs: server botanophobie not responding, timed out
> [13174.759596] nfs: server aquaphobie not responding, timed out
> [13178.855587] nfs: server pappnase not responding, timed out
> [13179.688582] nfs: server botanophobie not responding, timed out
> [13179.688584] nfs: server gula not responding, timed out
> [13179.688591] nfs: server aquaphobie not responding, timed out
> [13183.784464] nfs: server pappnase not responding, timed out
> [13190.119603] nfs: server gula not responding, timed out
> [13190.119607] nfs: server botanophobie not responding, timed out
> [13190.120599] nfs: server aquaphobie not responding, timed out
> [13194.216606] nfs: server pappnase not responding, timed out
> [13234.935545] rcu: INFO: rcu_sched self-detected stall on CPU
> [13234.942523] rcu: 	46-....: (2392165 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=526779 
> [13234.954107] 	(t=2400058 jiffies g=2794673 q=1241888)
> [13234.960311] Sending NMI from CPU 46 to CPUs 5:
> [13234.966929] NMI backtrace for cpu 5
> [13234.966930] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13234.966931] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13234.966931] RIP: 0010:queued_spin_lock_slowpath+0x3c/0x1a0
> [13234.966932] Code: e6 00 ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04
> [13234.966933] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [13234.966934] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [13234.966935] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [13234.966935] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [13234.966936] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [13234.966936] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [13234.966937] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [13234.966937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13234.966938] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [13234.966938] Call Trace:
> [13234.966939]  _raw_spin_lock_irqsave+0x22/0x30
> [13234.966939]  pagevec_lru_move_fn+0x6c/0xd0
> [13234.966940]  activate_page+0xb5/0xc0
> [13234.966940]  mark_page_accessed+0x7a/0x130
> [13234.966941]  generic_file_read_iter+0x4c8/0xae0
> [13234.966941]  ? generic_update_time+0x9c/0xc0
> [13234.966942]  ? pipe_write+0x286/0x400
> [13234.966942]  new_sync_read+0x114/0x1a0
> [13234.966942]  vfs_read+0x89/0x130
> [13234.966943]  ksys_read+0xa1/0xe0
> [13234.966943]  do_syscall_64+0x48/0x130
> [13234.966944]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [13234.966944] RIP: 0033:0x7fc44b933d71
> [13234.966945] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [13234.966946] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [13234.966947] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [13234.966947] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [13234.966948] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [13234.966949] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [13234.966949] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [13234.966974] NMI backtrace for cpu 46
> [13235.241330] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13235.252620] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13235.261493] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [13235.269540] Call Trace:
> [13235.273424]  <IRQ>
> [13235.276833]  dump_stack+0x50/0x6b
> [13235.281516]  nmi_cpu_backtrace+0x89/0x90
> [13235.286812]  ? lapic_can_unplug_cpu+0x90/0x90
> [13235.292469]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [13235.298738]  rcu_dump_cpu_stacks+0x99/0xd0
> [13235.304132]  rcu_sched_clock_irq+0x502/0x770
> [13235.309716]  ? tick_sched_do_timer+0x60/0x60
> [13235.315293]  update_process_times+0x24/0x50
> [13235.320709]  tick_sched_timer+0x37/0x70
> [13235.325722]  __hrtimer_run_queues+0x11f/0x2b0
> [13235.331262]  hrtimer_interrupt+0xe5/0x240
> [13235.336402]  smp_apic_timer_interrupt+0x6f/0x130
> [13235.342161]  apic_timer_interrupt+0xf/0x20
> [13235.347443]  </IRQ>
> [13235.350683] RIP: 0010:smp_call_function_many+0x22f/0x260
> [13235.357124] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [13235.378281] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [13235.387055] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [13235.395385] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [13235.403767] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [13235.412154] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [13235.420517] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [13235.428855]  ? native_set_ldt.part.10+0xc0/0xc0
> [13235.434601]  ? smp_call_function_many+0x20a/0x260
> [13235.440506]  ? native_set_ldt.part.10+0xc0/0xc0
> [13235.446254]  on_each_cpu+0x28/0x40
> [13235.450897]  flush_tlb_kernel_range+0x79/0x80
> [13235.456483]  pmd_free_pte_page+0x41/0x60
> [13235.461667]  ioremap_page_range+0x30f/0x560
> [13235.467143]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13235.472661]  __ioremap_caller.constprop.18+0x1a8/0x300
> [13235.479046]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13235.484393]  ? _cond_resched+0x15/0x40
> [13235.489398]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [13235.495774]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [13235.502484]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [13235.509749]  drm_gem_vmap+0x1f/0x60 [drm]
> [13235.514981]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [13235.521037]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [13235.528320]  process_one_work+0x1e5/0x410
> [13235.533547]  worker_thread+0x2d/0x3c0
> [13235.538432]  ? cancel_delayed_work+0x90/0x90
> [13235.543909]  kthread+0x117/0x130
> [13235.548321]  ? kthread_create_worker_on_cpu+0x70/0x70
> [13235.554517]  ret_from_fork+0x22/0x40
> [13334.504848] nfs: server afk not responding, timed out
> [13354.983896] nfs: server gula not responding, timed out
> [13354.984880] nfs: server botanophobie not responding, timed out
> [13354.984889] nfs: server afk not responding, timed out
> [13354.984892] nfs: server aquaphobie not responding, timed out
> [13359.079911] nfs: server pappnase not responding, timed out
> [13365.223912] nfs: server botanophobie not responding, timed out
> [13365.223916] nfs: server aquaphobie not responding, timed out
> [13365.224905] nfs: server gula not responding, timed out
> [13369.319914] nfs: server pappnase not responding, timed out
> [13375.463932] nfs: server gula not responding, timed out
> [13375.463955] nfs: server aquaphobie not responding, timed out
> [13375.464920] nfs: server botanophobie not responding, timed out
> [13379.559937] nfs: server pappnase not responding, timed out
> [13414.938860] rcu: INFO: rcu_sched self-detected stall on CPU
> [13414.945815] rcu: 	46-....: (2571546 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=568492 
> [13414.957433] 	(t=2580061 jiffies g=2794673 q=1243203)
> [13414.963605] Sending NMI from CPU 46 to CPUs 5:
> [13414.970220] NMI backtrace for cpu 5
> [13414.970221] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13414.970222] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13414.970223] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [13414.970224] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [13414.970225] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [13414.970226] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [13414.970226] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [13414.970227] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [13414.970227] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [13414.970228] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [13414.970229] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [13414.970230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13414.970230] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [13414.970230] Call Trace:
> [13414.970231]  _raw_spin_lock_irqsave+0x22/0x30
> [13414.970231]  pagevec_lru_move_fn+0x6c/0xd0
> [13414.970232]  activate_page+0xb5/0xc0
> [13414.970232]  mark_page_accessed+0x7a/0x130
> [13414.970233]  generic_file_read_iter+0x4c8/0xae0
> [13414.970233]  ? generic_update_time+0x9c/0xc0
> [13414.970233]  ? pipe_write+0x286/0x400
> [13414.970234]  new_sync_read+0x114/0x1a0
> [13414.970234]  vfs_read+0x89/0x130
> [13414.970235]  ksys_read+0xa1/0xe0
> [13414.970235]  do_syscall_64+0x48/0x130
> [13414.970236]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [13414.970236] RIP: 0033:0x7fc44b933d71
> [13414.970237] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [13414.970238] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [13414.970239] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [13414.970240] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [13414.970240] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [13414.970241] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [13414.970241] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [13414.970265] NMI backtrace for cpu 46
> [13415.244977] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13415.256254] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13415.265174] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [13415.273191] Call Trace:
> [13415.277037]  <IRQ>
> [13415.280432]  dump_stack+0x50/0x6b
> [13415.285135]  nmi_cpu_backtrace+0x89/0x90
> [13415.290385]  ? lapic_can_unplug_cpu+0x90/0x90
> [13415.296071]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [13415.302397]  rcu_dump_cpu_stacks+0x99/0xd0
> [13415.307832]  rcu_sched_clock_irq+0x502/0x770
> [13415.313421]  ? tick_sched_do_timer+0x60/0x60
> [13415.318915]  update_process_times+0x24/0x50
> [13415.324332]  tick_sched_timer+0x37/0x70
> [13415.329423]  __hrtimer_run_queues+0x11f/0x2b0
> [13415.334977]  hrtimer_interrupt+0xe5/0x240
> [13415.340122]  smp_apic_timer_interrupt+0x6f/0x130
> [13415.345963]  apic_timer_interrupt+0xf/0x20
> [13415.351256]  </IRQ>
> [13415.354452] RIP: 0010:smp_call_function_many+0x22f/0x260
> [13415.360978] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [13415.382172] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [13415.390993] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [13415.399324] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [13415.407648] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [13415.415988] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [13415.424374] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [13415.432771]  ? native_set_ldt.part.10+0xc0/0xc0
> [13415.438510]  ? smp_call_function_many+0x20a/0x260
> [13415.444463]  ? native_set_ldt.part.10+0xc0/0xc0
> [13415.450256]  on_each_cpu+0x28/0x40
> [13415.454964]  flush_tlb_kernel_range+0x79/0x80
> [13415.460550]  pmd_free_pte_page+0x41/0x60
> [13415.465731]  ioremap_page_range+0x30f/0x560
> [13415.471174]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13415.476702]  __ioremap_caller.constprop.18+0x1a8/0x300
> [13415.483102]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13415.488440]  ? _cond_resched+0x15/0x40
> [13415.493429]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [13415.499751]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [13415.506440]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [13415.513741]  drm_gem_vmap+0x1f/0x60 [drm]
> [13415.518985]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [13415.525043]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [13415.532319]  process_one_work+0x1e5/0x410
> [13415.537591]  worker_thread+0x2d/0x3c0
> [13415.542437]  ? cancel_delayed_work+0x90/0x90
> [13415.547940]  kthread+0x117/0x130
> [13415.552352]  ? kthread_create_worker_on_cpu+0x70/0x70
> [13415.558582]  ret_from_fork+0x22/0x40
> [13514.729173] nfs: server afk not responding, timed out
> [13535.209085] nfs: server gula not responding, timed out
> [13535.209198] nfs: server botanophobie not responding, timed out
> [13535.209219] nfs: server aquaphobie not responding, timed out
> [13539.305096] nfs: server pappnase not responding, timed out
> [13540.136231] nfs: server botanophobie not responding, timed out
> [13540.136235] nfs: server aquaphobie not responding, timed out
> [13540.137099] nfs: server gula not responding, timed out
> [13540.329213] nfs: server afk not responding, timed out
> [13544.233100] nfs: server pappnase not responding, timed out
> [13550.569241] nfs: server gula not responding, timed out
> [13550.569245] nfs: server botanophobie not responding, timed out
> [13550.569248] nfs: server aquaphobie not responding, timed out
> [13554.665262] nfs: server pappnase not responding, timed out
> [13560.808262] nfs: server gula not responding, timed out
> [13560.808279] nfs: server aquaphobie not responding, timed out
> [13560.809258] nfs: server botanophobie not responding, timed out
> [13564.905278] nfs: server pappnase not responding, timed out
> [13594.942184] rcu: INFO: rcu_sched self-detected stall on CPU
> [13594.949082] rcu: 	46-....: (2750926 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=608846 
> [13594.960563] 	(t=2760064 jiffies g=2794673 q=1244491)
> [13594.966699] Sending NMI from CPU 46 to CPUs 5:
> [13594.973314] NMI backtrace for cpu 5
> [13594.973315] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13594.973316] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13594.973316] RIP: 0010:queued_spin_lock_slowpath+0x3c/0x1a0
> [13594.973318] Code: e6 00 ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04
> [13594.973318] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [13594.973319] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [13594.973320] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [13594.973320] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [13594.973321] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [13594.973322] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [13594.973322] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [13594.973323] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13594.973324] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [13594.973324] Call Trace:
> [13594.973324]  _raw_spin_lock_irqsave+0x22/0x30
> [13594.973325]  pagevec_lru_move_fn+0x6c/0xd0
> [13594.973325]  activate_page+0xb5/0xc0
> [13594.973326]  mark_page_accessed+0x7a/0x130
> [13594.973326]  generic_file_read_iter+0x4c8/0xae0
> [13594.973327]  ? generic_update_time+0x9c/0xc0
> [13594.973327]  ? pipe_write+0x286/0x400
> [13594.973328]  new_sync_read+0x114/0x1a0
> [13594.973328]  vfs_read+0x89/0x130
> [13594.973328]  ksys_read+0xa1/0xe0
> [13594.973329]  do_syscall_64+0x48/0x130
> [13594.973329]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [13594.973330] RIP: 0033:0x7fc44b933d71
> [13594.973331] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [13594.973331] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [13594.973333] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [13594.973333] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [13594.973334] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [13594.973334] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [13594.973335] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [13594.973358] NMI backtrace for cpu 46
> [13595.247676] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13595.258934] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13595.267801] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [13595.275817] Call Trace:
> [13595.279661]  <IRQ>
> [13595.283057]  dump_stack+0x50/0x6b
> [13595.287741]  nmi_cpu_backtrace+0x89/0x90
> [13595.292989]  ? lapic_can_unplug_cpu+0x90/0x90
> [13595.298645]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [13595.304965]  rcu_dump_cpu_stacks+0x99/0xd0
> [13595.310386]  rcu_sched_clock_irq+0x502/0x770
> [13595.315995]  ? tick_sched_do_timer+0x60/0x60
> [13595.321551]  update_process_times+0x24/0x50
> [13595.326972]  tick_sched_timer+0x37/0x70
> [13595.332021]  __hrtimer_run_queues+0x11f/0x2b0
> [13595.337553]  ? ixgbe_msix_clean_rings+0x19/0x40 [ixgbe]
> [13595.343930]  hrtimer_interrupt+0xe5/0x240
> [13595.349085]  smp_apic_timer_interrupt+0x6f/0x130
> [13595.354904]  apic_timer_interrupt+0xf/0x20
> [13595.360168]  </IRQ>
> [13595.363430] RIP: 0010:smp_call_function_many+0x232/0x260
> [13595.369873] Code: 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 8b 4a 18 <83> e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f 57 82 48
> [13595.391031] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [13595.399841] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000003
> [13595.408178] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [13595.416561] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [13595.424965] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [13595.433320] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [13595.441661]  ? native_set_ldt.part.10+0xc0/0xc0
> [13595.447427]  ? smp_call_function_many+0x20a/0x260
> [13595.453363]  ? native_set_ldt.part.10+0xc0/0xc0
> [13595.459131]  on_each_cpu+0x28/0x40
> [13595.463772]  flush_tlb_kernel_range+0x79/0x80
> [13595.469364]  pmd_free_pte_page+0x41/0x60
> [13595.474529]  ioremap_page_range+0x30f/0x560
> [13595.480031]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13595.485552]  __ioremap_caller.constprop.18+0x1a8/0x300
> [13595.491966]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13595.497294]  ? _cond_resched+0x15/0x40
> [13595.502237]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [13595.508603]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [13595.515305]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [13595.522581]  drm_gem_vmap+0x1f/0x60 [drm]
> [13595.527839]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [13595.533912]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [13595.541224]  process_one_work+0x1e5/0x410
> [13595.546440]  worker_thread+0x2d/0x3c0
> [13595.551312]  ? cancel_delayed_work+0x90/0x90
> [13595.556714]  kthread+0x117/0x130
> [13595.561118]  ? kthread_create_worker_on_cpu+0x70/0x70
> [13595.567338]  ret_from_fork+0x22/0x40
> [13694.953491] nfs: server afk not responding, timed out
> [13715.432566] nfs: server botanophobie not responding, timed out
> [13715.433541] nfs: server gula not responding, timed out
> [13715.433545] nfs: server aquaphobie not responding, timed out
> [13719.529565] nfs: server pappnase not responding, timed out
> [13725.672576] nfs: server botanophobie not responding, timed out
> [13725.672581] nfs: server gula not responding, timed out
> [13725.673538] nfs: server afk not responding, timed out
> [13725.673562] nfs: server aquaphobie not responding, timed out
> [13729.769441] nfs: server pappnase not responding, timed out
> [13735.912593] nfs: server botanophobie not responding, timed out
> [13735.912612] nfs: server aquaphobie not responding, timed out
> [13735.913570] nfs: server gula not responding, timed out
> [13740.009586] nfs: server pappnase not responding, timed out
> [13746.152634] nfs: server gula not responding, timed out
> [13746.152639] nfs: server aquaphobie not responding, timed out
> [13746.153590] nfs: server botanophobie not responding, timed out
> [13750.249610] nfs: server pappnase not responding, timed out
> [13774.945512] rcu: INFO: rcu_sched self-detected stall on CPU
> [13774.952452] rcu: 	46-....: (2930301 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=651114 
> [13774.963993] 	(t=2940067 jiffies g=2794673 q=1245773)
> [13774.970152] Sending NMI from CPU 46 to CPUs 5:
> [13774.976783] NMI backtrace for cpu 5
> [13774.976784] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13774.976785] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13774.976785] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [13774.976787] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [13774.976787] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [13774.976788] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [13774.976789] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [13774.976789] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [13774.976790] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [13774.976791] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [13774.976791] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [13774.976792] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13774.976793] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [13774.976793] Call Trace:
> [13774.976793]  _raw_spin_lock_irqsave+0x22/0x30
> [13774.976794]  pagevec_lru_move_fn+0x6c/0xd0
> [13774.976794]  activate_page+0xb5/0xc0
> [13774.976795]  mark_page_accessed+0x7a/0x130
> [13774.976795]  generic_file_read_iter+0x4c8/0xae0
> [13774.976796]  ? generic_update_time+0x9c/0xc0
> [13774.976796]  ? pipe_write+0x286/0x400
> [13774.976796]  new_sync_read+0x114/0x1a0
> [13774.976797]  vfs_read+0x89/0x130
> [13774.976797]  ksys_read+0xa1/0xe0
> [13774.976798]  do_syscall_64+0x48/0x130
> [13774.976798]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [13774.976799] RIP: 0033:0x7fc44b933d71
> [13774.976800] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [13774.976800] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [13774.976801] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [13774.976802] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [13774.976803] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [13774.976803] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [13774.976804] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [13774.976827] NMI backtrace for cpu 46
> [13775.252956] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13775.264291] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13775.273219] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [13775.281283] Call Trace:
> [13775.285183]  <IRQ>
> [13775.288636]  dump_stack+0x50/0x6b
> [13775.293352]  nmi_cpu_backtrace+0x89/0x90
> [13775.298666]  ? lapic_can_unplug_cpu+0x90/0x90
> [13775.304382]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [13775.310708]  rcu_dump_cpu_stacks+0x99/0xd0
> [13775.316145]  rcu_sched_clock_irq+0x502/0x770
> [13775.321765]  ? tick_sched_do_timer+0x60/0x60
> [13775.327331]  update_process_times+0x24/0x50
> [13775.332809]  tick_sched_timer+0x37/0x70
> [13775.337895]  __hrtimer_run_queues+0x11f/0x2b0
> [13775.343452]  hrtimer_interrupt+0xe5/0x240
> [13775.348656]  smp_apic_timer_interrupt+0x6f/0x130
> [13775.354436]  apic_timer_interrupt+0xf/0x20
> [13775.359703]  </IRQ>
> [13775.362985] RIP: 0010:smp_call_function_many+0x22d/0x260
> [13775.369481] Code: 89 c7 e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a <f3> 90 8b 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2
> [13775.390739] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [13775.399557] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [13775.407947] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [13775.416325] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [13775.424737] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [13775.433124] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [13775.441525]  ? native_set_ldt.part.10+0xc0/0xc0
> [13775.447333]  ? smp_call_function_many+0x20a/0x260
> [13775.453312]  ? native_set_ldt.part.10+0xc0/0xc0
> [13775.459141]  on_each_cpu+0x28/0x40
> [13775.463808]  flush_tlb_kernel_range+0x79/0x80
> [13775.469454]  pmd_free_pte_page+0x41/0x60
> [13775.474658]  ioremap_page_range+0x30f/0x560
> [13775.480145]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13775.485722]  __ioremap_caller.constprop.18+0x1a8/0x300
> [13775.492154]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13775.497565]  ? _cond_resched+0x15/0x40
> [13775.502589]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [13775.508970]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [13775.515676]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [13775.523002]  drm_gem_vmap+0x1f/0x60 [drm]
> [13775.528235]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [13775.534347]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [13775.541701]  process_one_work+0x1e5/0x410
> [13775.546971]  worker_thread+0x2d/0x3c0
> [13775.551872]  ? cancel_delayed_work+0x90/0x90
> [13775.557362]  kthread+0x117/0x130
> [13775.561765]  ? kthread_create_worker_on_cpu+0x70/0x70
> [13775.567992]  ret_from_fork+0x22/0x40
> [13875.177829] nfs: server afk not responding, timed out
> [13895.656879] nfs: server botanophobie not responding, timed out
> [13895.656890] nfs: server aquaphobie not responding, timed out
> [13895.657742] nfs: server gula not responding, timed out
> [13899.753900] nfs: server pappnase not responding, timed out
> [13900.585886] nfs: server botanophobie not responding, timed out
> [13900.585897] nfs: server gula not responding, timed out
> [13900.585900] nfs: server aquaphobie not responding, timed out
> [13904.680890] nfs: server pappnase not responding, timed out
> [13911.016906] nfs: server gula not responding, timed out
> [13911.016914] nfs: server aquaphobie not responding, timed out
> [13911.017877] nfs: server afk not responding, timed out
> [13911.017894] nfs: server botanophobie not responding, timed out
> [13915.112923] nfs: server pappnase not responding, timed out
> [13921.256922] nfs: server aquaphobie not responding, timed out
> [13921.257928] nfs: server botanophobie not responding, timed out
> [13921.257949] nfs: server gula not responding, timed out
> [13925.353932] nfs: server pappnase not responding, timed out
> [13931.496951] nfs: server aquaphobie not responding, timed out
> [13931.496953] nfs: server botanophobie not responding, timed out
> [13931.496956] nfs: server gula not responding, timed out
> [13935.593000] nfs: server pappnase not responding, timed out
> [13954.948845] rcu: INFO: rcu_sched self-detected stall on CPU
> [13954.955743] rcu: 	46-....: (3109678 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=691117 
> [13954.967291] 	(t=3120070 jiffies g=2794673 q=1247046)
> [13954.973432] Sending NMI from CPU 46 to CPUs 5:
> [13954.980047] NMI backtrace for cpu 5
> [13954.980048] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13954.980049] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13954.980049] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [13954.980051] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [13954.980051] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [13954.980052] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [13954.980053] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [13954.980054] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [13954.980054] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [13954.980055] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [13954.980056] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [13954.980056] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13954.980057] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [13954.980057] Call Trace:
> [13954.980058]  _raw_spin_lock_irqsave+0x22/0x30
> [13954.980058]  pagevec_lru_move_fn+0x6c/0xd0
> [13954.980059]  activate_page+0xb5/0xc0
> [13954.980059]  mark_page_accessed+0x7a/0x130
> [13954.980059]  generic_file_read_iter+0x4c8/0xae0
> [13954.980060]  ? generic_update_time+0x9c/0xc0
> [13954.980060]  ? pipe_write+0x286/0x400
> [13954.980061]  new_sync_read+0x114/0x1a0
> [13954.980061]  vfs_read+0x89/0x130
> [13954.980061]  ksys_read+0xa1/0xe0
> [13954.980062]  do_syscall_64+0x48/0x130
> [13954.980062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [13954.980063] RIP: 0033:0x7fc44b933d71
> [13954.980064] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [13954.980065] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [13954.980066] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [13954.980067] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [13954.980067] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [13954.980068] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [13954.980068] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [13954.980096] NMI backtrace for cpu 46
> [13955.255841] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [13955.267181] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [13955.276106] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [13955.284173] Call Trace:
> [13955.288070]  <IRQ>
> [13955.291523]  dump_stack+0x50/0x6b
> [13955.296267]  nmi_cpu_backtrace+0x89/0x90
> [13955.301590]  ? lapic_can_unplug_cpu+0x90/0x90
> [13955.307300]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [13955.313626]  rcu_dump_cpu_stacks+0x99/0xd0
> [13955.319081]  rcu_sched_clock_irq+0x502/0x770
> [13955.324689]  ? tick_sched_do_timer+0x60/0x60
> [13955.330267]  update_process_times+0x24/0x50
> [13955.335745]  tick_sched_timer+0x37/0x70
> [13955.340846]  __hrtimer_run_queues+0x11f/0x2b0
> [13955.346413]  hrtimer_interrupt+0xe5/0x240
> [13955.351623]  smp_apic_timer_interrupt+0x6f/0x130
> [13955.357423]  apic_timer_interrupt+0xf/0x20
> [13955.362707]  </IRQ>
> [13955.365985] RIP: 0010:smp_call_function_many+0x22f/0x260
> [13955.372483] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [13955.393741] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [13955.402549] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [13955.410905] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [13955.419287] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [13955.427674] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [13955.436057] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [13955.444456]  ? native_set_ldt.part.10+0xc0/0xc0
> [13955.450265]  ? smp_call_function_many+0x20a/0x260
> [13955.456251]  ? native_set_ldt.part.10+0xc0/0xc0
> [13955.462061]  on_each_cpu+0x28/0x40
> [13955.466728]  flush_tlb_kernel_range+0x79/0x80
> [13955.472370]  pmd_free_pte_page+0x41/0x60
> [13955.477586]  ioremap_page_range+0x30f/0x560
> [13955.483097]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13955.488674]  __ioremap_caller.constprop.18+0x1a8/0x300
> [13955.495129]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [13955.500538]  ? _cond_resched+0x15/0x40
> [13955.505560]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [13955.511964]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [13955.518665]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [13955.525997]  drm_gem_vmap+0x1f/0x60 [drm]
> [13955.531219]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [13955.537282]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [13955.544626]  process_one_work+0x1e5/0x410
> [13955.549955]  worker_thread+0x2d/0x3c0
> [13955.554860]  ? cancel_delayed_work+0x90/0x90
> [13955.560346]  kthread+0x117/0x130
> [13955.564760]  ? kthread_create_worker_on_cpu+0x70/0x70
> [13955.570991]  ret_from_fork+0x22/0x40
> [14055.402154] nfs: server afk not responding, timed out
> [14075.881210] nfs: server gula not responding, timed out
> [14075.881216] nfs: server botanophobie not responding, timed out
> [14075.881221] nfs: server aquaphobie not responding, timed out
> [14079.977222] nfs: server pappnase not responding, timed out
> [14086.121232] nfs: server gula not responding, timed out
> [14086.121239] nfs: server aquaphobie not responding, timed out
> [14086.122217] nfs: server botanophobie not responding, timed out
> [14090.217254] nfs: server pappnase not responding, timed out
> [14096.361258] nfs: server aquaphobie not responding, timed out
> [14096.361290] nfs: server gula not responding, timed out
> [14096.362237] nfs: server afk not responding, timed out
> [14096.362240] nfs: server botanophobie not responding, timed out
> [14100.457252] nfs: server pappnase not responding, timed out
> [14106.601269] nfs: server aquaphobie not responding, timed out
> [14106.602254] nfs: server botanophobie not responding, timed out
> [14106.602261] nfs: server gula not responding, timed out
> [14110.697276] nfs: server pappnase not responding, timed out
> [14116.841291] nfs: server gula not responding, timed out
> [14116.841296] nfs: server aquaphobie not responding, timed out
> [14116.841299] nfs: server botanophobie not responding, timed out
> [14120.938333] nfs: server pappnase not responding, timed out
> [14134.952180] rcu: INFO: rcu_sched self-detected stall on CPU
> [14134.959054] rcu: 	46-....: (3289056 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=731115 
> [14134.970625] 	(t=3300073 jiffies g=2794673 q=1248320)
> [14134.976751] Sending NMI from CPU 46 to CPUs 5:
> [14134.983366] NMI backtrace for cpu 5
> [14134.983367] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14134.983368] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14134.983369] RIP: 0010:queued_spin_lock_slowpath+0x3c/0x1a0
> [14134.983370] Code: e6 00 ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04
> [14134.983370] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [14134.983371] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [14134.983372] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [14134.983373] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [14134.983373] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [14134.983374] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [14134.983375] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [14134.983375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14134.983376] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [14134.983376] Call Trace:
> [14134.983376]  _raw_spin_lock_irqsave+0x22/0x30
> [14134.983377]  pagevec_lru_move_fn+0x6c/0xd0
> [14134.983377]  activate_page+0xb5/0xc0
> [14134.983378]  mark_page_accessed+0x7a/0x130
> [14134.983378]  generic_file_read_iter+0x4c8/0xae0
> [14134.983379]  ? generic_update_time+0x9c/0xc0
> [14134.983379]  ? pipe_write+0x286/0x400
> [14134.983379]  new_sync_read+0x114/0x1a0
> [14134.983380]  vfs_read+0x89/0x130
> [14134.983380]  ksys_read+0xa1/0xe0
> [14134.983381]  do_syscall_64+0x48/0x130
> [14134.983381]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14134.983382] RIP: 0033:0x7fc44b933d71
> [14134.983383] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [14134.983383] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [14134.983384] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [14134.983385] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [14134.983386] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [14134.983386] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [14134.983387] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [14134.983417] NMI backtrace for cpu 46
> [14135.259479] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14135.270817] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14135.279757] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [14135.287841] Call Trace:
> [14135.291744]  <IRQ>
> [14135.295197]  dump_stack+0x50/0x6b
> [14135.299945]  nmi_cpu_backtrace+0x89/0x90
> [14135.305290]  ? lapic_can_unplug_cpu+0x90/0x90
> [14135.311007]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [14135.317326]  rcu_dump_cpu_stacks+0x99/0xd0
> [14135.322784]  rcu_sched_clock_irq+0x502/0x770
> [14135.328399]  ? tick_sched_do_timer+0x60/0x60
> [14135.333981]  update_process_times+0x24/0x50
> [14135.339460]  tick_sched_timer+0x37/0x70
> [14135.344548]  __hrtimer_run_queues+0x11f/0x2b0
> [14135.350132]  hrtimer_interrupt+0xe5/0x240
> [14135.355343]  smp_apic_timer_interrupt+0x6f/0x130
> [14135.361151]  apic_timer_interrupt+0xf/0x20
> [14135.366438]  </IRQ>
> [14135.369721] RIP: 0010:smp_call_function_many+0x22f/0x260
> [14135.376221] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [14135.397482] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [14135.406304] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [14135.414697] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [14135.423055] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [14135.431441] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [14135.439830] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [14135.448229]  ? native_set_ldt.part.10+0xc0/0xc0
> [14135.454027]  ? smp_call_function_many+0x20a/0x260
> [14135.459992]  ? native_set_ldt.part.10+0xc0/0xc0
> [14135.465807]  on_each_cpu+0x28/0x40
> [14135.470490]  flush_tlb_kernel_range+0x79/0x80
> [14135.476143]  pmd_free_pte_page+0x41/0x60
> [14135.481362]  ioremap_page_range+0x30f/0x560
> [14135.486834]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14135.492414]  __ioremap_caller.constprop.18+0x1a8/0x300
> [14135.498861]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14135.504297]  ? _cond_resched+0x15/0x40
> [14135.509325]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [14135.515708]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [14135.522419]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [14135.529746]  drm_gem_vmap+0x1f/0x60 [drm]
> [14135.534977]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [14135.541094]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [14135.548432]  process_one_work+0x1e5/0x410
> [14135.553701]  worker_thread+0x2d/0x3c0
> [14135.558609]  ? cancel_delayed_work+0x90/0x90
> [14135.564078]  kthread+0x117/0x130
> [14135.568506]  ? kthread_create_worker_on_cpu+0x70/0x70
> [14135.574738]  ret_from_fork+0x22/0x40
> [14235.626509] nfs: server afk not responding, timed out
> [14256.105559] nfs: server gula not responding, timed out
> [14256.105568] nfs: server botanophobie not responding, timed out
> [14256.105578] nfs: server aquaphobie not responding, timed out
> [14260.202554] nfs: server pappnase not responding, timed out
> [14261.033586] nfs: server aquaphobie not responding, timed out
> [14261.034531] nfs: server botanophobie not responding, timed out
> [14261.034544] nfs: server gula not responding, timed out
> [14265.130561] nfs: server pappnase not responding, timed out
> [14271.466570] nfs: server aquaphobie not responding, timed out
> [14271.466573] nfs: server botanophobie not responding, timed out
> [14271.466578] nfs: server gula not responding, timed out
> [14275.562601] nfs: server pappnase not responding, timed out
> [14281.705591] nfs: server gula not responding, timed out
> [14281.705604] nfs: server aquaphobie not responding, timed out
> [14281.706576] nfs: server botanophobie not responding, timed out
> [14284.778588] nfs: server afk not responding, timed out
> [14285.801612] nfs: server pappnase not responding, timed out
> [14291.946619] nfs: server botanophobie not responding, timed out
> [14291.946627] nfs: server aquaphobie not responding, timed out
> [14291.946645] nfs: server gula not responding, timed out
> [14296.041620] nfs: server pappnase not responding, timed out
> [14302.185640] nfs: server gula not responding, timed out
> [14302.185655] nfs: server aquaphobie not responding, timed out
> [14302.186621] nfs: server botanophobie not responding, timed out
> [14306.281647] nfs: server pappnase not responding, timed out
> [14314.955517] rcu: INFO: rcu_sched self-detected stall on CPU
> [14314.962401] rcu: 	46-....: (3468433 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=772638 
> [14314.973962] 	(t=3480076 jiffies g=2794673 q=1249596)
> [14314.980129] Sending NMI from CPU 46 to CPUs 5:
> [14314.986759] NMI backtrace for cpu 5
> [14314.986760] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14314.986761] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14314.986761] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [14314.986762] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [14314.986763] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [14314.986764] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [14314.986765] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [14314.986765] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [14314.986766] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [14314.986767] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [14314.986767] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [14314.986768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14314.986768] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [14314.986769] Call Trace:
> [14314.986769]  _raw_spin_lock_irqsave+0x22/0x30
> [14314.986770]  pagevec_lru_move_fn+0x6c/0xd0
> [14314.986770]  activate_page+0xb5/0xc0
> [14314.986770]  mark_page_accessed+0x7a/0x130
> [14314.986771]  generic_file_read_iter+0x4c8/0xae0
> [14314.986771]  ? generic_update_time+0x9c/0xc0
> [14314.986772]  ? pipe_write+0x286/0x400
> [14314.986772]  new_sync_read+0x114/0x1a0
> [14314.986773]  vfs_read+0x89/0x130
> [14314.986773]  ksys_read+0xa1/0xe0
> [14314.986773]  do_syscall_64+0x48/0x130
> [14314.986774]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14314.986775] RIP: 0033:0x7fc44b933d71
> [14314.986776] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [14314.986776] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [14314.986777] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [14314.986778] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [14314.986778] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [14314.986779] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [14314.986780] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [14314.986803] NMI backtrace for cpu 46
> [14315.262841] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14315.274194] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14315.283113] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [14315.291211] Call Trace:
> [14315.295108]  <IRQ>
> [14315.298561]  dump_stack+0x50/0x6b
> [14315.303289]  nmi_cpu_backtrace+0x89/0x90
> [14315.308637]  ? lapic_can_unplug_cpu+0x90/0x90
> [14315.314350]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [14315.320672]  rcu_dump_cpu_stacks+0x99/0xd0
> [14315.326130]  rcu_sched_clock_irq+0x502/0x770
> [14315.331737]  ? tick_sched_do_timer+0x60/0x60
> [14315.337321]  update_process_times+0x24/0x50
> [14315.342800]  tick_sched_timer+0x37/0x70
> [14315.347892]  __hrtimer_run_queues+0x11f/0x2b0
> [14315.353475]  hrtimer_interrupt+0xe5/0x240
> [14315.358683]  smp_apic_timer_interrupt+0x6f/0x130
> [14315.364489]  apic_timer_interrupt+0xf/0x20
> [14315.369777]  </IRQ>
> [14315.373061] RIP: 0010:smp_call_function_many+0x22f/0x260
> [14315.379561] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [14315.400821] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [14315.409645] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [14315.418033] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [14315.426419] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [14315.434812] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [14315.443201] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [14315.451629]  ? native_set_ldt.part.10+0xc0/0xc0
> [14315.457438]  ? smp_call_function_many+0x20a/0x260
> [14315.463414]  ? native_set_ldt.part.10+0xc0/0xc0
> [14315.469196]  on_each_cpu+0x28/0x40
> [14315.473880]  flush_tlb_kernel_range+0x79/0x80
> [14315.479522]  pmd_free_pte_page+0x41/0x60
> [14315.484738]  ioremap_page_range+0x30f/0x560
> [14315.490228]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14315.495806]  __ioremap_caller.constprop.18+0x1a8/0x300
> [14315.502265]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14315.507713]  ? _cond_resched+0x15/0x40
> [14315.512739]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [14315.519121]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [14315.525825]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [14315.533153]  drm_gem_vmap+0x1f/0x60 [drm]
> [14315.538387]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [14315.544504]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [14315.551840]  process_one_work+0x1e5/0x410
> [14315.557116]  worker_thread+0x2d/0x3c0
> [14315.562018]  ? cancel_delayed_work+0x90/0x90
> [14315.567517]  kthread+0x117/0x130
> [14315.571913]  ? kthread_create_worker_on_cpu+0x70/0x70
> [14315.578146]  ret_from_fork+0x22/0x40
> [14415.850840] nfs: server afk not responding, timed out
> [14436.329905] nfs: server aquaphobie not responding, timed out
> [14436.329917] nfs: server gula not responding, timed out
> [14436.330890] nfs: server botanophobie not responding, timed out
> [14440.426899] nfs: server pappnase not responding, timed out
> [14446.570908] nfs: server botanophobie not responding, timed out
> [14446.570911] nfs: server gula not responding, timed out
> [14446.570916] nfs: server aquaphobie not responding, timed out
> [14450.665915] nfs: server pappnase not responding, timed out
> [14456.809925] nfs: server botanophobie not responding, timed out
> [14456.809943] nfs: server aquaphobie not responding, timed out
> [14456.809963] nfs: server gula not responding, timed out
> [14460.906940] nfs: server pappnase not responding, timed out
> [14467.049956] nfs: server botanophobie not responding, timed out
> [14467.049961] nfs: server aquaphobie not responding, timed out
> [14467.049987] nfs: server gula not responding, timed out
> [14471.145953] nfs: server pappnase not responding, timed out
> [14473.194936] nfs: server afk not responding, timed out
> [14477.289980] nfs: server aquaphobie not responding, timed out
> [14477.290002] nfs: server gula not responding, timed out
> [14477.290968] nfs: server botanophobie not responding, timed out
> [14481.385979] nfs: server pappnase not responding, timed out
> [14487.529994] nfs: server botanophobie not responding, timed out
> [14487.529999] nfs: server aquaphobie not responding, timed out
> [14487.530019] nfs: server gula not responding, timed out
> [14491.625995] nfs: server pappnase not responding, timed out
> [14494.958861] rcu: INFO: rcu_sched self-detected stall on CPU
> [14494.965745] rcu: 	46-....: (3647810 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=814896 
> [14494.977299] 	(t=3660079 jiffies g=2794673 q=1250883)
> [14494.983460] Sending NMI from CPU 46 to CPUs 5:
> [14494.990104] NMI backtrace for cpu 5
> [14494.990104] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14494.990105] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14494.990106] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [14494.990107] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [14494.990108] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [14494.990109] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [14494.990109] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [14494.990110] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [14494.990111] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [14494.990111] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [14494.990112] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [14494.990112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14494.990113] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [14494.990113] Call Trace:
> [14494.990114]  _raw_spin_lock_irqsave+0x22/0x30
> [14494.990114]  pagevec_lru_move_fn+0x6c/0xd0
> [14494.990115]  activate_page+0xb5/0xc0
> [14494.990115]  mark_page_accessed+0x7a/0x130
> [14494.990116]  generic_file_read_iter+0x4c8/0xae0
> [14494.990116]  ? generic_update_time+0x9c/0xc0
> [14494.990116]  ? pipe_write+0x286/0x400
> [14494.990117]  new_sync_read+0x114/0x1a0
> [14494.990117]  vfs_read+0x89/0x130
> [14494.990118]  ksys_read+0xa1/0xe0
> [14494.990118]  do_syscall_64+0x48/0x130
> [14494.990120]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14494.990121] RIP: 0033:0x7fc44b933d71
> [14494.990122] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [14494.990122] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [14494.990123] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [14494.990124] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [14494.990125] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [14494.990125] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [14494.990128] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [14494.990153] NMI backtrace for cpu 46
> [14495.266181] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14495.277524] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14495.286455] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [14495.294563] Call Trace:
> [14495.298463]  <IRQ>
> [14495.301907]  dump_stack+0x50/0x6b
> [14495.306653]  nmi_cpu_backtrace+0x89/0x90
> [14495.311978]  ? lapic_can_unplug_cpu+0x90/0x90
> [14495.317699]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [14495.324016]  rcu_dump_cpu_stacks+0x99/0xd0
> [14495.329479]  rcu_sched_clock_irq+0x502/0x770
> [14495.335091]  ? tick_sched_do_timer+0x60/0x60
> [14495.340649]  update_process_times+0x24/0x50
> [14495.346139]  tick_sched_timer+0x37/0x70
> [14495.351240]  __hrtimer_run_queues+0x11f/0x2b0
> [14495.356816]  hrtimer_interrupt+0xe5/0x240
> [14495.362024]  smp_apic_timer_interrupt+0x6f/0x130
> [14495.367834]  apic_timer_interrupt+0xf/0x20
> [14495.373124]  </IRQ>
> [14495.376400] RIP: 0010:smp_call_function_many+0x22f/0x260
> [14495.382899] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [14495.404161] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [14495.412990] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [14495.421345] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [14495.429730] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [14495.438123] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [14495.446515] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [14495.454917]  ? native_set_ldt.part.10+0xc0/0xc0
> [14495.460725]  ? smp_call_function_many+0x20a/0x260
> [14495.466698]  ? native_set_ldt.part.10+0xc0/0xc0
> [14495.472499]  on_each_cpu+0x28/0x40
> [14495.477181]  flush_tlb_kernel_range+0x79/0x80
> [14495.482826]  pmd_free_pte_page+0x41/0x60
> [14495.488036]  ioremap_page_range+0x30f/0x560
> [14495.493516]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14495.499079]  __ioremap_caller.constprop.18+0x1a8/0x300
> [14495.505492]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14495.510896]  ? _cond_resched+0x15/0x40
> [14495.515914]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [14495.522270]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [14495.528984]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [14495.536305]  drm_gem_vmap+0x1f/0x60 [drm]
> [14495.541536]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [14495.547651]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [14495.555044]  process_one_work+0x1e5/0x410
> [14495.560312]  worker_thread+0x2d/0x3c0
> [14495.565218]  ? cancel_delayed_work+0x90/0x90
> [14495.570704]  kthread+0x117/0x130
> [14495.575117]  ? kthread_create_worker_on_cpu+0x70/0x70
> [14495.581344]  ret_from_fork+0x22/0x40
> [14596.075177] nfs: server afk not responding, timed out
> [14616.554214] nfs: server botanophobie not responding, timed out
> [14616.554223] nfs: server aquaphobie not responding, timed out
> [14616.554232] nfs: server gula not responding, timed out
> [14620.650248] nfs: server pappnase not responding, timed out
> [14621.482249] nfs: server aquaphobie not responding, timed out
> [14621.483227] nfs: server botanophobie not responding, timed out
> [14621.483231] nfs: server gula not responding, timed out
> [14625.579252] nfs: server pappnase not responding, timed out
> [14631.914258] nfs: server aquaphobie not responding, timed out
> [14631.915255] nfs: server botanophobie not responding, timed out
> [14631.915269] nfs: server gula not responding, timed out
> [14636.010277] nfs: server pappnase not responding, timed out
> [14642.154284] nfs: server gula not responding, timed out
> [14642.155275] nfs: server botanophobie not responding, timed out
> [14642.155296] nfs: server aquaphobie not responding, timed out
> [14646.251290] nfs: server pappnase not responding, timed out
> [14652.394297] nfs: server gula not responding, timed out
> [14652.394300] nfs: server aquaphobie not responding, timed out
> [14652.395315] nfs: server botanophobie not responding, timed out
> [14656.490305] nfs: server pappnase not responding, timed out
> [14661.611303] nfs: server afk not responding, timed out
> [14662.634317] nfs: server botanophobie not responding, timed out
> [14662.634319] nfs: server gula not responding, timed out
> [14662.634324] nfs: server aquaphobie not responding, timed out
> [14666.730331] nfs: server pappnase not responding, timed out
> [14672.875338] nfs: server gula not responding, timed out
> [14672.875342] nfs: server botanophobie not responding, timed out
> [14672.875347] nfs: server aquaphobie not responding, timed out
> [14674.962199] rcu: INFO: rcu_sched self-detected stall on CPU
> [14674.968992] rcu: 	46-....: (3827187 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=855643 
> [14674.980527] 	(t=3840082 jiffies g=2794673 q=1252887)
> [14674.986666] Sending NMI from CPU 46 to CPUs 5:
> [14674.993315] NMI backtrace for cpu 5
> [14674.993316] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14674.993317] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14674.993318] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [14674.993319] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [14674.993320] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [14674.993321] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [14674.993321] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [14674.993322] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [14674.993322] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [14674.993323] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [14674.993324] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [14674.993324] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14674.993325] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [14674.993325] Call Trace:
> [14674.993326]  _raw_spin_lock_irqsave+0x22/0x30
> [14674.993326]  pagevec_lru_move_fn+0x6c/0xd0
> [14674.993326]  activate_page+0xb5/0xc0
> [14674.993327]  mark_page_accessed+0x7a/0x130
> [14674.993327]  generic_file_read_iter+0x4c8/0xae0
> [14674.993328]  ? generic_update_time+0x9c/0xc0
> [14674.993328]  ? pipe_write+0x286/0x400
> [14674.993329]  new_sync_read+0x114/0x1a0
> [14674.993329]  vfs_read+0x89/0x130
> [14674.993329]  ksys_read+0xa1/0xe0
> [14674.993330]  do_syscall_64+0x48/0x130
> [14674.993330]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14674.993331] RIP: 0033:0x7fc44b933d71
> [14674.993332] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [14674.993332] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [14674.993334] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [14674.993334] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [14674.993335] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [14674.993335] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [14674.993336] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [14674.993360] NMI backtrace for cpu 46
> [14675.269097] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14675.280427] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14675.289326] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [14675.297390] Call Trace:
> [14675.301318]  <IRQ>
> [14675.304768]  dump_stack+0x50/0x6b
> [14675.309508]  nmi_cpu_backtrace+0x89/0x90
> [14675.314826]  ? lapic_can_unplug_cpu+0x90/0x90
> [14675.320536]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [14675.326863]  rcu_dump_cpu_stacks+0x99/0xd0
> [14675.332320]  rcu_sched_clock_irq+0x502/0x770
> [14675.337927]  ? tick_sched_do_timer+0x60/0x60
> [14675.343506]  update_process_times+0x24/0x50
> [14675.348979]  tick_sched_timer+0x37/0x70
> [14675.354063]  __hrtimer_run_queues+0x11f/0x2b0
> [14675.359655]  hrtimer_interrupt+0xe5/0x240
> [14675.364860]  smp_apic_timer_interrupt+0x6f/0x130
> [14675.370667]  apic_timer_interrupt+0xf/0x20
> [14675.375956]  </IRQ>
> [14675.379232] RIP: 0010:smp_call_function_many+0x22f/0x260
> [14675.385714] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [14675.406966] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [14675.415786] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [14675.424170] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [14675.432555] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [14675.440944] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [14675.449331] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [14675.457718]  ? native_set_ldt.part.10+0xc0/0xc0
> [14675.463521]  ? smp_call_function_many+0x20a/0x260
> [14675.469500]  ? native_set_ldt.part.10+0xc0/0xc0
> [14675.475321]  on_each_cpu+0x28/0x40
> [14675.479977]  flush_tlb_kernel_range+0x79/0x80
> [14675.485657]  pmd_free_pte_page+0x41/0x60
> [14675.490872]  ioremap_page_range+0x30f/0x560
> [14675.496364]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14675.501923]  __ioremap_caller.constprop.18+0x1a8/0x300
> [14675.508393]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14675.513802]  ? _cond_resched+0x15/0x40
> [14675.518812]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [14675.525203]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [14675.531913]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [14675.539233]  drm_gem_vmap+0x1f/0x60 [drm]
> [14675.544444]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [14675.550551]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [14675.557896]  process_one_work+0x1e5/0x410
> [14675.563164]  worker_thread+0x2d/0x3c0
> [14675.568067]  ? cancel_delayed_work+0x90/0x90
> [14675.573567]  kthread+0x117/0x130
> [14675.577968]  ? kthread_create_worker_on_cpu+0x70/0x70
> [14675.584199]  ret_from_fork+0x22/0x40
> [14676.970521] nfs: server pappnase not responding, timed out
> [14776.299515] nfs: server afk not responding, timed out
> [14796.778571] nfs: server botanophobie not responding, timed out
> [14796.778573] nfs: server aquaphobie not responding, timed out
> [14796.778578] nfs: server gula not responding, timed out
> [14800.874588] nfs: server pappnase not responding, timed out
> [14807.019466] nfs: server botanophobie not responding, timed out
> [14807.019585] nfs: server gula not responding, timed out
> [14807.019598] nfs: server aquaphobie not responding, timed out
> [14811.115625] nfs: server pappnase not responding, timed out
> [14817.258611] nfs: server aquaphobie not responding, timed out
> [14817.259609] nfs: server botanophobie not responding, timed out
> [14817.259612] nfs: server gula not responding, timed out
> [14821.355651] nfs: server pappnase not responding, timed out
> [14827.498641] nfs: server aquaphobie not responding, timed out
> [14827.499627] nfs: server gula not responding, timed out
> [14827.499639] nfs: server botanophobie not responding, timed out
> [14831.595670] nfs: server pappnase not responding, timed out
> [14837.738655] nfs: server botanophobie not responding, timed out
> [14837.738658] nfs: server aquaphobie not responding, timed out
> [14837.738663] nfs: server gula not responding, timed out
> [14841.834657] nfs: server pappnase not responding, timed out
> [14847.978668] nfs: server gula not responding, timed out
> [14847.978672] nfs: server botanophobie not responding, timed out
> [14847.978677] nfs: server aquaphobie not responding, timed out
> [14850.027680] nfs: server afk not responding, timed out
> [14852.074678] nfs: server pappnase not responding, timed out
> [14854.965544] rcu: INFO: rcu_sched self-detected stall on CPU
> [14854.972444] rcu: 	46-....: (4006565 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=899696 
> [14854.983925] 	(t=4020085 jiffies g=2794673 q=1254158)
> [14854.990075] Sending NMI from CPU 46 to CPUs 5:
> [14854.996710] NMI backtrace for cpu 5
> [14854.996710] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14854.996711] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14854.996712] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [14854.996713] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [14854.996714] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [14854.996715] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [14854.996715] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [14854.996716] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [14854.996717] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [14854.996717] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [14854.996718] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [14854.996718] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14854.996719] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [14854.996719] Call Trace:
> [14854.996720]  _raw_spin_lock_irqsave+0x22/0x30
> [14854.996720]  pagevec_lru_move_fn+0x6c/0xd0
> [14854.996721]  activate_page+0xb5/0xc0
> [14854.996721]  mark_page_accessed+0x7a/0x130
> [14854.996722]  generic_file_read_iter+0x4c8/0xae0
> [14854.996722]  ? generic_update_time+0x9c/0xc0
> [14854.996722]  ? pipe_write+0x286/0x400
> [14854.996723]  new_sync_read+0x114/0x1a0
> [14854.996723]  vfs_read+0x89/0x130
> [14854.996724]  ksys_read+0xa1/0xe0
> [14854.996724]  do_syscall_64+0x48/0x130
> [14854.996725]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14854.996725] RIP: 0033:0x7fc44b933d71
> [14854.996726] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [14854.996727] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [14854.996728] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [14854.996729] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [14854.996729] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [14854.996730] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [14854.996730] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [14854.996754] NMI backtrace for cpu 46
> [14855.271032] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [14855.282309] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [14855.291165] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [14855.299175] Call Trace:
> [14855.303003]  <IRQ>
> [14855.306388]  dump_stack+0x50/0x6b
> [14855.311072]  nmi_cpu_backtrace+0x89/0x90
> [14855.316329]  ? lapic_can_unplug_cpu+0x90/0x90
> [14855.322006]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [14855.328328]  rcu_dump_cpu_stacks+0x99/0xd0
> [14855.333745]  rcu_sched_clock_irq+0x502/0x770
> [14855.339341]  ? tick_sched_do_timer+0x60/0x60
> [14855.344906]  update_process_times+0x24/0x50
> [14855.350327]  tick_sched_timer+0x37/0x70
> [14855.355368]  __hrtimer_run_queues+0x11f/0x2b0
> [14855.360888]  hrtimer_interrupt+0xe5/0x240
> [14855.366039]  smp_apic_timer_interrupt+0x6f/0x130
> [14855.371834]  apic_timer_interrupt+0xf/0x20
> [14855.377118]  </IRQ>
> [14855.380334] RIP: 0010:smp_call_function_many+0x22d/0x260
> [14855.386799] Code: 89 c7 e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a <f3> 90 8b 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2
> [14855.408002] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [14855.416822] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [14855.425152] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [14855.433480] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [14855.441837] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [14855.450223] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [14855.458594]  ? native_set_ldt.part.10+0xc0/0xc0
> [14855.464344]  ? smp_call_function_many+0x20a/0x260
> [14855.470268]  ? native_set_ldt.part.10+0xc0/0xc0
> [14855.476037]  on_each_cpu+0x28/0x40
> [14855.480721]  flush_tlb_kernel_range+0x79/0x80
> [14855.486310]  pmd_free_pte_page+0x41/0x60
> [14855.491474]  ioremap_page_range+0x30f/0x560
> [14855.496928]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14855.502452]  __ioremap_caller.constprop.18+0x1a8/0x300
> [14855.508811]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [14855.514160]  ? _cond_resched+0x15/0x40
> [14855.519163]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [14855.525490]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [14855.532177]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [14855.539487]  drm_gem_vmap+0x1f/0x60 [drm]
> [14855.544689]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [14855.550740]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [14855.558026]  process_one_work+0x1e5/0x410
> [14855.563294]  worker_thread+0x2d/0x3c0
> [14855.568139]  ? cancel_delayed_work+0x90/0x90
> [14855.573655]  kthread+0x117/0x130
> [14855.578070]  ? kthread_create_worker_on_cpu+0x70/0x70
> [14855.584295]  ret_from_fork+0x22/0x40
> [14858.218683] nfs: server aquaphobie not responding, timed out
> [14858.218688] nfs: server gula not responding, timed out
> [14858.219771] nfs: server botanophobie not responding, timed out
> [14862.314699] nfs: server pappnase not responding, timed out
> [14956.523877] nfs: server afk not responding, timed out
> [14977.002942] nfs: server gula not responding, timed out
> [14977.003901] nfs: server botanophobie not responding, timed out
> [14977.003916] nfs: server aquaphobie not responding, timed out
> [14981.099941] nfs: server pappnase not responding, timed out
> [14981.930929] nfs: server botanophobie not responding, timed out
> [14981.930934] nfs: server aquaphobie not responding, timed out
> [14981.930938] nfs: server gula not responding, timed out
> [14986.026958] nfs: server pappnase not responding, timed out
> [14992.362948] nfs: server aquaphobie not responding, timed out
> [14992.363937] nfs: server botanophobie not responding, timed out
> [14992.363942] nfs: server gula not responding, timed out
> [14996.459953] nfs: server pappnase not responding, timed out
> [15002.602963] nfs: server aquaphobie not responding, timed out
> [15002.603964] nfs: server gula not responding, timed out
> [15002.603979] nfs: server botanophobie not responding, timed out
> [15006.699970] nfs: server pappnase not responding, timed out
> [15012.842986] nfs: server gula not responding, timed out
> [15012.842991] nfs: server aquaphobie not responding, timed out
> [15012.844004] nfs: server botanophobie not responding, timed out
> [15016.939023] nfs: server pappnase not responding, timed out
> [15023.083034] nfs: server gula not responding, timed out
> [15023.084010] nfs: server botanophobie not responding, timed out
> [15023.084013] nfs: server aquaphobie not responding, timed out
> [15027.179012] nfs: server pappnase not responding, timed out
> [15033.323026] nfs: server aquaphobie not responding, timed out
> [15033.324026] nfs: server botanophobie not responding, timed out
> [15033.324046] nfs: server gula not responding, timed out
> [15034.968889] rcu: INFO: rcu_sched self-detected stall on CPU
> [15034.975651] rcu: 	46-....: (4185946 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=940465 
> [15034.987131] 	(t=4200088 jiffies g=2794673 q=1255434)
> [15034.993206] Sending NMI from CPU 46 to CPUs 5:
> [15034.999769] NMI backtrace for cpu 5
> [15034.999770] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15034.999770] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15034.999770] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [15034.999771] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [15034.999772] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [15034.999773] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [15034.999773] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [15034.999774] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [15034.999774] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [15034.999775] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [15034.999775] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [15034.999776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [15034.999776] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [15034.999777] Call Trace:
> [15034.999777]  _raw_spin_lock_irqsave+0x22/0x30
> [15034.999777]  pagevec_lru_move_fn+0x6c/0xd0
> [15034.999778]  activate_page+0xb5/0xc0
> [15034.999778]  mark_page_accessed+0x7a/0x130
> [15034.999779]  generic_file_read_iter+0x4c8/0xae0
> [15034.999779]  ? generic_update_time+0x9c/0xc0
> [15034.999779]  ? pipe_write+0x286/0x400
> [15034.999780]  new_sync_read+0x114/0x1a0
> [15034.999780]  vfs_read+0x89/0x130
> [15034.999780]  ksys_read+0xa1/0xe0
> [15034.999780]  do_syscall_64+0x48/0x130
> [15034.999781]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [15034.999781] RIP: 0033:0x7fc44b933d71
> [15034.999782] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [15034.999783] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [15034.999784] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [15034.999784] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [15034.999785] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [15034.999785] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [15034.999786] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [15034.999808] NMI backtrace for cpu 46
> [15035.274321] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15035.285637] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15035.294470] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [15035.302489] Call Trace:
> [15035.306338]  <IRQ>
> [15035.309743]  dump_stack+0x50/0x6b
> [15035.314433]  nmi_cpu_backtrace+0x89/0x90
> [15035.319721]  ? lapic_can_unplug_cpu+0x90/0x90
> [15035.325381]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [15035.331641]  rcu_dump_cpu_stacks+0x99/0xd0
> [15035.337085]  rcu_sched_clock_irq+0x502/0x770
> [15035.342633]  ? tick_sched_do_timer+0x60/0x60
> [15035.348163]  update_process_times+0x24/0x50
> [15035.353634]  tick_sched_timer+0x37/0x70
> [15035.358663]  __hrtimer_run_queues+0x11f/0x2b0
> [15035.364190]  hrtimer_interrupt+0xe5/0x240
> [15035.369388]  smp_apic_timer_interrupt+0x6f/0x130
> [15035.375126]  apic_timer_interrupt+0xf/0x20
> [15035.380355]  </IRQ>
> [15035.383631] RIP: 0010:smp_call_function_many+0x22f/0x260
> [15035.390063] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [15035.411259] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [15035.420022] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [15035.428395] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [15035.436787] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [15035.445125] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [15035.453461] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [15035.461790]  ? native_set_ldt.part.10+0xc0/0xc0
> [15035.467525]  ? smp_call_function_many+0x20a/0x260
> [15035.473446]  ? native_set_ldt.part.10+0xc0/0xc0
> [15035.479197]  on_each_cpu+0x28/0x40
> [15035.483825]  flush_tlb_kernel_range+0x79/0x80
> [15035.489441]  pmd_free_pte_page+0x41/0x60
> [15035.494597]  ioremap_page_range+0x30f/0x560
> [15035.500042]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15035.505620]  __ioremap_caller.constprop.18+0x1a8/0x300
> [15035.512024]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15035.517432]  ? _cond_resched+0x15/0x40
> [15035.522399]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [15035.528790]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [15035.535480]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [15035.542738]  drm_gem_vmap+0x1f/0x60 [drm]
> [15035.547918]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [15035.554018]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [15035.561365]  process_one_work+0x1e5/0x410
> [15035.566583]  worker_thread+0x2d/0x3c0
> [15035.571463]  ? cancel_delayed_work+0x90/0x90
> [15035.576860]  kthread+0x117/0x130
> [15035.581225]  ? kthread_create_worker_on_cpu+0x70/0x70
> [15035.587398]  ret_from_fork+0x22/0x40
> [15037.419908] nfs: server pappnase not responding, timed out
> [15038.444009] nfs: server afk not responding, timed out
> [15043.563050] nfs: server aquaphobie not responding, timed out
> [15043.564070] nfs: server gula not responding, timed out
> [15043.564075] nfs: server botanophobie not responding, timed out
> [15047.660050] nfs: server pappnase not responding, timed out
> [15136.748210] nfs: server afk not responding, timed out
> [15157.227283] nfs: server aquaphobie not responding, timed out
> [15157.227288] nfs: server botanophobie not responding, timed out
> [15157.227294] nfs: server gula not responding, timed out
> [15161.324274] nfs: server pappnase not responding, timed out
> [15167.468284] nfs: server gula not responding, timed out
> [15167.468288] nfs: server botanophobie not responding, timed out
> [15167.468302] nfs: server aquaphobie not responding, timed out
> [15171.563294] nfs: server pappnase not responding, timed out
> [15177.707322] nfs: server aquaphobie not responding, timed out
> [15177.707326] nfs: server gula not responding, timed out
> [15177.708300] nfs: server botanophobie not responding, timed out
> [15181.804311] nfs: server pappnase not responding, timed out
> [15187.947348] nfs: server aquaphobie not responding, timed out
> [15187.948321] nfs: server botanophobie not responding, timed out
> [15187.948324] nfs: server gula not responding, timed out
> [15192.044332] nfs: server pappnase not responding, timed out
> [15198.187358] nfs: server botanophobie not responding, timed out
> [15198.187360] nfs: server aquaphobie not responding, timed out
> [15198.187370] nfs: server gula not responding, timed out
> [15202.284353] nfs: server pappnase not responding, timed out
> [15208.427369] nfs: server botanophobie not responding, timed out
> [15208.427382] nfs: server aquaphobie not responding, timed out
> [15208.427406] nfs: server gula not responding, timed out
> [15212.524374] nfs: server pappnase not responding, timed out
> [15214.972238] rcu: INFO: rcu_sched self-detected stall on CPU
> [15214.979160] rcu: 	46-....: (4365327 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=981577 
> [15214.990699] 	(t=4380091 jiffies g=2794673 q=1257128)
> [15214.996852] Sending NMI from CPU 46 to CPUs 5:
> [15215.003496] NMI backtrace for cpu 5
> [15215.003497] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15215.003498] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15215.003499] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [15215.003504] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [15215.003504] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [15215.003505] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [15215.003506] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [15215.003506] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [15215.003507] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [15215.003508] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [15215.003508] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [15215.003509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [15215.003510] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [15215.003510] Call Trace:
> [15215.003511]  _raw_spin_lock_irqsave+0x22/0x30
> [15215.003511]  pagevec_lru_move_fn+0x6c/0xd0
> [15215.003512]  activate_page+0xb5/0xc0
> [15215.003512]  mark_page_accessed+0x7a/0x130
> [15215.003512]  generic_file_read_iter+0x4c8/0xae0
> [15215.003513]  ? generic_update_time+0x9c/0xc0
> [15215.003513]  ? pipe_write+0x286/0x400
> [15215.003514]  new_sync_read+0x114/0x1a0
> [15215.003514]  vfs_read+0x89/0x130
> [15215.003514]  ksys_read+0xa1/0xe0
> [15215.003515]  do_syscall_64+0x48/0x130
> [15215.003516]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [15215.003516] RIP: 0033:0x7fc44b933d71
> [15215.003517] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [15215.003518] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [15215.003519] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [15215.003519] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [15215.003520] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [15215.003520] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [15215.003521] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [15215.003545] NMI backtrace for cpu 46
> [15215.279543] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15215.290876] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15215.299816] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [15215.307894] Call Trace:
> [15215.311782]  <IRQ>
> [15215.315220]  dump_stack+0x50/0x6b
> [15215.319964]  nmi_cpu_backtrace+0x89/0x90
> [15215.325283]  ? lapic_can_unplug_cpu+0x90/0x90
> [15215.331001]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [15215.337352]  rcu_dump_cpu_stacks+0x99/0xd0
> [15215.342808]  rcu_sched_clock_irq+0x502/0x770
> [15215.348404]  ? tick_sched_do_timer+0x60/0x60
> [15215.353981]  update_process_times+0x24/0x50
> [15215.359463]  tick_sched_timer+0x37/0x70
> [15215.364555]  __hrtimer_run_queues+0x11f/0x2b0
> [15215.370115]  hrtimer_interrupt+0xe5/0x240
> [15215.375355]  smp_apic_timer_interrupt+0x6f/0x130
> [15215.381164]  apic_timer_interrupt+0xf/0x20
> [15215.386451]  </IRQ>
> [15215.389703] RIP: 0010:smp_call_function_many+0x22f/0x260
> [15215.396200] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [15215.417457] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [15215.426282] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [15215.434666] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [15215.443050] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [15215.451460] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [15215.459822] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [15215.468213]  ? native_set_ldt.part.10+0xc0/0xc0
> [15215.474016]  ? smp_call_function_many+0x20a/0x260
> [15215.479959]  ? native_set_ldt.part.10+0xc0/0xc0
> [15215.485766]  on_each_cpu+0x28/0x40
> [15215.490444]  flush_tlb_kernel_range+0x79/0x80
> [15215.496085]  pmd_free_pte_page+0x41/0x60
> [15215.501292]  ioremap_page_range+0x30f/0x560
> [15215.506775]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15215.512355]  __ioremap_caller.constprop.18+0x1a8/0x300
> [15215.518810]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15215.524214]  ? _cond_resched+0x15/0x40
> [15215.529236]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [15215.535614]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [15215.542353]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [15215.549673]  drm_gem_vmap+0x1f/0x60 [drm]
> [15215.554907]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [15215.561006]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [15215.568360]  process_one_work+0x1e5/0x410
> [15215.573626]  worker_thread+0x2d/0x3c0
> [15215.578529]  ? cancel_delayed_work+0x90/0x90
> [15215.584017]  kthread+0x117/0x130
> [15215.588429]  ? kthread_create_worker_on_cpu+0x70/0x70
> [15215.594655]  ret_from_fork+0x22/0x40
> [15218.667390] nfs: server aquaphobie not responding, timed out
> [15218.668373] nfs: server botanophobie not responding, timed out
> [15218.668377] nfs: server gula not responding, timed out
> [15222.764393] nfs: server pappnase not responding, timed out
> [15226.860380] nfs: server afk not responding, timed out
> [15228.907420] nfs: server aquaphobie not responding, timed out
> [15228.908404] nfs: server botanophobie not responding, timed out
> [15228.908407] nfs: server gula not responding, timed out
> [15233.004406] nfs: server pappnase not responding, timed out
> [15316.972563] nfs: server afk not responding, timed out
> [15337.451606] nfs: server gula not responding, timed out
> [15337.451613] nfs: server aquaphobie not responding, timed out
> [15337.452608] nfs: server botanophobie not responding, timed out
> [15341.547618] nfs: server pappnase not responding, timed out
> [15342.380609] nfs: server botanophobie not responding, timed out
> [15342.380616] nfs: server gula not responding, timed out
> [15342.380623] nfs: server aquaphobie not responding, timed out
> [15346.476623] nfs: server pappnase not responding, timed out
> [15352.811643] nfs: server botanophobie not responding, timed out
> [15352.811646] nfs: server gula not responding, timed out
> [15352.811650] nfs: server aquaphobie not responding, timed out
> [15356.907646] nfs: server pappnase not responding, timed out
> [15363.052532] nfs: server gula not responding, timed out
> [15363.052680] nfs: server botanophobie not responding, timed out
> [15363.052690] nfs: server aquaphobie not responding, timed out
> [15367.148669] nfs: server pappnase not responding, timed out
> [15373.291684] nfs: server botanophobie not responding, timed out
> [15373.291696] nfs: server aquaphobie not responding, timed out
> [15373.292697] nfs: server gula not responding, timed out
> [15377.388687] nfs: server pappnase not responding, timed out
> [15383.531705] nfs: server gula not responding, timed out
> [15383.531707] nfs: server aquaphobie not responding, timed out
> [15383.532698] nfs: server botanophobie not responding, timed out
> [15387.628706] nfs: server pappnase not responding, timed out
> [15393.771725] nfs: server aquaphobie not responding, timed out
> [15393.771730] nfs: server gula not responding, timed out
> [15393.772726] nfs: server botanophobie not responding, timed out
> [15394.975582] rcu: INFO: rcu_sched self-detected stall on CPU
> [15394.982460] rcu: 	46-....: (4544704 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1022114 
> [15394.994042] 	(t=4560094 jiffies g=2794673 q=1258474)
> [15395.000140] Sending NMI from CPU 46 to CPUs 5:
> [15395.006701] NMI backtrace for cpu 5
> [15395.006702] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15395.006703] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15395.006704] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [15395.006705] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [15395.006706] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [15395.006707] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [15395.006707] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [15395.006708] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [15395.006708] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [15395.006709] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [15395.006710] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [15395.006710] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [15395.006711] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [15395.006711] Call Trace:
> [15395.006712]  _raw_spin_lock_irqsave+0x22/0x30
> [15395.006712]  pagevec_lru_move_fn+0x6c/0xd0
> [15395.006712]  activate_page+0xb5/0xc0
> [15395.006713]  mark_page_accessed+0x7a/0x130
> [15395.006713]  generic_file_read_iter+0x4c8/0xae0
> [15395.006714]  ? generic_update_time+0x9c/0xc0
> [15395.006714]  ? pipe_write+0x286/0x400
> [15395.006715]  new_sync_read+0x114/0x1a0
> [15395.006715]  vfs_read+0x89/0x130
> [15395.006715]  ksys_read+0xa1/0xe0
> [15395.006716]  do_syscall_64+0x48/0x130
> [15395.006716]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [15395.006717] RIP: 0033:0x7fc44b933d71
> [15395.006718] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [15395.006719] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [15395.006720] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [15395.006720] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [15395.006721] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [15395.006721] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [15395.006722] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [15395.006746] NMI backtrace for cpu 46
> [15395.281305] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15395.292596] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15395.301512] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [15395.309524] Call Trace:
> [15395.313370]  <IRQ>
> [15395.316768]  dump_stack+0x50/0x6b
> [15395.321510]  nmi_cpu_backtrace+0x89/0x90
> [15395.326766]  ? lapic_can_unplug_cpu+0x90/0x90
> [15395.332466]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [15395.338749]  rcu_dump_cpu_stacks+0x99/0xd0
> [15395.344200]  rcu_sched_clock_irq+0x502/0x770
> [15395.349744]  ? tick_sched_do_timer+0x60/0x60
> [15395.355265]  update_process_times+0x24/0x50
> [15395.360715]  tick_sched_timer+0x37/0x70
> [15395.365802]  __hrtimer_run_queues+0x11f/0x2b0
> [15395.371324]  hrtimer_interrupt+0xe5/0x240
> [15395.376492]  smp_apic_timer_interrupt+0x6f/0x130
> [15395.382299]  apic_timer_interrupt+0xf/0x20
> [15395.387527]  </IRQ>
> [15395.390792] RIP: 0010:smp_call_function_many+0x22d/0x260
> [15395.397289] Code: 89 c7 e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a <f3> 90 8b 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2
> [15395.418486] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [15395.427268] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [15395.435626] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [15395.443952] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [15395.452277] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [15395.460607] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [15395.468992]  ? native_set_ldt.part.10+0xc0/0xc0
> [15395.474799]  ? smp_call_function_many+0x20a/0x260
> [15395.480778]  ? native_set_ldt.part.10+0xc0/0xc0
> [15395.486582]  on_each_cpu+0x28/0x40
> [15395.491230]  flush_tlb_kernel_range+0x79/0x80
> [15395.496833]  pmd_free_pte_page+0x41/0x60
> [15395.502042]  ioremap_page_range+0x30f/0x560
> [15395.507477]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15395.513003]  __ioremap_caller.constprop.18+0x1a8/0x300
> [15395.519450]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15395.524798]  ? _cond_resched+0x15/0x40
> [15395.529819]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [15395.536148]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [15395.542806]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [15395.550126]  drm_gem_vmap+0x1f/0x60 [drm]
> [15395.555304]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [15395.561386]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [15395.568712]  process_one_work+0x1e5/0x410
> [15395.573979]  worker_thread+0x2d/0x3c0
> [15395.578833]  ? cancel_delayed_work+0x90/0x90
> [15395.584317]  kthread+0x117/0x130
> [15395.588696]  ? kthread_create_worker_on_cpu+0x70/0x70
> [15395.594929]  ret_from_fork+0x22/0x40
> [15397.867770] nfs: server pappnase not responding, timed out
> [15404.011739] nfs: server gula not responding, timed out
> [15404.011741] nfs: server aquaphobie not responding, timed out
> [15404.012737] nfs: server botanophobie not responding, timed out
> [15408.107773] nfs: server pappnase not responding, timed out
> [15412.012738] nfs: server afk not responding, timed out
> [15414.251775] nfs: server aquaphobie not responding, timed out
> [15414.251784] nfs: server gula not responding, timed out
> [15414.252773] nfs: server botanophobie not responding, timed out
> [15418.348765] nfs: server pappnase not responding, timed out
> [15497.196903] nfs: server afk not responding, timed out
> [15517.675959] nfs: server gula not responding, timed out
> [15517.675965] nfs: server aquaphobie not responding, timed out
> [15517.676959] nfs: server botanophobie not responding, timed out
> [15521.773009] nfs: server pappnase not responding, timed out
> [15527.915983] nfs: server aquaphobie not responding, timed out
> [15527.916970] nfs: server gula not responding, timed out
> [15527.916974] nfs: server botanophobie not responding, timed out
> [15532.012998] nfs: server pappnase not responding, timed out
> [15538.155997] nfs: server aquaphobie not responding, timed out
> [15538.156001] nfs: server botanophobie not responding, timed out
> [15538.156004] nfs: server gula not responding, timed out
> [15542.252008] nfs: server pappnase not responding, timed out
> [15548.396016] nfs: server aquaphobie not responding, timed out
> [15548.396022] nfs: server gula not responding, timed out
> [15548.397005] nfs: server botanophobie not responding, timed out
> [15552.492034] nfs: server pappnase not responding, timed out
> [15558.637045] nfs: server botanophobie not responding, timed out
> [15558.637048] nfs: server aquaphobie not responding, timed out
> [15558.637053] nfs: server gula not responding, timed out
> [15562.732049] nfs: server pappnase not responding, timed out
> [15568.877072] nfs: server gula not responding, timed out
> [15568.877075] nfs: server aquaphobie not responding, timed out
> [15568.877081] nfs: server botanophobie not responding, timed out
> [15572.972074] nfs: server pappnase not responding, timed out
> [15574.978932] rcu: INFO: rcu_sched self-detected stall on CPU
> [15574.985867] rcu: 	46-....: (4724084 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1064280 
> [15574.997512] 	(t=4740097 jiffies g=2794673 q=1259898)
> [15575.003667] Sending NMI from CPU 46 to CPUs 5:
> [15575.010309] NMI backtrace for cpu 5
> [15575.010310] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15575.010310] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15575.010311] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [15575.010312] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [15575.010313] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [15575.010314] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [15575.010314] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [15575.010315] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [15575.010316] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [15575.010316] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [15575.010317] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [15575.010317] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [15575.010318] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [15575.010318] Call Trace:
> [15575.010319]  _raw_spin_lock_irqsave+0x22/0x30
> [15575.010319]  pagevec_lru_move_fn+0x6c/0xd0
> [15575.010320]  activate_page+0xb5/0xc0
> [15575.010320]  mark_page_accessed+0x7a/0x130
> [15575.010321]  generic_file_read_iter+0x4c8/0xae0
> [15575.010321]  ? generic_update_time+0x9c/0xc0
> [15575.010321]  ? pipe_write+0x286/0x400
> [15575.010322]  new_sync_read+0x114/0x1a0
> [15575.010322]  vfs_read+0x89/0x130
> [15575.010323]  ksys_read+0xa1/0xe0
> [15575.010323]  do_syscall_64+0x48/0x130
> [15575.010324]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [15575.010324] RIP: 0033:0x7fc44b933d71
> [15575.010325] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [15575.010326] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [15575.010327] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [15575.010327] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [15575.010328] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [15575.010329] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [15575.010329] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [15575.010353] NMI backtrace for cpu 46
> [15575.286231] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15575.297570] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15575.306518] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [15575.314635] Call Trace:
> [15575.318534]  <IRQ>
> [15575.321985]  dump_stack+0x50/0x6b
> [15575.326732]  nmi_cpu_backtrace+0x89/0x90
> [15575.332046]  ? lapic_can_unplug_cpu+0x90/0x90
> [15575.337768]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [15575.344096]  rcu_dump_cpu_stacks+0x99/0xd0
> [15575.349554]  rcu_sched_clock_irq+0x502/0x770
> [15575.355163]  ? tick_sched_do_timer+0x60/0x60
> [15575.360741]  update_process_times+0x24/0x50
> [15575.366218]  tick_sched_timer+0x37/0x70
> [15575.371311]  __hrtimer_run_queues+0x11f/0x2b0
> [15575.376890]  hrtimer_interrupt+0xe5/0x240
> [15575.382096]  smp_apic_timer_interrupt+0x6f/0x130
> [15575.387904]  apic_timer_interrupt+0xf/0x20
> [15575.393194]  </IRQ>
> [15575.396468] RIP: 0010:smp_call_function_many+0x22f/0x260
> [15575.402968] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [15575.424223] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [15575.433048] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [15575.441433] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [15575.449814] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [15575.458200] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [15575.466596] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [15575.475019]  ? native_set_ldt.part.10+0xc0/0xc0
> [15575.480822]  ? smp_call_function_many+0x20a/0x260
> [15575.486802]  ? native_set_ldt.part.10+0xc0/0xc0
> [15575.492610]  on_each_cpu+0x28/0x40
> [15575.497288]  flush_tlb_kernel_range+0x79/0x80
> [15575.502935]  pmd_free_pte_page+0x41/0x60
> [15575.508148]  ioremap_page_range+0x30f/0x560
> [15575.513630]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15575.519190]  __ioremap_caller.constprop.18+0x1a8/0x300
> [15575.525644]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15575.531053]  ? _cond_resched+0x15/0x40
> [15575.536057]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [15575.542440]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [15575.549149]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [15575.556469]  drm_gem_vmap+0x1f/0x60 [drm]
> [15575.561702]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [15575.567815]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [15575.575161]  process_one_work+0x1e5/0x410
> [15575.580428]  worker_thread+0x2d/0x3c0
> [15575.585331]  ? cancel_delayed_work+0x90/0x90
> [15575.590818]  kthread+0x117/0x130
> [15575.595258]  ? kthread_create_worker_on_cpu+0x70/0x70
> [15575.601481]  ret_from_fork+0x22/0x40
> [15579.116947] nfs: server botanophobie not responding, timed out
> [15579.117084] nfs: server gula not responding, timed out
> [15579.117087] nfs: server aquaphobie not responding, timed out
> [15583.213094] nfs: server pappnase not responding, timed out
> [15589.356100] nfs: server aquaphobie not responding, timed out
> [15589.356103] nfs: server botanophobie not responding, timed out
> [15589.356106] nfs: server gula not responding, timed out
> [15593.452108] nfs: server pappnase not responding, timed out
> [15597.549105] nfs: server afk not responding, timed out
> [15599.596110] nfs: server botanophobie not responding, timed out
> [15599.596116] nfs: server aquaphobie not responding, timed out
> [15599.596119] nfs: server gula not responding, timed out
> [15603.692124] nfs: server pappnase not responding, timed out
> [15677.421261] nfs: server afk not responding, timed out
> [15697.901310] nfs: server botanophobie not responding, timed out
> [15697.901315] nfs: server gula not responding, timed out
> [15697.901319] nfs: server aquaphobie not responding, timed out
> [15701.996324] nfs: server pappnase not responding, timed out
> [15702.828318] nfs: server botanophobie not responding, timed out
> [15702.828323] nfs: server aquaphobie not responding, timed out
> [15702.829308] nfs: server gula not responding, timed out
> [15706.925324] nfs: server pappnase not responding, timed out
> [15713.260338] nfs: server botanophobie not responding, timed out
> [15713.260341] nfs: server aquaphobie not responding, timed out
> [15713.261337] nfs: server gula not responding, timed out
> [15717.356395] nfs: server pappnase not responding, timed out
> [15723.500379] nfs: server gula not responding, timed out
> [15723.500382] nfs: server aquaphobie not responding, timed out
> [15723.501353] nfs: server botanophobie not responding, timed out
> [15727.596362] nfs: server pappnase not responding, timed out
> [15733.740399] nfs: server gula not responding, timed out
> [15733.741379] nfs: server botanophobie not responding, timed out
> [15733.741386] nfs: server aquaphobie not responding, timed out
> [15737.836409] nfs: server pappnase not responding, timed out
> [15743.980408] nfs: server aquaphobie not responding, timed out
> [15743.980414] nfs: server gula not responding, timed out
> [15743.981401] nfs: server botanophobie not responding, timed out
> [15748.076417] nfs: server pappnase not responding, timed out
> [15754.220435] nfs: server botanophobie not responding, timed out
> [15754.220438] nfs: server aquaphobie not responding, timed out
> [15754.220446] nfs: server gula not responding, timed out
> [15754.982274] rcu: INFO: rcu_sched self-detected stall on CPU
> [15754.989194] rcu: 	46-....: (4903461 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1103248 
> [15755.000834] 	(t=4920100 jiffies g=2794673 q=1261432)
> [15755.006973] Sending NMI from CPU 46 to CPUs 5:
> [15755.013590] NMI backtrace for cpu 5
> [15755.013591] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15755.013592] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15755.013593] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [15755.013594] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [15755.013595] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [15755.013595] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [15755.013596] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [15755.013597] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [15755.013598] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [15755.013598] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [15755.013599] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [15755.013599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [15755.013600] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [15755.013600] Call Trace:
> [15755.013601]  _raw_spin_lock_irqsave+0x22/0x30
> [15755.013601]  pagevec_lru_move_fn+0x6c/0xd0
> [15755.013601]  activate_page+0xb5/0xc0
> [15755.013602]  mark_page_accessed+0x7a/0x130
> [15755.013602]  generic_file_read_iter+0x4c8/0xae0
> [15755.013603]  ? generic_update_time+0x9c/0xc0
> [15755.013603]  ? pipe_write+0x286/0x400
> [15755.013604]  new_sync_read+0x114/0x1a0
> [15755.013604]  vfs_read+0x89/0x130
> [15755.013605]  ksys_read+0xa1/0xe0
> [15755.013605]  do_syscall_64+0x48/0x130
> [15755.013606]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [15755.013606] RIP: 0033:0x7fc44b933d71
> [15755.013607] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [15755.013608] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [15755.013609] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [15755.013609] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [15755.013610] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [15755.013610] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [15755.013611] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [15755.013635] NMI backtrace for cpu 46
> [15755.289592] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15755.300933] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15755.309864] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [15755.317971] Call Trace:
> [15755.321867]  <IRQ>
> [15755.325319]  dump_stack+0x50/0x6b
> [15755.330063]  nmi_cpu_backtrace+0x89/0x90
> [15755.335399]  ? lapic_can_unplug_cpu+0x90/0x90
> [15755.341111]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [15755.347420]  rcu_dump_cpu_stacks+0x99/0xd0
> [15755.352873]  rcu_sched_clock_irq+0x502/0x770
> [15755.358484]  ? tick_sched_do_timer+0x60/0x60
> [15755.364067]  update_process_times+0x24/0x50
> [15755.369559]  tick_sched_timer+0x37/0x70
> [15755.374651]  __hrtimer_run_queues+0x11f/0x2b0
> [15755.380230]  hrtimer_interrupt+0xe5/0x240
> [15755.385437]  smp_apic_timer_interrupt+0x6f/0x130
> [15755.391243]  apic_timer_interrupt+0xf/0x20
> [15755.396529]  </IRQ>
> [15755.399783] RIP: 0010:smp_call_function_many+0x22d/0x260
> [15755.406284] Code: 89 c7 e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a <f3> 90 8b 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2
> [15755.427545] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [15755.436394] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [15755.444782] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [15755.453170] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [15755.461562] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [15755.469949] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [15755.478363]  ? native_set_ldt.part.10+0xc0/0xc0
> [15755.484171]  ? smp_call_function_many+0x20a/0x260
> [15755.490154]  ? native_set_ldt.part.10+0xc0/0xc0
> [15755.495955]  on_each_cpu+0x28/0x40
> [15755.500615]  flush_tlb_kernel_range+0x79/0x80
> [15755.506259]  pmd_free_pte_page+0x41/0x60
> [15755.511477]  ioremap_page_range+0x30f/0x560
> [15755.516965]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15755.522544]  __ioremap_caller.constprop.18+0x1a8/0x300
> [15755.529004]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15755.534411]  ? _cond_resched+0x15/0x40
> [15755.539432]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [15755.545813]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [15755.552527]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [15755.559855]  drm_gem_vmap+0x1f/0x60 [drm]
> [15755.565088]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [15755.571239]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [15755.578588]  process_one_work+0x1e5/0x410
> [15755.583867]  worker_thread+0x2d/0x3c0
> [15755.588769]  ? cancel_delayed_work+0x90/0x90
> [15755.594259]  kthread+0x117/0x130
> [15755.598675]  ? kthread_create_worker_on_cpu+0x70/0x70
> [15755.604907]  ret_from_fork+0x22/0x40
> [15758.316451] nfs: server pappnase not responding, timed out
> [15764.460440] nfs: server gula not responding, timed out
> [15764.461439] nfs: server botanophobie not responding, timed out
> [15764.461445] nfs: server aquaphobie not responding, timed out
> [15768.557473] nfs: server pappnase not responding, timed out
> [15774.700451] nfs: server aquaphobie not responding, timed out
> [15774.700454] nfs: server botanophobie not responding, timed out
> [15774.700457] nfs: server gula not responding, timed out
> [15778.796470] nfs: server pappnase not responding, timed out
> [15782.893462] nfs: server afk not responding, timed out
> [15784.940472] nfs: server gula not responding, timed out
> [15784.940475] nfs: server botanophobie not responding, timed out
> [15784.941489] nfs: server aquaphobie not responding, timed out
> [15789.037502] nfs: server pappnase not responding, timed out
> [15857.645613] nfs: server afk not responding, timed out
> [15878.125659] nfs: server gula not responding, timed out
> [15878.125667] nfs: server botanophobie not responding, timed out
> [15878.125669] nfs: server aquaphobie not responding, timed out
> [15882.220668] nfs: server pappnase not responding, timed out
> [15888.364687] nfs: server botanophobie not responding, timed out
> [15888.364693] nfs: server gula not responding, timed out
> [15888.364696] nfs: server aquaphobie not responding, timed out
> [15892.461682] nfs: server pappnase not responding, timed out
> [15898.604708] nfs: server botanophobie not responding, timed out
> [15898.604711] nfs: server aquaphobie not responding, timed out
> [15898.605694] nfs: server gula not responding, timed out
> [15902.701709] nfs: server pappnase not responding, timed out
> [15908.844734] nfs: server aquaphobie not responding, timed out
> [15908.844751] nfs: server gula not responding, timed out
> [15908.845718] nfs: server botanophobie not responding, timed out
> [15912.940731] nfs: server pappnase not responding, timed out
> [15919.085734] nfs: server gula not responding, timed out
> [15919.085738] nfs: server botanophobie not responding, timed out
> [15919.085741] nfs: server aquaphobie not responding, timed out
> [15923.181745] nfs: server pappnase not responding, timed out
> [15929.324774] nfs: server aquaphobie not responding, timed out
> [15929.325759] nfs: server gula not responding, timed out
> [15933.420825] nfs: server pappnase not responding, timed out
> [15934.985630] rcu: INFO: rcu_sched self-detected stall on CPU
> [15934.992571] rcu: 	46-....: (5082838 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1145988 
> [15935.004222] 	(t=5100103 jiffies g=2794673 q=1263114)
> [15935.010391] Sending NMI from CPU 46 to CPUs 5:
> [15935.017009] NMI backtrace for cpu 5
> [15935.017010] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15935.017011] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15935.017012] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [15935.017013] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [15935.017013] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [15935.017014] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [15935.017015] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [15935.017016] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [15935.017016] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [15935.017017] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [15935.017017] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [15935.017018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [15935.017018] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [15935.017019] Call Trace:
> [15935.017019]  _raw_spin_lock_irqsave+0x22/0x30
> [15935.017020]  pagevec_lru_move_fn+0x6c/0xd0
> [15935.017020]  activate_page+0xb5/0xc0
> [15935.017020]  mark_page_accessed+0x7a/0x130
> [15935.017021]  generic_file_read_iter+0x4c8/0xae0
> [15935.017021]  ? generic_update_time+0x9c/0xc0
> [15935.017022]  ? pipe_write+0x286/0x400
> [15935.017022]  new_sync_read+0x114/0x1a0
> [15935.017023]  vfs_read+0x89/0x130
> [15935.017023]  ksys_read+0xa1/0xe0
> [15935.017023]  do_syscall_64+0x48/0x130
> [15935.017024]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [15935.017024] RIP: 0033:0x7fc44b933d71
> [15935.017026] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [15935.017026] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [15935.017027] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [15935.017028] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [15935.017028] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [15935.017029] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [15935.017029] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [15935.017054] NMI backtrace for cpu 46
> [15935.293571] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [15935.304891] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [15935.313813] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [15935.321869] Call Trace:
> [15935.325773]  <IRQ>
> [15935.329228]  dump_stack+0x50/0x6b
> [15935.333632]  nmi_cpu_backtrace+0x89/0x90
> [15935.338649]  ? lapic_can_unplug_cpu+0x90/0x90
> [15935.344082]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [15935.350076]  rcu_dump_cpu_stacks+0x99/0xd0
> [15935.355207]  rcu_sched_clock_irq+0x502/0x770
> [15935.360503]  ? tick_sched_do_timer+0x60/0x60
> [15935.365769]  update_process_times+0x24/0x50
> [15935.370935]  tick_sched_timer+0x37/0x70
> [15935.375746]  __hrtimer_run_queues+0x11f/0x2b0
> [15935.381063]  hrtimer_interrupt+0xe5/0x240
> [15935.385992]  smp_apic_timer_interrupt+0x6f/0x130
> [15935.391513]  apic_timer_interrupt+0xf/0x20
> [15935.396508]  </IRQ>
> [15935.399495] RIP: 0010:smp_call_function_many+0x22d/0x260
> [15935.405731] Code: 89 c7 e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a <f3> 90 8b 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2
> [15935.426364] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [15935.434874] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [15935.442950] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [15935.451032] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [15935.459112] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [15935.467187] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [15935.475279]  ? native_set_ldt.part.10+0xc0/0xc0
> [15935.480775]  ? smp_call_function_many+0x20a/0x260
> [15935.486446]  ? native_set_ldt.part.10+0xc0/0xc0
> [15935.491939]  on_each_cpu+0x28/0x40
> [15935.496302]  flush_tlb_kernel_range+0x79/0x80
> [15935.501634]  pmd_free_pte_page+0x41/0x60
> [15935.506530]  ioremap_page_range+0x30f/0x560
> [15935.511725]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15935.516995]  __ioremap_caller.constprop.18+0x1a8/0x300
> [15935.523133]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [15935.528221]  ? _cond_resched+0x15/0x40
> [15935.532928]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [15935.539010]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [15935.545429]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [15935.552449]  drm_gem_vmap+0x1f/0x60 [drm]
> [15935.557375]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [15935.563189]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [15935.570228]  process_one_work+0x1e5/0x410
> [15935.575188]  worker_thread+0x2d/0x3c0
> [15935.579786]  ? cancel_delayed_work+0x90/0x90
> [15935.584995]  kthread+0x117/0x130
> [15935.589124]  ? kthread_create_worker_on_cpu+0x70/0x70
> [15935.595059]  ret_from_fork+0x22/0x40
> [15939.564792] nfs: server botanophobie not responding, timed out
> [15939.564798] nfs: server aquaphobie not responding, timed out
> [15939.565652] nfs: server gula not responding, timed out
> [15943.661656] nfs: server pappnase not responding, timed out
> [15949.804814] nfs: server aquaphobie not responding, timed out
> [15949.805784] nfs: server botanophobie not responding, timed out
> [15949.805790] nfs: server gula not responding, timed out
> [15953.901807] nfs: server pappnase not responding, timed out
> [15960.044839] nfs: server aquaphobie not responding, timed out
> [15960.045814] nfs: server botanophobie not responding, timed out
> [15960.045817] nfs: server gula not responding, timed out
> [15964.140829] nfs: server pappnase not responding, timed out
> [15968.236835] nfs: server afk not responding, timed out
> [15970.284843] nfs: server botanophobie not responding, timed out
> [15970.284850] nfs: server gula not responding, timed out
> [15970.284853] nfs: server aquaphobie not responding, timed out
> [15974.380849] nfs: server pappnase not responding, timed out
> [16037.677964] nfs: server afk not responding, timed out
> [16058.349006] nfs: server gula not responding, timed out
> [16058.349017] nfs: server aquaphobie not responding, timed out
> [16058.349024] nfs: server botanophobie not responding, timed out
> [16062.445029] nfs: server pappnase not responding, timed out
> [16063.277023] nfs: server gula not responding, timed out
> [16063.277031] nfs: server botanophobie not responding, timed out
> [16063.277041] nfs: server aquaphobie not responding, timed out
> [16067.373029] nfs: server pappnase not responding, timed out
> [16073.709037] nfs: server gula not responding, timed out
> [16073.709039] nfs: server aquaphobie not responding, timed out
> [16073.710043] nfs: server botanophobie not responding, timed out
> [16077.805069] nfs: server pappnase not responding, timed out
> [16083.950072] nfs: server botanophobie not responding, timed out
> [16083.950086] nfs: server gula not responding, timed out
> [16088.045070] nfs: server pappnase not responding, timed out
> [16094.190099] nfs: server botanophobie not responding, timed out
> [16094.190113] nfs: server aquaphobie not responding, timed out
> [16094.190118] nfs: server gula not responding, timed out
> [16098.285090] nfs: server pappnase not responding, timed out
> [16104.429107] nfs: server aquaphobie not responding, timed out
> [16104.429132] nfs: server gula not responding, timed out
> [16104.430089] nfs: server botanophobie not responding, timed out
> [16108.525138] nfs: server pappnase not responding, timed out
> [16114.669115] nfs: server botanophobie not responding, timed out
> [16114.669121] nfs: server gula not responding, timed out
> [16114.669125] nfs: server aquaphobie not responding, timed out
> [16114.988980] rcu: INFO: rcu_sched self-detected stall on CPU
> [16114.995693] rcu: 	46-....: (5262229 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1187362 
> [16115.007107] 	(t=5280106 jiffies g=2794673 q=1264429)
> [16115.013053] Sending NMI from CPU 46 to CPUs 5:
> [16115.019383] NMI backtrace for cpu 5
> [16115.019384] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16115.019385] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16115.019385] RIP: 0010:queued_spin_lock_slowpath+0x3c/0x1a0
> [16115.019387] Code: e6 00 ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04
> [16115.019387] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [16115.019388] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [16115.019389] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [16115.019389] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [16115.019390] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [16115.019390] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [16115.019391] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [16115.019392] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16115.019392] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [16115.019393] Call Trace:
> [16115.019393]  _raw_spin_lock_irqsave+0x22/0x30
> [16115.019393]  pagevec_lru_move_fn+0x6c/0xd0
> [16115.019394]  activate_page+0xb5/0xc0
> [16115.019394]  mark_page_accessed+0x7a/0x130
> [16115.019395]  generic_file_read_iter+0x4c8/0xae0
> [16115.019395]  ? generic_update_time+0x9c/0xc0
> [16115.019396]  ? pipe_write+0x286/0x400
> [16115.019396]  new_sync_read+0x114/0x1a0
> [16115.019396]  vfs_read+0x89/0x130
> [16115.019397]  ksys_read+0xa1/0xe0
> [16115.019397]  do_syscall_64+0x48/0x130
> [16115.019398]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [16115.019398] RIP: 0033:0x7fc44b933d71
> [16115.019399] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [16115.019400] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [16115.019401] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [16115.019402] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [16115.019402] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [16115.019403] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [16115.019403] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [16115.019427] NMI backtrace for cpu 46
> [16115.282660] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16115.293588] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16115.302166] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [16115.309830] Call Trace:
> [16115.313350]  <IRQ>
> [16115.316452]  dump_stack+0x50/0x6b
> [16115.320792]  nmi_cpu_backtrace+0x89/0x90
> [16115.325710]  ? lapic_can_unplug_cpu+0x90/0x90
> [16115.331113]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [16115.337112]  rcu_dump_cpu_stacks+0x99/0xd0
> [16115.342235]  rcu_sched_clock_irq+0x502/0x770
> [16115.347470]  ? tick_sched_do_timer+0x60/0x60
> [16115.352730]  update_process_times+0x24/0x50
> [16115.357836]  tick_sched_timer+0x37/0x70
> [16115.362625]  __hrtimer_run_queues+0x11f/0x2b0
> [16115.367849]  hrtimer_interrupt+0xe5/0x240
> [16115.372779]  smp_apic_timer_interrupt+0x6f/0x130
> [16115.378246]  apic_timer_interrupt+0xf/0x20
> [16115.383184]  </IRQ>
> [16115.386180] RIP: 0010:smp_call_function_many+0x22f/0x260
> [16115.392376] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [16115.412949] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [16115.421430] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [16115.429503] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [16115.437575] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [16115.445658] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [16115.453747] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [16115.461834]  ? native_set_ldt.part.10+0xc0/0xc0
> [16115.467325]  ? smp_call_function_many+0x20a/0x260
> [16115.472984]  ? native_set_ldt.part.10+0xc0/0xc0
> [16115.478455]  on_each_cpu+0x28/0x40
> [16115.482775]  flush_tlb_kernel_range+0x79/0x80
> [16115.488034]  pmd_free_pte_page+0x41/0x60
> [16115.492887]  ioremap_page_range+0x30f/0x560
> [16115.498015]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16115.503233]  __ioremap_caller.constprop.18+0x1a8/0x300
> [16115.509366]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16115.514443]  ? _cond_resched+0x15/0x40
> [16115.519107]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [16115.525212]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [16115.531623]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [16115.538654]  drm_gem_vmap+0x1f/0x60 [drm]
> [16115.543532]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [16115.549344]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [16115.556385]  process_one_work+0x1e5/0x410
> [16115.561290]  worker_thread+0x2d/0x3c0
> [16115.565878]  ? cancel_delayed_work+0x90/0x90
> [16115.571089]  kthread+0x117/0x130
> [16115.575225]  ? kthread_create_worker_on_cpu+0x70/0x70
> [16115.581160]  ret_from_fork+0x22/0x40
> [16118.765197] nfs: server pappnase not responding, timed out
> [16124.909164] nfs: server aquaphobie not responding, timed out
> [16124.910131] nfs: server gula not responding, timed out
> [16124.910134] nfs: server botanophobie not responding, timed out
> [16129.005163] nfs: server pappnase not responding, timed out
> [16135.149156] nfs: server gula not responding, timed out
> [16135.150145] nfs: server botanophobie not responding, timed out
> [16135.150153] nfs: server aquaphobie not responding, timed out
> [16139.245186] nfs: server pappnase not responding, timed out
> [16145.389174] nfs: server gula not responding, timed out
> [16145.389176] nfs: server botanophobie not responding, timed out
> [16145.389181] nfs: server aquaphobie not responding, timed out
> [16149.485214] nfs: server pappnase not responding, timed out
> [16153.582179] nfs: server afk not responding, timed out
> [16155.437198] nfs: server aquaphobie not responding, timed out
> [16155.438196] nfs: server gula not responding, timed out
> [16155.438199] nfs: server botanophobie not responding, timed out
> [16159.534202] nfs: server pappnase not responding, timed out
> [16218.094311] nfs: server afk not responding, timed out
> [16238.573356] nfs: server gula not responding, timed out
> [16238.574355] nfs: server botanophobie not responding, timed out
> [16238.574361] nfs: server aquaphobie not responding, timed out
> [16242.670392] nfs: server pappnase not responding, timed out
> [16248.813376] nfs: server botanophobie not responding, timed out
> [16248.813381] nfs: server gula not responding, timed out
> [16248.813387] nfs: server aquaphobie not responding, timed out
> [16252.909392] nfs: server pappnase not responding, timed out
> [16259.053417] nfs: server aquaphobie not responding, timed out
> [16259.053432] nfs: server gula not responding, timed out
> [16263.149413] nfs: server pappnase not responding, timed out
> [16269.293420] nfs: server gula not responding, timed out
> [16269.293430] nfs: server aquaphobie not responding, timed out
> [16269.294413] nfs: server botanophobie not responding, timed out
> [16273.389423] nfs: server pappnase not responding, timed out
> [16279.533436] nfs: server gula not responding, timed out
> [16279.533438] nfs: server aquaphobie not responding, timed out
> [16279.534446] nfs: server botanophobie not responding, timed out
> [16283.629448] nfs: server pappnase not responding, timed out
> [16289.773454] nfs: server gula not responding, timed out
> [16289.773458] nfs: server aquaphobie not responding, timed out
> [16289.774481] nfs: server botanophobie not responding, timed out
> [16293.869465] nfs: server pappnase not responding, timed out
> [16294.992330] rcu: INFO: rcu_sched self-detected stall on CPU
> [16294.999038] rcu: 	46-....: (5441637 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1226724 
> [16295.010381] 	(t=5460108 jiffies g=2794673 q=1265813)
> [16295.016240] Sending NMI from CPU 46 to CPUs 5:
> [16295.022548] NMI backtrace for cpu 5
> [16295.022549] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16295.022550] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16295.022551] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [16295.022552] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [16295.022552] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [16295.022554] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [16295.022554] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [16295.022555] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [16295.022555] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [16295.022556] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [16295.022557] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [16295.022557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16295.022558] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [16295.022558] Call Trace:
> [16295.022559]  _raw_spin_lock_irqsave+0x22/0x30
> [16295.022559]  pagevec_lru_move_fn+0x6c/0xd0
> [16295.022560]  activate_page+0xb5/0xc0
> [16295.022560]  mark_page_accessed+0x7a/0x130
> [16295.022560]  generic_file_read_iter+0x4c8/0xae0
> [16295.022561]  ? generic_update_time+0x9c/0xc0
> [16295.022561]  ? pipe_write+0x286/0x400
> [16295.022562]  new_sync_read+0x114/0x1a0
> [16295.022562]  vfs_read+0x89/0x130
> [16295.022563]  ksys_read+0xa1/0xe0
> [16295.022563]  do_syscall_64+0x48/0x130
> [16295.022564]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [16295.022564] RIP: 0033:0x7fc44b933d71
> [16295.022565] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [16295.022566] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [16295.022567] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [16295.022568] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [16295.022568] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [16295.022569] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [16295.022569] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [16295.022601] NMI backtrace for cpu 46
> [16295.285781] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16295.296720] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16295.305306] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [16295.313044] Call Trace:
> [16295.316587]  <IRQ>
> [16295.319687]  dump_stack+0x50/0x6b
> [16295.324034]  nmi_cpu_backtrace+0x89/0x90
> [16295.328972]  ? lapic_can_unplug_cpu+0x90/0x90
> [16295.334364]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [16295.340406]  rcu_dump_cpu_stacks+0x99/0xd0
> [16295.345524]  rcu_sched_clock_irq+0x502/0x770
> [16295.350757]  ? tick_sched_do_timer+0x60/0x60
> [16295.356016]  update_process_times+0x24/0x50
> [16295.361138]  tick_sched_timer+0x37/0x70
> [16295.365932]  __hrtimer_run_queues+0x11f/0x2b0
> [16295.371177]  hrtimer_interrupt+0xe5/0x240
> [16295.376092]  smp_apic_timer_interrupt+0x6f/0x130
> [16295.381550]  apic_timer_interrupt+0xf/0x20
> [16295.386530]  </IRQ>
> [16295.389531] RIP: 0010:smp_call_function_many+0x22f/0x260
> [16295.395722] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [16295.416293] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [16295.424777] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [16295.432847] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [16295.440910] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [16295.448991] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [16295.457064] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [16295.465149]  ? native_set_ldt.part.10+0xc0/0xc0
> [16295.470647]  ? smp_call_function_many+0x20a/0x260
> [16295.476333]  ? native_set_ldt.part.10+0xc0/0xc0
> [16295.481804]  on_each_cpu+0x28/0x40
> [16295.486107]  flush_tlb_kernel_range+0x79/0x80
> [16295.491376]  pmd_free_pte_page+0x41/0x60
> [16295.496239]  ioremap_page_range+0x30f/0x560
> [16295.501372]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16295.506587]  __ioremap_caller.constprop.18+0x1a8/0x300
> [16295.512717]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16295.517792]  ? _cond_resched+0x15/0x40
> [16295.522460]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [16295.528564]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [16295.534974]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [16295.542001]  drm_gem_vmap+0x1f/0x60 [drm]
> [16295.546873]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [16295.552676]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [16295.559712]  process_one_work+0x1e5/0x410
> [16295.564629]  worker_thread+0x2d/0x3c0
> [16295.569224]  ? cancel_delayed_work+0x90/0x90
> [16295.574430]  kthread+0x117/0x130
> [16295.578557]  ? kthread_create_worker_on_cpu+0x70/0x70
> [16295.584492]  ret_from_fork+0x22/0x40
> [16300.013486] nfs: server aquaphobie not responding, timed out
> [16300.013543] nfs: server gula not responding, timed out
> [16300.014480] nfs: server botanophobie not responding, timed out
> [16304.110503] nfs: server pappnase not responding, timed out
> [16310.253504] nfs: server aquaphobie not responding, timed out
> [16310.253516] nfs: server gula not responding, timed out
> [16310.254501] nfs: server botanophobie not responding, timed out
> [16314.350516] nfs: server pappnase not responding, timed out
> [16320.493507] nfs: server aquaphobie not responding, timed out
> [16320.493514] nfs: server gula not responding, timed out
> [16320.494522] nfs: server botanophobie not responding, timed out
> [16324.589528] nfs: server pappnase not responding, timed out
> [16330.734542] nfs: server gula not responding, timed out
> [16330.734546] nfs: server botanophobie not responding, timed out
> [16330.734554] nfs: server aquaphobie not responding, timed out
> [16334.829577] nfs: server pappnase not responding, timed out
> [16338.926541] nfs: server afk not responding, timed out
> [16340.973562] nfs: server botanophobie not responding, timed out
> [16340.973565] nfs: server aquaphobie not responding, timed out
> [16340.973648] nfs: server gula not responding, timed out
> [16345.069567] nfs: server pappnase not responding, timed out
> [16398.318670] nfs: server afk not responding, timed out
> [16418.797725] nfs: server aquaphobie not responding, timed out
> [16418.797729] nfs: server gula not responding, timed out
> [16418.798719] nfs: server botanophobie not responding, timed out
> [16422.894723] nfs: server pappnase not responding, timed out
> [16423.726724] nfs: server botanophobie not responding, timed out
> [16423.726746] nfs: server gula not responding, timed out
> [16423.726750] nfs: server aquaphobie not responding, timed out
> [16427.821723] nfs: server pappnase not responding, timed out
> [16434.157735] nfs: server gula not responding, timed out
> [16434.158753] nfs: server botanophobie not responding, timed out
> [16434.158761] nfs: server aquaphobie not responding, timed out
> [16438.253748] nfs: server pappnase not responding, timed out
> [16444.397765] nfs: server gula not responding, timed out
> [16444.397770] nfs: server aquaphobie not responding, timed out
> [16444.398780] nfs: server botanophobie not responding, timed out
> [16448.493768] nfs: server pappnase not responding, timed out
> [16454.637781] nfs: server gula not responding, timed out
> [16454.637784] nfs: server aquaphobie not responding, timed out
> [16454.638803] nfs: server botanophobie not responding, timed out
> [16458.733793] nfs: server pappnase not responding, timed out
> [16464.877797] nfs: server aquaphobie not responding, timed out
> [16464.877801] nfs: server botanophobie not responding, timed out
> [16464.877805] nfs: server gula not responding, timed out
> [16468.973941] nfs: server pappnase not responding, timed out
> [16474.995679] rcu: INFO: rcu_sched self-detected stall on CPU
> [16475.002422] rcu: 	46-....: (5621045 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1267379 
> [16475.013759] 	(t=5640111 jiffies g=2794673 q=1267784)
> [16475.019594] Sending NMI from CPU 46 to CPUs 5:
> [16475.025937] NMI backtrace for cpu 5
> [16475.025938] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16475.025939] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16475.025939] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [16475.025940] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [16475.025941] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [16475.025942] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [16475.025943] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [16475.025943] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [16475.025944] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [16475.025944] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [16475.025945] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [16475.025946] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16475.025946] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [16475.025947] Call Trace:
> [16475.025947]  _raw_spin_lock_irqsave+0x22/0x30
> [16475.025948]  pagevec_lru_move_fn+0x6c/0xd0
> [16475.025948]  activate_page+0xb5/0xc0
> [16475.025948]  mark_page_accessed+0x7a/0x130
> [16475.025949]  generic_file_read_iter+0x4c8/0xae0
> [16475.025949]  ? generic_update_time+0x9c/0xc0
> [16475.025950]  ? pipe_write+0x286/0x400
> [16475.025950]  new_sync_read+0x114/0x1a0
> [16475.025950]  vfs_read+0x89/0x130
> [16475.025951]  ksys_read+0xa1/0xe0
> [16475.025951]  do_syscall_64+0x48/0x130
> [16475.025952]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [16475.025952] RIP: 0033:0x7fc44b933d71
> [16475.025953] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [16475.025954] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [16475.025955] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [16475.025956] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [16475.025956] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [16475.025957] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [16475.025958] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [16475.025981] NMI backtrace for cpu 46
> [16475.118848] nfs: server botanophobie not responding, timed out
> [16475.118866] nfs: server aquaphobie not responding, timed out
> [16475.118870] nfs: server gula not responding, timed out
> [16475.122461] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16475.122472] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16475.122482] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [16475.343940] Call Trace:
> [16475.347781]  <IRQ>
> [16475.351113]  dump_stack+0x50/0x6b
> [16475.355802]  nmi_cpu_backtrace+0x89/0x90
> [16475.361041]  ? lapic_can_unplug_cpu+0x90/0x90
> [16475.366743]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [16475.373044]  rcu_dump_cpu_stacks+0x99/0xd0
> [16475.378456]  rcu_sched_clock_irq+0x502/0x770
> [16475.383952]  ? tick_sched_do_timer+0x60/0x60
> [16475.389402]  update_process_times+0x24/0x50
> [16475.394813]  tick_sched_timer+0x37/0x70
> [16475.399839]  __hrtimer_run_queues+0x11f/0x2b0
> [16475.405347]  hrtimer_interrupt+0xe5/0x240
> [16475.410539]  smp_apic_timer_interrupt+0x6f/0x130
> [16475.416315]  apic_timer_interrupt+0xf/0x20
> [16475.421539]  </IRQ>
> [16475.424807] RIP: 0010:smp_call_function_many+0x22f/0x260
> [16475.431285] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [16475.452445] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [16475.461220] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [16475.469609] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [16475.477954] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [16475.486327] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [16475.494685] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [16475.503071]  ? native_set_ldt.part.10+0xc0/0xc0
> [16475.508896]  ? smp_call_function_many+0x20a/0x260
> [16475.514908]  ? native_set_ldt.part.10+0xc0/0xc0
> [16475.520757]  on_each_cpu+0x28/0x40
> [16475.525470]  flush_tlb_kernel_range+0x79/0x80
> [16475.531141]  pmd_free_pte_page+0x41/0x60
> [16475.536384]  ioremap_page_range+0x30f/0x560
> [16475.541831]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16475.547345]  __ioremap_caller.constprop.18+0x1a8/0x300
> [16475.553714]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16475.558961]  ? _cond_resched+0x15/0x40
> [16475.563926]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [16475.570230]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [16475.576906]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [16475.584255]  drm_gem_vmap+0x1f/0x60 [drm]
> [16475.589478]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [16475.595568]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [16475.602879]  process_one_work+0x1e5/0x410
> [16475.608121]  worker_thread+0x2d/0x3c0
> [16475.612977]  ? cancel_delayed_work+0x90/0x90
> [16475.618479]  kthread+0x117/0x130
> [16475.622837]  ? kthread_create_worker_on_cpu+0x70/0x70
> [16475.629079]  ret_from_fork+0x22/0x40
> [16479.213823] nfs: server pappnase not responding, timed out
> [16485.357838] nfs: server aquaphobie not responding, timed out
> [16485.357853] nfs: server gula not responding, timed out
> [16485.358829] nfs: server botanophobie not responding, timed out
> [16489.453853] nfs: server pappnase not responding, timed out
> [16495.597862] nfs: server aquaphobie not responding, timed out
> [16495.597865] nfs: server gula not responding, timed out
> [16495.598865] nfs: server botanophobie not responding, timed out
> [16499.693869] nfs: server pappnase not responding, timed out
> [16505.837881] nfs: server gula not responding, timed out
> [16505.837887] nfs: server aquaphobie not responding, timed out
> [16505.838869] nfs: server botanophobie not responding, timed out
> [16509.933882] nfs: server pappnase not responding, timed out
> [16515.886769] nfs: server aquaphobie not responding, timed out
> [16515.886912] nfs: server botanophobie not responding, timed out
> [16515.886924] nfs: server gula not responding, timed out
> [16519.981902] nfs: server pappnase not responding, timed out
> [16524.270896] nfs: server afk not responding, timed out
> [16526.317917] nfs: server gula not responding, timed out
> [16526.318924] nfs: server botanophobie not responding, timed out
> [16526.318927] nfs: server aquaphobie not responding, timed out
> [16530.413928] nfs: server pappnase not responding, timed out
> [16578.543008] nfs: server afk not responding, timed out
> [16599.022056] nfs: server botanophobie not responding, timed out
> [16599.022069] nfs: server gula not responding, timed out
> [16599.022075] nfs: server aquaphobie not responding, timed out
> [16603.119075] nfs: server pappnase not responding, timed out
> [16609.262099] nfs: server botanophobie not responding, timed out
> [16609.263080] nfs: server gula not responding, timed out
> [16609.263086] nfs: server aquaphobie not responding, timed out
> [16613.359093] nfs: server pappnase not responding, timed out
> [16619.503101] nfs: server botanophobie not responding, timed out
> [16619.503108] nfs: server gula not responding, timed out
> [16619.503110] nfs: server aquaphobie not responding, timed out
> [16623.598112] nfs: server pappnase not responding, timed out
> [16629.742131] nfs: server botanophobie not responding, timed out
> [16629.742134] nfs: server aquaphobie not responding, timed out
> [16629.742148] nfs: server gula not responding, timed out
> [16633.838125] nfs: server pappnase not responding, timed out
> [16639.982143] nfs: server botanophobie not responding, timed out
> [16639.982146] nfs: server aquaphobie not responding, timed out
> [16639.982157] nfs: server gula not responding, timed out
> [16644.078146] nfs: server pappnase not responding, timed out
> [16650.222172] nfs: server aquaphobie not responding, timed out
> [16650.222248] nfs: server gula not responding, timed out
> [16650.223152] nfs: server botanophobie not responding, timed out
> [16654.319177] nfs: server pappnase not responding, timed out
> [16654.999032] rcu: INFO: rcu_sched self-detected stall on CPU
> [16655.005973] rcu: 	46-....: (5800411 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1307551 
> [16655.017605] 	(t=5820115 jiffies g=2794673 q=1269109)
> [16655.023771] Sending NMI from CPU 46 to CPUs 5:
> [16655.030399] NMI backtrace for cpu 5
> [16655.030400] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16655.030401] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16655.030401] RIP: 0010:queued_spin_lock_slowpath+0x3c/0x1a0
> [16655.030403] Code: e6 00 ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04
> [16655.030403] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [16655.030404] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [16655.030405] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [16655.030406] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [16655.030406] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [16655.030407] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [16655.030407] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [16655.030408] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16655.030409] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [16655.030409] Call Trace:
> [16655.030410]  _raw_spin_lock_irqsave+0x22/0x30
> [16655.030410]  pagevec_lru_move_fn+0x6c/0xd0
> [16655.030410]  activate_page+0xb5/0xc0
> [16655.030411]  mark_page_accessed+0x7a/0x130
> [16655.030411]  generic_file_read_iter+0x4c8/0xae0
> [16655.030412]  ? generic_update_time+0x9c/0xc0
> [16655.030412]  ? pipe_write+0x286/0x400
> [16655.030413]  new_sync_read+0x114/0x1a0
> [16655.030413]  vfs_read+0x89/0x130
> [16655.030413]  ksys_read+0xa1/0xe0
> [16655.030414]  do_syscall_64+0x48/0x130
> [16655.030414]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [16655.030415] RIP: 0033:0x7fc44b933d71
> [16655.030416] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [16655.030417] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [16655.030418] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [16655.030418] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [16655.030419] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [16655.030419] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [16655.030420] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [16655.030445] NMI backtrace for cpu 46
> [16655.306879] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16655.318250] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16655.327198] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [16655.335275] Call Trace:
> [16655.339186]  <IRQ>
> [16655.342646]  dump_stack+0x50/0x6b
> [16655.347443]  nmi_cpu_backtrace+0x89/0x90
> [16655.352778]  ? lapic_can_unplug_cpu+0x90/0x90
> [16655.358521]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [16655.364850]  rcu_dump_cpu_stacks+0x99/0xd0
> [16655.370311]  rcu_sched_clock_irq+0x502/0x770
> [16655.375931]  ? tick_sched_do_timer+0x60/0x60
> [16655.381526]  update_process_times+0x24/0x50
> [16655.387030]  tick_sched_timer+0x37/0x70
> [16655.392148]  __hrtimer_run_queues+0x11f/0x2b0
> [16655.397744]  ? ixgbe_msix_clean_rings+0x19/0x40 [ixgbe]
> [16655.404158]  hrtimer_interrupt+0xe5/0x240
> [16655.409342]  smp_apic_timer_interrupt+0x6f/0x130
> [16655.415173]  apic_timer_interrupt+0xf/0x20
> [16655.420455]  </IRQ>
> [16655.423746] RIP: 0010:smp_call_function_many+0x22f/0x260
> [16655.430252] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [16655.451521] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [16655.460347] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [16655.468734] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [16655.477151] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [16655.485565] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [16655.493975] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [16655.502403]  ? native_set_ldt.part.10+0xc0/0xc0
> [16655.508238]  ? smp_call_function_many+0x20a/0x260
> [16655.514234]  ? native_set_ldt.part.10+0xc0/0xc0
> [16655.520063]  on_each_cpu+0x28/0x40
> [16655.524772]  flush_tlb_kernel_range+0x79/0x80
> [16655.530483]  pmd_free_pte_page+0x41/0x60
> [16655.535712]  ioremap_page_range+0x30f/0x560
> [16655.541243]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16655.546812]  __ioremap_caller.constprop.18+0x1a8/0x300
> [16655.553296]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16655.558678]  ? _cond_resched+0x15/0x40
> [16655.563678]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [16655.570040]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [16655.576757]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [16655.584145]  drm_gem_vmap+0x1f/0x60 [drm]
> [16655.589403]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [16655.595532]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [16655.602897]  process_one_work+0x1e5/0x410
> [16655.608150]  worker_thread+0x2d/0x3c0
> [16655.613042]  ? cancel_delayed_work+0x90/0x90
> [16655.618512]  kthread+0x117/0x130
> [16655.622923]  ? kthread_create_worker_on_cpu+0x70/0x70
> [16655.629179]  ret_from_fork+0x22/0x40
> [16660.462193] nfs: server botanophobie not responding, timed out
> [16660.462201] nfs: server aquaphobie not responding, timed out
> [16660.462221] nfs: server gula not responding, timed out
> [16664.558186] nfs: server pappnase not responding, timed out
> [16670.702216] nfs: server aquaphobie not responding, timed out
> [16670.702234] nfs: server gula not responding, timed out
> [16670.703193] nfs: server botanophobie not responding, timed out
> [16674.798205] nfs: server pappnase not responding, timed out
> [16680.942216] nfs: server aquaphobie not responding, timed out
> [16680.942318] nfs: server gula not responding, timed out
> [16680.943228] nfs: server botanophobie not responding, timed out
> [16685.038228] nfs: server pappnase not responding, timed out
> [16691.182242] nfs: server botanophobie not responding, timed out
> [16691.182246] nfs: server gula not responding, timed out
> [16691.182249] nfs: server aquaphobie not responding, timed out
> [16695.278250] nfs: server pappnase not responding, timed out
> [16701.422259] nfs: server aquaphobie not responding, timed out
> [16701.422267] nfs: server gula not responding, timed out
> [16701.423259] nfs: server botanophobie not responding, timed out
> [16705.518272] nfs: server pappnase not responding, timed out
> [16709.615266] nfs: server afk not responding, timed out
> [16711.662285] nfs: server botanophobie not responding, timed out
> [16711.662287] nfs: server gula not responding, timed out
> [16711.663292] nfs: server aquaphobie not responding, timed out
> [16715.758290] nfs: server pappnase not responding, timed out
> [16758.767370] nfs: server afk not responding, timed out
> [16779.054414] nfs: server gula not responding, timed out
> [16779.055413] nfs: server aquaphobie not responding, timed out
> [16779.055416] nfs: server botanophobie not responding, timed out
> [16783.151425] nfs: server pappnase not responding, timed out
> [16784.174425] nfs: server aquaphobie not responding, timed out
> [16784.174427] nfs: server gula not responding, timed out
> [16784.175416] nfs: server botanophobie not responding, timed out
> [16788.271428] nfs: server pappnase not responding, timed out
> [16794.606442] nfs: server aquaphobie not responding, timed out
> [16794.606445] nfs: server gula not responding, timed out
> [16794.607455] nfs: server botanophobie not responding, timed out
> [16798.703446] nfs: server pappnase not responding, timed out
> [16804.846456] nfs: server aquaphobie not responding, timed out
> [16804.847463] nfs: server gula not responding, timed out
> [16804.847471] nfs: server botanophobie not responding, timed out
> [16808.943648] nfs: server pappnase not responding, timed out
> [16815.086483] nfs: server aquaphobie not responding, timed out
> [16815.087478] nfs: server botanophobie not responding, timed out
> [16815.087485] nfs: server gula not responding, timed out
> [16819.183494] nfs: server pappnase not responding, timed out
> [16825.327497] nfs: server botanophobie not responding, timed out
> [16825.327502] nfs: server gula not responding, timed out
> [16825.327516] nfs: server aquaphobie not responding, timed out
> [16829.423503] nfs: server pappnase not responding, timed out
> [16835.002383] rcu: INFO: rcu_sched self-detected stall on CPU
> [16835.009121] rcu: 	46-....: (5979781 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1347801 
> [16835.020433] 	(t=6000117 jiffies g=2794673 q=1270399)
> [16835.026271] Sending NMI from CPU 46 to CPUs 5:
> [16835.032622] NMI backtrace for cpu 5
> [16835.032623] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16835.032624] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16835.032625] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [16835.032626] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [16835.032627] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [16835.032628] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [16835.032629] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [16835.032629] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [16835.032630] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [16835.032630] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [16835.032631] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [16835.032631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16835.032632] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [16835.032632] Call Trace:
> [16835.032633]  _raw_spin_lock_irqsave+0x22/0x30
> [16835.032633]  pagevec_lru_move_fn+0x6c/0xd0
> [16835.032634]  activate_page+0xb5/0xc0
> [16835.032634]  mark_page_accessed+0x7a/0x130
> [16835.032635]  generic_file_read_iter+0x4c8/0xae0
> [16835.032635]  ? generic_update_time+0x9c/0xc0
> [16835.032636]  ? pipe_write+0x286/0x400
> [16835.032636]  new_sync_read+0x114/0x1a0
> [16835.032636]  vfs_read+0x89/0x130
> [16835.032637]  ksys_read+0xa1/0xe0
> [16835.032637]  do_syscall_64+0x48/0x130
> [16835.032638]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [16835.032638] RIP: 0033:0x7fc44b933d71
> [16835.032639] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [16835.032640] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [16835.032641] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [16835.032642] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [16835.032642] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [16835.032643] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [16835.032643] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [16835.032668] NMI backtrace for cpu 46
> [16835.295306] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [16835.306265] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [16835.314807] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [16835.322498] Call Trace:
> [16835.325990]  <IRQ>
> [16835.329091]  dump_stack+0x50/0x6b
> [16835.333418]  nmi_cpu_backtrace+0x89/0x90
> [16835.338403]  ? lapic_can_unplug_cpu+0x90/0x90
> [16835.343749]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [16835.349742]  rcu_dump_cpu_stacks+0x99/0xd0
> [16835.354868]  rcu_sched_clock_irq+0x502/0x770
> [16835.360094]  ? tick_sched_do_timer+0x60/0x60
> [16835.365356]  update_process_times+0x24/0x50
> [16835.370502]  tick_sched_timer+0x37/0x70
> [16835.375240]  __hrtimer_run_queues+0x11f/0x2b0
> [16835.380499]  hrtimer_interrupt+0xe5/0x240
> [16835.385382]  smp_apic_timer_interrupt+0x6f/0x130
> [16835.390880]  apic_timer_interrupt+0xf/0x20
> [16835.395834]  </IRQ>
> [16835.398823] RIP: 0010:smp_call_function_many+0x22f/0x260
> [16835.404970] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [16835.425542] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [16835.434051] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [16835.442131] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [16835.450206] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [16835.458286] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [16835.466351] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [16835.474405]  ? native_set_ldt.part.10+0xc0/0xc0
> [16835.479856]  ? smp_call_function_many+0x20a/0x260
> [16835.485526]  ? native_set_ldt.part.10+0xc0/0xc0
> [16835.491027]  on_each_cpu+0x28/0x40
> [16835.495340]  flush_tlb_kernel_range+0x79/0x80
> [16835.500639]  pmd_free_pte_page+0x41/0x60
> [16835.505509]  ioremap_page_range+0x30f/0x560
> [16835.510673]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16835.515884]  __ioremap_caller.constprop.18+0x1a8/0x300
> [16835.522012]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [16835.527095]  ? _cond_resched+0x15/0x40
> [16835.531754]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [16835.537824]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [16835.544234]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [16835.551256]  drm_gem_vmap+0x1f/0x60 [drm]
> [16835.556153]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [16835.561967]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [16835.566536] nfs: server aquaphobie not responding, timed out
> [16835.566539] nfs: server gula not responding, timed out
> [16835.567534] nfs: server botanophobie not responding, timed out
> [16835.569013]  process_one_work+0x1e5/0x410
> [16835.569022]  worker_thread+0x2d/0x3c0
> [16835.598053]  ? cancel_delayed_work+0x90/0x90
> [16835.603204]  kthread+0x117/0x130
> [16835.607262]  ? kthread_create_worker_on_cpu+0x70/0x70
> [16835.613178]  ret_from_fork+0x22/0x40
> [16839.662535] nfs: server pappnase not responding, timed out
> [16845.806542] nfs: server botanophobie not responding, timed out
> [16845.806544] nfs: server gula not responding, timed out
> [16845.807535] nfs: server aquaphobie not responding, timed out
> [16849.903550] nfs: server pappnase not responding, timed out
> [16856.046562] nfs: server aquaphobie not responding, timed out
> [16856.047563] nfs: server botanophobie not responding, timed out
> [16856.047565] nfs: server gula not responding, timed out
> [16860.143564] nfs: server pappnase not responding, timed out
> [16866.286585] nfs: server aquaphobie not responding, timed out
> [16866.287579] nfs: server gula not responding, timed out
> [16866.287586] nfs: server botanophobie not responding, timed out
> [16870.383593] nfs: server pappnase not responding, timed out
> [16876.334591] nfs: server botanophobie not responding, timed out
> [16876.334596] nfs: server aquaphobie not responding, timed out
> [16876.334602] nfs: server gula not responding, timed out
> [16880.430637] nfs: server pappnase not responding, timed out
> [16886.766623] nfs: server aquaphobie not responding, timed out
> [16886.766626] nfs: server botanophobie not responding, timed out
> [16886.766644] nfs: server gula not responding, timed out
> [16890.863639] nfs: server pappnase not responding, timed out
> [16897.006646] nfs: server aquaphobie not responding, timed out
> [16897.007631] nfs: server gula not responding, timed out
> [16897.007634] nfs: server botanophobie not responding, timed out
> [16898.031623] nfs: server afk not responding, timed out
> [16901.103660] nfs: server pappnase not responding, timed out
> [16938.991712] nfs: server afk not responding, timed out
> [16959.470778] nfs: server aquaphobie not responding, timed out
> [16959.470785] nfs: server gula not responding, timed out
> [16959.471755] nfs: server botanophobie not responding, timed out
> [16963.567780] nfs: server pappnase not responding, timed out
> [16969.710795] nfs: server botanophobie not responding, timed out
> [16969.711654] nfs: server aquaphobie not responding, timed out
> [16969.711781] nfs: server gula not responding, timed out
> [16973.806787] nfs: server pappnase not responding, timed out
> [16979.950969] nfs: server gula not responding, timed out
> [16979.951798] nfs: server aquaphobie not responding, timed out
> [16979.951806] nfs: server botanophobie not responding, timed out
> [16984.046805] nfs: server pappnase not responding, timed out
> [16990.190837] nfs: server aquaphobie not responding, timed out
> [16990.190850] nfs: server gula not responding, timed out
> [16990.191816] nfs: server botanophobie not responding, timed out
> [16994.286841] nfs: server pappnase not responding, timed out
> [17000.430857] nfs: server gula not responding, timed out
> [17000.430860] nfs: server aquaphobie not responding, timed out
> [17000.431727] nfs: server botanophobie not responding, timed out
> [17004.526854] nfs: server pappnase not responding, timed out
> [17010.670886] nfs: server aquaphobie not responding, timed out
> [17010.670900] nfs: server gula not responding, timed out
> [17010.671849] nfs: server botanophobie not responding, timed out
> [17014.767877] nfs: server pappnase not responding, timed out
> [17015.005732] rcu: INFO: rcu_sched self-detected stall on CPU
> [17015.012475] rcu: 	46-....: (6159170 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1387508 
> [17015.023868] 	(t=6180121 jiffies g=2794673 q=1272162)
> [17015.029801] Sending NMI from CPU 46 to CPUs 5:
> [17015.036139] NMI backtrace for cpu 5
> [17015.036140] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17015.036141] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17015.036142] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [17015.036143] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [17015.036143] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [17015.036145] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [17015.036145] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [17015.036146] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [17015.036146] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [17015.036147] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [17015.036148] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [17015.036148] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17015.036149] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [17015.036149] Call Trace:
> [17015.036150]  _raw_spin_lock_irqsave+0x22/0x30
> [17015.036150]  pagevec_lru_move_fn+0x6c/0xd0
> [17015.036150]  activate_page+0xb5/0xc0
> [17015.036151]  mark_page_accessed+0x7a/0x130
> [17015.036151]  generic_file_read_iter+0x4c8/0xae0
> [17015.036152]  ? generic_update_time+0x9c/0xc0
> [17015.036152]  ? pipe_write+0x286/0x400
> [17015.036152]  new_sync_read+0x114/0x1a0
> [17015.036153]  vfs_read+0x89/0x130
> [17015.036153]  ksys_read+0xa1/0xe0
> [17015.036154]  do_syscall_64+0x48/0x130
> [17015.036154]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [17015.036155] RIP: 0033:0x7fc44b933d71
> [17015.036156] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [17015.036156] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [17015.036158] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [17015.036158] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [17015.036159] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [17015.036159] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [17015.036160] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [17015.036185] NMI backtrace for cpu 46
> [17015.300476] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17015.311474] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17015.320056] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [17015.327776] Call Trace:
> [17015.331323]  <IRQ>
> [17015.334431]  dump_stack+0x50/0x6b
> [17015.338852]  nmi_cpu_backtrace+0x89/0x90
> [17015.343853]  ? lapic_can_unplug_cpu+0x90/0x90
> [17015.349237]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [17015.355235]  rcu_dump_cpu_stacks+0x99/0xd0
> [17015.360364]  rcu_sched_clock_irq+0x502/0x770
> [17015.365648]  ? tick_sched_do_timer+0x60/0x60
> [17015.370913]  update_process_times+0x24/0x50
> [17015.376073]  tick_sched_timer+0x37/0x70
> [17015.380861]  __hrtimer_run_queues+0x11f/0x2b0
> [17015.386188]  hrtimer_interrupt+0xe5/0x240
> [17015.391106]  smp_apic_timer_interrupt+0x6f/0x130
> [17015.396634]  apic_timer_interrupt+0xf/0x20
> [17015.401635]  </IRQ>
> [17015.404623] RIP: 0010:smp_call_function_many+0x22f/0x260
> [17015.410851] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [17015.431502] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [17015.440017] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [17015.448091] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [17015.456167] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [17015.464237] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [17015.472306] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [17015.480399]  ? native_set_ldt.part.10+0xc0/0xc0
> [17015.485893]  ? smp_call_function_many+0x20a/0x260
> [17015.491563]  ? native_set_ldt.part.10+0xc0/0xc0
> [17015.497054]  on_each_cpu+0x28/0x40
> [17015.501426]  flush_tlb_kernel_range+0x79/0x80
> [17015.506756]  pmd_free_pte_page+0x41/0x60
> [17015.511655]  ioremap_page_range+0x30f/0x560
> [17015.516854]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17015.522112]  __ioremap_caller.constprop.18+0x1a8/0x300
> [17015.528233]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17015.533323]  ? _cond_resched+0x15/0x40
> [17015.538034]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [17015.544108]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [17015.550515]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [17015.557535]  drm_gem_vmap+0x1f/0x60 [drm]
> [17015.562467]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [17015.568278]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [17015.575310]  process_one_work+0x1e5/0x410
> [17015.580273]  worker_thread+0x2d/0x3c0
> [17015.584871]  ? cancel_delayed_work+0x90/0x90
> [17015.590100]  kthread+0x117/0x130
> [17015.594218]  ? kthread_create_worker_on_cpu+0x70/0x70
> [17015.600152]  ret_from_fork+0x22/0x40
> [17020.910905] nfs: server aquaphobie not responding, timed out
> [17020.910915] nfs: server gula not responding, timed out
> [17020.911880] nfs: server botanophobie not responding, timed out
> [17025.007903] nfs: server pappnase not responding, timed out
> [17031.150919] nfs: server aquaphobie not responding, timed out
> [17031.150935] nfs: server gula not responding, timed out
> [17031.151894] nfs: server botanophobie not responding, timed out
> [17035.246913] nfs: server pappnase not responding, timed out
> [17041.391921] nfs: server botanophobie not responding, timed out
> [17041.391926] nfs: server gula not responding, timed out
> [17041.391932] nfs: server aquaphobie not responding, timed out
> [17045.486937] nfs: server pappnase not responding, timed out
> [17051.630957] nfs: server aquaphobie not responding, timed out
> [17051.630969] nfs: server gula not responding, timed out
> [17051.631931] nfs: server botanophobie not responding, timed out
> [17055.726952] nfs: server pappnase not responding, timed out
> [17061.871958] nfs: server botanophobie not responding, timed out
> [17061.871964] nfs: server aquaphobie not responding, timed out
> [17061.871967] nfs: server gula not responding, timed out
> [17065.967070] nfs: server pappnase not responding, timed out
> [17072.110989] nfs: server aquaphobie not responding, timed out
> [17072.111981] nfs: server botanophobie not responding, timed out
> [17072.111984] nfs: server gula not responding, timed out
> [17076.206989] nfs: server pappnase not responding, timed out
> [17082.352005] nfs: server botanophobie not responding, timed out
> [17082.352016] nfs: server gula not responding, timed out
> [17082.352019] nfs: server aquaphobie not responding, timed out
> [17086.447149] nfs: server pappnase not responding, timed out
> [17086.448001] nfs: server afk not responding, timed out
> [17119.216056] nfs: server afk not responding, timed out
> [17139.695140] nfs: server gula not responding, timed out
> [17139.696111] nfs: server botanophobie not responding, timed out
> [17139.696125] nfs: server aquaphobie not responding, timed out
> [17143.792138] nfs: server pappnase not responding, timed out
> [17144.623128] nfs: server aquaphobie not responding, timed out
> [17144.623135] nfs: server gula not responding, timed out
> [17144.624136] nfs: server botanophobie not responding, timed out
> [17148.719164] nfs: server pappnase not responding, timed out
> [17155.055142] nfs: server botanophobie not responding, timed out
> [17155.055147] nfs: server gula not responding, timed out
> [17155.055150] nfs: server aquaphobie not responding, timed out
> [17159.151159] nfs: server pappnase not responding, timed out
> [17165.295170] nfs: server aquaphobie not responding, timed out
> [17165.296158] nfs: server gula not responding, timed out
> [17165.296167] nfs: server botanophobie not responding, timed out
> [17169.392170] nfs: server pappnase not responding, timed out
> [17175.535185] nfs: server aquaphobie not responding, timed out
> [17175.536201] nfs: server botanophobie not responding, timed out
> [17175.536214] nfs: server gula not responding, timed out
> [17179.632192] nfs: server pappnase not responding, timed out
> [17185.775206] nfs: server aquaphobie not responding, timed out
> [17185.776220] nfs: server botanophobie not responding, timed out
> [17185.776223] nfs: server gula not responding, timed out
> [17189.872213] nfs: server pappnase not responding, timed out
> [17195.009085] rcu: INFO: rcu_sched self-detected stall on CPU
> [17195.015787] rcu: 	46-....: (6338576 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1426893 
> [17195.027093] 	(t=6360123 jiffies g=2794673 q=1273611)
> [17195.032924] Sending NMI from CPU 46 to CPUs 5:
> [17195.039247] NMI backtrace for cpu 5
> [17195.039248] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17195.039249] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17195.039250] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [17195.039251] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [17195.039252] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [17195.039253] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [17195.039254] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [17195.039254] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [17195.039255] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [17195.039255] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [17195.039256] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [17195.039257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17195.039257] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [17195.039258] Call Trace:
> [17195.039258]  _raw_spin_lock_irqsave+0x22/0x30
> [17195.039259]  pagevec_lru_move_fn+0x6c/0xd0
> [17195.039259]  activate_page+0xb5/0xc0
> [17195.039259]  mark_page_accessed+0x7a/0x130
> [17195.039260]  generic_file_read_iter+0x4c8/0xae0
> [17195.039260]  ? generic_update_time+0x9c/0xc0
> [17195.039261]  ? pipe_write+0x286/0x400
> [17195.039261]  new_sync_read+0x114/0x1a0
> [17195.039262]  vfs_read+0x89/0x130
> [17195.039262]  ksys_read+0xa1/0xe0
> [17195.039262]  do_syscall_64+0x48/0x130
> [17195.039263]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [17195.039263] RIP: 0033:0x7fc44b933d71
> [17195.039265] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [17195.039265] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [17195.039266] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [17195.039267] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [17195.039268] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [17195.039268] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [17195.039269] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [17195.039294] NMI backtrace for cpu 46
> [17195.301765] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17195.312699] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17195.321280] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [17195.328951] Call Trace:
> [17195.332467]  <IRQ>
> [17195.335571]  dump_stack+0x50/0x6b
> [17195.339921]  nmi_cpu_backtrace+0x89/0x90
> [17195.344860]  ? lapic_can_unplug_cpu+0x90/0x90
> [17195.350246]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [17195.356235]  rcu_dump_cpu_stacks+0x99/0xd0
> [17195.361361]  rcu_sched_clock_irq+0x502/0x770
> [17195.366590]  ? tick_sched_do_timer+0x60/0x60
> [17195.371855]  update_process_times+0x24/0x50
> [17195.376971]  tick_sched_timer+0x37/0x70
> [17195.381759]  __hrtimer_run_queues+0x11f/0x2b0
> [17195.386991]  hrtimer_interrupt+0xe5/0x240
> [17195.391916]  smp_apic_timer_interrupt+0x6f/0x130
> [17195.397389]  apic_timer_interrupt+0xf/0x20
> [17195.402345]  </IRQ>
> [17195.405343] RIP: 0010:smp_call_function_many+0x22f/0x260
> [17195.411501] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [17195.432085] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [17195.440572] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [17195.448644] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [17195.456722] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [17195.464810] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [17195.472896] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [17195.480989]  ? native_set_ldt.part.10+0xc0/0xc0
> [17195.486470]  ? smp_call_function_many+0x20a/0x260
> [17195.492141]  ? native_set_ldt.part.10+0xc0/0xc0
> [17195.497640]  on_each_cpu+0x28/0x40
> [17195.501960]  flush_tlb_kernel_range+0x79/0x80
> [17195.507242]  pmd_free_pte_page+0x41/0x60
> [17195.512111]  ioremap_page_range+0x30f/0x560
> [17195.517265]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17195.522467]  __ioremap_caller.constprop.18+0x1a8/0x300
> [17195.528587]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17195.533677]  ? _cond_resched+0x15/0x40
> [17195.538334]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [17195.544413]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [17195.550826]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [17195.557848]  drm_gem_vmap+0x1f/0x60 [drm]
> [17195.562727]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [17195.568532]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [17195.575563]  process_one_work+0x1e5/0x410
> [17195.580471]  worker_thread+0x2d/0x3c0
> [17195.585078]  ? cancel_delayed_work+0x90/0x90
> [17195.590236]  kthread+0x117/0x130
> [17195.594412]  ? kthread_create_worker_on_cpu+0x70/0x70
> [17195.600340]  ret_from_fork+0x22/0x40
> [17196.015230] nfs: server aquaphobie not responding, timed out
> [17196.016098] nfs: server gula not responding, timed out
> [17196.016246] nfs: server botanophobie not responding, timed out
> [17200.112232] nfs: server pappnase not responding, timed out
> [17206.255237] nfs: server aquaphobie not responding, timed out
> [17206.256118] nfs: server gula not responding, timed out
> [17206.256257] nfs: server botanophobie not responding, timed out
> [17210.352128] nfs: server pappnase not responding, timed out
> [17216.496284] nfs: server gula not responding, timed out
> [17216.496289] nfs: server aquaphobie not responding, timed out
> [17216.496294] nfs: server botanophobie not responding, timed out
> [17220.592274] nfs: server pappnase not responding, timed out
> [17226.735295] nfs: server aquaphobie not responding, timed out
> [17226.736281] nfs: server gula not responding, timed out
> [17226.736286] nfs: server botanophobie not responding, timed out
> [17230.832290] nfs: server pappnase not responding, timed out
> [17236.783300] nfs: server botanophobie not responding, timed out
> [17236.783307] nfs: server gula not responding, timed out
> [17236.784177] nfs: server aquaphobie not responding, timed out
> [17240.879310] nfs: server pappnase not responding, timed out
> [17247.215325] nfs: server gula not responding, timed out
> [17247.216326] nfs: server aquaphobie not responding, timed out
> [17247.216329] nfs: server botanophobie not responding, timed out
> [17251.311337] nfs: server pappnase not responding, timed out
> [17257.455350] nfs: server botanophobie not responding, timed out
> [17257.455352] nfs: server gula not responding, timed out
> [17257.455355] nfs: server aquaphobie not responding, timed out
> [17261.552361] nfs: server pappnase not responding, timed out
> [17267.695386] nfs: server aquaphobie not responding, timed out
> [17267.695401] nfs: server gula not responding, timed out
> [17267.696365] nfs: server botanophobie not responding, timed out
> [17271.791403] nfs: server pappnase not responding, timed out
> [17274.864369] nfs: server afk not responding, timed out
> [17299.439443] nfs: server afk not responding, timed out
> [17319.920474] nfs: server gula not responding, timed out
> [17319.920476] nfs: server botanophobie not responding, timed out
> [17319.920481] nfs: server aquaphobie not responding, timed out
> [17324.015475] nfs: server pappnase not responding, timed out
> [17330.159490] nfs: server aquaphobie not responding, timed out
> [17330.159504] nfs: server gula not responding, timed out
> [17330.160355] nfs: server botanophobie not responding, timed out
> [17334.255535] nfs: server pappnase not responding, timed out
> [17340.399519] nfs: server aquaphobie not responding, timed out
> [17340.399592] nfs: server gula not responding, timed out
> [17340.400487] nfs: server botanophobie not responding, timed out
> [17344.495517] nfs: server pappnase not responding, timed out
> [17350.639539] nfs: server aquaphobie not responding, timed out
> [17350.640526] nfs: server botanophobie not responding, timed out
> [17350.640540] nfs: server gula not responding, timed out
> [17354.736532] nfs: server pappnase not responding, timed out
> [17360.879570] nfs: server botanophobie not responding, timed out
> [17360.879573] nfs: server aquaphobie not responding, timed out
> [17360.880547] nfs: server gula not responding, timed out
> [17364.976644] nfs: server pappnase not responding, timed out
> [17371.119576] nfs: server botanophobie not responding, timed out
> [17371.119582] nfs: server aquaphobie not responding, timed out
> [17371.120561] nfs: server gula not responding, timed out
> [17375.012436] rcu: INFO: rcu_sched self-detected stall on CPU
> [17375.018896] rcu: 	46-....: (6517985 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1467510 
> [17375.030230] 	(t=6540126 jiffies g=2794673 q=1275064)
> [17375.036093] Sending NMI from CPU 46 to CPUs 5:
> [17375.042436] NMI backtrace for cpu 5
> [17375.042437] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17375.042438] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17375.042439] RIP: 0010:queued_spin_lock_slowpath+0x3c/0x1a0
> [17375.042440] Code: e6 00 ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04
> [17375.042441] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [17375.042442] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [17375.042442] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [17375.042443] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [17375.042443] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [17375.042444] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [17375.042445] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [17375.042445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17375.042446] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [17375.042446] Call Trace:
> [17375.042447]  _raw_spin_lock_irqsave+0x22/0x30
> [17375.042447]  pagevec_lru_move_fn+0x6c/0xd0
> [17375.042448]  activate_page+0xb5/0xc0
> [17375.042448]  mark_page_accessed+0x7a/0x130
> [17375.042448]  generic_file_read_iter+0x4c8/0xae0
> [17375.042449]  ? generic_update_time+0x9c/0xc0
> [17375.042449]  ? pipe_write+0x286/0x400
> [17375.042450]  new_sync_read+0x114/0x1a0
> [17375.042450]  vfs_read+0x89/0x130
> [17375.042450]  ksys_read+0xa1/0xe0
> [17375.042451]  do_syscall_64+0x48/0x130
> [17375.042452]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [17375.042452] RIP: 0033:0x7fc44b933d71
> [17375.042453] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [17375.042454] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [17375.042455] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [17375.042455] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [17375.042456] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [17375.042456] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [17375.042457] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [17375.042482] NMI backtrace for cpu 46
> [17375.216571] nfs: server pappnase not responding, timed out
> [17375.220671] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17375.220672] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17375.220681] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [17375.340715] Call Trace:
> [17375.344255]  <IRQ>
> [17375.347347]  dump_stack+0x50/0x6b
> [17375.351735]  nmi_cpu_backtrace+0x89/0x90
> [17375.356696]  ? lapic_can_unplug_cpu+0x90/0x90
> [17375.362082]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [17375.368079]  rcu_dump_cpu_stacks+0x99/0xd0
> [17375.373199]  rcu_sched_clock_irq+0x502/0x770
> [17375.378463]  ? tick_sched_do_timer+0x60/0x60
> [17375.383716]  update_process_times+0x24/0x50
> [17375.388860]  tick_sched_timer+0x37/0x70
> [17375.393615]  __hrtimer_run_queues+0x11f/0x2b0
> [17375.398888]  hrtimer_interrupt+0xe5/0x240
> [17375.403805]  smp_apic_timer_interrupt+0x6f/0x130
> [17375.409329]  apic_timer_interrupt+0xf/0x20
> [17375.414324]  </IRQ>
> [17375.417317] RIP: 0010:smp_call_function_many+0x22d/0x260
> [17375.423549] Code: 89 c7 e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a <f3> 90 8b 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2
> [17375.444162] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [17375.452666] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [17375.460729] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [17375.468800] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [17375.476879] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [17375.484956] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [17375.493040]  ? native_set_ldt.part.10+0xc0/0xc0
> [17375.498554]  ? smp_call_function_many+0x20a/0x260
> [17375.504235]  ? native_set_ldt.part.10+0xc0/0xc0
> [17375.509730]  on_each_cpu+0x28/0x40
> [17375.514109]  flush_tlb_kernel_range+0x79/0x80
> [17375.519444]  pmd_free_pte_page+0x41/0x60
> [17375.524351]  ioremap_page_range+0x30f/0x560
> [17375.529556]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17375.534816]  __ioremap_caller.constprop.18+0x1a8/0x300
> [17375.540937]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17375.545995]  ? _cond_resched+0x15/0x40
> [17375.550680]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [17375.556744]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [17375.563143]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [17375.570165]  drm_gem_vmap+0x1f/0x60 [drm]
> [17375.575113]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [17375.580934]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [17375.587982]  process_one_work+0x1e5/0x410
> [17375.592932]  worker_thread+0x2d/0x3c0
> [17375.597547]  ? cancel_delayed_work+0x90/0x90
> [17375.602727]  kthread+0x117/0x130
> [17375.606853]  ? kthread_create_worker_on_cpu+0x70/0x70
> [17375.612785]  ret_from_fork+0x22/0x40
> [17381.359593] nfs: server botanophobie not responding, timed out
> [17381.359599] nfs: server aquaphobie not responding, timed out
> [17381.360583] nfs: server gula not responding, timed out
> [17385.456628] nfs: server pappnase not responding, timed out
> [17391.599605] nfs: server aquaphobie not responding, timed out
> [17391.600600] nfs: server gula not responding, timed out
> [17391.600603] nfs: server botanophobie not responding, timed out
> [17395.696614] nfs: server pappnase not responding, timed out
> [17401.839626] nfs: server botanophobie not responding, timed out
> [17401.839638] nfs: server aquaphobie not responding, timed out
> [17401.840618] nfs: server gula not responding, timed out
> [17405.936650] nfs: server pappnase not responding, timed out
> [17412.079640] nfs: server aquaphobie not responding, timed out
> [17412.080657] nfs: server botanophobie not responding, timed out
> [17412.080665] nfs: server gula not responding, timed out
> [17416.176685] nfs: server pappnase not responding, timed out
> [17422.320685] nfs: server aquaphobie not responding, timed out
> [17422.320689] nfs: server botanophobie not responding, timed out
> [17422.320696] nfs: server gula not responding, timed out
> [17426.415669] nfs: server pappnase not responding, timed out
> [17432.559681] nfs: server aquaphobie not responding, timed out
> [17432.559690] nfs: server gula not responding, timed out
> [17432.560697] nfs: server botanophobie not responding, timed out
> [17436.655699] nfs: server pappnase not responding, timed out
> [17442.799702] nfs: server aquaphobie not responding, timed out
> [17442.799707] nfs: server botanophobie not responding, timed out
> [17442.799710] nfs: server gula not responding, timed out
> [17446.895716] nfs: server pappnase not responding, timed out
> [17453.039717] nfs: server gula not responding, timed out
> [17453.039720] nfs: server aquaphobie not responding, timed out
> [17453.040744] nfs: server botanophobie not responding, timed out
> [17457.135741] nfs: server pappnase not responding, timed out
> [17463.280735] nfs: server afk not responding, timed out
> [17479.664771] nfs: server afk not responding, timed out
> [17500.143819] nfs: server gula not responding, timed out
> [17500.143823] nfs: server aquaphobie not responding, timed out
> [17500.144806] nfs: server botanophobie not responding, timed out
> [17504.240830] nfs: server pappnase not responding, timed out
> [17505.072827] nfs: server botanophobie not responding, timed out
> [17505.072832] nfs: server aquaphobie not responding, timed out
> [17505.072834] nfs: server gula not responding, timed out
> [17509.167859] nfs: server pappnase not responding, timed out
> [17515.503857] nfs: server aquaphobie not responding, timed out
> [17515.503866] nfs: server gula not responding, timed out
> [17515.504862] nfs: server botanophobie not responding, timed out
> [17519.599851] nfs: server pappnase not responding, timed out
> [17525.743872] nfs: server botanophobie not responding, timed out
> [17525.743886] nfs: server aquaphobie not responding, timed out
> [17525.743892] nfs: server gula not responding, timed out
> [17529.839873] nfs: server pappnase not responding, timed out
> [17535.983876] nfs: server botanophobie not responding, timed out
> [17535.983884] nfs: server gula not responding, timed out
> [17535.983894] nfs: server aquaphobie not responding, timed out
> [17540.079892] nfs: server pappnase not responding, timed out
> [17546.223928] nfs: server aquaphobie not responding, timed out
> [17546.223932] nfs: server gula not responding, timed out
> [17546.224959] nfs: server botanophobie not responding, timed out
> [17550.319939] nfs: server pappnase not responding, timed out
> [17555.015786] rcu: INFO: rcu_sched self-detected stall on CPU
> [17555.022505] rcu: 	46-....: (6697385 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1509360 
> [17555.033837] 	(t=6720129 jiffies g=2794673 q=1276590)
> [17555.039693] Sending NMI from CPU 46 to CPUs 5:
> [17555.046021] NMI backtrace for cpu 5
> [17555.046022] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17555.046023] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17555.046023] RIP: 0010:queued_spin_lock_slowpath+0x3c/0x1a0
> [17555.046025] Code: e6 00 ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04
> [17555.046025] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [17555.046026] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [17555.046027] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [17555.046028] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [17555.046028] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [17555.046029] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [17555.046030] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [17555.046030] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17555.046031] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [17555.046031] Call Trace:
> [17555.046032]  _raw_spin_lock_irqsave+0x22/0x30
> [17555.046032]  pagevec_lru_move_fn+0x6c/0xd0
> [17555.046033]  activate_page+0xb5/0xc0
> [17555.046033]  mark_page_accessed+0x7a/0x130
> [17555.046034]  generic_file_read_iter+0x4c8/0xae0
> [17555.046034]  ? generic_update_time+0x9c/0xc0
> [17555.046034]  ? pipe_write+0x286/0x400
> [17555.046035]  new_sync_read+0x114/0x1a0
> [17555.046035]  vfs_read+0x89/0x130
> [17555.046036]  ksys_read+0xa1/0xe0
> [17555.046036]  do_syscall_64+0x48/0x130
> [17555.046037]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [17555.046037] RIP: 0033:0x7fc44b933d71
> [17555.046038] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [17555.046039] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [17555.046040] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [17555.046041] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [17555.046041] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [17555.046042] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [17555.046042] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [17555.046071] NMI backtrace for cpu 46
> [17555.309900] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17555.320908] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17555.329488] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [17555.337200] Call Trace:
> [17555.340744]  <IRQ>
> [17555.343846]  dump_stack+0x50/0x6b
> [17555.348254]  nmi_cpu_backtrace+0x89/0x90
> [17555.353229]  ? lapic_can_unplug_cpu+0x90/0x90
> [17555.358620]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [17555.364612]  rcu_dump_cpu_stacks+0x99/0xd0
> [17555.369741]  rcu_sched_clock_irq+0x502/0x770
> [17555.375040]  ? tick_sched_do_timer+0x60/0x60
> [17555.380304]  update_process_times+0x24/0x50
> [17555.385477]  tick_sched_timer+0x37/0x70
> [17555.390269]  __hrtimer_run_queues+0x11f/0x2b0
> [17555.395560]  hrtimer_interrupt+0xe5/0x240
> [17555.400482]  smp_apic_timer_interrupt+0x6f/0x130
> [17555.406004]  apic_timer_interrupt+0xf/0x20
> [17555.411009]  </IRQ>
> [17555.414003] RIP: 0010:smp_call_function_many+0x22f/0x260
> [17555.420212] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [17555.440847] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [17555.449355] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [17555.457436] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [17555.465513] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [17555.473594] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [17555.481674] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [17555.489761]  ? native_set_ldt.part.10+0xc0/0xc0
> [17555.495246]  ? smp_call_function_many+0x20a/0x260
> [17555.500911]  ? native_set_ldt.part.10+0xc0/0xc0
> [17555.506414]  on_each_cpu+0x28/0x40
> [17555.510788]  flush_tlb_kernel_range+0x79/0x80
> [17555.516106]  pmd_free_pte_page+0x41/0x60
> [17555.521007]  ioremap_page_range+0x30f/0x560
> [17555.526173]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17555.531437]  __ioremap_caller.constprop.18+0x1a8/0x300
> [17555.537566]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17555.542652]  ? _cond_resched+0x15/0x40
> [17555.547369]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [17555.553450]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [17555.559862]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [17555.566914]  drm_gem_vmap+0x1f/0x60 [drm]
> [17555.571911]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [17555.577766]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [17555.584801]  process_one_work+0x1e5/0x410
> [17555.589751]  worker_thread+0x2d/0x3c0
> [17555.594349]  ? cancel_delayed_work+0x90/0x90
> [17555.599539]  kthread+0x117/0x130
> [17555.603657]  ? kthread_create_worker_on_cpu+0x70/0x70
> [17555.609597]  ret_from_fork+0x22/0x40
> [17556.464932] nfs: server gula not responding, timed out
> [17556.464935] nfs: server botanophobie not responding, timed out
> [17556.464940] nfs: server aquaphobie not responding, timed out
> [17560.560952] nfs: server pappnase not responding, timed out
> [17566.703950] nfs: server botanophobie not responding, timed out
> [17566.703957] nfs: server gula not responding, timed out
> [17566.703959] nfs: server aquaphobie not responding, timed out
> [17570.800021] nfs: server pappnase not responding, timed out
> [17576.943970] nfs: server botanophobie not responding, timed out
> [17576.943989] nfs: server aquaphobie not responding, timed out
> [17576.944007] nfs: server gula not responding, timed out
> [17581.039997] nfs: server pappnase not responding, timed out
> [17587.184005] nfs: server aquaphobie not responding, timed out
> [17587.184986] nfs: server gula not responding, timed out
> [17587.184991] nfs: server botanophobie not responding, timed out
> [17591.280996] nfs: server pappnase not responding, timed out
> [17597.232001] nfs: server botanophobie not responding, timed out
> [17597.232008] nfs: server aquaphobie not responding, timed out
> [17597.232010] nfs: server gula not responding, timed out
> [17601.328884] nfs: server pappnase not responding, timed out
> [17607.664047] nfs: server aquaphobie not responding, timed out
> [17607.665038] nfs: server gula not responding, timed out
> [17607.665044] nfs: server botanophobie not responding, timed out
> [17611.761040] nfs: server pappnase not responding, timed out
> [17617.904065] nfs: server botanophobie not responding, timed out
> [17617.904069] nfs: server aquaphobie not responding, timed out
> [17617.904073] nfs: server gula not responding, timed out
> [17622.000093] nfs: server pappnase not responding, timed out
> [17628.144064] nfs: server aquaphobie not responding, timed out
> [17628.144067] nfs: server botanophobie not responding, timed out
> [17628.144072] nfs: server gula not responding, timed out
> [17632.240080] nfs: server pappnase not responding, timed out
> [17638.384085] nfs: server botanophobie not responding, timed out
> [17638.384090] nfs: server aquaphobie not responding, timed out
> [17638.385116] nfs: server gula not responding, timed out
> [17642.480097] nfs: server pappnase not responding, timed out
> [17651.697106] nfs: server afk not responding, timed out
> [17659.889126] nfs: server afk not responding, timed out
> [17680.368168] nfs: server gula not responding, timed out
> [17680.368178] nfs: server aquaphobie not responding, timed out
> [17680.369159] nfs: server botanophobie not responding, timed out
> [17684.464172] nfs: server pappnase not responding, timed out
> [17690.608188] nfs: server gula not responding, timed out
> [17690.608190] nfs: server botanophobie not responding, timed out
> [17690.609063] nfs: server aquaphobie not responding, timed out
> [17694.704193] nfs: server pappnase not responding, timed out
> [17700.848209] nfs: server gula not responding, timed out
> [17700.849218] nfs: server aquaphobie not responding, timed out
> [17700.849222] nfs: server botanophobie not responding, timed out
> [17704.945088] nfs: server pappnase not responding, timed out
> [17711.088225] nfs: server aquaphobie not responding, timed out
> [17711.088233] nfs: server gula not responding, timed out
> [17711.089105] nfs: server botanophobie not responding, timed out
> [17715.184234] nfs: server pappnase not responding, timed out
> [17721.328255] nfs: server aquaphobie not responding, timed out
> [17721.328257] nfs: server gula not responding, timed out
> [17721.329244] nfs: server botanophobie not responding, timed out
> [17725.424261] nfs: server pappnase not responding, timed out
> [17731.568276] nfs: server aquaphobie not responding, timed out
> [17731.569269] nfs: server gula not responding, timed out
> [17731.569272] nfs: server botanophobie not responding, timed out
> [17735.019139] rcu: INFO: rcu_sched self-detected stall on CPU
> [17735.025876] rcu: 	46-....: (6876791 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1551393 
> [17735.037275] 	(t=6900133 jiffies g=2794673 q=1278258)
> [17735.043204] Sending NMI from CPU 46 to CPUs 5:
> [17735.049534] NMI backtrace for cpu 5
> [17735.049535] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17735.049536] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17735.049537] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [17735.049538] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [17735.049539] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [17735.049540] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [17735.049541] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [17735.049541] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [17735.049542] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [17735.049543] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [17735.049543] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [17735.049544] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17735.049544] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [17735.049545] Call Trace:
> [17735.049545]  _raw_spin_lock_irqsave+0x22/0x30
> [17735.049546]  pagevec_lru_move_fn+0x6c/0xd0
> [17735.049546]  activate_page+0xb5/0xc0
> [17735.049546]  mark_page_accessed+0x7a/0x130
> [17735.049547]  generic_file_read_iter+0x4c8/0xae0
> [17735.049547]  ? generic_update_time+0x9c/0xc0
> [17735.049548]  ? pipe_write+0x286/0x400
> [17735.049548]  new_sync_read+0x114/0x1a0
> [17735.049548]  vfs_read+0x89/0x130
> [17735.049549]  ksys_read+0xa1/0xe0
> [17735.049549]  do_syscall_64+0x48/0x130
> [17735.049550]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [17735.049550] RIP: 0033:0x7fc44b933d71
> [17735.049552] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [17735.049552] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [17735.049553] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [17735.049554] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [17735.049554] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [17735.049555] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [17735.049556] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [17735.049580] NMI backtrace for cpu 46
> [17735.320345] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17735.331639] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17735.340533] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [17735.348544] Call Trace:
> [17735.352387]  <IRQ>
> [17735.355787]  dump_stack+0x50/0x6b
> [17735.360189]  nmi_cpu_backtrace+0x89/0x90
> [17735.365158]  ? lapic_can_unplug_cpu+0x90/0x90
> [17735.370588]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [17735.376532]  rcu_dump_cpu_stacks+0x99/0xd0
> [17735.381603]  rcu_sched_clock_irq+0x502/0x770
> [17735.386889]  ? tick_sched_do_timer+0x60/0x60
> [17735.392103]  update_process_times+0x24/0x50
> [17735.397264]  tick_sched_timer+0x37/0x70
> [17735.402072]  __hrtimer_run_queues+0x11f/0x2b0
> [17735.407355]  ? ixgbe_msix_clean_rings+0x19/0x40 [ixgbe]
> [17735.413497]  hrtimer_interrupt+0xe5/0x240
> [17735.418412]  smp_apic_timer_interrupt+0x6f/0x130
> [17735.423886]  apic_timer_interrupt+0xf/0x20
> [17735.428893]  </IRQ>
> [17735.431822] RIP: 0010:smp_call_function_many+0x22d/0x260
> [17735.438034] Code: 89 c7 e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a <f3> 90 8b 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2
> [17735.458615] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [17735.467073] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [17735.475120] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [17735.483184] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [17735.491269] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [17735.499365] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [17735.507455]  ? native_set_ldt.part.10+0xc0/0xc0
> [17735.512960]  ? smp_call_function_many+0x20a/0x260
> [17735.518578]  ? native_set_ldt.part.10+0xc0/0xc0
> [17735.524024]  on_each_cpu+0x28/0x40
> [17735.528392]  flush_tlb_kernel_range+0x79/0x80
> [17735.533684]  pmd_free_pte_page+0x41/0x60
> [17735.538601]  ioremap_page_range+0x30f/0x560
> [17735.543719]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17735.548979]  __ioremap_caller.constprop.18+0x1a8/0x300
> [17735.555062]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17735.560096]  ? _cond_resched+0x15/0x40
> [17735.564769]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [17735.570782]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [17735.577144]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [17735.584151]  drm_gem_vmap+0x1f/0x60 [drm]
> [17735.589064]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [17735.594857]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [17735.601860]  process_one_work+0x1e5/0x410
> [17735.606814]  worker_thread+0x2d/0x3c0
> [17735.611348]  ? cancel_delayed_work+0x90/0x90
> [17735.616512]  kthread+0x117/0x130
> [17735.620572]  ? kthread_create_worker_on_cpu+0x70/0x70
> [17735.626448]  ret_from_fork+0x22/0x40
> [17735.665365] nfs: server pappnase not responding, timed out
> [17741.808292] nfs: server gula not responding, timed out
> [17741.808300] nfs: server aquaphobie not responding, timed out
> [17741.809290] nfs: server botanophobie not responding, timed out
> [17745.905311] nfs: server pappnase not responding, timed out
> [17752.048333] nfs: server aquaphobie not responding, timed out
> [17752.049309] nfs: server botanophobie not responding, timed out
> [17752.049314] nfs: server gula not responding, timed out
> [17756.145320] nfs: server pappnase not responding, timed out
> [17762.288347] nfs: server aquaphobie not responding, timed out
> [17762.288360] nfs: server gula not responding, timed out
> [17762.289335] nfs: server botanophobie not responding, timed out
> [17766.384349] nfs: server pappnase not responding, timed out
> [17772.528356] nfs: server gula not responding, timed out
> [17772.528361] nfs: server aquaphobie not responding, timed out
> [17772.529341] nfs: server botanophobie not responding, timed out
> [17776.624359] nfs: server pappnase not responding, timed out
> [17782.768367] nfs: server gula not responding, timed out
> [17782.768371] nfs: server botanophobie not responding, timed out
> [17782.768376] nfs: server aquaphobie not responding, timed out
> [17786.864381] nfs: server pappnase not responding, timed out
> [17793.008393] nfs: server aquaphobie not responding, timed out
> [17793.009379] nfs: server gula not responding, timed out
> [17793.009393] nfs: server botanophobie not responding, timed out
> [17797.105404] nfs: server pappnase not responding, timed out
> [17803.248417] nfs: server aquaphobie not responding, timed out
> [17803.249399] nfs: server botanophobie not responding, timed out
> [17803.249408] nfs: server gula not responding, timed out
> [17807.345421] nfs: server pappnase not responding, timed out
> [17813.489433] nfs: server gula not responding, timed out
> [17813.489446] nfs: server botanophobie not responding, timed out
> [17813.489450] nfs: server aquaphobie not responding, timed out
> [17817.585439] nfs: server pappnase not responding, timed out
> [17823.728458] nfs: server botanophobie not responding, timed out
> [17823.728466] nfs: server aquaphobie not responding, timed out
> [17823.729442] nfs: server gula not responding, timed out
> [17827.825460] nfs: server pappnase not responding, timed out
> [17840.113476] nfs: server afk not responding, timed out
> [17840.113482] nfs: server afk not responding, timed out
> [17860.592545] nfs: server aquaphobie not responding, timed out
> [17860.593397] nfs: server gula not responding, timed out
> [17860.593521] nfs: server botanophobie not responding, timed out
> [17864.689550] nfs: server pappnase not responding, timed out
> [17865.520537] nfs: server aquaphobie not responding, timed out
> [17865.520545] nfs: server gula not responding, timed out
> [17865.521526] nfs: server botanophobie not responding, timed out
> [17869.617406] nfs: server pappnase not responding, timed out
> [17875.952555] nfs: server aquaphobie not responding, timed out
> [17875.952652] nfs: server gula not responding, timed out
> [17875.953542] nfs: server botanophobie not responding, timed out
> [17880.049429] nfs: server pappnase not responding, timed out
> [17886.192581] nfs: server aquaphobie not responding, timed out
> [17886.192604] nfs: server gula not responding, timed out
> [17886.193574] nfs: server botanophobie not responding, timed out
> [17890.288576] nfs: server pappnase not responding, timed out
> [17896.433465] nfs: server botanophobie not responding, timed out
> [17896.433608] nfs: server aquaphobie not responding, timed out
> [17896.433618] nfs: server gula not responding, timed out
> [17900.528622] nfs: server pappnase not responding, timed out
> [17906.672620] nfs: server gula not responding, timed out
> [17906.673610] nfs: server aquaphobie not responding, timed out
> [17906.673616] nfs: server botanophobie not responding, timed out
> [17910.768618] nfs: server pappnase not responding, timed out
> [17915.022491] rcu: INFO: rcu_sched self-detected stall on CPU
> [17915.029199] rcu: 	46-....: (7056184 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1593383 
> [17915.040536] 	(t=7080135 jiffies g=2794673 q=1279644)
> [17915.046392] Sending NMI from CPU 46 to CPUs 5:
> [17915.052728] NMI backtrace for cpu 5
> [17915.052729] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17915.052730] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17915.052730] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [17915.052732] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [17915.052732] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [17915.052733] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [17915.052734] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [17915.052735] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [17915.052735] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [17915.052736] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [17915.052736] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [17915.052737] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17915.052738] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [17915.052738] Call Trace:
> [17915.052738]  _raw_spin_lock_irqsave+0x22/0x30
> [17915.052739]  pagevec_lru_move_fn+0x6c/0xd0
> [17915.052739]  activate_page+0xb5/0xc0
> [17915.052740]  mark_page_accessed+0x7a/0x130
> [17915.052740]  generic_file_read_iter+0x4c8/0xae0
> [17915.052741]  ? generic_update_time+0x9c/0xc0
> [17915.052741]  ? pipe_write+0x286/0x400
> [17915.052741]  new_sync_read+0x114/0x1a0
> [17915.052742]  vfs_read+0x89/0x130
> [17915.052742]  ksys_read+0xa1/0xe0
> [17915.052743]  do_syscall_64+0x48/0x130
> [17915.052743]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [17915.052744] RIP: 0033:0x7fc44b933d71
> [17915.052745] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [17915.052745] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [17915.052746] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [17915.052747] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [17915.052748] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [17915.052748] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [17915.052749] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [17915.052777] NMI backtrace for cpu 46
> [17915.322029] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [17915.333381] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [17915.342336] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [17915.350430] Call Trace:
> [17915.354355]  <IRQ>
> [17915.357814]  dump_stack+0x50/0x6b
> [17915.362597]  nmi_cpu_backtrace+0x89/0x90
> [17915.367909]  ? lapic_can_unplug_cpu+0x90/0x90
> [17915.373632]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [17915.379951]  rcu_dump_cpu_stacks+0x99/0xd0
> [17915.385422]  rcu_sched_clock_irq+0x502/0x770
> [17915.391036]  ? tick_sched_do_timer+0x60/0x60
> [17915.396627]  update_process_times+0x24/0x50
> [17915.402109]  tick_sched_timer+0x37/0x70
> [17915.407207]  __hrtimer_run_queues+0x11f/0x2b0
> [17915.412795]  ? ixgbe_msix_clean_rings+0x19/0x40 [ixgbe]
> [17915.419228]  hrtimer_interrupt+0xe5/0x240
> [17915.424438]  smp_apic_timer_interrupt+0x6f/0x130
> [17915.430272]  apic_timer_interrupt+0xf/0x20
> [17915.435610]  </IRQ>
> [17915.438898] RIP: 0010:smp_call_function_many+0x22f/0x260
> [17915.445412] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [17915.466654] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [17915.475492] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [17915.483875] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [17915.492263] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [17915.500659] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [17915.509078] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [17915.517498]  ? native_set_ldt.part.10+0xc0/0xc0
> [17915.523326]  ? smp_call_function_many+0x20a/0x260
> [17915.529339]  ? native_set_ldt.part.10+0xc0/0xc0
> [17915.535185]  on_each_cpu+0x28/0x40
> [17915.539890]  flush_tlb_kernel_range+0x79/0x80
> [17915.545552]  pmd_free_pte_page+0x41/0x60
> [17915.550796]  ioremap_page_range+0x30f/0x560
> [17915.556314]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17915.561900]  __ioremap_caller.constprop.18+0x1a8/0x300
> [17915.568376]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [17915.573776]  ? _cond_resched+0x15/0x40
> [17915.578776]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [17915.585148]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [17915.591866]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [17915.599199]  drm_gem_vmap+0x1f/0x60 [drm]
> [17915.604451]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [17915.610616]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [17915.617985]  process_one_work+0x1e5/0x410
> [17915.623262]  worker_thread+0x2d/0x3c0
> [17915.628156]  ? cancel_delayed_work+0x90/0x90
> [17915.633624]  kthread+0x117/0x130
> [17915.638035]  ? kthread_create_worker_on_cpu+0x70/0x70
> [17915.644270]  ret_from_fork+0x22/0x40
> [17916.912627] nfs: server aquaphobie not responding, timed out
> [17916.912630] nfs: server gula not responding, timed out
> [17916.913642] nfs: server botanophobie not responding, timed out
> [17921.008637] nfs: server pappnase not responding, timed out
> [17927.152650] nfs: server aquaphobie not responding, timed out
> [17927.152653] nfs: server gula not responding, timed out
> [17927.153668] nfs: server botanophobie not responding, timed out
> [17931.248670] nfs: server pappnase not responding, timed out
> [17937.392669] nfs: server gula not responding, timed out
> [17937.392676] nfs: server aquaphobie not responding, timed out
> [17937.393672] nfs: server botanophobie not responding, timed out
> [17941.488680] nfs: server pappnase not responding, timed out
> [17947.632688] nfs: server gula not responding, timed out
> [17947.632695] nfs: server aquaphobie not responding, timed out
> [17947.633700] nfs: server botanophobie not responding, timed out
> [17951.728702] nfs: server pappnase not responding, timed out
> [17957.681714] nfs: server gula not responding, timed out
> [17957.681729] nfs: server botanophobie not responding, timed out
> [17957.681733] nfs: server aquaphobie not responding, timed out
> [17961.776719] nfs: server pappnase not responding, timed out
> [17968.112733] nfs: server gula not responding, timed out
> [17968.112742] nfs: server botanophobie not responding, timed out
> [17968.112744] nfs: server aquaphobie not responding, timed out
> [17972.208745] nfs: server pappnase not responding, timed out
> [17978.352770] nfs: server aquaphobie not responding, timed out
> [17978.352780] nfs: server gula not responding, timed out
> [17978.353756] nfs: server botanophobie not responding, timed out
> [17982.448767] nfs: server pappnase not responding, timed out
> [17988.592788] nfs: server gula not responding, timed out
> [17988.592791] nfs: server aquaphobie not responding, timed out
> [17988.593777] nfs: server botanophobie not responding, timed out
> [17992.688783] nfs: server pappnase not responding, timed out
> [17998.833792] nfs: server gula not responding, timed out
> [17998.833813] nfs: server botanophobie not responding, timed out
> [17998.833818] nfs: server aquaphobie not responding, timed out
> [18002.929807] nfs: server pappnase not responding, timed out
> [18009.073811] nfs: server botanophobie not responding, timed out
> [18009.073816] nfs: server aquaphobie not responding, timed out
> [18009.073819] nfs: server gula not responding, timed out
> [18013.169829] nfs: server pappnase not responding, timed out
> [18020.337829] nfs: server afk not responding, timed out
> [18025.265825] nfs: server afk not responding, timed out
> [18040.816902] nfs: server gula not responding, timed out
> [18040.816909] nfs: server aquaphobie not responding, timed out
> [18040.817865] nfs: server botanophobie not responding, timed out
> [18044.912920] nfs: server pappnase not responding, timed out
> [18051.056924] nfs: server aquaphobie not responding, timed out
> [18051.056928] nfs: server gula not responding, timed out
> [18051.057891] nfs: server botanophobie not responding, timed out
> [18055.152940] nfs: server pappnase not responding, timed out
> [18061.296926] nfs: server botanophobie not responding, timed out
> [18061.296934] nfs: server aquaphobie not responding, timed out
> [18061.296943] nfs: server gula not responding, timed out
> [18065.393926] nfs: server pappnase not responding, timed out
> [18071.536948] nfs: server aquaphobie not responding, timed out
> [18071.536956] nfs: server botanophobie not responding, timed out
> [18071.537925] nfs: server gula not responding, timed out
> [18075.633946] nfs: server pappnase not responding, timed out
> [18081.777955] nfs: server botanophobie not responding, timed out
> [18081.777961] nfs: server gula not responding, timed out
> [18081.777976] nfs: server aquaphobie not responding, timed out
> [18085.873991] nfs: server pappnase not responding, timed out
> [18092.016983] nfs: server aquaphobie not responding, timed out
> [18092.017975] nfs: server gula not responding, timed out
> [18092.017990] nfs: server botanophobie not responding, timed out
> [18095.025844] rcu: INFO: rcu_sched self-detected stall on CPU
> [18095.032754] rcu: 	46-....: (7235562 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1633990 
> [18095.044311] 	(t=7260139 jiffies g=2794673 q=1280958)
> [18095.050447] Sending NMI from CPU 46 to CPUs 5:
> [18095.057058] NMI backtrace for cpu 5
> [18095.057059] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18095.057060] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18095.057060] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [18095.057062] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [18095.057062] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [18095.057064] RAX: 0000000000740101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [18095.057064] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [18095.057065] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [18095.057065] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [18095.057066] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [18095.057067] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [18095.057067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [18095.057068] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [18095.057068] Call Trace:
> [18095.057069]  _raw_spin_lock_irqsave+0x22/0x30
> [18095.057069]  pagevec_lru_move_fn+0x6c/0xd0
> [18095.057069]  activate_page+0xb5/0xc0
> [18095.057070]  mark_page_accessed+0x7a/0x130
> [18095.057070]  generic_file_read_iter+0x4c8/0xae0
> [18095.057071]  ? generic_update_time+0x9c/0xc0
> [18095.057071]  ? pipe_write+0x286/0x400
> [18095.057072]  new_sync_read+0x114/0x1a0
> [18095.057072]  vfs_read+0x89/0x130
> [18095.057072]  ksys_read+0xa1/0xe0
> [18095.057073]  do_syscall_64+0x48/0x130
> [18095.057073]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [18095.057074] RIP: 0033:0x7fc44b933d71
> [18095.057075] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [18095.057075] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [18095.057077] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [18095.057078] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [18095.057078] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [18095.057079] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [18095.057079] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [18095.057103] NMI backtrace for cpu 46
> [18095.331525] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18095.342842] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18095.351724] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [18095.359763] Call Trace:
> [18095.363641]  <IRQ>
> [18095.367046]  dump_stack+0x50/0x6b
> [18095.371743]  nmi_cpu_backtrace+0x89/0x90
> [18095.377038]  ? lapic_can_unplug_cpu+0x90/0x90
> [18095.382703]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [18095.388962]  rcu_dump_cpu_stacks+0x99/0xd0
> [18095.394345]  rcu_sched_clock_irq+0x502/0x770
> [18095.399971]  ? tick_sched_do_timer+0x60/0x60
> [18095.405554]  update_process_times+0x24/0x50
> [18095.410980]  tick_sched_timer+0x37/0x70
> [18095.416031]  __hrtimer_run_queues+0x11f/0x2b0
> [18095.421627]  hrtimer_interrupt+0xe5/0x240
> [18095.426790]  smp_apic_timer_interrupt+0x6f/0x130
> [18095.432565]  apic_timer_interrupt+0xf/0x20
> [18095.437842]  </IRQ>
> [18095.441120] RIP: 0010:smp_call_function_many+0x22f/0x260
> [18095.447574] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [18095.468729] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [18095.477509] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [18095.485857] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [18095.494235] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [18095.502629] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [18095.510990] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [18095.519341]  ? native_set_ldt.part.10+0xc0/0xc0
> [18095.525096]  ? smp_call_function_many+0x20a/0x260
> [18095.531037]  ? native_set_ldt.part.10+0xc0/0xc0
> [18095.536801]  on_each_cpu+0x28/0x40
> [18095.541449]  flush_tlb_kernel_range+0x79/0x80
> [18095.547040]  pmd_free_pte_page+0x41/0x60
> [18095.552201]  ioremap_page_range+0x30f/0x560
> [18095.557704]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18095.563253]  __ioremap_caller.constprop.18+0x1a8/0x300
> [18095.569648]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18095.575039]  ? _cond_resched+0x15/0x40
> [18095.580019]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [18095.586389]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [18095.593117]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [18095.600389]  drm_gem_vmap+0x1f/0x60 [drm]
> [18095.605636]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [18095.611715]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [18095.619040]  process_one_work+0x1e5/0x410
> [18095.624273]  worker_thread+0x2d/0x3c0
> [18095.629191]  ? cancel_delayed_work+0x90/0x90
> [18095.634627]  kthread+0x117/0x130
> [18095.639016]  ? kthread_create_worker_on_cpu+0x70/0x70
> [18095.645191]  ret_from_fork+0x22/0x40
> [18096.113999] nfs: server pappnase not responding, timed out
> [18102.257002] nfs: server aquaphobie not responding, timed out
> [18102.257989] nfs: server botanophobie not responding, timed out
> [18102.257995] nfs: server gula not responding, timed out
> [18106.354033] nfs: server pappnase not responding, timed out
> [18112.497014] nfs: server aquaphobie not responding, timed out
> [18112.498012] nfs: server gula not responding, timed out
> [18112.498020] nfs: server botanophobie not responding, timed out
> [18116.594050] nfs: server pappnase not responding, timed out
> [18122.737040] nfs: server aquaphobie not responding, timed out
> [18122.738057] nfs: server botanophobie not responding, timed out
> [18122.738061] nfs: server gula not responding, timed out
> [18126.834032] nfs: server pappnase not responding, timed out
> [18132.977928] nfs: server botanophobie not responding, timed out
> [18132.978072] nfs: server aquaphobie not responding, timed out
> [18132.978081] nfs: server gula not responding, timed out
> [18137.074072] nfs: server pappnase not responding, timed out
> [18143.217083] nfs: server gula not responding, timed out
> [18143.218071] nfs: server botanophobie not responding, timed out
> [18143.218076] nfs: server aquaphobie not responding, timed out
> [18147.314108] nfs: server pappnase not responding, timed out
> [18153.457099] nfs: server gula not responding, timed out
> [18153.457108] nfs: server aquaphobie not responding, timed out
> [18153.458115] nfs: server botanophobie not responding, timed out
> [18157.553112] nfs: server pappnase not responding, timed out
> [18163.697121] nfs: server gula not responding, timed out
> [18163.697123] nfs: server aquaphobie not responding, timed out
> [18163.698120] nfs: server botanophobie not responding, timed out
> [18167.793131] nfs: server pappnase not responding, timed out
> [18173.937145] nfs: server gula not responding, timed out
> [18173.938008] nfs: server botanophobie not responding, timed out
> [18173.938150] nfs: server aquaphobie not responding, timed out
> [18178.033152] nfs: server pappnase not responding, timed out
> [18184.177155] nfs: server aquaphobie not responding, timed out
> [18184.177159] nfs: server gula not responding, timed out
> [18184.178155] nfs: server botanophobie not responding, timed out
> [18188.273174] nfs: server pappnase not responding, timed out
> [18194.417182] nfs: server aquaphobie not responding, timed out
> [18194.417185] nfs: server gula not responding, timed out
> [18194.418200] nfs: server botanophobie not responding, timed out
> [18198.513207] nfs: server pappnase not responding, timed out
> [18200.562173] nfs: server afk not responding, timed out
> [18210.802193] nfs: server afk not responding, timed out
> [18221.041244] nfs: server aquaphobie not responding, timed out
> [18221.042228] nfs: server gula not responding, timed out
> [18221.042242] nfs: server botanophobie not responding, timed out
> [18225.138244] nfs: server pappnase not responding, timed out
> [18225.969240] nfs: server aquaphobie not responding, timed out
> [18225.969244] nfs: server gula not responding, timed out
> [18225.970223] nfs: server botanophobie not responding, timed out
> [18230.066243] nfs: server pappnase not responding, timed out
> [18236.401260] nfs: server botanophobie not responding, timed out
> [18236.401267] nfs: server aquaphobie not responding, timed out
> [18236.402128] nfs: server gula not responding, timed out
> [18240.497274] nfs: server pappnase not responding, timed out
> [18246.642276] nfs: server aquaphobie not responding, timed out
> [18246.642279] nfs: server gula not responding, timed out
> [18246.642281] nfs: server botanophobie not responding, timed out
> [18250.738281] nfs: server pappnase not responding, timed out
> [18256.881304] nfs: server botanophobie not responding, timed out
> [18256.881341] nfs: server aquaphobie not responding, timed out
> [18256.882286] nfs: server gula not responding, timed out
> [18260.978296] nfs: server pappnase not responding, timed out
> [18267.122310] nfs: server botanophobie not responding, timed out
> [18267.122315] nfs: server gula not responding, timed out
> [18267.122320] nfs: server aquaphobie not responding, timed out
> [18271.218319] nfs: server pappnase not responding, timed out
> [18275.029194] rcu: INFO: rcu_sched self-detected stall on CPU
> [18275.035921] rcu: 	46-....: (7414942 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1675684 
> [18275.047326] 	(t=7440142 jiffies g=2794673 q=1282345)
> [18275.053197] Sending NMI from CPU 46 to CPUs 5:
> [18275.059507] NMI backtrace for cpu 5
> [18275.059508] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18275.059509] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18275.059509] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [18275.059511] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [18275.059511] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [18275.059513] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [18275.059513] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [18275.059514] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [18275.059514] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [18275.059515] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [18275.059516] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [18275.059516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [18275.059517] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [18275.059517] Call Trace:
> [18275.059517]  _raw_spin_lock_irqsave+0x22/0x30
> [18275.059518]  pagevec_lru_move_fn+0x6c/0xd0
> [18275.059518]  activate_page+0xb5/0xc0
> [18275.059519]  mark_page_accessed+0x7a/0x130
> [18275.059519]  generic_file_read_iter+0x4c8/0xae0
> [18275.059520]  ? generic_update_time+0x9c/0xc0
> [18275.059520]  ? pipe_write+0x286/0x400
> [18275.059521]  new_sync_read+0x114/0x1a0
> [18275.059521]  vfs_read+0x89/0x130
> [18275.059521]  ksys_read+0xa1/0xe0
> [18275.059522]  do_syscall_64+0x48/0x130
> [18275.059522]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [18275.059523] RIP: 0033:0x7fc44b933d71
> [18275.059524] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [18275.059524] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [18275.059525] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [18275.059526] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [18275.059527] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [18275.059527] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [18275.059528] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [18275.059553] NMI backtrace for cpu 46
> [18275.333224] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18275.344571] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18275.353460] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [18275.361542] Call Trace:
> [18275.365448]  <IRQ>
> [18275.368905]  dump_stack+0x50/0x6b
> [18275.373245]  nmi_cpu_backtrace+0x89/0x90
> [18275.378221]  ? lapic_can_unplug_cpu+0x90/0x90
> [18275.383560]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [18275.389557]  rcu_dump_cpu_stacks+0x99/0xd0
> [18275.394690]  rcu_sched_clock_irq+0x502/0x770
> [18275.399921]  ? tick_sched_do_timer+0x60/0x60
> [18275.405197]  update_process_times+0x24/0x50
> [18275.410340]  tick_sched_timer+0x37/0x70
> [18275.415124]  __hrtimer_run_queues+0x11f/0x2b0
> [18275.420385]  hrtimer_interrupt+0xe5/0x240
> [18275.425319]  smp_apic_timer_interrupt+0x6f/0x130
> [18275.430840]  apic_timer_interrupt+0xf/0x20
> [18275.435789]  </IRQ>
> [18275.438785] RIP: 0010:smp_call_function_many+0x22f/0x260
> [18275.444932] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [18275.465532] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [18275.474033] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [18275.482113] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [18275.490175] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [18275.498238] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [18275.506309] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [18275.514362]  ? native_set_ldt.part.10+0xc0/0xc0
> [18275.519823]  ? smp_call_function_many+0x20a/0x260
> [18275.525493]  ? native_set_ldt.part.10+0xc0/0xc0
> [18275.530990]  on_each_cpu+0x28/0x40
> [18275.535321]  flush_tlb_kernel_range+0x79/0x80
> [18275.540650]  pmd_free_pte_page+0x41/0x60
> [18275.545493]  ioremap_page_range+0x30f/0x560
> [18275.550671]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18275.555873]  __ioremap_caller.constprop.18+0x1a8/0x300
> [18275.562012]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18275.567096]  ? _cond_resched+0x15/0x40
> [18275.571771]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [18275.577852]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [18275.584297]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [18275.591327]  drm_gem_vmap+0x1f/0x60 [drm]
> [18275.596318]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [18275.602082]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [18275.609119]  process_one_work+0x1e5/0x410
> [18275.614051]  worker_thread+0x2d/0x3c0
> [18275.618652]  ? cancel_delayed_work+0x90/0x90
> [18275.623784]  kthread+0x117/0x130
> [18275.627898]  ? kthread_create_worker_on_cpu+0x70/0x70
> [18275.633836]  ret_from_fork+0x22/0x40
> [18277.362341] nfs: server aquaphobie not responding, timed out
> [18277.362344] nfs: server gula not responding, timed out
> [18277.362372] nfs: server botanophobie not responding, timed out
> [18281.458346] nfs: server pappnase not responding, timed out
> [18287.602346] nfs: server botanophobie not responding, timed out
> [18287.602351] nfs: server gula not responding, timed out
> [18287.602354] nfs: server aquaphobie not responding, timed out
> [18291.698366] nfs: server pappnase not responding, timed out
> [18297.842256] nfs: server botanophobie not responding, timed out
> [18297.842369] nfs: server gula not responding, timed out
> [18297.842378] nfs: server aquaphobie not responding, timed out
> [18301.938387] nfs: server pappnase not responding, timed out
> [18308.082389] nfs: server gula not responding, timed out
> [18308.082391] nfs: server botanophobie not responding, timed out
> [18308.082396] nfs: server aquaphobie not responding, timed out
> [18312.178404] nfs: server pappnase not responding, timed out
> [18318.129435] nfs: server aquaphobie not responding, timed out
> [18318.129439] nfs: server gula not responding, timed out
> [18318.130289] nfs: server botanophobie not responding, timed out
> [18322.226295] nfs: server pappnase not responding, timed out
> [18328.562419] nfs: server botanophobie not responding, timed out
> [18328.562424] nfs: server gula not responding, timed out
> [18328.562440] nfs: server aquaphobie not responding, timed out
> [18332.658444] nfs: server pappnase not responding, timed out
> [18338.802444] nfs: server botanophobie not responding, timed out
> [18338.802448] nfs: server aquaphobie not responding, timed out
> [18338.802455] nfs: server gula not responding, timed out
> [18342.898477] nfs: server pappnase not responding, timed out
> [18349.042468] nfs: server botanophobie not responding, timed out
> [18349.042470] nfs: server gula not responding, timed out
> [18349.042475] nfs: server aquaphobie not responding, timed out
> [18353.137493] nfs: server pappnase not responding, timed out
> [18359.281506] nfs: server gula not responding, timed out
> [18359.282483] nfs: server botanophobie not responding, timed out
> [18359.282495] nfs: server aquaphobie not responding, timed out
> [18363.377512] nfs: server pappnase not responding, timed out
> [18369.522515] nfs: server aquaphobie not responding, timed out
> [18369.522518] nfs: server botanophobie not responding, timed out
> [18369.522522] nfs: server gula not responding, timed out
> [18373.617531] nfs: server pappnase not responding, timed out
> [18379.761546] nfs: server gula not responding, timed out
> [18379.762533] nfs: server aquaphobie not responding, timed out
> [18379.762536] nfs: server botanophobie not responding, timed out
> [18380.786546] nfs: server afk not responding, timed out
> [18383.857545] nfs: server pappnase not responding, timed out
> [18396.146564] nfs: server afk not responding, timed out
> [18401.265591] nfs: server gula not responding, timed out
> [18401.266569] nfs: server botanophobie not responding, timed out
> [18401.266575] nfs: server aquaphobie not responding, timed out
> [18405.361595] nfs: server pappnase not responding, timed out
> [18411.505608] nfs: server gula not responding, timed out
> [18411.506471] nfs: server aquaphobie not responding, timed out
> [18411.506473] nfs: server botanophobie not responding, timed out
> [18415.601611] nfs: server pappnase not responding, timed out
> [18421.745626] nfs: server gula not responding, timed out
> [18421.746619] nfs: server botanophobie not responding, timed out
> [18421.746622] nfs: server aquaphobie not responding, timed out
> [18425.841638] nfs: server pappnase not responding, timed out
> [18431.985642] nfs: server aquaphobie not responding, timed out
> [18431.985647] nfs: server gula not responding, timed out
> [18431.986515] nfs: server botanophobie not responding, timed out
> [18436.081653] nfs: server pappnase not responding, timed out
> [18442.225676] nfs: server aquaphobie not responding, timed out
> [18442.226649] nfs: server botanophobie not responding, timed out
> [18446.322659] nfs: server pappnase not responding, timed out
> [18452.465687] nfs: server gula not responding, timed out
> [18452.465694] nfs: server aquaphobie not responding, timed out
> [18452.466663] nfs: server botanophobie not responding, timed out
> [18455.032545] rcu: INFO: rcu_sched self-detected stall on CPU
> [18455.039003] rcu: 	46-....: (7594337 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1716051 
> [18455.050339] 	(t=7620144 jiffies g=2794673 q=1283027)
> [18455.056202] Sending NMI from CPU 46 to CPUs 5:
> [18455.062549] NMI backtrace for cpu 5
> [18455.062550] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18455.062551] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18455.062551] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [18455.062553] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [18455.062553] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [18455.062554] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [18455.062555] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [18455.062556] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [18455.062556] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [18455.062557] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [18455.062558] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [18455.062558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [18455.062559] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [18455.062559] Call Trace:
> [18455.062560]  _raw_spin_lock_irqsave+0x22/0x30
> [18455.062560]  pagevec_lru_move_fn+0x6c/0xd0
> [18455.062560]  activate_page+0xb5/0xc0
> [18455.062561]  mark_page_accessed+0x7a/0x130
> [18455.062561]  generic_file_read_iter+0x4c8/0xae0
> [18455.062562]  ? generic_update_time+0x9c/0xc0
> [18455.062562]  ? pipe_write+0x286/0x400
> [18455.062563]  new_sync_read+0x114/0x1a0
> [18455.062563]  vfs_read+0x89/0x130
> [18455.062564]  ksys_read+0xa1/0xe0
> [18455.062564]  do_syscall_64+0x48/0x130
> [18455.062565]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [18455.062565] RIP: 0033:0x7fc44b933d71
> [18455.062566] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [18455.062567] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [18455.062568] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [18455.062568] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [18455.062569] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [18455.062570] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [18455.062570] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [18455.062594] NMI backtrace for cpu 46
> [18455.326675] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18455.337667] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18455.346251] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [18455.353960] Call Trace:
> [18455.357509]  <IRQ>
> [18455.360668]  dump_stack+0x50/0x6b
> [18455.365067]  nmi_cpu_backtrace+0x89/0x90
> [18455.370049]  ? lapic_can_unplug_cpu+0x90/0x90
> [18455.375435]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [18455.381433]  rcu_dump_cpu_stacks+0x99/0xd0
> [18455.386555]  rcu_sched_clock_irq+0x502/0x770
> [18455.391848]  ? tick_sched_do_timer+0x60/0x60
> [18455.397109]  update_process_times+0x24/0x50
> [18455.402274]  tick_sched_timer+0x37/0x70
> [18455.407071]  __hrtimer_run_queues+0x11f/0x2b0
> [18455.412362]  hrtimer_interrupt+0xe5/0x240
> [18455.417281]  smp_apic_timer_interrupt+0x6f/0x130
> [18455.422814]  apic_timer_interrupt+0xf/0x20
> [18455.427818]  </IRQ>
> [18455.430815] RIP: 0010:smp_call_function_many+0x22f/0x260
> [18455.437020] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [18455.457663] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [18455.466207] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [18455.474291] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [18455.482367] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [18455.490445] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [18455.498522] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [18455.506604]  ? native_set_ldt.part.10+0xc0/0xc0
> [18455.512109]  ? smp_call_function_many+0x20a/0x260
> [18455.517770]  ? native_set_ldt.part.10+0xc0/0xc0
> [18455.523262]  on_each_cpu+0x28/0x40
> [18455.527655]  flush_tlb_kernel_range+0x79/0x80
> [18455.533003]  pmd_free_pte_page+0x41/0x60
> [18455.537903]  ioremap_page_range+0x30f/0x560
> [18455.543057]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18455.548319]  __ioremap_caller.constprop.18+0x1a8/0x300
> [18455.554456]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18455.559548]  ? _cond_resched+0x15/0x40
> [18455.564248]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [18455.570330]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [18455.576749]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [18455.583771]  drm_gem_vmap+0x1f/0x60 [drm]
> [18455.588703]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [18455.594525]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [18455.601567]  process_one_work+0x1e5/0x410
> [18455.606518]  worker_thread+0x2d/0x3c0
> [18455.611111]  ? cancel_delayed_work+0x90/0x90
> [18455.616303]  kthread+0x117/0x130
> [18455.620431]  ? kthread_create_worker_on_cpu+0x70/0x70
> [18455.626367]  ret_from_fork+0x22/0x40
> [18456.562678] nfs: server pappnase not responding, timed out
> [18462.705750] nfs: server aquaphobie not responding, timed out
> [18462.706672] nfs: server botanophobie not responding, timed out
> [18462.706689] nfs: server gula not responding, timed out
> [18466.802715] nfs: server pappnase not responding, timed out
> [18472.945733] nfs: server aquaphobie not responding, timed out
> [18472.945744] nfs: server gula not responding, timed out
> [18472.946714] nfs: server botanophobie not responding, timed out
> [18477.041782] nfs: server pappnase not responding, timed out
> [18483.186729] nfs: server botanophobie not responding, timed out
> [18483.186735] nfs: server gula not responding, timed out
> [18483.186744] nfs: server aquaphobie not responding, timed out
> [18487.281835] nfs: server pappnase not responding, timed out
> [18493.425769] nfs: server gula not responding, timed out
> [18493.426751] nfs: server botanophobie not responding, timed out
> [18493.426753] nfs: server aquaphobie not responding, timed out
> [18497.521777] nfs: server pappnase not responding, timed out
> [18503.665783] nfs: server gula not responding, timed out
> [18503.666777] nfs: server aquaphobie not responding, timed out
> [18503.666782] nfs: server botanophobie not responding, timed out
> [18507.761795] nfs: server pappnase not responding, timed out
> [18513.906792] nfs: server gula not responding, timed out
> [18513.906795] nfs: server botanophobie not responding, timed out
> [18513.906799] nfs: server aquaphobie not responding, timed out
> [18518.002803] nfs: server pappnase not responding, timed out
> [18524.146815] nfs: server botanophobie not responding, timed out
> [18524.146821] nfs: server gula not responding, timed out
> [18524.146824] nfs: server aquaphobie not responding, timed out
> [18528.242834] nfs: server pappnase not responding, timed out
> [18534.385845] nfs: server gula not responding, timed out
> [18534.386836] nfs: server botanophobie not responding, timed out
> [18534.386843] nfs: server aquaphobie not responding, timed out
> [18538.481872] nfs: server pappnase not responding, timed out
> [18544.625867] nfs: server gula not responding, timed out
> [18544.625884] nfs: server aquaphobie not responding, timed out
> [18544.626849] nfs: server botanophobie not responding, timed out
> [18548.721907] nfs: server pappnase not responding, timed out
> [18554.865882] nfs: server gula not responding, timed out
> [18554.865884] nfs: server aquaphobie not responding, timed out
> [18554.866772] nfs: server botanophobie not responding, timed out
> [18558.962047] nfs: server pappnase not responding, timed out
> [18561.010885] nfs: server afk not responding, timed out
> [18565.105910] nfs: server gula not responding, timed out
> [18565.105912] nfs: server aquaphobie not responding, timed out
> [18565.106888] nfs: server botanophobie not responding, timed out
> [18569.201919] nfs: server pappnase not responding, timed out
> [18581.489941] nfs: server gula not responding, timed out
> [18581.489944] nfs: server aquaphobie not responding, timed out
> [18581.490911] nfs: server afk not responding, timed out
> [18581.490924] nfs: server botanophobie not responding, timed out
> [18585.585950] nfs: server pappnase not responding, timed out
> [18586.417943] nfs: server botanophobie not responding, timed out
> [18586.417946] nfs: server aquaphobie not responding, timed out
> [18586.417951] nfs: server gula not responding, timed out
> [18590.513955] nfs: server pappnase not responding, timed out
> [18596.849967] nfs: server gula not responding, timed out
> [18596.849973] nfs: server aquaphobie not responding, timed out
> [18596.850963] nfs: server botanophobie not responding, timed out
> [18600.945981] nfs: server pappnase not responding, timed out
> [18607.090856] nfs: server botanophobie not responding, timed out
> [18607.090974] nfs: server gula not responding, timed out
> [18607.090978] nfs: server aquaphobie not responding, timed out
> [18611.186981] nfs: server pappnase not responding, timed out
> [18617.330976] nfs: server botanophobie not responding, timed out
> [18617.330996] nfs: server aquaphobie not responding, timed out
> [18617.331013] nfs: server gula not responding, timed out
> [18621.427004] nfs: server pappnase not responding, timed out
> [18627.570034] nfs: server aquaphobie not responding, timed out
> [18627.570897] nfs: server botanophobie not responding, timed out
> [18627.571036] nfs: server gula not responding, timed out
> [18631.667034] nfs: server pappnase not responding, timed out
> [18635.035899] rcu: INFO: rcu_sched self-detected stall on CPU
> [18635.042630] rcu: 	46-....: (7773743 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1756517 
> [18635.053988] 	(t=7800147 jiffies g=2794673 q=1283690)
> [18635.059861] Sending NMI from CPU 46 to CPUs 5:
> [18635.066209] NMI backtrace for cpu 5
> [18635.066210] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18635.066211] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18635.066211] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [18635.066213] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [18635.066213] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [18635.066214] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [18635.066215] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [18635.066216] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [18635.066216] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [18635.066217] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [18635.066217] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [18635.066218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [18635.066219] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [18635.066219] Call Trace:
> [18635.066219]  _raw_spin_lock_irqsave+0x22/0x30
> [18635.066220]  pagevec_lru_move_fn+0x6c/0xd0
> [18635.066220]  activate_page+0xb5/0xc0
> [18635.066221]  mark_page_accessed+0x7a/0x130
> [18635.066221]  generic_file_read_iter+0x4c8/0xae0
> [18635.066222]  ? generic_update_time+0x9c/0xc0
> [18635.066222]  ? pipe_write+0x286/0x400
> [18635.066222]  new_sync_read+0x114/0x1a0
> [18635.066223]  vfs_read+0x89/0x130
> [18635.066223]  ksys_read+0xa1/0xe0
> [18635.066224]  do_syscall_64+0x48/0x130
> [18635.066224]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [18635.066225] RIP: 0033:0x7fc44b933d71
> [18635.066226] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [18635.066226] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [18635.066227] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [18635.066228] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [18635.066229] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [18635.066229] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [18635.066230] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [18635.066254] NMI backtrace for cpu 46
> [18635.330314] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18635.341314] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18635.349912] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [18635.357624] Call Trace:
> [18635.361175]  <IRQ>
> [18635.364279]  dump_stack+0x50/0x6b
> [18635.368666]  nmi_cpu_backtrace+0x89/0x90
> [18635.373645]  ? lapic_can_unplug_cpu+0x90/0x90
> [18635.379027]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [18635.385024]  rcu_dump_cpu_stacks+0x99/0xd0
> [18635.390155]  rcu_sched_clock_irq+0x502/0x770
> [18635.395437]  ? tick_sched_do_timer+0x60/0x60
> [18635.400711]  update_process_times+0x24/0x50
> [18635.405873]  tick_sched_timer+0x37/0x70
> [18635.410653]  __hrtimer_run_queues+0x11f/0x2b0
> [18635.415935]  hrtimer_interrupt+0xe5/0x240
> [18635.420846]  smp_apic_timer_interrupt+0x6f/0x130
> [18635.426370]  apic_timer_interrupt+0xf/0x20
> [18635.431375]  </IRQ>
> [18635.434371] RIP: 0010:smp_call_function_many+0x22f/0x260
> [18635.440581] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [18635.461221] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [18635.469742] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [18635.477819] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [18635.485900] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [18635.494008] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [18635.502122] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [18635.510218]  ? native_set_ldt.part.10+0xc0/0xc0
> [18635.515712]  ? smp_call_function_many+0x20a/0x260
> [18635.521380]  ? native_set_ldt.part.10+0xc0/0xc0
> [18635.526872]  on_each_cpu+0x28/0x40
> [18635.531234]  flush_tlb_kernel_range+0x79/0x80
> [18635.536562]  pmd_free_pte_page+0x41/0x60
> [18635.541464]  ioremap_page_range+0x30f/0x560
> [18635.546634]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18635.551901]  __ioremap_caller.constprop.18+0x1a8/0x300
> [18635.558032]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18635.563116]  ? _cond_resched+0x15/0x40
> [18635.567836]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [18635.573915]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [18635.580316]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [18635.587337]  drm_gem_vmap+0x1f/0x60 [drm]
> [18635.592272]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [18635.598081]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [18635.605110]  process_one_work+0x1e5/0x410
> [18635.610071]  worker_thread+0x2d/0x3c0
> [18635.614670]  ? cancel_delayed_work+0x90/0x90
> [18635.619860]  kthread+0x117/0x130
> [18635.624014]  ? kthread_create_worker_on_cpu+0x70/0x70
> [18635.629943]  ret_from_fork+0x22/0x40
> [18637.811054] nfs: server botanophobie not responding, timed out
> [18637.811056] nfs: server aquaphobie not responding, timed out
> [18637.811063] nfs: server gula not responding, timed out
> [18641.907040] nfs: server pappnase not responding, timed out
> [18648.050064] nfs: server aquaphobie not responding, timed out
> [18648.050937] nfs: server botanophobie not responding, timed out
> [18648.051082] nfs: server gula not responding, timed out
> [18652.147061] nfs: server pappnase not responding, timed out
> [18658.290084] nfs: server aquaphobie not responding, timed out
> [18658.291095] nfs: server botanophobie not responding, timed out
> [18658.291107] nfs: server gula not responding, timed out
> [18662.387089] nfs: server pappnase not responding, timed out
> [18668.530111] nfs: server aquaphobie not responding, timed out
> [18668.530977] nfs: server botanophobie not responding, timed out
> [18668.531095] nfs: server gula not responding, timed out
> [18672.627119] nfs: server pappnase not responding, timed out
> [18678.578129] nfs: server botanophobie not responding, timed out
> [18678.578992] nfs: server aquaphobie not responding, timed out
> [18678.579121] nfs: server gula not responding, timed out
> [18682.674135] nfs: server pappnase not responding, timed out
> [18689.010162] nfs: server botanophobie not responding, timed out
> [18689.010174] nfs: server gula not responding, timed out
> [18689.011128] nfs: server aquaphobie not responding, timed out
> [18693.107148] nfs: server pappnase not responding, timed out
> [18699.251154] nfs: server botanophobie not responding, timed out
> [18699.251158] nfs: server aquaphobie not responding, timed out
> [18699.251165] nfs: server gula not responding, timed out
> [18703.347189] nfs: server pappnase not responding, timed out
> [18709.490208] nfs: server aquaphobie not responding, timed out
> [18709.490221] nfs: server gula not responding, timed out
> [18709.491155] nfs: server botanophobie not responding, timed out
> [18713.587190] nfs: server pappnase not responding, timed out
> [18719.730208] nfs: server aquaphobie not responding, timed out
> [18719.731198] nfs: server botanophobie not responding, timed out
> [18719.731206] nfs: server gula not responding, timed out
> [18723.827211] nfs: server pappnase not responding, timed out
> [18729.970235] nfs: server aquaphobie not responding, timed out
> [18729.970384] nfs: server gula not responding, timed out
> [18729.971096] nfs: server botanophobie not responding, timed out
> [18734.066240] nfs: server pappnase not responding, timed out
> [18740.210249] nfs: server aquaphobie not responding, timed out
> [18740.210267] nfs: server gula not responding, timed out
> [18740.211226] nfs: server botanophobie not responding, timed out
> [18741.235244] nfs: server afk not responding, timed out
> [18744.306285] nfs: server pappnase not responding, timed out
> [18750.450271] nfs: server gula not responding, timed out
> [18750.450274] nfs: server aquaphobie not responding, timed out
> [18750.451244] nfs: server botanophobie not responding, timed out
> [18754.547273] nfs: server pappnase not responding, timed out
> [18761.715273] nfs: server botanophobie not responding, timed out
> [18761.715275] nfs: server aquaphobie not responding, timed out
> [18761.715283] nfs: server gula not responding, timed out
> [18765.811288] nfs: server pappnase not responding, timed out
> [18766.835276] nfs: server afk not responding, timed out
> [18771.954311] nfs: server botanophobie not responding, timed out
> [18771.954319] nfs: server aquaphobie not responding, timed out
> [18771.955297] nfs: server gula not responding, timed out
> [18776.050316] nfs: server pappnase not responding, timed out
> [18782.194335] nfs: server gula not responding, timed out
> [18782.194339] nfs: server botanophobie not responding, timed out
> [18782.194342] nfs: server aquaphobie not responding, timed out
> [18786.290328] nfs: server pappnase not responding, timed out
> [18792.434373] nfs: server gula not responding, timed out
> [18792.435334] nfs: server botanophobie not responding, timed out
> [18792.435343] nfs: server aquaphobie not responding, timed out
> [18796.530353] nfs: server pappnase not responding, timed out
> [18802.674369] nfs: server aquaphobie not responding, timed out
> [18802.674384] nfs: server gula not responding, timed out
> [18802.675347] nfs: server botanophobie not responding, timed out
> [18806.771395] nfs: server pappnase not responding, timed out
> [18812.914385] nfs: server aquaphobie not responding, timed out
> [18812.914388] nfs: server gula not responding, timed out
> [18812.915366] nfs: server botanophobie not responding, timed out
> [18815.039251] rcu: INFO: rcu_sched self-detected stall on CPU
> [18815.045817] rcu: 	46-....: (7953149 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1797644 
> [18815.057167] 	(t=7980150 jiffies g=2794673 q=1284837)
> [18815.063041] Sending NMI from CPU 46 to CPUs 5:
> [18815.069395] NMI backtrace for cpu 5
> [18815.069396] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18815.069396] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18815.069397] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [18815.069398] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [18815.069399] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [18815.069400] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [18815.069400] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [18815.069401] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [18815.069402] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [18815.069402] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [18815.069403] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [18815.069403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [18815.069404] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [18815.069404] Call Trace:
> [18815.069405]  _raw_spin_lock_irqsave+0x22/0x30
> [18815.069405]  pagevec_lru_move_fn+0x6c/0xd0
> [18815.069406]  activate_page+0xb5/0xc0
> [18815.069406]  mark_page_accessed+0x7a/0x130
> [18815.069407]  generic_file_read_iter+0x4c8/0xae0
> [18815.069407]  ? generic_update_time+0x9c/0xc0
> [18815.069407]  ? pipe_write+0x286/0x400
> [18815.069408]  new_sync_read+0x114/0x1a0
> [18815.069408]  vfs_read+0x89/0x130
> [18815.069409]  ksys_read+0xa1/0xe0
> [18815.069409]  do_syscall_64+0x48/0x130
> [18815.069410]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [18815.069410] RIP: 0033:0x7fc44b933d71
> [18815.069411] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [18815.069412] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [18815.069413] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [18815.069413] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [18815.069414] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [18815.069415] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [18815.069415] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [18815.069440] NMI backtrace for cpu 46
> [18815.333427] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18815.344412] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18815.352995] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [18815.360704] Call Trace:
> [18815.364255]  <IRQ>
> [18815.367371]  dump_stack+0x50/0x6b
> [18815.371765]  nmi_cpu_backtrace+0x89/0x90
> [18815.376745]  ? lapic_can_unplug_cpu+0x90/0x90
> [18815.382129]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [18815.388128]  rcu_dump_cpu_stacks+0x99/0xd0
> [18815.393257]  rcu_sched_clock_irq+0x502/0x770
> [18815.398542]  ? tick_sched_do_timer+0x60/0x60
> [18815.403806]  update_process_times+0x24/0x50
> [18815.408980]  tick_sched_timer+0x37/0x70
> [18815.413774]  __hrtimer_run_queues+0x11f/0x2b0
> [18815.419063]  hrtimer_interrupt+0xe5/0x240
> [18815.423983]  smp_apic_timer_interrupt+0x6f/0x130
> [18815.429505]  apic_timer_interrupt+0xf/0x20
> [18815.434507]  </IRQ>
> [18815.437497] RIP: 0010:smp_call_function_many+0x232/0x260
> [18815.443706] Code: 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 8b 4a 18 <83> e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f 57 82 48
> [18815.464363] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [18815.472906] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000003
> [18815.480983] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [18815.489059] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [18815.497138] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [18815.505218] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [18815.513296]  ? native_set_ldt.part.10+0xc0/0xc0
> [18815.518790]  ? smp_call_function_many+0x20a/0x260
> [18815.524468]  ? native_set_ldt.part.10+0xc0/0xc0
> [18815.529953]  on_each_cpu+0x28/0x40
> [18815.534345]  flush_tlb_kernel_range+0x79/0x80
> [18815.539703]  pmd_free_pte_page+0x41/0x60
> [18815.544603]  ioremap_page_range+0x30f/0x560
> [18815.549763]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18815.555020]  __ioremap_caller.constprop.18+0x1a8/0x300
> [18815.561151]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18815.566240]  ? _cond_resched+0x15/0x40
> [18815.570939]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [18815.577015]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [18815.583422]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [18815.590443]  drm_gem_vmap+0x1f/0x60 [drm]
> [18815.595373]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [18815.601226]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [18815.608257]  process_one_work+0x1e5/0x410
> [18815.613203]  worker_thread+0x2d/0x3c0
> [18815.617794]  ? cancel_delayed_work+0x90/0x90
> [18815.622977]  kthread+0x117/0x130
> [18815.627104]  ? kthread_create_worker_on_cpu+0x70/0x70
> [18815.633050]  ret_from_fork+0x22/0x40
> [18817.010392] nfs: server pappnase not responding, timed out
> [18823.154410] nfs: server aquaphobie not responding, timed out
> [18823.155383] nfs: server botanophobie not responding, timed out
> [18823.155402] nfs: server gula not responding, timed out
> [18827.250416] nfs: server pappnase not responding, timed out
> [18833.394428] nfs: server gula not responding, timed out
> [18833.395415] nfs: server botanophobie not responding, timed out
> [18833.395419] nfs: server aquaphobie not responding, timed out
> [18837.491454] nfs: server pappnase not responding, timed out
> [18843.634453] nfs: server aquaphobie not responding, timed out
> [18843.635445] nfs: server botanophobie not responding, timed out
> [18843.635475] nfs: server gula not responding, timed out
> [18847.730459] nfs: server pappnase not responding, timed out
> [18853.874467] nfs: server gula not responding, timed out
> [18853.874470] nfs: server aquaphobie not responding, timed out
> [18853.875472] nfs: server botanophobie not responding, timed out
> [18857.970479] nfs: server pappnase not responding, timed out
> [18864.114488] nfs: server botanophobie not responding, timed out
> [18864.115494] nfs: server aquaphobie not responding, timed out
> [18864.115517] nfs: server gula not responding, timed out
> [18868.210521] nfs: server pappnase not responding, timed out
> [18874.354514] nfs: server aquaphobie not responding, timed out
> [18874.354527] nfs: server gula not responding, timed out
> [18874.355502] nfs: server botanophobie not responding, timed out
> [18878.450531] nfs: server pappnase not responding, timed out
> [18884.594519] nfs: server gula not responding, timed out
> [18884.594533] nfs: server botanophobie not responding, timed out
> [18884.594541] nfs: server aquaphobie not responding, timed out
> [18888.690536] nfs: server pappnase not responding, timed out
> [18894.834546] nfs: server aquaphobie not responding, timed out
> [18894.834548] nfs: server gula not responding, timed out
> [18894.835564] nfs: server botanophobie not responding, timed out
> [18898.930565] nfs: server pappnase not responding, timed out
> [18905.075571] nfs: server botanophobie not responding, timed out
> [18905.075575] nfs: server aquaphobie not responding, timed out
> [18905.075588] nfs: server gula not responding, timed out
> [18909.170582] nfs: server pappnase not responding, timed out
> [18915.314583] nfs: server aquaphobie not responding, timed out
> [18915.314593] nfs: server gula not responding, timed out
> [18915.315577] nfs: server botanophobie not responding, timed out
> [18919.410610] nfs: server pappnase not responding, timed out
> [18921.459610] nfs: server afk not responding, timed out
> [18925.554602] nfs: server gula not responding, timed out
> [18925.554605] nfs: server botanophobie not responding, timed out
> [18925.554612] nfs: server aquaphobie not responding, timed out
> [18929.650640] nfs: server pappnase not responding, timed out
> [18935.794623] nfs: server aquaphobie not responding, timed out
> [18935.795618] nfs: server botanophobie not responding, timed out
> [18935.795623] nfs: server gula not responding, timed out
> [18939.890652] nfs: server pappnase not responding, timed out
> [18941.939632] nfs: server botanophobie not responding, timed out
> [18941.939635] nfs: server gula not responding, timed out
> [18941.939639] nfs: server aquaphobie not responding, timed out
> [18946.035700] nfs: server pappnase not responding, timed out
> [18946.866651] nfs: server gula not responding, timed out
> [18946.867645] nfs: server aquaphobie not responding, timed out
> [18946.867651] nfs: server botanophobie not responding, timed out
> [18950.962826] nfs: server pappnase not responding, timed out
> [18952.179657] nfs: server afk not responding, timed out
> [18957.298662] nfs: server gula not responding, timed out
> [18957.298666] nfs: server botanophobie not responding, timed out
> [18957.298669] nfs: server aquaphobie not responding, timed out
> [18961.395675] nfs: server pappnase not responding, timed out
> [18967.538693] nfs: server aquaphobie not responding, timed out
> [18967.539665] nfs: server botanophobie not responding, timed out
> [18967.539671] nfs: server gula not responding, timed out
> [18971.635684] nfs: server pappnase not responding, timed out
> [18977.779700] nfs: server botanophobie not responding, timed out
> [18977.779702] nfs: server aquaphobie not responding, timed out
> [18977.779708] nfs: server gula not responding, timed out
> [18981.875718] nfs: server pappnase not responding, timed out
> [18988.018738] nfs: server aquaphobie not responding, timed out
> [18988.019602] nfs: server botanophobie not responding, timed out
> [18988.019724] nfs: server gula not responding, timed out
> [18992.115725] nfs: server pappnase not responding, timed out
> [18995.042604] rcu: INFO: rcu_sched self-detected stall on CPU
> [18995.049311] rcu: 	46-....: (8132555 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1839544 
> [18995.060671] 	(t=8160153 jiffies g=2794673 q=1285566)
> [18995.066527] Sending NMI from CPU 46 to CPUs 5:
> [18995.072860] NMI backtrace for cpu 5
> [18995.072861] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18995.072862] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18995.072862] RIP: 0010:queued_spin_lock_slowpath+0x3c/0x1a0
> [18995.072864] Code: e6 00 ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04
> [18995.072864] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [18995.072865] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [18995.072866] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [18995.072867] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [18995.072867] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [18995.072868] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [18995.072869] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [18995.072869] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [18995.072870] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [18995.072870] Call Trace:
> [18995.072870]  _raw_spin_lock_irqsave+0x22/0x30
> [18995.072871]  pagevec_lru_move_fn+0x6c/0xd0
> [18995.072871]  activate_page+0xb5/0xc0
> [18995.072872]  mark_page_accessed+0x7a/0x130
> [18995.072872]  generic_file_read_iter+0x4c8/0xae0
> [18995.072873]  ? generic_update_time+0x9c/0xc0
> [18995.072873]  ? pipe_write+0x286/0x400
> [18995.072874]  new_sync_read+0x114/0x1a0
> [18995.072874]  vfs_read+0x89/0x130
> [18995.072874]  ksys_read+0xa1/0xe0
> [18995.072875]  do_syscall_64+0x48/0x130
> [18995.072875]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [18995.072876] RIP: 0033:0x7fc44b933d71
> [18995.072877] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [18995.072877] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [18995.072878] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [18995.072879] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [18995.072880] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [18995.072880] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [18995.072881] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [18995.072906] NMI backtrace for cpu 46
> [18995.336543] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [18995.347600] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [18995.356185] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [18995.363900] Call Trace:
> [18995.367454]  <IRQ>
> [18995.370561]  dump_stack+0x50/0x6b
> [18995.374965]  nmi_cpu_backtrace+0x89/0x90
> [18995.379946]  ? lapic_can_unplug_cpu+0x90/0x90
> [18995.385336]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [18995.391340]  rcu_dump_cpu_stacks+0x99/0xd0
> [18995.396468]  rcu_sched_clock_irq+0x502/0x770
> [18995.401754]  ? tick_sched_do_timer+0x60/0x60
> [18995.407012]  update_process_times+0x24/0x50
> [18995.412178]  tick_sched_timer+0x37/0x70
> [18995.416977]  __hrtimer_run_queues+0x11f/0x2b0
> [18995.422263]  hrtimer_interrupt+0xe5/0x240
> [18995.427178]  smp_apic_timer_interrupt+0x6f/0x130
> [18995.432721]  apic_timer_interrupt+0xf/0x20
> [18995.437726]  </IRQ>
> [18995.440727] RIP: 0010:smp_call_function_many+0x22f/0x260
> [18995.446939] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [18995.467571] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [18995.476081] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [18995.484161] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [18995.492239] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [18995.500324] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [18995.508399] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [18995.516497]  ? native_set_ldt.part.10+0xc0/0xc0
> [18995.521996]  ? smp_call_function_many+0x20a/0x260
> [18995.527679]  ? native_set_ldt.part.10+0xc0/0xc0
> [18995.533184]  on_each_cpu+0x28/0x40
> [18995.537547]  flush_tlb_kernel_range+0x79/0x80
> [18995.542876]  pmd_free_pte_page+0x41/0x60
> [18995.547779]  ioremap_page_range+0x30f/0x560
> [18995.552949]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18995.558202]  __ioremap_caller.constprop.18+0x1a8/0x300
> [18995.564342]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [18995.569424]  ? _cond_resched+0x15/0x40
> [18995.574145]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [18995.580229]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [18995.586642]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [18995.593654]  drm_gem_vmap+0x1f/0x60 [drm]
> [18995.598581]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [18995.604397]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [18995.611432]  process_one_work+0x1e5/0x410
> [18995.616392]  worker_thread+0x2d/0x3c0
> [18995.620992]  ? cancel_delayed_work+0x90/0x90
> [18995.626173]  kthread+0x117/0x130
> [18995.630295]  ? kthread_create_worker_on_cpu+0x70/0x70
> [18995.636236]  ret_from_fork+0x22/0x40
> [18998.258747] nfs: server aquaphobie not responding, timed out
> [18998.259738] nfs: server botanophobie not responding, timed out
> [18998.259740] nfs: server gula not responding, timed out
> [19002.355753] nfs: server pappnase not responding, timed out
> [19008.498774] nfs: server aquaphobie not responding, timed out
> [19008.499758] nfs: server gula not responding, timed out
> [19008.499761] nfs: server botanophobie not responding, timed out
> [19012.595772] nfs: server pappnase not responding, timed out
> [19018.738809] nfs: server aquaphobie not responding, timed out
> [19018.739661] nfs: server botanophobie not responding, timed out
> [19018.739781] nfs: server gula not responding, timed out
> [19022.835796] nfs: server pappnase not responding, timed out
> [19028.978822] nfs: server aquaphobie not responding, timed out
> [19028.979688] nfs: server gula not responding, timed out
> [19028.979791] nfs: server botanophobie not responding, timed out
> [19033.075812] nfs: server pappnase not responding, timed out
> [19039.026831] nfs: server gula not responding, timed out
> [19039.026834] nfs: server aquaphobie not responding, timed out
> [19039.027697] nfs: server botanophobie not responding, timed out
> [19043.122835] nfs: server pappnase not responding, timed out
> [19049.458851] nfs: server aquaphobie not responding, timed out
> [19049.458861] nfs: server gula not responding, timed out
> [19049.459830] nfs: server botanophobie not responding, timed out
> [19053.554869] nfs: server pappnase not responding, timed out
> [19059.698875] nfs: server gula not responding, timed out
> [19059.698878] nfs: server aquaphobie not responding, timed out
> [19059.699741] nfs: server botanophobie not responding, timed out
> [19063.794886] nfs: server pappnase not responding, timed out
> [19069.938887] nfs: server aquaphobie not responding, timed out
> [19069.938891] nfs: server gula not responding, timed out
> [19069.939873] nfs: server botanophobie not responding, timed out
> [19074.035914] nfs: server pappnase not responding, timed out
> [19080.178916] nfs: server aquaphobie not responding, timed out
> [19080.179782] nfs: server botanophobie not responding, timed out
> [19080.179906] nfs: server gula not responding, timed out
> [19084.274921] nfs: server pappnase not responding, timed out
> [19090.418939] nfs: server aquaphobie not responding, timed out
> [19090.418962] nfs: server gula not responding, timed out
> [19090.419917] nfs: server botanophobie not responding, timed out
> [19094.515936] nfs: server pappnase not responding, timed out
> [19100.658965] nfs: server aquaphobie not responding, timed out
> [19100.658979] nfs: server gula not responding, timed out
> [19100.659823] nfs: server botanophobie not responding, timed out
> [19101.683942] nfs: server afk not responding, timed out
> [19104.754965] nfs: server pappnase not responding, timed out
> [19110.898973] nfs: server aquaphobie not responding, timed out
> [19110.898988] nfs: server gula not responding, timed out
> [19110.899957] nfs: server botanophobie not responding, timed out
> [19114.995080] nfs: server pappnase not responding, timed out
> [19121.139008] nfs: server aquaphobie not responding, timed out
> [19121.139970] nfs: server botanophobie not responding, timed out
> [19121.139980] nfs: server gula not responding, timed out
> [19121.971002] nfs: server aquaphobie not responding, timed out
> [19121.971140] nfs: server gula not responding, timed out
> [19121.971976] nfs: server botanophobie not responding, timed out
> [19125.234994] nfs: server pappnase not responding, timed out
> [19126.067030] nfs: server pappnase not responding, timed out
> [19132.403879] nfs: server aquaphobie not responding, timed out
> [19132.404003] nfs: server botanophobie not responding, timed out
> [19132.404007] nfs: server gula not responding, timed out
> [19136.500017] nfs: server pappnase not responding, timed out
> [19137.524000] nfs: server afk not responding, timed out
> [19142.644028] nfs: server botanophobie not responding, timed out
> [19142.644032] nfs: server aquaphobie not responding, timed out
> [19142.644035] nfs: server gula not responding, timed out
> [19146.739907] nfs: server pappnase not responding, timed out
> [19152.883061] nfs: server aquaphobie not responding, timed out
> [19152.883069] nfs: server gula not responding, timed out
> [19152.884041] nfs: server botanophobie not responding, timed out
> [19156.980054] nfs: server pappnase not responding, timed out
> [19163.123085] nfs: server aquaphobie not responding, timed out
> [19163.123093] nfs: server gula not responding, timed out
> [19163.124046] nfs: server botanophobie not responding, timed out
> [19167.219086] nfs: server pappnase not responding, timed out
> [19173.364084] nfs: server botanophobie not responding, timed out
> [19173.364088] nfs: server aquaphobie not responding, timed out
> [19173.364091] nfs: server gula not responding, timed out
> [19175.045955] rcu: INFO: rcu_sched self-detected stall on CPU
> [19175.052393] rcu: 	46-....: (8311961 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1880427 
> [19175.063719] 	(t=8340156 jiffies g=2794673 q=1286343)
> [19175.069584] Sending NMI from CPU 46 to CPUs 5:
> [19175.075915] NMI backtrace for cpu 5
> [19175.075916] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19175.075917] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19175.075917] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [19175.075918] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [19175.075919] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [19175.075920] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [19175.075921] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [19175.075922] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [19175.075922] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [19175.075923] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [19175.075924] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [19175.075924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19175.075925] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [19175.075925] Call Trace:
> [19175.075926]  _raw_spin_lock_irqsave+0x22/0x30
> [19175.075926]  pagevec_lru_move_fn+0x6c/0xd0
> [19175.075926]  activate_page+0xb5/0xc0
> [19175.075927]  mark_page_accessed+0x7a/0x130
> [19175.075927]  generic_file_read_iter+0x4c8/0xae0
> [19175.075928]  ? generic_update_time+0x9c/0xc0
> [19175.075928]  ? pipe_write+0x286/0x400
> [19175.075929]  new_sync_read+0x114/0x1a0
> [19175.075929]  vfs_read+0x89/0x130
> [19175.075929]  ksys_read+0xa1/0xe0
> [19175.075930]  do_syscall_64+0x48/0x130
> [19175.075930]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [19175.075931] RIP: 0033:0x7fc44b933d71
> [19175.075932] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [19175.075932] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [19175.075934] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [19175.075934] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [19175.075935] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [19175.075935] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [19175.075945] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [19175.075972] NMI backtrace for cpu 46
> [19175.339627] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19175.350619] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19175.359189] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [19175.366898] Call Trace:
> [19175.370501]  <IRQ>
> [19175.373615]  dump_stack+0x50/0x6b
> [19175.378013]  nmi_cpu_backtrace+0x89/0x90
> [19175.382994]  ? lapic_can_unplug_cpu+0x90/0x90
> [19175.388407]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [19175.394407]  rcu_dump_cpu_stacks+0x99/0xd0
> [19175.399533]  rcu_sched_clock_irq+0x502/0x770
> [19175.404816]  ? tick_sched_do_timer+0x60/0x60
> [19175.410087]  update_process_times+0x24/0x50
> [19175.415254]  tick_sched_timer+0x37/0x70
> [19175.420072]  __hrtimer_run_queues+0x11f/0x2b0
> [19175.425407]  hrtimer_interrupt+0xe5/0x240
> [19175.430321]  smp_apic_timer_interrupt+0x6f/0x130
> [19175.435846]  apic_timer_interrupt+0xf/0x20
> [19175.440846]  </IRQ>
> [19175.443843] RIP: 0010:smp_call_function_many+0x22f/0x260
> [19175.450072] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [19175.470716] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [19175.479227] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [19175.487294] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [19175.495368] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [19175.503445] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [19175.511521] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [19175.519609]  ? native_set_ldt.part.10+0xc0/0xc0
> [19175.525100]  ? smp_call_function_many+0x20a/0x260
> [19175.530768]  ? native_set_ldt.part.10+0xc0/0xc0
> [19175.536269]  on_each_cpu+0x28/0x40
> [19175.540638]  flush_tlb_kernel_range+0x79/0x80
> [19175.545968]  pmd_free_pte_page+0x41/0x60
> [19175.550871]  ioremap_page_range+0x30f/0x560
> [19175.556073]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19175.561330]  __ioremap_caller.constprop.18+0x1a8/0x300
> [19175.567456]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19175.572541]  ? _cond_resched+0x15/0x40
> [19175.577256]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [19175.583334]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [19175.589743]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [19175.596761]  drm_gem_vmap+0x1f/0x60 [drm]
> [19175.601696]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [19175.607515]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [19175.614553]  process_one_work+0x1e5/0x410
> [19175.619522]  worker_thread+0x2d/0x3c0
> [19175.624127]  ? cancel_delayed_work+0x90/0x90
> [19175.629322]  kthread+0x117/0x130
> [19175.633450]  ? kthread_create_worker_on_cpu+0x70/0x70
> [19175.639386]  ret_from_fork+0x22/0x40
> [19177.459099] nfs: server pappnase not responding, timed out
> [19183.603117] nfs: server aquaphobie not responding, timed out
> [19183.603170] nfs: server gula not responding, timed out
> [19183.604098] nfs: server botanophobie not responding, timed out
> [19187.699122] nfs: server pappnase not responding, timed out
> [19193.843150] nfs: server gula not responding, timed out
> [19193.844115] nfs: server botanophobie not responding, timed out
> [19193.844127] nfs: server aquaphobie not responding, timed out
> [19197.940141] nfs: server pappnase not responding, timed out
> [19204.083152] nfs: server aquaphobie not responding, timed out
> [19204.084136] nfs: server botanophobie not responding, timed out
> [19204.084146] nfs: server gula not responding, timed out
> [19208.180168] nfs: server pappnase not responding, timed out
> [19214.323173] nfs: server gula not responding, timed out
> [19214.323178] nfs: server aquaphobie not responding, timed out
> [19214.324157] nfs: server botanophobie not responding, timed out
> [19218.420177] nfs: server pappnase not responding, timed out
> [19224.563192] nfs: server aquaphobie not responding, timed out
> [19224.564187] nfs: server botanophobie not responding, timed out
> [19224.564193] nfs: server gula not responding, timed out
> [19228.660201] nfs: server pappnase not responding, timed out
> [19234.804204] nfs: server aquaphobie not responding, timed out
> [19234.804209] nfs: server botanophobie not responding, timed out
> [19234.804212] nfs: server gula not responding, timed out
> [19238.899246] nfs: server pappnase not responding, timed out
> [19245.043226] nfs: server aquaphobie not responding, timed out
> [19245.043233] nfs: server botanophobie not responding, timed out
> [19245.043236] nfs: server gula not responding, timed out
> [19249.139265] nfs: server pappnase not responding, timed out
> [19255.283249] nfs: server gula not responding, timed out
> [19255.284252] nfs: server botanophobie not responding, timed out
> [19255.284256] nfs: server aquaphobie not responding, timed out
> [19259.379287] nfs: server pappnase not responding, timed out
> [19265.523265] nfs: server botanophobie not responding, timed out
> [19265.523269] nfs: server aquaphobie not responding, timed out
> [19265.523273] nfs: server gula not responding, timed out
> [19269.619300] nfs: server pappnase not responding, timed out
> [19275.763291] nfs: server gula not responding, timed out
> [19275.764292] nfs: server botanophobie not responding, timed out
> [19275.764294] nfs: server aquaphobie not responding, timed out
> [19279.859310] nfs: server pappnase not responding, timed out
> [19281.908296] nfs: server afk not responding, timed out
> [19286.003307] nfs: server gula not responding, timed out
> [19286.004310] nfs: server botanophobie not responding, timed out
> [19286.004320] nfs: server aquaphobie not responding, timed out
> [19290.100320] nfs: server pappnase not responding, timed out
> [19296.244341] nfs: server botanophobie not responding, timed out
> [19296.244348] nfs: server gula not responding, timed out
> [19296.244351] nfs: server aquaphobie not responding, timed out
> [19300.339339] nfs: server pappnase not responding, timed out
> [19302.387334] nfs: server gula not responding, timed out
> [19302.387336] nfs: server aquaphobie not responding, timed out
> [19302.388340] nfs: server botanophobie not responding, timed out
> [19306.483350] nfs: server pappnase not responding, timed out
> [19307.315358] nfs: server gula not responding, timed out
> [19307.316221] nfs: server aquaphobie not responding, timed out
> [19307.316223] nfs: server botanophobie not responding, timed out
> [19311.411363] nfs: server pappnase not responding, timed out
> [19317.748374] nfs: server botanophobie not responding, timed out
> [19317.748377] nfs: server aquaphobie not responding, timed out
> [19317.748384] nfs: server gula not responding, timed out
> [19321.843393] nfs: server pappnase not responding, timed out
> [19322.868374] nfs: server afk not responding, timed out
> [19327.987399] nfs: server gula not responding, timed out
> [19327.987404] nfs: server aquaphobie not responding, timed out
> [19327.988379] nfs: server botanophobie not responding, timed out
> [19332.083413] nfs: server pappnase not responding, timed out
> [19338.227414] nfs: server gula not responding, timed out
> [19338.228424] nfs: server botanophobie not responding, timed out
> [19338.228428] nfs: server aquaphobie not responding, timed out
> [19342.323427] nfs: server pappnase not responding, timed out
> [19348.467439] nfs: server aquaphobie not responding, timed out
> [19348.468428] nfs: server gula not responding, timed out
> [19348.468430] nfs: server botanophobie not responding, timed out
> [19352.564433] nfs: server pappnase not responding, timed out
> [19355.049308] rcu: INFO: rcu_sched self-detected stall on CPU
> [19355.056050] rcu: 	46-....: (8491368 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1920535 
> [19355.067434] 	(t=8520160 jiffies g=2794673 q=1287261)
> [19355.073308] Sending NMI from CPU 46 to CPUs 5:
> [19355.079636] NMI backtrace for cpu 5
> [19355.079637] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19355.079638] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19355.079638] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [19355.079639] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [19355.079640] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [19355.079641] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [19355.079642] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [19355.079642] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [19355.079643] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [19355.079644] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [19355.079644] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [19355.079645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19355.079645] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [19355.079646] Call Trace:
> [19355.079646]  _raw_spin_lock_irqsave+0x22/0x30
> [19355.079647]  pagevec_lru_move_fn+0x6c/0xd0
> [19355.079647]  activate_page+0xb5/0xc0
> [19355.079647]  mark_page_accessed+0x7a/0x130
> [19355.079648]  generic_file_read_iter+0x4c8/0xae0
> [19355.079648]  ? generic_update_time+0x9c/0xc0
> [19355.079649]  ? pipe_write+0x286/0x400
> [19355.079649]  new_sync_read+0x114/0x1a0
> [19355.079650]  vfs_read+0x89/0x130
> [19355.079650]  ksys_read+0xa1/0xe0
> [19355.079650]  do_syscall_64+0x48/0x130
> [19355.079651]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [19355.079651] RIP: 0033:0x7fc44b933d71
> [19355.079653] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [19355.079653] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [19355.079654] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [19355.079655] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [19355.079655] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [19355.079656] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [19355.079657] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [19355.079681] NMI backtrace for cpu 46
> [19355.343517] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19355.354509] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19355.363085] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [19355.370802] Call Trace:
> [19355.374349]  <IRQ>
> [19355.377464]  dump_stack+0x50/0x6b
> [19355.381862]  nmi_cpu_backtrace+0x89/0x90
> [19355.386850]  ? lapic_can_unplug_cpu+0x90/0x90
> [19355.392238]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [19355.398237]  rcu_dump_cpu_stacks+0x99/0xd0
> [19355.403369]  rcu_sched_clock_irq+0x502/0x770
> [19355.408672]  ? tick_sched_do_timer+0x60/0x60
> [19355.413940]  update_process_times+0x24/0x50
> [19355.419100]  tick_sched_timer+0x37/0x70
> [19355.423893]  __hrtimer_run_queues+0x11f/0x2b0
> [19355.429169]  hrtimer_interrupt+0xe5/0x240
> [19355.434094]  smp_apic_timer_interrupt+0x6f/0x130
> [19355.439619]  apic_timer_interrupt+0xf/0x20
> [19355.444619]  </IRQ>
> [19355.447615] RIP: 0010:smp_call_function_many+0x22f/0x260
> [19355.453826] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [19355.474465] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [19355.482978] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [19355.491057] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [19355.499136] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [19355.507221] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [19355.515307] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [19355.523422]  ? native_set_ldt.part.10+0xc0/0xc0
> [19355.528934]  ? smp_call_function_many+0x20a/0x260
> [19355.534611]  ? native_set_ldt.part.10+0xc0/0xc0
> [19355.540110]  on_each_cpu+0x28/0x40
> [19355.544471]  flush_tlb_kernel_range+0x79/0x80
> [19355.549804]  pmd_free_pte_page+0x41/0x60
> [19355.554696]  ioremap_page_range+0x30f/0x560
> [19355.559870]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19355.565127]  __ioremap_caller.constprop.18+0x1a8/0x300
> [19355.571255]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19355.576344]  ? _cond_resched+0x15/0x40
> [19355.581056]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [19355.587127]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [19355.593538]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [19355.600563]  drm_gem_vmap+0x1f/0x60 [drm]
> [19355.605500]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [19355.611321]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [19355.618350]  process_one_work+0x1e5/0x410
> [19355.623315]  worker_thread+0x2d/0x3c0
> [19355.627901]  ? cancel_delayed_work+0x90/0x90
> [19355.633084]  kthread+0x117/0x130
> [19355.637214]  ? kthread_create_worker_on_cpu+0x70/0x70
> [19355.643153]  ret_from_fork+0x22/0x40
> [19358.707455] nfs: server gula not responding, timed out
> [19358.707461] nfs: server aquaphobie not responding, timed out
> [19358.708463] nfs: server botanophobie not responding, timed out
> [19362.803464] nfs: server pappnase not responding, timed out
> [19368.947475] nfs: server botanophobie not responding, timed out
> [19368.947490] nfs: server aquaphobie not responding, timed out
> [19368.947562] nfs: server gula not responding, timed out
> [19373.043488] nfs: server pappnase not responding, timed out
> [19379.187488] nfs: server aquaphobie not responding, timed out
> [19379.187493] nfs: server gula not responding, timed out
> [19379.188489] nfs: server botanophobie not responding, timed out
> [19383.283505] nfs: server pappnase not responding, timed out
> [19389.427506] nfs: server gula not responding, timed out
> [19389.427512] nfs: server aquaphobie not responding, timed out
> [19393.523520] nfs: server pappnase not responding, timed out
> [19399.475528] nfs: server botanophobie not responding, timed out
> [19399.475531] nfs: server aquaphobie not responding, timed out
> [19399.476532] nfs: server gula not responding, timed out
> [19403.571533] nfs: server pappnase not responding, timed out
> [19409.907553] nfs: server botanophobie not responding, timed out
> [19409.907560] nfs: server gula not responding, timed out
> [19409.907567] nfs: server aquaphobie not responding, timed out
> [19414.003576] nfs: server pappnase not responding, timed out
> [19420.147593] nfs: server aquaphobie not responding, timed out
> [19420.148575] nfs: server gula not responding, timed out
> [19420.148578] nfs: server botanophobie not responding, timed out
> [19424.244584] nfs: server pappnase not responding, timed out
> [19430.387598] nfs: server botanophobie not responding, timed out
> [19430.387605] nfs: server aquaphobie not responding, timed out
> [19430.388597] nfs: server gula not responding, timed out
> [19434.484610] nfs: server pappnase not responding, timed out
> [19440.628612] nfs: server gula not responding, timed out
> [19440.628619] nfs: server botanophobie not responding, timed out
> [19440.628626] nfs: server aquaphobie not responding, timed out
> [19444.724624] nfs: server pappnase not responding, timed out
> [19450.867651] nfs: server botanophobie not responding, timed out
> [19450.867659] nfs: server aquaphobie not responding, timed out
> [19450.868627] nfs: server gula not responding, timed out
> [19454.964511] nfs: server pappnase not responding, timed out
> [19461.107650] nfs: server botanophobie not responding, timed out
> [19461.107662] nfs: server aquaphobie not responding, timed out
> [19461.108645] nfs: server gula not responding, timed out
> [19462.132648] nfs: server afk not responding, timed out
> [19465.204535] nfs: server pappnase not responding, timed out
> [19471.347688] nfs: server botanophobie not responding, timed out
> [19471.347725] nfs: server aquaphobie not responding, timed out
> [19471.348676] nfs: server gula not responding, timed out
> [19475.444552] nfs: server pappnase not responding, timed out
> [19481.587704] nfs: server aquaphobie not responding, timed out
> [19481.588695] nfs: server botanophobie not responding, timed out
> [19481.588698] nfs: server gula not responding, timed out
> [19482.419702] nfs: server botanophobie not responding, timed out
> [19482.419710] nfs: server aquaphobie not responding, timed out
> [19482.420697] nfs: server gula not responding, timed out
> [19485.684572] nfs: server pappnase not responding, timed out
> [19486.516576] nfs: server pappnase not responding, timed out
> [19492.851728] nfs: server aquaphobie not responding, timed out
> [19492.852587] nfs: server botanophobie not responding, timed out
> [19492.852716] nfs: server gula not responding, timed out
> [19496.947711] nfs: server pappnase not responding, timed out
> [19503.091752] nfs: server gula not responding, timed out
> [19503.091758] nfs: server aquaphobie not responding, timed out
> [19503.092712] nfs: server botanophobie not responding, timed out
> [19507.188618] nfs: server pappnase not responding, timed out
> [19511.283734] nfs: server afk not responding, timed out
> [19513.331763] nfs: server botanophobie not responding, timed out
> [19513.331781] nfs: server aquaphobie not responding, timed out
> [19513.331785] nfs: server gula not responding, timed out
> [19517.427759] nfs: server pappnase not responding, timed out
> [19523.571790] nfs: server aquaphobie not responding, timed out
> [19523.571793] nfs: server botanophobie not responding, timed out
> [19523.571807] nfs: server gula not responding, timed out
> [19527.668792] nfs: server pappnase not responding, timed out
> [19533.811784] nfs: server botanophobie not responding, timed out
> [19533.811791] nfs: server gula not responding, timed out
> [19533.811796] nfs: server aquaphobie not responding, timed out
> [19535.052658] rcu: INFO: rcu_sched self-detected stall on CPU
> [19535.059367] rcu: 	46-....: (8670774 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=1960699 
> [19535.070714] 	(t=8700162 jiffies g=2794673 q=1288303)
> [19535.076564] Sending NMI from CPU 46 to CPUs 5:
> [19535.082892] NMI backtrace for cpu 5
> [19535.082893] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19535.082894] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19535.082895] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [19535.082896] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [19535.082897] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [19535.082898] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [19535.082899] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [19535.082899] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [19535.082900] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [19535.082900] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [19535.082901] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [19535.082902] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19535.082902] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [19535.082903] Call Trace:
> [19535.082903]  _raw_spin_lock_irqsave+0x22/0x30
> [19535.082903]  pagevec_lru_move_fn+0x6c/0xd0
> [19535.082904]  activate_page+0xb5/0xc0
> [19535.082904]  mark_page_accessed+0x7a/0x130
> [19535.082905]  generic_file_read_iter+0x4c8/0xae0
> [19535.082905]  ? generic_update_time+0x9c/0xc0
> [19535.082906]  ? pipe_write+0x286/0x400
> [19535.082906]  new_sync_read+0x114/0x1a0
> [19535.082906]  vfs_read+0x89/0x130
> [19535.082907]  ksys_read+0xa1/0xe0
> [19535.082907]  do_syscall_64+0x48/0x130
> [19535.082908]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [19535.082908] RIP: 0033:0x7fc44b933d71
> [19535.082909] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [19535.082910] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [19535.082911] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [19535.082912] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [19535.082912] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [19535.082913] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [19535.082913] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [19535.082943] NMI backtrace for cpu 46
> [19535.346609] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19535.357657] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19535.366248] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [19535.373964] Call Trace:
> [19535.377506]  <IRQ>
> [19535.380616]  dump_stack+0x50/0x6b
> [19535.385035]  nmi_cpu_backtrace+0x89/0x90
> [19535.390011]  ? lapic_can_unplug_cpu+0x90/0x90
> [19535.395396]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [19535.401398]  rcu_dump_cpu_stacks+0x99/0xd0
> [19535.406535]  rcu_sched_clock_irq+0x502/0x770
> [19535.411828]  ? tick_sched_do_timer+0x60/0x60
> [19535.417094]  update_process_times+0x24/0x50
> [19535.422267]  tick_sched_timer+0x37/0x70
> [19535.427064]  __hrtimer_run_queues+0x11f/0x2b0
> [19535.432351]  hrtimer_interrupt+0xe5/0x240
> [19535.437274]  smp_apic_timer_interrupt+0x6f/0x130
> [19535.442797]  apic_timer_interrupt+0xf/0x20
> [19535.447836]  </IRQ>
> [19535.450857] RIP: 0010:smp_call_function_many+0x22f/0x260
> [19535.457064] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [19535.477695] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [19535.486208] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [19535.494297] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [19535.502367] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [19535.510445] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [19535.518535] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [19535.526625]  ? native_set_ldt.part.10+0xc0/0xc0
> [19535.532118]  ? smp_call_function_many+0x20a/0x260
> [19535.537789]  ? native_set_ldt.part.10+0xc0/0xc0
> [19535.543284]  on_each_cpu+0x28/0x40
> [19535.547658]  flush_tlb_kernel_range+0x79/0x80
> [19535.552976]  pmd_free_pte_page+0x41/0x60
> [19535.557875]  ioremap_page_range+0x30f/0x560
> [19535.563039]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19535.568298]  __ioremap_caller.constprop.18+0x1a8/0x300
> [19535.574422]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19535.579511]  ? _cond_resched+0x15/0x40
> [19535.584231]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [19535.590310]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [19535.596770]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [19535.603796]  drm_gem_vmap+0x1f/0x60 [drm]
> [19535.608783]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [19535.614635]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [19535.621669]  process_one_work+0x1e5/0x410
> [19535.626621]  worker_thread+0x2d/0x3c0
> [19535.631222]  ? cancel_delayed_work+0x90/0x90
> [19535.636413]  kthread+0x117/0x130
> [19535.640532]  ? kthread_create_worker_on_cpu+0x70/0x70
> [19535.646473]  ret_from_fork+0x22/0x40
> [19537.907800] nfs: server pappnase not responding, timed out
> [19544.051810] nfs: server botanophobie not responding, timed out
> [19544.052820] nfs: server aquaphobie not responding, timed out
> [19544.052828] nfs: server gula not responding, timed out
> [19548.147828] nfs: server pappnase not responding, timed out
> [19554.291831] nfs: server botanophobie not responding, timed out
> [19554.291836] nfs: server gula not responding, timed out
> [19554.292836] nfs: server aquaphobie not responding, timed out
> [19558.387839] nfs: server pappnase not responding, timed out
> [19564.531845] nfs: server gula not responding, timed out
> [19564.532855] nfs: server botanophobie not responding, timed out
> [19564.532858] nfs: server aquaphobie not responding, timed out
> [19568.627853] nfs: server pappnase not responding, timed out
> [19574.771872] nfs: server gula not responding, timed out
> [19574.772871] nfs: server botanophobie not responding, timed out
> [19574.772876] nfs: server aquaphobie not responding, timed out
> [19578.868922] nfs: server pappnase not responding, timed out
> [19585.011897] nfs: server gula not responding, timed out
> [19585.011900] nfs: server aquaphobie not responding, timed out
> [19585.012896] nfs: server botanophobie not responding, timed out
> [19589.107906] nfs: server pappnase not responding, timed out
> [19595.251909] nfs: server botanophobie not responding, timed out
> [19595.251917] nfs: server aquaphobie not responding, timed out
> [19595.252014] nfs: server gula not responding, timed out
> [19599.347924] nfs: server pappnase not responding, timed out
> [19605.491928] nfs: server botanophobie not responding, timed out
> [19605.491934] nfs: server gula not responding, timed out
> [19605.492934] nfs: server aquaphobie not responding, timed out
> [19609.587939] nfs: server pappnase not responding, timed out
> [19615.731945] nfs: server botanophobie not responding, timed out
> [19615.731956] nfs: server gula not responding, timed out
> [19615.732958] nfs: server aquaphobie not responding, timed out
> [19619.827968] nfs: server pappnase not responding, timed out
> [19625.971980] nfs: server gula not responding, timed out
> [19625.972847] nfs: server aquaphobie not responding, timed out
> [19625.972991] nfs: server botanophobie not responding, timed out
> [19630.068982] nfs: server pappnase not responding, timed out
> [19636.211994] nfs: server gula not responding, timed out
> [19636.212998] nfs: server botanophobie not responding, timed out
> [19636.213004] nfs: server aquaphobie not responding, timed out
> [19640.308044] nfs: server pappnase not responding, timed out
> [19642.357023] nfs: server afk not responding, timed out
> [19646.452013] nfs: server aquaphobie not responding, timed out
> [19646.452056] nfs: server gula not responding, timed out
> [19646.453022] nfs: server botanophobie not responding, timed out
> [19650.548051] nfs: server pappnase not responding, timed out
> [19656.692025] nfs: server botanophobie not responding, timed out
> [19656.692032] nfs: server gula not responding, timed out
> [19656.692036] nfs: server aquaphobie not responding, timed out
> [19660.788046] nfs: server pappnase not responding, timed out
> [19662.837053] nfs: server aquaphobie not responding, timed out
> [19662.837058] nfs: server gula not responding, timed out
> [19662.837062] nfs: server botanophobie not responding, timed out
> [19666.933073] nfs: server pappnase not responding, timed out
> [19667.764047] nfs: server botanophobie not responding, timed out
> [19667.764927] nfs: server aquaphobie not responding, timed out
> [19667.765065] nfs: server gula not responding, timed out
> [19671.860096] nfs: server pappnase not responding, timed out
> [19678.197068] nfs: server botanophobie not responding, timed out
> [19678.197084] nfs: server aquaphobie not responding, timed out
> [19678.197087] nfs: server gula not responding, timed out
> [19682.293094] nfs: server pappnase not responding, timed out
> [19688.436096] nfs: server aquaphobie not responding, timed out
> [19688.437099] nfs: server gula not responding, timed out
> [19688.437101] nfs: server botanophobie not responding, timed out
> [19692.533106] nfs: server pappnase not responding, timed out
> [19698.676110] nfs: server botanophobie not responding, timed out
> [19698.676121] nfs: server aquaphobie not responding, timed out
> [19698.677119] nfs: server gula not responding, timed out
> [19699.701122] nfs: server afk not responding, timed out
> [19702.773126] nfs: server pappnase not responding, timed out
> [19708.917144] nfs: server gula not responding, timed out
> [19708.917147] nfs: server botanophobie not responding, timed out
> [19708.917149] nfs: server aquaphobie not responding, timed out
> [19713.013151] nfs: server pappnase not responding, timed out
> [19715.056010] rcu: INFO: rcu_sched self-detected stall on CPU
> [19715.062745] rcu: 	46-....: (8850180 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=2002698 
> [19715.074134] 	(t=8880166 jiffies g=2794673 q=1289011)
> [19715.080079] Sending NMI from CPU 46 to CPUs 5:
> [19715.086411] NMI backtrace for cpu 5
> [19715.086412] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19715.086412] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19715.086413] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [19715.086415] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [19715.086415] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [19715.086416] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [19715.086417] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [19715.086418] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [19715.086418] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [19715.086419] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [19715.086420] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [19715.086420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19715.086421] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [19715.086421] Call Trace:
> [19715.086422]  _raw_spin_lock_irqsave+0x22/0x30
> [19715.086422]  pagevec_lru_move_fn+0x6c/0xd0
> [19715.086422]  activate_page+0xb5/0xc0
> [19715.086423]  mark_page_accessed+0x7a/0x130
> [19715.086423]  generic_file_read_iter+0x4c8/0xae0
> [19715.086424]  ? generic_update_time+0x9c/0xc0
> [19715.086424]  ? pipe_write+0x286/0x400
> [19715.086425]  new_sync_read+0x114/0x1a0
> [19715.086425]  vfs_read+0x89/0x130
> [19715.086425]  ksys_read+0xa1/0xe0
> [19715.086426]  do_syscall_64+0x48/0x130
> [19715.086426]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [19715.086427] RIP: 0033:0x7fc44b933d71
> [19715.086428] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [19715.086429] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [19715.086430] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [19715.086430] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [19715.086431] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [19715.086432] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [19715.086432] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [19715.086457] NMI backtrace for cpu 46
> [19715.350371] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19715.361362] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19715.369938] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [19715.377713] Call Trace:
> [19715.381263]  <IRQ>
> [19715.384368]  dump_stack+0x50/0x6b
> [19715.388767]  nmi_cpu_backtrace+0x89/0x90
> [19715.393750]  ? lapic_can_unplug_cpu+0x90/0x90
> [19715.399142]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [19715.405142]  rcu_dump_cpu_stacks+0x99/0xd0
> [19715.410271]  rcu_sched_clock_irq+0x502/0x770
> [19715.415557]  ? tick_sched_do_timer+0x60/0x60
> [19715.420829]  update_process_times+0x24/0x50
> [19715.426012]  tick_sched_timer+0x37/0x70
> [19715.430793]  __hrtimer_run_queues+0x11f/0x2b0
> [19715.436088]  hrtimer_interrupt+0xe5/0x240
> [19715.441019]  smp_apic_timer_interrupt+0x6f/0x130
> [19715.446535]  apic_timer_interrupt+0xf/0x20
> [19715.451539]  </IRQ>
> [19715.454533] RIP: 0010:smp_call_function_many+0x22f/0x260
> [19715.460742] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [19715.481381] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [19715.489881] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [19715.497950] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [19715.506026] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [19715.514125] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [19715.522233] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [19715.530330]  ? native_set_ldt.part.10+0xc0/0xc0
> [19715.535824]  ? smp_call_function_many+0x20a/0x260
> [19715.541489]  ? native_set_ldt.part.10+0xc0/0xc0
> [19715.546979]  on_each_cpu+0x28/0x40
> [19715.551345]  flush_tlb_kernel_range+0x79/0x80
> [19715.556666]  pmd_free_pte_page+0x41/0x60
> [19715.561562]  ioremap_page_range+0x30f/0x560
> [19715.566733]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19715.572009]  __ioremap_caller.constprop.18+0x1a8/0x300
> [19715.578148]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19715.583236]  ? _cond_resched+0x15/0x40
> [19715.587950]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [19715.594026]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [19715.600431]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [19715.607457]  drm_gem_vmap+0x1f/0x60 [drm]
> [19715.612394]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [19715.618212]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [19715.625251]  process_one_work+0x1e5/0x410
> [19715.630211]  worker_thread+0x2d/0x3c0
> [19715.634806]  ? cancel_delayed_work+0x90/0x90
> [19715.639991]  kthread+0x117/0x130
> [19715.644126]  ? kthread_create_worker_on_cpu+0x70/0x70
> [19715.650063]  ret_from_fork+0x22/0x40
> [19719.156157] nfs: server aquaphobie not responding, timed out
> [19719.157147] nfs: server botanophobie not responding, timed out
> [19719.157161] nfs: server gula not responding, timed out
> [19723.253168] nfs: server pappnase not responding, timed out
> [19729.397177] nfs: server gula not responding, timed out
> [19729.397180] nfs: server aquaphobie not responding, timed out
> [19729.397185] nfs: server botanophobie not responding, timed out
> [19733.493188] nfs: server pappnase not responding, timed out
> [19739.636209] nfs: server aquaphobie not responding, timed out
> [19739.637205] nfs: server gula not responding, timed out
> [19739.637208] nfs: server botanophobie not responding, timed out
> [19743.733212] nfs: server pappnase not responding, timed out
> [19749.876235] nfs: server botanophobie not responding, timed out
> [19749.876238] nfs: server aquaphobie not responding, timed out
> [19749.877211] nfs: server gula not responding, timed out
> [19753.973228] nfs: server pappnase not responding, timed out
> [19759.924268] nfs: server gula not responding, timed out
> [19759.925108] nfs: server aquaphobie not responding, timed out
> [19759.925230] nfs: server botanophobie not responding, timed out
> [19764.021249] nfs: server pappnase not responding, timed out
> [19770.356259] nfs: server botanophobie not responding, timed out
> [19770.356264] nfs: server gula not responding, timed out
> [19770.357256] nfs: server aquaphobie not responding, timed out
> [19774.452275] nfs: server pappnase not responding, timed out
> [19780.596274] nfs: server aquaphobie not responding, timed out
> [19780.596277] nfs: server botanophobie not responding, timed out
> [19780.597282] nfs: server gula not responding, timed out
> [19784.693306] nfs: server pappnase not responding, timed out
> [19790.836302] nfs: server aquaphobie not responding, timed out
> [19790.837298] nfs: server gula not responding, timed out
> [19790.837305] nfs: server botanophobie not responding, timed out
> [19794.933340] nfs: server pappnase not responding, timed out
> [19801.076315] nfs: server aquaphobie not responding, timed out
> [19801.077192] nfs: server botanophobie not responding, timed out
> [19801.077326] nfs: server gula not responding, timed out
> [19805.173353] nfs: server pappnase not responding, timed out
> [19811.316343] nfs: server aquaphobie not responding, timed out
> [19811.317333] nfs: server botanophobie not responding, timed out
> [19811.317338] nfs: server gula not responding, timed out
> [19815.413376] nfs: server pappnase not responding, timed out
> [19821.556355] nfs: server aquaphobie not responding, timed out
> [19821.557358] nfs: server botanophobie not responding, timed out
> [19821.557361] nfs: server gula not responding, timed out
> [19822.581367] nfs: server afk not responding, timed out
> [19825.653390] nfs: server pappnase not responding, timed out
> [19831.796382] nfs: server aquaphobie not responding, timed out
> [19831.797377] nfs: server gula not responding, timed out
> [19831.797385] nfs: server botanophobie not responding, timed out
> [19835.893412] nfs: server pappnase not responding, timed out
> [19842.036393] nfs: server aquaphobie not responding, timed out
> [19842.037270] nfs: server botanophobie not responding, timed out
> [19842.037402] nfs: server gula not responding, timed out
> [19842.868395] nfs: server aquaphobie not responding, timed out
> [19842.869275] nfs: server botanophobie not responding, timed out
> [19842.869391] nfs: server gula not responding, timed out
> [19846.133427] nfs: server pappnase not responding, timed out
> [19846.965415] nfs: server pappnase not responding, timed out
> [19853.300412] nfs: server botanophobie not responding, timed out
> [19853.300418] nfs: server aquaphobie not responding, timed out
> [19853.300421] nfs: server gula not responding, timed out
> [19857.396429] nfs: server pappnase not responding, timed out
> [19863.540433] nfs: server gula not responding, timed out
> [19863.540437] nfs: server aquaphobie not responding, timed out
> [19863.541445] nfs: server botanophobie not responding, timed out
> [19867.636443] nfs: server pappnase not responding, timed out
> [19873.780459] nfs: server botanophobie not responding, timed out
> [19873.780467] nfs: server aquaphobie not responding, timed out
> [19873.781457] nfs: server gula not responding, timed out
> [19877.877495] nfs: server pappnase not responding, timed out
> [19884.020475] nfs: server aquaphobie not responding, timed out
> [19884.021482] nfs: server botanophobie not responding, timed out
> [19884.021485] nfs: server gula not responding, timed out
> [19888.117483] nfs: server afk not responding, timed out
> [19888.117488] nfs: server pappnase not responding, timed out
> [19894.260512] nfs: server botanophobie not responding, timed out
> [19894.260518] nfs: server aquaphobie not responding, timed out
> [19894.261500] nfs: server gula not responding, timed out
> [19895.059363] rcu: INFO: rcu_sched self-detected stall on CPU
> [19895.065797] rcu: 	46-....: (9029586 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=2044219 
> [19895.077108] 	(t=9060168 jiffies g=2794673 q=1289678)
> [19895.082949] Sending NMI from CPU 46 to CPUs 5:
> [19895.089268] NMI backtrace for cpu 5
> [19895.089269] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19895.089270] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19895.089270] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [19895.089271] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [19895.089272] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [19895.089273] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [19895.089274] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [19895.089275] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [19895.089275] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [19895.089276] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [19895.089276] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [19895.089277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19895.089278] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [19895.089278] Call Trace:
> [19895.089279]  _raw_spin_lock_irqsave+0x22/0x30
> [19895.089279]  pagevec_lru_move_fn+0x6c/0xd0
> [19895.089279]  activate_page+0xb5/0xc0
> [19895.089280]  mark_page_accessed+0x7a/0x130
> [19895.089280]  generic_file_read_iter+0x4c8/0xae0
> [19895.089281]  ? generic_update_time+0x9c/0xc0
> [19895.089281]  ? pipe_write+0x286/0x400
> [19895.089282]  new_sync_read+0x114/0x1a0
> [19895.089282]  vfs_read+0x89/0x130
> [19895.089282]  ksys_read+0xa1/0xe0
> [19895.089283]  do_syscall_64+0x48/0x130
> [19895.089283]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [19895.089284] RIP: 0033:0x7fc44b933d71
> [19895.089285] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [19895.089286] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [19895.089287] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [19895.089287] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [19895.089288] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [19895.089288] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [19895.089289] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [19895.089313] NMI backtrace for cpu 46
> [19895.352671] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [19895.363665] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [19895.372240] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [19895.379967] Call Trace:
> [19895.383516]  <IRQ>
> [19895.386614]  dump_stack+0x50/0x6b
> [19895.391018]  nmi_cpu_backtrace+0x89/0x90
> [19895.396000]  ? lapic_can_unplug_cpu+0x90/0x90
> [19895.401393]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [19895.407423]  rcu_dump_cpu_stacks+0x99/0xd0
> [19895.412553]  rcu_sched_clock_irq+0x502/0x770
> [19895.417844]  ? tick_sched_do_timer+0x60/0x60
> [19895.423106]  update_process_times+0x24/0x50
> [19895.428270]  tick_sched_timer+0x37/0x70
> [19895.433060]  __hrtimer_run_queues+0x11f/0x2b0
> [19895.438362]  hrtimer_interrupt+0xe5/0x240
> [19895.443276]  smp_apic_timer_interrupt+0x6f/0x130
> [19895.448804]  apic_timer_interrupt+0xf/0x20
> [19895.453811]  </IRQ>
> [19895.456808] RIP: 0010:smp_call_function_many+0x22f/0x260
> [19895.463018] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [19895.483653] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [19895.492169] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [19895.500242] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [19895.508317] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [19895.516400] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [19895.524482] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [19895.532587]  ? native_set_ldt.part.10+0xc0/0xc0
> [19895.538080]  ? smp_call_function_many+0x20a/0x260
> [19895.543751]  ? native_set_ldt.part.10+0xc0/0xc0
> [19895.549244]  on_each_cpu+0x28/0x40
> [19895.553609]  flush_tlb_kernel_range+0x79/0x80
> [19895.558939]  pmd_free_pte_page+0x41/0x60
> [19895.563839]  ioremap_page_range+0x30f/0x560
> [19895.569011]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19895.574272]  __ioremap_caller.constprop.18+0x1a8/0x300
> [19895.580404]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [19895.585500]  ? _cond_resched+0x15/0x40
> [19895.590217]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [19895.596296]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [19895.602710]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [19895.609730]  drm_gem_vmap+0x1f/0x60 [drm]
> [19895.614663]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [19895.620484]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [19895.627548]  process_one_work+0x1e5/0x410
> [19895.632506]  worker_thread+0x2d/0x3c0
> [19895.637120]  ? cancel_delayed_work+0x90/0x90
> [19895.642302]  kthread+0x117/0x130
> [19895.646426]  ? kthread_create_worker_on_cpu+0x70/0x70
> [19895.652365]  ret_from_fork+0x22/0x40
> [19898.357504] nfs: server pappnase not responding, timed out
> [19904.500537] nfs: server aquaphobie not responding, timed out
> [19904.500541] nfs: server botanophobie not responding, timed out
> [19904.501512] nfs: server gula not responding, timed out
> [19908.597530] nfs: server pappnase not responding, timed out
> [19914.740526] nfs: server botanophobie not responding, timed out
> [19914.740535] nfs: server aquaphobie not responding, timed out
> [19914.741545] nfs: server gula not responding, timed out
> [19918.837555] nfs: server pappnase not responding, timed out
> [19924.980560] nfs: server aquaphobie not responding, timed out
> [19924.980563] nfs: server botanophobie not responding, timed out
> [19924.981565] nfs: server gula not responding, timed out
> [19929.077575] nfs: server pappnase not responding, timed out
> [19935.220574] nfs: server botanophobie not responding, timed out
> [19935.220576] nfs: server aquaphobie not responding, timed out
> [19935.221585] nfs: server gula not responding, timed out
> [19939.317592] nfs: server pappnase not responding, timed out
> [19945.460590] nfs: server gula not responding, timed out
> [19945.461608] nfs: server aquaphobie not responding, timed out
> [19945.461612] nfs: server botanophobie not responding, timed out
> [19949.556610] nfs: server pappnase not responding, timed out
> [19955.700633] nfs: server botanophobie not responding, timed out
> [19955.701628] nfs: server aquaphobie not responding, timed out
> [19955.701631] nfs: server gula not responding, timed out
> [19959.796659] nfs: server pappnase not responding, timed out
> [19965.941620] nfs: server botanophobie not responding, timed out
> [19965.941645] nfs: server gula not responding, timed out
> [19965.941655] nfs: server aquaphobie not responding, timed out
> [19970.037652] nfs: server pappnase not responding, timed out
> [19976.180660] nfs: server aquaphobie not responding, timed out
> [19976.181664] nfs: server botanophobie not responding, timed out
> [19976.181667] nfs: server gula not responding, timed out
> [19980.277668] nfs: server pappnase not responding, timed out
> [19986.420686] nfs: server aquaphobie not responding, timed out
> [19986.421686] nfs: server gula not responding, timed out
> [19986.421690] nfs: server botanophobie not responding, timed out
> [19990.517687] nfs: server pappnase not responding, timed out
> [19996.660704] nfs: server aquaphobie not responding, timed out
> [19996.661691] nfs: server botanophobie not responding, timed out
> [19996.661698] nfs: server gula not responding, timed out
> [20000.757710] nfs: server pappnase not responding, timed out
> [20002.804709] nfs: server afk not responding, timed out
> [20006.900722] nfs: server aquaphobie not responding, timed out
> [20006.901740] nfs: server gula not responding, timed out
> [20006.901745] nfs: server botanophobie not responding, timed out
> [20010.997731] nfs: server pappnase not responding, timed out
> [20017.140739] nfs: server aquaphobie not responding, timed out
> [20017.141766] nfs: server botanophobie not responding, timed out
> [20017.141770] nfs: server gula not responding, timed out
> [20021.237752] nfs: server pappnase not responding, timed out
> [20023.284756] nfs: server aquaphobie not responding, timed out
> [20023.285765] nfs: server gula not responding, timed out
> [20023.285772] nfs: server botanophobie not responding, timed out
> [20027.381793] nfs: server pappnase not responding, timed out
> [20028.212762] nfs: server aquaphobie not responding, timed out
> [20028.212765] nfs: server botanophobie not responding, timed out
> [20028.212770] nfs: server gula not responding, timed out
> [20032.308765] nfs: server pappnase not responding, timed out
> [20038.644773] nfs: server aquaphobie not responding, timed out
> [20038.644781] nfs: server gula not responding, timed out
> [20038.645798] nfs: server botanophobie not responding, timed out
> [20042.740789] nfs: server pappnase not responding, timed out
> [20048.884803] nfs: server gula not responding, timed out
> [20048.884809] nfs: server aquaphobie not responding, timed out
> [20048.885822] nfs: server botanophobie not responding, timed out
> [20052.980820] nfs: server pappnase not responding, timed out
> [20059.124821] nfs: server aquaphobie not responding, timed out
> [20059.124825] nfs: server gula not responding, timed out
> [20059.125855] nfs: server botanophobie not responding, timed out
> [20063.220844] nfs: server pappnase not responding, timed out
> [20069.364835] nfs: server gula not responding, timed out
> [20069.364843] nfs: server aquaphobie not responding, timed out
> [20069.365870] nfs: server botanophobie not responding, timed out
> [20073.460854] nfs: server pappnase not responding, timed out
> [20075.062717] rcu: INFO: rcu_sched self-detected stall on CPU
> [20075.069434] rcu: 	46-....: (9208993 ticks this GP) idle=cea/1/0x4000000000000002 softirq=216900/216900 fqs=2085394 
> [20075.080740] 	(t=9240171 jiffies g=2794673 q=1290975)
> [20075.086578] Sending NMI from CPU 46 to CPUs 5:
> [20075.092926] NMI backtrace for cpu 5
> [20075.092927] CPU: 5 PID: 22509 Comm: tar Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [20075.092928] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [20075.092929] RIP: 0010:queued_spin_lock_slowpath+0x3e/0x1a0
> [20075.092930] Code: ff ff ff 75 3d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 17 85 c0 75 04 eb 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [20075.092930] RSP: 0018:ffffc900155e7cf0 EFLAGS: 00000002
> [20075.092932] RAX: 0000000000580101 RBX: 0000000000000246 RCX: ffffffff82572d60
> [20075.092932] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c01ffff500
> [20075.092933] RBP: ffff888fdfb66500 R08: 00006000212009c0 R09: ffffea0122fa8988
> [20075.092934] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000246
> [20075.092934] R13: ffffffff811b60e0 R14: ffff88c01fffc000 R15: ffffea00e0d11a80
> [20075.092935] FS:  00007fc44be29740(0000) GS:ffff888fdfb40000(0000) knlGS:0000000000000000
> [20075.092935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [20075.092936] CR2: 00000000006e7718 CR3: 0000000fc971a000 CR4: 00000000000406e0
> [20075.092936] Call Trace:
> [20075.092937]  _raw_spin_lock_irqsave+0x22/0x30
> [20075.092937]  pagevec_lru_move_fn+0x6c/0xd0
> [20075.092938]  activate_page+0xb5/0xc0
> [20075.092938]  mark_page_accessed+0x7a/0x130
> [20075.092939]  generic_file_read_iter+0x4c8/0xae0
> [20075.092939]  ? generic_update_time+0x9c/0xc0
> [20075.092939]  ? pipe_write+0x286/0x400
> [20075.092940]  new_sync_read+0x114/0x1a0
> [20075.092940]  vfs_read+0x89/0x130
> [20075.092941]  ksys_read+0xa1/0xe0
> [20075.092941]  do_syscall_64+0x48/0x130
> [20075.092942]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [20075.092942] RIP: 0033:0x7fc44b933d71
> [20075.092943] Code: 31 c0 48 83 c4 08 e9 6e fe ff ff 48 8d 3d 17 6b 09 00 e8 f2 eb 01 00 66 90 48 8d 05 f1 0b 2d 00 8b 00 85 c0 75 2b 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 e1 b0 2c 00
> [20075.092944] RSP: 002b:00007fffe8e95718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [20075.092945] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fc44b933d71
> [20075.092945] RDX: 0000000000002800 RSI: 00000000006a8000 RDI: 0000000000000005
> [20075.092946] RBP: 0000000000000005 R08: 00000000006a8000 R09: 0000000000000007
> [20075.092947] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000006a8000
> [20075.092947] R13: 0000000000000005 R14: 0000000000080150 R15: 00007fffe8e958e0
> [20075.092971] NMI backtrace for cpu 46
> [20075.355652] CPU: 46 PID: 4665 Comm: kworker/46:0 Kdump: loaded Tainted: G      D           5.4.14.mx64.317 #1
> [20075.366626] Hardware name: Dell Inc. PowerEdge R815/0THJFH, BIOS 3.2.2 09/15/2014
> [20075.375184] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [20075.382851] Call Trace:
> [20075.386339]  <IRQ>
> [20075.389453]  dump_stack+0x50/0x6b
> [20075.393841]  nmi_cpu_backtrace+0x89/0x90
> [20075.398833]  ? lapic_can_unplug_cpu+0x90/0x90
> [20075.404172]  nmi_trigger_cpumask_backtrace+0xc4/0xf0
> [20075.410172]  rcu_dump_cpu_stacks+0x99/0xd0
> [20075.415297]  rcu_sched_clock_irq+0x502/0x770
> [20075.420520]  ? tick_sched_do_timer+0x60/0x60
> [20075.425812]  update_process_times+0x24/0x50
> [20075.430994]  tick_sched_timer+0x37/0x70
> [20075.435730]  __hrtimer_run_queues+0x11f/0x2b0
> [20075.440994]  hrtimer_interrupt+0xe5/0x240
> [20075.445863]  smp_apic_timer_interrupt+0x6f/0x130
> [20075.451426]  apic_timer_interrupt+0xf/0x20
> [20075.456376]  </IRQ>
> [20075.459366] RIP: 0010:smp_call_function_many+0x22f/0x260
> [20075.465515] Code: e8 96 f3 9a 00 3b 05 a4 84 47 01 0f 83 63 fe ff ff 48 63 c8 48 8b 55 00 48 03 14 cd a0 d6 32 82 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c7 0f 0b e9 11 fe ff ff 48 c7 c2 e0 2f
> [20075.486097] RSP: 0018:ffffc9000e92fc18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [20075.494609] RAX: 0000000000000005 RBX: ffff88bfdfba98a8 RCX: 0000000000000001
> [20075.502681] RDX: ffffe89000d47b20 RSI: 0000000000000000 RDI: ffff88bfdfba9888
> [20075.510726] RBP: ffff88bfdfba9880 R08: 0000000000000004 R09: 0000000000000004
> [20075.518767] R10: ffff88bfdfba9888 R11: 0000000000000004 R12: ffff88bfdfba9888
> [20075.526830] R13: 0000000000000100 R14: ffffffff81060ea0 R15: ffff88bfdfba8380
> [20075.534873]  ? native_set_ldt.part.10+0xc0/0xc0
> [20075.540351]  ? smp_call_function_many+0x20a/0x260
> [20075.546025]  ? native_set_ldt.part.10+0xc0/0xc0
> [20075.551517]  on_each_cpu+0x28/0x40
> [20075.555842]  flush_tlb_kernel_range+0x79/0x80
> [20075.561173]  pmd_free_pte_page+0x41/0x60
> [20075.566019]  ioremap_page_range+0x30f/0x560
> [20075.571185]  ? ttm_bo_kmap+0x1e4/0x280 [ttm]
> [20075.576392]  __ioremap_caller.constprop.18+0x1a8/0x300
> [20075.582514]  ttm_bo_kmap+0x1e4/0x280 [ttm]
> [20075.587606]  ? _cond_resched+0x15/0x40
> [20075.592282]  ? ttm_bo_del_sub_from_lru+0x26/0x30 [ttm]
> [20075.598361]  drm_gem_vram_kmap+0x54/0x70 [drm_vram_helper]
> [20075.604773]  drm_gem_vram_object_vmap+0x23/0x40 [drm_vram_helper]
> [20075.611755]  drm_gem_vmap+0x1f/0x60 [drm]
> [20075.616675]  drm_client_buffer_vmap+0x1d/0x30 [drm]
> [20075.622476]  drm_fb_helper_dirty_work+0x92/0x180 [drm_kms_helper]
> [20075.629519]  process_one_work+0x1e5/0x410
> [20075.634426]  worker_thread+0x2d/0x3c0
> [20075.639023]  ? cancel_delayed_work+0x90/0x90
> [20075.644158]  kthread+0x117/0x130
> [20075.648278]  ? kthread_create_worker_on_cpu+0x70/0x70
> [20075.654215]  ret_from_fork+0x22/0x40




-- 
Michal Hocko
SUSE Labs
