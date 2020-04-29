Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B601CC83009
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C37208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMMGd7cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgD2Mi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgD2Mi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:38:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFDEC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:38:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so2437660ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiklenLhNOV+HKXdiZuFGpxcMEuzoxvnXmW3/CZQYZs=;
        b=fMMGd7cuYi00xYIotGRhY6Dnx7VYaht0u0LQuHp4fzcCDF9cBBdPfE+f8GXRMwcza0
         cLuwR336ZmgamL7yC676FL5jlkc5Yz1B+1TS4yVNxDprMVCznLRjQdK1bX816iSRAWxd
         vCvTGXv3tDcjKsafsNJiLTH2Z/TFLyyqrthbVHJxlAAPpgxWK/RlNhJUDw9OLXdE0smj
         kKtaF64FI9ricj+z5+PMpVi/HcrBHhYWQc6Hw715u3+ZxxFmFXuhjNN83YcHp7lHpcvi
         20w3ODJEGsB2yuhAXLnYyJ0Snyklwuq81N5iNcKJMXc7Xiiwx6j9alt/6cDGQgxFy6hX
         VDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiklenLhNOV+HKXdiZuFGpxcMEuzoxvnXmW3/CZQYZs=;
        b=EHL75X+PGwdD+FRmd8m5VQ21Mxe5aobYFJv52uMNGhL2DXKwfsfKbMSUTyM1Rije7W
         pc0c6w/Ze3Y4kVjNdJZjYXRx24L/Ckj19c1vDzBHA3ZU15BMVWkmgnZSYUJyKHbL2bgS
         QpnJR6C9wLT+2HwfPQGuGyNA5nTbJWsTaXDrVYDxTvXnVZHwR1+JcS7toDJFH5ycduER
         FySl3Ws2hdyUkkCFN1XZIfd5BUiNaMRpbsn4X/Tg74Egc3esrk8mpdxTRwJS4AmI8b5l
         s2Pi47gRcfq64+tKF4USP63rCWHnm7pWKmw6wtUxzr7bFIkciwfdXY3WPXIWAQ9mR5Jp
         wygQ==
X-Gm-Message-State: AGi0PuY1a9I1HI1gh1AF3m09jO8qwHYTgaSqSbn37Rktax1Zo6V9u8zR
        p/EGWR8PGO+lhKvaDDXf7VQNijj5pIvJ/a40+7Gm8nfltxQ=
X-Google-Smtp-Source: APiQypJSjoxKbAKfAOvydqwj3C8SjC23BV+vHuypyRaJJ1bGKEYT/DUGGPAuboZMKwIe81ZCOER6hgFyOq7nxIlRwZg=
X-Received: by 2002:a05:651c:1058:: with SMTP id x24mr21640311ljm.39.1588163905575;
 Wed, 29 Apr 2020 05:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200419001858.105281-1-hector.bujanda@digi.com> <CAMRc=MeHun_WEApEXP59ZszGa2n+wbU9qq3wU1VO9o590rO-Pw@mail.gmail.com>
In-Reply-To: <CAMRc=MeHun_WEApEXP59ZszGa2n+wbU9qq3wU1VO9o590rO-Pw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Apr 2020 14:38:13 +0200
Message-ID: <CACRpkdaeXFW5K=Npy2ubWsffc7aepEQ5kSJ2HrkrESjaTy_psQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add GPIO_SET_DEBOUNCE_IOCTL
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hector Bujanda <hector.bujanda@digi.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 2:06 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> I understand the need to set debounce time to make line events
> reliable. As I see it: there'll be a couple steps to add this.

I think there is a serious user-facing problem here though, because
not all GPIO controllers supports debounce, so the call may return
"nope" (error code).

I think that is unavoidable with things like pull-up/down or drive
strength, but for debounce I think we could do better.
drivers/input/keyboard/gpio_keys.c contains generic
debounce code using kernel timers if the GPIO driver
cannot provide debouncing, and I have thought for a long
time that it would be nice if we could do this generic, so that
we always provide debouncing if requested, even for in-kernel
consumers but most certainly for userspace consumers,
else userspace will just start to reinvent this too.

Yours,
Linus Walleij
