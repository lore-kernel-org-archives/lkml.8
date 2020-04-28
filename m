Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C6C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88AB206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuSW84MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgD1KB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbgD1KBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:01:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465FBC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:01:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so20801272lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLmsZ8FzUvZ2qyUD84j1b22i18dHEE70Jtvscxhc09k=;
        b=YuSW84MJxGm4qTrO7x6FDa0tNZ2DwTGnBZcdLuuUJwmIySl3NXFo5FIxgcdvSWhhHw
         w8f3SVhylLAGIenBWpXFofh7SIqxoYqGlwz7LQm+YJ51a177fjUJO5Xr8wTKk7PLE9Ow
         sq0njirZjcIVJgrpYtz0SI1Xkqde9Fx+gJzIVvtihqPzC8b+RubH3I+eAsZH3kyRJCaT
         TGV1gQgqGK9ntlhlHxoERIFjvIwg0mp1TnG9kPacdcpTqghNObPflJ8OxLxmk7azsenJ
         5pB5uU4FilL+JAVfPKMCSGlURLIKRawxY2bwR16A3geOEdTBD8NnehNPWlwNekdReDCw
         g9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLmsZ8FzUvZ2qyUD84j1b22i18dHEE70Jtvscxhc09k=;
        b=l4dx/nurzxu5O/JGK9OZHHoacla6iT4t2+Siz77aS9bgJ6/g+zeWUrQQOhnrRgdZGS
         e3D9k1J0HCMlx+FTflQaHY0o3cAwf8S10FFPf/3/YDiL5I/KscOi9yjyVa8FVtILV2Mi
         EtAsyVT3OVx28Sv0yFE72NqjcvRpQkIQsGO4MZovnb9XsPW40Rc5zhj8dEYpekEanymh
         BcroOOh6t0c+1S6rtLpFfVxIwaM7YyCncsfFyZZkq74rviR/3tD8NEuWU3lIf7ZvhVot
         4efqW6KTpumnS5t0X4CSxINjwiA4Mdg5oo0CfHs3wpQZ0MqI+huWcqjNoWXKwBsA1Nav
         MnxQ==
X-Gm-Message-State: AGi0Pua0ef3QIsdz+BgoVX75ZfiQFm6otJT8yp832XTeDxDBwns6l1qx
        HQ3m9wGWQnYVqtO8hnuTKL8ylNsiJT/UREiWXTgbjw==
X-Google-Smtp-Source: APiQypILX45Ac1tiqnMnI+HFKCHUmn1qsryssGy+UbF1Sz2zs9tEQxqIByqukAumdnDai62XdgrEeXgjb4HSD+iqAwQ=
X-Received: by 2002:a2e:2ac2:: with SMTP id q185mr8308858ljq.125.1588068083674;
 Tue, 28 Apr 2020 03:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200417183349.1283092-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200417183349.1283092-1-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 12:01:12 +0200
Message-ID: <CACRpkdZ82tjcBc_kF29zUMiLLH==0zKbOd=fTRGq5-4FOiez5w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/2] pinctrl-meson: two small improvements
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 8:34 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> While playing with audio output on Meson8b I found out that the
> vendor kernel uses a custom version of the GPIO_PULL_UP flag. I
> suspect that we will need this for audio support on Meson8b and/or
> Meson8m2 but I don't see it hurt other platforms.
>
> Also while comparing the register bits with the GPIO direction (of
> GPIOs exported to sysfs) I sometimes had a mismatch. This also wires
> up gpio_chip.get_direction to have sysfs and the actual registers in
> sync.

Patches applied.

Yours,
Linus Walleij
