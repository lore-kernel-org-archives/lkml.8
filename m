Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49083C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162AF206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BU+9LphH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgD1OAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgD1OAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:00:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87806C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:00:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d25so2050677lfi.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwLBtHMxIouz6WBeC7Ry6rusTbPMGQuVa1Crv6UC2Xo=;
        b=BU+9LphHkBjB7hH3z9ucS+MQDbJGncdMqaSIrZNJDwbF7FB/iurPpMj9+WTW1eINtV
         S+zPTDnJ2xc37hyY/wcVjeGHslM6ThBq1dhnjpBW/0YueJvJrSSUE4hAHM9EEyacv3Ro
         B4Za1VsqsZSuElBjM85ap7CwkGKyGxqqN7dtffSV9ZXfDzfNtS9JLqmcjjuPzSrfUaBK
         svAItVmk9afH4cQWB3NgbC+jjqW/aQxBvNk83ZIHRMWRmn1wKI1nxz2I3zt0djJgqNvX
         6pfBW4YM3wGhGZ0YVH8s1R7KHYvSvKB3Tydn+/GBEY6VmzY0tVzY4gNFP0OsRxKZZLkF
         EAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwLBtHMxIouz6WBeC7Ry6rusTbPMGQuVa1Crv6UC2Xo=;
        b=rV223RtFioUQo0aHlV3mfc2+rAk/btfg0sFGXV4IF+S2WLarJ4JTIKl3lBk15LPatF
         W+KwObCCzsiTw496gz76wJv7bgTHTPLXi28fTMTS/7ypSWXzvKcCy9/DdJP3neQ9yODc
         E9S8L98x8VNOwatLOVOl+Lp3LdTjFfy5ELMdDkY+A+8Gt99aocNOAh1ZX425b4FodiZL
         4G9qBpJCkHvzIj6B14+9B5Nb2LBiQKue/UX/4VSTsDAqbJ0jZGrfGY5HtXKKPnPv4Dcg
         UiguYgxKlWQnoGey+RrRhUtY6OWUZ5S9p1hGdcuW3a1b+7mc5J/jnT61fZnkR9Zzn3bK
         oaog==
X-Gm-Message-State: AGi0PuZbZ6y2Jpi+cGSwZBUAmcvngVI/BEdcY2TftaJ+OB9VH6pNgz7K
        jzVXksXMCHS5ypYAzj3NVXp0PjTddYPbL+LBAZRKkg==
X-Google-Smtp-Source: APiQypIYzSbT7CAknI2cCMtFL2RX7gZahBzPYkhQq2sZJSILQBDs0uGsOEbqwcRELaTFxqJh/6Pd64SWJfEU4rNWbvI=
X-Received: by 2002:ac2:5c4e:: with SMTP id s14mr19555025lfp.77.1588082448005;
 Tue, 28 Apr 2020 07:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200425044655.166257-1-davidgow@google.com>
In-Reply-To: <20200425044655.166257-1-davidgow@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 16:00:36 +0200
Message-ID: <CACRpkdY=CvSyKO+LpGqu06XVq5pdwycMwyey3U=-qzFY+Dpv4g@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: Build fails if CONFIG_OF_DYNAMIC enabled
 without CONFIG_OF_GPIO
To:     David Gow <davidgow@google.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frank.rowand@sony.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 6:46 AM David Gow <davidgow@google.com> wrote:

> The symbol 'gpio_of_notifier' doesn't exist without both CONFIG_OF_GPIO
> and CONFIG_OF_DYNAMIC enabled, but is referenced when only
> CONFIG_OF_DYNAMIC is enabled.
>
> This broke building with 'make ARCH=um allyesconfig':
> ---------------
> /usr/bin/ld: drivers/gpio/gpiolib.o: in function `gpiolib_dev_init':
> ./drivers/gpio/gpiolib.c:5293: undefined reference to `gpio_of_notifier'
> collect2: error: ld returned 1 exit status
> ---------------
>
> Fixes: 63636d956c45 ("gpio: of: Add DT overlay support for GPIO hogs")
> Signed-off-by: David Gow <davidgow@google.com>

Patch applied for fixes since it fixes a regression,
I recommend looking a bit down the dependency
chain as indicated by Geert if you have time!

Yours,
Linus Walleij
