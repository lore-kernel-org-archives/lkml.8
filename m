Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57533C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C8C2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1USJP9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390507AbgEYMRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbgEYMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:17:54 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:17:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so10396050lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8DvzM1LUfYPJBdMAba0GyfRQVQc3MJGiW7Qheov8do=;
        b=O1USJP9FRD9ErvJk3j1Wo8/HZnbUh1dbudkEcMZXs9b3+JA5YSohAmpC2l0A5R4WWL
         8so9pDmwPcsjzarfj/TurajHvn8PinNRJqIzYAWXoRh0o1P/KZMjN4gHRfQ5L29Ag0S8
         gH6mlXvB0OpNB2GH/Q2fzreA9V5QYcgyCSL7cX+gKpcFGo2YdciQwGo3SwkV7SzIJYOG
         Erprmj3VK8nXAAkN9QAixd6ql85fBt1oCgyLo/uhDq6g3ytZUFFkorM0ixnpGxe0cJVy
         MYUZulcB6jGK/7mCxKWXDk7u4tlfjSwT7Onm2xSYpVCTm9qTZnFmMs5B7VVxzUIwRjRe
         17aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8DvzM1LUfYPJBdMAba0GyfRQVQc3MJGiW7Qheov8do=;
        b=cbnWZP14rXZPywd6Rnv4URWDJEFezIHQv5xMR8W7q9ZLcsnb8XBAlWENDj5sPWp29V
         upeQsvFjYXVVvEJ4VTTs7RzCgoe35y9C7xUrm8haao7J2OwGHWTtTsew7+eFCMB2rsJA
         0K/oTjGpL1xj+vo160GkDPITk2JiJquRgAmf18rrwnVum5q5lddwGVbcUS5ttOGk2GCu
         xoCXSK5LQSmNvbYx9Y9+IdWoNFZCC4A4q38P5Nr4YMHuaYKShocFohoN8jwfBfvezPYw
         cmISJwK57f2otcNT+t42pmlGkmYGpsH7pjzxuxAPzoqD2IupMjFvVVqfyeJeczeAJirv
         T7Yg==
X-Gm-Message-State: AOAM530sdxOfY5aK6SlSvjnBIXE8mILo+2/AzEnSeQuQhlGHFevyRLXH
        8/xOJDDvg3TWwp9V8M+W2KgjO2hoxSmlsAGgj8jWwA==
X-Google-Smtp-Source: ABdhPJxPDl9RyoQe3gqtH2MDfzTuuUWC4/u0qXYZhxm+OrC7Hsr2aIclDWKtcuxX69PwCj0+z88e+AhBN+oSI0bEVbo=
X-Received: by 2002:a19:be87:: with SMTP id o129mr10724914lff.217.1590409072296;
 Mon, 25 May 2020 05:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200419001858.105281-1-hector.bujanda@digi.com>
 <CAMRc=MeHun_WEApEXP59ZszGa2n+wbU9qq3wU1VO9o590rO-Pw@mail.gmail.com>
 <CACRpkdaeXFW5K=Npy2ubWsffc7aepEQ5kSJ2HrkrESjaTy_psQ@mail.gmail.com> <20200525022252.GA22956@sol>
In-Reply-To: <20200525022252.GA22956@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 14:17:41 +0200
Message-ID: <CACRpkdagkhbULGVGJqcS55m=X2EaH_iK0Khr8+6M7ATWrC3hOQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add GPIO_SET_DEBOUNCE_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Hector Bujanda <hector.bujanda@digi.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 4:22 AM Kent Gibson <warthog618@gmail.com> wrote:

> You mention timers for the gpio pins that cannot provide debounce,
> so I'm confused. Could you clarify which strategy you have in mind?

My idea is that the callback gpiod_set_debounce() for in-kernel consumers
should more or less always return success. Either the hardware does
the debounce,  or gpiolib sets up a timer.

> I've also had a quick look at the possibility of providing the software
> debounce for in-kernel consumers.

That is where I think it should start.

>  Are you anticipating new API for
> that?  e.g. allowing consumers to request gpio events?  Cos, gpio_keys
> grabs the irq itself - and that would bypass the software debouncer,
> or even conflict with it.

It may be hard or impossible.

I suppose gpiolib would have to steal or intercept the interrupt
by using e.g. IRQF_SHARED and then just return IRQ_HANDLED
on the first IRQ so the underlying irq handler does not get called.

After the timer times out it needs to retrigger the IRQ.

So the consuming driver would se a "debounced and ready"
IRQ so when it gets this IRQ it knows for sure there is
no bounciness on it because gpiolib already took care
of that.

The above is in no way trivial, but it follows the design pattern
of "narrow and deep" APIs.

Failure is an option! Sorry if I push too complex ideas.

Yours,
Linus Walleij
