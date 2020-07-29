Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CCDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CBFB2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kb2uKX8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgG2SnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2SnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:43:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05514C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:43:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so14767873pgg.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ao3gYRdt2ElCy6wrMHMRO1zFYSatQRmO8ChzZFiBXu0=;
        b=kb2uKX8jci49yKGrJqerR1tAzw6UdMCFhr1zS8wUJbaeFIKjlwlGzh9I9VPZAmJHNs
         wYckm9k4g0DXmWL6Zmvu+oYGCgluqwEqbyn7nhPsRWazncYsHyJa/bKAEvvwV1q1ywbg
         10B6jsiTZgXyNQvkh8QBaBEiKSMjW6nMonBPiYxQT91bpEXcNEK3w5ljDtk8DJ9JZdJp
         o4H0Kpop1S4NtKa1Yu2r5Joml1Xz0Od6eTusmKltssklNwe9pU9PlVckpCxMGJxhiD6s
         +26kWKEIwNcfRp07Eop1rUka2pOK65p31hQsylfNTp7S1VZcC3cCT0oFW1eg8F3S2FBO
         KG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ao3gYRdt2ElCy6wrMHMRO1zFYSatQRmO8ChzZFiBXu0=;
        b=JL+VZcAoaYYWoGlTCbvtjIb5PWwwXbiz5LEIrmSE1LC+JRu2t6YyJLEEM4f5OmplKz
         DtvcFNv7axvwj8vbxATquipb3VnDFmSekHObRGN1ZoTKVxijc/CPQYczJO8cuIjkvds1
         httyJxm97syQAymsb1NyiXXSOVEyyqornPTfuB/BhN2zSywdPbL3A35H5KQwt46DmO+i
         KoBU7WohN5OhYxXZPayR++a1XzUyHlUbBgBUYx86acUyP9F9++bib3iXCyJCfcyHmzKI
         ElGDPtc372lXnSpXZNg6w068hFaP7NqsiwuQPze9ymFE3VZzifkv+Z9B4lW/AHNnJIa4
         vRWQ==
X-Gm-Message-State: AOAM533Unb56H+xeNhDu+sqDCZF7giDbr/90Ybi25np6x1n+JxB36Fh3
        U/kCU4vtpl1Jj163ojAUKqjhIiqPi8tn7pgmyP5voQ==
X-Google-Smtp-Source: ABdhPJydQJstyS2jHvJH7t4WgZZRBvCF1P6diedEry+ckqxnTiJn2hwIXK4nzpfzHb0iJoHMphMp3zAIw3Kz6XVzzm8=
X-Received: by 2002:aa7:9f1b:: with SMTP id g27mr13283742pfr.215.1596048200179;
 Wed, 29 Jul 2020 11:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com>
 <1595931377-21627-3-git-send-email-freddy.hsin@mediatek.com> <87mu3ia2zn.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87mu3ia2zn.fsf@nanos.tec.linutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 29 Jul 2020 11:42:44 -0700
Message-ID: <CAGETcx-Aooz+BLpqHMwsJn+FiV9pgYz58gQxOw=TeWq3UWFsYg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] timer: mt6873: porting Mediatek timer driver to
 loadable module
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Freddy Hsin <freddy.hsin@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.or>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, chang-an.chen@mediatek.com,
        Baolin Wang <baolin.wang7@gmail.com>,
        wsd_upstream@mediatek.com, kuohong.wang@mediatek.com,
        stanley.chu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 6:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Freddy,
>
> Freddy Hsin <freddy.hsin@mediatek.com> writes:
>
> again, please be more careful with subject lines. git log $FILE will
> give you a hint.
>
> > porting Mediatek timer driver to loadable module
>
> Repeating the sentence in the subject line is not giving any
> information. Also changelogs want to tell the WHY and not the WHAT. This
> also lacks any information why this is actually safe when booting such a
> system w/o this particular driver built in. What is early boot - up to
> module load - using as clocksource and timer?
>
> > diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
> > index 9de7515..5504569 100644
> > --- a/drivers/clocksource/mmio.c
> > +++ b/drivers/clocksource/mmio.c
> > @@ -21,6 +21,7 @@ u64 clocksource_mmio_readl_up(struct clocksource *c)
> >  {
> >       return (u64)readl_relaxed(to_mmio_clksrc(c)->reg);
> >  }
> > +EXPORT_SYMBOL(clocksource_mmio_readl_up);
>
> Again EXPORT_SYMBOL_GPL() and this wants to be a seperate patch. It has
> absolutely no business with the mediatek timer changes.
>
> >  u64 clocksource_mmio_readl_down(struct clocksource *c)
> >  {
> > @@ -46,7 +47,7 @@ u64 clocksource_mmio_readw_down(struct clocksource *c)
> >   * @bits:    Number of valid bits
> >   * @read:    One of clocksource_mmio_read*() above
> >   */
> > -int __init clocksource_mmio_init(void __iomem *base, const char *name,
> > +int clocksource_mmio_init(void __iomem *base, const char *name,
> >
> >       unsigned long hz, int rating, unsigned bits,
> >       u64 (*read)(struct clocksource *))
> >  {
> > @@ -68,3 +69,4 @@ int __init clocksource_mmio_init(void __iomem *base, const char *name,
> >
> >       return clocksource_register_hz(&cs->clksrc, hz);
> >  }
> > +EXPORT_SYMBOL(clocksource_mmio_init);
>
> See above.
>
> > diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> > index 9318edc..5c89b6b 100644
> > --- a/drivers/clocksource/timer-mediatek.c
> > +++ b/drivers/clocksource/timer-mediatek.c
> > @@ -13,6 +13,9 @@
> >  #include <linux/clocksource.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irqreturn.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/sched_clock.h>
> >  #include <linux/slab.h>
> >  #include "timer-of.h"
> > @@ -309,5 +312,41 @@ static int __init mtk_gpt_init(struct device_node *node)
> >
> >       return 0;
> >  }
> > +
> > +#ifdef MODULE
> > +static int mtk_timer_probe(struct platform_device *pdev)
> > +{
> > +     int (*timer_init)(struct device_node *node);
> > +     struct device_node *np = pdev->dev.of_node;
> > +
> > +     timer_init = of_device_get_match_data(&pdev->dev);
> > +     return timer_init(np);
> > +}
> > +
> > +static const struct of_device_id mtk_timer_match_table[] = {
> > +     {
> > +             .compatible = "mediatek,mt6577-timer",
> > +             .data = mtk_gpt_init,
> > +     },
> > +     {
> > +             .compatible = "mediatek,mt6765-timer",
> > +             .data = mtk_syst_init,
> > +     },
> > +     {}
> > +};
> > +
> > +static struct platform_driver mtk_timer_driver = {
> > +     .probe = mtk_timer_probe,
> > +     .driver = {
> > +             .name = "mtk-timer",
> > +             .of_match_table = mtk_timer_match_table,
> > +     },
> > +};
> > +MODULE_DESCRIPTION("MEDIATEK Module timer driver");
> > +MODULE_LICENSE("GPL v2");
> > +
> > +module_platform_driver(mtk_timer_driver);
> > +#else
> >  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
> >  TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> > +#endif
>
> Sorry no. This is not going to happen.
>
> The above probe, match table and platform driver structs plus the module*
> thingies are going to be repeated in every single driver which is going
> to support module build. Tons of boilerplate copied over and over
> again.
>
> We had exactly the same before TIMER_OF_DECLARE() came around, so pretty
> please this want's to be some smart macro which handles all of this
> automatically.

Probably something like what I did for IRQCHIP?
https://lore.kernel.org/lkml/20200718000637.3632841-1-saravanak@google.com/

Also, one point that came up with IRQCHIP is that if these drivers can
be platform drivers, then they should stay that way even when it's
built in. I'm not sure if that has any other special implications for
timer code, but raising it in case you'd prefer that here too.


-Saravana
