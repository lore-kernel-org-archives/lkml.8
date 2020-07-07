Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18C5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C114620771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVo/Uujy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGGMb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:31:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A00CC08C5E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:31:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so46072670ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5PreIccieZzqDCuD5xHlKY1sTvI9Idr6J7wd3fIaUk=;
        b=uVo/UujyMsGtl1IhZIf0UfXMtcUtvlZX259B37NgwfYCeh029ftdKMBqsJRUu7n99r
         mcWou1pG39QO5sW0vG3t5VUb5l1ZlAnH44S/oKfc2m9pED+MK9+JoL7Do+suRPF+zEkX
         lKbflXau3wnWjRdb7uiecHhqfEpksnVQ9zPnP9/rv4FeAFW6/A/Ei1qVeb1FFbTOI9vO
         1akzd2uycaQzqAm34MrtEEXuKRpKQTuWcLxG8PGItET728a1GwoKnePxh9NtKHyhUzx6
         xVDMpALjWzsN9IvchROet9Rca6PgP5yYFK1NgXP2psQXFEttr9uF5+30x+4tRNKO8ZP0
         6O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5PreIccieZzqDCuD5xHlKY1sTvI9Idr6J7wd3fIaUk=;
        b=MhNVvkN4JkO98QhwuJ0HwCmfsGO91OVxHVVZK7pCde0H4rBr7GuJVwtn/yKvga6ykW
         +HKpuCfkQ3I2oOUWEfaMxeHkmlYyjduzuWQ44+KE0sY/tdM4EdOhczDQTgFe7uwCDVg4
         EVAg+rGQAoY5bfOBioDKMtPlMcIqf08b/X7CajschILNDHKoiMtXX6lW9qRfepqUX5Ed
         /zFoPOMAixRmOzGinZnJioeqeUjKazs56bqH2qdc33POBBoot4l/mxkZz7F86p02eoqP
         eSIJGlVbKJcL9T7ZJM2TFWh3BE66/MpUUhICB8QFpK47w+M8jOLIhSIR+YXHxzDhdGqI
         hufg==
X-Gm-Message-State: AOAM531c85ljWRG8dp8NnMF6GikIbzxJrmrsCBnIU3A6UhwhllKyX4JN
        ZTrQ3SUPHCo4qSTdU16/4kP+TUQq26wdBCyUiSPlKA==
X-Google-Smtp-Source: ABdhPJzNuXjFxL4eLB0ZfXEgPVcJc64eKxEfq0oxGzOkKZvSKhOBaXkoArxnE8a880A6ThE3ocyS7OoFjYdLe/YYRdU=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr14132869ljc.104.1594125086553;
 Tue, 07 Jul 2020 05:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200701114212.8520-1-geert+renesas@glider.be>
In-Reply-To: <20200701114212.8520-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:31:15 +0200
Message-ID: <CACRpkdYr1don64ZCcJ7w223+cMntjCzeHg9VrZrE4rzf77bOcA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio: aggregator: Misc parsing improvements
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 1:42 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> This patch series contains two improvements for the parsing code in the
> GPIO Aggregator.
>
> The second one converts the driver to use bitmap_parselist() for parsing
> GPIO offsets and/or ranges, as suggested by Andy[1].  This should have
> no impact on the format of the configuration parameters written to the
> "new_device" virtual file in sysfs.
>
> Changes compared to v1:
>   - Rename mask to bitmap,
>   - Allocate bitmap dynamically.

Patches applied for v5.9! If there are further review comments they can surely
be addressed by new patches.

Yours,
Linus Walleij
