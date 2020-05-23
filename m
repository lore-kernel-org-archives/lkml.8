Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4958320727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9Ujea8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbgEWXGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 19:06:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59861 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388010AbgEWXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 19:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590275169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhu/kTFieytwhBfr5HP0IL0qZ1WKf06pn6VE9qR+1dI=;
        b=D9Ujea8VE5pi//wqRaU9447739+OecCG6zxCAecb9IHpR90mKlWfireHfVrlGBfMmJSRMj
        vd4Oe4bQ6/9EhmRLYBdmwWpmEjhp7A6p94q4i3Xuhw/hNW6CGv0bDUXHcYiicikswgQ7Ae
        61PNsIk/gBwEv9f2zC4QmSbUiRhu8fE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-3XezQTksN6mvlh47jhwi-Q-1; Sat, 23 May 2020 19:06:07 -0400
X-MC-Unique: 3XezQTksN6mvlh47jhwi-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD7A835B40;
        Sat, 23 May 2020 23:06:06 +0000 (UTC)
Received: from x1.home (ovpn-114-203.phx2.redhat.com [10.3.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54C8F1BCBE;
        Sat, 23 May 2020 23:06:02 +0000 (UTC)
Date:   Sat, 23 May 2020 17:06:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca, cai@lca.pw
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200523170602.5eb09a66@x1.home>
In-Reply-To: <20200523193417.GI766834@xz-x1>
References: <159017449210.18853.15037950701494323009.stgit@gimli.home>
        <159017506369.18853.17306023099999811263.stgit@gimli.home>
        <20200523193417.GI766834@xz-x1>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 May 2020 15:34:17 -0400
Peter Xu <peterx@redhat.com> wrote:

> Hi, Alex,
> 
> On Fri, May 22, 2020 at 01:17:43PM -0600, Alex Williamson wrote:
> > @@ -1346,15 +1526,32 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> >  	struct vfio_pci_device *vdev = vma->vm_private_data;
> > +	vm_fault_t ret = VM_FAULT_NOPAGE;
> > +
> > +	mutex_lock(&vdev->vma_lock);
> > +	down_read(&vdev->memory_lock);  
> 
> I remembered to have seen the fault() handling FAULT_FLAG_RETRY_NOWAIT at least
> in the very first version, but it's not here any more...  Could I ask what's
> the reason behind?  I probably have missed something along with the versions,
> I'm just not sure whether e.g. this would potentially block a GUP caller even
> if it's with FOLL_NOWAIT.

This is largely what v2 was about, from the cover letter:

    Locking in 3/ is substantially changed to avoid the retry scenario
    within the fault handler, therefore a caller who does not allow
    retry will no longer receive a SIGBUS on contention.

The discussion thread starts here:

https://lore.kernel.org/kvm/20200501234849.GQ26002@ziepe.ca/

Feel free to interject if there's something that doesn't make sense,
the idea is that since we've fixed the lock ordering we never need to
release one lock to wait for another, therefore we can wait for the
lock.  I'm under the impression that we can wait for the lock
regardless of the flags under these conditions.

> Side note: Another thing I thought about when reading this patch - there seems
> to have quite some possibility that the VFIO_DEVICE_PCI_HOT_RESET ioctl will
> start to return -EBUSY now.  Not a problem for this series, but maybe we should
> rememeber to let the userspace handle -EBUSY properly as follow up too, since I
> saw QEMU seemed to not handle -EBUSY for host reset path right now.

I think this has always been the case, whether it's the device lock or
this lock, the only way I know to avoid potential deadlock is to use
the 'try' locking semantics.  In normal scenarios I expect access to
sibling devices is quiesced at this point, so a user driver actually
wanting to achieve a reset shouldn't be affected by this.  Thanks,

Alex

