Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7FC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE0D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cf0mh8pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgEHCRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:17:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726618AbgEHCRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588904221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WtjazxlEuskMF4wPNnQP3Ty5Cta06wXamFiE9VjuwNg=;
        b=Cf0mh8piFkUCVgISaaruR0DviQQ3W3E2VxzoT3X61m0+5lWjgtPqdN9bsrRGPyeYcvPpGy
        3d51BgyF0Si3Y6zU032Tb+BfMYthKVB/MRpvrHzU7ZxvJLuCoxntCJkrbjIGzpR0Z2wrzO
        o6yMIPt8lUG3b+23ce+6FhUq3eTLcpM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-lpRUh_uuO8WeY2B64fPJ-w-1; Thu, 07 May 2020 22:16:59 -0400
X-MC-Unique: lpRUh_uuO8WeY2B64fPJ-w-1
Received: by mail-qt1-f197.google.com with SMTP id y31so112303qta.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WtjazxlEuskMF4wPNnQP3Ty5Cta06wXamFiE9VjuwNg=;
        b=oUDxpkt/XHpoFq/T2Ns4AbQ1Po4PaGBWVUpnuAApiuUDOFziHz1wW7hrEstDdWu8Ap
         +63Mx8A5pxsY5wOSwupLbq+iSAKQBD1Rm+g+QJkrf0fgTRzCqEkK5cHfoyyHam/jMr/2
         frCGNQNWGm+e0OhT1jNprG/+k7qf2JZvc2HDozPU0wXb6KIcA6vanix58vfPwKJ6dfGm
         auJyPrqi879oNRLsXzTmolEFwBpysf1xUbrnXKaqaHN2z9xUcAgzHMAHANz3lZeH3P6N
         Up8+N+BScYDFvWIBRaOciij9InyZHVer15piCsaNEKLVWqPvuTg6pVO7iLmXnwTcZQmH
         e1WA==
X-Gm-Message-State: AGi0PuaFQP5+slRBB91NcdS5Y5PE1NorngYpJmynX8Zi/tuw+ZpTYv0p
        DhV2x0gFQaVNPdxFiIy0+DHqW22gTykTX13uUI7OM20PPP2L/LXSTfRcZxGqDoYjJwqA1+r6LrQ
        aJayODooMZAx1xZx8zpVf5LU+
X-Received: by 2002:ac8:1e91:: with SMTP id c17mr513576qtm.237.1588904218795;
        Thu, 07 May 2020 19:16:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypKMCJLQFlz4Jrv1e8UQwTefpV+CtILqg45Ii+fu35tC1S+zdxR7Le6TrpKICh1tIWhWqh9sEQ==
X-Received: by 2002:ac8:1e91:: with SMTP id c17mr513566qtm.237.1588904218488;
        Thu, 07 May 2020 19:16:58 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p68sm45146qka.56.2020.05.07.19.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 19:16:57 -0700 (PDT)
Date:   Thu, 7 May 2020 22:16:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH v2 2/3] vfio-pci: Fault mmaps to enable vma tracking
Message-ID: <20200508021656.GS228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871569380.15589.16950418949340311053.stgit@gimli.home>
 <20200507214744.GP228260@xz-x1>
 <20200507160334.4c029518@x1.home>
 <20200507222223.GR228260@xz-x1>
 <20200507235633.GL26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507235633.GL26002@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 08:56:33PM -0300, Jason Gunthorpe wrote:
> On Thu, May 07, 2020 at 06:22:23PM -0400, Peter Xu wrote:
> > On Thu, May 07, 2020 at 04:03:34PM -0600, Alex Williamson wrote:
> > > On Thu, 7 May 2020 17:47:44 -0400
> > > Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > > Hi, Alex,
> > > > 
> > > > On Tue, May 05, 2020 at 03:54:53PM -0600, Alex Williamson wrote:
> > > > > +/*
> > > > > + * Zap mmaps on open so that we can fault them in on access and therefore
> > > > > + * our vma_list only tracks mappings accessed since last zap.
> > > > > + */
> > > > > +static void vfio_pci_mmap_open(struct vm_area_struct *vma)
> > > > > +{
> > > > > +	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);  
> > > > 
> > > > A pure question: is this only a safety-belt or it is required in some known
> > > > scenarios?
> > > 
> > > It's not required.  I originally did this so that I'm not allocating a
> > > vma_list entry in a path where I can't return error, but as Jason
> > > suggested I could zap here only in the case that I do encounter that
> > > allocation fault.  However I still like consolidating the vma_list
> > > handling to the vm_ops .fault and .close callbacks and potentially we
> > > reduce the zap latency by keeping the vma_list to actual users, which
> > > we'll get to eventually anyway in the VM case as memory BARs are sized
> > > and assigned addresses.
> > 
> > Yes, I don't see much problem either on doing the vma_list maintainance only in
> > .fault() and .close().  My understandingg is that the worst case is the perf
> > critical applications (e.g. DPDK) could pre-fault these MMIO region easily
> > during setup if they want.  My question was majorly about whether the vma
> > should be guaranteed to have no mapping at all when .open() is called.  But I
> > agree with you that it's always good to have that as safety-belt anyways.
> 
> If the VMA has a mapping then that specific VMA has to be in the
> linked list.
> 
> So if the zap is skipped then the you have to allocate something and
> add to the linked list to track the VMA with mapping.
> 
> It is not a 'safety belt'

But shouldn't open() only be called when the VMA is created for a memory range?
If so, does it also mean that the address range must have not been mapped yet?

Thanks,

-- 
Peter Xu

