Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307F8C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0207E222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GskzbfQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAOTsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:48:03 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34967 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAOTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:48:02 -0500
Received: by mail-vs1-f67.google.com with SMTP id x123so11215094vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2SH49lI+6VFGk5xmCSW6VNj+SBvTiwjLBEhg2VRN1o=;
        b=GskzbfQjdp7RZo5fTf/SVXFRVlx0m9k0dJmJav/bGrGN6ZKvFs6EAnIculE1JEYJ60
         s4OzSgXkc+LMifz1FF+HgGcEh87n46k7OTfGe64YrqCmkeikeiYI77/3CN1Rf+n1XWQV
         DGxe2GWHYIm7PzqKMijuoe4D2DFrVL/sQGswE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2SH49lI+6VFGk5xmCSW6VNj+SBvTiwjLBEhg2VRN1o=;
        b=CgoT4I07MAB/EtBmQDD0Gie/tP8W4292BrO66PRUkrZhHy20O931YQHANJx9AubCfE
         ieRR3i02YiDz6VlqVeESV3voDVSITy20HGzubAZqK8I2+P7beo9dUGAT0EY+R0MbbdPu
         SXetpm+AjkX+dEW3K99/qU/AACi+hdlYR3FwMtbgmw5oo1a0wQWhXH1bDYjMqaw7LYed
         FiQxAR0X7dcsUuSj5oz5z+EtBgyBrTGJsWX30qpCCTowHHbGA+ke4D2HutUsLqn6wYPi
         IbGLyJKhLHADbboOhXCqCxZufcdM/teeAVymbvz8gop3FqNzjj1M8hQTYmivIqJ5hYDh
         4ANw==
X-Gm-Message-State: APjAAAXKpKH4jQ/uSkQhbx6sJIs62+QwU18djWhDMzlntvEn5UOYa6Yd
        aEu39gK6QWa4eKCWvYg2/pCe/YNo0C0=
X-Google-Smtp-Source: APXvYqz4XXl2/VmBaa3FsXtlS6yqt250ahzTDfdOv8gQms+qHNPVUZJPKKrCRQWx4ky63WTqEsnHPw==
X-Received: by 2002:a67:d986:: with SMTP id u6mr5658010vsj.226.1579117681387;
        Wed, 15 Jan 2020 11:48:01 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id x22sm4687520vsq.6.2020.01.15.11.48.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:48:00 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id g15so11208948vsf.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:48:00 -0800 (PST)
X-Received: by 2002:a05:6102:2d8:: with SMTP id h24mr5767789vsh.169.1579117680240;
 Wed, 15 Jan 2020 11:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20200109155910.907-1-swboyd@chromium.org> <20200109155910.907-4-swboyd@chromium.org>
In-Reply-To: <20200109155910.907-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jan 2020 11:47:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uxw+M-+-P=0z9K558RhzZA+XPA7thVTbcU2z3pL3eU5w@mail.gmail.com>
Message-ID: <CAD=FV=Uxw+M-+-P=0z9K558RhzZA+XPA7thVTbcU2z3pL3eU5w@mail.gmail.com>
Subject: Re: [PATCH 3/4] alarmtimer: Use wakeup source from alarmtimer
 platform device
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
> Use the wakeup source that can be associated with the 'alarmtimer'
> platform device instead of registering another one by hand.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  kernel/time/alarmtimer.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index ccb6aea4f1d4..be057638e89d 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -55,8 +55,6 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
>  #endif
>
>  #ifdef CONFIG_RTC_CLASS
> -static struct wakeup_source *ws;
> -
>  /* rtc timer and device for setting alarm wakeups at suspend */
>  static struct rtc_timer                rtctimer;
>  static struct rtc_device       *rtcdev;
> @@ -87,7 +85,6 @@ static int alarmtimer_rtc_add_device(struct device *dev,
>  {
>         unsigned long flags;
>         struct rtc_device *rtc = to_rtc_device(dev);
> -       struct wakeup_source *__ws;
>         struct platform_device *pdev;
>         int ret = 0;
>
> @@ -99,8 +96,9 @@ static int alarmtimer_rtc_add_device(struct device *dev,
>         if (!device_may_wakeup(rtc->dev.parent))
>                 return -1;
>
> -       __ws = wakeup_source_register(dev, "alarmtimer");
>         pdev = platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);
> +       if (pdev)

It appears that the error case for platform_device_register_data()
needs to be checked with by IS_ERR().

Other than that, this seems like a sane idea to me and a nice cleanup.
With my usual caveat that I'm reviewing code that I'm by no means an
expert in, feel free to add my Reviewed-by with that change.

-Doug
