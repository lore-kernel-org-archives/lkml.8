Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE3C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE0A2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="tDIE+9KE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgBGHdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:33:32 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45579 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgBGHdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:33:32 -0500
Received: by mail-vs1-f66.google.com with SMTP id v141so603676vsv.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 23:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GMFyNSZrLGOSGOiW387mNilRAxEOlA7T3UqXZxjTZXQ=;
        b=tDIE+9KEqQ7H6fy9XIFA5/HUFvvUrAQotEIg6QNL+7TG6RHAs67BTsLcIFUmFeFnrA
         ibEDci6Sycnz6/vrvMg3slqLQNtdcmbfR+ylZ9s1q2y8hlxX3UdCJ5ITKBGMKrB9nyNl
         6r2qLp2hheOfasUA5EltRfoMPk6hVKVHJhXDghxMqhAjNQoQQwFaxyeddD2fh+MfGlHe
         ss9SWgHoFsVOBzW/X6DisB+wpzGSyPtawUqJMmsPvlHqBysHGLdRBRFeh9KB8zdEE+Ki
         dkFIJkmS0lM+oHSDOaUWvjgGMmZTsLo/dXpyNw9tePNR9AfsCkxR47xvA4kgDqutcm95
         lvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GMFyNSZrLGOSGOiW387mNilRAxEOlA7T3UqXZxjTZXQ=;
        b=TyLkDYLMGUX0BR0DO7pksjrCnS3tbobAH4TMIY8r42blAGQnV+KMN+thYQ3UKz1u5V
         y6qeqG+xnY1LxAKsHux9xLLPkZneWZkWtVJK8rcUrS3v78iA34ikOdpWS2Tqgff6aENu
         EJZuPOxR3EmxiNktu/Rs1fwDReJ/OJsh+OgMTCETkJK3mFEdfQLwKDsf/nC+aYXT3mkX
         pJIs8XAOY18eE66rY6YweFb196AzrOZOj+cSPm06ruFrex+Jrrdrd9ZXizz+OSDPDBeD
         3rUWNdUDsf/Fd1aFv1Se+jVL9gSTHlr4RjbBL4Ig+9VeeeI9bhNoPm0PQxpqQjes7iF5
         n0Ig==
X-Gm-Message-State: APjAAAVg/CrTQkvji5YWK1DKvA02uqLiQ5QO4C6jHKb/0GG+pHED+pXI
        9aTntH813yuK6Uignq9c5VhOg5MIv+FefTnBsZt5Fw==
X-Google-Smtp-Source: APXvYqxu1vtGHZ2FVZfabmM1lhOF0H5O1WZzBxhVsqlo1F1wJbnshw2I3KV5zkve1VfX2wYsd9jO/NAh0Y/wdn05AKk=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr3856562vsq.206.1581060811000;
 Thu, 06 Feb 2020 23:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com> <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
 <948da337-128f-22ae-7b2e-730b4b8da446@linux.intel.com> <CAPpJ_ecM0oCUjYLbG+uTprRk0=OTUBTxZc-d2BGBRDSYWk4uSQ@mail.gmail.com>
 <c8d89c4f-1347-8b9d-0486-a29dd081f26c@linux.intel.com>
In-Reply-To: <c8d89c4f-1347-8b9d-0486-a29dd081f26c@linux.intel.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Fri, 7 Feb 2020 15:32:48 +0800
Message-ID: <CAPpJ_ec6H9fqSLA9L8QXir=FBjJqV7xcXp4ea+6XJ8MotDWVyg@mail.gmail.com>
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no IOMMU
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lu Baolu <baolu.lu@linux.intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=886=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 2020/2/5 18:06, Jian-Hong Pan wrote:
> > Lu Baolu <baolu.lu@linux.intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:28=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >> Hi,
> >>
> >> On 2020/2/4 17:25, Jian-Hong Pan wrote:
> >>> Lu Baolu <baolu.lu@linux.intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=88=
4=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 2020/2/3 17:10, Jian-Hong Pan wrote:
> >>>>> If the device has no IOMMU, it still invokes iommu_need_mapping dur=
ing
> >>>>> intel_alloc_coherent. However, iommu_need_mapping can only check th=
e
> >>>>> device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the dev=
ice
> >>>>> is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.
> >>>>>
> >>>>> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> >>>>> ---
> >>>>>     drivers/iommu/intel-iommu.c | 4 +++-
> >>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iomm=
u.c
> >>>>> index 35a4a3abedc6..878bc986a015 100644
> >>>>> --- a/drivers/iommu/intel-iommu.c
> >>>>> +++ b/drivers/iommu/intel-iommu.c
> >>>>> @@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct dev=
ice *dev)
> >>>>>         int ret;
> >>>>>
> >>>>>         iommu =3D device_to_iommu(dev, &bus, &devfn);
> >>>>> -     if (!iommu)
> >>>>> +     if (!iommu) {
> >>>>> +             dev->archdata.iommu =3D DUMMY_DEVICE_DOMAIN_INFO;
> >>>>
> >>>> Is this a DMA capable device?
> >>>
> >>> Do you mean is the device in DMA Remapping table?
> >>> Dump DMAR from ACPI table.  The device is not in the table.
> >>> So, it does not support DMAR, Intel IOMMU.
> >>>
> >>> Or, should device_to_iommu be invoked in iommu_need_mapping to check
> >>> IOMMU feature again?
> >>>
> >>
> >> Normally intel_iommu_add_device() should only be called for PCI device=
s
> >> and APCI name space devices (reported in ACPI/DMAR table). In both
> >> cases, device_to_iommu() should always return a corresponding iommu. I
> >> just tried to understand why it failed for your case.
> >
> > We found all of the DMAR featured devices's PCI Segment Number is *0000=
*.
> > But the devices locating under segment/domain *0001* hit the issue,
> > until the patch is applied.
> >
> > Because of different segment numbers, none of iommu will be matched by
> > for_each_active_iommu(iommu, drhd) loop in function device_to_iommu()
> > and it will return NULL.  So, intel_iommu_add_device() returns no
> > device.
> >
> > I can share the DMAR:
> > /*
> >   * Intel ACPI Component Architecture
> >   * AML/ASL+ Disassembler version 20200110 (64-bit version)
> >   * Copyright (c) 2000 - 2020 Intel Corporation
> >   *
> >   * Disassembly of dmar.dat, Wed Jan 22 11:41:50 2020
> >   *
> >   * ACPI Data Table [DMAR]
> >   *
> >   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValu=
e
> >   */
> >
> > [000h 0000   4]                    Signature : "DMAR"    [DMA Remapping=
 table]
> > [004h 0004   4]                 Table Length : 000000A8
> > [008h 0008   1]                     Revision : 01
> > [009h 0009   1]                     Checksum : 5E
> > [00Ah 0010   6]                       Oem ID : "INTEL "
> > [010h 0016   8]                 Oem Table ID : "EDK2    "
> > [018h 0024   4]                 Oem Revision : 00000002
> > [01Ch 0028   4]              Asl Compiler ID : "    "
> > [020h 0032   4]        Asl Compiler Revision : 01000013
> >
> > [024h 0036   1]           Host Address Width : 26
> > [025h 0037   1]                        Flags : 05
> > [026h 0038  10]                     Reserved : 00 00 00 00 00 00 00 00 =
00 00
> >
> > [030h 0048   2]                Subtable Type : 0000 [Hardware Unit Defi=
nition]
> > [032h 0050   2]                       Length : 0018
> >
> > [034h 0052   1]                        Flags : 00
> > [035h 0053   1]                     Reserved : 00
> > [036h 0054   2]           PCI Segment Number : 0000
> > [038h 0056   8]        Register Base Address : 00000000FED90000
> >
> > [040h 0064   1]            Device Scope Type : 01 [PCI Endpoint Device]
> > [041h 0065   1]                 Entry Length : 08
> > [042h 0066   2]                     Reserved : 0000
> > [044h 0068   1]               Enumeration ID : 00
> > [045h 0069   1]               PCI Bus Number : 00
> >
> > [046h 0070   2]                     PCI Path : 02,00
> >
> >
> > [048h 0072   2]                Subtable Type : 0000 [Hardware Unit Defi=
nition]
> > [04Ah 0074   2]                       Length : 0020
> >
> > [04Ch 0076   1]                        Flags : 01
> > [04Dh 0077   1]                     Reserved : 00
> > [04Eh 0078   2]           PCI Segment Number : 0000
> > [050h 0080   8]        Register Base Address : 00000000FED91000
> >
> > [058h 0088   1]            Device Scope Type : 03 [IOAPIC Device]
> > [059h 0089   1]                 Entry Length : 08
> > [05Ah 0090   2]                     Reserved : 0000
> > [05Ch 0092   1]               Enumeration ID : 02
> > [05Dh 0093   1]               PCI Bus Number : 00
> >
> > [05Eh 0094   2]                     PCI Path : 1E,07
> >
> >
> > [060h 0096   1]            Device Scope Type : 04 [Message-capable HPET=
 Device]
> > [061h 0097   1]                 Entry Length : 08
> > [062h 0098   2]                     Reserved : 0000
> > [064h 0100   1]               Enumeration ID : 00
> > [065h 0101   1]               PCI Bus Number : 00
> >
> > [066h 0102   2]                     PCI Path : 1E,06
> >
> >
> > [068h 0104   2]                Subtable Type : 0001 [Reserved Memory Re=
gion]
> > [06Ah 0106   2]                       Length : 0020
> >
> > [06Ch 0108   2]                     Reserved : 0000
> > [06Eh 0110   2]           PCI Segment Number : 0000
> > [070h 0112   8]                 Base Address : 000000006F58B000
> > [078h 0120   8]          End Address (limit) : 000000006F7D4FFF
> >
> > [080h 0128   1]            Device Scope Type : 01 [PCI Endpoint Device]
> > [081h 0129   1]                 Entry Length : 08
> > [082h 0130   2]                     Reserved : 0000
> > [084h 0132   1]               Enumeration ID : 00
> > [085h 0133   1]               PCI Bus Number : 00
> >
> > [086h 0134   2]                     PCI Path : 14,00
> >
> >
> > [088h 0136   2]                Subtable Type : 0001 [Reserved Memory Re=
gion]
> > [08Ah 0138   2]                       Length : 0020
> >
> > [08Ch 0140   2]                     Reserved : 0000
> > [08Eh 0142   2]           PCI Segment Number : 0000
> > [090h 0144   8]                 Base Address : 0000000079800000
> > [098h 0152   8]          End Address (limit) : 000000007DFFFFFF
> >
> > [0A0h 0160   1]            Device Scope Type : 01 [PCI Endpoint Device]
> > [0A1h 0161   1]                 Entry Length : 08
> > [0A2h 0162   2]                     Reserved : 0000
> > [0A4h 0164   1]               Enumeration ID : 00
> > [0A5h 0165   1]               PCI Bus Number : 00
> >
> > [0A6h 0166   2]                     PCI Path : 02,00
> >
> >
> > Raw Table Data: Length 168 (0xA8)
> >
> >      0000: 44 4D 41 52 A8 00 00 00 01 5E 49 4E 54 45 4C 20  // DMAR....=
.^INTEL
> >      0010: 45 44 4B 32 20 20 20 20 02 00 00 00 20 20 20 20  // EDK2    =
....
> >      0020: 13 00 00 01 26 05 00 00 00 00 00 00 00 00 00 00  // ....&...=
........
> >      0030: 00 00 18 00 00 00 00 00 00 00 D9 FE 00 00 00 00  // ........=
........
> >      0040: 01 08 00 00 00 00 02 00 00 00 20 00 01 00 00 00  // ........=
.. .....
> >      0050: 00 10 D9 FE 00 00 00 00 03 08 00 00 02 00 1E 07  // ........=
........
> >      0060: 04 08 00 00 00 00 1E 06 01 00 20 00 00 00 00 00  // ........=
.. .....
> >      0070: 00 B0 58 6F 00 00 00 00 FF 4F 7D 6F 00 00 00 00  // ..Xo....=
.O}o....
> >      0080: 01 08 00 00 00 00 14 00 01 00 20 00 00 00 00 00  // ........=
.. .....
> >      0090: 00 00 80 79 00 00 00 00 FF FF FF 7D 00 00 00 00  // ...y....=
...}....
> >      00A0: 01 08 00 00 00 00 02 00                          // ........
> >
> > Here is the lspci:
> > 0000:00:00.0 Host bridge: Intel Corporation Device 9b61 (rev 0c)
> > 0000:00:02.0 VGA compatible controller: Intel Corporation Device 9b41 (=
rev 02)
> > 0000:00:04.0 Signal processing controller: Intel Corporation Skylake
> > Processor Thermal Subsystem (rev 0c)
> > 0000:00:08.0 System peripheral: Intel Corporation Skylake Gaussian Mixt=
ure Model
> > 0000:00:12.0 Signal processing controller: Intel Corporation Device 02f=
9
> > 0000:00:13.0 Serial controller: Intel Corporation Device 02fc
> > 0000:00:14.0 USB controller: Intel Corporation Device 02ed
> > 0000:00:14.2 RAM memory: Intel Corporation Device 02ef
> > 0000:00:14.3 Network controller: Intel Corporation Device 02f0
> > 0000:00:15.0 Serial bus controller [0c80]: Intel Corporation Device 02e=
8
> > 0000:00:15.1 Serial bus controller [0c80]: Intel Corporation Device 02e=
9
> > 0000:00:15.2 Serial bus controller [0c80]: Intel Corporation Device 02e=
a
> > 0000:00:16.0 Communication controller: Intel Corporation Device 02e0
> > 0000:00:17.0 RAID bus controller: Intel Corporation Device 02d7
> > 0000:00:1c.0 PCI bridge: Intel Corporation Device 02b8 (rev f0)
> > 0000:00:1e.0 Communication controller: Intel Corporation Device 02a8
> > 0000:00:1e.2 Serial bus controller [0c80]: Intel Corporation Device 02a=
a
> > 0000:00:1f.0 ISA bridge: Intel Corporation Device 0284
> > 0000:00:1f.3 Audio device: Intel Corporation Device 02c8
> > 0000:00:1f.4 SMBus: Intel Corporation Device 02a3
> > 0000:00:1f.5 Serial bus controller [0c80]: Intel Corporation Device 02a=
4
> > 0000:00:1f.6 Ethernet controller: Intel Corporation Device 0d4f
> > 0000:01:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
> > Bridge [Titan Ridge 4C 2018] (rev 06)
> > 0000:02:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
> > Bridge [Titan Ridge 4C 2018] (rev 06)
> > 0000:02:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
> > Bridge [Titan Ridge 4C 2018] (rev 06)
> > 0000:02:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
> > Bridge [Titan Ridge 4C 2018] (rev 06)
> > 0000:02:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
> > Bridge [Titan Ridge 4C 2018] (rev 06)
> > 0000:03:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt
> > 3 NHI [Titan Ridge 4C 2018] (rev 06)
> > 0000:37:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3
> > USB Controller [Titan Ridge 4C 2018] (rev 06)
> > 0001:00:00.0 SATA controller: Intel Corporation Device 02d7
> > 0001:00:01.0 Non-Volatile memory controller: Intel Corporation Device 0=
000
> > 0001:00:02.0 Non-Volatile memory controller: Intel Corporation Device 0=
000
> >
>
> So devices are sitting in PCI segment 1, while ACPI/DMAR only reports
> IOMMU units for PCI segment 0. Do I understand it right?

Yes.

> Is it possible that hardware supports DMAR for both PCI segment 0 and 1,
> but the firmware doesn't reports those for PCI segement 1?

Good question!  I have not think the change of DMAR for segment 0 and
1.  But, I guess the answer is not.  The hardware vendor will say
Windows works fine ...

The devices under segment 1 are fake devices produced by
intel-nvme-remap mentioned here https://lkml.org/lkml/2020/2/5/139

We are also curios about why VMD (drivers/pci/controller/vmd.c) works
fine here.  It also produces fake devices, but can use iommu
correctly.  Due to no VMD related machines on hand, it is hard to
trace the flow.  Could you please give us some clues?

Thank you,
Jian-Hong Pan
