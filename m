Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD8EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983782076A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m691b3tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgEPJat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbgEPJat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:30:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21DC05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:30:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so4743777ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5T9hQMIe1D/f51iIfhrDEL/PLl5vY2+2w0v+LSamN4=;
        b=m691b3txDQl92upzOLE5lEnAeh4PYLToC1WZu/Q634s005NwQPzSoRWsyERlxc985m
         5PgFGMyBLl1zI+KK35wTSO0kJMTfqCJ8A3MsMCC02ynymU8xYwE7Vr54aw0e3jJ1A9AV
         GCgjEb7pZgsXTBc1YMgWLSia2SVHDu/gRX3RziqDZpGgc7zkZetAwoOY9cK1UYuaSHsP
         MBH60IcnXnza4nQuwLMK7nOuoRn4QZdJRCE7uT8Lh+uH43AtNwNZ/A+Z4p36cd+AnnHu
         68TVjCZdzFpYZnhzmfeEpgpnqq/YrBdl8ZfdAm2pGBWybxOlNUODAAMX0FyDuCMZO8NU
         hgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5T9hQMIe1D/f51iIfhrDEL/PLl5vY2+2w0v+LSamN4=;
        b=OmL7fyWAbLYiXkqrem3MbR75nE1+UYVvne5HPxmMfkcoQ5MVAtl59P+a7pDfOzmx+s
         t6Q6o3xlBNidM7mRiT4NML37lmCC3feEXf6iUmfsJiNsZ4fCbS9bbYorVH+S4LkGWbgz
         ZuYUwobAERjDySt+ghHOUlmRO0u8yivBesV1VJReh2pMdqyT9T8eAaajMfo0R9GmOtji
         q3b/fC6XmeIqMHUHIMpybzHkUQbMZtKWEnn57y/W52HSMlMr2yZOUS6QdSacG+Vwjl80
         PgOiujQfBLKyicCH8/7qcBipNsDXW0Lbq6QFZR3BgPyNhgJ71ti2m6g5DHrHv/lRy7eR
         ihXA==
X-Gm-Message-State: AOAM53030b+A73xcexq3gzdZyLSUxNsi2O93C37whtpawyed0cYz1O1b
        xSiwDdTNC2HBVh5g05PInqDjw0/g7bAJSkAjtMWfnLGX
X-Google-Smtp-Source: ABdhPJwhNNHCnYEN5PX+Rf8+hr4dw2XtQ7VKh1pmMRbupDUV3DJpSTVJkZZmN9FsC0GxfweAWevclSfnBL/rZ0Vm6zw=
X-Received: by 2002:a2e:8805:: with SMTP id x5mr4987823ljh.223.1589621447199;
 Sat, 16 May 2020 02:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200509141507.19531-1-brgl@bgdev.pl>
In-Reply-To: <20200509141507.19531-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 May 2020 11:30:36 +0200
Message-ID: <CACRpkdZ2WGs=aWjwS=vk6-PDMvXMLppfBBF-8rs42F=ko3biNg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: notify user-space about line status changes
 after flags are set
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 4:15 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Since the flags can be configured in different ways depending on how the
> line is being requested - we need to call the notifier chain in different
> places separately.

Ooops.

> This comes late in the release cycle but I only recently got down to
> writing libgpiod support for this new ioctl(). When writing test cases
> I noticed this doesn't really work as expected.

This is why I am so grateful about the tests you are doing with
libgpiod! We actually find these problems quickly and not after
years. Thanks!

> This patch fixes the
> issue I identified this week. There may be more coming the following
> week though...

I will pull in your pull request once the next -rc is out as I had already
sent my first pull request, but do not hesitate to bug me about this.

Yours,
Linus Walleij
