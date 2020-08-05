Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8961C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1942063A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aPqJee4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHEVK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:10:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9145BC061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:10:23 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so34099717ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2PZXILdefiTwwzfO5OUUQBgzK17xy7UQ4vY/f0A1uM=;
        b=aPqJee4+/II1pDeHm6YJT9N8szJtyfH8/u0a/mb/rUh0XKwrO9/lI6mAKg/YUjZsap
         p0B7nL/zuMyT3EsRGWbvq29/0Lc9irQLp5boKwUO0dgr7wICe4bQ/VVNo2zfxFQFtKUF
         aTAuAP1cEHDioLUgDXQmFNnV10RJlUC2CPrZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2PZXILdefiTwwzfO5OUUQBgzK17xy7UQ4vY/f0A1uM=;
        b=pth4mrdZhPml0j0mRK21e7OWk4VHtCwmptAgP4KyGLk/lnLPBXOfmqBVJ3iJDUWXHP
         vMEB9X4iVtDXUxJH4DeURrD59NTb2iMRC14CIu4yImoA6oH+yVCq8Yk+JCsde9A/mXfl
         CNuNTfZKnxRD0Vlkd3msjjQNznLidSIaWq/cEmoAlqh84hpN3FXd3R9H2mLz4PWcd7bT
         aOlDTHIpUnkWJhbU0fdv5alqNWfCAOhaBXoAVdS/JiMGOkXiMwdvFv15XZ5ShLDrLhnk
         vCP5Wj3yNV1mrqG9EI+ex3RZjNqtK7pWWMZNf1dzVBI/VIb3DvqAoiTXzcGPF1EOO9bQ
         Tb6Q==
X-Gm-Message-State: AOAM533xz3wADfCzCmlBGttRYsgBTHfQ8/om0orBnJmt3Q8ix/GQV/oB
        5C5r7xcQmMCjoRB++8G/F1ng4A4Mz5k=
X-Google-Smtp-Source: ABdhPJxBX95do5yPbM4lrDh4XtNiezNlJO3s6gwxpdpxHravQ2Hcf/I2l2NlL9cK9EI6tYrwUL4iHg==
X-Received: by 2002:a17:906:4f82:: with SMTP id o2mr1251879eju.424.1596661821719;
        Wed, 05 Aug 2020 14:10:21 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id ec20sm2247304ejb.61.2020.08.05.14.10.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 14:10:21 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id jp10so21379409ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:10:21 -0700 (PDT)
X-Received: by 2002:a05:6402:28f:: with SMTP id l15mr1118783edv.233.1596661486208;
 Wed, 05 Aug 2020 14:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200721042522.2403410-1-amstan@chromium.org>
In-Reply-To: <20200721042522.2403410-1-amstan@chromium.org>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Wed, 5 Aug 2020 14:04:09 -0700
X-Gmail-Original-Message-ID: <CAHNYxRzwQ2jx99M0oyNv8CDE4h051jcdAdYFjRd8mhNjB19FgA@mail.gmail.com>
Message-ID: <CAHNYxRzwQ2jx99M0oyNv8CDE4h051jcdAdYFjRd8mhNjB19FgA@mail.gmail.com>
Subject: Re: [PATCH 0/3] PWM backlight interpolation adjustments
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 9:27 PM Alexandru Stan <amstan@chromium.org> wrote:
>
> I was trying to adjust the brightness for a new chromebook:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2291209
> Like a lot of panels, the low end needs to be cropped,
> and now that we have the interpolation stuff I wanted to make use of it
> and bake in even the curve.
>
> I found the behavior a little unintuitive and non-linear. See patch 1
> for a suggested fix for this.
>
> Unfortunatelly a few veyron dts files were relying on this
> (perhaps weird) behavior. Those devices also want a minimum brightness.
> The issue is that they also want the 0% point for turning off the
> display.
> https://github.com/torvalds/linux/commit/6233269bce47bd450196a671ab28eb1ec5eb88d9#diff-e401ae20091bbfb311a062c464f4f47fL23
>
> So the idea here is to change those dts files to only say <3 255> (patch
> 3), and add in a virtual 0% point at the bottom of the scale (patch 2).
>
> We have to do this conditionally because it seems some devices like to
> have the scale inverted:
>   % git grep "brightness-levels\s*=\s*<\s*[1-9]"|cat
>   arch/arm/boot/dts/tegra124-apalis-eval.dts:             brightness-levels = <255 231 223 207 191 159 127 0>;
>
>
> Alexandru Stan (3):
>   backlight: pwm_bl: Fix interpolation
>   backlight: pwm_bl: Artificially add 0% during interpolation
>   ARM: dts: rockchip: Remove 0 point in backlight
>
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts    |  2 +-
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts |  2 +-
>  arch/arm/boot/dts/rk3288-veyron-tiger.dts  |  2 +-
>  drivers/video/backlight/pwm_bl.c           | 78 +++++++++++-----------
>  4 files changed, 42 insertions(+), 42 deletions(-)
>
> --
> 2.27.0
>

Hello,

Friendly ping.
Let me know if you would like me to make any changes to my patches.

Thanks,
Alexandru M Stan
