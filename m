Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E957EC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C422070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IomMbbbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgBQT5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:57:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40745 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgBQT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:57:06 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so8282518iop.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TkZflMcROFsesKUNZV7osOthh1cZ+d/gpsuqXa9C5l8=;
        b=IomMbbbRUB6peFoBopVRcXZLp+v3pwqHiFwJ+zz3CgTCHpx/ai31KvJpxUqNFwEDFA
         bnw2mKddqNteZD0xJFZhKEhKqOUEI8hZ/f5A1qNkzC4McjYBmk4xSXsiafGysyUT1uz7
         4Zoy9khoSb8MKmU8VUUQUvpBwTn8voe//r0Lnt/GCwfaaqGQeQh5N15h24UyKQ9ThfKL
         nAyJa3Vlu/E10SAXcfE4FLVgij+VgoHwNytOQM+DUDqiMw37E7wHDMHS0xonbidfmDAu
         Me0t2Q6/lytOjYIvf5Q7gzefC/3D/szDoZh2yQvlXvLEL6R7pRLuQuXzN0kZDZG2KGiu
         E7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TkZflMcROFsesKUNZV7osOthh1cZ+d/gpsuqXa9C5l8=;
        b=lwTNfSYvsjigCi8DfayB42tDIlDuul0GMz96zSuD6uiMGswBoqfOe9Ox0OWQT43Ako
         UU3zg+gAw69q0bj9fr8aT2uzqD7aoFIhvEC2QQZTFTL5yf6E0z/XwgqWA8dsPzxPR4j7
         GrY5jlhmTPtKwCgCgqkrlk4/Nn+apCsU3XFmJfI1zqTpPjU9QG/uev//dFhnn/ycUd87
         i9tFiJhRb5FRShk1D24vwgGat0FQHfpEELONNBNuwKViHVItUZnLf/9GS8x1debY4NGi
         U/o0SJHaZuI/zL6pHqICUQlV8ZY9w1zMXsr75SbsM+2U5jzUgwhhBEAm/4QoPsNhwquc
         OwUA==
X-Gm-Message-State: APjAAAXG4pFVrdlzsBxsIc9AhEVoP0QoY3P5QoxQbSJ6hQh2huOHg3Pf
        h4kPkR3P8teVHCFCubxQyO6raQbWkYDtGikenJIiDA==
X-Google-Smtp-Source: APXvYqyM5+ZjQIP+Frd5tM0WY4D/8hw6MGjHQa/KvLPV8uqeUFW+t2W0F8RWioJmZyZM3fbUApvoNSAkAqqp6HvNLv4=
X-Received: by 2002:a05:6602:2352:: with SMTP id r18mr12638053iot.220.1581969425784;
 Mon, 17 Feb 2020 11:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20200217195435.9309-1-brgl@bgdev.pl>
In-Reply-To: <20200217195435.9309-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Feb 2020 20:56:55 +0100
Message-ID: <CAMRc=Md-gw5ViK7qhH2pZ8RWf-V_7TPgJ2rnb=v6AC5wcxLdog@mail.gmail.com>
Subject: Re: [PATCH 0/6] nvmem/gpio: fix resource management
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 17 lut 2020 o 20:54 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This series addresses a couple problems with memory management in nvmem
> core. We fix an earlier memory leak in error path in patch 2/6. Patches
> 1/6, 5/6 & 6/6 add reference counting to gpio_desc structure and use it
> to correctly free the write-protect GPIO. Patches 3/6 & 4/6 fix newline
> problems.
>
> Bartosz Golaszewski (5):
>   gpiolib: use kref in gpio_desc
>   nvmem: fix memory leak in error path
>   nvmem: remove a stray newline in nvmem_register()
>   nvmem: add a newline for readability
>   nvmem: increase the reference count of a gpio passed over config
>
> Khouloud Touil (1):
>   nvmem: release the write-protect pin
>
>  drivers/gpio/gpiolib.c        | 26 +++++++++++++++++++++++---
>  drivers/gpio/gpiolib.h        |  1 +
>  drivers/nvmem/core.c          | 14 ++++++++++----
>  include/linux/gpio/consumer.h |  1 +
>  4 files changed, 35 insertions(+), 7 deletions(-)
>
> --
> 2.25.0
>

Cc'ing Geert - sorry I forgot you when submitting this.

Bartosz
