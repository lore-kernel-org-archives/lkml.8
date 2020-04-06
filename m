Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659EEC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376F020842
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXlJz6CK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDFV54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:57:56 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37046 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgDFV54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:57:56 -0400
Received: by mail-pj1-f66.google.com with SMTP id k3so490454pjj.2;
        Mon, 06 Apr 2020 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3T1BmTedGTg22l9N35z2hanUfUnh2WE1VEXbstx4f0=;
        b=PXlJz6CKxt6Yy8ROjQFBhyjxbMe6bh7NMXPY4nWawuJcDJG8RbGZVuG6qIEA9fZEhs
         64VMLFwFI/3YpytBN6yckjM8NhrC9vVJWv5ol4wWPyBLewG72qR8yflaVYPqEOX/6wnA
         igO8NTNssL6JBsrb/MAEzCUa+N83WtvnNafASMLbmSy7Jg6ADPgg6LeNRTYxVxjOsnMI
         n+C8j3dEAY89bbJIViZZ/9shibEf2zIUnHLUW1AtM/Kau3nJM5u/kCWTqBNL3fgmNv98
         QYiU2dRvTxF+mDaQeugDgW8xKLWpX0mNOsJlUwun8yqsuIdwvDVmmBZ7Zm6Ah/72pvrB
         RFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3T1BmTedGTg22l9N35z2hanUfUnh2WE1VEXbstx4f0=;
        b=o2Iguiu5x7H6cMmxIyqUKMkHbKjsVU5lx2l3TF93mkGCr7jyKOP5CYv3BY+rrhCDYV
         xLHmWOrBtmxVz+kNR6bTStie7Bm16g09kEEfoLrHS5K98am34DAfyLc3+tdewByh1XPj
         e+V9HeTLnNWECCaVWy1b+Ux82uZ1eiHR7USZIP7HYg+7h6fCd9cyxEU/zSAz7FGDKpi+
         WCSJXJpGKESfLnwrL4pAQKf6lZYVYv/exQuICb/sfEj5eYlowLnQviy/bXSpNws0whaK
         /Wdhbpcbiwn85XmdTKQ6l4hnYfDZdD0G+0JSn4xmFkJGfochPuD0zx8MbPm+SrEejXpX
         d2Ww==
X-Gm-Message-State: AGi0PuYA/czYC8hrHuFmywOO7ATZ7ON5YwnUY8pg0B0RwPDTHnGFcT73
        j9al4Yt7TdIdavN9+ufd+DWwX2duL9ISsaxVJGM=
X-Google-Smtp-Source: APiQypIISZ1VPqKmpDBm5uYF7y9Ms05db/tPvLwJwqeuhEivHg/eJdW4tRUfLfwFDCKJx9DS+C2RJCMC3HLNayUhaiQ=
X-Received: by 2002:a17:90a:8546:: with SMTP id a6mr1526909pjw.8.1586210274806;
 Mon, 06 Apr 2020 14:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200406213314.248038-1-mst@redhat.com> <20200406213314.248038-13-mst@redhat.com>
In-Reply-To: <20200406213314.248038-13-mst@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Apr 2020 00:57:43 +0300
Message-ID: <CAHp75Ve46P=TYk0pzHFsYXjkKX92K2=NO5Krqy2uo_7HG=DWCA@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] mellanox: switch to virtio_legacy_init/size
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:35 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> These are used for legacy ring format, switch to APIs that make this
> explicit.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> maintainers, pls ack merging this through virtio tree due to dependency
> on previous patches in the patchset.

Here you are!

>
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index 5739a9669b29..f42b1fb713f1 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -214,7 +214,7 @@ static void mlxbf_tmfifo_free_vrings(struct mlxbf_tmfifo *fifo,
>         for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
>                 vring = &tm_vdev->vrings[i];
>                 if (vring->va) {
> -                       size = vring_size(vring->num, vring->align);
> +                       size = vring_legacy_size(vring->num, vring->align);
>                         dma_free_coherent(tm_vdev->vdev.dev.parent, size,
>                                           vring->va, vring->dma);
>                         vring->va = NULL;
> @@ -245,7 +245,7 @@ static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
>                 vring->vdev_id = tm_vdev->vdev.id.device;
>                 dev = &tm_vdev->vdev.dev;
>
> -               size = vring_size(vring->num, vring->align);
> +               size = vring_legacy_size(vring->num, vring->align);
>                 va = dma_alloc_coherent(dev->parent, size, &dma, GFP_KERNEL);
>                 if (!va) {
>                         mlxbf_tmfifo_free_vrings(fifo, tm_vdev);
> @@ -935,7 +935,7 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
>                 vring = &tm_vdev->vrings[i];
>
>                 /* zero vring */
> -               size = vring_size(vring->num, vring->align);
> +               size = vring_legacy_size(vring->num, vring->align);
>                 memset(vring->va, 0, size);
>                 vq = vring_new_virtqueue(i, vring->num, vring->align, vdev,
>                                          false, false, vring->va,
> --
> MST
>


-- 
With Best Regards,
Andy Shevchenko
