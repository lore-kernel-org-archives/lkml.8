Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9BF2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmHSa0Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGHHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:35:34 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A7C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:35:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t9so26260166lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BR6f0/BqJCEN1CVfcKyyqFPGBwWk+T779U9WQ9pd+T8=;
        b=XmHSa0UzMCoKN/tnYpRpf1kVvmOC6ZnhRaRiqN4dhekdDS+dYRV4tKqjXeotjjk6CM
         0MOlfsqx2ohqnb6RqR6ienmLqhlOgV5HpjXxdnuF+2RNshU0o9RIAIhUZSGaeqwlgB4C
         gUW8FyQX+VrymFES8f5hJ2kMWkTZXksc4SuBtTUoukp8gzsIOf9gOetUEQ9GKiXZ9aEU
         cTaQ5sIe+t/aBH6d25PGmD5Ym6EFRxjCK4D01B+XFLYt6JFtN/HdUdeQ6VoTnNi1Qi+J
         7eBpWDqvtLxhJ+XWohhbbsQWumjK6uhfievDT2eH1knqhrEDjvihiHsulNpgkNzY+qj6
         CMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BR6f0/BqJCEN1CVfcKyyqFPGBwWk+T779U9WQ9pd+T8=;
        b=dHILxhF6fapRIJ/E/su9HdYnicRQnXlRWwDbKdxYzTghc7b0FtNEaj56YkHVvFBVt4
         uvmX9iIYeA74deicj2ipREzGlak2D6R+YJb20f/HIIxMRDpqnEiLcmDkzrKn7gUjJBnH
         eqD78P9pfxx42d/+zUpCjoBnqN0XsbkjzjW0sW/QoPVZtznr7vVricA2r9V2aajxW7s3
         KiAXrX/YerBL9kKmvRdLuYs6it8bT1KrvpFWIfqNc8xRJLoa1vHHwaaehm32i69pH/gh
         57d/ZoTfTg7QhuS9SXpZIO2Xe6IKlv61OuobHmI70O5ZHT481K3ddrvjNrhhaOaMzMrq
         utzA==
X-Gm-Message-State: AOAM533/9DTvASr/CjCtKnVaB9yKCfFzZOh6Ee07qqNFQWrC/rwENpQc
        uLp8k0r3lKw/uHSNt2Vlmt6YwBmd+4dPkRC5Z6qC36nSSqk=
X-Google-Smtp-Source: ABdhPJyJ+eDL/+RhcnG7xcn/RKZTuk4K1j7DdGcaDL2nOuPTPOOM3n5gq5c736mD3TdGBOD+yswnwtLJpQbCLuN0+7s=
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr35325021lfp.21.1594193732803;
 Wed, 08 Jul 2020 00:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200706175353.16404-1-michael@walle.cc> <20200706175353.16404-9-michael@walle.cc>
In-Reply-To: <20200706175353.16404-9-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:35:21 +0200
Message-ID: <CACRpkda=C1XxLEJrVb8oMdrt1CgVyfDn7=cf7UdK0AJJwt+0Yg@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] gpio: add support for the sl28cpld GPIO controller
To:     Michael Walle <michael@walle.cc>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 7:57 PM Michael Walle <michael@walle.cc> wrote:

> Add support for the GPIO controller of the sl28 board management
> controller. This driver is part of a multi-function device.
>
> A controller has 8 lines. There are three different flavors:
> full-featured GPIO with interrupt support, input-only and output-only.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v4:

This is awesomely elegant now.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose it needs merging through MFD with the rest.

Yours,
Linus Walleij
