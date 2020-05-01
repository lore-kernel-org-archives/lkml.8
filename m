Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2DCC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CBF02166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Eqiu8lMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgEAXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:25:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F59C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 16:25:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so2771486qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=guhZjIp2vp9oWNh7lZ5HHleHHphMv+m2NLPBb/u4l7A=;
        b=Eqiu8lMdmS6+P2ZcNK/e+Iaahx/uCQh3CHQUBTD5de0+pu+zKljMVFlYn5tnGMwcxu
         Eb08nuXGGFnYK57ZUhNZFuNsravXsuy6oYoAxKPEKXIQeeWOK6oGA08iqdiGQSsD6zFD
         /auzUyqEBjyDOL+vmwQXNX/F7V7Glw0Mp0ZIxgbqPJ3G1s+TxbXpUL/XBURNlYeWwv40
         z8ueSbSXeJiB71QBWSXsUBD7LhtDwWrGEr0kU3zKeOdhpd/REIp/PbgI4NE7JscezHHI
         eyxdrTHLFNyqmOcbMF7+VxNuoapO3M5cfjhuwDuRQyyVUt3ciUJ+sU0HCgnlNsRz5h5D
         yZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=guhZjIp2vp9oWNh7lZ5HHleHHphMv+m2NLPBb/u4l7A=;
        b=ZojVZ0Z6EpHs4r4nxtkx0tnsYj3x9jX5pFNoC40UFJ2zDy8YvndyfBrh2LTgiX4mjK
         y1AffOrjBx4YdEnM1Ghez1r8OQDxCSGMcWLlHWwdpIkoCnfeDnkxaj6VCH8Ejb6kK9iM
         trdQzRIAT1u2/xDFsx8obptzfLjSDzfFLbGc65TvLq2rnJXWUk/MiLPYhuAtVs9ISoft
         vkg/TP2ffD4bCuEZ0qu9IofkEDE++HISVck3gjeIaigzD8jJRNGZFN365JvQSMVnPJWG
         zc5j7p+XQR6R97Cfeg9djtOK/Gy+80ZBBcqiYPkD7bPYcIFGX8e2h4hdNLckyxUm2AQS
         8/3w==
X-Gm-Message-State: AGi0Pubn3XxpHlXeRQOUbAWadpBaB2P5t0HuXT0adBNnJStMKrRlCzt+
        d674/MHyRrB5SVe0y1uweiyrRQ==
X-Google-Smtp-Source: APiQypI+2s0GZe3nxVD+0xsoQavQU/+FtrL1RYlWy2FTgfZZDO7vLFkTpbrLJOP3YZ7bE2nQIHcgXA==
X-Received: by 2002:ae9:e606:: with SMTP id z6mr5968250qkf.320.1588375551884;
        Fri, 01 May 2020 16:25:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b126sm3768601qkc.119.2020.05.01.16.25.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 16:25:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jUf2U-0005Rh-Ld; Fri, 01 May 2020 20:25:50 -0300
Date:   Fri, 1 May 2020 20:25:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, peterx@redhat.com
Subject: Re: [PATCH 2/3] vfio-pci: Fault mmaps to enable vma tracking
Message-ID: <20200501232550.GP26002@ziepe.ca>
References: <158836742096.8433.685478071796941103.stgit@gimli.home>
 <158836915917.8433.8017639758883869710.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158836915917.8433.8017639758883869710.stgit@gimli.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 03:39:19PM -0600, Alex Williamson wrote:
> Rather than calling remap_pfn_range() when a region is mmap'd, setup
> a vm_ops handler to support dynamic faulting of the range on access.
> This allows us to manage a list of vmas actively mapping the area that
> we can later use to invalidate those mappings.  The open callback
> invalidates the vma range so that all tracking is inserted in the
> fault handler and removed in the close handler.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         |   76 ++++++++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_private.h |    7 +++
>  2 files changed, 81 insertions(+), 2 deletions(-)

> +static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct vfio_pci_device *vdev = vma->vm_private_data;
> +
> +	if (vfio_pci_add_vma(vdev, vma))
> +		return VM_FAULT_OOM;
> +
> +	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +			    vma->vm_end - vma->vm_start, vma->vm_page_prot))
> +		return VM_FAULT_SIGBUS;
> +
> +	return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vfio_pci_mmap_ops = {
> +	.open = vfio_pci_mmap_open,
> +	.close = vfio_pci_mmap_close,
> +	.fault = vfio_pci_mmap_fault,
> +};
> +
>  static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  {
>  	struct vfio_pci_device *vdev = device_data;
> @@ -1357,8 +1421,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
>  
> -	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> -			       req_len, vma->vm_page_prot);
> +	/*
> +	 * See remap_pfn_range(), called from vfio_pci_fault() but we can't
> +	 * change vm_flags within the fault handler.  Set them now.
> +	 */
> +	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> +	vma->vm_ops = &vfio_pci_mmap_ops;

Perhaps do the vfio_pci_add_vma & remap_pfn_range combo here if the
BAR is activated ? That way a fully populated BAR is presented in the
common case and avoids taking a fault path?

But it does seem OK as is

Jason
