Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF61C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B3D207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H2NcxoBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgHCT7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgHCT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:59:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:59:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 77so4034648qkm.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMr7j5kP6nex1WMLIUbWVtJxCoXdAe6Xx/9JM/a5res=;
        b=H2NcxoBrl7r69IvVi/9x92XDg1z7WmHdxs423ix+1AoNv23v0/+F7C9fxhaZqBhmDY
         CxtGBXCgtUn3x6dBNx0wBPYs1hRQlHmXDqw796NAbW03Q0aTuNpRESxJWOlaARyh5+1O
         43E5lh12SZ8yDmVmtCuZDQhRedmezpD3g42/HlJYut9lf2g3+rPnosbdvnQBywTKf+eP
         m4ifV99w/5uUmTNKap4TSizuU2qnfvob1O4EBwbkQAXfffGlVWjkMD1AC9B/1Y5+m+pj
         bQKhhpC/5JB1XhhN9nkW/Fnuk0yg1m3XYTRHpTAaMWWQoK2HRp5bN19Lq5Z3DzdwDPWT
         /MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMr7j5kP6nex1WMLIUbWVtJxCoXdAe6Xx/9JM/a5res=;
        b=KWWqyyZ4sbClrBAOeIeh80XFjOlJK4vWdwS07RiYS8Yk9M08ueQJsQY8YwTKGxQvnJ
         bVu2ZUFBf7qQ9OvSwRSOK1ZsCbUjK+7PL0rApGRRNfQLrCOfcJAXIDmOBvL5nnStWg3g
         1MhLxlckoOJWNGLGfaLmIKrAcK1Q8lABqOp8v18tOcuQ7vjd63fIv2GrTXif1Eijz0S/
         /M8ny3dra70O8z1cxmYIHk+YxR7CFPiyHd8zX0+iupDZ1YhANW21RQU7WYThGXksYTCa
         pb9K4HuDKyUbO3MWdvyYE4zuSyh3Oph/uija3ifRkNEPmX/gnP1daP6PrG2n8fLpSXx5
         tetA==
X-Gm-Message-State: AOAM531RId9QjPRNLahAGt0UVw/8yZ6utruBDqeXS9zwTylUYp/ImPag
        WpbgbIGywL1Afg/TuF5CyDyl90I2tbJZgodCcabv2w==
X-Google-Smtp-Source: ABdhPJxDymFtZNgAnIJdxzvntCOIeqaOzyfwThGdou91UTBOOSVRS5gDgOWCrSjkXiDJGqr25BEvUWV5FAElompEqZw=
X-Received: by 2002:a37:a495:: with SMTP id n143mr18005291qke.330.1596484778138;
 Mon, 03 Aug 2020 12:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-6-warthog618@gmail.com>
 <CAHp75VcKtATPDKGAViWqjOJDqukDrgZ13aTU6rTJ1jEeB3vmVw@mail.gmail.com>
 <20200726011244.GA6587@sol> <CAMpxmJWaEVwjXSFHTYmwdfA+88upVkJ4ePSQf_ziSOa1YdOUKQ@mail.gmail.com>
 <20200802033158.GA13174@sol> <20200802093242.GA23877@sol>
In-Reply-To: <20200802093242.GA23877@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 3 Aug 2020 21:59:27 +0200
Message-ID: <CAMpxmJWD9mA_=+8QGq4iQgahEqh39m=7QkmTcMN_Q5XkBZys6w@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] gpiolib: cdev: support GPIO_GET_LINE_IOCTL and GPIOLINE_GET_VALUES_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 2, 2020 at 11:32 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Sun, Aug 02, 2020 at 11:31:58AM +0800, Kent Gibson wrote:
> > On Fri, Jul 31, 2020 at 06:05:10PM +0200, Bartosz Golaszewski wrote:
> > > On Sun, Jul 26, 2020 at 3:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > >
> > > > >
> > > > > > +               dev_dbg(&gdev->dev, "registered chardev handle for line %d\n",
> > > > > > +                       offset);
> > > > >
> > > > > Perhaps tracepoint / event?
> > > > >
> > > >
> > > > Again, a cut-and-paste from V1, and I have no experience with
> > > > tracepoints or events, so I have no opinion on that.
> > > >
> > > > So, yeah - perhaps?
> > > >
> > >
> > > I think it's a good idea to add some proper instrumentation this time
> > > other than much less reliable logs. Can you take a look at
> > > include/trace/events/gpio.h? Adding new GPIO trace events should be
> > > pretty straightforward by copy-pasti... drawing inspiration from
> > > existing ones.
> > >
> >
> > You only want tracepoints to replace those dev_dbg()s, so when a line
> > is requested? What about the release?  Any other points?
> >
>
> Had a closer look and it seems to me that the correct place to add such
> tracepoints would be gpiod_request() and gpiod_free(), so they catch all
> requests, not just the cdev ones.  And that moves it outside the scope
> of this patch.
>
> I personally don't have any use for the dev_dbg()s here and am happy to
> remove them - they were only there to match the behaviour of
> linehandle_create as closely as possible.
>

Sounds good, we can work on trace points separately.

Bartosz
