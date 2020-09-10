Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56000C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6DC20756
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4LNL210"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgIJJrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgIJJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:47:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1381C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:47:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l63so5612336edl.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=metNjPQom55ViMWgpPGBJCdJNxCYtLQyRMirgizcUQ4=;
        b=d4LNL210XpsysHiTtXd0WD1jHzXGVBZsS0SBhg9iEWJm+0C4ToIV+h8CLvtZz+RndI
         zuF02MQNQ9tbuVaOTokIflaZKbHFDncWR9E2Fivhjbre5qIvGI0pwO+LtNuZhrFlz7c4
         uw8NxIzZu/MhFiCKgsoKT0pAPzehasvAWeh+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=metNjPQom55ViMWgpPGBJCdJNxCYtLQyRMirgizcUQ4=;
        b=Jehn2SBmWg7gT/cShyHsoHwjVPOz56WUTyFXJ5Dnuxf4Dw8z4MS057L6yJqbGX8AoQ
         pTRf4DOnJfQ5TyuUwPwIR7P5YhoeVVMU1eT9SSJZHCacOis1D8WfENm+eumPM9M4HvAu
         mKQeoGA9Blrj1Cu98Ekke3E/tL1ceWdRkq2Hkyiz2B/ITPWk6Re5tXlmmLfNbB6XEjRK
         kyD/AkcQjyWPeDSdMmP9WFe1pnPArPAeiJPWs3PjvgWdBJZYXotUaxO0FvRfQhb9FDXZ
         84ZaFu7xYPuuP+i9aKSEYODfWwE59hKRNCIem32C0YlwmnhYWYlOUOfpCIDWFxgt8HiX
         nOOA==
X-Gm-Message-State: AOAM531Bev7EHfj+ShTa9CGZa6QXwruZClw+Bt+8ccqAmpn+LiY672Lo
        MRNtTdb3W+R5fU3naOAO/FnK/AG02tPVRA==
X-Google-Smtp-Source: ABdhPJyzUVKxQxE/zNkxD08YgwRxVIaGbgfOx6CLyg2ZIOWjTgg4iEA7RBzga4LcAJ5/ebPeDROszQ==
X-Received: by 2002:aa7:c1c3:: with SMTP id d3mr8555130edp.228.1599731261163;
        Thu, 10 Sep 2020 02:47:41 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a15sm6172147ejy.118.2020.09.10.02.47.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 02:47:40 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id x14so5933041wrl.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:47:39 -0700 (PDT)
X-Received: by 2002:adf:f042:: with SMTP id t2mr7710610wro.385.1599731259384;
 Thu, 10 Sep 2020 02:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133512eucas1p204efa4e252ceb5fb50715239705f9965@eucas1p2.samsung.com>
 <20200904131711.12950-31-m.szyprowski@samsung.com> <e1070a0d-2772-b5e2-7067-9f53ade19aae@xs4all.nl>
In-Reply-To: <e1070a0d-2772-b5e2-7067-9f53ade19aae@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 10 Sep 2020 11:47:09 +0200
X-Gmail-Original-Message-ID: <CAAFQd5BhwPNaYR1nZims9VBEB+564=fw5o7Za91EvHngs7YcOw@mail.gmail.com>
Message-ID: <CAAFQd5BhwPNaYR1nZims9VBEB+564=fw5o7Za91EvHngs7YcOw@mail.gmail.com>
Subject: Re: [PATCH v10 30/30] videobuf2: use sgtable-based scatterlist wrappers
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linaro-mm-sig@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:17 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 04/09/2020 15:17, Marek Szyprowski wrote:
> > Use recently introduced common wrappers operating directly on the struct
> > sg_table objects and scatterlist page iterators to make the code a bit
> > more compact, robust, easier to follow and copy/paste safe.
> >
> > No functional change, because the code already properly did all the
> > scatterlist related calls.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>
> Note that I agree with Marek to keep returning -EIO. If we want to propagate
> low-level errors, then that should be done in a separate patch. But I think EIO
> is fine.

As I mentioned, there are 2 different cases here - UAPI and kAPI. I
agree that we should keep -EIO for UAPI, but kAPI is another story.
But if we're convinced that -EIO is also fine for the latter, I'm fine
with that.

Best regards,
Tomasz

>
> Regards,
>
>         Hans
>
> > ---
> >  .../common/videobuf2/videobuf2-dma-contig.c   | 34 ++++++++-----------
> >  .../media/common/videobuf2/videobuf2-dma-sg.c | 32 +++++++----------
> >  .../common/videobuf2/videobuf2-vmalloc.c      | 12 +++----
> >  3 files changed, 31 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > index ec3446cc45b8..1b242d844dde 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > @@ -58,10 +58,10 @@ static unsigned long vb2_dc_get_contiguous_size(struct sg_table *sgt)
> >       unsigned int i;
> >       unsigned long size = 0;
> >
> > -     for_each_sg(sgt->sgl, s, sgt->nents, i) {
> > +     for_each_sgtable_dma_sg(sgt, s, i) {
> >               if (sg_dma_address(s) != expected)
> >                       break;
> > -             expected = sg_dma_address(s) + sg_dma_len(s);
> > +             expected += sg_dma_len(s);
> >               size += sg_dma_len(s);
> >       }
> >       return size;
> > @@ -103,8 +103,7 @@ static void vb2_dc_prepare(void *buf_priv)
> >       if (!sgt)
> >               return;
> >
> > -     dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
> > -                            buf->dma_dir);
> > +     dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
> >  }
> >
> >  static void vb2_dc_finish(void *buf_priv)
> > @@ -115,7 +114,7 @@ static void vb2_dc_finish(void *buf_priv)
> >       if (!sgt)
> >               return;
> >
> > -     dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
> > +     dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
> >  }
> >
> >  /*********************************************/
> > @@ -275,8 +274,8 @@ static void vb2_dc_dmabuf_ops_detach(struct dma_buf *dbuf,
> >                * memory locations do not require any explicit cache
> >                * maintenance prior or after being used by the device.
> >                */
> > -             dma_unmap_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                                attach->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +             dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir,
> > +                               DMA_ATTR_SKIP_CPU_SYNC);
> >       sg_free_table(sgt);
> >       kfree(attach);
> >       db_attach->priv = NULL;
> > @@ -301,8 +300,8 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
> >
> >       /* release any previous cache */
> >       if (attach->dma_dir != DMA_NONE) {
> > -             dma_unmap_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                                attach->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +             dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir,
> > +                               DMA_ATTR_SKIP_CPU_SYNC);
> >               attach->dma_dir = DMA_NONE;
> >       }
> >
> > @@ -310,9 +309,8 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
> >        * mapping to the client with new direction, no cache sync
> >        * required see comment in vb2_dc_dmabuf_ops_detach()
> >        */
> > -     sgt->nents = dma_map_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                                   dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > -     if (!sgt->nents) {
> > +     if (dma_map_sgtable(db_attach->dev, sgt, dma_dir,
> > +                         DMA_ATTR_SKIP_CPU_SYNC)) {
> >               pr_err("failed to map scatterlist\n");
> >               mutex_unlock(lock);
> >               return ERR_PTR(-EIO);
> > @@ -455,8 +453,8 @@ static void vb2_dc_put_userptr(void *buf_priv)
> >                * No need to sync to CPU, it's already synced to the CPU
> >                * since the finish() memop will have been called before this.
> >                */
> > -             dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
> > -                                buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +             dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir,
> > +                               DMA_ATTR_SKIP_CPU_SYNC);
> >               pages = frame_vector_pages(buf->vec);
> >               /* sgt should exist only if vector contains pages... */
> >               BUG_ON(IS_ERR(pages));
> > @@ -553,9 +551,8 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
> >        * No need to sync to the device, this will happen later when the
> >        * prepare() memop is called.
> >        */
> > -     sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
> > -                                   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > -     if (sgt->nents <= 0) {
> > +     if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
> > +                         DMA_ATTR_SKIP_CPU_SYNC)) {
> >               pr_err("failed to map scatterlist\n");
> >               ret = -EIO;
> >               goto fail_sgt_init;
> > @@ -577,8 +574,7 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
> >       return buf;
> >
> >  fail_map_sg:
> > -     dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
> > -                        buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +     dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> >
> >  fail_sgt_init:
> >       sg_free_table(sgt);
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> > index 0a40e00f0d7e..0dd3b19025e0 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> > @@ -148,9 +148,8 @@ static void *vb2_dma_sg_alloc(struct device *dev, unsigned long dma_attrs,
> >        * No need to sync to the device, this will happen later when the
> >        * prepare() memop is called.
> >        */
> > -     sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
> > -                                   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > -     if (!sgt->nents)
> > +     if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
> > +                         DMA_ATTR_SKIP_CPU_SYNC))
> >               goto fail_map;
> >
> >       buf->handler.refcount = &buf->refcount;
> > @@ -186,8 +185,8 @@ static void vb2_dma_sg_put(void *buf_priv)
> >       if (refcount_dec_and_test(&buf->refcount)) {
> >               dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
> >                       buf->num_pages);
> > -             dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
> > -                                buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +             dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir,
> > +                               DMA_ATTR_SKIP_CPU_SYNC);
> >               if (buf->vaddr)
> >                       vm_unmap_ram(buf->vaddr, buf->num_pages);
> >               sg_free_table(buf->dma_sgt);
> > @@ -204,8 +203,7 @@ static void vb2_dma_sg_prepare(void *buf_priv)
> >       struct vb2_dma_sg_buf *buf = buf_priv;
> >       struct sg_table *sgt = buf->dma_sgt;
> >
> > -     dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
> > -                            buf->dma_dir);
> > +     dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
> >  }
> >
> >  static void vb2_dma_sg_finish(void *buf_priv)
> > @@ -213,7 +211,7 @@ static void vb2_dma_sg_finish(void *buf_priv)
> >       struct vb2_dma_sg_buf *buf = buf_priv;
> >       struct sg_table *sgt = buf->dma_sgt;
> >
> > -     dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
> > +     dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
> >  }
> >
> >  static void *vb2_dma_sg_get_userptr(struct device *dev, unsigned long vaddr,
> > @@ -256,9 +254,8 @@ static void *vb2_dma_sg_get_userptr(struct device *dev, unsigned long vaddr,
> >        * No need to sync to the device, this will happen later when the
> >        * prepare() memop is called.
> >        */
> > -     sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
> > -                                   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > -     if (!sgt->nents)
> > +     if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
> > +                         DMA_ATTR_SKIP_CPU_SYNC))
> >               goto userptr_fail_map;
> >
> >       return buf;
> > @@ -284,8 +281,7 @@ static void vb2_dma_sg_put_userptr(void *buf_priv)
> >
> >       dprintk(1, "%s: Releasing userspace buffer of %d pages\n",
> >              __func__, buf->num_pages);
> > -     dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir,
> > -                        DMA_ATTR_SKIP_CPU_SYNC);
> > +     dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> >       if (buf->vaddr)
> >               vm_unmap_ram(buf->vaddr, buf->num_pages);
> >       sg_free_table(buf->dma_sgt);
> > @@ -408,8 +404,7 @@ static void vb2_dma_sg_dmabuf_ops_detach(struct dma_buf *dbuf,
> >
> >       /* release the scatterlist cache */
> >       if (attach->dma_dir != DMA_NONE)
> > -             dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                     attach->dma_dir);
> > +             dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir, 0);
> >       sg_free_table(sgt);
> >       kfree(attach);
> >       db_attach->priv = NULL;
> > @@ -434,15 +429,12 @@ static struct sg_table *vb2_dma_sg_dmabuf_ops_map(
> >
> >       /* release any previous cache */
> >       if (attach->dma_dir != DMA_NONE) {
> > -             dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                     attach->dma_dir);
> > +             dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir, 0);
> >               attach->dma_dir = DMA_NONE;
> >       }
> >
> >       /* mapping to the client with new direction */
> > -     sgt->nents = dma_map_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                             dma_dir);
> > -     if (!sgt->nents) {
> > +     if (dma_map_sgtable(db_attach->dev, sgt, dma_dir, 0)) {
> >               pr_err("failed to map scatterlist\n");
> >               mutex_unlock(lock);
> >               return ERR_PTR(-EIO);
> > diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> > index c66fda4a65e4..bf5ac63a5742 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> > @@ -229,7 +229,7 @@ static int vb2_vmalloc_dmabuf_ops_attach(struct dma_buf *dbuf,
> >               kfree(attach);
> >               return ret;
> >       }
> > -     for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> > +     for_each_sgtable_sg(sgt, sg, i) {
> >               struct page *page = vmalloc_to_page(vaddr);
> >
> >               if (!page) {
> > @@ -259,8 +259,7 @@ static void vb2_vmalloc_dmabuf_ops_detach(struct dma_buf *dbuf,
> >
> >       /* release the scatterlist cache */
> >       if (attach->dma_dir != DMA_NONE)
> > -             dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                     attach->dma_dir);
> > +             dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir, 0);
> >       sg_free_table(sgt);
> >       kfree(attach);
> >       db_attach->priv = NULL;
> > @@ -285,15 +284,12 @@ static struct sg_table *vb2_vmalloc_dmabuf_ops_map(
> >
> >       /* release any previous cache */
> >       if (attach->dma_dir != DMA_NONE) {
> > -             dma_unmap_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                     attach->dma_dir);
> > +             dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir, 0);
> >               attach->dma_dir = DMA_NONE;
> >       }
> >
> >       /* mapping to the client with new direction */
> > -     sgt->nents = dma_map_sg(db_attach->dev, sgt->sgl, sgt->orig_nents,
> > -                             dma_dir);
> > -     if (!sgt->nents) {
> > +     if (dma_map_sgtable(db_attach->dev, sgt, dma_dir, 0)) {
> >               pr_err("failed to map scatterlist\n");
> >               mutex_unlock(lock);
> >               return ERR_PTR(-EIO);
> >
>
