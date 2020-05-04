Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373D9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127D92078E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588576393;
	bh=XfFhhStBycJzV0puy65G2AGQGcJw71aLuImYtkVyKy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HO0ny9gp22XCnykpUfgCulAPQbijGYW8Qiu9P1Qq/J8PPS/sWdMmH/np3nYLzEAMa
	 2Cd8hDatPu8+VQujdHycnKaIVIZcJxHDWTQJ3HcuSFJLqFO6H+hFTitTDpBQWdAFP6
	 mqiiNq0VluciocGNuACz4a4l3O8YvZxaEjq7I2bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEDHNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgEDHNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA5420757;
        Mon,  4 May 2020 07:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588576390;
        bh=XfFhhStBycJzV0puy65G2AGQGcJw71aLuImYtkVyKy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PN6OVx5JB5/9SQpEja8hYrfZezsED5+zQGTFoXQ1/Tyk+8+nqB/XuGG0UuKkQweP+
         FVlGCGy6RsuefwhtdM25LkXiPLAWeD78PCEqUKTZLBzzLkp84ji3V3DmIXA18j3RnO
         VnbSPAV01ET9XxFSbqCTDJ+NdEbt/8NTdzh/ly9s=
Date:   Mon, 4 May 2020 09:13:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        git@thegavinli.com, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: usbfs: correct kernel->user page attribute mismatch
Message-ID: <20200504071306.GA831956@kroah.com>
References: <20200430211922.929165-1-jeremy.linton@arm.com>
 <20200501070500.GA887524@kroah.com>
 <d2d4f50e-a0bf-77c8-399b-86c2137bfa84@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d4f50e-a0bf-77c8-399b-86c2137bfa84@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:47:22AM -0500, Jeremy Linton wrote:
> Hi,
> 
> Thanks for taking a look at this.
> 
> On 5/1/20 2:05 AM, Greg KH wrote:
> > On Thu, Apr 30, 2020 at 04:19:22PM -0500, Jeremy Linton wrote:
> > > On arm64, and possibly other architectures, requesting
> > > IO coherent memory may return Normal-NC if the underlying
> > > hardware isn't coherent. If these pages are then
> > > remapped into userspace as Normal, that defeats the
> > > purpose of getting Normal-NC, as well as resulting in
> > > mappings with differing cache attributes.
> > 
> > What is "Normal-NC"?
> 
> A non-cacheable attribute on arm64 pages. I think Mark R & Marc Z elaborated
> while I was asleep (thanks!).
>   .
> 
> 
> > 
> > > In particular this happens with libusb, when it attempts
> > > to create zero-copy buffers as is used by rtl-sdr, and
> > 
> > What is "rtl-sdr"
> 
> Its the realtek software defined radio (SDR), a really inexpensive TV dongle
> that was discovered could be used as a general purpose SDR a decade or so
> ago. In particular, this project
> https://github.com/osmocom/rtl-sdr/
> which is packaged by fedora/etc.
> 
> > 
> > > maybe other applications. The result is usually
> > > application death.
> > 
> > So is this a new problem?  Old problem?  Old problem only showing up on
> > future devices?  On current devices?  I need a hint here as to know if
> > this is a bugfix or just work to make future devices work properly.
> 
> This has been a problem on arm devices without IO coherent USB apparently
> for years. The rtl-sdr project itself has a disable zero-copy mode that
> people have been using on rpi/etc specific builds. Fedora OTOH, is building
> it with the same flags on x86 & arm64 which means that people report
> problems. This happened a few days ago (on a pinebook), and I duplicated it
> on an NXP platform just running the `rtl_test` artifact with a nooelec from
> my junk box. Guessing that it was a page mismatch I went looking for that,
> rather than disabling the zero copy since punishing arm machine that have IO
> coherent USB adapters for the sins of these low end devices isn't ideal. I
> found this, and this patch allows the rtl_test app to run without issues on
> my NXP/solidrun.
> 
> Plus, given that its actually a kernel/libusb problem its likely there are
> other applications having similar problems.
> 
> > 
> > > 
> > > If dma_mmap_attr() is used instead of remap_pfn_range,
> > > the page cache/etc attributes can be matched between the
> > > kernel and userspace.
> > > 
> > > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > ---
> > >   drivers/usb/core/devio.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > > index 6833c918abce..1e7458dd6e5d 100644
> > > --- a/drivers/usb/core/devio.c
> > > +++ b/drivers/usb/core/devio.c
> > > @@ -217,6 +217,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
> > >   {
> > >   	struct usb_memory *usbm = NULL;
> > >   	struct usb_dev_state *ps = file->private_data;
> > > +	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
> > >   	size_t size = vma->vm_end - vma->vm_start;
> > >   	void *mem;
> > >   	unsigned long flags;
> > > @@ -250,9 +251,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
> > >   	usbm->vma_use_count = 1;
> > >   	INIT_LIST_HEAD(&usbm->memlist);
> > > -	if (remap_pfn_range(vma, vma->vm_start,
> > > -			virt_to_phys(usbm->mem) >> PAGE_SHIFT,
> > > -			size, vma->vm_page_prot) < 0) {
> > > +	if (dma_mmap_attrs(hcd->self.sysdev, vma, mem, dma_handle, size, 0)) {
> > 
> > Given that this code has not changed since 2016, how has no one noticed
> > this issue before?
> They have there are a lot of reports of sdr failures, but the general use
> case is rare?
> 
> > 
> > And have you tested this change out on other systems (i.e. x86) to
> > ensure that this still works properly?
> 
> Yes and no, I did some basic libusb tests on an x86 machine, but its a bit
> tricky at the moment for me to get the rtl plugged into a x86 test machine.
> (its a work in progress).
> 
> 
> > 
> > And why isn't this call used more by drivers if this is a real issue?
> The particulars of asking for iocoherent memory and then mapping it to
> userspace is rarer than just asking for kmalloc()/remap() and then
> performing the dma ops?
> 
> Then there are all the softer issues around arm64 testing/availability and
> vendors carrying "fixes" for particular issues (like rtl-sdr disabling zero
> copy).
> 
> > And will this cause issues with how the userspace mapping is handled as
> > now we rely on userspace to do things differently?  Or am I reading the
> > dma_mmap_attrs() documentation wrong?
> I don't think userspace is doing anything differently here, and AFAIK, on
> systems with IO coherent adapters this ends up with the same page mapping as
> just doing the remap_pfn_rage() with the same attributes as before. I've
> looked at dma_map_attrs() a bit, but i'm also trusting it does what it says
> on the tin.
> 
> 
> Thanks again for looking at this.

Ok, can I get a lot better written changelog text for this patch based
on this thread, so that it makes more sense when we merge this patch?

thanks,

greg k-h
