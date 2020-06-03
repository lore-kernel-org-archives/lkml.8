Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA90C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A120F20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbLO+P/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgFCIut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgFCIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:50:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D5C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 01:50:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so1718300ljn.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 01:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDEdHw6LDRuGgcUmAT25W9TXRRB0f6WQXb9BxD6EOp8=;
        b=BbLO+P/mutWqkVKp4Vanmt5nZK0RWWKwRKb34gVK7SNNxKS1Yk16cVaX114PM21y9J
         cVTkuQOVI2+qR4v1b+DeJ9XsbLHdlHJwrX1aXvtWMw7+H0XLpE/QgwndakgnTn3xdFou
         axfr9gG1UCJiYfG3a6pWEL307+48LsO1cmck1iBPe9QK0as5SoGDxoPIzrfmmtdf0xe/
         k8CnIB0e43i51JVgZCwVeUjycE6yBbmna9PaSZGKOBIf8YaRTFkpYbtt4OaePNwafI3A
         0xw/aQBimcoztV0YumEGxAWsufVjOgLVtYNuAJQD00Y3bM+qrkh5I5rOt5RDESCX5ww/
         2Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDEdHw6LDRuGgcUmAT25W9TXRRB0f6WQXb9BxD6EOp8=;
        b=KOh1D7DAiFMaQd4KmzN47oE4qB8sOXRPeFhlx1spvNyiH+yl3HuRgW6+/nqK+oxlxo
         lAzqKVenRIliYDeyLQcibF/mWKdH335kNKiFZX+u2pwArF8Ox4igCcsChxci7kqD0rjZ
         cWQAyywyPCjb7XUjTrKoA9EQ56aABrMnc7X6mZWCy7yrZYlMk0utuqnNaVqj2KYPQiAT
         qbET63HWouMd/YRK6qz/L8CNJNzyIvrRAEHNgK6lF0GU+oXmLmcnXiR9QrrBIm4pRMtq
         PtrsnVDiBWJCf3XDag0SwDoUwE/6UG2WuI8u1kNU291cJXqeaYczYJS6sBYw+fu6VX2B
         swdw==
X-Gm-Message-State: AOAM531Pfft8RLyh0aR72hE6Ie0otpU9R+Ki1R+UE54RkK1jm3LPi3/Z
        vcEu/ZKB1VIOtLE1P8/GyYZm+Bto4W3p58pKgRyW7Q==
X-Google-Smtp-Source: ABdhPJy8VQ4fp8xmv45stx/+eVoknbhxSQ5Cl/g9F/qzdkvop9q9bTKqMVh106e59bacchCZaCIpkqoFxhlOmcdQeL8=
X-Received: by 2002:a2e:351a:: with SMTP id z26mr1541181ljz.144.1591174240794;
 Wed, 03 Jun 2020 01:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200528145845.31436-1-michael@walle.cc>
In-Reply-To: <20200528145845.31436-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jun 2020 10:50:30 +0200
Message-ID: <CACRpkdbAeF6bVDvcMAXguFpHeEnq7DnmWswRnXjByNkH7t3Bhg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] gpio: generic regmap implementation
To:     Michael Walle <michael@walle.cc>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 4:59 PM Michael Walle <michael@walle.cc> wrote:

> This series is a split off of the sl28cpld series:
> https://lore.kernel.org/linux-gpio/20200423174543.17161-1-michael@walle.cc/
>
> I wasn't sure if I should also include the gpiochip_irqchip_add_domain()
> patch here. So feel free to skip it. OTOH if you use interrupts with
> gpio-regmap it is quite handy.
>
> For an actual user see the patch 11/16 ("gpio: add support for the sl28cpld
> GPIO controller") of the series above.

Patches applied as some of the last stuff before sending my pull
requests :)

Let's work with this as a base, and thanks a *LOT* for your work
so far!

Yours,
Linus Walleij
