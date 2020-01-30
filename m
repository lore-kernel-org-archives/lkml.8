Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7579CC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AF2206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J6cp/hlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgA3LCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:02:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44656 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3LCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:02:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so3320357eds.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPAei91bdBKv+rtfq6jeMzyMQEwb+GsA+UNab2GQXWE=;
        b=J6cp/hlWE07Posv7U7HV3Jnsf5Nuvj7k3gxZEy8CJbRquFWEUep1tVJEjz4ziWGovG
         gXXL6hW46/4Z5wKIsLzCtRFq1INamP0SwaO+jO/1qb4iHbnfeELLg4Pfq7astmZilU6E
         KVlSgpTyzH+8ssoYaBryEiWKDQlvJcyvAOw2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPAei91bdBKv+rtfq6jeMzyMQEwb+GsA+UNab2GQXWE=;
        b=RGppUhL6O4//nPYPek1FLXRj18+rRHc44BnmArInEfnT+j0tlC2PLuxFEadFIxMqic
         aL2kljtK8jId4KcBZtyC6SjuLtzIxQqqcWEZiCkAnqQLxr5VrHP4a35/E1HrveYnjh7m
         ryhMOXXU0SM6nobwUMWiFmdemp6DYeNrU13Kzus0/4IzWnLnmf1OpJG8o7dYOSOBHye+
         o9/HWZM8S8KOYRRfHa7DDR/JYBndcs3IxUzpzxTRd69tMkzK8JOYYsLSkMPeG/keuW63
         pXpand3FfwHQkP0SvSqKDRe9xTDeWKbAcdNM4PqhWaUty9qiG6G8nxkZxtZ6Ip0qJAZN
         7iwA==
X-Gm-Message-State: APjAAAXmXcWwtTCWY9xBM8UQhnPwtDi5p1laU6fG65p2pwkirRyhytUC
        BGrdndGKEx+8nKoLMKiudSsik0nZ9JyM6Q==
X-Google-Smtp-Source: APXvYqxnEzH7XUWC+8L9oO4OJHRUMj4rK3Kq8F+WwLNnEeS82PL2GTaJHzH1SekTxXA/7+CVUbb02A==
X-Received: by 2002:a05:6402:1595:: with SMTP id c21mr3325179edv.32.1580382140321;
        Thu, 30 Jan 2020 03:02:20 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id f17sm588013eja.37.2020.01.30.03.02.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 03:02:17 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id s10so3277938wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 03:02:17 -0800 (PST)
X-Received: by 2002:a1c:9a8d:: with SMTP id c135mr4706199wme.183.1580382136375;
 Thu, 30 Jan 2020 03:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-13-senozhatsky@chromium.org> <1c5198dc-db4e-47d6-0d8b-259fbbb6372f@xs4all.nl>
 <CAAFQd5DN0FSJ=pXG3J32AXocnbkR+AB8yKKDk0tZS4s7K04Z9Q@mail.gmail.com> <560ba621-5396-1ea9-625e-a9f83622e052@xs4all.nl>
In-Reply-To: <560ba621-5396-1ea9-625e-a9f83622e052@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 30 Jan 2020 20:02:04 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D27xaKhxg8UuPH6XXdzgBBsCeDL8wYw37r6AK+6sWcbg@mail.gmail.com>
Message-ID: <CAAFQd5D27xaKhxg8UuPH6XXdzgBBsCeDL8wYw37r6AK+6sWcbg@mail.gmail.com>
Subject: Re: [RFC][PATCH 12/15] videobuf2: add begin/end cpu_access callbacks
 to dma-sg
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 5:36 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 1/28/20 5:38 AM, Tomasz Figa wrote:
> > On Fri, Jan 10, 2020 at 7:13 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>
> >> On 12/17/19 4:20 AM, Sergey Senozhatsky wrote:
> >>> Provide begin_cpu_access() and end_cpu_access() dma_buf_ops
> >>> callbacks for cache synchronisation on exported buffers.
> >>>
> >>> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >>> ---
> >>>  .../media/common/videobuf2/videobuf2-dma-sg.c | 22 +++++++++++++++++++
> >>>  1 file changed, 22 insertions(+)
> >>>
> >>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> >>> index 6db60e9d5183..bfc99a0cb7b9 100644
> >>> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> >>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> >>> @@ -470,6 +470,26 @@ static void vb2_dma_sg_dmabuf_ops_release(struct dma_buf *dbuf)
> >>>       vb2_dma_sg_put(dbuf->priv);
> >>>  }
> >>>
> >>
> >> There is no corresponding vb2_sg_buffer_consistent function here.
> >>
> >> Looking more closely I see that vb2_dma_sg_alloc doesn't pass the dma_attrs
> >> argument to dma_map_sg_attrs, thus V4L2_FLAG_MEMORY_NON_CONSISTENT has no
> >> effect on dma-sg buffers.
> >
> > videobuf2-dma-sg allocates the memory using the page allocator
> > directly, which means that there is no memory consistency guarantee.
> >
> >>
> >> Is there a reason why dma_attrs isn't passed on to dma_map_sg_attrs()?
> >>
> >
> > V4L2_FLAG_MEMORY_NON_CONSISTENT is a flag for dma_alloc_attrs(). It
> > isn't supposed to do anything for dma_map_sg_attrs(), which is only
> > supposed to create the device (e.g. IOMMU) mapping for already
> > allocated memory.
>
> Ah, right.
>
> But could vb2_dma_sg_alloc_compacted() be modified so that is uses
> dma_alloc_attrs() instead of alloc_pages()? Sorry, that might be a stupid
> question, I'm not an expert in this area. All I know is that I hate inconsistent
> APIs where something works for one thing, but not another.
>

dma_alloc_attrs() would allocate contiguous memory, which kind of goes
against the vb2_dma_sg allocator idea. Technically we could call it N
times with size = 1 page to achieve what we want, but is this really
what we want?

Given that vb2_dma_sg has always been returning non-consistent memory,
do we have any good reason to add consistent memory to it? If so,
perhaps we could still do that in an incremental patch, to avoid
complicating this already complex series? :)

Best regards,
Tomasz

> Regards,
>
>         Hans
>
> >
> >> I suspect it was just laziness in the past, and that it should be wired
> >> up, just as for dma-contig.
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >>> +static int vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> >>> +                                     enum dma_data_direction direction)
> >>> +{
> >>> +     struct vb2_dma_sg_buf *buf = dbuf->priv;
> >>> +     struct sg_table *sgt = buf->dma_sgt;
> >>> +
> >>> +     dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int vb2_dma_sg_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
> >>> +                                     enum dma_data_direction direction)
> >>> +{
> >>> +     struct vb2_dma_sg_buf *buf = dbuf->priv;
> >>> +     struct sg_table *sgt = buf->dma_sgt;
> >>> +
> >>> +     dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
> >>> +     return 0;
> >>> +}
> >>> +
> >>>  static void *vb2_dma_sg_dmabuf_ops_vmap(struct dma_buf *dbuf)
> >>>  {
> >>>       struct vb2_dma_sg_buf *buf = dbuf->priv;
> >>> @@ -488,6 +508,8 @@ static const struct dma_buf_ops vb2_dma_sg_dmabuf_ops = {
> >>>       .detach = vb2_dma_sg_dmabuf_ops_detach,
> >>>       .map_dma_buf = vb2_dma_sg_dmabuf_ops_map,
> >>>       .unmap_dma_buf = vb2_dma_sg_dmabuf_ops_unmap,
> >>> +     .begin_cpu_access = vb2_dma_sg_dmabuf_ops_begin_cpu_access,
> >>> +     .end_cpu_access = vb2_dma_sg_dmabuf_ops_end_cpu_access,
> >>>       .vmap = vb2_dma_sg_dmabuf_ops_vmap,
> >>>       .mmap = vb2_dma_sg_dmabuf_ops_mmap,
> >>>       .release = vb2_dma_sg_dmabuf_ops_release,
> >>>
> >>
>
