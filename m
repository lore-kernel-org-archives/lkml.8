Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA0FC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FFB2081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TotNqo5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgAOTcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:32:41 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35819 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:32:41 -0500
Received: by mail-ua1-f67.google.com with SMTP id y23so6711763ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhuM70Y9CQ3lHvXFb32kY421wqyl+dqm9WpsVvRyRYs=;
        b=TotNqo5a9FLWny6MauM8BsAcIT3r9sGn4h1UhwGC59Oys0gmMpD4CNkkMmZtC+pRkz
         8+ExAaxrY9c5PakRwP8rNPLmTH6ek35+H0EbzcnkzymSpStRqpf2uwRvDY0vo6fV52JG
         +ib8y+95ADxHKkbmrelSYJM744wPduCIR8epM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhuM70Y9CQ3lHvXFb32kY421wqyl+dqm9WpsVvRyRYs=;
        b=U0AqVN6aR8lDvMo5FXJWdHG9mcFoyhW7DXmyZgA9Lvb/eT/fdMlAn2aJDzuclBJExd
         bqy8zamIEvecn5TxOuW6fx4owyz+l5xSKBKudM5OCYHVE5BKe78fFOhUiVyaPh/Xakcl
         L1q5hWEB9SvBlSOqiIB8JJCsvu3SMslz58t3Bug4X/usLLT3nRtGACQU4dT+wG0lp3/B
         2PmhZizyHhH6vy6v/1GJKt5zgPVVZhQ0fl4DORuHv+R6KWzroJORZaYc0UaicsZ6FBSl
         XaNh2Y64ldJe5TWcZqzGS3EkDvvqsoJS/+viIYV3m1FxRSeqBoLWJewqM/PNqxCtEsKK
         pcBw==
X-Gm-Message-State: APjAAAXWXYwlBHYUEDACB9M30AjPqCIAe7NCHTBYBD2pxmfaCZxb8f3Y
        hZyc25zcHLPhUvr80JHBiU7/20sLFwU=
X-Google-Smtp-Source: APXvYqyX+AlpQKjOOpucbVPcssqTWdTq161ow8oa25FMF1qHyAZmOTpRiFf31aREw1IZyyAWRKACPQ==
X-Received: by 2002:ab0:728b:: with SMTP id w11mr15364821uao.1.1579116760197;
        Wed, 15 Jan 2020 11:32:40 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id d25sm5776362vko.46.2020.01.15.11.32.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:32:39 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id 59so6707934uap.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:32:39 -0800 (PST)
X-Received: by 2002:ab0:254e:: with SMTP id l14mr15622637uan.91.1579116759104;
 Wed, 15 Jan 2020 11:32:39 -0800 (PST)
MIME-Version: 1.0
References: <87v9pdxcc2.fsf@nanos.tec.linutronix.de> <5e1f4235.1c69fb81.7041e.36a0@mx.google.com>
In-Reply-To: <5e1f4235.1c69fb81.7041e.36a0@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jan 2020 11:32:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XfZC_c_tKQ5pCWwCAdipqpxzfHO-cUDbXFBMt8gaB_1g@mail.gmail.com>
Message-ID: <CAD=FV=XfZC_c_tKQ5pCWwCAdipqpxzfHO-cUDbXFBMt8gaB_1g@mail.gmail.com>
Subject: Re: [PATCH 2/4] alarmtimer: Make alarmtimer platform device child of
 RTC device
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 15, 2020 at 8:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Thomas Gleixner (2020-01-15 02:07:09)
> > Doug Anderson <dianders@chromium.org> writes:
> > > On Thu, Jan 9, 2020 at 7:59 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> > >> index 4b11f0309eee..ccb6aea4f1d4 100644
> > >> --- a/kernel/time/alarmtimer.c
> > >> +++ b/kernel/time/alarmtimer.c
> > >> @@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
> > >>         unsigned long flags;
> > >>         struct rtc_device *rtc = to_rtc_device(dev);
> > >>         struct wakeup_source *__ws;
> > >> +       struct platform_device *pdev;
> > >>         int ret = 0;
> > >>
> > >>         if (rtcdev)
> > >> @@ -99,6 +100,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
> > >>                 return -1;
> > >>
> > >>         __ws = wakeup_source_register(dev, "alarmtimer");
> > >> +       pdev = platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);
> > >
> > > Don't you need to check for an error here?  If pdev is an error you'll
> > > continue on your merry way.  Before your patch if you got an error
> > > registering the device it would have caused probe to fail.
> >
> > Yes, that return value should be checked
> >
>
> Ok. Should __ws also be checked for error? I'm currently thinking of this patch
> and then simplifying it in patch 3 of this series by removing __ws. Or
> the series can swap patch 2 and 3.
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index ccb6aea4f1d4..3e1f4056e384 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -103,7 +103,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
>         pdev = platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);
>
>         spin_lock_irqsave(&rtcdev_lock, flags);
> -       if (!rtcdev) {
> +       if (__ws && pdev && !rtcdev) {

I believe instead of pdev you want !IS_ERR(pdev)

...otherwise this seems sane.  I ran out of time last night to get to
patch #3 and #4 but I'll look at them shortly.  I don't have tons of
opinions for the ordering questions, so whatever seems cleanest?

-Doug
