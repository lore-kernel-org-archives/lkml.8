Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A51AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CB22080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="kFTdCWCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbgDAIUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:20:19 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34574 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgDAIUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:20:19 -0400
Received: by mail-ua1-f67.google.com with SMTP id d23so8495399uak.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jfx+WzxfTIw9109h9/F+uN5ZdtC4CUJc38PHSbeeBtM=;
        b=kFTdCWCnXWL/FxLIRizE+7P10KR+ftxEYZsICf8C8mqGdKrRQEscI/64vPCXWOyuC9
         hv1fmKVvX9YZAvVuJ3eM8o3RuurUlQ5aquTKQh0S2A6ICZHE7hjgbois3NK3d53co6sq
         7nciOYPmbIhWZIv6ATsF1xoYIr0T6KhPhl0VmA4WURRS/qkDk74rO3sf8FvomTCCOcuq
         POSpjXZ0TQg9bAZVoaz+Xz/k2lCOWOBMBhWHOpRAtpnYuFgPGAxqJ5UKABKMW18QIPIW
         wHo700tX4cbbOuvDpdRuVG2o3DeYGmjQ6XbVJpMNSdPca0p5LK3UF4iWM61Mu8qz8srV
         8UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jfx+WzxfTIw9109h9/F+uN5ZdtC4CUJc38PHSbeeBtM=;
        b=tBLDEOfnH/9zXhz78tfGcmZ6Zuk5Q4WOAdJgSLcDDubQhZcOxJRZ3UOYBQyKm6/NyP
         YG3sJXEZVfIEXtJZLM1LXMxs0WmNjY6HkioOoLKfZCq75btctxp8KxJS7XIrrFYGNuoh
         /6Y+8wV3F1qRLggMBCW/qPecMnr1UfBSlSTDtfZhglnyv8xOWA7ICdZRBQNxDBIvj2Bz
         E7FRCXAWdxd7Z2iYhT0rBKayGZfYBc1Bv5NRtca3Uf0KHSTql+uPYTToWwhifKpFesMp
         sEgdkUaiq3IIxtBst6qh4vaoOVVoarDrAA6amuoIc1zFQQ7yNNRUY2xwDu9HvTpWsqhR
         nLdw==
X-Gm-Message-State: AGi0Pubgy46Grq6veR+VtiEs4iMB2pyPgsh1u3M3FXza8gbDDtLeWZGM
        ThSGkwDVSuHAGemSSp1nCIbuRYLGchsXkUwN3iBkUzltN/7HVw==
X-Google-Smtp-Source: APiQypJ0UixfKiD4USaplcV9xofH2gdUQll0ySr4YPXyUtqi0iouiSejQj3sS2nAegAhi7IEFT63GHFPOW6QMhDyJRw=
X-Received: by 2002:ab0:608b:: with SMTP id i11mr14498961ual.94.1585729217782;
 Wed, 01 Apr 2020 01:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200331165449.30355-1-daniel.lezcano@linaro.org> <20200331165449.30355-2-daniel.lezcano@linaro.org>
In-Reply-To: <20200331165449.30355-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 1 Apr 2020 13:50:06 +0530
Message-ID: <CAHLCerOqyy+2H0hsrFZGD87aYpr6-fjimhKXasn=JCTK8An+qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: core: Remove pointless debug traces
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:27 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The last temperature and the current temperature are show via a
> dev_debug. The line before, those temperature are also traced.
>
> It is pointless to duplicate the traces for the temperatures,
> remove the dev_dbg traces.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9a321dc548c8..c06550930979 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -447,12 +447,6 @@ static void update_temperature(struct thermal_zone_device *tz)
>         mutex_unlock(&tz->lock);
>
>         trace_thermal_temperature(tz);
> -       if (tz->last_temperature == THERMAL_TEMP_INVALID)
> -               dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
> -                       tz->temperature);
> -       else
> -               dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
> -                       tz->last_temperature, tz->temperature);
>  }
>
>  static void thermal_zone_device_init(struct thermal_zone_device *tz)
> --
> 2.17.1
>
