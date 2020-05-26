Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB941C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842F92075F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUq4jBx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgEZP54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:57:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727926AbgEZP5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590508674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5zh+s+IprJj3EQMEv2Qd48tdeWkShgTQ5MUrKFvWkg=;
        b=HUq4jBx+s+UTscCMiLBXN7pP7h+nt4nNY4OwHceAXXr54WTrSHZh3f58lOZrvqtZTT6udX
        ZQ8Htx+0PTXwC5L+em9Srh6LKvdw8RKMdKDglk0NMDrtD5CcvbWqLqNwWwpa+C7bADDZm+
        TmIADBL/KzKWtTpzBLoMc7Y+s00K5uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Sce2_GM2NsWgJohxMwrbog-1; Tue, 26 May 2020 11:57:50 -0400
X-MC-Unique: Sce2_GM2NsWgJohxMwrbog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F119E108597D;
        Tue, 26 May 2020 15:57:46 +0000 (UTC)
Received: from x1.home (ovpn-114-203.phx2.redhat.com [10.3.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA8BD79C4E;
        Tue, 26 May 2020 15:57:43 +0000 (UTC)
Date:   Tue, 26 May 2020 09:57:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, cai@lca.pw,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200526095743.3e68c791@x1.home>
In-Reply-To: <20200526155331.GN744@ziepe.ca>
References: <20200523235257.GC939059@xz-x1>
        <20200525122607.GC744@ziepe.ca>
        <20200525142806.GC1058657@xz-x1>
        <20200525144651.GE744@ziepe.ca>
        <20200525151142.GE1058657@xz-x1>
        <20200525165637.GG744@ziepe.ca>
        <3d9c1c8b-5278-1c4d-0e9c-e6f8fdb75853@nvidia.com>
        <20200526003705.GK744@ziepe.ca>
        <20200526134954.GA1125781@xz-x1>
        <20200526083218.40402f01@x1.home>
        <20200526155331.GN744@ziepe.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 12:53:31 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, May 26, 2020 at 08:32:18AM -0600, Alex Williamson wrote:
> > > > Certainly there is no reason to optimize the fringe case of vfio
> > > > sleeping if there is and incorrect concurrnent attempt to disable the
> > > > a BAR.    
> > > 
> > > If fixup_user_fault() (which is always with ALLOW_RETRY && !RETRY_NOWAIT) is
> > > the only path for the new fault(), then current way seems ok.  Not sure whether
> > > this would worth a WARN_ON_ONCE(RETRY_NOWAIT) in the fault() to be clear of
> > > that fact.  
> > 
> > Thanks for the discussion over the weekend folks.  Peter, I take it
> > you'd be satisfied if this patch were updated as:
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index aabba6439a5b..35bd7cd4e268 100644
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -1528,6 +1528,13 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
> >  	struct vfio_pci_device *vdev = vma->vm_private_data;
> >  	vm_fault_t ret = VM_FAULT_NOPAGE;
> >  
> > +	/*
> > +	 * We don't expect to be called with NOWAIT and there are conflicting
> > +	 * opinions on whether NOWAIT suggests we shouldn't wait for locks or
> > +	 * just shouldn't wait for I/O.
> > +	 */
> > +	WARN_ON_ONCE(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);  
> 
> I don't think this is right, this implies there is some reason this
> code fails with FAULT_FLAG_RETRY_NOWAIT - but it is fine as written,
> AFAICT

Ok, Peter said he's fine either way, I'll use the patch as originally
posted and include Peter's R-b.  Thanks,

Alex

