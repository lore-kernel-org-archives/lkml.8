Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41092C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E4920720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="BSNviLIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBFH0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:26:34 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35299 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBFH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:26:33 -0500
Received: by mail-vs1-f68.google.com with SMTP id x123so3157066vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 23:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JUSrIWljLZiQAdYA8OR3m0qEhDa+P7lRjn7Jwv/yp0Y=;
        b=BSNviLIYOKU0eA0Tol2ZMKGjOshfAFELQKFV+KP803wtoauvXzSB0+PlIuMkbtPN50
         usTsbanfLewc6VghkSyhzR/tFqKQsoT6XOkgRMui35y8YNCw2JJMaYjoi41QXdCE5fOM
         vElJo67AARovaRk/mv7JbBW98u0S2jhKdFtBrVkKUnOIwdVzpXHV7guAzrpMtwYqRZVi
         DUJPHpTYeCo/DO+g6nxcdbcNw2LzBEtRuXkyiHD7lyIQIr2wZXXdM1zdtz6HNzueWLXp
         JBwqaJaH4+1nSIH330ME9RGoOIXOd6SWJ5Bb2CmVulQRkdfVTbQsUEPWsUyWwbvgEBwo
         qZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JUSrIWljLZiQAdYA8OR3m0qEhDa+P7lRjn7Jwv/yp0Y=;
        b=iwoJJinntsThw1vHkkeRDPFLaNDz5JY9F5GqaFuRvh4SrtW8+XBwBbKRmAp/ciEYO2
         RuaptNNeRIzWp2c/9vJSM9PM/m/Ve2iH2H6XLVQzEND+w/OnHcptRSu8piFaKz7TCoHy
         Qbgw02BzagYZKhJXAwc5XJrTKK/2IiEWnC7HjujqlzFxHQALCh4XOxRR5BUDhBVZrLz7
         nn8XfA3fzX3xZ1JKxKsKi9gRVKocu7Q6URsms57khJg+iS33IUKkf2OXlnD0XN5uvmJn
         yINJQhCcDaPHlzkpwRvcfy9JO4vTJgUvayTi4YzQH0eDYUEYYxkMVHh1uG2UW5gVrXPP
         NDjg==
X-Gm-Message-State: APjAAAVi1Ngx8GytH2VLwZY+fufRCRpPv31fXH7UirfJ8LPrA8qU1bv2
        umdX64SxMC3gF12RezAlMH4waHJh9AX7SxS5tTyH2w==
X-Google-Smtp-Source: APXvYqx/KOmpudOiOHvSL6H90ncNLbKPHXv63QYZEEwWlX7f+TzDrjWmNZVib6m++dFVUs2k5FNy5t1yne56uoRwbXU=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr888207vsq.206.1580973991857;
 Wed, 05 Feb 2020 23:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com> <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
 <948da337-128f-22ae-7b2e-730b4b8da446@linux.intel.com> <CAPpJ_ecM0oCUjYLbG+uTprRk0=OTUBTxZc-d2BGBRDSYWk4uSQ@mail.gmail.com>
In-Reply-To: <CAPpJ_ecM0oCUjYLbG+uTprRk0=OTUBTxZc-d2BGBRDSYWk4uSQ@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Thu, 6 Feb 2020 15:25:48 +0800
Message-ID: <CAPpJ_efn0jwHf8rWjBm0=BwrFd=z7MATWkNsqNfHuyrn4wAt+w@mail.gmail.com>
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no IOMMU
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jian-Hong Pan <jian-hong@endlessm.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:06=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Lu Baolu <baolu.lu@linux.intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:28=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi,
> >
> > On 2020/2/4 17:25, Jian-Hong Pan wrote:
> > > Lu Baolu <baolu.lu@linux.intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=88=
4=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >>
> > >> Hi,
> > >>
> > >> On 2020/2/3 17:10, Jian-Hong Pan wrote:
> > >>> If the device has no IOMMU, it still invokes iommu_need_mapping dur=
ing
> > >>> intel_alloc_coherent. However, iommu_need_mapping can only check th=
e
> > >>> device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the dev=
ice
> > >>> is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.
> > >>>
> > >>> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > >>> ---
> > >>>    drivers/iommu/intel-iommu.c | 4 +++-
> > >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iomm=
u.c
> > >>> index 35a4a3abedc6..878bc986a015 100644
> > >>> --- a/drivers/iommu/intel-iommu.c
> > >>> +++ b/drivers/iommu/intel-iommu.c
> > >>> @@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct dev=
ice *dev)
> > >>>        int ret;
> > >>>
> > >>>        iommu =3D device_to_iommu(dev, &bus, &devfn);
> > >>> -     if (!iommu)
> > >>> +     if (!iommu) {
> > >>> +             dev->archdata.iommu =3D DUMMY_DEVICE_DOMAIN_INFO;
> > >>
> > >> Is this a DMA capable device?
> > >
> > > Do you mean is the device in DMA Remapping table?
> > > Dump DMAR from ACPI table.  The device is not in the table.
> > > So, it does not support DMAR, Intel IOMMU.
> > >
> > > Or, should device_to_iommu be invoked in iommu_need_mapping to check
> > > IOMMU feature again?
> > >
> >
> > Normally intel_iommu_add_device() should only be called for PCI devices
> > and APCI name space devices (reported in ACPI/DMAR table). In both
> > cases, device_to_iommu() should always return a corresponding iommu. I
> > just tried to understand why it failed for your case.

Hi,

Here is the original issue: There are more and more laptops equipped
with Intel Rapid Storage Technology (RST) feature.  That makes the
NVMe SSD hidden and as the cache.  However, there is no built in
driver for it.  So, Daniel prepares a driver called intel-nvme-remap
[1] to remap and show up the hidden NVMe SSD and make it as a normal
SSD.  The driver is developed and refers to
drivers/pci/controller/vmd.c.

Recently, we get a laptop with Intel RST feature enabled in BIOS and
two NVMe SSDs after the RAID bus controller.  So, those two NVMe SSDs
are hidden by Intel RST.  Then, intel-nvme-remap is going to remap and
show up the NVMe SSDs.  But it hits two issues:

1. The datatype of segment for PCI in intel-iommu is u16 [2], but
pci_domain_nr() [3][4] returns an integer.  That makes overflow
(possible), then truncates segment to a wrong number.
2. The device has no IOMMU but still be asked to do IOMMU mapping for
intel_alloc_coherent in intel-iommu.

Item 1:
   For example, VMD's domain/segment number starts from 0x10000 [5].
Intel-nvme-remap implements the same idea originally [6].  But we
found system shows BUG_ON error in dmar_insert_dev_scope() during
probing the device and none of the NVMe SSD is shown.

[    7.433079] intel-nvme-remap 0000:00:17.0: Found 2 remapped NVMe devices
[    7.433116] intel-nvme-remap 0000:00:17.0: PCI host bridge to bus 10000:=
00
[    7.433117] pci_bus 10000:00: root bus resource [mem 0xae108000-0xae10bf=
ff]
[    7.433118] pci_bus 10000:00: root bus resource [mem 0xae10c000-0xae10ff=
ff]
[    7.433119] pci_bus 10000:00: root bus resource [mem 0xae1a0000-0xae1a7f=
ff]
[    7.433120] pci_bus 10000:00: root bus resource [mem 0xae1a8000-0xae1a80=
ff]
[    7.433121] pci_bus 10000:00: root bus resource [io  0x3090-0x3097]
[    7.433121] pci_bus 10000:00: root bus resource [io  0x3080-0x3083]
[    7.433122] pci_bus 10000:00: root bus resource [io  0x3060-0x307f]
[    7.433123] pci_bus 10000:00: root bus resource [mem 0xae100000-0xae17ff=
ff]
[    7.433241] pci 10000:00:00.0: [8086:02d7] type 00 class 0x010601
[    7.433276] pci 10000:00:00.0: reg 0x10: [mem 0xae1a0000-0xae1a7fff]
[    7.433290] pci 10000:00:00.0: reg 0x14: [mem 0xae1a8000-0xae1a80ff]
[    7.433303] pci 10000:00:00.0: reg 0x18: [io  0x3090-0x3097]
[    7.433317] pci 10000:00:00.0: reg 0x1c: [io  0x3080-0x3083]
[    7.433330] pci 10000:00:00.0: reg 0x20: [io  0x3060-0x307f]
[    7.433440] pci 10000:00:00.0: reg 0x24: [mem 0xae100000-0xae103fff]
[    7.433536] pci 10000:00:00.0: PME# supported from D3hot
[    7.433836] pci 10000:00:00.0: Failed to add to iommu group 13: -16
[    7.433860] pci 10000:00:01.0: [8086:0000] type 00 class 0x010802
[    7.433863] pci 10000:00:01.0: reg 0x10: [mem 0xae108000-0xae10bfff 64bi=
t]
[    7.433907] pci 10000:00:01.0: Adding to iommu group 13
[    7.433916] pci 10000:00:01.0: Using iommu direct mapping
[    7.433924] pci 10000:00:02.0: [8086:0000] type 00 class 0x010802
[    7.433926] pci 10000:00:02.0: reg 0x10: [mem 0xae10c000-0xae10ffff 64bi=
t]
[    7.433966] pci 10000:00:02.0: Failed to add to iommu group 14: -16
[    7.433979] ------------[ cut here ]------------
[    7.433980] kernel BUG at drivers/iommu/dmar.c:261!
[    7.433983] invalid opcode: 0000 [#1] SMP NOPTI
[    7.433985] CPU: 6 PID: 373 Comm: systemd-udevd Not tainted 5.4.0+ #2
[    7.433986] Hardware name: ASUSTeK COMPUTER INC. ASUSPRO
B9450FA_B9450FA/B9450FA, BIOS B9450FA.205.T04 12/10/2019
[    7.433989] RIP: 0010:dmar_insert_dev_scope+0x13c/0x1a0
[    7.433990] Code: 0f 85 4c 10 00 00 45 85 c9 7e 1f 49 8b 08 49 8d
50 10 31 c0 eb 07 48 8b 0a 48 83 c2 10 48 85 c9 74 0a 83 c0 01 41 39
c1 75 ec <0f> 0b 48 98 49 8d bc 24 b0 00 00 00 48 c1 e0 04 49 8d 1c 00
48 8b
[    7.433991] RSP: 0018:ffff9b650079f8b0 EFLAGS: 00010246
[    7.433992] RAX: 0000000000000001 RBX: ffff97f83c3688e8 RCX: ffff97f83b5=
c50b0
[    7.433993] RDX: ffff97f83c36d060 RSI: 0000000000000001 RDI: 00000000000=
00008
[    7.433993] RBP: ffffffff8c60a0e0 R08: ffff97f83c36d050 R09: 00000000000=
00001
[    7.433994] R10: 0000000000000001 R11: 0000000000000000 R12: ffff97f838f=
58000
[    7.433994] R13: ffffffff8c60a0fc R14: ffffffff8c60a0fc R15: 00000000000=
00000
[    7.433995] FS:  00007f8284fa3d40(0000) GS:ffff97f83dd80000(0000)
knlGS:0000000000000000
[    7.433996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.433996] CR2: 00007f7a7a28b000 CR3: 0000000462306006 CR4: 00000000003=
606e0
[    7.433997] Call Trace:
[    7.434000]  dmar_pci_bus_add_dev+0x3e/0x80
[    7.434001]  dmar_pci_bus_notifier+0x90/0xe0
[    7.434003]  notifier_call_chain+0x44/0x70
[    7.434004]  blocking_notifier_call_chain+0x43/0x60
[    7.434006]  device_add+0x35d/0x640
[    7.434008]  pci_device_add+0x1f8/0x580
[    7.434009]  ? pci_setup_device+0x304/0x6d0
[    7.434010]  pci_scan_single_device+0x9f/0xc0
[    7.434011]  pci_scan_slot+0x4d/0x100
[    7.434013]  pci_scan_child_bus_extend+0x30/0x210
[    7.434015]  nvme_remap_probe.cold+0x109/0x171 [intel_nvme_remap]
[    7.434016]  local_pci_probe+0x38/0x70
[    7.434018]  ? pci_assign_irq+0x22/0xc0
[    7.434019]  pci_device_probe+0xd0/0x150
[    7.434020]  really_probe+0xdf/0x290
[    7.434021]  driver_probe_device+0x4b/0xc0
[    7.434022]  device_driver_attach+0x4e/0x60
[    7.434023]  __driver_attach+0x44/0xb0
[    7.434024]  ? device_driver_attach+0x60/0x60
[    7.434026]  bus_for_each_dev+0x6c/0xb0
[    7.434027]  bus_add_driver+0x172/0x1c0
[    7.434028]  driver_register+0x67/0xb0
[    7.434029]  ? 0xffffffffc021d000
[    7.434030]  do_one_initcall+0x3e/0x1cf
[    7.434032]  ? free_vmap_area_noflush+0x8d/0xe0
[    7.434034]  ? _cond_resched+0x10/0x20
[    7.434036]  ? kmem_cache_alloc_trace+0x3a/0x1b0
[    7.434038]  do_init_module+0x56/0x200
[    7.434039]  load_module+0x2202/0x24d0
[    7.434041]  ? __do_sys_finit_module+0xbf/0xe0
[    7.434042]  __do_sys_finit_module+0xbf/0xe0
[    7.434044]  do_syscall_64+0x3d/0x110
[    7.434045]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    7.434046] RIP: 0033:0x7f82855912a9
[    7.434048] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 6b 0c 00 f7 d8 64 89
01 48
[    7.434048] RSP: 002b:00007ffd4b4f0d58 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    7.434049] RAX: ffffffffffffffda RBX: 00005602342f6c80 RCX: 00007f82855=
912a9
[    7.434049] RDX: 0000000000000000 RSI: 00007f8285495cad RDI: 00000000000=
00006
[    7.434050] RBP: 00007f8285495cad R08: 0000000000000000 R09: 00005602342=
f6c80
[    7.434050] R10: 0000000000000006 R11: 0000000000000246 R12: 00000000000=
00000
[    7.434051] R13: 0000560234301a90 R14: 0000000000020000 R15: 00005602342=
f6c80
[    7.434051] Modules linked in: intel_nvme_remap(+) efivarfs
[    7.434054] ---[ end trace 204a357401123f0a ]---

   There are 3 PCI devices will be produced by intel-nvme-remap:
10000:00:00.0 (fake SATA controller mapped to RAID bus controller),
10000:00:01.0 (fake NVMe mapped to real NVMe) and 10000:00:02.0 (fake
NVMe mapped to real NVMe).
   We checked the DMAR table:

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200110 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 *
 * Disassembly of dmar.dat, Wed Jan 22 11:41:50 2020
 *
 * ACPI Data Table [DMAR]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "DMAR"    [DMA Remapping tab=
le]
[004h 0004   4]                 Table Length : 000000A8
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 5E
[00Ah 0010   6]                       Oem ID : "INTEL "
[010h 0016   8]                 Oem Table ID : "EDK2    "
[018h 0024   4]                 Oem Revision : 00000002
[01Ch 0028   4]              Asl Compiler ID : "    "
[020h 0032   4]        Asl Compiler Revision : 01000013

[024h 0036   1]           Host Address Width : 26
[025h 0037   1]                        Flags : 05
[026h 0038  10]                     Reserved : 00 00 00 00 00 00 00 00 00 0=
0

[030h 0048   2]                Subtable Type : 0000 [Hardware Unit Definiti=
on]
[032h 0050   2]                       Length : 0018

[034h 0052   1]                        Flags : 00
[035h 0053   1]                     Reserved : 00
[036h 0054   2]           PCI Segment Number : 0000
[038h 0056   8]        Register Base Address : 00000000FED90000

[040h 0064   1]            Device Scope Type : 01 [PCI Endpoint Device]
[041h 0065   1]                 Entry Length : 08
[042h 0066   2]                     Reserved : 0000
[044h 0068   1]               Enumeration ID : 00
[045h 0069   1]               PCI Bus Number : 00

[046h 0070   2]                     PCI Path : 02,00


[048h 0072   2]                Subtable Type : 0000 [Hardware Unit Definiti=
on]
[04Ah 0074   2]                       Length : 0020

[04Ch 0076   1]                        Flags : 01
[04Dh 0077   1]                     Reserved : 00
[04Eh 0078   2]           PCI Segment Number : 0000
[050h 0080   8]        Register Base Address : 00000000FED91000

[058h 0088   1]            Device Scope Type : 03 [IOAPIC Device]
[059h 0089   1]                 Entry Length : 08
[05Ah 0090   2]                     Reserved : 0000
[05Ch 0092   1]               Enumeration ID : 02
[05Dh 0093   1]               PCI Bus Number : 00

[05Eh 0094   2]                     PCI Path : 1E,07


[060h 0096   1]            Device Scope Type : 04 [Message-capable HPET Dev=
ice]
[061h 0097   1]                 Entry Length : 08
[062h 0098   2]                     Reserved : 0000
[064h 0100   1]               Enumeration ID : 00
[065h 0101   1]               PCI Bus Number : 00

[066h 0102   2]                     PCI Path : 1E,06


[068h 0104   2]                Subtable Type : 0001 [Reserved Memory Region=
]
[06Ah 0106   2]                       Length : 0020

[06Ch 0108   2]                     Reserved : 0000
[06Eh 0110   2]           PCI Segment Number : 0000
[070h 0112   8]                 Base Address : 000000006F58B000
[078h 0120   8]          End Address (limit) : 000000006F7D4FFF

[080h 0128   1]            Device Scope Type : 01 [PCI Endpoint Device]
[081h 0129   1]                 Entry Length : 08
[082h 0130   2]                     Reserved : 0000
[084h 0132   1]               Enumeration ID : 00
[085h 0133   1]               PCI Bus Number : 00

[086h 0134   2]                     PCI Path : 14,00


[088h 0136   2]                Subtable Type : 0001 [Reserved Memory Region=
]
[08Ah 0138   2]                       Length : 0020

[08Ch 0140   2]                     Reserved : 0000
[08Eh 0142   2]           PCI Segment Number : 0000
[090h 0144   8]                 Base Address : 0000000079800000
[098h 0152   8]          End Address (limit) : 000000007DFFFFFF

[0A0h 0160   1]            Device Scope Type : 01 [PCI Endpoint Device]
[0A1h 0161   1]                 Entry Length : 08
[0A2h 0162   2]                     Reserved : 0000
[0A4h 0164   1]               Enumeration ID : 00
[0A5h 0165   1]               PCI Bus Number : 00

[0A6h 0166   2]                     PCI Path : 02,00


Raw Table Data: Length 168 (0xA8)

    0000: 44 4D 41 52 A8 00 00 00 01 5E 49 4E 54 45 4C 20  // DMAR.....^INT=
EL
    0010: 45 44 4B 32 20 20 20 20 02 00 00 00 20 20 20 20  // EDK2    ....
    0020: 13 00 00 01 26 05 00 00 00 00 00 00 00 00 00 00  // ....&........=
...
    0030: 00 00 18 00 00 00 00 00 00 00 D9 FE 00 00 00 00  // .............=
...
    0040: 01 08 00 00 00 00 02 00 00 00 20 00 01 00 00 00  // .......... ..=
...
    0050: 00 10 D9 FE 00 00 00 00 03 08 00 00 02 00 1E 07  // .............=
...
    0060: 04 08 00 00 00 00 1E 06 01 00 20 00 00 00 00 00  // .......... ..=
...
    0070: 00 B0 58 6F 00 00 00 00 FF 4F 7D 6F 00 00 00 00  // ..Xo.....O}o.=
...
    0080: 01 08 00 00 00 00 14 00 01 00 20 00 00 00 00 00  // .......... ..=
...
    0090: 00 00 80 79 00 00 00 00 FF FF FF 7D 00 00 00 00  // ...y.......}.=
...
    00A0: 01 08 00 00 00 00 02 00                          // ........

   The possible PCI Endpoint Devices with DMAR feature locate at
0000:00:02:00 and 0000:00:14:00.

   After tracing code, we found it comes from the wrong domain/segment
number, because of the segment's unmatched datatype.  It is truncated
to a wrong number, then wrong behavior.
   The fake 10000:00:02.0 will be truncated to 0000:00:02.0.  It is
the same PCI path of original real PCI device 0000:00:02.0, which is a
VGA.  This conflict makes 10000:00:02.0 try to take the same scope of
0000:00:02.0.  But the scope can only be taken once.  Then, this leads
to BUG_ON.

   So, I prepare another fix: Change the domain number from 0x10000+
to next free domain [7].  It will be domain 0x0001, which can sit in
u16 for most machines.
   Now, no BUG_ON, the fake SATA controller and two fake NVMe SSD PCI
devices show up.  Because of no matched segment 0x0001 in drhd [8],
NULL is returned as the iommu from device_to_iommu().

   However, still none of the NVMe SSD device node locates under /dev.

Item 2:
   We found the NVMe SSDs are probed, but also removed due to failure.

[    8.156593] nvme nvme1: Removing after probe failure status: -12
[    8.156783] nvme nvme0: Removing after probe failure status: -12

   According to dumped stack trace:

[    7.939620] nvme nvme0: pci function 0001:00:01.0
[    7.939889] nvme nvme1: pci function 0001:00:02.0
[    8.045836] nvme 0001:00:02.0: DMAR: iommu_dummy: in
[    8.045837] nvme 0001:00:01.0: DMAR: iommu_dummy: in
[    8.045840] CPU: 7 PID: 1232 Comm: kworker/u16:7 Not tainted 5.4.0+ #105
[    8.045840] Hardware name: ASUSTeK COMPUTER INC. ASUSPRO
B9450FA_B9450FA/B9450FA, BIOS B9450FA.205.T04 12/10/2019
[    8.045845] Workqueue: nvme-reset-wq nvme_reset_work
[    8.045846] Call Trace:
[    8.045852]  dump_stack+0x50/0x70
[    8.045854]  iommu_dummy.cold+0x1c/0x25
[    8.045856]  iommu_need_mapping+0xe/0x110
[    8.045857]  intel_alloc_coherent+0x1d/0x100
[    8.045859]  nvme_alloc_queue+0x55/0x160
[    8.045861]  nvme_reset_work+0x330/0x12e0
[    8.045864]  ? enqueue_task_fair+0x1a7/0x770
[    8.045865]  ? newidle_balance+0x1ec/0x340
[    8.045866]  ? check_preempt_curr+0x45/0x80
[    8.045867]  ? ttwu_do_wakeup.isra.0+0xf/0xd0
[    8.045868]  ? try_to_wake_up+0x387/0x570
[    8.045871]  process_one_work+0x1d5/0x370
[    8.045873]  worker_thread+0x45/0x3c0
[    8.045875]  kthread+0xf3/0x130
[    8.045876]  ? process_one_work+0x370/0x370
[    8.045877]  ? kthread_park+0x80/0x80
[    8.045879]  ret_from_fork+0x1f/0x30
[    8.045882] CPU: 3 PID: 57 Comm: kworker/u16:1 Not tainted 5.4.0+ #105
[    8.045882] nvme 0001:00:01.0: DMAR: identity_mapping: in
[    8.045883] Hardware name: ASUSTeK COMPUTER INC. ASUSPRO
B9450FA_B9450FA/B9450FA, BIOS B9450FA.205.T04 12/10/2019
[    8.045885] Workqueue: nvme-reset-wq nvme_reset_work
[    8.045885] Call Trace:
[    8.045887]  dump_stack+0x50/0x70
[    8.045888]  iommu_dummy.cold+0x1c/0x25
[    8.045889]  iommu_need_mapping+0xe/0x110
[    8.045890]  intel_alloc_coherent+0x1d/0x100
[    8.045892]  nvme_alloc_queue+0x55/0x160
[    8.045893]  nvme_reset_work+0x330/0x12e0
[    8.045895]  ? enqueue_task_fair+0x1a7/0x770
[    8.045896]  ? newidle_balance+0x1ec/0x340
[    8.045897]  ? check_preempt_curr+0x45/0x80
[    8.045898]  ? ttwu_do_wakeup.isra.0+0xf/0xd0
[    8.045899]  ? try_to_wake_up+0x387/0x570
[    8.045901]  process_one_work+0x1d5/0x370
[    8.045902]  worker_thread+0x45/0x3c0
[    8.045904]  kthread+0xf3/0x130
[    8.045905]  ? process_one_work+0x370/0x370
[    8.045907]  ? kthread_park+0x80/0x80
[    8.045908]  ret_from_fork+0x1f/0x30
[    8.045910] CPU: 7 PID: 1232 Comm: kworker/u16:7 Not tainted 5.4.0+ #105

   We found intel_alloc_coherent will check the device that needs
iommu mapping or not [9].  If it does not, then it goes to
dma_direct_alloc() and returns.  Otherwise, it goes to IOMMU mapping
stuff.  From item 1, since the fake NVMe SSDs have no IOMMU (NULL),
they should use dma_direct_alloc() for intel_alloc_coherent, but the
current code leads to IOMMU mapping stuff.  So I propose the patch
https://lkml.org/lkml/2020/2/3/79 .
   The fake NVMe device nodes show up with the patch is applied.

[1] https://github.com/endlessm/linux/commit/e18cd2573122b813aff4a4e2986da5=
ebedea2706
[2] https://elixir.bootlin.com/linux/v5.5.2/source/include/linux/dmar.h#L60
[3] https://elixir.free-electrons.com/linux/v5.5.2/source/arch/x86/include/=
asm/pci.h#L39
[4] https://elixir.free-electrons.com/linux/v5.5.2/source/drivers/iommu/int=
el-iommu.c#L789
[5] https://elixir.free-electrons.com/linux/v5.5.2/source/drivers/pci/contr=
oller/vmd.c#L547
[6] https://github.com/endlessm/linux/commit/e18cd2573122b813aff4a4e2986da5=
ebedea2706#diff-95458a6c77af8e2489b6fd08152888cfR283
[7] https://github.com/endlessm/linux/pull/534/commits/1a5f584eb362d9b0369f=
ab8a22ed1c683565e5ef
[8] https://elixir.free-electrons.com/linux/v5.5.2/source/drivers/iommu/int=
el-iommu.c#L795
[9] https://elixir.free-electrons.com/linux/v5.5.2/source/drivers/iommu/int=
el-iommu.c#L3655

Best regards,
Jian-Hong Pan
