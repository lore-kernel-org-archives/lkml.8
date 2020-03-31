Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9142072D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCtLxoLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgCaCAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 22:00:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47177 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729035AbgCaCAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 22:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585620011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7J/WvCRzFDPjN13KVOAH7X96x+em5mLjdDYjxy7JL4=;
        b=fCtLxoLnOPo/SoS4R7pRoLXAJRwpPrNCzJzCzCaCRRmqLNeX1UIYU3wAIy6wkjJ/Y7HxoB
        lTUpj3atXnffF9niOvtlpahhnVfOjq3kdq1x6kWJoJk2XswYLNXFkODQM/hDHScGdqgS6w
        TK0KtMw005Z6Iij8E6LLwnEpunlKm98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-EpzUZZB8O_GoilF-gs7kdA-1; Mon, 30 Mar 2020 22:00:09 -0400
X-MC-Unique: EpzUZZB8O_GoilF-gs7kdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 179D58017DF;
        Tue, 31 Mar 2020 02:00:06 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-247.pek2.redhat.com [10.72.12.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40CA15DA60;
        Tue, 31 Mar 2020 01:59:52 +0000 (UTC)
Date:   Tue, 31 Mar 2020 09:59:49 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Kairui Song <kasong@redhat.com>, anthony.yznaga@oracle.com,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
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
        kexec@lists.infradead.org,
        "Schoenherr, Jan H." <jschoenh@amazon.de>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200331015949.GB81569@dhcp-128-65.nay.redhat.com>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
 <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[snip]
> 2) Reuse the SWIOTLB from the previous boot on kexec/kdump

We should only care about kdump

> 
> I see little direct relation to SEV here. The only reason SEV makes it more
> relevant, is that you need to have an SWIOTLB region available with SEV
> while without you could live with a disabled IOMMU.


Here is some comment in arch/x86/kernel/pci-swiotlb.c, it is enforced
for some reason.
        /*
         * If SME is active then swiotlb will be set to 1 so that bounce
         * buffers are allocated and used for devices that do not support
         * the addressing range required for the encryption mask.
         */
        if (sme_active())
                swiotlb = 1;

> 
> However, I can definitely understand how you would want to have a way to
> tell the new kexec'ed kernel where the old SWIOTLB was, so it can reuse its
> memory for its own SWIOTLB. That way, you don't have to reserve another 64MB
> of RAM for kdump.
> 
> What I'm curious on is whether we need to be as elaborate. Can't we just
> pass the old SWIOTLB as free memory to the new kexec'ed kernel and
> everything else will fall into place? All that would take is a bit of
> shuffling on the e820 table pass-through to the kexec'ed kernel, no?

Maybe either of the two is fine.  But we may need ensure these swiotlb
area to be reused explictly in some way.  Say about the crashkernel=X,high case,
major part is in above 4G region, and a small piece in low memory. Then
when kernel booting, kernel/driver initialization could use out of the
low memory, and the remain part for swiotlb could be not big enough and
finally swiotlb allocation fails. 

Thanks
Dave

