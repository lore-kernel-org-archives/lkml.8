Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F8C2D0E9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A76206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5/hhm6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgCaBq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 21:46:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40900 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729557AbgCaBq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 21:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585619215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uo+1bM5jLbPf26TN6zEnjUeeLZzs+2jX0NNWi8ZBweA=;
        b=U5/hhm6+07Um63PyTZohHQEwa5e+Y1Z1SMnDGFVfS/i+5cyQSaEEOWJG/ItRcoS83lWcml
        s2XXT2bB4iW3Juqr7JJWhDpRvwfMzcRczmv4ZXKAfcErp5KdqXO1k88ykUmBxQOGgIATqv
        rFAwRz+2xTPV3w8athFRcqE9Z44/WW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-ByELsUk1MmGYaIeZ40WgHg-1; Mon, 30 Mar 2020 21:46:50 -0400
X-MC-Unique: ByELsUk1MmGYaIeZ40WgHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48291005509;
        Tue, 31 Mar 2020 01:46:46 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-247.pek2.redhat.com [10.72.12.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20332100EBB3;
        Tue, 31 Mar 2020 01:46:36 +0000 (UTC)
Date:   Tue, 31 Mar 2020 09:46:32 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Kairui Song <kasong@redhat.com>, anthony.yznaga@oracle.com,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        Alexander Graf <graf@amazon.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200331014632.GA81569@dhcp-128-65.nay.redhat.com>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330134004.GA31026@char.us.oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/20 at 09:40am, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 30, 2020 at 02:06:01PM +0800, Kairui Song wrote:
> > On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On 03/26/20 at 05:29pm, Alexander Graf wrote:
> > > > The swiotlb is a very convenient fallback mechanism for bounce buffering of
> > > > DMAable data. It is usually used for the compatibility case where devices
> > > > can only DMA to a "low region".
> > > >
> > > > However, in some scenarios this "low region" may be bound even more
> > > > heavily. For example, there are embedded system where only an SRAM region
> > > > is shared between device and CPU. There are also heterogeneous computing
> > > > scenarios where only a subset of RAM is cache coherent between the
> > > > components of the system. There are partitioning hypervisors, where
> > > > a "control VM" that implements device emulation has limited view into a
> > > > partition's memory for DMA capabilities due to safety concerns.
> > > >
> > > > This patch adds a command line driven mechanism to move all DMA memory into
> > > > a predefined shared memory region which may or may not be part of the
> > > > physical address layout of the Operating System.
> > > >
> > > > Ideally, the typical path to set this configuration would be through Device
> > > > Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> > > > in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> > > > instead configure the system purely through kernel command line options.
> > > >
> > > > I'm sure other people will find the functionality useful going forward
> > > > though and extend it to be triggered by DT/ACPI in the future.
> > >
> > > Hmm, we have a use case for kdump, this maybe useful.  For example
> > > swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
> > > kernel we have to increase the crashkernel reserved size for the extra
> > > swiotlb requirement.  I wonder if we can just reuse the old kernel's
> > > swiotlb region and pass the addr to kdump kernel.
> > >
> > 
> > Yes, definitely helpful for kdump kernel. This can help reduce the
> > crashkernel value.
> > 
> > Previously I was thinking about something similar, play around the
> > e820 entry passed to kdump and let it place swiotlb in wanted region.
> > Simply remap it like in this patch looks much cleaner.
> > 
> > If this patch is acceptable, one more patch is needed to expose the
> > swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
> > second kernel.
> 
> We seem to be passsing a lot of data to kexec.. Perhaps something
> of a unified way since we seem to have a lot of things to pass - disabling
> IOMMU, ACPI RSDT address, and then this.

acpi_rsdp kernel cmdline is not useful anymore.  The initial purpose is
for kexec-rebooting in efi system.  But now we have supported efi boot
across kexec reboot thus that is useless now.

Thanks
Dave

