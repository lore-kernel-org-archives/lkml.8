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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE5CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A89920789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZXf7Z4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbgFYFYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbgFYFYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:24:00 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC02C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:24:00 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n123so2137821ybf.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GN+vwP6awwYeHuE8Nxiqbib4DkikNLChIdT3TjcmjCQ=;
        b=sZXf7Z4uTzNP+UaPk4pvsBCB6Gb0KK2NKJ2Uj2afN3SNByxwcpyOH5XIzCMP6mIA+2
         CnnbQis6REgQ7JqaCwg9MtoIc4rbrAKsfUI4rpxVIYPyMUze2M6Qaw+jHudWWiYl+/fS
         QgMlyLL7eXQ2fJGZU66vUqktic6M3Khz09xX4hocet+bGg2alfsUYEF8nHDEB0wXA0Gi
         6Z1h0KovhSdX62UmrEIfec1z0hlYhHrB3JpMUn9XxHdNNmWVq3FiFwDnJR5VEwaHLme/
         zPlzIWwt4FrIfTca7NMZAjrtEuib2Fe39kqHKoCc5TeZqurravOsZyu7zWqwtcccppkX
         twSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GN+vwP6awwYeHuE8Nxiqbib4DkikNLChIdT3TjcmjCQ=;
        b=uGksDepCoYGUsmCt6GoPpI03JrK+E46H4F3qnvQw2yoVkwzxTdSPPSEyXCqH6D+eZR
         I3al4hWJh2J7LsOaPGkaOqYuZupx2ZYFbIqmyMUt8zcDtS7FzT60SfigL+VO3MVpxc3O
         QIr9I1gDBrCIWpvwukSwEZnKyavsm/51eqmIniqUWhqdKTvxcDl+93xtWuFszffBUXXP
         MXaEMnlj+ttWhKB/i9e0FAdoyJ4IYdTMpAdFwFpd1tQIgjXfLpLW3bnlT1ILaQc0/Zgb
         sYwN//RqIPLPStuWOLiGiwoqidpEm1OwrdMPP2bxmiTmTWU5BjVtZRb09lpK2k6SClKN
         5YjA==
X-Gm-Message-State: AOAM530x8r6n/Cv7qirRm4qLMD99Eqr/GMC9oMOkoj+zG8AtV8Sp0+n6
        6qs7SOmDAgvakskKbV1kQvDbmxo0oZu6yUhEWPM=
X-Google-Smtp-Source: ABdhPJwFBExNOvnqSjcHjjCVFajvYo439vZFDatYszxkdzA35ELrTHJE0dawomj2kgWq9q2Xs7xI85GoF1jMKWsa2A8=
X-Received: by 2002:a5b:582:: with SMTP id l2mr45827370ybp.147.1593062639308;
 Wed, 24 Jun 2020 22:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200622233854.10889-1-rcampbell@nvidia.com> <20200622233854.10889-2-rcampbell@nvidia.com>
 <53751f8e-d901-df2e-a2e0-1b1484b31b81@nvidia.com>
In-Reply-To: <53751f8e-d901-df2e-a2e0-1b1484b31b81@nvidia.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 25 Jun 2020 15:23:48 +1000
Message-ID: <CACAvsv5NqqF704HyvTd6DH43-one06OO7Z=uENUS5RSOJzP8Jg@mail.gmail.com>
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

On Tue, 23 Jun 2020 at 10:51, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-06-22 16:38, Ralph Campbell wrote:
> > The patch to add zero page migration to GPU memory inadvertantly included
>
> inadvertently
>
> > part of a future change which broke normal page migration to GPU memory
> > by copying too much data and corrupting GPU memory.
> > Fix this by only copying one page instead of a byte count.
> >
> > Fixes: 9d4296a7d4b3 ("drm/nouveau/nouveau/hmm: fix migrate zero page to GPU")
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > ---
> >   drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > index e5c230d9ae24..cc9993837508 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > @@ -550,7 +550,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
> >                                        DMA_BIDIRECTIONAL);
> >               if (dma_mapping_error(dev, *dma_addr))
> >                       goto out_free_page;
> > -             if (drm->dmem->migrate.copy_func(drm, page_size(spage),
> > +             if (drm->dmem->migrate.copy_func(drm, 1,
> >                       NOUVEAU_APER_VRAM, paddr, NOUVEAU_APER_HOST, *dma_addr))
> >                       goto out_dma_unmap;
> >       } else {
> >
>
>
> I Am Not A Nouveau Expert, nor is it really clear to me how
> page_size(spage) came to contain something other than a page's worth of
> byte count, but this fix looks accurate to me. It's better for
> maintenance, too, because the function never intends to migrate "some
> number of bytes". It intends to migrate exactly one page.
>
> Hope I'm not missing something fundamental, but:
I'm actually a bit confused here too.  Because, it *looks* like the
function takes a byte count, not a page count, and unless I'm missing
something too, it's setup the copy class for a byte count also.

>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
