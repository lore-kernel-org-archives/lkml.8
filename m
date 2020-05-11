Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37552C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1197720731
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4za8q6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgEKJn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbgEKJnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:43:55 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF4C061A0C;
        Mon, 11 May 2020 02:43:55 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c12so13556041oic.1;
        Mon, 11 May 2020 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YO2ZrbWa/GjLyrkjg6sCgnAZgQAjgJWk4AMO7gsTNVw=;
        b=W4za8q6xCq1PKmE8TDaVI/YbrU6tqAlPw3FphOaONDGWKNRL+n6K8rSmWR95gSdRiB
         Pc72TnO3EiTLrsUZOm9sQ9P1mv8VLDl/jEofb3UQT982ll1L4zGpE+upTgjddatOLAGi
         vTjZ7BJoLpiDK2xvIqRWE4g2aK6pBxn4ErUuAAbwgR00NO6t/QQ0GQnRF7+CCx8vg5jb
         Z6vodzvYigvmI1gybtXoYIhvzlrouuL/Dah9ipcyPIL3UHonNON0i7OGh1x9WaaQwXl+
         9FErOVivQrBuiln/MSiNpAGkh7eH59IlB1cI28gkmcyr6hMcDhyW46K97SROLNgAiiej
         SryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YO2ZrbWa/GjLyrkjg6sCgnAZgQAjgJWk4AMO7gsTNVw=;
        b=UBfBCUNOB7u6J3cVkULD24yfF1id3DC4Hdl1cZpDgNxgSdHS4oQDuBWKoZcGhrGCEQ
         fQn2mUTlC6vVyAYQkHktV/fq8OGIsXxUFowkmBw89dZXtXDx2AYOk/liyQxvlpdjmxpF
         pR/S/d86iCxQCH+1v8z4kZB2JhG88SY7SmePNF85j8npT8OhRsF8OSWy8kvXjX0UCgbv
         3si4S+p9h5cBQfynz959EemFcvBNb+tTVZZc4Mv4T/pcW6Kp3iOavt7QciTHUY1TKMip
         Zo3DnsAF7/9gDCPk0BScG+98t846RDawp1TGnxQRLLTY815pcPJYo2HtUA2kYQ08stRc
         CtUQ==
X-Gm-Message-State: AGi0PuY7EJMpl4iiSHGTIOjT4dNBh87QJFrMVbX+I5shrTm9xvxO7JHa
        hb9csuOuJeJpXrQJLyClIn4OTej+YMUwIUXfDU7trnCPkTs=
X-Google-Smtp-Source: APiQypK+nD0Gmx36F2wXwHrGVNh8L6LLcNUzenp1CD2DqFB/EQ8oek6utcYJ1Lr3zoWhnSPdbH5CwdqJePlWg1ebiqY=
X-Received: by 2002:aca:abd0:: with SMTP id u199mr18301648oie.130.1589190234071;
 Mon, 11 May 2020 02:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
 <20200511091142.208787-3-daniel.vetter@ffwll.ch> <CAFCwf10m14ModSuRbQAsWf5CSJvTeP7YRzcokD=o+m2Pa0TqKg@mail.gmail.com>
In-Reply-To: <CAFCwf10m14ModSuRbQAsWf5CSJvTeP7YRzcokD=o+m2Pa0TqKg@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 11 May 2020 12:43:09 +0300
Message-ID: <CAFCwf11MrovJbcutkuyhJpvAY9v9rtRdHAkY8wJF7S-z5vrWTg@mail.gmail.com>
Subject: Re: [PATCH 3/3] misc/habalabs: don't set default fence_ops->wait
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And just FYI, the driver was written internally at 2016-17, where the
dma-buf module didn't check the .wait ops before calling it and that's
why the initialization of the default wait was there in the first
place.
I should have removed it when I upstreamed it but it missed my review.
Thanks,
Oded

On Mon, May 11, 2020 at 12:36 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Mon, May 11, 2020 at 12:11 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > It's the default.
> Thanks for catching that.
>
> >
> > Also so much for "we're not going to tell the graphics people how to
> > review their code", dma_fence is a pretty core piece of gpu driver
> > infrastructure. And it's very much uapi relevant, including piles of
> > corresponding userspace protocols and libraries for how to pass these
> > around.
> >
> > Would be great if habanalabs would not use this (from a quick look
> > it's not needed at all), since open source the userspace and playing
> > by the usual rules isn't on the table. If that's not possible (because
> > it's actually using the uapi part of dma_fence to interact with gpu
> > drivers) then we have exactly what everyone promised we'd want to
> > avoid.
>
> We don't use the uapi parts, we currently only using the fencing and
> signaling ability of this module inside our kernel code. But maybe I
> didn't understand what you request. You want us *not* to use this
> well-written piece of kernel code because it is only used by graphics
> drivers ?
> I'm sorry but I don't get this argument, if this is indeed what you meant.
>
> Oded
>
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc:     Olof Johansson <olof@lixom.net>
> > Cc: Oded Gabbay <oded.gabbay@gmail.com>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > ---
> >  drivers/misc/habanalabs/command_submission.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> > index 409276b6374d..cc3ce759b6c3 100644
> > --- a/drivers/misc/habanalabs/command_submission.c
> > +++ b/drivers/misc/habanalabs/command_submission.c
> > @@ -46,7 +46,6 @@ static const struct dma_fence_ops hl_fence_ops = {
> >         .get_driver_name = hl_fence_get_driver_name,
> >         .get_timeline_name = hl_fence_get_timeline_name,
> >         .enable_signaling = hl_fence_enable_signaling,
> > -       .wait = dma_fence_default_wait,
> >         .release = hl_fence_release
> >  };
> >
> > --
> > 2.26.2
> >
