Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9833C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92C320684
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BiHDsUL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgAODk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:40:27 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38781 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgAODk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:40:27 -0500
Received: by mail-ua1-f67.google.com with SMTP id c7so5714308uaf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ji1HwQ1N6xPeXwy6MODHYNaR0cEPlI+RnmBwO9azAEE=;
        b=BiHDsUL1F3KqdmUohfK2LJgp3v+kq/x1BH6rIcqmXthD0OcIQriBahw90cvxmCAx7Z
         CDi1pyzIax/zowDjvF4RmWygJCPedf4ouuov/HKWhoqQwjhAsiEALEgYcy/TZcq0Z5jj
         zyy3dnFYRVQTU3UIjCl5ZW0EiNxJEeSfSfWuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ji1HwQ1N6xPeXwy6MODHYNaR0cEPlI+RnmBwO9azAEE=;
        b=J2nvQkJothF5YP+j2P3UGPHGYuH36UEAeVTQnGfQWkZ6IzG6xubtM28gYqcvArDkaT
         cw/c7nKa+f40NGhIkKThFes8rGrimj88tWaqAPQKnShupfnlXNt4DxPVwGsMbI0mc7U1
         tdKTMj4joGEkoNO1l6zxLUjgRaI1UNDGWhgi0k3hvkBNNT2WHc5LJk6ewUpK9gCJJo/x
         9uwPCHjuTlXen4lfPUcOc8+BYdYlZ3PI4sGcZYeNKVGVW0o8qZDKidnRKYMi6aslomIF
         2f9YhQwL2CFi2bkbPNVB0HH0AmF+yxIijmUSyzNg+4l0QqAgh6vqdx2jaBVORxhzw0tg
         KwCA==
X-Gm-Message-State: APjAAAXs2Ap206AA95JuNo8+ijcsTzq9uUPd2HFJkEMB9qyz4YwpmXrC
        NMwxm88p+5wMQ3ZYk/l8F/hWrMxJ54w=
X-Google-Smtp-Source: APXvYqwPY56+a4kllvQ6YoRNGSgpU0n3s44l7RaPgKE7eW0XNleNLIkh2+AnpppUcRYnIdl0z31NmQ==
X-Received: by 2002:ab0:60ba:: with SMTP id f26mr13429185uam.51.1579059626108;
        Tue, 14 Jan 2020 19:40:26 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id i20sm5177016vkn.51.2020.01.14.19.40.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 19:40:25 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id y184so4289014vkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:40:25 -0800 (PST)
X-Received: by 2002:a1f:fccb:: with SMTP id a194mr16179035vki.92.1579059624898;
 Tue, 14 Jan 2020 19:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20200109155910.907-1-swboyd@chromium.org> <20200109155910.907-3-swboyd@chromium.org>
In-Reply-To: <20200109155910.907-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jan 2020 19:40:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W2xBFxOgdOM2=RJMB56wi24UUYqdR8WE63KKhxRRwsZQ@mail.gmail.com>
Message-ID: <CAD=FV=W2xBFxOgdOM2=RJMB56wi24UUYqdR8WE63KKhxRRwsZQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] alarmtimer: Make alarmtimer platform device child of
 RTC device
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 9, 2020 at 7:59 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The alarmtimer_suspend() function will fail if an RTC device is on a bus
> such as SPI or i2c and that RTC device registers and probes after
> alarmtimer_init() registers and probes the 'alarmtimer' platform device.
> This is because system wide suspend suspends devices in the reverse
> order of their probe. When alarmtimer_suspend() attempts to program the
> RTC for a wakeup it will try to program an RTC device on a bus that has
> already been suspended.
>
> Let's move the alarmtimer device registration to be when the RTC we use
> for wakeup is registered. Register the 'alarmtimer' platform device as a
> child of the RTC device too, so that we can be guaranteed that the RTC
> device won't be suspended when alarmtimer_suspend() is called.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  kernel/time/alarmtimer.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 4b11f0309eee..ccb6aea4f1d4 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
>         unsigned long flags;
>         struct rtc_device *rtc = to_rtc_device(dev);
>         struct wakeup_source *__ws;
> +       struct platform_device *pdev;
>         int ret = 0;
>
>         if (rtcdev)
> @@ -99,6 +100,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
>                 return -1;
>
>         __ws = wakeup_source_register(dev, "alarmtimer");
> +       pdev = platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);

Don't you need to check for an error here?  If pdev is an error you'll
continue on your merry way.  Before your patch if you got an error
registering the device it would have caused probe to fail.

I guess you'd only want it to be an error if "rtcdev" is NULL?

Otherwise (though I'm no expert on this code), it looks sane to me.


-Doug
