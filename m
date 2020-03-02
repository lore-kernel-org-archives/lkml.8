Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE554C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EC920870
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCBKOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:14:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36098 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgCBKOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:14:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id j14so4842104otq.3;
        Mon, 02 Mar 2020 02:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVlemy32h72Zpj8jVlIGq7eQAhoadA5R3segFYSq66w=;
        b=ELGPzNhp69sj+2oC0Y1Eh6u2+NdtJvFBULhKksN2+XrUtV4T+VM7c1VyjYFeARvPCl
         MftwjcW/5q6KANeXz9vVyYKrt2ehobZzpq5unUneP5GfA5HRh9jJIaVtXjAOCja1esd5
         1T1NeK7DFZuPphl+ztE9AK5jOrJ0rQDrWbN6IFsKhV/5RVe+gVgaZbg1+cdYI0B05u8p
         L7EP/dOckGuLud6inX6FUhKgjFwA+rOYEYMsFaYy/kx82qXISyVJgLEQxvB+9VmZE+IO
         LxmfuO4Plz+mRbwIY+OR2/gs4Gy6PJ7f38zhZ5nbXr5I/Zw88DGtI3JQ/KvG+d0HKqNx
         5HaQ==
X-Gm-Message-State: ANhLgQ0etdj+RxP+k+krSpUjyiERJq8VOGL/RR7KoP0sBkQ9DeCHO0ic
        8pVL9J3z2BOKErjsierqCtu8eZpWM4qFRY46nhmWjw==
X-Google-Smtp-Source: ADFU+vs/0ZiJfqPA7EukyL4+DZs2EJZ2FkBQDZwJ/jcv1Cma/xnhZmbg/F6SIEf/URrc+W049AaZlV2ArAclptArrf0=
X-Received: by 2002:a05:6830:12d1:: with SMTP id a17mr3526676otq.39.1583144083038;
 Mon, 02 Mar 2020 02:14:43 -0800 (PST)
MIME-Version: 1.0
References: <68219a85-295d-7b7c-9658-c3045bbcbaeb@free.fr> <e88ca46a-799d-9c86-f2d2-6284eb3c3419@free.fr>
 <CAMuHMdUZfR6pYG-hourZCKT-jhh1t+x-ySF4JnEPJjscGAQT+A@mail.gmail.com> <7622db71-b1f4-62b4-86ee-78e00d5bd52c@free.fr>
In-Reply-To: <7622db71-b1f4-62b4-86ee-78e00d5bd52c@free.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Mar 2020 11:14:21 +0100
Message-ID: <CAMuHMdVYghD_xLeXVFD+PGBKECSkQ+_KxPBwFmUDDO3W5skscQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] clk: Use devm_add in managed functions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Mar 2, 2020 at 11:01 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> On 27/02/2020 14:36, Geert Uytterhoeven wrote:
> > On Wed, Feb 26, 2020 at 4:55 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> >> Using the helper produces simpler code, and smaller object size.

> >> --- a/drivers/clk/clk-devres.c
> >> +++ b/drivers/clk/clk-devres.c

> >> @@ -128,30 +109,22 @@ static int devm_clk_match(struct device *dev, void *res, void *data)
> >>
> >>  void devm_clk_put(struct device *dev, struct clk *clk)
> >>  {
> >> -       int ret;
> >> -
> >> -       ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
> >> -
> >> -       WARN_ON(ret);
> >> +       WARN_ON(devres_release(dev, my_clk_put, devm_clk_match, clk));
> >
> > Getting rid of "ret" is an unrelated change, which actually increases
> > kernel size, as the WARN_ON() parameter is stringified for the warning
> > message.
>
> Weird... Are you sure about that? I built the preprocessed file,
> and it didn't appear to be so.
>
> #ifndef WARN_ON
> #define WARN_ON(condition) ({                                           \
>         int __ret_warn_on = !!(condition);                              \
>         if (unlikely(__ret_warn_on))                                    \
>                 __WARN();                                               \
>         unlikely(__ret_warn_on);                                        \
> })
> #endif
>
> Maybe you were thinking of i915's WARN_ON?
>
> #define WARN_ON(x) WARN((x), "%s", "WARN_ON(" __stringify(x) ")")

Oops, you're right.  I got trapped again by an override of a standard macro
(IMHO this should be removed).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
