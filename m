Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95499C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1AA20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="QOXi+X6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgA2LmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:42:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42384 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2LmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:42:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id q15so16650361qke.9;
        Wed, 29 Jan 2020 03:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uvj5lSyDUBorAnnxXjG0B8EQR6HQaBhBDU5iflSNwj4=;
        b=QOXi+X6cQhMWnytGleLK0OUN0HI68S/oKGGDuKDiUzWhkhBdWDeWp8/8fKCMF/GO8X
         LXMHYqJW1mNZZT7D5EghCfl5YVfwFUwNMdZgV3KaJZlY5T3GaNUO1wnQlgtIVfEJ7F1u
         86uPAT4HtTHfYhInYGsO8oeMGpaAIcLeWJNuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uvj5lSyDUBorAnnxXjG0B8EQR6HQaBhBDU5iflSNwj4=;
        b=CAUhTpBOOkP1RlGfixcqBkpSvd3QR+iz2IwMThtTvyfU91tfJfXnj2NdAHnHjyTdPC
         bNTyuvqV5m+hgMRPapXICP14oNDTw+ho+IA0WhAlh/pndKx26CEs4DbpQcTUVrN617jo
         uQZcfqVGpA0z+qLgBNsga+yZeBegtuxI0zHz12SBFz1XaaSZm0rdP6YqCCYkWJRziY2a
         Rq/Vb7YmbTNe3g0apSNYzo0bvvFKCMvqw/UfcayrMoxWgwdtO+NKJ4Ou4mzU/V8RfrDO
         Ac+53yyk5d9hKU2X81RwrQnljP+yutK9wLeQJx0golFGqxVTKCgaNVOt2xHA7Bk0yoCH
         I82g==
X-Gm-Message-State: APjAAAXR9elkurJI/ZD4ELO5OuNuPd6crXo+m+oDysCMUAwMqt5mKeVP
        p7aTmPtuAzhxvaaKq4i0cs0Fo7K0rBE/nGSyoL4=
X-Google-Smtp-Source: APXvYqymt5r5lppEO2YAaxtxP6Hxljwgl3tAcJc5DzZr7VRHl4+EmiLFZU/qDQx5le6IjkigmbJOKkdUbF27trs4L5A=
X-Received: by 2002:a37:a1cc:: with SMTP id k195mr27881820qke.414.1580298130544;
 Wed, 29 Jan 2020 03:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20191107094218.13210-1-joel@jms.id.au> <20191107094218.13210-2-joel@jms.id.au>
 <747e3c0a-ee10-4a41-d0b7-1d54e0f56dd0@linaro.org>
In-Reply-To: <747e3c0a-ee10-4a41-d0b7-1d54e0f56dd0@linaro.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 29 Jan 2020 11:41:59 +0000
Message-ID: <CACPK8XeWY-upP-b_aAMWv-Rx9qaNSbPxOZLVd67-khEVjG877A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] clocksource: fttmr010: Parametrise shutdown
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 at 11:25, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 07/11/2019 10:42, Joel Stanley wrote:
> > In preparation for supporting the ast2600 which uses a different method
> > to clear bits in the control register, use a callback for performing th=
e
> > shutdown sequence.
> >
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> It will be cleaner if you create a struct of_device_id array where you
> store the different variant data.

I agree, and that's the path I would have taken when writing a normal
driver. However as the timer drivers probe with the
TIMER_OF_DECLARE/timer_probe infrastructure, we can't register our own
.data pointer (TIMER_OF_DECLARE uses .data  to store the _init
function).

Unless I'm missing something?

Cheers,

Joel


>
> eg.
> struct myops {
>         int (*shutdown)(struct clock_event_device *evt);
> };
>
> struct fttmr010 {
>         ...
>         struct myops *ops;
> };
>
> ...
>
> static const struct of_device_id fttmr010_of_match[] =3D {
>         { .compatible =3D "faraday,fttmr010",     .data =3D &fttmr010_ops=
 },
>         ...
>         { .compatible =3D "aspeed,ast2600-timer", .data =3D &as2600_ops, =
},
>         { /* sentinel */ }
> };
>
> Keep the generic timer_shutdown function, get the ops from there and
> then call the shutdown callback.
>
> At init time:
>
> ...
>
> const struct of_device_id *match;
>
> ...
>
> match =3D of_match_node(fttmr010_of_match, node);
> fttmr010->ops =3D (struct myops *)match->data;
>
> ...
>
> (also if you have time, remove the is_aspeed boolean test by a
> corresponding callback).
>
> > ---
> >  drivers/clocksource/timer-fttmr010.c | 19 ++++++++-----------
> >  1 file changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource=
/timer-fttmr010.c
> > index fadff7915dd9..c2d30eb9dc72 100644
> > --- a/drivers/clocksource/timer-fttmr010.c
> > +++ b/drivers/clocksource/timer-fttmr010.c
> > @@ -97,6 +97,7 @@ struct fttmr010 {
> >       bool is_aspeed;
> >       u32 t1_enable_val;
> >       struct clock_event_device clkevt;
> > +     int (*timer_shutdown)(struct clock_event_device *evt);
> >  #ifdef CONFIG_ARM
> >       struct delay_timer delay_timer;
> >  #endif
> > @@ -140,9 +141,7 @@ static int fttmr010_timer_set_next_event(unsigned l=
ong cycles,
> >       u32 cr;
> >
> >       /* Stop */
> > -     cr =3D readl(fttmr010->base + TIMER_CR);
> > -     cr &=3D ~fttmr010->t1_enable_val;
> > -     writel(cr, fttmr010->base + TIMER_CR);
> > +     fttmr010->timer_shutdown(evt);
> >
> >       if (fttmr010->is_aspeed) {
> >               /*
> > @@ -183,9 +182,7 @@ static int fttmr010_timer_set_oneshot(struct clock_=
event_device *evt)
> >       u32 cr;
> >
> >       /* Stop */
> > -     cr =3D readl(fttmr010->base + TIMER_CR);
> > -     cr &=3D ~fttmr010->t1_enable_val;
> > -     writel(cr, fttmr010->base + TIMER_CR);
> > +     fttmr010->timer_shutdown(evt);
> >
> >       /* Setup counter start from 0 or ~0 */
> >       writel(0, fttmr010->base + TIMER1_COUNT);
> > @@ -211,9 +208,7 @@ static int fttmr010_timer_set_periodic(struct clock=
_event_device *evt)
> >       u32 cr;
> >
> >       /* Stop */
> > -     cr =3D readl(fttmr010->base + TIMER_CR);
> > -     cr &=3D ~fttmr010->t1_enable_val;
> > -     writel(cr, fttmr010->base + TIMER_CR);
> > +     fttmr010->timer_shutdown(evt);
> >
> >       /* Setup timer to fire at 1/HZ intervals. */
> >       if (fttmr010->is_aspeed) {
> > @@ -350,6 +345,8 @@ static int __init fttmr010_common_init(struct devic=
e_node *np, bool is_aspeed)
> >                                    fttmr010->tick_rate);
> >       }
> >
> > +     fttmr010->timer_shutdown =3D fttmr010_timer_shutdown;
> > +
> >       /*
> >        * Setup clockevent timer (interrupt-driven) on timer 1.
> >        */
> > @@ -370,10 +367,10 @@ static int __init fttmr010_common_init(struct dev=
ice_node *np, bool is_aspeed)
> >       fttmr010->clkevt.features =3D CLOCK_EVT_FEAT_PERIODIC |
> >               CLOCK_EVT_FEAT_ONESHOT;
> >       fttmr010->clkevt.set_next_event =3D fttmr010_timer_set_next_event=
;
> > -     fttmr010->clkevt.set_state_shutdown =3D fttmr010_timer_shutdown;
> > +     fttmr010->clkevt.set_state_shutdown =3D fttmr010->timer_shutdown;
> >       fttmr010->clkevt.set_state_periodic =3D fttmr010_timer_set_period=
ic;
> >       fttmr010->clkevt.set_state_oneshot =3D fttmr010_timer_set_oneshot=
;
> > -     fttmr010->clkevt.tick_resume =3D fttmr010_timer_shutdown;
> > +     fttmr010->clkevt.tick_resume =3D fttmr010->timer_shutdown;
> >       fttmr010->clkevt.cpumask =3D cpumask_of(0);
> >       fttmr010->clkevt.irq =3D irq;
> >       clockevents_config_and_register(&fttmr010->clkevt,
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
