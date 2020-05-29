Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918CDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1F2207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbZe0udn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgE2G1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2G1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:27:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9674C03E969
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:27:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so617526lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcojLQqLi5jvXd4nH045/Izmj9iUf4RKThqP6RXkuIQ=;
        b=TbZe0udnokxKRGkxiCJnwVNDkVOaQUM+btIee1mDmdIoyE80Oc8hwPJbeEdrloZdG9
         AdTAE+Z1XPDS1txibwkIeWcJBxyjDUkD+Xz+mnSq+QwBO8ImVsbQPw9T15/nPwNkrBJS
         PgXVeS61Kj0tAXhNbtA+sXw5kQyPI4oPLv9VviP0VkiEnqvZj/XZKdBAhCABkh7JiWYS
         z7dhft9e4J4kkabHYZAWDik6po2L0Fmv+1xl6cF40wKqmcvYChgGJ0VipD8jQfGKUG+P
         F638nAbFprF2f8ekVT1XdWHwuwjDmjR0eYx+TUn6HYPwBA2Ldvg0varG9SYqf976D3xU
         evsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcojLQqLi5jvXd4nH045/Izmj9iUf4RKThqP6RXkuIQ=;
        b=gz0N4J2s6sh8JX+iGwADbUyayGGN1UJitCwZ7bvopkMN+1wl/3LUw8CnHrbbx0m/JV
         5N0NdFAXR4D0lS4xis0/M4j27SWc1trbwRfphPI8o+NFuuHEq9EUoxNyCo2Ffvc04fHR
         vRSHvYWqhZA8vS9QJZofNdQuiGz3YfG4ZR5gg8UHPjcoaW1J5knoFvo6dp/+vU6rvH7J
         ceV7R3kjPSR9TVpFWkVOrckQxFNP1/gOek3TBfAuoFSUiAly2ktFtrcyXOgof7iEbU5X
         IBH+lGQHvugh6Fzuzg/G2zAglVS8KSGQi8T4597RkoINsvUufJBNX+HL3pW6hPyOVbQQ
         uHdg==
X-Gm-Message-State: AOAM531Qvr4mP4pddtR6kiXSlWltYY9KBKfWzdHcLb2sDbb2ao3/lIbC
        nl/QQavM5TXRe6iKh5YjICMwW8kZpu0NNl+eDE0=
X-Google-Smtp-Source: ABdhPJw5hOyRGBO3EOfmnPeiZn6PVwVwAhymJAGVrKrF/Q3agWq4Q5PWrxJlXiqfNGqIqSHgjHXArh6NgMLdbyl1Tdc=
X-Received: by 2002:a19:5d57:: with SMTP id p23mr3624412lfj.94.1590733641061;
 Thu, 28 May 2020 23:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <1590613362-27495-1-git-send-email-jrdr.linux@gmail.com>
 <20200528110408.GJ30374@kadam> <CAFqt6zaKWBQTy9XfvxwVAvzGS+gz9Qv1gL8Bv1VxLq+THYf+Aw@mail.gmail.com>
In-Reply-To: <CAFqt6zaKWBQTy9XfvxwVAvzGS+gz9Qv1gL8Bv1VxLq+THYf+Aw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 29 May 2020 11:57:09 +0530
Message-ID: <CAFqt6zbtg0NWbAnDGPC0ZddEiTeohz=8JN+S_KxqM0bnnvar3g@mail.gmail.com>
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

On Fri, May 29, 2020 at 11:46 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, May 28, 2020 at 4:34 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Thu, May 28, 2020 at 02:32:42AM +0530, Souptick Joarder wrote:
> > > This code was using get_user_pages_fast(), in a "Case 2" scenario
> > > (DMA/RDMA), using the categorization from [1]. That means that it's
> > > time to convert the get_user_pages_fast() + put_page() calls to
> > > pin_user_pages_fast() + unpin_user_page() calls.
> >
> > You are saying that the page is used for DIO and not DMA, but it sure
> > looks to me like it is used for DMA.
>
> No, I was referring to "Case 2" scenario in change log which means  it is
> used for DMA, not DIO.
>
> >
> >    503                          /* Map the page into DMA space. */
> >    504                          ptes[i].dma_addr =
> >    505                                  dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
> >    506                                               DMA_BIDIRECTIONAL);
> >
> > To be honest, that starting paragraph was confusing.  At first I thought
> > you were saying gasket was an RDMA driver. :P  I shouldn't have to read
> > a different document to understand the commit message.  It should be
> > summarized enough and the other documentation is supplemental.
> >
> > "In 2019 we introduced pin_user_pages() and now we are converting
> > get_user_pages() to the new API as appropriate".
>
> As all other similar conversion have similar change logs, so I was trying
> to maintain the same. John might have a different opinion on this.

For example, I was referring to few recent similar commits for change logs.

http://lkml.kernel.org/r/20200519002124.2025955-5-jhubbard@nvidia.com
https://lore.kernel.org/r/20200518015237.1568940-1-jhubbard@nvidia.com


>
> John, Any further opinion ??
>
> >
> > >
> > > There is some helpful background in [2]: basically, this is a small
> > > part of fixing a long-standing disconnect between pinning pages, and
> > > file systems' use of those pages.
> >
> > What is the impact of this patch on runtime?
>
> I don't have the hardware to validate the runtime impact and will
> wait if someone is going to validate it for runtime impact.
>
> >
> > >
> > > [1] Documentation/core-api/pin_user_pages.rst
> > >
> > > [2] "Explicit pinning of user-space pages":
> > >       https://lwn.net/Articles/807108/
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > >
> > > Hi,
> > >
> > > I'm compile tested this, but unable to run-time test, so any testing
> > > help is much appriciated.
> > > ---
> >
> > The "Hi" part of patch should have been under the "---" cut off line so
> > this will definitely need to be resent.
>
> Sorry about it.
> Will wait for feedback from John before resend it :)
>
> >
> > regards,
> > dan carpenter
> >
