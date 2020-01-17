Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E5C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D2D2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579224322;
	bh=j4mnlEJdoA/jwa1rGI+9ejQiMGQanMfxl1fbyaBC9p8=;
	h=In-Reply-To:References:Subject:Cc:To:From:Date:List-ID:From;
	b=XPuMBOBj8h4SsqONUMJJt6o6jtLbcywp1vMtQ5GtHloe3SbqtXScpgi7jQOhFPLQV
	 NRrS6a6woHXCKOioABFLzFcgVcFOUaxX1uScl6DSDjnkfniXXgT1oMTfrBw5Tj1Z5+
	 euMImNmjJN6dAuuu5C+i1yyxPIJDim0rwt+WfVOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbgAQBZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbgAQBZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:25:21 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1234720728;
        Fri, 17 Jan 2020 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579224320;
        bh=j4mnlEJdoA/jwa1rGI+9ejQiMGQanMfxl1fbyaBC9p8=;
        h=In-Reply-To:References:Subject:Cc:To:From:Date:From;
        b=D4G3h1EbXu2sBRiRvJEHAXjtVk8fabUlEMmN8teaDdMOf0n+Ra495WProIB6NoVNT
         Fqd1pygPSy3ppvIhd0ySQMM3YrWsI0cBPVMoWOZ0oTMdDBKMLUtw7WXluK6EETkz28
         6JjvJc3hczAalb8a8ZnUNb0tta8DN9G+ylwHLF14=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=XDPyJJEzjQTd8=6Om0i0HYRfin1+X5Feqcdu5oM0Ro+g@mail.gmail.com>
References: <CAD=FV=W2xBFxOgdOM2=RJMB56wi24UUYqdR8WE63KKhxRRwsZQ@mail.gmail.com> <87v9pdxcc2.fsf@nanos.tec.linutronix.de> <CAD=FV=XDPyJJEzjQTd8=6Om0i0HYRfin1+X5Feqcdu5oM0Ro+g@mail.gmail.com>
Subject: Re: [PATCH 2/4] alarmtimer: Make alarmtimer platform device child of RTC device
Cc:     Stephen Boyd <swboyd@chromium.org>,
        John Stultz <john.stultz@linaro.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 16 Jan 2020 17:25:19 -0800
Message-Id: <20200117012520.1234720728@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-01-15 11:22:26)
> Hi,
>=20
> On Wed, Jan 15, 2020 at 2:07 AM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
> >
> > Doug Anderson <dianders@chromium.org> writes:
> > > On Thu, Jan 9, 2020 at 7:59 AM Stephen Boyd <swboyd@chromium.org> wro=
te:
> > >> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> > >> index 4b11f0309eee..ccb6aea4f1d4 100644
> > >> --- a/kernel/time/alarmtimer.c
> > >> +++ b/kernel/time/alarmtimer.c
> > >> @@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device=
 *dev,
> > >>         unsigned long flags;
> > >>         struct rtc_device *rtc =3D to_rtc_device(dev);
> > >>         struct wakeup_source *__ws;
> > >> +       struct platform_device *pdev;
> > >>         int ret =3D 0;
> > >>
> > >>         if (rtcdev)
> > >> @@ -99,6 +100,7 @@ static int alarmtimer_rtc_add_device(struct devic=
e *dev,
> > >>                 return -1;
> > >>
> > >>         __ws =3D wakeup_source_register(dev, "alarmtimer");
> > >> +       pdev =3D platform_device_register_data(dev, "alarmtimer", -1=
, NULL, 0);
> > >
> > > Don't you need to check for an error here?  If pdev is an error you'll
> > > continue on your merry way.  Before your patch if you got an error
> > > registering the device it would have caused probe to fail.
> >
> > Yes, that return value should be checked
> >
> > > I guess you'd only want it to be an error if "rtcdev" is NULL?
> >
> > If rtcdev is not NULL then this code is not reached. See the begin of
> > this function :)
>=20
> Wow, not sure how I missed that.  I guess the one at the top of the
> function is an optimization, though?  It's being accessed without the
> spinlock which means that it's not necessarily reliable, right?  I
> guess once the rtcdev has been set then it is never unset, but it does
> seem like if two threads could call alarmtimer_rtc_add_device() at the
> same time then it's possible that we could end up calling
> wakeup_source_register() for both of them.  Did I understand that
> correctly?  If I did then maybe it deserves a comment?

It also looks like we call wakeup_source_register() and get lucky that
they're both called alarmtimer but they don't conflict with each other
in sysfs. Once we try to add a device named "alarmtimer" to the platform
bus it is the only one that can be added. I'll have to make this
autogenerate some number for the device instead of using -1 as the id so
that we don't see device name conflicts on the same bus.

