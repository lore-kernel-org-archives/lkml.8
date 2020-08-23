Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A794C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 07:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB10C2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 07:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvACUgal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHWHCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 03:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgHWHC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 03:02:29 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07850C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 00:02:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l84so5450189oig.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 00:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E25u1RZ35/8UovGtjIgDLnGJo1E95eU4X7jPGyQa9FU=;
        b=lvACUgalycGxGivoroXz/mNrSv7Ofz0paPtCvb4RXndTDjIBy2bCyHU8FWIGQYzxOg
         4tsps256SrnDHgLBm3YukAaiNFvH3UFL3pjxz7A+oJXV9JvnP8OdDWPsU8R5a5HweHyw
         ag0Gshk3HHZBRW9V2K/8Gha34eW5E7Y4uUfB2MjJ4qNbCuM1Bx3OZDLSIhh2NiYI3QNs
         djsU39FGAHxyoyLHzK2uQ00YJHLXmPsEHOE6NIQOOAjIamanfi7+eJedkpaAu9w0BhCR
         tfm+oReMeD8Qb5jnaWj9Au8x1JVkC5aOc14HAb8oH13Q/WLzEpT3nDhI5IW+GmjKF+zX
         fi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E25u1RZ35/8UovGtjIgDLnGJo1E95eU4X7jPGyQa9FU=;
        b=UpHIx/hue2JX2dcP0GKODlEjMtkT08OAG+AyqCT7pCEtJ6VaXD+uOpM6UOOfXcRE/k
         IpPLl+aKEySxjrzBhJ4CvkD+b6PqIg37OilLvbHqqCKwU6l6ToJnqM7wAiCM5t1o37S1
         ssSLaMKlPHgD9EsIUBcB3KejPMwLSGodSE0t+z1DLvE2tAEzB2i4WargK1Jev0MdqlZd
         hZuxTRoJkNCYrmg4egjkDyyqfxRxVbSequyQZEkkyErAsEf340BAlXMnKnHGBPw2C2zi
         Cl9h4Cmp55MK68TUija0XqNpUpWMFRJbf73KLg8gh7Cr02UfVFpxn4wmZTiUL/pBrcoa
         iBZQ==
X-Gm-Message-State: AOAM532HYVV8n75XZBuZZWeGIDQ79p58r0w8RzBw4Y4jsOuz1xgyH10C
        oElXzzfcaqgGUaZ4Koeo1ISsXPAObqYMY6tQUBs=
X-Google-Smtp-Source: ABdhPJxQ1E/uGTFYkWpstxd/q0CY+ZcJoo6ElilYCbrCUAwq903fZKQi58FLqpgPhGcR9vrC1y4lHplC1ouzvmD5/Ao=
X-Received: by 2002:aca:5bc6:: with SMTP id p189mr155602oib.130.1598166147132;
 Sun, 23 Aug 2020 00:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200817134752.11344-1-hdanton@sina.com> <CAFCwf13BGZC86iWdL4msO5=0TbUm=HVwgHsqfxCSJzVKr1FqpA@mail.gmail.com>
 <20200822233242.7840-1-hdanton@sina.com>
In-Reply-To: <20200822233242.7840-1-hdanton@sina.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 23 Aug 2020 10:01:59 +0300
Message-ID: <CAFCwf12yz+6tiNWSUxs05dTL-XG+ukAg823uQAAOoA-6uQMXWQ@mail.gmail.com>
Subject: Re: [RFC PATCH] habanalabs: goya: make use of dma_mmap_coherent
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>,
        Zhang Li <li.zhang@bitmain.com>,
        Ding Z Nan <oshack@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 2:32 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Sat, 22 Aug 2020 19:10:07 +0300 Oded Gabbay wrote:
> > On Mon, Aug 17, 2020 at 4:48 PM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > >
> > > Add dma_mmap_coherent() to match dma_alloc_coherent(), see the Link tag
> > > for why.
> > >
> > > Link: https://lore.kernel.org/lkml/20200609091727.GA23814@lst.de/
> > > Signed-off-by: Hillf Danton <hdanton@sina.com>
> > > ---
> > >
> > > --- a/drivers/misc/habanalabs/common/habanalabs.h
> > > +++ b/drivers/misc/habanalabs/common/habanalabs.h
> > > @@ -679,7 +679,7 @@ struct hl_asic_funcs {
> > >         int (*suspend)(struct hl_device *hdev);
> > >         int (*resume)(struct hl_device *hdev);
> > >         int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
> > > -                       u64 kaddress, phys_addr_t paddress, u32 size);
> > > +                       void *cpu_addr, dma_addr_t dma_addr, size_t size);
> > >         void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
> > >         void (*pqe_write)(struct hl_device *hdev, __le64 *pqe,
> > >                         struct hl_bd *bd);
> > > --- a/drivers/misc/habanalabs/goya/goya.c
> > > +++ b/drivers/misc/habanalabs/goya/goya.c
> > > @@ -2642,15 +2642,14 @@ int goya_resume(struct hl_device *hdev)
> > >  }
> > >
> > >  static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> > > -               u64 kaddress, phys_addr_t paddress, u32 size)
> > > +                       void *cpu_addr, dma_addr_t dma_addr, size_t size)
> > >  {
> > >         int rc;
> > >
> > >         vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
> > >                         VM_DONTCOPY | VM_NORESERVE;
> > >
> > > -       rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
> > > -                               size, vma->vm_page_prot);
> > > +       rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
> > >         if (rc)
> > >                 dev_err(hdev->dev, "remap_pfn_range error %d", rc);
> > >
> > > --- a/drivers/misc/habanalabs/common/command_buffer.c
> > > +++ b/drivers/misc/habanalabs/common/command_buffer.c
> > > @@ -299,7 +299,6 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, s
> > >  {
> > >         struct hl_device *hdev = hpriv->hdev;
> > >         struct hl_cb *cb;
> > > -       phys_addr_t address;
> > >         u32 handle;
> > >         int rc;
> > >
> > > @@ -344,12 +343,8 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, s
> > >
> > >         vma->vm_private_data = cb;
> > >
> > > -       /* Calculate address for CB */
> > > -       address = virt_to_phys((void *) (uintptr_t) cb->kernel_address);
> > > -
> > > -       rc = hdev->asic_funcs->cb_mmap(hdev, vma, cb->kernel_address,
> > > -                                       address, cb->size);
> > > -
> > > +       rc = hdev->asic_funcs->cb_mmap(hdev, vma, (void *) cb->kernel_address,
> > > +                                       cb->bus_address, cb->size);
> > >         if (rc) {
> > >                 spin_lock(&cb->lock);
> > >                 cb->mmap = false;
> > >
> >
> > Hi Hillf,
> > Could you please also fix gaudi_cb_mmap() and resend this patch ?
>
> ---8<---
> From: Hillf Danton <hdanton@sina.com>
> Subject: [PATCH] habanalabs: make use of dma_mmap_coherent
>
> Add dma_mmap_coherent() for goya and gaudi to match their use of
> dma_alloc_coherent(), see the Link tag for why.
>
> Link: https://lore.kernel.org/lkml/20200609091727.GA23814@lst.de/
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Zhang Li <li.zhang@bitmain.com>
> Cc: Ding Z Nan <oshack@hotmail.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
>
> --- a/drivers/misc/habanalabs/common/habanalabs.h
> +++ b/drivers/misc/habanalabs/common/habanalabs.h
> @@ -679,7 +679,7 @@ struct hl_asic_funcs {
>         int (*suspend)(struct hl_device *hdev);
>         int (*resume)(struct hl_device *hdev);
>         int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
> -                       u64 kaddress, phys_addr_t paddress, u32 size);
> +                       void *cpu_addr, dma_addr_t dma_addr, size_t size);
>         void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
>         void (*pqe_write)(struct hl_device *hdev, __le64 *pqe,
>                         struct hl_bd *bd);
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -2642,15 +2642,14 @@ int goya_resume(struct hl_device *hdev)
>  }
>
>  static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> -               u64 kaddress, phys_addr_t paddress, u32 size)
> +                       void *cpu_addr, dma_addr_t dma_addr, size_t size)
>  {
>         int rc;
>
>         vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
>                         VM_DONTCOPY | VM_NORESERVE;
>
> -       rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
> -                               size, vma->vm_page_prot);
> +       rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
>         if (rc)
>                 dev_err(hdev->dev, "remap_pfn_range error %d", rc);
>
> --- a/drivers/misc/habanalabs/common/command_buffer.c
> +++ b/drivers/misc/habanalabs/common/command_buffer.c
> @@ -299,7 +299,6 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, s
>  {
>         struct hl_device *hdev = hpriv->hdev;
>         struct hl_cb *cb;
> -       phys_addr_t address;
>         u32 handle;
>         int rc;
>
> @@ -344,12 +343,8 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, s
>
>         vma->vm_private_data = cb;
>
> -       /* Calculate address for CB */
> -       address = virt_to_phys((void *) (uintptr_t) cb->kernel_address);
> -
> -       rc = hdev->asic_funcs->cb_mmap(hdev, vma, cb->kernel_address,
> -                                       address, cb->size);
> -
> +       rc = hdev->asic_funcs->cb_mmap(hdev, vma, (void *) cb->kernel_address,
> +                                       cb->bus_address, cb->size);
>         if (rc) {
>                 spin_lock(&cb->lock);
>                 cb->mmap = false;
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -3063,15 +3063,14 @@ static int gaudi_resume(struct hl_device
>  }
>
>  static int gaudi_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> -               u64 kaddress, phys_addr_t paddress, u32 size)
> +                       void *cpu_addr, dma_addr_t dma_addr, size_t size)
>  {
>         int rc;
>
>         vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
>                         VM_DONTCOPY | VM_NORESERVE;
>
> -       rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
> -                               size, vma->vm_page_prot);
> +       rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
>         if (rc)
>                 dev_err(hdev->dev, "remap_pfn_range error %d", rc);
>
> --
>

Thanks!
One more small thing, can you please change the error message content
from "remap_pfn_range error" to "dma_mmap_coherent error" ?
Oded
