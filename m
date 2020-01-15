Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2FC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CA52465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8qtmWdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAOQru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:47:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46677 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAOQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:47:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so8447483pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=v/2Up0PFtIlsPxiJvXtazrmjOUMQoxRhjvtQu6hdcr4=;
        b=P8qtmWdJtJ7m7pW+HgRUOb1CJbaL+4F5Y2LnAnWC3VsYXsiS8aj1YOif00meRaRXAm
         TNOvNw0b4CYtgRIumf3okxBeTk+VVIX92ubWcBHtyliJwkgXChgNE33azRcmikfawhEl
         x7Yfwi3+81XfqpLHFiXMabdiaEmjdnEsa8Chk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=v/2Up0PFtIlsPxiJvXtazrmjOUMQoxRhjvtQu6hdcr4=;
        b=tWr7avT8c3DUtccGN68TT9kK7b7uPC44vRNTpfK3QfSSqXjRH9crV0Cp3fMGj6ylfx
         fcuwFg8HB/oJkHoJYj70QNvQIMQXT2XBxITnJdWpuxa+sAepogqDTQK+QO72xNku43uK
         uyTpGNNGodZpWHQmBZV8ChNmAO9+/Ms4V1o2GVpXwIiilKkIZSbpkmpPTVOGXu0TSnQ2
         zi0L9gbHXcQcdMGEFFt9e5BmPTaC7w8hvnSXqhgYKwhTcdzLPnKCqYsIMLruux6cgweM
         OIsYORscaZf4llTh1BbvRWk6J15E4SGjOskKwxGbrLvXWQkvk6gDcGr6ZyrDRE5YOXVu
         BHzg==
X-Gm-Message-State: APjAAAW6qdmRwBye+TqYLmPaRkPqCwWqujK1jVIthrwWq1Ao0txZ0ZJU
        8yyPjEM2vvmBamgyzv7LYKQHVA==
X-Google-Smtp-Source: APXvYqzerLLGTfjo+7XW33KV3+WCWZxbLyQn0HybE49ZK/8BTObIJ/ZnneFo7LZI7i5hytZcqXaAXg==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr31482777pfp.97.1579106869688;
        Wed, 15 Jan 2020 08:47:49 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u18sm21192621pgi.44.2020.01.15.08.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:47:49 -0800 (PST)
Message-ID: <5e1f4235.1c69fb81.7041e.36a0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87v9pdxcc2.fsf@nanos.tec.linutronix.de>
References: <87v9pdxcc2.fsf@nanos.tec.linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
To:     Doug Anderson <dianders@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/4] alarmtimer: Make alarmtimer platform device child of RTC device
User-Agent: alot/0.8.1
Date:   Wed, 15 Jan 2020 08:47:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2020-01-15 02:07:09)
> Doug Anderson <dianders@chromium.org> writes:
> > On Thu, Jan 9, 2020 at 7:59 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> >> index 4b11f0309eee..ccb6aea4f1d4 100644
> >> --- a/kernel/time/alarmtimer.c
> >> +++ b/kernel/time/alarmtimer.c
> >> @@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device *=
dev,
> >>         unsigned long flags;
> >>         struct rtc_device *rtc =3D to_rtc_device(dev);
> >>         struct wakeup_source *__ws;
> >> +       struct platform_device *pdev;
> >>         int ret =3D 0;
> >>
> >>         if (rtcdev)
> >> @@ -99,6 +100,7 @@ static int alarmtimer_rtc_add_device(struct device =
*dev,
> >>                 return -1;
> >>
> >>         __ws =3D wakeup_source_register(dev, "alarmtimer");
> >> +       pdev =3D platform_device_register_data(dev, "alarmtimer", -1, =
NULL, 0);
> >
> > Don't you need to check for an error here?  If pdev is an error you'll
> > continue on your merry way.  Before your patch if you got an error
> > registering the device it would have caused probe to fail.
>=20
> Yes, that return value should be checked
>=20

Ok. Should __ws also be checked for error? I'm currently thinking of this p=
atch
and then simplifying it in patch 3 of this series by removing __ws. Or
the series can swap patch 2 and 3.

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ccb6aea4f1d4..3e1f4056e384 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -103,7 +103,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	pdev =3D platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);
=20
 	spin_lock_irqsave(&rtcdev_lock, flags);
-	if (!rtcdev) {
+	if (__ws && pdev && !rtcdev) {
 		if (!try_module_get(rtc->owner)) {
 			ret =3D -1;
 			goto unlock;
@@ -115,6 +115,8 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		ws =3D __ws;
 		__ws =3D NULL;
 		pdev =3D NULL;
+	} else {
+		ret =3D - 1;
 	}
 unlock:
 	spin_unlock_irqrestore(&rtcdev_lock, flags);

