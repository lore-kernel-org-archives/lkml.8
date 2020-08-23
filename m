Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07740C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5A82072D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyhsRiqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgHWLCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgHWLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 07:01:52 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 04:01:52 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id g1so1312869oop.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHZ1N3no/YKDtE7VbYW/o6/ON8hTW8hQsmS6YXwxFAs=;
        b=FyhsRiqCz5j6zP17qhB56lphX+JNbaiIKzGGsQnew0V/TiDT0ED5SysZ+Kol1CX2YQ
         en4eqFm3cqsH9n9EvrayewUV3tLeMrn8904nMZEUmN8qeBh4Ly30e6omVHiSPqtlmW8T
         cFt8jvdekDPYySzbXv3BNpoXo52lMzMo5eg6oj7cbGK0HRGD3LXUaWFI4/xlwbp2etbo
         akrfQrbo1/C6LHnjtYf1KvnHQZfKLj88kDKvJyWyB9roKfJ4jFB9Sm+xC9miCcwOJebo
         k1qeCZaN/rREVXq8pNlzl5obf0gnauGzaH0NQ7N2qTBziDodeQWjmOE6OaF/aqJ9PFQ7
         uIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHZ1N3no/YKDtE7VbYW/o6/ON8hTW8hQsmS6YXwxFAs=;
        b=QHjU0Yecsz9oyncfFIFej8wWcXa7p8qAv1Mhp9eogjLUdIj/b8EfY0HE38CSRzwFDT
         2PBE+bhEB0oM9g0/+VPGONqSvqV+oZQZ3ZV8QThVF0TBYEBhVBsSsi/gQX8qj4RFH5IV
         +Eb+pJng28Ord+zeD8vj/sdpGGgPREwnpQ6ohFybOiUldLhpi0ObzErzAwN95GpHmrRA
         C9V0b0Bk8dfiarMtQs08IqtKF5s+VG+AtxAkSjbWu2FxsZdylEdDzEHGDKjEwsDU2XYt
         iLuveAJUlTkywfKAw6KP9iEXIcPAdUYEl0G4mXYpJh8SAh1+3Srs3NraeYHmM7gKUfRP
         I19g==
X-Gm-Message-State: AOAM5312U7m8BX2m6xBWZyI2XM0DuW22TpAHyTgfc3rQ4N2aT65/kaBv
        joXWfLl4A/qTNkkpbfx2R6EiMe4TFSxqGYZgiANoUmeQKZQMpQ==
X-Google-Smtp-Source: ABdhPJyxEbm6HY9F92dujPs2r1EAht/nKpCccwhJ5n9SW2///XIUblWSzhvq6BcwybmumnTiWaQCvxK7vkHVkfllwas=
X-Received: by 2002:a4a:aa0e:: with SMTP id x14mr560354oom.27.1598180511048;
 Sun, 23 Aug 2020 04:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200817134752.11344-1-hdanton@sina.com> <CAFCwf13BGZC86iWdL4msO5=0TbUm=HVwgHsqfxCSJzVKr1FqpA@mail.gmail.com>
 <20200822233242.7840-1-hdanton@sina.com> <CAFCwf12yz+6tiNWSUxs05dTL-XG+ukAg823uQAAOoA-6uQMXWQ@mail.gmail.com>
 <20200823081913.6132-1-hdanton@sina.com>
In-Reply-To: <20200823081913.6132-1-hdanton@sina.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 23 Aug 2020 14:01:23 +0300
Message-ID: <CAFCwf126app346tE0pCotHoAPTufpUr0xMgkfu2OC2sjhPUuzA@mail.gmail.com>
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

On Sun, Aug 23, 2020 at 11:19 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Sun, 23 Aug 2020 10:01:59 +0300 Oded Gabbay wrote:
> >
> > One more small thing, can you please change the error message content
> > from "remap_pfn_range error" to "dma_mmap_coherent error" ?
>
> My fault.
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
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -2642,17 +2642,16 @@ int goya_resume(struct hl_device *hdev)
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
> -               dev_err(hdev->dev, "remap_pfn_range error %d", rc);
> +               dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
>
>         return rc;
>  }
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -3063,17 +3063,16 @@ static int gaudi_resume(struct hl_device
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
> -               dev_err(hdev->dev, "remap_pfn_range error %d", rc);
> +               dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
>
>         return rc;
>  }
> --
>

Hi Hillf,
I took your patch and ran a very basic test with it and unfortunately it breaks.
There are two bugs which I fixed:
1. Need to pass "&hdev->pdev->dev" instead of "hdev->dev" to
dma_mmap_coherent because we use the PCI dev, not our driver's device.
2. Need to pass "dma_addr - HOST_PHYS_BASE" instead of "dma_addr" to
dma_mmap_coherent because goya/gaudi alloc function adds
HOST_PHYS_BASE

But even after those fixes, I still get "-ENXIO" as a return value each time.
I added prints in the driver to make sure I called dma_mmap_coherent
with the exact same parameters as dma_alloc_coherent was called and I
saw they were the same.
e.g.
habanalabs hl0: alloc CB:
habanalabs hl0:   kernel address   == ffff9e6124691000
habanalabs hl0:   bus address    == 0xa24691000
habanalabs hl0:   size           == 0x1000
habanalabs hl0: mapping CB:
habanalabs hl0:   user address   == 0x7f674c4d9000
habanalabs hl0:   kernel address == ffff9e6124691000
habanalabs hl0:   bus address    == 0xa24691000
habanalabs hl0:   vm_flags       == 0x42644fb
habanalabs hl0:   size           == 0x1000
habanalabs hl0:   vm_page_prot   == 0x8000000000000027

Bottom line, I can't take this patch until we find what's wrong.
Oded
