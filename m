Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E7EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D05620772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yo8aKusF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgFCMRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCMRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:17:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AA6C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:17:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so783688ljm.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D41G1t3TtndFsp3Fk5xdy8Udf6eOJ1N1fW5sl9opBC4=;
        b=yo8aKusFH8rjFRbst7Pd2XRO5OM0uzRQkbHZ/REysSt9JSXHyjarMKg82fb2fZueI4
         Z6uU6ik1Rmgp6EzdDMlfumXvHOZzogk0BRn+cCt/EXdVKlybK1MJsj7dfXCgIcJNdw5e
         uchM2b4rb4v09XFMhxn9alZQilyh6w/79e9HBFCgj15Di6/OqD5GRdhwneCO9SKflWb5
         7PzvnUPscIJpoV87H0jipvwdMBb5k+NZG0JtHsl/YMxDbDh8qiiKDTzaGa8VxchlwGH/
         fVkdhjK+sVIpM3Ho2VmmHLERJKhRfsYPBhTQg+sc+oXWusQdFDiToZ61BvLaLBlfZnYD
         Kj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D41G1t3TtndFsp3Fk5xdy8Udf6eOJ1N1fW5sl9opBC4=;
        b=PuBWzgqFZNWbke67gaxQemtQIwNtgXGYVIzQWFLEF04e4ogVJSKWA3kEeoKAPr++tQ
         R8T0h+38/qWRfLEyeZO+5nCGrrsvsv7j0uCxnssBx9zNGnaHIGgpL4zaPmreAynhjt7t
         0Vawu6YJm/Mb2mWM8ror43BcFvZU86T8HeI8w1n1f0vpITSHnAlXjUyJDv4UOczNooz8
         AWQD6KCSZm1In7IqhvvwLVorOJifSgJuU2ztdeFITS7Ai69bt4fIX//l5JusopRk3wyX
         7NxkdEj3plM9Es1KNaVQqKRGPdN0PVDoTbNzkMW2Aislpw8AhKtNx7G7sq8U5KCWIGws
         kCcw==
X-Gm-Message-State: AOAM531nf66+BSrXu+aAvgbPiVIgOzv7Z7acghCD2q+2s7gphiWoOLGh
        mBnyJcv8urVmgBUohwBvSpnvPpCLl859dYVnxXxdaQ==
X-Google-Smtp-Source: ABdhPJyoeZrNepeqk+9jgqLKZrt7i+C1qWTwwmCR1qtAPIbZRcMnPhJXEc9R2F8Y1mjnsppMks/wRXFQe154ZzFwVB8=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr1143186ljn.286.1591186660293;
 Wed, 03 Jun 2020 05:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200531001101.24945-1-f.fainelli@gmail.com>
In-Reply-To: <20200531001101.24945-1-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jun 2020 14:17:29 +0200
Message-ID: <CACRpkdad8K-uDpYWOwxOW33YM3yWsKOS-Fr4OjkXhNoVxJv1jg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] pinctrl: bcm2835: Add support for wake-up interrupts
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 2:11 AM Florian Fainelli <f.fainelli@gmail.com> wrote:

> This patch series updates the bcm2835 pinctrl driver to support
> the BCM7211 SoC which is quite similar to 2711 (Raspberry Pi 4)
> except that it also supports wake-up interrupts.
>
> Thanks!
>
> Changes in v3:
>
> - added Rob's Acked-by for the binding patches (#1 and #2)
> - correct check on the number of GPIOs in irq_set_irq_wake (Stefan)

Applied this v3 version right in time for the merge window.

Yours,
Linus Walleij
