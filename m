Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37747C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16461207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/rFP5jU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbgE0N4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbgE0N4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:56:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF1C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:56:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so14496664lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=guH7o/1zYnrQw/f4NGxjhbP6GUVVrqoSi4RVWW1wiy4=;
        b=h/rFP5jU7cioPjV1DkfLT60l5HzFyDlE43d+yIyGjpfGLX2l3Efe85Ur+Ba64KLcoM
         zSYmCjOkxvc2ZeDK7/xCokEXGfmeESMxEhM1vFyZ4mm4OVpkfYIy0kTgHat70yi0Ebfh
         68eNZx98yKTvnu/hHahi3tJ2DC11bSZCNOB2nh/hZy5a7Je7cZbRmg0Segd0Iab7I/tD
         7ZYha8VDL6/NZ+JjecV+WhiRmjxXBoR/aC4fDyHB5sUCzU6KG+SAE2itO0Krph+MUMMM
         FGtepvb7QfEBglndReZsyTY+Q4Kt9DyQAdzaxgfPQa9ouzGJPES8JZJFix8W7ptVwJ21
         LXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guH7o/1zYnrQw/f4NGxjhbP6GUVVrqoSi4RVWW1wiy4=;
        b=YXf0ns4KooHNjPQc+iAay9mzOy8e6gZDG/H4vlYC7tmWlj+YyeAl9U6hVARzG/qXV5
         0cafJIJmaHQOWpy28u3aALl7f8aimHkTKNMPlzwaVWcIdmdRhcp07PYdHBCWxkHK7JVl
         +OgNudDDdOnerdkQyR3b43ziAnsPh1V4D65Wi3NjiInxNE/ER3LsUx3hdI9dQ8JGpXwp
         5kWMVvDiHornXfneUz+YBD3SX2eWMIUtIYbimnXKmHMhZ4c0XaxqDZmanuJVOX8KuvWg
         pDBqEwES905QvwCBZeO0w/H6qtPwDW2ckWpZYkytwSjVew1cYFkA3N3sQU3aRHNdUzNm
         Ctaw==
X-Gm-Message-State: AOAM530gdK9+l6o8zhUaA3n6rjrbKPhPlSln0/kN+yoQYavf9+0eHgMx
        NFxcjyiHHUxV6+y2Ol6e827oYM76Iwqq/OOgW0UQ7g==
X-Google-Smtp-Source: ABdhPJxrYvCdWpEHRw3d7mzHw1j45r/ov/6G/cOSMxC5Z8VzEhLXjdUKpusqyG8DMTsrJLjU1wzwEFrlZvIRc1t0YLM=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr3207793lfn.77.1590587788858;
 Wed, 27 May 2020 06:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <1590253873-11556-1-git-send-email-mkshah@codeaurora.org>
 <1590253873-11556-2-git-send-email-mkshah@codeaurora.org> <CACRpkdba9j4EdCkD5OeL=3A4Zeb57vO78FAXA9fo0SOgBE57ag@mail.gmail.com>
 <3efa1f69-1e1d-f919-d47e-b4c5c73532b7@xs4all.nl>
In-Reply-To: <3efa1f69-1e1d-f919-d47e-b4c5c73532b7@xs4all.nl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 May 2020 15:56:16 +0200
Message-ID: <CACRpkdY3pJVvAi_a=pVVQQbQyA3_b=o2pJqb5W8Wivp-SSy+tA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] gpio: gpiolib: Allow GPIO IRQs to lazy disable
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Russell King <linux@armlinux.org.uk>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:38 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:

> However, I discovered that patch 256efaea1fdc ("gpiolib: fix up emulated
> open drain outputs") broke the cec-gpio driver on the Raspberry Pi starting
> with kernel v5.5.
>
> The CEC pin is an open drain pin that is used in both input and output
> directions and has an interrupt (which is of course disabled while in
> output mode).
>
> With this patch the interrupt can no longer be requested:
>
> [    4.157806] gpio gpiochip0: (pinctrl-bcm2835): gpiochip_lock_as_irq: tried to flag a GPIO set as output for IRQ
>
> [    4.168086] gpio gpiochip0: (pinctrl-bcm2835): unable to lock HW IRQ 7 for IRQ
> [    4.175425] genirq: Failed to request resources for cec-gpio@7 (irq 79) on irqchip pinctrl-bcm2835
> [    4.184597] cec-gpio: probe of cec-gpio@7 failed with error -5

There is nothing conceptually wrong with that patch so I think we
need to have the irqchip code check if it is input *OR* open drain.

I'll send a separate patch for this, it should be an easy fix.

Yours,
Linus Walleij
