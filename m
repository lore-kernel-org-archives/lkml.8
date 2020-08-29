Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D2FC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA5020757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okfGHajB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgH2Ooi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgH2Ooh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:44:37 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C479C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:44:37 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 109so1751989otv.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rhd9jlxRNij4iFunHLWly4AsH5UIyY9G8iXaY+PfByU=;
        b=okfGHajBAuGVLzYmkYyof16VRJzRZ7XssyJnO4RXdPC9TKSExS5bOL5kIpjOwC9LxB
         wK7veD/qAmd34oWztjoPVRskxI8BXdCsttAm+14s5mximq6v/IcNfiKCpd9z5rajgcgs
         23CBOaGMPruR0tZnWpq6tIdzSsuSqXWZwGkfqaEXavKI9+pYFuaVoqktm/FSi9ssBfs9
         Ig1VH4nlWobSSu4w8orbJyBENcN4DWdzKqvJK0J7bc6ZONY9y5hYbsf7YWvUS9V5rS72
         Ol+uCm63a+ENz1zEPBzPAU0kcDK5bMVGP838XiyHyZptTE/TvuJVQ0u+V8Phu3jEXQhK
         d3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rhd9jlxRNij4iFunHLWly4AsH5UIyY9G8iXaY+PfByU=;
        b=brhW2Npn0PMy4KEI7z6MLHbXh7zuFszEjOrQs7XIhx9zmTFC7CjlNYhk+N33Zy7NfG
         mFTWLXbyEVFhIDGW5CKEOFbRtJLLLFW8uXUplyWcBhHxdUEihznlnUde28jJqKRHR39u
         +bYDOBaN2g9AgZA4/AJ4ijWUxZi/9FCfX7SRtzfj7jlcrZjzR5+1axMGOwYCF7C7w3Fl
         55l+Dl0aa9lTEKjyh/a8fe+00SjrAZZ/SRAzrwuKTilwZ8hXvdw0zEjF8oLfnESlIbOF
         01qlNRQWMYCGl/3e/KB82ZGy6thJ4x9QJK8L3Cwo8qvuBQbSYYTiNVZf4S4vikxk3ZGr
         bqBQ==
X-Gm-Message-State: AOAM533kXErC6Re65TmRozyHakt2ihlNw/O53UNPrOT5wFpjmVpP2m2F
        lA303zv759wNQJoBp+4plpaJMIpu5h/kTKRba3I=
X-Google-Smtp-Source: ABdhPJxvyY3rcAOHOrt5vqfw1x0M0CvB4xwZ5cKaRBS5XsRoC6nzr3cv42dGh5FYNwtz4JLUY7hf5ioPxsTIu7BnBSA=
X-Received: by 2002:a05:6830:160e:: with SMTP id g14mr2399915otr.339.1598712276413;
 Sat, 29 Aug 2020 07:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200817134752.11344-1-hdanton@sina.com> <CAFCwf13BGZC86iWdL4msO5=0TbUm=HVwgHsqfxCSJzVKr1FqpA@mail.gmail.com>
 <20200822233242.7840-1-hdanton@sina.com> <CAFCwf12yz+6tiNWSUxs05dTL-XG+ukAg823uQAAOoA-6uQMXWQ@mail.gmail.com>
 <20200823081913.6132-1-hdanton@sina.com> <CAFCwf126app346tE0pCotHoAPTufpUr0xMgkfu2OC2sjhPUuzA@mail.gmail.com>
 <20200825010509.10660-1-hdanton@sina.com>
In-Reply-To: <20200825010509.10660-1-hdanton@sina.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 29 Aug 2020 17:44:08 +0300
Message-ID: <CAFCwf11+4TE+avgFLNHmYFtv3Q_63TLTyCpuTyx-5cKiC8=-Bg@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 4:05 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Mon, Aug 24, 2020 at 09:29 Hillf Danton wrote:
> > On Sun, 23 Aug 2020 14:01:23 +0300 Oded Gabbay wrote:
> > > On Sun, Aug 23, 2020 at 11:19 AM Hillf Danton <hdanton@sina.com> wrote:
> > > > On Sun, 23 Aug 2020 10:01:59 +0300 Oded Gabbay wrote:
> > > > >
> > > > > One more small thing, can you please change the error message content
> > > > > from "remap_pfn_range error" to "dma_mmap_coherent error" ?
> > > >
> > > > My fault.
> > > >
> > > > ---8<---
> > > > From: Hillf Danton <hdanton@sina.com>
> > > > Subject: [PATCH] habanalabs: make use of dma_mmap_coherent
> > > >
> > > > Add dma_mmap_coherent() for goya and gaudi to match their use of
> > > > dma_alloc_coherent(), see the Link tag for why.
> > > >
> > > > Link: https://lore.kernel.org/lkml/20200609091727.GA23814@lst.de/
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Zhang Li <li.zhang@bitmain.com>
> > > > Cc: Ding Z Nan <oshack@hotmail.com>
> > > > Signed-off-by: Hillf Danton <hdanton@sina.com>
> > > > ---
> > > >
> > > > --- a/drivers/misc/habanalabs/common/habanalabs.h
> > > > +++ b/drivers/misc/habanalabs/common/habanalabs.h
> > > > @@ -679,7 +679,7 @@ struct hl_asic_funcs {
> > > >         int (*suspend)(struct hl_device *hdev);
> > > >         int (*resume)(struct hl_device *hdev);
> > > >         int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
> > > > -                       u64 kaddress, phys_addr_t paddress, u32 size);
> > > > +                       void *cpu_addr, dma_addr_t dma_addr, size_t size);
> > > >         void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
> > > >         void (*pqe_write)(struct hl_device *hdev, __le64 *pqe,
> > > >                         struct hl_bd *bd);
> > > > --- a/drivers/misc/habanalabs/common/command_buffer.c
> > > > +++ b/drivers/misc/habanalabs/common/command_buffer.c
> > > > @@ -299,7 +299,6 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, s
> > > >  {
> > > >         struct hl_device *hdev = hpriv->hdev;
> > > >         struct hl_cb *cb;
> > > > -       phys_addr_t address;
> > > >         u32 handle;
> > > >         int rc;
> > > >
> > > > @@ -344,12 +343,8 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, s
> > > >
> > > >         vma->vm_private_data = cb;
> > > >
> > > > -       /* Calculate address for CB */
> > > > -       address = virt_to_phys((void *) (uintptr_t) cb->kernel_address);
> > > > -
> > > > -       rc = hdev->asic_funcs->cb_mmap(hdev, vma, cb->kernel_address,
> > > > -                                       address, cb->size);
> > > > -
> > > > +       rc = hdev->asic_funcs->cb_mmap(hdev, vma, (void *) cb->kernel_address,
> > > > +                                       cb->bus_address, cb->size);
> > > >         if (rc) {
> > > >                 spin_lock(&cb->lock);
> > > >                 cb->mmap = false;
> > > > --- a/drivers/misc/habanalabs/goya/goya.c
> > > > +++ b/drivers/misc/habanalabs/goya/goya.c
> > > > @@ -2642,17 +2642,16 @@ int goya_resume(struct hl_device *hdev)
> > > >  }
> > > >
> > > >  static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> > > > -               u64 kaddress, phys_addr_t paddress, u32 size)
> > > > +                       void *cpu_addr, dma_addr_t dma_addr, size_t size)
> > > >  {
> > > >         int rc;
> > > >
> > > >         vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
> > > >                         VM_DONTCOPY | VM_NORESERVE;
> > > >
> > > > -       rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
> > > > -                               size, vma->vm_page_prot);
> > > > +       rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
> > > >         if (rc)
> > > > -               dev_err(hdev->dev, "remap_pfn_range error %d", rc);
> > > > +               dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
> > > >
> > > >         return rc;
> > > >  }
> > > > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > > > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > > > @@ -3063,17 +3063,16 @@ static int gaudi_resume(struct hl_device
> > > >  }
> > > >
> > > >  static int gaudi_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> > > > -               u64 kaddress, phys_addr_t paddress, u32 size)
> > > > +                       void *cpu_addr, dma_addr_t dma_addr, size_t size)
> > > >  {
> > > >         int rc;
> > > >
> > > >         vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
> > > >                         VM_DONTCOPY | VM_NORESERVE;
> > > >
> > > > -       rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
> > > > -                               size, vma->vm_page_prot);
> > > > +       rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
> > > >         if (rc)
> > > > -               dev_err(hdev->dev, "remap_pfn_range error %d", rc);
> > > > +               dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
> > > >
> > > >         return rc;
> > > >  }
> > > > --
> > > >
> > >
> > > Hi Hillf,
> > > I took your patch and ran a very basic test with it and unfortunately it breaks.
> > > There are two bugs which I fixed:
> >
> > Thanks for your fix.
> >
> > > 1. Need to pass "&hdev->pdev->dev" instead of "hdev->dev" to
> > > dma_mmap_coherent because we use the PCI dev, not our driver's device.
> > > 2. Need to pass "dma_addr - HOST_PHYS_BASE" instead of "dma_addr" to
> > > dma_mmap_coherent because goya/gaudi alloc function adds
> > > HOST_PHYS_BASE
> > >
> > > But even after those fixes, I still get "-ENXIO" as a return value each time.
> > > I added prints in the driver to make sure I called dma_mmap_coherent
> > > with the exact same parameters as dma_alloc_coherent was called and I
> > > saw they were the same.
> > > e.g.
> > > habanalabs hl0: alloc CB:
> > > habanalabs hl0:   kernel address   == ffff9e6124691000
> > > habanalabs hl0:   bus address    == 0xa24691000
> > > habanalabs hl0:   size           == 0x1000
> > > habanalabs hl0: mapping CB:
> > > habanalabs hl0:   user address   == 0x7f674c4d9000
> > > habanalabs hl0:   kernel address == ffff9e6124691000
> > > habanalabs hl0:   bus address    == 0xa24691000
> > > habanalabs hl0:   vm_flags       == 0x42644fb
> > > habanalabs hl0:   size           == 0x1000
> > > habanalabs hl0:   vm_page_prot   == 0x8000000000000027
> >
> > 1) it's a small mapping as the above size shows.
> >
> > 2) there is a boundary check in dma_direct_mmap(),
> >
> >       if (vma->vm_pgoff >= count || user_count > count - vma->vm_pgoff)
> >               return -ENXIO;
> >
> > and I'm wondering if we didn't go across it, e.g vm_pgoff isn't zero.
>
> 3) the grep output seems to have something to say.
>
> _>grep -n idr_ linux/drivers/misc/habanalabs/common/command_buffer.c
> 168:    rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
> 215:    cb = idr_find(&mgr->cb_handles, handle);
> 217:            idr_remove(&mgr->cb_handles, handle);
> 376:    cb = idr_find(&mgr->cb_handles, handle);
> 401:    idr_init(&mgr->cb_handles);
> 412:    idr_for_each_entry(idp, cb, id) {
> 419:    idr_destroy(&mgr->cb_handles);
>
> First, the key managed by idr is never zero as the alloc method feeds
> back keys that are bigger than one.
>
> Second, no mmap callback, which is the target of this patch, will be
> invoked for a command buffer that cann't be successfully found in idr
> with vma->vm_pgoff used as the key in hl_cb_mmap().
>
>         handle = vma->vm_pgoff;
>
>         /* reference was taken here */
>         cb = hl_cb_get(hdev, &hpriv->cb_mgr, handle);
>         if (!cb) {
>                 dev_err(hdev->dev,
>                         "CB mmap failed, no match to handle 0x%x\n", handle);
>                 return -EINVAL;
>         }
>
> IOW vm_pgoff is reused by habana as idr key.
>
> Finally, the helper in the dma core is trying to fix the reuse and
> got your tests broken.
> >
> > Hillf
> > >
> > > Bottom line, I can't take this patch until we find what's wrong.
> > > Oded
>

Hi Hillf,
Thanks for the detailed analysis.
With your findings, I was able to make your patch work by clearing the
vm_pgoff after extracting from it the idr handle.
It also gave me the chance to do some nice refactoring of the mmap
function in the driver.
So I'll add your patch after my two patches which do the refactoring +
clearing the handle.

Thanks so much for your time and contribution :)


Oded
