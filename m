Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003C3C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A7720728
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AwYY6Ltx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAOTWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:22:40 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39293 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:22:39 -0500
Received: by mail-ua1-f65.google.com with SMTP id 73so6714402uac.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17v8/619D2AZoaUFrAar/CtDdWqpWMj60JN0gaBw0RA=;
        b=AwYY6LtxDPRLomfOrjpw8+Gis6U739xC6dwXys/nC5Y/5L4XyuijhAg5OOpyC1XEyY
         XjRdghULG/KMYKFomh8B335LGY+oh3wQsRKkVFfRpn/8V/3mEt6q4e9iTXQEBZ7AA3rx
         KDiNMiyHiiAkKWnSh8h7qVhe/NMxr9vjOZYOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17v8/619D2AZoaUFrAar/CtDdWqpWMj60JN0gaBw0RA=;
        b=cPYOSNMy74mEHXe2Oz+FprdLzYiZODxVbo/wFmZGdFE9Heqhp3KftK371awtwuwcdA
         z2WCRbyh6wjSrYcCy/64Qq8vExQOBma3d4+xMCLRODnDqjU94BYm/f+unUNDYelRvId1
         dAoq6zlfWWa79d/BKVphah+NEdmXIhHz8AkMZD4NvcCIO7JolI5vEQpo7miiFXQeip53
         rr2K72QUm+UBW4uJdbWUzzLF40k+ltOHLxWEU8nT3/39ClbvHUeOGoHdEsY+FzZqNfUi
         2lmfo0Ur9X4grgTi2orEdVLls6k3K9SehKnZvZBIs6qRscjD8YTzGDMgZI42ajK58zlb
         YuRA==
X-Gm-Message-State: APjAAAWBo1o2DBFslqEBRZtEI93epYzaZYpcfWtGT5dxk7BZYWDWcwvw
        plXfWNGpZIGkLTKFTpV4P7Ovuw4OoXY=
X-Google-Smtp-Source: APXvYqwyPA7ABvubiTwi4NioOv3ZPMvIMMMHV/wIzWJd7DmOCSMi8uUZNexh8fem+aO2n8cBsr70Qw==
X-Received: by 2002:ab0:2bc1:: with SMTP id s1mr14479939uar.109.1579116158463;
        Wed, 15 Jan 2020 11:22:38 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id j199sm4768058vsd.11.2020.01.15.11.22.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:22:37 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id y23so6699629ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:22:37 -0800 (PST)
X-Received: by 2002:ab0:30c2:: with SMTP id c2mr18534657uam.8.1579116157297;
 Wed, 15 Jan 2020 11:22:37 -0800 (PST)
MIME-Version: 1.0
References: <CAD=FV=W2xBFxOgdOM2=RJMB56wi24UUYqdR8WE63KKhxRRwsZQ@mail.gmail.com>
 <87v9pdxcc2.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9pdxcc2.fsf@nanos.tec.linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jan 2020 11:22:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XDPyJJEzjQTd8=6Om0i0HYRfin1+X5Feqcdu5oM0Ro+g@mail.gmail.com>
Message-ID: <CAD=FV=XDPyJJEzjQTd8=6Om0i0HYRfin1+X5Feqcdu5oM0Ro+g@mail.gmail.com>
Subject: Re: [PATCH 2/4] alarmtimer: Make alarmtimer platform device child of
 RTC device
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <swboyd@chromium.org>,
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

On Wed, Jan 15, 2020 at 2:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
> > On Thu, Jan 9, 2020 at 7:59 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> >> index 4b11f0309eee..ccb6aea4f1d4 100644
> >> --- a/kernel/time/alarmtimer.c
> >> +++ b/kernel/time/alarmtimer.c
> >> @@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
> >>         unsigned long flags;
> >>         struct rtc_device *rtc = to_rtc_device(dev);
> >>         struct wakeup_source *__ws;
> >> +       struct platform_device *pdev;
> >>         int ret = 0;
> >>
> >>         if (rtcdev)
> >> @@ -99,6 +100,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
> >>                 return -1;
> >>
> >>         __ws = wakeup_source_register(dev, "alarmtimer");
> >> +       pdev = platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);
> >
> > Don't you need to check for an error here?  If pdev is an error you'll
> > continue on your merry way.  Before your patch if you got an error
> > registering the device it would have caused probe to fail.
>
> Yes, that return value should be checked
>
> > I guess you'd only want it to be an error if "rtcdev" is NULL?
>
> If rtcdev is not NULL then this code is not reached. See the begin of
> this function :)

Wow, not sure how I missed that.  I guess the one at the top of the
function is an optimization, though?  It's being accessed without the
spinlock which means that it's not necessarily reliable, right?  I
guess once the rtcdev has been set then it is never unset, but it does
seem like if two threads could call alarmtimer_rtc_add_device() at the
same time then it's possible that we could end up calling
wakeup_source_register() for both of them.  Did I understand that
correctly?  If I did then maybe it deserves a comment?

-Doug
