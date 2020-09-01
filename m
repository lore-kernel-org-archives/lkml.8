Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEFC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4CD2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599002229;
	bh=dEzwxEuUgfYnGt8tTDL/A1NPb+fEcrJH6io3xPpZIAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hGvNhsIjqSbtQoye+1zDOeF8c55gyGnMRtPjt1rD0rC1CZxKYJWvdaWBnNWsdd/WZ
	 +2zICOkqIAoBPmt06GInDAhaLSqtwP8Ch4IF5fP3g8bJBygLGSfCjlNx5ip9yjZGHX
	 CrUcQT7rX5DPISpYdhVD8Rsg8WPbF1gW/9oEbLfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIAXRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIAXRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:17:08 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E92202071B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599002227;
        bh=dEzwxEuUgfYnGt8tTDL/A1NPb+fEcrJH6io3xPpZIAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZYj8rqV3HROpw6CDvgMVd5hZg5rBDjH4RSJIo5SPOM7Ja7YqDakNre623J7KNMdv9
         zpEb0CzMeczKHCD4/DAAOODJN5n6te/K7xaUjswZj03FpVUJmbOxdsGfuH5owN08yV
         Y8JxqXzezZAiQVMZxYJlE3EINQVxw7bVxJS2ykFo=
Received: by mail-ej1-f50.google.com with SMTP id a15so1346138ejf.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 16:17:06 -0700 (PDT)
X-Gm-Message-State: AOAM530Azf3SPnzgFoNk7oLNiIP1uabZU3cGLNrE+8+YaTN5ZYlGJI7/
        CXVbwm3bKM1cpTq6Fx6z+1Lhn8KmD4qKXoiGYQ==
X-Google-Smtp-Source: ABdhPJxjGeMplEAO/cPVthJXCGCEi6FG3fNO07cenYqDxG9mxyLxAmv8N/2WWybtiLb8XagSSQ/Sw0SUTCoZ0nSCAFg=
X-Received: by 2002:a17:906:119b:: with SMTP id n27mr3661770eja.124.1599002225526;
 Tue, 01 Sep 2020 16:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063534eucas1p2647f5e9679f79f568e184b092f743f8b@eucas1p2.samsung.com>
 <20200826063316.23486-12-m.szyprowski@samsung.com> <30f20ad6-783b-89c3-17b5-30c6a2587d23@arm.com>
In-Reply-To: <30f20ad6-783b-89c3-17b5-30c6a2587d23@arm.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 2 Sep 2020 07:16:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9BaFZbiGFYjat4vJ-_kEONXxfgcTRPd6aKoeKJ7xxBww@mail.gmail.com>
Message-ID: <CAAOTY_9BaFZbiGFYjat4vJ-_kEONXxfgcTRPd6aKoeKJ7xxBww@mail.gmail.com>
Subject: Re: [PATCH v9 11/32] drm: mediatek: use common helper for extracting
 pages array
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Murphy <robin.murphy@arm.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=882=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 2020-08-26 07:32, Marek Szyprowski wrote:
> > Use common helper for converting a sg_table object into struct
> > page pointer array.
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> Side note: is mtk_drm_gem_prime_vmap() missing a call to
> sg_free_table(sgt) before its kfree(sgt)?

Yes, we need another patch to fix that bug, But for this patch,

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_drm_gem.c | 9 ++-------
> >   1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_gem.c
> > index 3654ec732029..0583e557ad37 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > @@ -233,9 +233,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object =
*obj)
> >   {
> >       struct mtk_drm_gem_obj *mtk_gem =3D to_mtk_gem_obj(obj);
> >       struct sg_table *sgt;
> > -     struct sg_page_iter iter;
> >       unsigned int npages;
> > -     unsigned int i =3D 0;
> >
> >       if (mtk_gem->kvaddr)
> >               return mtk_gem->kvaddr;
> > @@ -249,11 +247,8 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object=
 *obj)
> >       if (!mtk_gem->pages)
> >               goto out;
> >
> > -     for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
> > -             mtk_gem->pages[i++] =3D sg_page_iter_page(&iter);
> > -             if (i > npages)
> > -                     break;
> > -     }
> > +     drm_prime_sg_to_page_addr_arrays(sgt, mtk_gem->pages, NULL, npage=
s);
> > +
> >       mtk_gem->kvaddr =3D vmap(mtk_gem->pages, npages, VM_MAP,
> >                              pgprot_writecombine(PAGE_KERNEL));
> >
> >
