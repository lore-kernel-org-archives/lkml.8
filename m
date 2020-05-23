Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC63DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0EA20727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgLRwB4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbgEWXxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 19:53:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23342 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388214AbgEWXxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 19:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590277982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d5MrxvWGXldufWJs7NZEwPFjZd8K8vtfRkxI4AQZlGI=;
        b=cgLRwB4GMIwOCRaVFOMo1ODhW9c5l/hovmjGxxEKNljeBFtXNdUtSMjjX6gxenSwXhOOCj
        pVlp87WKohsBz/Y2XyynlJTzFbz0lpdSd8zb9lbtY0rUdpIIYcCVliTIT5JU0B1DW+VK4t
        8+IoFhNS7DW1kfCi+L5Mh2kAsTzMClA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-2ehFbfKTOVGNUm4ddl-dbQ-1; Sat, 23 May 2020 19:53:01 -0400
X-MC-Unique: 2ehFbfKTOVGNUm4ddl-dbQ-1
Received: by mail-qt1-f198.google.com with SMTP id c20so15973814qtw.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 16:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d5MrxvWGXldufWJs7NZEwPFjZd8K8vtfRkxI4AQZlGI=;
        b=sRl38/vz3QOkIkbqo/Iv28qyQR686k0wC+gBkBoU5L7Oi3bbKKzznuEwsHOftQk5NL
         xPV9vTt1Z44hOeaJiXVii+WZy4UntsANllUdHVZbGPEYQyVGAFpdGIyR2eGdUu+st9CO
         XU3TBvd14LVNSFDIGOcmZXBOcm+OLsxwfWaR0UYVRAqWDjawlLOt4y0moy5xbwmhohTK
         8+uxpSN1jgd2pPKJ2IqViAHTQRnmiL7K/yVEk8vFP0AE265l1uXvQKtyVkwiNFCFfbrO
         qodcEwYJ4Qhxe1DqgNfbYQ2vLTV2rhGFhmg5Iiwd2d9j/4KjaIZuPq+/VBpSXDHui48A
         vgLw==
X-Gm-Message-State: AOAM532702GcmZCEVfK9xm7cKQc3iUZ7GSXSAfdLdxNA/4f/1PKYQDqQ
        WIM5Kwz0zsDuNl8v7obKDUeal0cLPkDOn+Hh2hDh8zURadzP6DVeEAphFW1DAquRShRZ7c3artc
        wLcvtSh6GBxxtrKRzQSuMaXKL
X-Received: by 2002:ac8:44da:: with SMTP id b26mr714074qto.232.1590277980461;
        Sat, 23 May 2020 16:53:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd+LSpddoLxFiIcA0YLSw6zts0WQ9RwwRPpO+xy4rpZASSnwuYtQt3y4PM6BzIUDMtUDgyBQ==
X-Received: by 2002:ac8:44da:: with SMTP id b26mr714062qto.232.1590277980189;
        Sat, 23 May 2020 16:53:00 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g14sm7981038qtr.52.2020.05.23.16.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 16:52:59 -0700 (PDT)
Date:   Sat, 23 May 2020 19:52:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca, cai@lca.pw
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200523235257.GC939059@xz-x1>
References: <159017449210.18853.15037950701494323009.stgit@gimli.home>
 <159017506369.18853.17306023099999811263.stgit@gimli.home>
 <20200523193417.GI766834@xz-x1>
 <20200523170602.5eb09a66@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200523170602.5eb09a66@x1.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 05:06:02PM -0600, Alex Williamson wrote:
> On Sat, 23 May 2020 15:34:17 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > Hi, Alex,
> > 
> > On Fri, May 22, 2020 at 01:17:43PM -0600, Alex Williamson wrote:
> > > @@ -1346,15 +1526,32 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
> > >  {
> > >  	struct vm_area_struct *vma = vmf->vma;
> > >  	struct vfio_pci_device *vdev = vma->vm_private_data;
> > > +	vm_fault_t ret = VM_FAULT_NOPAGE;
> > > +
> > > +	mutex_lock(&vdev->vma_lock);
> > > +	down_read(&vdev->memory_lock);  
> > 
> > I remembered to have seen the fault() handling FAULT_FLAG_RETRY_NOWAIT at least
> > in the very first version, but it's not here any more...  Could I ask what's
> > the reason behind?  I probably have missed something along with the versions,
> > I'm just not sure whether e.g. this would potentially block a GUP caller even
> > if it's with FOLL_NOWAIT.
> 
> This is largely what v2 was about, from the cover letter:
> 
>     Locking in 3/ is substantially changed to avoid the retry scenario
>     within the fault handler, therefore a caller who does not allow
>     retry will no longer receive a SIGBUS on contention.
> 
> The discussion thread starts here:
> 
> https://lore.kernel.org/kvm/20200501234849.GQ26002@ziepe.ca/

[1]

> 
> Feel free to interject if there's something that doesn't make sense,
> the idea is that since we've fixed the lock ordering we never need to
> release one lock to wait for another, therefore we can wait for the
> lock.  I'm under the impression that we can wait for the lock
> regardless of the flags under these conditions.

I see; thanks for the link.  Sorry I should probably follow up the discussion
and ask the question earlier, anyway...

For what I understand now, IMHO we should still need all those handlings of
FAULT_FLAG_RETRY_NOWAIT like in the initial version.  E.g., IIUC KVM gup will
try with FOLL_NOWAIT when async is allowed, before the complete slow path.  I'm
not sure what would be the side effect of that if fault() blocked it.  E.g.,
the caller could be in an atomic context.

But now I also agree that VM_FAULT_SIGBUS is probably not correct there in the
initial version [1] - I thought it was OK initially (after all after the
multiple fault retry series we should always be with FAULT_FLAG_ALLOW_RETRY..).
However after some thinking... it should be the common slow path where retry is
simply not allowed.  So IMHO instead of SIGBUS there, we should also use all
the slow path of the locks.  That'll be safe then because it's never going to
be with FAULT_FLAG_RETRY_NOWAIT (FAULT_FLAG_RETRY_NOWAIT depends on
FAULT_FLAG_ALLOW_RETRY).

A reference code could be __lock_page_or_retry() where the lock_page could wait
just like we taking the sems/mutexes, and the previous SIGBUS case would
corresponds to this chunk of __lock_page_or_retry():

	} else {
		if (flags & FAULT_FLAG_KILLABLE) {
			int ret;

			ret = __lock_page_killable(page);
			if (ret) {
				up_read(&mm->mmap_sem);
				return 0;
			}
		} else
			__lock_page(page);
		return 1;
	}

Thanks,

-- 
Peter Xu

