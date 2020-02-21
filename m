Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4157C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8F9208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FV8vFJro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgBUNlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:41:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37153 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgBUNlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:41:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id q23so2233553ljm.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVHjti8X9qAjkP+KLYv2+YuZEcskMr676gzyYTbo9aM=;
        b=FV8vFJro/qlRu/uNvUKOuk5XPOqeaUV3z3c0MvNHAC5R35ciT8bLdv4ioUro1lZNz+
         LX212SvXpktnYHIIH1/bsm/17ZnmZL/qv5TUXK2LDLq2gunjD+icH/hmw4nM2vBYaWUU
         BZqc+3hB95awD/vhhrFBA/1/+bAQiMVLBgLSt1oF/wzhYQohZkpL+NIhvFky7JyUI+wd
         NB6w/NH3B6hRbTad2KEOVMaHFmSCfedlyxc0+M98GeTBrHB6BkgeVWcEhpfvbC1G3L8W
         qO6xNWubnAg3gyrCh0nM6wCCdFFUFRIs3ZFI2hg8oZxr+hKBEDzzf5IwNeLVZI+uDIPL
         0PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVHjti8X9qAjkP+KLYv2+YuZEcskMr676gzyYTbo9aM=;
        b=EQQnN5kM1p+mqR0Tp9TG+v9tChLKQ/f3Ob1PDNe9qbvxPflwdC7XaASl73MuBaknYs
         Sk3f7Oe0fIOVcYQX+bIF+qr70M4G+GQE3MvoMHUSAthakQEJDlYTpaZ6ByQSVsMI6Z2N
         W+8q0lUrnpSOb6dYuPU5Ibi/9vcGmbLfl9UyauLFRc0Z/ISFJGyQ84RAtpKSsYSzTcDe
         57LNsIanJJOPFZyJEsnH4Jaw5i50nPYQ8EGjW59Vl6IwiWDWOvasr9ZOy4bNRiz521MS
         GgwyJZjIFyIIWdALFnFpVp0diiZv0Vk5/La4qLqjIBpTll/Lk+c2z2feLy8jm6ZnB3LD
         Ap2g==
X-Gm-Message-State: APjAAAWYxjDVUtdT3I7U/lDBKWLZVcsxAsa9zwdaLijo0kfcs7jwrS68
        IMzgc/fJ9VKuZYHP1rrtjU4wD8PHGh/HdGOgCyqf7g==
X-Google-Smtp-Source: APXvYqxffTw9jtZT5IylAtS3KMQ5eN+Md6MiFoRkBnpZTiMv4udUulYwMEy1vAtMjkv5eWlqjguH8NE7Vaa3eyJu53M=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr21360405ljq.258.1582292464265;
 Fri, 21 Feb 2020 05:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20200219092218.18143-1-brgl@bgdev.pl> <20200219092218.18143-3-brgl@bgdev.pl>
In-Reply-To: <20200219092218.18143-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 14:40:52 +0100
Message-ID: <CACRpkdZbvMBHacWYotSYKM=MVbDc16Z9qyQrkjDgRi5eFJZAAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpiolib: use kref in gpio_desc
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:22 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> GPIO descriptors are freed by consumers using gpiod_put(). The name of
> this function suggests some reference counting is going on but it's not
> true.
>
> Use kref to actually introduce reference counting for gpio_desc objects.
> Add a corresponding gpiod_get() helper for increasing the reference count.
>
> This doesn't change anything for already existing (correct) drivers but
> allows us to keep track of GPIO descs used by multiple users.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I really like the simplicity of this approach ... hm!
It seems the only downside is a krefcount_t extra per gpio_desc
which is an atomic_t so I guess 32 or 64 bits per desc depending
on arch.

We discussed refcounts in gpiods in another context but it got
really complicated there. This is a clearly cut usecase.

Yours,
Linus Walleij
