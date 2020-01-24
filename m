Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FDEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4272077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTcjbOvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbgAXNod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:44:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34637 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387395AbgAXNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:44:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so2503315ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 05:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=681bijGOIP3KrNVYlf7XkoIYiFDmMZfImCEes87J83I=;
        b=oTcjbOvt2QwnfWqSnATqp2zVWdsVZ51rbeM+d8pbBnSkiApH3bYFOZfKDfEGx6FO+G
         mYlAloxHhhNRQLah4UBHVhUU8AUEtv6XcIMrmUNfdNZv9jNAInESI50YFUDcNPtV4Xi4
         OrgSU86GukM3ULzXtbjrowjwViPZPvgdp2BcL7Sal2VT2Q/TUe4IzctfY6v96i/Z3Xud
         aDD+QXEDSr/lSx3qX0m8X8QpYaUmYiPHRagsJcSywkEWK2Af2J71+4t9zaDJd2SFwYLd
         k9CvtH08twDnbKGbr8i2Cu0QrC1GH2/3X7geYSu6YV5vLj944gzlZKt0cLgo2xtF9ydD
         o1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=681bijGOIP3KrNVYlf7XkoIYiFDmMZfImCEes87J83I=;
        b=MvKbt2Kzqni6gvwqVjwe08zQoV+jVZ51zr267AV9uVywFySyZrKvQDSQtHKKjVhKqf
         v1Zd6MO28qjDfAS0wpIuPbC/1e2N+KlhfAx+QIkHUoEBHV+CTtOTWXZlWfTenyhHWZ7W
         2TQ+keyBEDHzmAE7PMEey60+9gcm/3mZWUCUDCk7W+a+bw9GvVhuCExz+N7JEVYaI5Ib
         7RpvfmIgEZCyTkGu1v2tkkwrVDKutB7OJnezl0Kq6mqAnVNudsoZjDohqmhM8IfgcMgg
         Hr/w5dhobN2I2A4O0r/Wtri9r94YpiwzeMH6n8y874QIk1tYddTggLi5mB2F7ETZw1PX
         6BJQ==
X-Gm-Message-State: APjAAAWdj/QxPw4xNPheROwAWhoDyNpS4Y2X2v9L4z+1ZU+OCxvUi546
        g/IAkAEjS0AZ3i/DXdOb7zVimWqiotqDY28WCfekwd3JR24=
X-Google-Smtp-Source: APXvYqxKj+jQyHTEX8XdhkCaTtOQNA+Qsr+/i1PQ2T9UmGbxGq6uGQ3G6xTY/FfpoQZjMCnID8Y5fSCr4cghZiVQSA0=
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr2254281ljo.125.1579873471268;
 Fri, 24 Jan 2020 05:44:31 -0800 (PST)
MIME-Version: 1.0
References: <5e2ad951.1c69fb81.6d762.dd8e@mx.google.com> <0ed4668a-fb29-fca8-558e-385ef118d432@collabora.com>
 <20200124131821.GA4918@sirena.org.uk>
In-Reply-To: <20200124131821.GA4918@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Jan 2020 14:44:19 +0100
Message-ID: <CACRpkdYdX-k+YT5wmyRzDnvaziwEDhYe82r3V2WOW6tyvNomFg@mail.gmail.com>
Subject: Re: stable-rc/linux-4.19.y bisection: baseline.login on sun8i-h3-libretech-all-h3-cc
To:     Mark Brown <broonie@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        mgalka@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 2:18 PM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 24, 2020 at 12:58:32PM +0000, Guillaume Tucker wrote:
>
> > Please see the bisection report below about a boot failure, it
> > looks legit as this commit was made today:
>
> > >     Fix it by ignoring the config in the device tree for now: the
> > >     later patches in the series will push all inversion handling
> > >     over to the gpiolib core and set it up properly in the
> > >     boardfiles for legacy devices, but I did not finish that
> > >     for this kernel cycle.

So here the patch clearly says it is for "this kernel cycle"
which I feel implies that it is NOT for any previous kernels
stable or not...

I'm sorry if I missed the "look at this thing that we will
apply to stable soon" mail, sadly there are just too many
of these for me to handle sometimes. (Maybe it means I
am making too many mistakes to begin with, mea culpa.)

> > >     Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> > >     Reported-by: Fabio Estevam <festevam@gmail.com>
> > >     Reported-by: John Stultz <john.stultz@linaro.org>
> > >     Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > >     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > >     Tested-by: John Stultz <john.stultz@linaro.org>
> > >     Signed-off-by: Mark Brown <broonie@kernel.org>
> > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Oh dear, this is another bot backported commit which I suspect is
> lacking some context or other from all the other work that was done with
> GPIO enables :(

This AI seems a bit confused :/
Maybe it is the prolific use of the word "fix" that triggers it?

Yours,
Linus Walleij
