Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AC0C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FAA222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c53ZpcVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgAOUbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:31:48 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39663 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:31:47 -0500
Received: by mail-vs1-f68.google.com with SMTP id y125so11263500vsb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APQ1UV/G1//faBWOjZt5MAENkmiTNmeLgnXeENgbs5M=;
        b=c53ZpcVMAKouxu/O6ib/onjxdpwkmNfRURW42BxVckNoirhL9c5EZZLI/16CyFPG+y
         5HlcmTV8VIrlqAA67j3vbJDJG8TvOPkzV00eIJ4Y420Vpc7q4v/9rhlC7jq+kL5xleiH
         7wWcG84OpdKU3kzY6yX37K0XseJK1Yon2xp3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APQ1UV/G1//faBWOjZt5MAENkmiTNmeLgnXeENgbs5M=;
        b=t8hEsmKve9QVejBEsbPXh/NDJkzzu8DBzq6AEZIrbsk8nGDmrG3mNqOB5Viys6g2JT
         dSCM4M1/GtKHZ1as2FSszmg79p8/FFHVee98YlOc1f/rloSx+2vownEFsDiS+TSFAUNy
         dloYldaQrb06TJRwd6Lq81d9HL0FVfK4Ac6eA+UcFIhyn5dK1M7EGPP02ck8czQ/yOMM
         b0nhuIMsrQzBYl8ZhAbHjDXQowsNCUHw/LvYOL4wEt6Zrsdh26YKrvVoZB2KLcw/suNx
         GhPAp+1XFbl9GX193AVZGNLO27hQuYyjmwg1vEHXR2bO53HhyOU5HXd61+THOdZpSoNd
         iv3Q==
X-Gm-Message-State: APjAAAX8SsBE7TRL80LTAsYU5czx9+O7vKz8cVB+IdIoD7+q3DQN011a
        WXtoQIgDdlPLH7BUo8EG5BRqZ6IFkhI=
X-Google-Smtp-Source: APXvYqw7H5F6kr0wknJLxPQp9eMWHKLduXnTuJGvP9ldGw8budqp1Bk9TSv9y0IeV8ou86qvQfiKXA==
X-Received: by 2002:a67:cd0a:: with SMTP id u10mr5731976vsl.156.1579120306353;
        Wed, 15 Jan 2020 12:31:46 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id v85sm5747185vkd.8.2020.01.15.12.31.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 12:31:45 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id 59so6781033uap.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:31:45 -0800 (PST)
X-Received: by 2002:ab0:2006:: with SMTP id v6mr17367655uak.22.1579120305258;
 Wed, 15 Jan 2020 12:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20200109155910.907-1-swboyd@chromium.org> <20200109155910.907-5-swboyd@chromium.org>
In-Reply-To: <20200109155910.907-5-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jan 2020 12:31:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WZpxDV8F-nZ_25XaPKvb0qCmpVUpi2Xzr=KR2PrdN6KA@mail.gmail.com>
Message-ID: <CAD=FV=WZpxDV8F-nZ_25XaPKvb0qCmpVUpi2Xzr=KR2PrdN6KA@mail.gmail.com>
Subject: Re: [PATCH 4/4] alarmtimer: Always export alarmtimer_get_rtcdev() and
 update docs
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
> The export isn't there for the stubbed version of
> alarmtimer_get_rtcdev(), so move the export outside of the ifdef. And
> rtcdev isn't used outside of this ifdef so we don't need to redefine it
> as NULL.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  kernel/time/alarmtimer.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
