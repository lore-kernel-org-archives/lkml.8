Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C760C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C669208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="irPk9OAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgGaQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGaQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:05:25 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:05:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so27528178qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJ0HxIO19zuh/BCile5ciVzrChACJ4nss4fnAlpEei8=;
        b=irPk9OAIjwCpLYNERM18sQ5GsjG/gkATuf/brjxgtq4Hh9hZ1LtL6g/RhkiNUlg+uv
         2+dJfDa7uWwLSVSrLjcKEfqNqx6ya0bG4bRnaLuJVUKtoMD9xZAc4k5hRUBEFWYUz+zu
         ofDhBVNfEzXuHWLZ+pRAoyUdRnKbIoc2DD88Gxcw048VsCghzcvqvAXKOg4l4+++oeRC
         /2gXr/LLk+Ask5XyqUik1t1jTSktqUEq9ITVpMsFIpKfZb3lflyD3QPumu45pK0bHmBZ
         Jmr+kHrNqB6/WRkDvMiiNLgZANJokVVuw5GUMPWE4wepTNvFleLFI2kznaXh/Rvx6Uct
         2t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJ0HxIO19zuh/BCile5ciVzrChACJ4nss4fnAlpEei8=;
        b=DxEA/N7zpkVpDeid2Q5C2/Rb3CJuGqP776zDtDavIE2ptzI5cTnrcpb5L+52xGrN3K
         9VrAVsPaW0Zm3tMrqybaSjdcPtWX9hTc/vrWJKTLzK4NmBzTz1VtiontMPy2SWXzjxWs
         /03Ra38MaUKSyVAXYncgNbDD9FsKzov7oIOp1G9iSBR4x9ktrSIgpC9hsa7ECibdLKiT
         YmNFP5N+bjV1xE+bY4+7vpWO4pLMP9F+2DCPYrgyLuEGowlovJVDjRLBX5st0YV7KLSt
         AEQpLQmIUWB66puEWnBFTOVgFnM0KqqyIhng0G2UTzzI9y37tAwh4f1ZyHvyzC5X8sHr
         Ruuw==
X-Gm-Message-State: AOAM533mve+mxmswUEUyO3ab5LYv6J7pvcMLplDUACDBCSn86PqE/jmu
        szGZ5NjqTp7YxSMV+6kKSoQeREe4j15s8QL4b1QIRg==
X-Google-Smtp-Source: ABdhPJxV0FzkxA4fVoAWc8//zRggX2lqtk+yX0xqqAI+cYax2el1LWoMt8QhEubFfwqynJs6sXrnPw0NVOZuNPZnYnw=
X-Received: by 2002:a37:b907:: with SMTP id j7mr4920632qkf.120.1596211522481;
 Fri, 31 Jul 2020 09:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-6-warthog618@gmail.com>
 <CAHp75VcKtATPDKGAViWqjOJDqukDrgZ13aTU6rTJ1jEeB3vmVw@mail.gmail.com> <20200726011244.GA6587@sol>
In-Reply-To: <20200726011244.GA6587@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 31 Jul 2020 18:05:10 +0200
Message-ID: <CAMpxmJWaEVwjXSFHTYmwdfA+88upVkJ4ePSQf_ziSOa1YdOUKQ@mail.gmail.com>
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

On Sun, Jul 26, 2020 at 3:12 AM Kent Gibson <warthog618@gmail.com> wrote:
>

[snip]

> >
> > > +static bool padding_not_zeroed(__u32 *padding, int pad_size)
> > > +{
> > > +       int i, sum = 0;
> > > +
> > > +       for (i = 0; i < pad_size; i++)
> > > +               sum |= padding[i];
> > > +
> > > +       return sum;
> > > +}
> >
> > Reimplementation of memchr_inv() ?
> >
>
> I was hoping to find an existing function, surely checking a region is
> zeroed is a common thing, right?, so this was a place holder as much
> as anything.  Not sure memchr_inv fits the bill, but I'll give it a
> try...
>

If you don't find an appropriate function: please put your new
implementation in lib/ so that others may reuse it.

> > ...
> >
> > > +static u64 gpioline_config_flags(struct gpioline_config *lc, int line_idx)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i = lc->num_attrs - 1; i >= 0; i--) {
> >
> > Much better to read is
> >
> > unsigned int i = lc->num_attrs;
> >
> > while (i--) {
> >  ...
> > }
> >
>
> Really? I find that the post-decrement in the while makes determining the
> bounds of the loop more confusing.
>

Agreed, Andy: this is too much nit-picking. :)

[snip]

> > ...
> >
> > > +               struct gpio_desc *desc = gpiochip_get_desc(gdev->chip, offset);
> >
> > I prefer to see this split, but it's minor.
> >
> > > +               if (IS_ERR(desc)) {
> > > +                       ret = PTR_ERR(desc);
> > > +                       goto out_free_line;
> > > +               }
> >
> > ...
> >
> > > +               dev_dbg(&gdev->dev, "registered chardev handle for line %d\n",
> > > +                       offset);
> >
> > Perhaps tracepoint / event?
> >
>
> Again, a cut-and-paste from V1, and I have no experience with
> tracepoints or events, so I have no opinion on that.
>
> So, yeah - perhaps?
>

I think it's a good idea to add some proper instrumentation this time
other than much less reliable logs. Can you take a look at
include/trace/events/gpio.h? Adding new GPIO trace events should be
pretty straightforward by copy-pasti... drawing inspiration from
existing ones.

Bart
