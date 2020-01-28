Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F498C35240
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D802467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdhsRI5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgA1HWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:22:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33108 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgA1HWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:22:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so13632441edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nk08glDvsO0Zhe33d32oC0h5w7Io+xZ7TRwvanNwqQ=;
        b=GdhsRI5CZRwPLrJPysq044nlfLMQCBU3saKN9NtdzpJIz2TWIKHKUxoq72r/Kkljkg
         +FzNGsGKoQbRQYbx0xuSvyf9gp1J+YjyrsfSTvGqsG4mC4T9hcMQv27AQrhr9QO2I/RL
         qGz4g/5r03DRqYRA1b56YKOVk/l533WuumYeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nk08glDvsO0Zhe33d32oC0h5w7Io+xZ7TRwvanNwqQ=;
        b=uMIuTA+bABng3pzG0+lSitfgrEoAcpt0JVP/6jr0z6lpdhQKOKo43iON9t7MS7v3Z7
         Mv6nG2g7v4HeBj5eghE9vcS/BmGD10pzNS7Viplsfxispj/tike4TRlUOvvb/q2n4wne
         a1/LEhqNYl09ijs5rNBRWSTcN/eEifUtoQu7kQ1CLy0lPhGIPS67unkzZi5TxqaBrNdl
         +B7lBwY9QUxnNiYls1JQrGyJh67ydPeOwHqz+cdFSVilADwEpraDstvDl10oU81da+p7
         4MjIr51l+y04Lcfx/St6NnXGVTn9IjPigNEpUg11GjMqbgC445uyeU2rXYUnMN/unoDs
         UOUw==
X-Gm-Message-State: APjAAAW4jE+6qB57qWQdKkP7J4i1GpwXW42JrK5OUR87eZgRIb/ML2C8
        ZtKw6Fp6JJzqyPZSinnf2KEh6nMxks2EAg==
X-Google-Smtp-Source: APXvYqzi1rM7gZA0MDWcgYhw2YFECM0+Z/ns0Ugxb5U+tIud/Rjx0lzfI0697DFT52vwJMmhfHdWUQ==
X-Received: by 2002:a05:6402:1c95:: with SMTP id cy21mr2108594edb.73.1580196150001;
        Mon, 27 Jan 2020 23:22:30 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id j17sm278979ejo.1.2020.01.27.23.22.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 23:22:28 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id p17so1326816wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:22:28 -0800 (PST)
X-Received: by 2002:a05:600c:294a:: with SMTP id n10mr3209119wmd.11.1580196147663;
 Mon, 27 Jan 2020 23:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-14-senozhatsky@chromium.org> <2d0e1a9b-6c5e-ff70-9862-32c8b8aaf65f@xs4all.nl>
 <20200122050515.GB49953@google.com> <57f711a0-6183-74f6-ab24-ebe414cb6881@xs4all.nl>
 <20200124022544.GD158382@google.com> <20200124073250.GA100275@google.com>
In-Reply-To: <20200124073250.GA100275@google.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 28 Jan 2020 16:22:16 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Dx50nt=yOCj-ufDDey=Zur_F5yE34a9OQP630A1opBSQ@mail.gmail.com>
Message-ID: <CAAFQd5Dx50nt=yOCj-ufDDey=Zur_F5yE34a9OQP630A1opBSQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 13/15] videobuf2: do not sync buffers for DMABUF queues
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
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

On Fri, Jan 24, 2020 at 4:32 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (20/01/24 11:25), Sergey Senozhatsky wrote:
> [..]
> >
> > > Then, if q->allow_cache_hint is set, then default to a cache sync (cache clean)
> > > in the prepare for OUTPUT buffers and a cache sync (cache invalidate) in the
> > > finish for CAPTURE buffers.
> >
> > We alter default cache sync behaviour based both on queue ->memory
> > type and queue ->dma_dir. Shall both of those cases depend on
> > ->allow_cache_hints, or q->memory can be independent?
> >
> > static void set_buffer_cache_hints(struct vb2_queue *q,
> >                                  struct vb2_buffer *vb,
> >                                  struct v4l2_buffer *b)
> > {
> >       if (!q->allow_cache_hints)
> >               return;
> >
> >       /*
> >        * DMA exporter should take care of cache syncs, so we can avoid
> >        * explicit ->prepare()/->finish() syncs. For other ->memory types
> >        * we always need ->prepare() or/and ->finish() cache sync.
> >        */
> >       if (q->memory == VB2_MEMORY_DMABUF) {
> >               vb->need_cache_sync_on_finish = 0;
> >               vb->need_cache_sync_on_prepare = 0;
> >               return;
> >       }
>
> I personally would prefer this to be above ->allow_cache_hints check,
> IOW to be independent. Because we need to skip flush/invalidation for
> DMABUF anyway, that's what allocators do in ->prepare() and ->finish()
> currently.

I think it's even more than personal preference. We shouldn't even
attempt to sync imported DMA-bufs, so the code above may result in
incorrect behavior.
