Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1428C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB91206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wqwy9L9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgHaS7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgHaS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:59:53 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7A8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:59:52 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id k1so1546483vkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XI7WTXEoNDr6yrW+/3unS7LStf8ebQusfThr5xGI4zk=;
        b=Wqwy9L9n/OUk4gjZDudQ9QhnD/IsXYbNiskPu0nk5MevQ5/Ew/+erPNJea/PAhoNqf
         BwWEkWVfmVpAn8eHuH7JQsvye0ijOC7173twOO7hZZiaO3duVVemOpQHsvn2xtb8bLLy
         4jQqqsnUX4Lb/Yhd4LN4bwBFx29khiq8KS/Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XI7WTXEoNDr6yrW+/3unS7LStf8ebQusfThr5xGI4zk=;
        b=OvOwRh27ICHMUugT0xtjAutqyptjqXqHCVJ5QoI4v0isj2GXptety3+THm0c5KoKc5
         zGLzdtFU9Epr1sHfvgYphd47oPutbqDbWKgpqpCZlU7t6mfj7mYi1Rf3fafBA49h8EpG
         JmGQm5bYqIqQIOc7fO1iQbAMMB9tmSOzmbWC2BoKMZgt1q2XYPDGbmJwDLtuXAC/dh5s
         myxGpYB7Q5M0RO6FP2ukUThGbYqNWQn+iUviYPj7JDeXiJUaGmqIc6Gohm6TKRAwdTbL
         7bQAF831Pak7gSNYVvfrMk3fuJhm1tGF/nPCQZHmgz+IUn6O7uLz4ggWH5JraQDxtSCk
         Ttjw==
X-Gm-Message-State: AOAM531VasuExGZ9LweMEC2UqUF0jazYjco2X8WlNp3jRhtEKNZ7+qBI
        YXRIUUhMms5+qCYqizkyIe8ZEelU8Gpbkw==
X-Google-Smtp-Source: ABdhPJyYh2Z8pWunB0fk4Yz6YUbDjVo3YP2LCnG7KNHF+r3frL/wJ5xY74OZ3+O2tp59o0XuIw2btg==
X-Received: by 2002:a1f:1c13:: with SMTP id c19mr2283798vkc.81.1598900391618;
        Mon, 31 Aug 2020 11:59:51 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id q74sm1538442vkq.31.2020.08.31.11.59.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:59:50 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id b123so3016277vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:59:50 -0700 (PDT)
X-Received: by 2002:a67:b345:: with SMTP id b5mr2540647vsm.45.1598900389671;
 Mon, 31 Aug 2020 11:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
 <20200829161230.398e0051@archlinux> <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com>
 <20200829181754.52d3cc3b@archlinux>
In-Reply-To: <20200829181754.52d3cc3b@archlinux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 31 Aug 2020 11:59:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VWrXwDwoxBK9y2ZeFEoG-edO4WktdSW0MFZLfbcS2hLQ@mail.gmail.com>
Message-ID: <CAD=FV=VWrXwDwoxBK9y2ZeFEoG-edO4WktdSW0MFZLfbcS2hLQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Prefer async probe
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 29, 2020 at 10:18 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 29 Aug 2020 09:56:41 -0700
> Doug Anderson <dianders@chromium.org> wrote:
>
> > Hi,
> >
> > On Sat, Aug 29, 2020 at 8:12 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Fri, 28 Aug 2020 17:01:18 -0700
> > > Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > > On one board I found that:
> > > >   probe of 5-0028 returned 1 after 259547 usecs
> > > >
> > > > There's no reason to block probe of all other devices on our probe.
> > > > Turn on async probe.
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > > NOTE: I haven't done any analysis of the driver to see _why_ it's so
> > > > slow, only that I have measured it to be slow.  Someone could
> > > > certainly take the time to profile / optimize it, but in any case it
> > > > still won't hurt to be async.
> > >
> > > Hmm. It is vanishingly rare to use that flag
> >
> > My guess is that people just haven't been spending as much time
> > optimizing boot performance recently.  I've been trying to do this and
> > finding that there are quite a few drivers that could benefit from
> > this flag.
> >
> > In theory this flag should probably be on by default and it looks like
> > that was Dmitry's original intention but the state of the world 5
> > years ago was that it wasn't quite ready for this.  I think, in
> > particular, drivers that are more core to the system (IOMMUs, clocks,
> > regulators, etc) may not have been ready, but misc peripherals should
> > be no problem.
>
> That fits with my understanding.  Would be great to have it on
> by default though I guess it could make for some really hard to debug
> race conditions.

One other note that I should have mentioned: anything that's buildable
as a module is essentially already testing this path.  Modules are
probed asynchronously and in parallel.  Possibly the solution for my
boot speed woes in this case is to just build this as a module since I
don't see any immediate need why it has to be builtin (so with that
realization I may not actually need this patch).  That being said, it
still seems nice to enable async probe in case someone has a reason to
build this in.


> > > so I'm not particularly
> > > keen on starting to deploy it when we don't know why a particular
> > > driver is taking so long.  I agree it should be safe but I don't
> > > like oddities I don't understand!
> > >
> > > There are some sleeps in there but they are all of the order of a few
> > > msecs.
> > >
> > > Could it be there is a regulator that is coming up very slowly?
> > >
> > > Any other ideas?
> >
> > I can do a little bit of profiling next week, but even if we get this
> > down from 250 ms to 10 ms I'd still like to see async probe turned on.
> > There's no reason for it to be off and every little bit counts.
> Agreed. However, I'd like a comment next to the place we turn it on
> saying what delays we are trying to mitigate by enabling it in this
> driver.

OK, I used function graph to get a trace.  Some of the time is simply
i2c transfers, which we do A LOT of during initialization (and i2c
transfers aren't known for being instant).  However, that's not the
big problem.  Check out the regmap_read_poll_timeout() in
sx9310_init_compensation().  20 ms per sleep with a 2 second timeout.
This seems to eat over around 220 ms of the time on my system.

So how do you want to do this?  Do you want me to re-post the patch
and mention the regmap_read_poll_timeout() in the commit message?  Do
you want to just add that to the commit message yourself?

Thanks!

-Doug
