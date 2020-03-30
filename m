Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C535C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC3920733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SoqkNnxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgC3UmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:42:22 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:64132 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgC3UmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585600940; x=1617136940;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pzei7EPNdSl0vQstWZdYvFBARJOekVDWFMh3y2n4Zzg=;
  b=SoqkNnxDDNpLJEjSehgHaebK+wGoVdRSn1EUjoFNeiLFwvu+XsbQ52Wb
   WFIYkGy9huKpC9aYl7CpIqR0zH/6qnFmDeLNj2BoAJ1/HSoJbiPbbCK7b
   6FktbahnxEU1cznScP+FEEL1r5VaNTna9q+cTStoIFd+OZJ76CGnHqytR
   g=;
IronPort-SDR: ZQ+rhy1V3tG9tO8gx4zMdwYV99PRd2MSqkQa6tUb6O30D5v+rRPtyfdHoJg1n+6rvekwp2wRW2
 RRTQjGuwOMAQ==
X-IronPort-AV: E=Sophos;i="5.72,325,1580774400"; 
   d="scan'208";a="25953907"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 30 Mar 2020 20:42:17 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id C9F3AA2992;
        Mon, 30 Mar 2020 20:42:09 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Mar 2020 20:42:09 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.134) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 30 Mar 2020 20:42:02 +0000
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Kairui Song <kasong@redhat.com>, <anthony.yznaga@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>
CC:     Dave Young <dyoung@redhat.com>, <iommu@lists.linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <dwmw@amazon.com>,
        <benh@amazon.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        <alcioa@amazon.com>, <aggh@amazon.com>, <aagch@amazon.com>,
        <dhr@amazon.com>, Laszlo Ersek <lersek@redhat.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        <kexec@lists.infradead.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
Date:   Mon, 30 Mar 2020 22:42:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330134004.GA31026@char.us.oracle.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D10UWB002.ant.amazon.com (10.43.161.130) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.20 15:40, Konrad Rzeszutek Wilk wrote:
> =

> =

> =

> On Mon, Mar 30, 2020 at 02:06:01PM +0800, Kairui Song wrote:
>> On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
>>>
>>> On 03/26/20 at 05:29pm, Alexander Graf wrote:
>>>> The swiotlb is a very convenient fallback mechanism for bounce bufferi=
ng of
>>>> DMAable data. It is usually used for the compatibility case where devi=
ces
>>>> can only DMA to a "low region".
>>>>
>>>> However, in some scenarios this "low region" may be bound even more
>>>> heavily. For example, there are embedded system where only an SRAM reg=
ion
>>>> is shared between device and CPU. There are also heterogeneous computi=
ng
>>>> scenarios where only a subset of RAM is cache coherent between the
>>>> components of the system. There are partitioning hypervisors, where
>>>> a "control VM" that implements device emulation has limited view into a
>>>> partition's memory for DMA capabilities due to safety concerns.
>>>>
>>>> This patch adds a command line driven mechanism to move all DMA memory=
 into
>>>> a predefined shared memory region which may or may not be part of the
>>>> physical address layout of the Operating System.
>>>>
>>>> Ideally, the typical path to set this configuration would be through D=
evice
>>>> Tree or ACPI, but neither of the two mechanisms is standardized yet. A=
lso,
>>>> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
>>>> instead configure the system purely through kernel command line option=
s.
>>>>
>>>> I'm sure other people will find the functionality useful going forward
>>>> though and extend it to be triggered by DT/ACPI in the future.
>>>
>>> Hmm, we have a use case for kdump, this maybe useful.  For example
>>> swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
>>> kernel we have to increase the crashkernel reserved size for the extra
>>> swiotlb requirement.  I wonder if we can just reuse the old kernel's
>>> swiotlb region and pass the addr to kdump kernel.
>>>
>>
>> Yes, definitely helpful for kdump kernel. This can help reduce the
>> crashkernel value.
>>
>> Previously I was thinking about something similar, play around the
>> e820 entry passed to kdump and let it place swiotlb in wanted region.
>> Simply remap it like in this patch looks much cleaner.
>>
>> If this patch is acceptable, one more patch is needed to expose the
>> swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
>> second kernel.
> =

> We seem to be passsing a lot of data to kexec.. Perhaps something
> of a unified way since we seem to have a lot of things to pass - disabling
> IOMMU, ACPI RSDT address, and then this.
> =

> CC-ing Anthony who is working on something - would you by any chance
> have a doc on this?


I see in general 2 use cases here:


1) Allow for a generic mechanism to have the fully system, individual =

buses, devices or functions of a device go through a particular, =

self-contained bounce buffer.

This sounds like the holy grail to a lot of problems. It would solve =

typical embedded scenarios where you only have a shared SRAM. It solves =

the safety case (to some extent) where you need to ensure that one =

device interaction doesn't conflict with another device interaction. It =

also solves the problem I've tried to solve with the patch here.

It's unfortunately a lot harder than the patch I sent, so it will take =

me some time to come up with a working patch set.. I suppose starting =

with a DT binding only is sensible. Worst case, x86 does also support DT ...

(And yes, I'm always happy to review patches if someone else beats me to it)


2) Reuse the SWIOTLB from the previous boot on kexec/kdump

I see little direct relation to SEV here. The only reason SEV makes it =

more relevant, is that you need to have an SWIOTLB region available with =

SEV while without you could live with a disabled IOMMU.

However, I can definitely understand how you would want to have a way to =

tell the new kexec'ed kernel where the old SWIOTLB was, so it can reuse =

its memory for its own SWIOTLB. That way, you don't have to reserve =

another 64MB of RAM for kdump.

What I'm curious on is whether we need to be as elaborate. Can't we just =

pass the old SWIOTLB as free memory to the new kexec'ed kernel and =

everything else will fall into place? All that would take is a bit of =

shuffling on the e820 table pass-through to the kexec'ed kernel, no?


Thanks,

Alex




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



