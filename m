Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B0FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13DA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pavvz+Fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgHDHjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgHDHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:39:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0145C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:39:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t6so1539139pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bUrPosWpbtUZGITpvnlHaTi7khIGfAqisN4TaUAkCAE=;
        b=Pavvz+FooPxe5h/5VDGo9c4Zqz16bgtEwD8V/rIC6jRcmkXDzkMZP9aWi2Jn95G93Z
         5pbFR5GPK5OyIIAy3AhSc23Kixg/Putnz1htPQUk7OmNcBBpaF5y7bPxDpuhtvFnx6mU
         vftTrbowyZZkyRTg03tMsEiPJgke6IGpEIcrecBx9rhUhrlvnFbgAG88UI7xoG6S7kMN
         A1AlVHrGIrPF9D83O38YZPJjdBUkX2qRlYQjaSzGHRiFk/JyPT1nKlNaWdD6BY6JXtqm
         +veqW2flCbTe7MASrs0MuGHk67tV/CJowYkbNdrKJb1l+r3d83uO2kfc2sLl0sdH0LSc
         c2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bUrPosWpbtUZGITpvnlHaTi7khIGfAqisN4TaUAkCAE=;
        b=cE7MWoKVsqG90ATAzB91yDO1qtySDf7Ntqtvv0EJZh1UE5uEZzqSpyxSRPNwqAoIT9
         A+hRpQqKzdnJtMKAILCbWXpp6x2daPsjF1UuIIabVy2NsKbhtif96ct88OxXYGtaMiOU
         dMEf0b+zbxDHUO6cimd8UQmR1A5dpjtGU4wpwJNKjReZfedCmActZWX9Plv+Rv5+/kWq
         cNGWiSs92DuWclO5GsZufh0TMSabG0hVpB2cbuafsXrYTJAQSOwDfD1J4a3qTeGiF73f
         iDFCDkqv3UJ2gqETNgxhMN26/IJSeObPJfwtshb982rnbN2XvwbBw5QWY7YPe8u2FCeq
         lT/A==
X-Gm-Message-State: AOAM5325DXUEjz8FIEZmP1xOpPtyEOGOQyDMEeOTFyZvUbsYrqhz9/jV
        uEZLy8X/ORsR7Le2FownfUZFU+mrD3gQAoVjwnE=
X-Google-Smtp-Source: ABdhPJxKhp0KbfInWbfMcpcBEQhF6c+PPuWTjPfHws+fWHsolyRuqos5w/qy91+QMtSQaRgWq1w0LTLFvWsgHpr7Mhc=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr3285472pjp.228.1596526791226;
 Tue, 04 Aug 2020 00:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <CAK8P3a2B5cxE512R0-ni6BJOnkgR7kGueqd3AU9E2PXh0unsmg@mail.gmail.com>
 <CACPK8Xd++ZQx9hh21dV6qn73aoWvoFsOHq8Pmgbtpi-GD3ShmA@mail.gmail.com> <CAHp75Vc8yXqCsZ79=YWZLJ3ObgA1AYLj0eqqK0e8sXvMWsf+Hg@mail.gmail.com>
In-Reply-To: <CAHp75Vc8yXqCsZ79=YWZLJ3ObgA1AYLj0eqqK0e8sXvMWsf+Hg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Aug 2020 10:39:34 +0300
Message-ID: <CAHp75VcadLh+hM244agKKif_QeSj1osHMzuC8wv9UVFo7diX5w@mail.gmail.com>
Subject: Re: [GIT PULL 3/5] ARM: SoC changes for v5.9
To:     Joel Stanley <joel@jms.id.au>
List-Id: <soc.lore.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 10:33 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Aug 4, 2020 at 10:02 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Mon, 3 Aug 2020 at 21:49, Arnd Bergmann <arnd@arndb.de> wrote:
> > > ARM: SoC changes for v5.9
> >
> > > Andy Shevchenko (1):
> > >       ARM: orion/gpio: Make use of for_each_requested_gpio()
> >
> > This change broke the arm build (I noticed it when building multi_v5_de=
fconfig):
> >
> > ../arch/arm/plat-orion/gpio.c:457:2: error: implicit declaration of
> > function =E2=80=98for_each_requested_gpio=E2=80=99
> > [-Werror=3Dimplicit-function-declaration]
> >   457 |  for_each_requested_gpio(chip, i, label) {
> >       |  ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > for_each_requested_gpio isn't in Linus (Torvalds) tree yet. It will be
> > fixed when he pulls Linus Walleij's GPIO tree which has the commit:
> >
> >  b3337eb24831 gpiolib: Introduce for_each_requested_gpio_in_range() mac=
ro
>
> Linus W. specifically created an immutable branch [1] for this.
> And I think I commented somewhere that entire branch should be pulled.

https://www.spinics.net/lists/linux-gpio/msg51186.html

Sorry if that message wasn't clear.

> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.gi=
t/log/?h=3Dib-for-each-requested

--=20
With Best Regards,
Andy Shevchenko
