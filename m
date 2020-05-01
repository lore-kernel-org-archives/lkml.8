Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDF5C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C03214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588316704;
	bh=+XNsx/y7wpr3wXy4+AywlP59DpP+Q7EqeGtvYes8QWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UfaXKTLC3lVRdnonpD7L8OgKvcwk+KGbIhUjc01Bs6XZj0eiJdQB8gGK3Kcyjwy1K
	 eS6fzf8yeApZjhEvVwJLIFQ2BISWyT90XF47uXVL1SQO2Tv5GARjCC3s6hfszYb/zm
	 KVfWPxg3PXJ706puiVqq5nybpc35gj6NjAnLuB+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgEAHFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAHFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:05:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3458D20787;
        Fri,  1 May 2020 07:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588316702;
        bh=+XNsx/y7wpr3wXy4+AywlP59DpP+Q7EqeGtvYes8QWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HQDrcctKw6flmvjHVvIBWYkP25DJeJXiS0x+RkzSggT6XtcSFNPt0PjIwM6NmBw/
         72L/lTCOQWWxEHvoGp22DQ8IKTCVHcygWsxqpJ27+br65wjoP68yqHNdzdTK1U9A9q
         M9FwRrSn1Fj5fEpdJakqcJP0gm2B+VZrgkXud5dk=
Date:   Fri, 1 May 2020 09:05:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        git@thegavinli.com, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: usbfs: correct kernel->user page attribute mismatch
Message-ID: <20200501070500.GA887524@kroah.com>
References: <20200430211922.929165-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211922.929165-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:19:22PM -0500, Jeremy Linton wrote:
> On arm64, and possibly other architectures, requesting
> IO coherent memory may return Normal-NC if the underlying
> hardware isn't coherent. If these pages are then
> remapped into userspace as Normal, that defeats the
> purpose of getting Normal-NC, as well as resulting in
> mappings with differing cache attributes.

What is "Normal-NC"?

> In particular this happens with libusb, when it attempts
> to create zero-copy buffers as is used by rtl-sdr, and

What is "rtl-sdr"

> maybe other applications. The result is usually
> application death.

So is this a new problem?  Old problem?  Old problem only showing up on
future devices?  On current devices?  I need a hint here as to know if
this is a bugfix or just work to make future devices work properly.

> 
> If dma_mmap_attr() is used instead of remap_pfn_range,
> the page cache/etc attributes can be matched between the
> kernel and userspace.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/usb/core/devio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index 6833c918abce..1e7458dd6e5d 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -217,6 +217,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct usb_memory *usbm = NULL;
>  	struct usb_dev_state *ps = file->private_data;
> +	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
>  	size_t size = vma->vm_end - vma->vm_start;
>  	void *mem;
>  	unsigned long flags;
> @@ -250,9 +251,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>  	usbm->vma_use_count = 1;
>  	INIT_LIST_HEAD(&usbm->memlist);
>  
> -	if (remap_pfn_range(vma, vma->vm_start,
> -			virt_to_phys(usbm->mem) >> PAGE_SHIFT,
> -			size, vma->vm_page_prot) < 0) {
> +	if (dma_mmap_attrs(hcd->self.sysdev, vma, mem, dma_handle, size, 0)) {

Given that this code has not changed since 2016, how has no one noticed
this issue before?

And have you tested this change out on other systems (i.e. x86) to
ensure that this still works properly?

And why isn't this call used more by drivers if this is a real issue?
And will this cause issues with how the userspace mapping is handled as
now we rely on userspace to do things differently?  Or am I reading the
dma_mmap_attrs() documentation wrong?

thanks,

greg k-h
