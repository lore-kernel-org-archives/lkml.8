Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11D1C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A5320838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZNIJtWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgAJVCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:02:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41345 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAJVC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:02:29 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so3542081ioo.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DscpuWHCpmPvr4rJjWCNU0C+wW4iWR7q6WdgIPGNWp8=;
        b=DZNIJtWDxi/IFi9rezbRRGdt2PNteEKMx12hwXSahx8QOiYfv5QyoZqEUO/h6dY2nG
         HtYbN0XKSDT8rKy8m4E9XUoK3k8d4QEoCk51sSf7ZKTPnsGDS8Mif3kgP9ZNFg1K+qXk
         LcEY3UPe1tYogE1FsCAoO5Iz+UIzPdbrwyXfEXyetei5BsL/kj6kUWYl5fVf78wUEPDh
         4mJsUUuDU2lH5qsgNRd1M2hov480V52g3r3NyOi1eRaf3yeQ6XpzBmDLzBJ7v9pT5Idt
         PxQfxFN8fEkEWRabStaLVCog4wNnxT8rHfjnwqaWisU+oY0x0ulS0d4iVIad737zTc4U
         mMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DscpuWHCpmPvr4rJjWCNU0C+wW4iWR7q6WdgIPGNWp8=;
        b=c+7vm8ZWu0z5LOhh9bCMFMVIkw6L34yw1OHLFbRlVRqe+flGjXjZrKxjWstXsXEpUg
         gWM3WPCGZAvq6e/flRvJccDmub/fLM42YM8u3dvXlbXb/FmdtO56RWF1FUjLpz5KWTFN
         1hfOuz9Ev58Fys3FP3fFE+vMZIe9vakTIP+JGisxUG+GuX8Sgw1tCD77W/6zLNN6bXCx
         +A9dPUSmT43qOXb5A/qbA694l4spi8MlgQzBPr9A2MBRyFkG0x2fMB5tldyimCYiEblN
         3MH42+923lAF2L3f2GJRjnbv1DmwXOOA6QY3Yoyucxtjil4+IUzydW5eFqlAL2HCKs+I
         TDgg==
X-Gm-Message-State: APjAAAXsnswSAAi0quuNPXysRjxlhKIzyhBa2owj7xT4F2hCWgLEY9J8
        al04SWmxTD6LAWxaROmj2TCrzWTSkq+QXhxRqqo=
X-Google-Smtp-Source: APXvYqwLh4K1IfrVM9/WMlQhAf6HvRXmjNuB6U8BcycbyeLI32u6bBID/d1x4io+NNaZ/oLcomb7JELbKTP/2iO8c2Y=
X-Received: by 2002:a5d:8b96:: with SMTP id p22mr4006771iol.93.1578690149027;
 Fri, 10 Jan 2020 13:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20200110094535.23472-1-kraxel@redhat.com> <CAG48ez0wfLkTqdBtDBV4b1uUQMGeeAr09GPPi9WT++Fn8ph4rA@mail.gmail.com>
In-Reply-To: <CAG48ez0wfLkTqdBtDBV4b1uUQMGeeAr09GPPi9WT++Fn8ph4rA@mail.gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 10 Jan 2020 13:02:17 -0800
Message-ID: <CAPaKu7TQCXOmj1zthBXq4XtNpK8WT4Rv5CwUmLrRBNwm4f0uRw@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: add missing virtio_gpu_array_lock_resv call
To:     Jann Horn <jannh@google.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 6:27 AM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Jan 10, 2020 at 10:45 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > When submitting a fenced command we must lock the object reservations
> > because virtio_gpu_queue_fenced_ctrl_buffer() unlocks after adding the
> > fence.
>
> Thanks a lot! With this patch applied, my VM doesn't throw lockdep
> warnings anymore. If you want, you can add:
>
> Tested-by: Jann Horn <jannh@google.com>
>
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
> >  1 file changed, 1 insertion(+)
