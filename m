Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6DBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030EC2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TVTA5LBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgFJKRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFJKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:17:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AFAC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:17:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g1so980227edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlc2DkfoS9fCgUdl8ll/iVxGFZ5RW0ELnSTQYCe4qzM=;
        b=TVTA5LByMF9ljQ4aw2uPEqGqWK40sLhpuXPzkdezDWqDFdJ0OhWmnsWnT1WvAkPJ38
         Qz5BQStn4oUkD1+qEIXMWeVcqHbqmq+VDD09cBB0PGsnVbakLcPc4+/zlCMTEHlVESTx
         8BQYMM1IP1GznHDYspSgYZkA1MuwsinzJY0x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlc2DkfoS9fCgUdl8ll/iVxGFZ5RW0ELnSTQYCe4qzM=;
        b=fKuOFqndn2KgIA/ItyBAi1C+etht0+FRreebIf5iZKtYJNct+8BSX5f3afAW4M+f1H
         SKjl9+cc7YfakWd9UX6bo9J1gOX3g9LvnmOEBPX8GDyfRhhvx5vcDlLhASqwre/6QxnB
         3lxqgTSkTVT0Q0WRHoevAfSfSVAaiy4GKy5VoHz0Pb8dg7X4+65EgGMiBOwyJDymru7b
         GnCFACLMIHsgdvRRD17jMN5KBMz23TMN3LxZGyhrc2VnFO474c2x7yjqgMkoodzavtFZ
         g1m7TUiDyBYbOjSlmw1qeB1XNnkklH9d7DuRIkkhQLOlfiYOTm1ZPi4rf8OyZwqmZ+2A
         rxrg==
X-Gm-Message-State: AOAM530EfmaOCZCRNn7yVfeETz0wTNSLnJuHxictvORIqY087ii0K8hK
        MTpp6DhEaj1VGPqG/JkSrVNUWOxRrZo=
X-Google-Smtp-Source: ABdhPJzcwFFOYPwjji+t8kCsvgegNA0cs+xSYvTqtOKsggDZT8dWsbwV5KLCJgR9E6gl2pIQK2Ehjg==
X-Received: by 2002:aa7:dc57:: with SMTP id g23mr1737376edu.352.1591784250147;
        Wed, 10 Jun 2020 03:17:30 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id o7sm12854956edj.52.2020.06.10.03.17.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 03:17:29 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id r15so1277892wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:17:29 -0700 (PDT)
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr2446283wmu.55.1591784248713;
 Wed, 10 Jun 2020 03:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200609060417.8066-1-sergey.senozhatsky@gmail.com> <d1ebdb9b-ceea-3582-831d-7cef5134d8f9@xs4all.nl>
In-Reply-To: <d1ebdb9b-ceea-3582-831d-7cef5134d8f9@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 10 Jun 2020 12:17:18 +0200
X-Gmail-Original-Message-ID: <CAAFQd5C=01Jpmn3TTEhPWufg8f72ta9ZUjeRG2VCB8F9NPwvJw@mail.gmail.com>
Message-ID: <CAAFQd5C=01Jpmn3TTEhPWufg8f72ta9ZUjeRG2VCB8F9NPwvJw@mail.gmail.com>
Subject: Re: [PATCH] videobuf2: always re-init queue memory consistency attribute
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:54 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Sergey,
>
> On 09/06/2020 08:04, Sergey Senozhatsky wrote:
> > We need a combination of two factors in order to permit modification
> > of queue's memory consistency attribute in set_queue_consistency():
> >   (1) queue should allow user-space cache hints
> >   (2) queue should be used for MMAP-ed I/O
> >
> > Therefore the code in videobuf2 core looks as follows:
> >
> >       q->memory = req->memory;
> >       set_queue_consistency(q, consistent);
> >
> > This works when we do something like this (suppose that queue allows
> > cache hints)
> >
> >       reqbufs.memory = V4L2_MEMORY_DMABUF;
> >       reqbufs.flags = 0;
> >       doioctl(node, VIDIOC_REQBUFS, &reqbufs);
> >
> >       reqbufs.memory = V4L2_MEMORY_MMAP;
> >       reqbufs.flags = V4L2_FLAG_MEMORY_NON_CONSISTENT;
> >       doioctl(node, VIDIOC_REQBUFS, &reqbufs);
> >
> > However, this doesn't work the other way around
> >
> >       reqbufs.memory = V4L2_MEMORY_MMAP;
> >       reqbufs.flags = V4L2_FLAG_MEMORY_NON_CONSISTENT;
> >       doioctl(node, VIDIOC_REQBUFS, &reqbufs);
> >
> >       reqbufs.memory = V4L2_MEMORY_DMABUF;
> >       reqbufs.flags = 0;
> >       doioctl(node, VIDIOC_REQBUFS, &reqbufs);
> >
> > because __vb2_queue_free() doesn't clear queue's ->dma_attrs
> > once its don't freeing queue buffers, and by the time we call
> > set_queue_consistency() the queue is DMABUF so (2) is false
> > and we never clear the stale consistency attribute.
> >
> > Re-implement set_queue_consistency() - it must always clear
> > queue's non-consistency attr and set it only if (1) and (2).
> >
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  drivers/media/common/videobuf2/videobuf2-core.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > index 7e081716b8da..37d0186ba330 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -704,12 +704,11 @@ EXPORT_SYMBOL(vb2_verify_memory_type);
> >
> >  static void set_queue_consistency(struct vb2_queue *q, bool consistent_mem)
> >  {
> > +     q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> > +
> >       if (!vb2_queue_allows_cache_hints(q))
> >               return;
> > -
> > -     if (consistent_mem)
> > -             q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> > -     else
> > +     if (!consistent_mem)
> >               q->dma_attrs |= DMA_ATTR_NON_CONSISTENT;
> >  }
> >
> >
>
> Is it OK with you if I fold this patch into the original patch series and make a
> new PR for it? I prefer to have a series merged without a bug, rather than fixing
> it in a final patch.

I believe this didn't introduce any real bug, because dma_attrs would
end up used only for MMAP buffers anyway. Still, the current behavior
could end up being confusing for whoever has to deal with vb2 in the
future, so should be fixed.

Best regards,
Tomasz
