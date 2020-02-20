Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3EAC11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3481208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqqtgYfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgBTOsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:48:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45358 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBTOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:48:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so4464406ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFsELfj9kJG75Pqbvz1ocn9qZImBer1nJRUwC4Q7bZY=;
        b=MqqtgYfSSn3FHYbEg13WQb6BWeq4sbtryqg6cZPsn20u3rxkq6YEFBDAKvqJIFORbm
         M1po1MNlQg90SORMlvuRTXHTALEgnixnZsrP1s5lpXbugJqoEfSx8o58UyRkAkmMVOJp
         x+L3zNQohho2+EaJBd3pH+v8U8eiBJ1NTeZ6h9zMcQVEmoCiIdBjGjNBO8Pz95ppvPQ6
         2tvTxNVaFFK5eyU6Onxv+Ad+n9MLSmCgPJ0u1C4VA1ZLT5alsQXwfPHcF+esY0xcjqP0
         eTgvVT9GXk3/30zrL57T+5kp/4Np5rJTR2vAbph1f77RDtWaR3Oncv7yRHXuVt2MPSVY
         oSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFsELfj9kJG75Pqbvz1ocn9qZImBer1nJRUwC4Q7bZY=;
        b=WxBezHrkzDdWyVfj7XSAEMdLo/pVKUCV+FVfT88Goj8+Kbyolu4OqhOAv+jl5Kbq0d
         dpX3MiWCtw1CPRdAr3nY9Js4n7HUmSL5Zph+4W7SVgQmITEOYBKORyXxRmz4hWcvhmqp
         RV8otZdxy9CPy9kvewQgE18lxdt2q9GuKRYIQI2AnPNO0BKWs2TWhVtIzK1Y9yNjJ1hy
         crdb3hhohhIXvIiSxViK0ufmKJTNJbyrPMH2H9lSle3/615UVGb1fJtlamLfnzb9YfWO
         wOqU67bQNq0r+LV6tGqIoCjJB7JK+nVZDs8K1/LebyI2rU2OGXwClyAI+qsp1RctC76U
         o0/g==
X-Gm-Message-State: APjAAAWieoGVIu9XQjhZL4RkRPD9zDUKfs+HjTZXYiIguTpM9w/E0MBK
        TnseyAOurY8bkqnt8q1Mup4O8j591ZwgRAdlo8ylzcpX194=
X-Google-Smtp-Source: APXvYqzC9uvcXVQUMEqfFBmLgRYjVN2yaUx+FWOP5lrFQgxOH/VrI5JSlJHy+5NkZQj0tvezfPvYss2NMoiD7aj8evk=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr18661030ljg.168.1582210121456;
 Thu, 20 Feb 2020 06:48:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com> <109d17402bc75ed186a2e151dfda1edf05463b5a.1581478324.git.afzal.mohd.ma@gmail.com>
In-Reply-To: <109d17402bc75ed186a2e151dfda1edf05463b5a.1581478324.git.afzal.mohd.ma@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Feb 2020 15:48:30 +0100
Message-ID: <CACRpkda-k26bWR9EJMMPDz0S4xy3QW_+uABdmPRbaKPD0b4qfA@mail.gmail.com>
Subject: Re: [PATCH 16/18] clocksource: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 9:05 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> request_irq() is preferred over setup_irq(). Existing callers of
> setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
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
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

This makes the kernel a better place.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
