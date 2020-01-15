Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF1C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BD720684
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RvMhHJRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAODkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:40:39 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37128 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgAODkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:40:39 -0500
Received: by mail-vs1-f67.google.com with SMTP id x18so9664813vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drkpqV4r5dWLWeh/Ukq5CXTmFjT5tZtoP/NgpIicDAo=;
        b=RvMhHJRy0BKcdpGOX6edsro+XuCjnHLwFr84j9/MKXcFQEi6iV9aSjUXhnyayQmDaZ
         b/iU4wY6vWtpU1ib7BIS4Y8FTrzJc+n7neeL7qYjCl7yc6Uy3FiuHcIDupcU86VZx6GJ
         jV8lOMJrNPdMpTUZ44ys37llBz28zb+hBWkhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drkpqV4r5dWLWeh/Ukq5CXTmFjT5tZtoP/NgpIicDAo=;
        b=h3Mgcf7uOyXLVAjJPXcik1O/u8by0a5uDDAgNGNQ7iDXu8my58ARFjRcEZ/1dzWa4+
         tbimNhGCha3znT6/v82TqkMohgEgx61qAX08MM2i6n2ejwx1AnXbFtdaJr026mPGQbyG
         M7oZVrLMWU8GK2LAY43hj0w8+oFt67I/eWSKeuaF4K0Xm4BTCoEctfiGSwXJ4BneYPeG
         QCKC4PgXZgugDvM0nCWFpuRZg94mTZcaEpwDb+YVZy4Jo9NptloPj8+PTmEgPNNeZGGk
         IyRQrJlHmlWRcbGLDpcl539GzO5eViw/HfxLAaBIvJJ17lSdTQlacdqXmdHOkDoTsOsY
         z9PQ==
X-Gm-Message-State: APjAAAVtCDbbPhFLh6YujEYTy7m/cRdNWyrpWspNDWtGza60duhxylHB
        9DWpT/hRj4gm3n2Rn++HSBlJI/Vw+M4=
X-Google-Smtp-Source: APXvYqy34ijEtHqJLdTJNKENchlHNtPE5sMEsjw2p0GUUtf9ZPCutFLi3YQMAIIEmw6rBV0xjdkMSA==
X-Received: by 2002:a67:f8c8:: with SMTP id c8mr3380962vsp.196.1579059638125;
        Tue, 14 Jan 2020 19:40:38 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id n25sm5138875vkk.56.2020.01.14.19.40.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 19:40:37 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a12so5745457uan.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:40:37 -0800 (PST)
X-Received: by 2002:ab0:254e:: with SMTP id l14mr13216859uan.91.1579059637158;
 Tue, 14 Jan 2020 19:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20200109155910.907-1-swboyd@chromium.org> <20200109155910.907-2-swboyd@chromium.org>
In-Reply-To: <20200109155910.907-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jan 2020 19:40:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XJZCebpa_Yas_riZhdKz+Gz+dL5CMeu+8+NmWxJ92dAA@mail.gmail.com>
Message-ID: <CAD=FV=XJZCebpa_Yas_riZhdKz+Gz+dL5CMeu+8+NmWxJ92dAA@mail.gmail.com>
Subject: Re: [PATCH 1/4] alarmtimer: Unregister wakeup source when module get fails
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
> The alarmtimer_rtc_add_device() function creates a wakeup source and
> then tries to grab a module reference. If that fails we return early
> with a -1, but forget to remove the wakeup source. Cleanup this exit
> path so we don't leave a dangling wakeup source allocated and named
> 'alarmtimer' that will conflict with another RTC device that may be
> registered.
>
> Fixes: 51218298a25e ("alarmtimer: Ensure RTC module is not unloaded")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  kernel/time/alarmtimer.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
