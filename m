Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D24420721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKp56kq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgE2Mfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgE2MfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:35:21 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DAC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:35:20 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 9so2204451ilg.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QQKUqX33jKxu7xXLL4ova+QPLIPkMuSTOrsUN0PAZO0=;
        b=LKp56kq34nPmIiOKHnOneCDJMToOPA7EL0pXwQM+nXciQtcVkxUWRXy8WLq8jE00e2
         POnOJuG8DVAAtng0S7S/Qv/gkSatXlGeptpsTCBQV0P3WtbkvecoVJQgHcrx0SVBm8P3
         qEHiIQo0Ho4rVCrriGzJxCrGzM9itFljdnr11y1rf+6soTk08cZ9mG50CFDo0rck76mO
         K4MhjTmLdFAX+KtZUB0R8H96avchflxwDyLosfVU+RIGfgfbalHhKmPc91j128quOw6L
         blXNe6pItY5lY5CCu30pXpa/Ed69elCz95zelGlKb6kcbNlfrop5cm50R6ji05M1Q3DL
         y6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QQKUqX33jKxu7xXLL4ova+QPLIPkMuSTOrsUN0PAZO0=;
        b=URAOzQtG+WNu7lmutZSKp+Qy0HZK/6ydxOWgf0sP/qt2r2p3OpUMEFXYdaS7/dkmfn
         FlznNrQWZ7T6JiQuUQ6v53rC+vPVzYo14ZIbiKy8XKtI8LMLHMY1Gwk+B240SYhhmebm
         KP1gQQoX2CzrY+aQ8cL8k+aZ7sA9XbomNp78JIGSHNdGco0FXR4NCRWa+K4JDDum//Yj
         DGNmoumi7/teaca5YGj0yrkDfOAuUtDZ7oLet8Wol6sELZyI9eeliOvAXsq9TYF48cNn
         pajx8ySntE4AoN29mWLc/pRNC6xIHCReQp7yvEGU5y/1xeA2xhSZqXWax25rfxwoho7W
         78pg==
X-Gm-Message-State: AOAM532PFtmGLcTvTTtlaH0RxfmCGehNVq756IiQLZovSDL7spJQLyHt
        dKJWgHDYoc4SdYZgC0i2xcmcwrTreQf/NhE6mP8=
X-Google-Smtp-Source: ABdhPJxsnPf7Ua0YRkxDmtaDeUWOtLqME8clmbrqOqhmFRtW14m06XVzx5wUbmg/g2x33c99GItnUdh5UwJSKkPZHrQ=
X-Received: by 2002:a92:4885:: with SMTP id j5mr6542365ilg.35.1590755719955;
 Fri, 29 May 2020 05:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200510165538.19720-1-peron.clem@gmail.com> <20200510165538.19720-6-peron.clem@gmail.com>
 <788ac664-e426-d307-f81e-9632de09887c@arm.com>
In-Reply-To: <788ac664-e426-d307-f81e-9632de09887c@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 29 May 2020 14:35:08 +0200
Message-ID: <CAJiuCcemwM-11ZT5+-4JfyTgTRD-_JjWz=HDCme8743M5Epf0g@mail.gmail.com>
Subject: Re: [PATCH 05/15] drm/panfrost: use spinlock instead of atomic
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, 29 May 2020 at 14:20, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-05-10 17:55, Cl=C3=A9ment P=C3=A9ron wrote:
> > Convert busy_count to a simple int protected by spinlock.
>
> A little more reasoning might be nice.

I have follow the modification requested for lima devfreq and clearly
don't have any argument to switch to spinlock.

The Lima Maintainer asked to change witht the following reason :
"Better make this count a normal int which is also protected by the spinloc=
k,
because current implementation can't protect atomic ops for state change
and busy idle check and we are using spinlock already"

>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> [...]
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/=
drm/panfrost/panfrost_devfreq.h
> > index 0697f8d5aa34..e6629900a618 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> > @@ -4,6 +4,7 @@
> >   #ifndef __PANFROST_DEVFREQ_H__
> >   #define __PANFROST_DEVFREQ_H__
> >
> > +#include <linux/spinlock.h>
> >   #include <linux/ktime.h>
> >
> >   struct devfreq;
> > @@ -14,10 +15,17 @@ struct panfrost_device;
> >   struct panfrost_devfreq {
> >       struct devfreq *devfreq;
> >       struct thermal_cooling_device *cooling;
> > +
> >       ktime_t busy_time;
> >       ktime_t idle_time;
> >       ktime_t time_last_update;
> > -     atomic_t busy_count;
> > +     int busy_count;
> > +     /*
> > +      * Protect busy_time, idle_time, time_last_update and busy_count
> > +      * because these can be updated concurrently, for example by the =
GP
> > +      * and PP interrupts.
> > +      */
>
> Nit: this comment is clearly wrong, since we only have Job, GPU and MMU
> interrupts here. I guess if there is a race it would be between
> submission/completion/timeout on different job slots.

It's copy/paste from lima I will update it,

>
> Given that, should this actually be considered a fix for 9e62b885f715
> ("drm/panfrost: Simplify devfreq utilisation tracking")?

I can't say if it can be considered as a fix, I didn't see any
improvement on my board before and after this patch.
I'm still facing some issue and didn't have time to fully investigate it.

Thanks for you review,


>
> Robin.
