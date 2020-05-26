Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E862075F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St6e8pLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgEZOrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:47:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57867 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbgEZOq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590504418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FDGK+OjCUJLD9YnRXgr/ePzn54Xe7e1OJ00JC3HKiE=;
        b=St6e8pLjtCkEpimFbOVlSxjLwAtlizW4d/m0BucXj9g8txzkCMiK94AOttlFLFg8nUvnyl
        JKgx2j6sZ6GtL3CPxdJ5/b9K+GNfhso1CYlvD1Q9EZffPIMXAJUGwRp1/qRjlmZLlpw5yA
        LwFXSbLuxxa+4w8WHC4icCNeLU2T8ro=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-dG2H211mN2WchmIQbXz3GQ-1; Tue, 26 May 2020 10:46:54 -0400
X-MC-Unique: dG2H211mN2WchmIQbXz3GQ-1
Received: by mail-qk1-f197.google.com with SMTP id q16so20838550qki.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4FDGK+OjCUJLD9YnRXgr/ePzn54Xe7e1OJ00JC3HKiE=;
        b=h/EhKn+RJkK0AOWLtYftUKQVXtfPPuBw3Mb5+5qsjTH8XRgKZYTT8CCadPMJ2bALyO
         Y12Tg/DLkh1VgqhWEbL1ePe6OOX+mG+vHCJCi8l72EGYXZqDgwo/CrDndRcJEBlqkiGC
         5XjkgnQSy/+HPN+s/jJ2Ga6cju6Dux2Oj2gQlYb+bNnq5CnfBPXK/aRZs1F4JmKfds1+
         /0OXfOsEyjopgqX5/rG/56KBZ2dJpgTjO1R1ROLiC0w2tkW9HUKfKHd31Oa6lZAHD286
         3S77XDiF5GnVDqalQI/6Y6hPGixRBq/5PYusTSFzNnVW2zLd0uoHqCiqZJHMJLYGEESy
         hZBg==
X-Gm-Message-State: AOAM532YXJe/hZKnJjHBqsPSQKG6CSHdnXdZvDsbVTQhmsVtenqKbhRF
        ZCCjjyx5nUdNXbsJPBEVT/IdxrYVtsUvkfHtwGN2/FZdsmLCLhvykjlMm1IoksnXgdxWNzll+ss
        UeagpWnTmjpRqdGwOA7dBcMGw
X-Received: by 2002:ac8:4448:: with SMTP id m8mr1665064qtn.4.1590504413581;
        Tue, 26 May 2020 07:46:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4YKxvIR1BQhdAX7Go3H9kSu3wCIMk6WfH8mweswP0F9y76AyYYcD5j8iW+LPNFmVqpXOUxg==
X-Received: by 2002:ac8:4448:: with SMTP id m8mr1665020qtn.4.1590504413240;
        Tue, 26 May 2020 07:46:53 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id z10sm17900998qtu.22.2020.05.26.07.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:46:52 -0700 (PDT)
Date:   Tue, 26 May 2020 10:46:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, cai@lca.pw,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200526144650.GB1190778@xz-x1>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200526083218.40402f01@x1.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:32:18AM -0600, Alex Williamson wrote:
> On Tue, 26 May 2020 09:49:54 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, May 25, 2020 at 09:37:05PM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 25, 2020 at 01:56:28PM -0700, John Hubbard wrote:  
> > > > On 2020-05-25 09:56, Jason Gunthorpe wrote:  
> > > > > On Mon, May 25, 2020 at 11:11:42AM -0400, Peter Xu wrote:  
> > > > > > On Mon, May 25, 2020 at 11:46:51AM -0300, Jason Gunthorpe wrote:  
> > > > > > > On Mon, May 25, 2020 at 10:28:06AM -0400, Peter Xu wrote:  
> > > > > > > > On Mon, May 25, 2020 at 09:26:07AM -0300, Jason Gunthorpe wrote:  
> > > > > > > > > On Sat, May 23, 2020 at 07:52:57PM -0400, Peter Xu wrote:
> > > > > > > > >   
> > > > > > > > > > For what I understand now, IMHO we should still need all those handlings of
> > > > > > > > > > FAULT_FLAG_RETRY_NOWAIT like in the initial version.  E.g., IIUC KVM gup will
> > > > > > > > > > try with FOLL_NOWAIT when async is allowed, before the complete slow path.  I'm
> > > > > > > > > > not sure what would be the side effect of that if fault() blocked it.  E.g.,
> > > > > > > > > > the caller could be in an atomic context.  
> > > > > > > > > 
> > > > > > > > > AFAICT FAULT_FLAG_RETRY_NOWAIT only impacts what happens when
> > > > > > > > > VM_FAULT_RETRY is returned, which this doesn't do?  
> > > > > > > > 
> > > > > > > > Yes, that's why I think we should still properly return VM_FAULT_RETRY if
> > > > > > > > needed..  because IMHO it is still possible that the caller calls with
> > > > > > > > FAULT_FLAG_RETRY_NOWAIT.
> > > > > > > > 
> > > > > > > > My understanding is that FAULT_FLAG_RETRY_NOWAIT majorly means:
> > > > > > > > 
> > > > > > > >    - We cannot release the mmap_sem, and,
> > > > > > > >    - We cannot sleep  
> > > > > > > 
> > > > > > > Sleeping looks fine, look at any FS implementation of fault, say,
> > > > > > > xfs. The first thing it does is xfs_ilock() which does down_write().  
> > > > > > 
> > > > > > Yeah.  My wild guess is that maybe fs code will always be without
> > > > > > FAULT_FLAG_RETRY_NOWAIT so it's safe to sleep unconditionally (e.g., I think
> > > > > > the general #PF should be fine to sleep in fault(); gup should be special, but
> > > > > > I didn't observe any gup code called upon file systems)?  
> > > > > 
> > > > > get_user_pages is called on filesystem backed pages.
> > > > > 
> > > > > I have no idea what FAULT_FLAG_RETRY_NOWAIT is supposed to do. Maybe
> > > > > John was able to guess when he reworked that stuff?
> > > > >   
> > > > 
> > > > Although I didn't end up touching that particular area, I'm sure it's going
> > > > to come up sometime soon, so I poked around just now, and found that
> > > > FAULT_FLAG_RETRY_NOWAIT was added almost exactly 9 years ago. This flag was
> > > > intended to make KVM and similar things behave better when doing GUP on
> > > > file-backed pages that might, or might not be in memory.
> > > > 
> > > > The idea is described in the changelog, but not in the code comments or
> > > > Documentation, sigh:
> > > > 
> > > > commit 318b275fbca1ab9ec0862de71420e0e92c3d1aa7
> > > > Author: Gleb Natapov <gleb@redhat.com>
> > > > Date:   Tue Mar 22 16:30:51 2011 -0700
> > > > 
> > > >     mm: allow GUP to fail instead of waiting on a page
> > > > 
> > > >     GUP user may want to try to acquire a reference to a page if it is already
> > > >     in memory, but not if IO, to bring it in, is needed.  For example KVM may
> > > >     tell vcpu to schedule another guest process if current one is trying to
> > > >     access swapped out page.  Meanwhile, the page will be swapped in and the
> > > >     guest process, that depends on it, will be able to run again.
> > > > 
> > > >     This patch adds FAULT_FLAG_RETRY_NOWAIT (suggested by Linus) and
> > > >     FOLL_NOWAIT follow_page flags.  FAULT_FLAG_RETRY_NOWAIT, when used in
> > > >     conjunction with VM_FAULT_ALLOW_RETRY, indicates to handle_mm_fault that
> > > >     it shouldn't drop mmap_sem and wait on a page, but return VM_FAULT_RETRY
> > > >     instead.  
> > > 
> > > So, from kvm's perspective it was to avoid excessively long blocking in
> > > common paths when it could rejoin the completed IO by somehow waiting
> > > on a page itself?
> > > 
> > > It all seems like it should not be used unless the page is going to go
> > > to IO?  
> > 
> > I think NOWAIT is used as a common flag for kvm for its initial attempt to
> > fault in a normal page, however...  I just noticed another fact that actually
> > __get_user_pages() won't work with PFNMAP (check_vma_flags should fail), but
> > KVM just started to support fault() for PFNMAP from commit add6a0cd1c5b (2016)
> > using fixup_user_fault(), where nvidia seems to have a similar request to have
> > a fault handler on some mapped BARs.
> > 
> > > 
> > > Certainly there is no reason to optimize the fringe case of vfio
> > > sleeping if there is and incorrect concurrnent attempt to disable the
> > > a BAR.  
> > 
> > If fixup_user_fault() (which is always with ALLOW_RETRY && !RETRY_NOWAIT) is
> > the only path for the new fault(), then current way seems ok.  Not sure whether
> > this would worth a WARN_ON_ONCE(RETRY_NOWAIT) in the fault() to be clear of
> > that fact.
> 
> Thanks for the discussion over the weekend folks.  Peter, I take it
> you'd be satisfied if this patch were updated as:
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index aabba6439a5b..35bd7cd4e268 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1528,6 +1528,13 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
>  	struct vfio_pci_device *vdev = vma->vm_private_data;
>  	vm_fault_t ret = VM_FAULT_NOPAGE;
>  
> +	/*
> +	 * We don't expect to be called with NOWAIT and there are conflicting
> +	 * opinions on whether NOWAIT suggests we shouldn't wait for locks or
> +	 * just shouldn't wait for I/O.
> +	 */
> +	WARN_ON_ONCE(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
> +
>  	mutex_lock(&vdev->vma_lock);
>  	down_read(&vdev->memory_lock);
>  
> 
> Is that correct?  Thanks,

Yes, actually either with or without it. :)

Since I've read through the patch too and I don't see any issue from my side
besides this one, FWIW.. please also feel free to take my r-b:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

