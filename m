Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2A420716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IBh00V0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgHQSZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390912AbgHQSYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:24:37 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C42FC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:24:36 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so13179405qtn.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAFYWBF2GClAQZpHVZzSpokffvud/RBlK/za9SW/At8=;
        b=IBh00V0k+zSkWhzx+YDpFbXyCl492e3Cc1rN0Hf31AltN8GmHUZ7Eu1Pnr7EGvdcA5
         nviZ6dfEjD2KAco8CV5UaRnttND2uXkUM8rzllVu+1MBBohlBneT0e8Wo5eWcmktWLRD
         NW6WAQLGbwa4X4zUOzyGjdB8hCsWtQXzJICTVtZh0P0/c9Vdhdv9ie7yfcRhquLkPaK+
         N9vw4pjngpcirMxXIWCs1rmYXNNykxCyJgA/gRPoM6R0iLPXLZA3L+1YNA/dUyU7Rqy0
         9xauNpSOcy6qWdsK/03HKNao1hacWMCxETj9VXx0murRt+DWAqOUqABB97XUPcSaNjqy
         hmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAFYWBF2GClAQZpHVZzSpokffvud/RBlK/za9SW/At8=;
        b=AytSfMHK9AjHFvc4v3Z8EF1DCm5FKzCMLLtVQCBGasODnPEqMrX3DKyYvDwygfdW1G
         4kJU1yQE6f1EGXWJiloKF4Fx9kdMmq/PGbuxjUjQ9oqW6kOgE5ibJb/cUH+kOSLheGEL
         xCmW7mi0Ytezbfm6zmcBabljasK0mFK88ic6zphZDtoE9JDiQ5H90tMrJBXHtgp/bsOV
         kYLpRcAoF0LWD/UJ/rDZYRbwjEBIcUDHdAuRzpgs6/kg9WMuu5MbZfKGT/Iyj1AU6IUW
         aZNmQacnLLBs12+ERuroXCzWhiC4gWmuZGj+iH7mUyshe3c+lqcbRe+tZ9R107WZc5BI
         w9JA==
X-Gm-Message-State: AOAM531+5RiR3kA4LfqtXx7BmKAXw94DEkNOy2kHZu14Gjzq+iuNZ9d+
        WxSWABr35G8E6n0F9R+vjg/7CFbxFJBFmHRkR+bYGQ==
X-Google-Smtp-Source: ABdhPJz927wcFmwanL9peMgX6pJXjDjF/dCLzYQ1JQ08qtiKJGp6eO+5/A76xOwmtPGcsAJ6dPdeBM9DOfi9rb0qVcc=
X-Received: by 2002:ac8:6952:: with SMTP id n18mr14369852qtr.27.1597688675455;
 Mon, 17 Aug 2020 11:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200814030257.135463-1-warthog618@gmail.com>
In-Reply-To: <20200814030257.135463-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 17 Aug 2020 20:24:24 +0200
Message-ID: <CAMpxmJUCwXVv6U9sE=8isRMoNd8QvM9XLu4PU2Rr454wt_FTUw@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] gpio: cdev: add uAPI v2
To:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 5:03 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> This patchset defines and implements adds a new version of the
> GPIO CDEV uAPI to address existing 32/64-bit alignment issues, add
> support for debounce, event sequence numbers, and allowing for requested
> lines with different configurations.
> It provides some future proofing by adding optional configuration fields
> and padding reserved for future use.
>
> The series can be partitioned into two sets; the first eleven
> contain the v2 uAPI implementation, and the final seven port
> the GPIO tools to the v2 uAPI and extend them to use new uAPI features.
>
> The more complicated patches include their own commentary where
> appropriate.
>
> Cheers,
> Kent.
>
> Changes for v4:
>  - bitmap width clarification in gpiod.h (patch 04)
>  - fix info offset initialisation bug (patch 08 and inserting patch 01)
>  - replace strncpy with strscpy to remove compiler warnings
>    (patch 08 and inserting patch 02)
>  - fix mask handling in line_get_values (patch 07)
>
> Changes for v3:
>  - disabling the character device from the build requires EXPERT
>  - uAPI revisions (see patch 02)
>  - replace padding_not_zeroed with calls to memchr_inv
>  - don't use bitops on 64-bit flags as that doesn't work on BE-32
>  - accept first attribute matching a line in gpio_v2_line_config.attrs
>    rather than the last
>  - rework lsgpio port to uAPI v2 as flags reverted to v1 like layout
>    (since patch v2)
>  - swapped patches 17 and 18 to apply debounce to multiple monitored
>    lines
>
> Changes for v2:
>  - split out cleanup patches into a separate series.
>  - split implementation patch into a patch for each ioctl or major feature.
>  - split tool port patch into a patch per tool.
>  - rework uAPI to allow requested lines with different configurations.
>
>
> Kent Gibson (20):
>   gpiolib: cdev: desc_to_lineinfo should set info offset
>   gpiolib: cdev: replace strncpy with strscpy
>   gpio: uapi: define GPIO_MAX_NAME_SIZE for array sizes
>   gpio: uapi: define uAPI v2
>   gpiolib: make cdev a build option
>   gpiolib: add build option for CDEV v1 ABI
>   gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and
>     GPIO_V2_LINE_GET_VALUES_IOCTL
>   gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and
>     GPIO_V2_GET_LINEINFO_WATCH_IOCTL
>   gpiolib: cdev: support edge detection for uAPI v2
>   gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL
>   gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL
>   gpiolib: cdev: support setting debounce
>   gpio: uapi: document uAPI v1 as deprecated
>   tools: gpio: port lsgpio to v2 uAPI
>   tools: gpio: port gpio-watch to v2 uAPI
>   tools: gpio: rename nlines to num_lines
>   tools: gpio: port gpio-hammer to v2 uAPI
>   tools: gpio: port gpio-event-mon to v2 uAPI
>   tools: gpio: add multi-line monitoring to gpio-event-mon
>   tools: gpio: add debounce support to gpio-event-mon
>
>  drivers/gpio/Kconfig        |   29 +-
>  drivers/gpio/Makefile       |    2 +-
>  drivers/gpio/gpiolib-cdev.c | 1354 +++++++++++++++++++++++++++++++++--
>  drivers/gpio/gpiolib-cdev.h |   15 +
>  drivers/gpio/gpiolib.c      |    2 +
>  drivers/gpio/gpiolib.h      |    6 +
>  include/uapi/linux/gpio.h   |  316 +++++++-
>  tools/gpio/gpio-event-mon.c |  146 ++--
>  tools/gpio/gpio-hammer.c    |   56 +-
>  tools/gpio/gpio-utils.c     |  127 ++--
>  tools/gpio/gpio-utils.h     |   50 +-
>  tools/gpio/gpio-watch.c     |   16 +-
>  tools/gpio/lsgpio.c         |   60 +-
>  13 files changed, 1949 insertions(+), 230 deletions(-)
>
>
> base-commit: 22cc422070d9a9a399f8a70b89f1b852945444cb
> --
> 2.28.0
>

Hi Kent!

The series looks quite good to me and I think we're on track to get it
in for v5.10. I'd love to have Andy (Cc'd) take a look as well. There
are some nits here and there but as long as we get the ABI right, any
implementation details can be ironed out later.

I need to think about some details a bit more but I really like the
current state of the patches.

Bart
