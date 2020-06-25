Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78416207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH/jGypy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389959AbgFYFZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389779AbgFYFZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:25:17 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDCBC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:25:16 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id y13so2139147ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1M8fJ0FCnOMntV70VPwyXOwsOWPRieVnDXWWBkV3kw=;
        b=bH/jGypyE1zLUM2BzGbRZ+mL9qES7p2JsAFtpu5w5rE08w0/89Pnb6xPSN2garomn6
         R0Gt+tpJgOSkD9T74ZhQGnWBjgfS9q8iiEP7/CfpsFBEa5Uc3Fol4pVXEv4JR1qp6HPu
         xvvl4RRZ61cUGBHq46nfQdGfPyc7cxX5Q7GnMqv0+ods4OQROyUmfwUJx3hyAQhg5iSQ
         EizCXC2GFVb1ENVkJDCpaHpA9Vaz1TMaM05C/UDOl5XTh0/HzPfKtOe8v7fkG1n0m/Bh
         5s/MZrzRpZ6i9WtBatEtQ9G6MaE71rnkJ65k+q2Tpj/VXVsEX6rEWu6YGQ5W3UajXqjM
         7vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1M8fJ0FCnOMntV70VPwyXOwsOWPRieVnDXWWBkV3kw=;
        b=FqvdtUBuoJboSQdqWWpRS92rydvW1/GhLr8CB2OHobOksp3OVRMS1GaA2bRRreeskU
         Uj9S8GPPYnG1yrnqd4zFCMZRtvrf3ndeNZK5l3b8DEg50TrA+m62m7+TGhQJTgh7thgq
         Gm/8LSp4ax3QUbXdTnQTVpUjo3YNQH8wqhM5JuLbkTmbfBcLhG7B3yXV6tfKE72tTHHa
         YuVObRWfKq26FEbJaToPI1SNlIlgNCgkI2j0b5QpuSlyHT+2FD3nB2cGFUCnR6C80KX+
         SfqFP0isqBilIBO/2vnpwcc+W6d4JpAF3NAxGixlEbOPJs/Iu70VdEoSIb6A5qUoaiqu
         yyjg==
X-Gm-Message-State: AOAM532hGfL3pKOxvJv2UWo3k8l8ucHBwzM0xWwfiBDB/6GE9/TVhORn
        AqdmWY6fSjqrP2C8Ew88yTkbTyF/7Vd8AG6IjaM=
X-Google-Smtp-Source: ABdhPJw7ZFJyA2mTuN2nynWCKPET3/NaIg+hFTh9bauwWQt500TZj9ueHtwWFzh19zkWupDS8iOIi1R9z6ugEJyArgs=
X-Received: by 2002:a5b:2c7:: with SMTP id h7mr49120445ybp.162.1593062715465;
 Wed, 24 Jun 2020 22:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200622233854.10889-1-rcampbell@nvidia.com> <20200622233854.10889-2-rcampbell@nvidia.com>
 <53751f8e-d901-df2e-a2e0-1b1484b31b81@nvidia.com> <CACAvsv5NqqF704HyvTd6DH43-one06OO7Z=uENUS5RSOJzP8Jg@mail.gmail.com>
In-Reply-To: <CACAvsv5NqqF704HyvTd6DH43-one06OO7Z=uENUS5RSOJzP8Jg@mail.gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 25 Jun 2020 15:25:04 +1000
Message-ID: <CACAvsv6x5PPjFcpz0VD1e6PcXhJ9ENkOr1p=X4dFarJ-OF-Wvw@mail.gmail.com>
Subject: Re: [Nouveau] [RESEND PATCH 1/3] nouveau: fix migrate page regression
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 at 15:23, Ben Skeggs <skeggsb@gmail.com> wrote:
>
> On Tue, 23 Jun 2020 at 10:51, John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 2020-06-22 16:38, Ralph Campbell wrote:
> > > The patch to add zero page migration to GPU memory inadvertantly included
> >
> > inadvertently
> >
> > > part of a future change which broke normal page migration to GPU memory
> > > by copying too much data and corrupting GPU memory.
> > > Fix this by only copying one page instead of a byte count.
> > >
> > > Fixes: 9d4296a7d4b3 ("drm/nouveau/nouveau/hmm: fix migrate zero page to GPU")
> > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > ---
> > >   drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > > index e5c230d9ae24..cc9993837508 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > > @@ -550,7 +550,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
> > >                                        DMA_BIDIRECTIONAL);
> > >               if (dma_mapping_error(dev, *dma_addr))
> > >                       goto out_free_page;
> > > -             if (drm->dmem->migrate.copy_func(drm, page_size(spage),
> > > +             if (drm->dmem->migrate.copy_func(drm, 1,
> > >                       NOUVEAU_APER_VRAM, paddr, NOUVEAU_APER_HOST, *dma_addr))
> > >                       goto out_dma_unmap;
> > >       } else {
> > >
> >
> >
> > I Am Not A Nouveau Expert, nor is it really clear to me how
> > page_size(spage) came to contain something other than a page's worth of
> > byte count, but this fix looks accurate to me. It's better for
> > maintenance, too, because the function never intends to migrate "some
> > number of bytes". It intends to migrate exactly one page.
> >
> > Hope I'm not missing something fundamental, but:
> I'm actually a bit confused here too.  Because, it *looks* like the
> function takes a byte count, not a page count, and unless I'm missing
> something too, it's setup the copy class for a byte count also.
No, nevermind.. I was looking at nvc0b5_migrate_clear() :)

>
> >
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com
> >
> >
> > thanks,
> > --
> > John Hubbard
> > NVIDIA
> > _______________________________________________
> > Nouveau mailing list
> > Nouveau@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/nouveau
