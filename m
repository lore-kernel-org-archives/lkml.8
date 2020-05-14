Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB6AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48160206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K10FdPko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgENWz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:55:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728905AbgENWz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589496926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s60HPftkf4Owq2vrt/qsbxPUPVWT2uYw/1cJBRV5Spg=;
        b=K10FdPkosCZDdn1xQ9ni01yfREq3HEHC0QEyBL5q7uapMTPlxamI2/vf74FgjtIokGyEfb
        91mu0rdu9n2MbYPrK58ioE21Vxfq/dD1wtupbkYX333OHZYTLeMRbvr+wd5/tbmu1I8nPV
        ZquCYnVyWjPS7bOXiPXpzsNLokZE5e4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-yG2JHT_vPUueah0Pj2kQBw-1; Thu, 14 May 2020 18:55:22 -0400
X-MC-Unique: yG2JHT_vPUueah0Pj2kQBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B994108BD0E;
        Thu, 14 May 2020 22:55:21 +0000 (UTC)
Received: from w520.home (ovpn-113-111.phx2.redhat.com [10.3.113.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4434C5C1D3;
        Thu, 14 May 2020 22:55:18 +0000 (UTC)
Date:   Thu, 14 May 2020 16:55:17 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH 0/2] vfio/type1/pci: IOMMU PFNMAP invalidation
Message-ID: <20200514165517.3df5a9ef@w520.home>
In-Reply-To: <20200514222415.GA24575@ziepe.ca>
References: <158947414729.12590.4345248265094886807.stgit@gimli.home>
        <20200514212538.GB449815@xz-x1>
        <20200514161712.14b34984@w520.home>
        <20200514222415.GA24575@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 19:24:15 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, May 14, 2020 at 04:17:12PM -0600, Alex Williamson wrote:
> 
> > that much.  I think this would also address Jason's primary concern.
> > It's better to get an IOMMU fault from the user trying to access those
> > mappings than it is to leave them in place.  
> 
> Yes, there are few options here - if the pages are available for use
> by the IOMMU and *asynchronously* someone else revokes them, then the
> only way to protect the kernel is to block them from the IOMMUU.
> 
> For this to be sane the revokation must be under complete control of
> the VFIO user. ie if a user decides to disable MMIO traffic then of
> course the IOMMU should block P2P transfer to the MMIO bar. It is user
> error to have not disabled those transfers in the first place.
> 
> When this is all done inside a guest the whole logic applies. On bare
> metal you might get some AER or crash or MCE. In virtualization you'll
> get an IOMMU fault.
> 
> > due to the memory enable bit.  If we could remap the range to a kernel
> > page we could maybe avoid the IOMMU fault and maybe even have a crude
> > test for whether any data was written to the page while that mapping
> > was in place (ie. simulating more restricted error handling, though
> > more asynchronous than done at the platform level).    
> 
> I'm not if this makes sense, can't we arrange to directly trap the
> IOMMU failure and route it into qemu if that is what is desired?

Can't guarantee it, some systems wire that directly into their
management processor so that they can "protect their users" regardless
of whether they want or need it.  Yay firmware first error handling,
*sigh*.  Thanks,

Alex

