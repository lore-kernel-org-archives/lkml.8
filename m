Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5894C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B488120757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wvs8yqi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgEDOHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:07:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28588 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728233AbgEDOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588601239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNEInDzsZUfgj6dVPP9TtTfYbCtjbqhCfb5bgYwLZbY=;
        b=Wvs8yqi/dtKKxncigQNT5V6wC6U2InfYpy/WtybRt1213VQhx4/UffIWqddZYQcy1Mx73X
        TlpgX5MJJGItTk5n6qWNs9Dk9mlb5o2KI7qLCUEN1kNc2i1erv+OshoEJ1i/Yiq/zHm/K7
        JEgK/miZyAzwpVaOVQZcCoqMJbl7Lzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-5Qn0jHjGNO2YUpdhuNEjLg-1; Mon, 04 May 2020 10:07:15 -0400
X-MC-Unique: 5Qn0jHjGNO2YUpdhuNEjLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FA471856FD5;
        Mon,  4 May 2020 14:06:34 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9335D78B21;
        Mon,  4 May 2020 14:06:31 +0000 (UTC)
Date:   Mon, 4 May 2020 08:06:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, peterx@redhat.com
Subject: Re: [PATCH 1/3] vfio/type1: Support faulting PFNMAP vmas
Message-ID: <20200504080630.293f33e8@x1.home>
In-Reply-To: <20200501235033.GA19929@ziepe.ca>
References: <158836742096.8433.685478071796941103.stgit@gimli.home>
        <158836914801.8433.9711545991918184183.stgit@gimli.home>
        <20200501235033.GA19929@ziepe.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020 20:50:33 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Fri, May 01, 2020 at 03:39:08PM -0600, Alex Williamson wrote:
> > With conversion to follow_pfn(), DMA mapping a PFNMAP range depends on
> > the range being faulted into the vma.  Add support to manually provide
> > that, in the same way as done on KVM with hva_to_pfn_remapped().
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >  drivers/vfio/vfio_iommu_type1.c |   36 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index cc1d64765ce7..4a4cb7cd86b2 100644
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -317,6 +317,32 @@ static int put_pfn(unsigned long pfn, int prot)
> >  	return 0;
> >  }
> >  
> > +static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
> > +			    unsigned long vaddr, unsigned long *pfn,
> > +			    bool write_fault)
> > +{
> > +	int ret;
> > +
> > +	ret = follow_pfn(vma, vaddr, pfn);
> > +	if (ret) {
> > +		bool unlocked = false;
> > +
> > +		ret = fixup_user_fault(NULL, mm, vaddr,
> > +				       FAULT_FLAG_REMOTE |
> > +				       (write_fault ?  FAULT_FLAG_WRITE : 0),
> > +				       &unlocked);
> > +		if (unlocked)
> > +			return -EAGAIN;
> > +
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = follow_pfn(vma, vaddr, pfn);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
> >  			 int prot, unsigned long *pfn)
> >  {
> > @@ -339,12 +365,16 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
> >  
> >  	vaddr = untagged_addr(vaddr);
> >  
> > +retry:
> >  	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
> >  
> >  	if (vma && vma->vm_flags & VM_PFNMAP) {
> > -		if (!follow_pfn(vma, vaddr, pfn) &&
> > -		    is_invalid_reserved_pfn(*pfn))
> > -			ret = 0;
> > +		ret = follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
> > +		if (ret == -EAGAIN)
> > +			goto retry;
> > +
> > +		if (!ret && !is_invalid_reserved_pfn(*pfn))
> > +			ret = -EFAULT;  
> 
> I suggest checking vma->vm_ops == &vfio_pci_mmap_ops and adding a
> comment that this is racy and needs to be fixed up. The ops check
> makes this only used by other vfio bars and should prevent some
> abuses of this hacky thing

We can't do that, vfio-pci is only one bus driver within the vfio
ecosystem.

> However, I wonder if this chould just link itself into the
> vma->private data so that when the vfio that owns the bar goes away,
> so does the iommu mapping?

I don't really see why we wouldn't use mmu notifiers so that the vfio
iommu backend and vfio bus driver remain independent.

> I feel like this patch set is not complete unless it also handles the
> shootdown of this path too?

It would be nice to solve both issues and I'll start working on the mmu
notifier side of things, but this series does solve a real issue on
its own and we're not changing the iommu mapping behavior here.  Thanks,

Alex

