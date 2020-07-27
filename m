Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D16AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E01020714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+vB9jT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbgG0SOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgG0SOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:14:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055FFC061794;
        Mon, 27 Jul 2020 11:14:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so15701014wml.3;
        Mon, 27 Jul 2020 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oweP9/5P4IwfXq7FRGFpzMEQgr6J1hZ6crzxPuNCiqY=;
        b=e+vB9jT04h1RqsV7Fy7tiIT+AHPMYl/g2rFgZntMj6RpzHGLDjLAI8bOB/FL+yBNX/
         9qn331OfOwaU3a8WYOhf3CAAJYYXHhs4KMXgtBWnexxEufuchYEnVKcDBSXzVUispykn
         PR40AH4VCMOWPdvJgpX6acxF7DBqNP8KyP2q4AIPqMVFUtDLmsCl6VmFgcNrsvst1eG9
         klrjBAOThyjIG0dioA2ojFxTUJn17xbtsqRdZ6z0B6yZtinAFVZ395Hi2lInjq360Fl9
         UtHO5WaCd+wmaxPB5DTQj2gwpModMlRNzeqY5m7liEbD/D9B33L3Io0obgG6UCAB3VY/
         xNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oweP9/5P4IwfXq7FRGFpzMEQgr6J1hZ6crzxPuNCiqY=;
        b=I89mTvMkn97s6PKfwIBjBwWhnLQAzbWy7fGu9gkQDklSvTknhBmf8P1qJUatpkEHP/
         Jb2/VmxybEbrsivbV/xv7bGTJi8326zXsIqILyzussSnsZG1OmsmR14CO8cAM2YHm6RP
         uNTHgJvDsqurZ4fz4yslEtpfhKjWyWlBelBXK/G9OVl4Tto7oN3H6TkuR6LRBoCvjQcx
         be+ZeVjAxYMoM4kofstRiYlYhPtk0xgUabmFUmaZIlm6zCOSSvm1p0zWPpkqzshqyV4a
         ZyDB0LHnsNYdEq1wrR0R34sUlVj2qJBVsaAVOXgIdxp5mM+pxW2zxffBQxWi+h7iDgLi
         QzmQ==
X-Gm-Message-State: AOAM532KS4IJPCr8NJ60Jk/pvznJbeeQLmxncKp0RpKFoe1vpvKzin5U
        weHRO7hntHnAiB4BvH6Psq6Puf3eDx2QtaD/fmA=
X-Google-Smtp-Source: ABdhPJwDf3NQVRSMOOvQ3/gDp3spLrysuALfIbGNUz8NSRkrcu7vnDQpr1MxHquSAobzWw/p7CVeHkm3ribJUJCaGHA=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr429279wml.73.1595873658666;
 Mon, 27 Jul 2020 11:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200727103421.50739-1-christophe.jaillet@wanadoo.fr> <224fc7f6-f56b-1dc8-87f2-33ff85d5720d@gmail.com>
In-Reply-To: <224fc7f6-f56b-1dc8-87f2-33ff85d5720d@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Jul 2020 14:14:07 -0400
Message-ID: <CADnq5_MKR9SC947WCN6Qp4BLhrK03=FtT7hD7b+DwNQ46krmkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/radeon: switch from 'pci_' to 'dma_' API
To:     Christian Koenig <christian.koenig@amd.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel-janitors@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jul 27, 2020 at 9:42 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 27.07.20 um 12:34 schrieb Christophe JAILLET:
> > The wrappers in include/linux/pci-dma-compat.h should go away.
> >
> > The patch has been generated with the coccinelle script below and has b=
een
> > hand modified to replace GFP_ with a correct flag.
> > It has been compile tested.
> >
> > When memory is allocated in 'radeon_gart_table_ram_alloc()' GFP_KERNEL
> > can be used because its callers already use this flag.
> >
> > Both 'r100_pci_gart_init()' (r100.c) and 'rs400_gart_init()' (rs400.c)
> > call 'radeon_gart_init()'.
> > This function uses 'vmalloc'.
> >
> >
> > @@
> > @@
> > -    PCI_DMA_BIDIRECTIONAL
> > +    DMA_BIDIRECTIONAL
> >
> > @@
> > @@
> > -    PCI_DMA_TODEVICE
> > +    DMA_TO_DEVICE
> >
> > @@
> > @@
> > -    PCI_DMA_FROMDEVICE
> > +    DMA_FROM_DEVICE
> >
> > @@
> > @@
> > -    PCI_DMA_NONE
> > +    DMA_NONE
> >
> > @@
> > expression e1, e2, e3;
> > @@
> > -    pci_alloc_consistent(e1, e2, e3)
> > +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
> >
> > @@
> > expression e1, e2, e3;
> > @@
> > -    pci_zalloc_consistent(e1, e2, e3)
> > +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_free_consistent(e1, e2, e3, e4)
> > +    dma_free_coherent(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_map_single(e1, e2, e3, e4)
> > +    dma_map_single(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_unmap_single(e1, e2, e3, e4)
> > +    dma_unmap_single(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4, e5;
> > @@
> > -    pci_map_page(e1, e2, e3, e4, e5)
> > +    dma_map_page(&e1->dev, e2, e3, e4, e5)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_unmap_page(e1, e2, e3, e4)
> > +    dma_unmap_page(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_map_sg(e1, e2, e3, e4)
> > +    dma_map_sg(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_unmap_sg(e1, e2, e3, e4)
> > +    dma_unmap_sg(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
> > +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
> > +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
> > +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
> > +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2;
> > @@
> > -    pci_dma_mapping_error(e1, e2)
> > +    dma_mapping_error(&e1->dev, e2)
> >
> > @@
> > expression e1, e2;
> > @@
> > -    pci_set_dma_mask(e1, e2)
> > +    dma_set_mask(&e1->dev, e2)
> >
> > @@
> > expression e1, e2;
> > @@
> > -    pci_set_consistent_dma_mask(e1, e2)
> > +    dma_set_coherent_mask(&e1->dev, e2)
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > If needed, see post from Christoph Hellwig on the kernel-janitors ML:
> >     https://marc.info/?l=3Dkernel-janitors&m=3D158745678307186&w=3D4
> > ---
> >   drivers/gpu/drm/radeon/radeon_gart.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/rad=
eon/radeon_gart.c
> > index f178ba321715..b7ce254e5663 100644
> > --- a/drivers/gpu/drm/radeon/radeon_gart.c
> > +++ b/drivers/gpu/drm/radeon/radeon_gart.c
> > @@ -72,8 +72,8 @@ int radeon_gart_table_ram_alloc(struct radeon_device =
*rdev)
> >   {
> >       void *ptr;
> >
> > -     ptr =3D pci_alloc_consistent(rdev->pdev, rdev->gart.table_size,
> > -                                &rdev->gart.table_addr);
> > +     ptr =3D dma_alloc_coherent(&rdev->pdev->dev, rdev->gart.table_siz=
e,
> > +                              &rdev->gart.table_addr, GFP_KERNEL);
> >       if (ptr =3D=3D NULL) {
> >               return -ENOMEM;
> >       }
> > @@ -110,9 +110,8 @@ void radeon_gart_table_ram_free(struct radeon_devic=
e *rdev)
> >                             rdev->gart.table_size >> PAGE_SHIFT);
> >       }
> >   #endif
> > -     pci_free_consistent(rdev->pdev, rdev->gart.table_size,
> > -                         (void *)rdev->gart.ptr,
> > -                         rdev->gart.table_addr);
> > +     dma_free_coherent(&rdev->pdev->dev, rdev->gart.table_size,
> > +                       (void *)rdev->gart.ptr, rdev->gart.table_addr);
> >       rdev->gart.ptr =3D NULL;
> >       rdev->gart.table_addr =3D 0;
> >   }
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
