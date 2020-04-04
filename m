Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE02C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA909206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="ilFI7CUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDDHbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 03:31:24 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36919 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 03:31:24 -0400
Received: by mail-vs1-f68.google.com with SMTP id o3so6486591vsd.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYYENpUenW1mOBtwvfCGSxitkk6MXuBt0h7Pv0y2XUQ=;
        b=ilFI7CUrtJSEbObp2HesFPiTB4AR1aiGuk3EnDSRgtX/hwzeXMsExL2JaxO3jukIrv
         bcZq/X+c6g5rUrI0WibAck/3jqs7Lsf1ZO3RkQvy9GlgeUr5NBsDVaRSokXfeErqJH/m
         +ypokOKM2lLOG/f/i0r0id7QKcV/EZzcTzyro6x2KQdl8zo6UolTEDgOaM+6WpvSVgzX
         ZeSQPU4Z26g/Fubo9b6HdX/srMgQOQNwie9R8i31ifBU5Nt7PFmCPlJ9DO/mZB4wZvoy
         kGzWQpdQVSZ+Kza8C6OzMgT6xItrCu/zTyGVdqZHbSsA/36e69UeMiLIWjBfw+zVeYKr
         2vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYYENpUenW1mOBtwvfCGSxitkk6MXuBt0h7Pv0y2XUQ=;
        b=AQG+E6+SdSSk6PleTPe95Bbixrb87je9TUbXMOeMtW+gve1z6pq+lu4b46sii7b4US
         OvJFV1Xd3AFtXrFGJfeJiG/JAjIiFx/Ok2vppYMtFGlVtyIJK8ivrk8/3+UQRLxDZxjQ
         d2CISMtL2Joh1zgKTFTb6poKptlfZ08TvekYVwH61T9vsVywm7iXoHIQyzALg1Jcbpk0
         vSZ+tYicbb5pq1u7nbQRGH1RAgRyZ+ndbFYKKGdacq0q4oifKy3auT388jimWCmDzIAy
         c8U6/UUN1GjxazzDgrarbF8V69QkoiRx/ErjbSR4FY/TeZuUeQyO5vfA160XqzKTysc+
         gtMA==
X-Gm-Message-State: AGi0PuYDc3fv8x6+kN3JoskzIJMc4mSVlXYv9Kx8mLZ8GOxqBOOQ9tr2
        B2BN894hcaO1f0cUralCM7MKI3l6tNQ1nhuRip0xtA==
X-Google-Smtp-Source: APiQypIwudVuiXe/LMRHhc+8ubP3TRukmM9WaTm2+ZWP9jINOT+vAJPzu1MSDfRi5eRWTsLpXV+EashporgRQZI943w=
X-Received: by 2002:a05:6102:104b:: with SMTP id h11mr9409688vsq.182.1585985482961;
 Sat, 04 Apr 2020 00:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-8-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-8-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerMD5fJR1nEeXPhX-=5WfTZ681KuLswcY5xXw2jfTXskWA@mail.gmail.com>
Subject: Re: [PATCH V2 8/9] thermal: Remove stubs for thermal_zone_[un]bind_cooling_device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> All callers of the functions depends on THERMAL, it is pointless to
> define stubs. Remove them.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  include/linux/thermal.h | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 12df9ff0182d..7b3dbfe15b59 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -426,16 +426,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
>  static inline void thermal_zone_device_unregister(
>         struct thermal_zone_device *tz)
>  { }
> -static inline int thermal_zone_bind_cooling_device(
> -       struct thermal_zone_device *tz, int trip,
> -       struct thermal_cooling_device *cdev,
> -       unsigned long upper, unsigned long lower,
> -       unsigned int weight)
> -{ return -ENODEV; }
> -static inline int thermal_zone_unbind_cooling_device(
> -       struct thermal_zone_device *tz, int trip,
> -       struct thermal_cooling_device *cdev)
> -{ return -ENODEV; }
>  static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
>                                               enum thermal_notify_event event)
>  { }
> --
> 2.17.1
>
