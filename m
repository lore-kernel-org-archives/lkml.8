Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150F52076C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrYz+BDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDYAoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgDYAoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 20:44:23 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388DEC09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:44:23 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e26so15796300otr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCDb553V1CVesXYGOyxZEELyTVgyKI2biYYtZJsGzDc=;
        b=SrYz+BDdqAUasXVvtSpM6ac2PifvJ9DVgKIK2dDxgbE8xBAB+6WlAMdgEwe+YykCKp
         r66x8qIE0yCi1bcK+v1jJZfTQqQkMvRQ8mHWnyXX2EddPjdEC1Mhmf3iqC71qrzoJqc8
         fhIRDU73xb5Jpb+5KpZK3HXyq/hkNyoxonRxbNORmc/AaTiGRO0aKSasoH2O1nlxWZL2
         1qZi1T/EsPHYrh86veE7LZ5GXJAFJUb1yuGrJn13j9uUFxt64QPOmBSkXg1PSzeiaX0i
         S3N4LRUofUQ1UEivzFIWqjfqgkbns7BVWIR8/djgl6xdskgaR2q2CHzaFmKdkHTG06x0
         4nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCDb553V1CVesXYGOyxZEELyTVgyKI2biYYtZJsGzDc=;
        b=hibeZsOEgYOQzl9E3BwBUkK4/HomgpbDCjt4XiWMapNwRrVEZ9DgvGofR95SvuKKjo
         m0SdmSr5vKRvr+WLMgu32GsRCoQZBXIhqUkTRqGEu4YU0qIQqvS7Pk2/hyYEwrsYG2jX
         Cm0YDlq/9DpTLFyPKSnr7LDL/+aUqPyWjVzh0pDkDoLprRBjB4I+8U+vb+JZZ7oYSzY9
         oANubkCaNQJMmt0zfuCI8U6O31P1KQ0Lj90ie/Z8MB6DA+dqY7HZbzBn5R0HqYehT8RZ
         u0q9plIPoeeL73uhR7EhWDZaFxSWcTHC9A9lwH7RgPn/yKBZdhREDu3FQKxWn+g9pbRc
         LCiQ==
X-Gm-Message-State: AGi0Pubr5DW5ekAJctJvtEeNsTZUwJHoR+BFR6vf8WT5HXt5X6S+DiIZ
        pNPRwq4eN1QP3lSyFM8j/DObrTizOlfF40ajuTM2Zg==
X-Google-Smtp-Source: APiQypKjehgA09VJZ5pHHDJvu+1vK/3lGElP+1ZSJh6fDhHer1J9wWO+OJn7x/bPb8K+t/5/XoksrDXfVdEfExvrDy0=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr9490064otc.221.1587775462417;
 Fri, 24 Apr 2020 17:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200424222740.16259-1-afd@ti.com>
In-Reply-To: <20200424222740.16259-1-afd@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 24 Apr 2020 17:44:10 -0700
Message-ID: <CALAqxLWcUkESyqVL1=Jzn_qOayohSvZe9008HGsSZ6+6AXaRXA@mail.gmail.com>
Subject: Re: [PATCH] misc: sram: Add dma-heap-export reserved SRAM area type
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 3:27 PM Andrew F. Davis <afd@ti.com> wrote:
> This new export type exposes to userspace the SRAM area as a DMA-Heap,
> this allows for allocations as DMA-BUFs that can be consumed by various
> DMA-BUF supporting devices.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Nice! Very excited to have the first new heap (that didn't come with
the initial patchset)!

Overall looks good! I don't have any comment on the SRAM side of
things, but a few minor questions/nits below.

> diff --git a/drivers/misc/sram-dma-heap.c b/drivers/misc/sram-dma-heap.c
> new file mode 100644
> index 000000000000..38df0397f294
> --- /dev/null
> +++ b/drivers/misc/sram-dma-heap.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SRAM DMA-Heap userspace exporter
> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + *     Andrew F. Davis <afd@ti.com>
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/genalloc.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +
> +#include "sram.h"
> +
> +struct sram_dma_heap {
> +       struct dma_heap *heap;
> +       struct gen_pool *pool;
> +};
> +
> +struct sram_dma_heap_buffer {
> +       struct gen_pool *pool;
> +       struct list_head attachments;
> +       struct mutex attachments_lock;
> +       unsigned long len;
> +       void *vaddr;
> +       phys_addr_t paddr;
> +};
> +
> +struct dma_heap_attachment {
> +       struct device *dev;
> +       struct sg_table *table;
> +       struct list_head list;
> +};
> +
> +static int dma_heap_attach(struct dma_buf *dmabuf,
> +                          struct dma_buf_attachment *attachment)
> +{
> +       struct sram_dma_heap_buffer *buffer = dmabuf->priv;
> +       struct dma_heap_attachment *a;
> +       struct sg_table *table;
> +
> +       a = kzalloc(sizeof(*a), GFP_KERNEL);
> +       if (!a)
> +               return -ENOMEM;
> +
> +       table = kmalloc(sizeof(*table), GFP_KERNEL);
> +       if (!table) {
> +               kfree(a);
> +               return -ENOMEM;
> +       }
> +       if (sg_alloc_table(table, 1, GFP_KERNEL)) {
> +               kfree(table);
> +               kfree(a);
> +               return -ENOMEM;
> +       }
> +       sg_set_page(table->sgl, pfn_to_page(PFN_DOWN(buffer->paddr)), buffer->len, 0);
> +
> +       a->table = table;
> +       a->dev = attachment->dev;
> +       INIT_LIST_HEAD(&a->list);
> +
> +       attachment->priv = a;
> +
> +       mutex_lock(&buffer->attachments_lock);
> +       list_add(&a->list, &buffer->attachments);
> +       mutex_unlock(&buffer->attachments_lock);
> +
> +       return 0;
> +}
> +
> +static void dma_heap_detatch(struct dma_buf *dmabuf,
> +                            struct dma_buf_attachment *attachment)
> +{
> +       struct sram_dma_heap_buffer *buffer = dmabuf->priv;
> +       struct dma_heap_attachment *a = attachment->priv;
> +
> +       mutex_lock(&buffer->attachments_lock);
> +       list_del(&a->list);
> +       mutex_unlock(&buffer->attachments_lock);
> +
> +       sg_free_table(a->table);
> +       kfree(a->table);
> +       kfree(a);
> +}
> +
> +static struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
> +                                            enum dma_data_direction direction)
> +{
> +       struct dma_heap_attachment *a = attachment->priv;
> +       struct sg_table *table = a->table;
> +
> +       if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> +                             direction, DMA_ATTR_SKIP_CPU_SYNC))

Might be nice to have a comment as to why you're using SKIP_CPU_SYNC
and why it's safe.

> +               return ERR_PTR(-ENOMEM);
> +
> +       return table;
> +}
> +
> +static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
> +                                  struct sg_table *table,
> +                                  enum dma_data_direction direction)
> +{
> +       dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
> +                          direction, DMA_ATTR_SKIP_CPU_SYNC);
> +}
> +
> +static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
> +{
> +       struct sram_dma_heap_buffer *buffer = dmabuf->priv;
> +
> +       gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
> +       kfree(buffer);
> +}
> +
> +static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +       struct sram_dma_heap_buffer *buffer = dmabuf->priv;
> +       int ret;
> +
> +       /* SRAM mappings are not cached */
> +       vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +
> +       ret = vm_iomap_memory(vma, buffer->paddr, buffer->len);
> +       if (ret)
> +               pr_err("Could not map buffer to userspace\n");
> +
> +       return ret;
> +}
> +
> +static void *dma_heap_vmap(struct dma_buf *dmabuf)
> +{
> +       struct sram_dma_heap_buffer *buffer = dmabuf->priv;
> +
> +       return buffer->vaddr;
> +}
> +
> +const struct dma_buf_ops sram_dma_heap_buf_ops = {
> +       .attach = dma_heap_attach,
> +       .detach = dma_heap_detatch,
> +       .map_dma_buf = dma_heap_map_dma_buf,
> +       .unmap_dma_buf = dma_heap_unmap_dma_buf,
> +       .release = dma_heap_dma_buf_release,
> +       .mmap = dma_heap_mmap,
> +       .vmap = dma_heap_vmap,
> +};

No begin/end_cpu_access functions here? I'm guessing it's because
you're always using SKIP_CPU_SYNC so it wouldn't do anything? A small
comment in the code might help.


> +
> +static int sram_dma_heap_allocate(struct dma_heap *heap,
> +                                 unsigned long len,
> +                                 unsigned long fd_flags,
> +                                 unsigned long heap_flags)
> +{
> +       struct sram_dma_heap *sram_dma_heap = dma_heap_get_drvdata(heap);
> +       struct sram_dma_heap_buffer *buffer;
> +
> +       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +       struct dma_buf *dmabuf;
> +       int ret;
> +
> +       buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +       if (!buffer)
> +               return -ENOMEM;
> +       buffer->pool = sram_dma_heap->pool;
> +       INIT_LIST_HEAD(&buffer->attachments);
> +       mutex_init(&buffer->attachments_lock);
> +       buffer->len = len;
> +
> +       buffer->vaddr = (void *)gen_pool_alloc(buffer->pool, buffer->len);
> +       if (!buffer->vaddr) {
> +               ret = -ENOMEM;
> +               goto free_buffer;
> +       }
> +
> +       buffer->paddr = gen_pool_virt_to_phys(buffer->pool, (unsigned long)buffer->vaddr);
> +       if (buffer->paddr == -1) {
> +               ret = -ENOMEM;
> +               goto free_pool;
> +       }
> +
> +       /* create the dmabuf */
> +       exp_info.ops = &sram_dma_heap_buf_ops;
> +       exp_info.size = buffer->len;
> +       exp_info.flags = fd_flags;
> +       exp_info.priv = buffer;
> +       dmabuf = dma_buf_export(&exp_info);
> +       if (IS_ERR(dmabuf)) {
> +               ret = PTR_ERR(dmabuf);
> +               goto free_pool;
> +       }
> +
> +       ret = dma_buf_fd(dmabuf, fd_flags);
> +       if (ret < 0) {
> +               dma_buf_put(dmabuf);
> +               /* just return, as put will call release and that will free */
> +               return ret;
> +       }
> +
> +       return ret;
> +
> +free_pool:
> +       gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
> +free_buffer:
> +       kfree(buffer);
> +
> +       return ret;
> +}
> +
> +static struct dma_heap_ops sram_dma_heap_ops = {
> +       .allocate = sram_dma_heap_allocate,
> +};
> +
> +int sram_dma_heap_export(struct sram_dev *sram,

This is totally a bikeshed thing (feel free to ignore), but maybe
sram_dma_heap_create()  or _add() would be a better name to avoid
folks mixing it up with the dmabuf exporter?

> +                        struct sram_reserve *block,
> +                        phys_addr_t start,
> +                        struct sram_partition *part)
> +{
> +       struct sram_dma_heap *sram_dma_heap;
> +       struct dma_heap_export_info exp_info;
> +
> +       dev_info(sram->dev, "Exporting SRAM pool '%s'\n", block->label);

Again, shed issue: but for terminology consistency (at least in the
dmabuf heaps space), maybe heap instead of pool?

Thanks so much again for submitting this!
-john
