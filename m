Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD39C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B136720705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5D4YyM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgC0KZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:25:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44187 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgC0KZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:25:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so9581864lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7m4lWvk4//cGrxQhI0ltBzlijc7RgGiBhxq+4JikvIo=;
        b=g5D4YyM74lsERyxVWEtSBIzcaGgdj91X+gvlZ19U9ZMi+fX9jzIbSx241hKH+2N10n
         ziWkkfCA99BNAYxuSyr8N2yRDOb+CrAs3hUW9nWyYL+T1Zbdpimu14dpwEQ8u0ZgWorn
         jSCE336+YRKMQoWrUu2H935e/YYhgLXs9uYqKbli4hJwXxKwIoSHMeuymqJgQkpQfZRQ
         2Yv0Je3RpW5WlNLbgou34/CGii2qNfxtnKZVPdAwGRM8dmO0AwU6kRISyRfEoQQtliQ0
         PzSk/y9Z5dGPWAExpyKivHo6EP0AGCQljfldCXbcC+z3SspoLHj5TtF3Ff10dRFHFfY5
         IkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7m4lWvk4//cGrxQhI0ltBzlijc7RgGiBhxq+4JikvIo=;
        b=NTejkDpwNGxVYGY3mBhcikzIbAuwe1r3Yu5zmG3mxx54bQjv7JUYhZOsRl+xi24FDo
         plPJpIh4H4Zo2ImRpicCrek8y1caZK0cmAGqvsZrMk1XLryIjVLyjT0iU4oloH9Um1Jn
         OIXzjHjhjogUVN2wu0ff6FcL+tKOXHkCZYBC/Jc3/jZWtDW9tIS9eQR9BP0yW0dahxK/
         ULy4IcoJlrn0BCf6IZ3J8Uio0EmJn+Ce3RRbptgmwuRBM6quk06JdaKoBy/eqZOlJ2jf
         5V0Zgk8vn8Y18QqN8dQIjIYInLSRBmFRrHLemQKGjL3VEYz6A5vfNyko5r3KSG9gRr2l
         4iSQ==
X-Gm-Message-State: AGi0PuYRE0uSjRvq7IVs6xSjvc/gWwJ21hXVwgF0mb7HGJM4yi0fz7E+
        rXl2Dj7RmGP6NVbsceOj5UJslJJr34oqoKKr1S9fdw==
X-Google-Smtp-Source: APiQypLGNjy+bso8fEQU1Rr+N9WpSOr49XJcW20+rl9/F0WHi6kN5XEtnL5MgahJRdxrpJS/UNceeTWkSa9YNVg/vb8=
X-Received: by 2002:a2e:9c48:: with SMTP id t8mr2097823ljj.168.1585304702362;
 Fri, 27 Mar 2020 03:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org> <20200318174131.20582-10-daniel.lezcano@linaro.org>
In-Reply-To: <20200318174131.20582-10-daniel.lezcano@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 11:24:51 +0100
Message-ID: <CACRpkdbt2yJ4-_82ZGrkgCat+Qywyy7HFLaqremzhc1rKTp+3w@mail.gmail.com>
Subject: Re: [PATCH 10/21] clocksource: Replace setup_irq() by request_irq()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Barry Song <baohua@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 6:42 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> From: afzal mohammed <afzal.mohd.ma@gmail.com>
>
> request_irq() is preferred over setup_irq(). The early boot setup_irq()
> invocations happen either via 'init_IRQ()' or 'time_init()', while
> memory allocators are ready by 'mm_init()'.
>
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
>
> Hence replace setup_irq() by request_irq().
>
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().
>
> A build error that was reported by kbuild test robot <lkp@intel.com>
> in the previous version of the patch also has been fixed.
>
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Link: https://lore.kernel.org/r/91961c77c1cf93d41523f5e1ac52043f32f97077.1582799709.git.afzal.mohd.ma@gmail.com

Acked-by: Linus Walleij <linus.walleij@linaro.org>

It is definitely the right thing to do, I cannot test it right now
but if desired I can test it on my targets later in the following
weeks.

Yours,
Linus Walleij
