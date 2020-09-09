Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0026C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FED32078B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggEyuPM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIISvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIISvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:51:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80DC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 11:51:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so3745225edk.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfN64tSOGeP7ex6MQ1qLJK62hgHjPavCUX84aVCHqYU=;
        b=ggEyuPM2at4cZym3o7YnP1kWeACf1A6Gzyf6R67Do2SkEc2O4Is3QDDRCJP5ee5H5s
         dqlEbhjuIJRjrKi25j6Mc8DUJ5Sz0mo5RxmSanuYmQTrFXKhj7t3w4Oh9DP6K6qOJPAX
         lzxxI9BQ4WLYaCt6rXfLNN1Nu66pUQK7u39vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfN64tSOGeP7ex6MQ1qLJK62hgHjPavCUX84aVCHqYU=;
        b=MQBATjzFdByCuJV1orrvwTGOoGOYTcyKh8so6418bns3s0OlLErjb9kX8IhHPHGzx9
         aCxNLRtukYIxGt2oPxq3e+w+u5oXAgzhSXeeEbEi2RlQfFAbor/wtCp+nA74LT+xswI/
         Xg3g6WWt1yg8V9A1errD1qAiqb3wDkSioiMVXfD8+VCD7k01NzEYXuDPh9Lub5UuAupR
         HIN48ie1fZEHzhqkHtp4DF+ME/iFt6aRzYZ55A5IxmUKv+7yPwC4u18wDXE7V98ZBBQT
         lGRgQvsvrzHPms8jSjycZb4Ift3gEaEPfcrpaL+kO9n2IQM2xZ4AeVc6laP3YwDvbk9N
         LlBQ==
X-Gm-Message-State: AOAM533rbqD6Bekr3LJJi476N0+Fk0kK9ElBJqjf1B16J/FktZmPbIZM
        m9X5r45YzgpLZTqPy9V6RnNCXiflIq98qw==
X-Google-Smtp-Source: ABdhPJx4FQ+3awuI3mNX/GZgnODJnAzlEeJpYWonSX6mSRskBoXLOm6MnyNCn+AgPDpNOOfqeX8ejA==
X-Received: by 2002:a50:8f45:: with SMTP id 63mr5761834edy.52.1599677490229;
        Wed, 09 Sep 2020 11:51:30 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id bt14sm3376241ejb.2.2020.09.09.11.51.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 11:51:30 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id n22so3757791edt.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 11:51:30 -0700 (PDT)
X-Received: by 2002:a17:906:bb0e:: with SMTP id jz14mr5218995ejb.525.1599677012842;
 Wed, 09 Sep 2020 11:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200721042522.2403410-1-amstan@chromium.org> <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
In-Reply-To: <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Wed, 9 Sep 2020 11:42:56 -0700
X-Gmail-Original-Message-ID: <CAHNYxRw5t67-A4sf719+hQ51K-oRZZLt5W5P3Hej0ynvS9-V5Q@mail.gmail.com>
Message-ID: <CAHNYxRw5t67-A4sf719+hQ51K-oRZZLt5W5P3Hej0ynvS9-V5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during interpolation
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 4:38 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > Some displays need the low end of the curve cropped in order to make
> > them happy. In that case we still want to have the 0% point, even though
> > anything between 0% and 5%(example) would be skipped.
>
> For backlights it is not defined that 0 means off and, to be honest, 0
> means off is actually rather weird for anything except transflexive
> or front lit reflective displays[1]. There is a problem on several
> systems that when the backlight slider is reduced to zero you can't
> see the screen properly to turn it back up. This patch looks like it
> would make that problem worse by hurting systems with will written
> device trees.
>
> There is some nasty legacy here: some backlight displays that are off
> at zero and that sucks because userspace doesn't know whether zero is
> off or lowest possible setting.
>
> Nevertheless perhaps a better way to handle this case is for 0 to map to
> 5% power and for the userspace to turn the backlight on/off as final
> step in an animated backlight fade out (and one again for a fade in).

Hello

Apologies for my delay. Thanks for the responses!

Yeah, I felt pretty sketchy about this 0% patch as well. But I figured
it's better to send my suggestion and get corrected than lose the
fixed interpolation patch.

Turns out there's no reason to need 2/3. I was mistaken:
echo "4" > /sys/devices/platform/backlight/backlight/backlight/bl_power
seems to work just fine to turn the backlight off, nothing special
about my device (pwm comes from cros_ec).
Chrome OS user space already makes full use of that knob
(https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/platform2/power_manager/powerd/system/internal_backlight.cc;l=169)
I wanted to try X11 on the same device but I haven't gotten to it yet,
perhaps I'll post my results in the next cover letter.
So it seems I didn't have to worry about "not breaking userspace" on
the existing devices.

I'll respin this patch set: keep 1/3 and 3/3, remove 2/3, and
potentially add another one to update trogdor's dtsi (since that's
where I want this fixed linear interpolation to happen).

Thank you,
Alexandru Stan
