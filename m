Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A541C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A75206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599001175;
	bh=6+prf8hd/dD/hqUCmuKJ8TIy6p+8/B1mAtJifqlir+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j9aCF+mvOoFMRoRuTc2Ks8Nm/hlxiPZ8+iFGoNzuwSfQ7Ge50cnLXntEd+Nbiyjbr
	 TejzFZR6L9DlzOm2L1gz5tgnmq3DWZM3LSTSr9DxLEbyC35LlJ9akGbTiMFZXQ0uzj
	 E+Ul7YehftuHTO+AXg2p6OD7k2yoDlJAE8f7Dipo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgIAW7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgIAW72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:59:28 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC50207EA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 22:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599001167;
        bh=6+prf8hd/dD/hqUCmuKJ8TIy6p+8/B1mAtJifqlir+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w3AXvs40WAjhXqbXqQI1GI9Yf7hMmKxb/eEPBdI1ctXxmiKOG5KwrJHt7sbbu9Re4
         4sgXHSx9tWBEQYbqv9Pjkq506kssAi0Zcp7Cv+il7ZTLRd/z6hHjzlDnpX/M0hpjIY
         EmThNZ/vhzh/HMmvip5IgkrHvzr7gvSKWbKBXIAc=
Received: by mail-ej1-f42.google.com with SMTP id d11so3916240ejt.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:59:26 -0700 (PDT)
X-Gm-Message-State: AOAM533q6l/yqgpVaOXEOFM5viND9qgodbmQ0cNuzzImoSNzoDOfCZno
        j94Ki0DvY//cZfZL1wCDcYna6Sn/pgYuUoHkvA==
X-Google-Smtp-Source: ABdhPJzjHDOXSGz7glhl+6OiZP2SWKZjyjWU9LL5WqhptcI1ntuiSPhKiGIOKRXMhN7HiiRtHc6HA76qv/dWjb/Q6CM=
X-Received: by 2002:a17:906:7492:: with SMTP id e18mr3598885ejl.375.1599001165547;
 Tue, 01 Sep 2020 15:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200826063533eucas1p1fad2f2afb117b026081468d2d840ab0f@eucas1p1.samsung.com>
 <20200826063316.23486-1-m.szyprowski@samsung.com> <20200826063316.23486-11-m.szyprowski@samsung.com>
In-Reply-To: <20200826063316.23486-11-m.szyprowski@samsung.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 2 Sep 2020 06:59:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9=GFMW2QQKjxWHeZLYTDo3+=j=wZ62t9LrSkfD79ji9A@mail.gmail.com>
Message-ID: <CAAOTY_9=GFMW2QQKjxWHeZLYTDo3+=j=wZ62t9LrSkfD79ji9A@mail.gmail.com>
Subject: Re: [PATCH v9 10/32] drm: mediatek: use common helper for a
 scatterlist contiguity check
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
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

Hi, Marek:

Marek Szyprowski <m.szyprowski@samsung.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8826=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:35=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Use common helper for checking the contiguity of the imported dma-buf and
> do this check before allocating resources, so the error path is simpler.
>

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 28 ++++++--------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/med=
iatek/mtk_drm_gem.c
> index 6190cc3b7b0d..3654ec732029 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -212,37 +212,21 @@ struct drm_gem_object *mtk_gem_prime_import_sg_tabl=
e(struct drm_device *dev,
>                         struct dma_buf_attachment *attach, struct sg_tabl=
e *sg)
>  {
>         struct mtk_drm_gem_obj *mtk_gem;
> -       int ret;
> -       struct scatterlist *s;
> -       unsigned int i;
> -       dma_addr_t expected;
>
> -       mtk_gem =3D mtk_drm_gem_init(dev, attach->dmabuf->size);
> +       /* check if the entries in the sg_table are contiguous */
> +       if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
> +               DRM_ERROR("sg_table is not contiguous");
> +               return ERR_PTR(-EINVAL);
> +       }
>
> +       mtk_gem =3D mtk_drm_gem_init(dev, attach->dmabuf->size);
>         if (IS_ERR(mtk_gem))
>                 return ERR_CAST(mtk_gem);
>
> -       expected =3D sg_dma_address(sg->sgl);
> -       for_each_sg(sg->sgl, s, sg->nents, i) {
> -               if (!sg_dma_len(s))
> -                       break;
> -
> -               if (sg_dma_address(s) !=3D expected) {
> -                       DRM_ERROR("sg_table is not contiguous");
> -                       ret =3D -EINVAL;
> -                       goto err_gem_free;
> -               }
> -               expected =3D sg_dma_address(s) + sg_dma_len(s);
> -       }
> -
>         mtk_gem->dma_addr =3D sg_dma_address(sg->sgl);
>         mtk_gem->sg =3D sg;
>
>         return &mtk_gem->base;
> -
> -err_gem_free:
> -       kfree(mtk_gem);
> -       return ERR_PTR(ret);
>  }
>
>  void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
> --
> 2.17.1
>
