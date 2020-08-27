Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4456C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDD520872
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeAnpLG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgH0WzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgH0WzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:55:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897BC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:55:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t6so8278655ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qb0Ec8fDQudSKqvQFmwnBIuKxE0k0ElPX6kr8ZppFm8=;
        b=MeAnpLG4pG2Ikxmbpy6Cs2fX3iTsHcQCQzPEKb4qfBmXfZTbxuDZ6g4JEVaZgTEKKX
         8FlO10kwzHHTDncetdmSpJi3tOJnfsSngYRqcZfVB9EpeO6DmhzghwCA69NW5MUB7BaS
         P3VcgSt11sTkF4YuIng6D1f56oMTRF5wN7rYphD/lwg+wF7N/EwZVVt2h6redx6XRvRl
         zA0raTj6jLEgtK1f+66Rbr1ZudmIpRDXRXweJjjDmmiVEMiSHBmji98Fp1PqW5qoXTur
         JoqgtkbQMK1+nuke+LwvH7Ah/pH7u6nOh3R1W58mJ20j0n8GsyXP/BEvJ5ZPBsnb/hFW
         2eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qb0Ec8fDQudSKqvQFmwnBIuKxE0k0ElPX6kr8ZppFm8=;
        b=LLiCuQGszV/1jsjgw5LlzX+Ua4AekvcUmI7UxtkFrO3AcX335J7PFLv2hzYa4i2sul
         NaA1Tba44AUn7aA5wtwUv95JqBgoPNbnzOVOJQmxwIDMJi/ZwCRV4BvW+B7Bs05Ny8Aw
         aBihtKNZEBnjawP3wjB+LK8lGjP0RS7VAI1iS3zp87Mgzur7enfuLg9wYAXg52kB9TWc
         oo6a6RcYrhjWdo/kKHIVKYNKS0lBxzfuQH0xAobzT0r6CR9fRwYc3sP7rTdo2tH9K+HJ
         2xokQ0cvAOliK+1fQqSjkXdpK6neezXfFruTrJ0OM7bJRbT428Ggd6pxi2d6GlDIPtzQ
         zD6Q==
X-Gm-Message-State: AOAM5326mFvTly5EoqoRaEPGh7WC1z/O5xVEQR6oHSibe5G5X+iWJJTZ
        ff3Ztl7ViniqKxMAcluCbwTDWnM66PtyzYlE8KpgxA==
X-Google-Smtp-Source: ABdhPJyauiwVNK3F8aHtjkSSue45fsdrC/ZAP+yDT7A1hDKs5ujzLl8YJlHq93WLvkvXZHRQtIN75jL/gr1bSV1yhnE=
X-Received: by 2002:a2e:81d9:: with SMTP id s25mr10355947ljg.104.1598568920739;
 Thu, 27 Aug 2020 15:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200804091603.541-1-a.fatoum@pengutronix.de>
In-Reply-To: <20200804091603.541-1-a.fatoum@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 00:55:09 +0200
Message-ID: <CACRpkdb9NBpS3yvvX+G8NWgVdSqR5vd6DxP2rT7GCuB0ObnvHg@mail.gmail.com>
Subject: Re: [PATCH] gpio: siox: indicate exclusive support of threaded IRQs
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Thorsten Scherer <t.scherer@eckelmann.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On Tue, Aug 4, 2020 at 11:18 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> Generic GPIO consumers like gpio-keys use request_any_context_irq()
> to request a threaded handler if irq_settings_is_nested_thread() ==
> true or a hardirq handler otherwise.
>
> Drivers using handle_nested_irq() must be sure that the nested
> IRQs were requested with threaded handlers, because the IRQ
> is handled by calling action->thread_fn().
>
> The gpio-siox driver dispatches IRQs via handle_nested_irq,
> but has irq_settings_is_nested_thread() == false.
>
> Set gpio_irq_chip::threaded to remedy this.
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

I think we concluded we want to apply this patch, but with
a fixed commit text, can you send a V2? (Or ask Uwe if he wants
to pick it up and write the text.)

Yours,
Linus Walleij
