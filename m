Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970D0C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633E62465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cBBOlTfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgA1HUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:20:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36101 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgA1HUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:20:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so13616866edp.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sb+8J/7DuRGfGudhsScfamBXEMs+Mce/hybB6WnCHb0=;
        b=cBBOlTfYKE9YToJ7LwFQXUs38A+ojqRBnM0kt+rHMyNahEoDFA6easCZ0aFYOPtke3
         92ch4PzsGSCY5aLRhqTT/Efcfd4whgm9Naygy4kaj/kYGeA0+wOB21kgR8n0MWKNEDG5
         1uI51gw21EMHkPLWo/gWWMfXNCjXDlc2AC+1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sb+8J/7DuRGfGudhsScfamBXEMs+Mce/hybB6WnCHb0=;
        b=b06Ee+0mojvBns3jSBeKEbVOzPtWHcW7IxsH82PG3yhMbBIzEuFxU3QKvIg7ajhJun
         QXAWgT27SM4Eyoi5UwQl603aQ9GkGRS050taOlQhOVzrxBzWbSsxvCEdtia46bXwUcEg
         wQQgM3wHh3yZBFeXKE9yfS1WDfwEnSRKFetLR7rojKRps7x7679JDeMx1Zfoj4wB2aSw
         tyYzaqs5Rf1z6LxHjsiIEhHTgESvVLjXDrowD/jPt8ED/snN8e1muf6RpOGC9Lu/UCZv
         PED1RDHYqbns8x+f4F9AcaUevrqKziExghMiAutaowWlxb/CvnbU27fAREQ5qmQcAlUw
         86fA==
X-Gm-Message-State: APjAAAXeCeixzMUAeYAgE0rPhBCDghbLV4JO6UQmZ9DnhWWkQsK8fxNu
        oHb5mJ0nCytp6IaB/wfgnahx58RZSR3IAg==
X-Google-Smtp-Source: APXvYqx+DCa/mVzHJX9RIUHASmsoPwzllGj4qx61ZF+o9UrkCqSlJwpXqfLivvylG5YHpr7yaiLqGg==
X-Received: by 2002:a05:6402:74a:: with SMTP id p10mr1943618edy.377.1580196004421;
        Mon, 27 Jan 2020 23:20:04 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id qh18sm339052ejb.23.2020.01.27.23.20.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 23:20:02 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id t14so1282224wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:20:01 -0800 (PST)
X-Received: by 2002:a05:600c:294a:: with SMTP id n10mr3195790wmd.11.1580196001394;
 Mon, 27 Jan 2020 23:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-14-senozhatsky@chromium.org> <2d0e1a9b-6c5e-ff70-9862-32c8b8aaf65f@xs4all.nl>
 <20200122050515.GB49953@google.com> <57f711a0-6183-74f6-ab24-ebe414cb6881@xs4all.nl>
In-Reply-To: <57f711a0-6183-74f6-ab24-ebe414cb6881@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 28 Jan 2020 16:19:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Dbw=B7kb-p8nkPN3GxwL0O-5q=y1HRAVUVOwv4eEAv-Q@mail.gmail.com>
Message-ID: <CAAFQd5Dbw=B7kb-p8nkPN3GxwL0O-5q=y1HRAVUVOwv4eEAv-Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 13/15] videobuf2: do not sync buffers for DMABUF queues
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

On Thu, Jan 23, 2020 at 8:35 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 1/22/20 6:05 AM, Sergey Senozhatsky wrote:
> > On (20/01/10 11:30), Hans Verkuil wrote:
> > [..]
> >>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >>> index 1762849288ae..2b9d3318e6fb 100644
> >>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >>> @@ -341,8 +341,22 @@ static void set_buffer_cache_hints(struct vb2_queue *q,
> >>>                                struct vb2_buffer *vb,
> >>>                                struct v4l2_buffer *b)
> >>>  {
> >>> -   vb->need_cache_sync_on_prepare = 1;
> >>> +   /*
> >>> +    * DMA exporter should take care of cache syncs, so we can avoid
> >>> +    * explicit ->prepare()/->finish() syncs.
> >>> +    */
> >>> +   if (q->memory == VB2_MEMORY_DMABUF) {
> >>> +           vb->need_cache_sync_on_finish = 0;
> >>> +           vb->need_cache_sync_on_prepare = 0;
> >>> +           return;
> >>> +   }
> >>>
> >>> +   /*
> >>> +    * For other ->memory types we always need ->prepare() cache
> >>> +    * sync. ->finish() cache sync, however, can be avoided when queue
> >>> +    * direction is TO_DEVICE.
> >>> +    */
> >>> +   vb->need_cache_sync_on_prepare = 1;
> >>
> >> I'm trying to remember: what needs to be done in prepare()
> >> for a capture buffer? I thought that for capture you only
> >> needed to invalidate the cache in finish(), but nothing needs
> >> to be done in the prepare().
> >
> > Hmm. Not sure. A precaution in case if user-space wrote to that buffer?
>
> But whatever was written in the buffer is going to be overwritten anyway.
>
> Unless I am mistaken the current situation is that the cache syncs are done
> in both prepare and finish, regardless of the DMA direction.
>
> I would keep that behavior to avoid introducing any unexpected regressions.
>

It wouldn't be surprising if the buffer was first filled with default
values (e.g. all zeroes) on the CPU. That would make the cache lines
dirty and they could overwrite what the device writes. So we need to
flush (aka clean) the write-back caches on prepare for CAPTURE
buffers.

> Then, if q->allow_cache_hint is set, then default to a cache sync (cache clean)
> in the prepare for OUTPUT buffers and a cache sync (cache invalidate) in the
> finish for CAPTURE buffers.

I'd still default to the existing behavior even if allow_cache_hint is
set, because of what I wrote above. Then if the userspace doesn't ever
write to the buffers, it can request no flush/clean by setting the
V4L2_BUF_FLAG_NO_CACHE_CLEAN flag when queuing the buffer.

>
> This also means that any drivers that want to access a buffer in between the
> prepare...finish calls will need to do a begin/end_cpu_access. But that's a
> separate matter.

AFAIR with current design of the series, the drivers can opt-in for
userspace cache sync hints, so by default even if the userspace
requests sync to be skipped, it wouldn't have any effect unless the
driver allows so. Then I'd imagine migrating all the drivers to
request clean/invalidate explicitly. Note that the DMA-buf
begin/end_cpu_access isn't enough here. We'd need something like
vb2_begin/end_cpu_access() which also takes care of syncing
inconsistent MMAP and USERPTR buffers.

>
> Regards,
>
>         Hans
>
> >
> > +     if (q->dma_dir == DMA_FROM_DEVICE)
> > +             q->need_cache_sync_on_prepare = 0;
> >
> > ?
> >
> >       -ss
> >
>
