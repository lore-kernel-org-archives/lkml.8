Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF812C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B40206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYU7Fc2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCLIk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:40:57 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:32938 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCLIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:40:57 -0400
Received: by mail-pj1-f67.google.com with SMTP id dw20so517992pjb.0;
        Thu, 12 Mar 2020 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B66v4eXPQ7K83ouJ2mPSLQXCELI/fDI8PZuRhUCkLnE=;
        b=TYU7Fc2fKR+lYRhdC12JYyZExBYrzc3NrCl6ugsTHfm8MzFBfhvhUw+s6jbUgTo+R+
         fDraAnZ+8JGEkVg+ImFpwiwiewaq+qaHw0CrmmgNCR8VyNfrVwQ/CQYEhIp493bdEoYP
         m2F/HdSYgp9LccmIbihcO6NjIJ+omW9sm28hz+JjxXEBJerHu6L2FRWNID1pepwD5AYM
         dIsldxeMszGF09fsj3Vc0AE+MZGMTmO6NQApXPZ2zaQrEo0mZ7Us6GxQa7p004K0mwkZ
         xTnixzieTBUen4tV/j0C2YQM/sbdrtSc9S0NMMKAraw/NkxTB84MvcAqRD7AmOUJKAaS
         d3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B66v4eXPQ7K83ouJ2mPSLQXCELI/fDI8PZuRhUCkLnE=;
        b=A95dgAVs25IiPOof0m05hd+ACwXXdI5BTJ3GiJDteib9RsA3H4bgLcUm+xS/2iF6bh
         JQGuWCRfaGRnlb43jaLpV87gDCbWFevSvxmpput0c4qoNc+rk2RnYdpFrCmNbosrpcGB
         XdbHd1ymy72T4jGyOFP0mVMzhiPIv+5lZ30L/0YhPTM0QljQne4PGvvUNT+bSZksk7a7
         ONsJOiwxN6AsCM0RHinl6mD9494ZqfvG3qtEBNnCL5F+fVakqp1wdklce2BJNIGlHlLc
         Pe7PPYbWiQqGklOVa2UrAjpj/RKw2Dw+6AaIzIQhg/sPBvzbVFEA2lBsqVGddHu5a+A0
         iMXg==
X-Gm-Message-State: ANhLgQ32ry3e8UXbSNh5fJ9r66eVeZmSOQbQwMv1e+fiCUYj4nWVmrsH
        VrvJDhabHMt99G8mRrcMDsO7zeOjyODSGtxR7UY=
X-Google-Smtp-Source: ADFU+vuCKsscjSBeYXkw3i4mhPJxhdDEyr6X9XyMUb7h5TIyA/i3v2HoTj6+Kfbm9VvcmM/QGsM3gb/gwmJ8NJ7ImUc=
X-Received: by 2002:a17:90a:77c3:: with SMTP id e3mr2939586pjs.143.1584002454410;
 Thu, 12 Mar 2020 01:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200311125135.30832-1-ple@baylibre.com> <20200311125135.30832-4-ple@baylibre.com>
 <20200311135535.GQ1922688@smile.fi.intel.com> <20200312005333.GH1639@pendragon.ideasonboard.com>
In-Reply-To: <20200312005333.GH1639@pendragon.ideasonboard.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 Mar 2020 10:40:46 +0200
Message-ID: <CAHp75Vc8oREKpiz6pR_QiTDHbymh-KKEP5ZzcT8iDJhZs=0bMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm: bridge: add it66121 driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phong LE <ple@baylibre.com>, narmstrong@baylibre.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>, jonas@kwiboo.se,
        jernej.skrabec@siol.net, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        heiko.stuebner@theobroma-systems.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>, icenowy@aosc.io,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 2:56 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Mar 11, 2020 at 03:55:35PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 11, 2020 at 01:51:34PM +0100, Phong LE wrote:
> > > This commit is a simple driver for bridge HMDI it66121.
> > > The input format is RBG and there is no color conversion.
> > > Audio, HDCP and CEC are not supported yet.
> >
> > I guess you should have been told in your company how to use get_maintainer.pl
> > to avoid spamming people.
> >
> > Hint:
> >       scripts/get_maintainer.pl --git --git-min-percent=67 ...

> I didn't even know about those options...

Doesn't one usually look at the help of the tool they are using?
How does one know what it does by default?

> I don't think we can't expect
> contributors to know about this if it's not even documented in
> Documentation/process/.

This is indeed not good and there is room for improvement.

> And even in that case, if this is what every
> contribution should use by default, then those options should become the
> default for the get_maintainer.pl script.

I don't think so. There is a common sense rule in play.
By default get_maintainer.pl shows the roles of the people, so, when
one puts the name at least they may read what the role of the
recipient in question. If I see too many people in the list (let's say
4+), I definitely will start looking for the explanation why.

-- 
With Best Regards,
Andy Shevchenko
