Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F02BC433F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C968207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qraFjx5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgGRJZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgGRJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:24:55 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3418C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:24:52 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so9479799qtq.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFno1i8ULLYg3FCWz/CmmFbzrbZUMcHSe/iu00Qu+g4=;
        b=qraFjx5YB4bZTW6OHepRqQaJ0u0cZulZzc6jCeVJQqh5HmzdjraCoxIsFGOjzxFbEr
         J/CjhdP91NLLJbeYiRuK4+TC+KK/tuE8uSpy/P6hs/dQ0owN3mLDZlkgzjRMUerX3Px+
         VPE0K7m+Zvh7kJj5V9I3nWFF5+YxZuU6jLmxxOd+Sl4CduA9BetaIgNS9UlkwgeUssFl
         jTZSEDd5UWQd+VG1l2IiIf0dx0bE7QcrBp5OtohGKUQkHa6aaurNk1pxMjP+FFxojDy0
         HRPP6UodUcCNU8GyTEuMzs8KKjUjxbWToLpHa61Q0w2hAsZPR34YPEH6PSZ2y252A1w8
         uZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFno1i8ULLYg3FCWz/CmmFbzrbZUMcHSe/iu00Qu+g4=;
        b=QgDj9eKWr3EhySZXW/7l2l9U1RvdppQWDbvaCGRV/OQ1OEI684kRNOOvAyDxP3G/HD
         VD/VGADCaO9HKKtZCtCZPXUufr9kYNhcswezGXzmHTKhrhIJwOpomAIYy4leIr4XUCPZ
         7nYGybBUQgbXayLPsQ/U0zU6oIywUhDgsD9hh4Cn9u8V/stPghKLZxa+R22z3MQYXxTP
         JThLHFlWouL82LtHYuvcMavQOI0pRTbJjGM4vnHsG6FWFdDz8CtmFeneSlk0wLSuPlPH
         LikqSfm2xnRxMDpBECY74N/bumIAUY3GN+5UNrEWaE5oE05rsv/Yxi2TF8NimZlpeMMn
         j1CA==
X-Gm-Message-State: AOAM530M2wSAkLqrsUVXVMWxMp5nIGTiaHqnbsQiYbEHpYU9OvyiJtT1
        yKUjLSBghrqzvsYodUmLuFzjFmnt3XHsvBk32uvtBQ==
X-Google-Smtp-Source: ABdhPJzM6hZdvPE/up0GYkD8TSobS6uRvY5KVvY9t3AZiSjoUmWbKbOG/uO8a8eca75CeRF2Y+PpLa68jllHUSws0Bg=
X-Received: by 2002:aed:2684:: with SMTP id q4mr14373679qtd.208.1595064291603;
 Sat, 18 Jul 2020 02:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200716135928.1456727-1-lee.jones@linaro.org> <20200716135928.1456727-16-lee.jones@linaro.org>
In-Reply-To: <20200716135928.1456727-16-lee.jones@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sat, 18 Jul 2020 11:24:40 +0200
Message-ID: <CAMpxmJU1NZniOOofWykaHmpJDD=ZDw2HpRofDHHF01fvr_JZfA@mail.gmail.com>
Subject: Re: [PATCH 15/30] iio: dummy: iio_dummy_evgen: Demote file header and
 supply description for 'irq_sim_domain'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 3:59 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> File headers are not good candidates for kerneldoc.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/iio/dummy/iio_dummy_evgen.c:30: warning: Cannot understand  * @regs: irq regs we are faking
>  on line 30 - I thought it was a doc line
>  drivers/iio/dummy/iio_dummy_evgen.c:42: warning: Function parameter or member 'irq_sim_domain' not described in 'iio_dummy_eventgen'
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/iio/dummy/iio_dummy_evgen.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
> index ee85d596e5284..1febbbff0ded6 100644
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (c) 2011 Jonathan Cameron
>   *
>   * Companion module to the iio simple dummy example driver.
> @@ -27,11 +27,13 @@
>  #define IIO_EVENTGEN_NO 10
>
>  /**
> + * struct iio_dummy_eventgen
>   * @regs: irq regs we are faking
>   * @lock: protect the evgen state
>   * @inuse: mask of which irqs are connected
>   * @irq_sim: interrupt simulator
>   * @base: base of irq range
> + * @irq_sim_domain: irq domain

To be even more clear: this could say: "interrupt simulator domain".

Bartosz

>   */
>  struct iio_dummy_eventgen {
>         struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
> --
> 2.25.1
>
