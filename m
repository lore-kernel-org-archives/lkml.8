Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B5CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF34722BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="luRCZFvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgHDT2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgHDT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:28:16 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5C5C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 12:28:16 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o22so31604790qtt.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZPv3vyb9T7Ph9oNjo817uichWZWclCWnCIRIilrMbI=;
        b=luRCZFvNv1qw6XK0lP5bctiCtoKipS1zkSan+vF/4w0QNcp7tvBGPSXhl2Hu55Zni2
         IVovI6W03P4sCwu3UjBAbkx9wSEIM5mQM1b/oB7V1Z/USbGH+S+9dq8ORM02WibWYy9b
         bgog7iYT5g2zlN7dzdekrUfbBalT2olGkwJrp7/9NhFWIV2ca2WOjnWPWf+Dn0IvLV1u
         /rmJodWFshUyd/AfAbXgpT+mnlWds6J8r8y3ipFHdaov9xAMXc+gV2A4Kn6NNbfyijtK
         RC6Atw7BnwPqoTwMP2okxisEmbqsqUZo0D27Afy3247WVNWN8l89zGmUWslqyy5QQDiD
         eWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZPv3vyb9T7Ph9oNjo817uichWZWclCWnCIRIilrMbI=;
        b=KRCRluwDMf15XMBoEe3zkkWglQNhdZdJBxtcFKXrSYjVBkgEmFN7UgCZqWh+KrBI/Z
         MBpznshM8VzINwQLIgzHFfBS23NZhAEkVHGnFc0BX6uQ+arKEg2WvFpL89RwQHtF21eU
         xjoZXvvUVG1qU/Kk9A9UFGIaD0UWp0/wDxn982FP/3lkEu9F6V6xulMDXxooaNpH1MtQ
         VBGAUGvKtQSSexbbqiGxwnHA4ZvDY/2COMvdcAkFZmxMv9wkMsUZvtzjHBpYjC5Nsy3g
         Vru7BbLlVX1L5SKWT81Ohw9bGEdQd8NTgBTcvnG2TYTgo0yuQaRU6PR072Ae7piLD+Rd
         U4LA==
X-Gm-Message-State: AOAM5318uBBdn5KyXDdiMnqYzM1D3IsLSa1FCcRc+V+e7y8km7gAUohP
        2vww1YUXqvuHalxJrQCjTfRWbNdgZ+Sv3StFKk3cUA==
X-Google-Smtp-Source: ABdhPJymsHefVLQVuV4G3IAFDTvR9UK59lInyk68B5dA9v9fdqqex2N6jbzDONS0DrBScUcDbjSWF5ZEeQa/M1q+dpA=
X-Received: by 2002:aed:21da:: with SMTP id m26mr23617075qtc.197.1596569295695;
 Tue, 04 Aug 2020 12:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-8-warthog618@gmail.com>
In-Reply-To: <20200725041955.9985-8-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 4 Aug 2020 21:28:04 +0200
Message-ID: <CAMpxmJW+RqW5=ugXru3ggRnLsPvtGEJ64_sBaY2GAXjeWT50qA@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] gpiolib: cdev: support edge detection for uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 6:21 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Add support for edge detection to lines requested using
> GPIO_GET_LINE_IOCTL.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---

[snip!]

> +
> +static irqreturn_t edge_irq_thread(int irq, void *p)
> +{
> +       struct edge_detector *edet = p;
> +       struct line *line = edet->line;
> +       struct gpio_desc *desc = edge_detector_desc(edet);
> +       struct gpioline_event le;
> +       int ret;
> +
> +       /* Do not leak kernel stack to userspace */
> +       memset(&le, 0, sizeof(le));
> +
> +       /*
> +        * We may be running from a nested threaded interrupt in which case
> +        * we didn't get the timestamp from edge_irq_handler().
> +        */
> +       if (!edet->timestamp) {
> +               le.timestamp = ktime_get_ns();

IIRC Marc suggested using smp_rmw() here before reading the timestamp.
Do we still need it or something changed?

Bartosz
