Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E8C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85477207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swXiWY6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAONjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:39:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35859 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAONjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:39:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so18613368ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 05:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnFqhhxBgQQrOJG9VMdTSVWlyDTWq02NzG7Ll7SsmRU=;
        b=swXiWY6KtW6USAXgEF0BKmbRj8LNW2I0j8lCKzuFISPOymqu0FzmXNJs5VC4vllHNJ
         5SS/9bDE/mXoEUeZVvqCUd2O3WPwH4GNxMuw+graItXIG3VM+lH03nQH81uZuOBgOBo1
         /lX4qIrezmOEb4dOV2tWHyesD68BpcYKeA5lrGEalqR2YFsjMNAtXVpDz7jYy7mdeRK1
         g4ocSnJvWJ13IUcdDr9dobxgGb1pG667VzZgrU13mTg2V+yYgxSupC3KOofzQ7RZNJhh
         4EQ2/WlLxQttVJuIoTekn5pf4p5YpPHcc89VnzzV3x6284yplbJ40lJw2MVkVKqqxI8X
         m3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnFqhhxBgQQrOJG9VMdTSVWlyDTWq02NzG7Ll7SsmRU=;
        b=lOFbdgPMUf2KU0MIuC30FDfVhnDERtq7m9ID9ZrU4BAreRPITqlT3NKNlJc02zXAa/
         5kOW4oSHY1DSZnfVgSL0oZkK4b6KBoUa6aXmHidFfrtsFtrC/d39UnpLLLVVqQvwTLqy
         fIFPFIEQ0ZGsjPnkm24oLSaDiVCTNPBao7ubu7DGUYFPKxt/NTMNa/6XsztSYQG+2Z2+
         rW8XQti1f/GT8FnLnQTC4f0LyTzkLx6is77siDENSU7qKVT2GUU7odzmVFCkUa31jciE
         +RkyaWznz5Ah0vzI/oUu7dfxWgdciDt1vVa8dkB/2GhB6Zfhv68VOYzSyFSRhNkcdK/X
         /Iew==
X-Gm-Message-State: APjAAAV8rz2hSFkbEMyGsuAxLqyV5kcI2kKHu9IMY2ZQP0R/cAG0V6Ek
        77i9pHFpr8pNoDNowTt1d/g4R+AyB01J7Azvz2C+Nw==
X-Google-Smtp-Source: APXvYqz9duMnYhOhVoTHoDmR2ennOQ8ot3KTXdINAT2gaDQVsmk8rQh2KItxvjbbdVC7xLJ1Lvjbw6id0ZXwkJ2LKXI=
X-Received: by 2002:a2e:9143:: with SMTP id q3mr1765334ljg.199.1579095586705;
 Wed, 15 Jan 2020 05:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20200108121117.45060-1-yuehaibing@huawei.com>
In-Reply-To: <20200108121117.45060-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 14:39:35 +0100
Message-ID: <CACRpkdYzKmbx55h0G=fLRMat7CBOKgLScCdvH+T=heebx4asAw@mail.gmail.com>
Subject: Re: [PATCH -next] gpiolib: remove set but not used variable 'config'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 1:11 PM YueHaibing <yuehaibing@huawei.com> wrote:

> drivers/gpio/gpiolib.c: In function gpio_set_config:
> drivers/gpio/gpiolib.c:3053:16: warning:
>  variable config set but not used [-Wunused-but-set-variable]
>
> commit d90f36851d65 ("gpiolib: have a single place
> of calling set_config()") left behind this unused variable.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with Bartosz' review tag.

Yours,
Linus Walleij
