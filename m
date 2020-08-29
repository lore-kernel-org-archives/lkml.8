Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB2EC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C9920791
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cj8IjmMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgH2Q4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgH2Q4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 12:56:36 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D6C061239
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 09:56:36 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n12so454649vkk.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pl7qQnWrPptXiF3yjs+XH+IkHtabV/XWURgR7SO1Is=;
        b=Cj8IjmMw3DIOR1s9zIW08aC8jlgO1KSG7gdKyG/JAfErgThgMtdWKiCBuel8bmL8aN
         pkYJnMlJEKXcwoGVdabePZTXNVEDgmehjEqA2GdpL5N1mqjauz9oCpVD44sZsCdAwR8l
         76UjA+2MyqlnDxXMhVa3LFHxBYp4EYqO7I1Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pl7qQnWrPptXiF3yjs+XH+IkHtabV/XWURgR7SO1Is=;
        b=TnQVxqi6WsPmF6Dpq1Nvt3WCWGI6+ZfRRv3ZmR91f1XNyzMHvlrm7gP+9vdhgy+yLA
         y9SK+8W6WKBEINJF/72HEKhHPrRxI04v+HYS5FfhPhH42c29xEU9j0/G6l+psStIbI7e
         pqZxGNJvMbw+5T7C7jH0gIACtly8Ra5HUd154lvWLp4O4Fg2PpUBifB/GrFfaFv48SGS
         t73XD9xHDYQ+oUHa7tO4S9nqQKkQQod1eITDBlAl51Rct9CT0bRGjv15arowKKcvaBUP
         TVIW/Rkw94cHZRliAxr0ZTmoHBdk4MwIPtsUumAzC1E5zTiPKsvXf8L1ySj7aY5Y1a+r
         hxsQ==
X-Gm-Message-State: AOAM530ra/OFO3elO2Fss3soP3nOB31Uka5peHZkMSD7Mb7OdAQKCVQf
        czIH/xnb988e2ZUt0VvwLA+rTjZt+wWpOA==
X-Google-Smtp-Source: ABdhPJx7rXKJZvntQxT5pgY0CEdQIDPP0h8ebUwLGsqBEvXd4iHUBz5ILD0S+Q1lGAjvNeWj9H22nA==
X-Received: by 2002:a1f:9b8f:: with SMTP id d137mr2294315vke.97.1598720194523;
        Sat, 29 Aug 2020 09:56:34 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id n8sm519690vkk.13.2020.08.29.09.56.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 09:56:33 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id v24so734558uaj.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 09:56:33 -0700 (PDT)
X-Received: by 2002:ab0:37d3:: with SMTP id e19mr2181153uav.64.1598720192750;
 Sat, 29 Aug 2020 09:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
 <20200829161230.398e0051@archlinux>
In-Reply-To: <20200829161230.398e0051@archlinux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 29 Aug 2020 09:56:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com>
Message-ID: <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com>
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

On Sat, Aug 29, 2020 at 8:12 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 28 Aug 2020 17:01:18 -0700
> Douglas Anderson <dianders@chromium.org> wrote:
>
> > On one board I found that:
> >   probe of 5-0028 returned 1 after 259547 usecs
> >
> > There's no reason to block probe of all other devices on our probe.
> > Turn on async probe.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > NOTE: I haven't done any analysis of the driver to see _why_ it's so
> > slow, only that I have measured it to be slow.  Someone could
> > certainly take the time to profile / optimize it, but in any case it
> > still won't hurt to be async.
>
> Hmm. It is vanishingly rare to use that flag

My guess is that people just haven't been spending as much time
optimizing boot performance recently.  I've been trying to do this and
finding that there are quite a few drivers that could benefit from
this flag.

In theory this flag should probably be on by default and it looks like
that was Dmitry's original intention but the state of the world 5
years ago was that it wasn't quite ready for this.  I think, in
particular, drivers that are more core to the system (IOMMUs, clocks,
regulators, etc) may not have been ready, but misc peripherals should
be no problem.


> so I'm not particularly
> keen on starting to deploy it when we don't know why a particular
> driver is taking so long.  I agree it should be safe but I don't
> like oddities I don't understand!
>
> There are some sleeps in there but they are all of the order of a few
> msecs.
>
> Could it be there is a regulator that is coming up very slowly?
>
> Any other ideas?

I can do a little bit of profiling next week, but even if we get this
down from 250 ms to 10 ms I'd still like to see async probe turned on.
There's no reason for it to be off and every little bit counts.


> Jonathan
>
> >
> > This is a very safe flag to turn on since:
> >
> > 1. It's not like our probe order was defined by anything anyway.  When
> > we probe is at the whim of when our i2c controller probes and that can
> > be any time.
> >
> > 2. If some other driver needs us then they have to handle the fact
> > that we might not have probed yet anyway.
> >
> > 3. There may be other drivers probing at the same time as us anyway
> > because _they_ used async probe.
> >
> > While I won't say that it's impossible to tickle a bug by turning on
> > async probe, I would assert that in almost all cases the bug was
> > already there and needed to be fixed anyway.
> >
> > ALSO NOTE: measurement / testing was done on the downstream Chrome OS
> > 5.4 tree.  I confirmed compiling on mainline.
> >
> >  drivers/iio/proximity/sx9310.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index dc2e11b43431..444cafc53408 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -1054,6 +1054,7 @@ static struct i2c_driver sx9310_driver = {
> >               .acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> >               .of_match_table = of_match_ptr(sx9310_of_match),
> >               .pm = &sx9310_pm_ops,
> > +             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >       },
> >       .probe          = sx9310_probe,
> >       .id_table       = sx9310_id,
>
