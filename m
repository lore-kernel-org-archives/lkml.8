Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25747C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00737207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDcWgigW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgERB10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgERB1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:27:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E280C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:27:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g14so21212660wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZfH/yW2EkwOl9gEcet4jN7ZXi9BLKHqqQrfr1sC6ac=;
        b=vDcWgigWf+8ZKsquN2u4JqfQ8umHJX5fe46rUTGhJECREweESiSfWnUn0R+kFnVYzL
         Po+JjR2lydKpGPNuAuKUfwyrCt05L9FE2SiboNT/Di3jcIyohybAZ7DEy0Rfme5FXmov
         hLdWtACwrYRBlLG0QN8oUbUrydmDczxFu2izF8ScEASNprtdB5wc/pnUdJmba6hRwV9n
         aHCMGNU+KjzWjQTSpCRhc4bWnVvgd0rJg1YDnGNoSnyOoDtovxLu56C1biuKkr+dRjvW
         tJZ3MvsoObtcyH+Pvwi+VeXvwxYehRqFZ5a/TM/TAH2YVIfFH9U6+mtgTNk5l3SnaaaD
         oGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZfH/yW2EkwOl9gEcet4jN7ZXi9BLKHqqQrfr1sC6ac=;
        b=IfHtw0nAmxkPO1GiDOLzCvJo2aaV//Vk7MSqQdRyoCxAwz+bwcBMTRmsPMbvIJJfGg
         BioOF2obPmprcvbQ+WV+K2d0WOtp29ilt7I+5gId6imI8OxcKvFd/a22Usiis5py27DJ
         BHiux9X9wcvXetyJGlSuX1pMYaRazi/ir2tcB9IMbH/4RS/IQgMgLf92Vd3RFCrR03l6
         mBDcwyVaFAZB6GvwRqB8JylSpuPBXopipJfnlQqT531ZYsKPJrRilYAst8jLwdnfCf6f
         +gFiIsMcEx7r1B+xeDUnvqsDmI4SVcD2UxHB4aZO163GwZ/zGwAEZeOjocV2XkwsTMcp
         8PLA==
X-Gm-Message-State: AOAM5306Kq3sfdMnoGR42CCg3OqjakJbA3QAg3UjrWMne9UhOlhZqU7O
        2uLdzfHsfMkDTHkQ3wcTDI+SKh89/R9P8yMvkh8o7EBBvWM=
X-Google-Smtp-Source: ABdhPJwYXjut1W+agJe7qHIAazerG/VY4Qh5rG0NKf6TSwEA+kmhHmC2ZVellCufA3F7oGA23ea+FfJqOJUfr5uzS0A=
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr17035637wmm.67.1589765242888;
 Sun, 17 May 2020 18:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <CGME20200513133305eucas1p15187ed8fa1e4af181cafa5c65ddab4cd@eucas1p1.samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com> <20200513133245.6408-13-m.szyprowski@samsung.com>
In-Reply-To: <20200513133245.6408-13-m.szyprowski@samsung.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 18 May 2020 09:27:11 +0800
Message-ID: <CAKGbVbsSPhQY5zEBGPQtyhLu38w=Hw73OQr6UiV_dHC46DescQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/38] drm: lima: fix common struct sg_table related issues
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Wed, May 13, 2020 at 9:33 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
>
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
>
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
>
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
> ---
>  drivers/gpu/drm/lima/lima_gem.c | 11 ++++++++---
>  drivers/gpu/drm/lima/lima_vm.c  |  5 ++---
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
> index 5404e0d..cda43f6 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -69,8 +69,7 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
>                 return ret;
>
>         if (bo->base.sgt) {
> -               dma_unmap_sg(dev, bo->base.sgt->sgl,
> -                            bo->base.sgt->nents, DMA_BIDIRECTIONAL);
> +               dma_unmap_sgtable(dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
>                 sg_free_table(bo->base.sgt);
>         } else {
>                 bo->base.sgt = kmalloc(sizeof(*bo->base.sgt), GFP_KERNEL);
> @@ -80,7 +79,13 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
>                 }
>         }
>
> -       dma_map_sg(dev, sgt.sgl, sgt.nents, DMA_BIDIRECTIONAL);
> +       ret = dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
> +       if (ret) {
> +               sg_free_table(&sgt);
> +               kfree(bo->base.sgt);
> +               bo->base.sgt = NULL;
> +               return ret;
> +       }
>
>         *bo->base.sgt = sgt;
>
> diff --git a/drivers/gpu/drm/lima/lima_vm.c b/drivers/gpu/drm/lima/lima_vm.c
> index 5b92fb8..2b2739a 100644
> --- a/drivers/gpu/drm/lima/lima_vm.c
> +++ b/drivers/gpu/drm/lima/lima_vm.c
> @@ -124,7 +124,7 @@ int lima_vm_bo_add(struct lima_vm *vm, struct lima_bo *bo, bool create)
>         if (err)
>                 goto err_out1;
>
> -       for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter, bo->base.sgt->nents, 0) {
> +       for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, 0) {
>                 err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
>                                        bo_va->node.start + offset);
>                 if (err)
> @@ -298,8 +298,7 @@ int lima_vm_map_bo(struct lima_vm *vm, struct lima_bo *bo, int pageoff)
>         mutex_lock(&vm->lock);
>
>         base = bo_va->node.start + (pageoff << PAGE_SHIFT);
> -       for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter,
> -                            bo->base.sgt->nents, pageoff) {
> +       for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, pageoff) {
>                 err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
>                                        base + offset);
>                 if (err)
> --
> 1.9.1
>
