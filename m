Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DAEC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9A7206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgAOKHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:07:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgAOKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:07:17 -0500
Received: from [5.158.153.55] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irfZz-0000VM-0i; Wed, 15 Jan 2020 11:07:15 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 64051101225; Wed, 15 Jan 2020 11:07:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/4] alarmtimer: Make alarmtimer platform device child of RTC device
In-Reply-To: <CAD=FV=W2xBFxOgdOM2=RJMB56wi24UUYqdR8WE63KKhxRRwsZQ@mail.gmail.com>
Date:   Wed, 15 Jan 2020 11:07:09 +0100
Message-ID: <87v9pdxcc2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:
> On Thu, Jan 9, 2020 at 7:59 AM Stephen Boyd <swboyd@chromium.org> wrote:
>> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
>> index 4b11f0309eee..ccb6aea4f1d4 100644
>> --- a/kernel/time/alarmtimer.c
>> +++ b/kernel/time/alarmtimer.c
>> @@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
>>         unsigned long flags;
>>         struct rtc_device *rtc = to_rtc_device(dev);
>>         struct wakeup_source *__ws;
>> +       struct platform_device *pdev;
>>         int ret = 0;
>>
>>         if (rtcdev)
>> @@ -99,6 +100,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
>>                 return -1;
>>
>>         __ws = wakeup_source_register(dev, "alarmtimer");
>> +       pdev = platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);
>
> Don't you need to check for an error here?  If pdev is an error you'll
> continue on your merry way.  Before your patch if you got an error
> registering the device it would have caused probe to fail.

Yes, that return value should be checked

> I guess you'd only want it to be an error if "rtcdev" is NULL?

If rtcdev is not NULL then this code is not reached. See the begin of
this function :)

Thanks,

        tglx
