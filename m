Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE3BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DAD20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dh34nKlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgIAP1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgIAPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:24:00 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8E5C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:24:00 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id r13so537432uah.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sl6xTKnd+6daHkSEhbQjHuiEQNZLZpxXWMv9V9u96KA=;
        b=dh34nKlEn2j6kHaUg6yzucVPfcrbjuQju3XuCAI6NEr8TKKUdj1llwvyq2AZxA9XM6
         ZEAJo70uPOkiuxVcE75GsMiLrFsMEIHANUGUbg7bfwm7DDQSWMCTZxHkI7DOc5saXswU
         a7pXWa3ywwG6ki/PfxnmRpVL8Ce/wWRa0mRj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sl6xTKnd+6daHkSEhbQjHuiEQNZLZpxXWMv9V9u96KA=;
        b=QwVquv/vo79KnvNclAzCSHKqGqyCG1wivTVLMaZnRZj5fg9bBHnYabEnmb3hZVMNGq
         m6YLTJI1BdJtk3/9OLJEzpG/oNkpTTai1l0O5UUeIGpDifXtLTbwgG3YSEj0x/c45eE9
         Yw/TWpDMXk1wAXIpuHIBq5x1eou+dEmbkh6hLz3JFtUmF/yOV+/P3pksYwKAMXNt1yVF
         eBVKHARcFBVIvWOal5cAyn+o+El0GtgXU0OO9OQ0uCDFqcPl5YZYIUz3JEQduLFqn/GV
         228VpnSQEjwrbX1S0ILqCJIagFj9gCKnpS/Yqu7rUDw3eySkGQQBDLjb6nlHgoztLCwq
         03jQ==
X-Gm-Message-State: AOAM532ZNLNs1oS3v5cYxz3OmzSlKHtyNirc5UzQORPy0dhkvCtWQP+/
        wkcohJ7jUnovmh8KOnd1FbFay6mYU0B4Rw==
X-Google-Smtp-Source: ABdhPJzqyJ6/jyVIS2ObpMP87PGTa5t8ptdJrm1keC7rNWDUe9PByKWnWcB2+5buMTdc/R+wQbpW4A==
X-Received: by 2002:ab0:2249:: with SMTP id z9mr1893514uan.72.1598973839295;
        Tue, 01 Sep 2020 08:23:59 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id f16sm240910vka.7.2020.09.01.08.23.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 08:23:58 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id e41so545311uad.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:23:57 -0700 (PDT)
X-Received: by 2002:ab0:5e7:: with SMTP id e94mr1815731uae.104.1598973836853;
 Tue, 01 Sep 2020 08:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
 <20200829161230.398e0051@archlinux> <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com>
 <20200829181754.52d3cc3b@archlinux> <CAD=FV=VWrXwDwoxBK9y2ZeFEoG-edO4WktdSW0MFZLfbcS2hLQ@mail.gmail.com>
 <159894383586.334488.2938301456606601581@swboyd.mtv.corp.google.com> <20200901144520.0000576c@Huawei.com>
In-Reply-To: <20200901144520.0000576c@Huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Sep 2020 08:23:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vv++Sh_pGiG+g7qhB1wgD_O_5zXdcnS0fqcsSH5QC8kQ@mail.gmail.com>
Message-ID: <CAD=FV=Vv++Sh_pGiG+g7qhB1wgD_O_5zXdcnS0fqcsSH5QC8kQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Prefer async probe
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Tue, Sep 1, 2020 at 6:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 1 Sep 2020 00:03:55 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > Quoting Doug Anderson (2020-08-31 11:59:37)
> > > On Sat, Aug 29, 2020 at 10:18 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > > > Agreed. However, I'd like a comment next to the place we turn it on
> > > > saying what delays we are trying to mitigate by enabling it in this
> > > > driver.
> > >
> > > OK, I used function graph to get a trace.  Some of the time is simply
> > > i2c transfers, which we do A LOT of during initialization (and i2c
> > > transfers aren't known for being instant).  However, that's not the
> > > big problem.  Check out the regmap_read_poll_timeout() in
> > > sx9310_init_compensation().  20 ms per sleep with a 2 second timeout.
> > > This seems to eat over around 220 ms of the time on my system.
> > >
> > > So how do you want to do this?  Do you want me to re-post the patch
> > > and mention the regmap_read_poll_timeout() in the commit message?  Do
> > > you want to just add that to the commit message yourself?
> > >
> >
> > I think the suggestion is to put a comment next to the
> > PROBE_PREFER_ASYNCHRONOUS flag indicating that
> > sx9310_init_compensation() can take a while.
>
> Yup. That's what I meant. Sorry for lack of clarity.
> A comment in the code stops others copying it without making sure they
> understand whether it is relevant in their case.  No one is going
> to look in commit messages.

OK, posted.  I expect it'll show up soon at:

https://lore.kernel.org/r/20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid


> > Should the compensation be
> > delayed even further though to some time when userspace opens the device
> > node?
>
> It's tricky because we may hit it on an individual sysfs read.
> We could spin off a thread to do it I suppose, though that would be
> more or less the same as allowing async probe.

Also: even if we delayed the compensation further we'd still end up
with a somewhat slow probe just due to the metric buttload of i2c
transfers we do at probe time.


-Doug
