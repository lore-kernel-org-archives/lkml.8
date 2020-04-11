Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78002C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459F920936
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uV8o6Zrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDKUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 16:54:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34223 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDKUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:54:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id s29so1298212edc.1;
        Sat, 11 Apr 2020 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpPxEWdUioZn0HQBN6mQ3Q1Ob+fhxROdq5kNfultqe0=;
        b=uV8o6Zrzip2ioASe/aWS4uXvVFMa3myxewPYeEnNDC0qaR7bBZVUnx5TAXo42zU+mT
         EGyAyToZyyI3SNTjHdnBQXAnBZ0YpvS+8sWFjlkbN006pdPypOunFi28q4GHWhiyC5UN
         V04MspF2oljn/e7Muu86Rn+VMAFmYYp3V8mmy9pjPGv3b7+2Wa9lDQKQ2gczJPiqfWDO
         Mn8yGKCpAjPKRs/jHFX9fa479geh2aNUNEUNvvbKYG4ZO6P0Q14saXOSGjLKPkxfkwU9
         LNLgd+l6Jx2PjSnzAWJuhsq4WdmYLsRBNguCYN8YxzOWoiQv4jTJjVgR4jhaFJ/nGYP6
         Ji8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpPxEWdUioZn0HQBN6mQ3Q1Ob+fhxROdq5kNfultqe0=;
        b=VJMucVuxdih31O8no5g4BP6J4th8AhsHpVzGK+VktH+hEn1iAErOUc4dl2Bq3EX8v7
         n5bi4H/6tEMl+bGdjH1pHSGFtDAT0H/Osdt54OSkGTNJWH76yLT6jXbE95YsJrLvR7NR
         k8K8UHjH2mcWtMf0cn6Xsx6g+N8rHWzoqQMLW52Si/7LrOeZnlNnlLqawPmGqdayTfpR
         5tceRKUsCtXkoiFyvcVix4CcDEcHQU8054APTac/cJ2sbUza/9OZN+kQ3kNobHVbCSGy
         4uZAgK8OWEYoEAuvxjBhxSa1nF6HFRQMNlUHJ0bw3MyGL/5h9urXQRjqMl1gwfphPsWO
         6xrA==
X-Gm-Message-State: AGi0PuYggBE3zFs5D0pd1Um9fndA7Zwpwx3DpWIvOO0qpR8Yj5I5ftu3
        Zu+vhj+qAp4sWAl66S0DFD8X8P2DEBhg8f1wwEbtxE59
X-Google-Smtp-Source: APiQypJIyy959kWit6wOcPV+RL4aML0qO6rTxQ8ZWgimKnCOgqQggo5+d4M8bUVBY9+zdR8WOiKOCdL3T3EfdqTZdT0=
X-Received: by 2002:a17:906:4048:: with SMTP id y8mr1640707ejj.258.1586638441265;
 Sat, 11 Apr 2020 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200411170356.1578031-1-martin.blumenstingl@googlemail.com>
 <20200411170356.1578031-3-martin.blumenstingl@googlemail.com> <1jlfn2szqp.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jlfn2szqp.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Apr 2020 22:53:50 +0200
Message-ID: <CAFBinCDut=qY9f8BTwRrHC6zKMGK4DEqXFnd8BxN6S2OatXrWg@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/2] pinctrl: meson: wire up the gpio_chip's
 set_config callback
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Sat, Apr 11, 2020 at 7:23 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Sat 11 Apr 2020 at 19:03, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > Use gpiochip_generic_config for the gpio_chip's set_config callback so
> > GPIO flags like GPIO_PULL_UP or GPIO_PULL_DOWN can be used in the board
> > .dts descriptions.
> > This is required for some Meson8m2 boards where GPIO_BSD_EN provides the
> > "MUTE" signal and requires enabling the internal pull-up resistor.
>
> I think your addition makes sense but, FYI, there is another solution to
> your problem that should already work as it is.
>
> If the platform requires a pull-up, you could set the pinconf 'bias-pull-up'
> property in dt in the pinctrl definition passed to the device using the gpio.
Thank you for this hint.
personally I find GPIO_PULL_UP is easier to write when I'm passing a
GPIO descriptor anyways.

> There is an example of that in meson-gx-libretech-pc.dtsi with the phy
> irq pin.
I'm still hoping that pinctrl-meson will gain interrupt support one
day, then the driver will (hopefully) take care of that :-)


Martin
