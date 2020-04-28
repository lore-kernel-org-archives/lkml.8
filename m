Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE0C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6728206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCPifXw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgD1NtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgD1Ns7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:48:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CC2C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:48:59 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so21536146lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hprmAywS78pYBC0BQt7gTceIcUivP3JeOHfXgeteKA0=;
        b=fCPifXw/aNPOXfO0rsjZ+yaZg41307Lkkk7BSKaH5H7psRRpteV5LYlsmB0N4dqM+G
         B8ufwhgl1jAKHJtIaK2N3pMI8gNruYVHB2STb08rGaoYD52IUxGOz4Aspg3Ds0Le0ikd
         TVuF6fV3Rvf7ebyZClOq1W3RpoHzm1YWMlrNqWKruL5OMdAZDou+zZlYEpF0HNAI/2Mc
         4NeZzLtbfLNep4qlhJEL6P9PCgYdG7lyL4tYiZmCwJhcQwNzV22+w6k7VeKjtO6YFRXV
         VYcgB+OPVwmv8eRYthKbSjqUsDGLqzpfUOeRl8laT2tDQSpAHIW/c8WTecXhOlyjnf/2
         XtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hprmAywS78pYBC0BQt7gTceIcUivP3JeOHfXgeteKA0=;
        b=mD0+F0YWogfPU8w0uaAig9oh+oQ6gL0pkSOXXb3eiQv4KniIO3bobwzvGGPXUvfGbZ
         y0QSI0ZrIr/6JiJvp7UlvfbBkYKliJZBPt84sywgg+oihUqeDAEjsOIyVgmvMi8gdPf9
         MAZvQZj2UL8iZGH4Z5jWV3rO7wkXrODmYSP+905ArLzSf6wYE2ZzEd/o8j5oTBwDTV4c
         KSz3mpWhaKNPCruRXkXGVIp758Mxw0av2We7LxsIQc0gqm8B5Og7jjAS8qIOWYkh0bw0
         7aLo7uxC9lyWD+9jmdiuh1boN5lwyMucKo1cvlSiRBfCRmtjJbp/hUWlPVaxIELc4qG5
         1z4Q==
X-Gm-Message-State: AGi0PuZxrwi1WsKgk5sbnPNjYlvFegqMYBh7QbntjyO/Qn1U/3acti73
        u2Zo+F8ayvAxMiBfkoEo/JgwdEUv8DOYaOulBmAooQ==
X-Google-Smtp-Source: APiQypJIhrNrQ+oaUJ5NP4QQvPil4l3MmkC57hDze40HmsjQNpb70nI3ajhIbXVp601g+fxmmSsaOiIc+ymo3FzTcC0=
X-Received: by 2002:a05:651c:1058:: with SMTP id x24mr18355448ljm.39.1588081737490;
 Tue, 28 Apr 2020 06:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200424141432.11400-1-geert+renesas@glider.be>
In-Reply-To: <20200424141432.11400-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 15:48:46 +0200
Message-ID: <CACRpkdYozdZZN5OB_tYOizFynWAXGSuRMbA1HmfBh0cZJ4J9aA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Improve kernel messages
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 4:14 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Simplify the printing of kernel messages and make the messages more
> accurate by using the most appropriate {dev,chip,gpiod}_*() helpers.
>
> Sample impact:
>
>     -gpiochip_setup_dev: registered GPIOs 496 to 511 on device: gpiochip0 (e6050000.gpio)
>     +gpio gpiochip0: registered GPIOs 496 to 511 on e6050000.gpio
>
>     -no flags found for gpios
>     +gpio-953 (?): no flags found for gpios
>
>     -GPIO line 355 (PCIE/SATA switch) hogged as output/low
>     +gpio-355 (PCIE/SATA switch): hogged as output/low
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
