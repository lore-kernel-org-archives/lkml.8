Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F17FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61ED8206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589442423;
	bh=wN80gGI8V+ylaxhZ0uVEzr/XB82cdY/3/3iPL444rCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o5RxKUtW2Oa1q78Rba2zE0sCL5/GhKigSKxA4hZCkuooa6NAvtHLxpFxv0F9FN/VT
	 xbjo6ouWrFEg9iBJwB5sJPW0oG3bDM4sqQqOV8duQnapuBTOS1Lhzoi3PC9TOOON0i
	 UPcX16ACNPodqN3u71D3Kr1VwopN/EasRiBEpedM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgENHrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgENHrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:47:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E34206BE;
        Thu, 14 May 2020 07:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589442421;
        bh=wN80gGI8V+ylaxhZ0uVEzr/XB82cdY/3/3iPL444rCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wyV8dKIjLO7rETVBqMxhDcXNwBCiYADAEr93vBBL4ZJl/y577W1fIntacfew8QfRa
         vt5DU2KMibyPDnZ18TCUQvd8fHYQRg6g/OvM9AAqpcaLisyd/3np0z7HHNyqbuhARI
         2sNCauNuuF90gzLVvznhjQAUFqDJAkmpKjMrP3jk=
Date:   Thu, 14 May 2020 09:46:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>, jeremy.linton@arm.com
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: Validating dma_mmap_coherent() parameters before calling (was
 Re: WARNING in memtype_reserve)
Message-ID: <20200514074659.GA1569055@kroah.com>
References: <000000000000f0d8d205a531f1a3@google.com>
 <20200509074507.GC1831917@kroah.com>
 <87wo5l4ecm.fsf@nanos.tec.linutronix.de>
 <20200513124445.GA1082735@kroah.com>
 <87zhab249p.fsf@nanos.tec.linutronix.de>
 <20200514035458.14760-1-hdanton@sina.com>
 <20200514061417.GA8367@lst.de>
 <20200514062750.GA1488715@kroah.com>
 <20200514063158.GA8780@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514063158.GA8780@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:31:58AM +0200, Christoph Hellwig wrote:
> On Thu, May 14, 2020 at 08:27:50AM +0200, Greg KH wrote:
> > On Thu, May 14, 2020 at 08:14:17AM +0200, Christoph Hellwig wrote:
> > > Guys, can you please start formal thread on this?  I have no
> > > idea where this came from and what the rationale is.  Btw, if the
> > > pfn is crap in dma_direct_mmap then the dma_addr_t passed in is
> > > crap, as it is derived from that.  What is the caller, and how is
> > > this triggered?
> > 
> > 
> > Ok, to summarize, commit 2bef9aed6f0e ("usb: usbfs: correct kernel->user
> > page attribute mismatch") changed a call from remap_pfn_range() to
> > dma_mmap_coherent() for usb data buffers being sent from userspace.
> 
> I only need to look at the commit for 3 seconds to tell you that it is
> completely buggy.  While using dma_mmap_coherent is fundamentally the
> right thing and absolutely required for dma_alloc_* allocations, USB
> also uses it's own local gen pool allocator or plain kmalloc for not
> DMA capable controller.  This need to use remap_pfn_range.  I'm pretty
> sure you hit one of those cases.
> 
> The logic should be something like:
> 
> 	if (hcd->localmem_pool || !hcd_uses_dma(hcd))
> 		remap_pfn_range()
> 	else
> 		dma_mmap_coherent()

Ok, that's simple enough, patch is below.

Jeremy, any objection to this change?

thanks,

greg k-h


diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index b9db9812d6c5..d93d94d7ff50 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -251,9 +251,19 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	usbm->vma_use_count = 1;
 	INIT_LIST_HEAD(&usbm->memlist);
 
-	if (dma_mmap_coherent(hcd->self.sysdev, vma, mem, dma_handle, size)) {
-		dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
-		return -EAGAIN;
+	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
+		if (remap_pfn_range(vma, vma->vm_start,
+				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
+				    size, vma->vm_page_prot) < 0) {
+			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
+			return -EAGAIN;
+		}
+	} else {
+		if (dma_mmap_coherent(hcd->self.sysdev, vma, mem, dma_handle,
+				      size)) {
+			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
+			return -EAGAIN;
+		}
 	}
 
 	vma->vm_flags |= VM_IO;
