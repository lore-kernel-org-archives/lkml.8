Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BBAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869D32053B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTjr4Wxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgE2GQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2GQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:16:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867C5C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:16:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so1164860ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbcIKf1QoC5/4fB83l0xjUjMmfyP6E9s02t0GChxUYQ=;
        b=vTjr4WxbPZtsUvkCFw14dCgUsefA0jl0RcKfShDG01aXKJ6SwH1Kf5uYPvcipV6lyC
         IF+BUc6e4s4OzayMzaM3gEjZb6zVng8mJUHSQsKM1kLQsGwPuDvQQQWCPMol1CX0WBe4
         7MWQkr7IR2kvYEx1lad5um66p20CW8OliYMXbDefT5XxbNT3z8Lop4/vUirUIBRgDTw4
         Vv/wJxuSSKkMeL8GWWGBG2sbpqB0iiaODRUF2cDBtyAEOnCHMwCpZH/0LqQWruPkJGLK
         cKOqCwpVu7eziNCDWE/DHlwAsg1ulDz7JiDPpM7IH62dBEhSxWv3f3ibZfj6+ssjl7pR
         intg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbcIKf1QoC5/4fB83l0xjUjMmfyP6E9s02t0GChxUYQ=;
        b=p7W0hlTOTsIryJkhBp3pEAfNl+x3j3KgE2quyYKpEMHPBJoJLUd54fYuyrPxUkMV7d
         /sAl7bJAneyB8FWd8Pvpd7itmHKB6VlJvCOSCzbAkbTJFR4QNHzfwlhuU6tedsOOGu5Y
         WEgeBZVZG6Y0kwqGwnLaro5cNOnkdnfg+N2g7ueGa9i5JCkfnrid0xKN/qdIqugZAr3r
         RMjuDLhOKHTRn5FYIalm+XCs0hgmSf5AcYch2Fz5iwIieETj0bRQ4t/tN4f8rcoZRtLs
         VJDKtlMZxYFsPWLGZ2VyKbrG0XxKvCXn1UH8P/po7HTEVqUj5jImla6oEEZBf5REWxMc
         tRjA==
X-Gm-Message-State: AOAM531FF7K1RR3YjuB0Ynp7Pal3B0THOMDl0BXg9UOYq7Lv3mKfQtqJ
        RzDihE1oBFwn7JQRssz02JZHrWzqSbZQvVNdLIs=
X-Google-Smtp-Source: ABdhPJwS174JrfOv4aFghfvIn75qQwU7dTqkD+YBQrQYgQsSUx+e3u1MgP2jlBD51m9QrdFBrPctqCS7mc8wk396s5Q=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3010022lji.315.1590733011950;
 Thu, 28 May 2020 23:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <1590613362-27495-1-git-send-email-jrdr.linux@gmail.com> <20200528110408.GJ30374@kadam>
In-Reply-To: <20200528110408.GJ30374@kadam>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 29 May 2020 11:46:39 +0530
Message-ID: <CAFqt6zaKWBQTy9XfvxwVAvzGS+gz9Qv1gL8Bv1VxLq+THYf+Aw@mail.gmail.com>
Subject: Re: [PATCH] staging: gasket: Convert get_user_pages*() --> pin_user_pages*()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>, benchan@chromium.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 4:34 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, May 28, 2020 at 02:32:42AM +0530, Souptick Joarder wrote:
> > This code was using get_user_pages_fast(), in a "Case 2" scenario
> > (DMA/RDMA), using the categorization from [1]. That means that it's
> > time to convert the get_user_pages_fast() + put_page() calls to
> > pin_user_pages_fast() + unpin_user_page() calls.
>
> You are saying that the page is used for DIO and not DMA, but it sure
> looks to me like it is used for DMA.

No, I was referring to "Case 2" scenario in change log which means  it is
used for DMA, not DIO.

>
>    503                          /* Map the page into DMA space. */
>    504                          ptes[i].dma_addr =
>    505                                  dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
>    506                                               DMA_BIDIRECTIONAL);
>
> To be honest, that starting paragraph was confusing.  At first I thought
> you were saying gasket was an RDMA driver. :P  I shouldn't have to read
> a different document to understand the commit message.  It should be
> summarized enough and the other documentation is supplemental.
>
> "In 2019 we introduced pin_user_pages() and now we are converting
> get_user_pages() to the new API as appropriate".

As all other similar conversion have similar change logs, so I was trying
to maintain the same. John might have a different opinion on this.

John, Any further opinion ??

>
> >
> > There is some helpful background in [2]: basically, this is a small
> > part of fixing a long-standing disconnect between pinning pages, and
> > file systems' use of those pages.
>
> What is the impact of this patch on runtime?

I don't have the hardware to validate the runtime impact and will
wait if someone is going to validate it for runtime impact.

>
> >
> > [1] Documentation/core-api/pin_user_pages.rst
> >
> > [2] "Explicit pinning of user-space pages":
> >       https://lwn.net/Articles/807108/
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> >
> > Hi,
> >
> > I'm compile tested this, but unable to run-time test, so any testing
> > help is much appriciated.
> > ---
>
> The "Hi" part of patch should have been under the "---" cut off line so
> this will definitely need to be resent.

Sorry about it.
Will wait for feedback from John before resend it :)

>
> regards,
> dan carpenter
>
