Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544B2C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261172077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vid4ORIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAON04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:26:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39350 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgAON04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:26:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so18519293lja.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 05:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IveF9K9ZvQHL0XCm0NhMK8V0t0Mh/Q+IVIFeaL32PDg=;
        b=Vid4ORIFzRzRLvESZpBs3Ah4aXP8I9dQvIMEoJ2abQEipxzFgRbq9cgs9qV9tZo8dG
         r+ALUOnRFW2hAYj80mACUV0tm2AUq+uiOJAz+mpLJtu+HvdKUdsgrIMqP81AttT6bPAo
         1iHOwyHySY/4v/351X1jQCrAfvgaejUZBV4oWitZ86TuNguKyKPqrdRsNH9EEYJIu+ke
         53zqhsRIr0ZRuBjgFtn1h2jzcpYaaDdvzuXzBv5EnJgleDjRzLUmBMOFTxPgCbwigVIN
         P4Fga4cDvP8gNm3KESwycpE4VyKfdY23u3ZtYMFvsV+t2rXJZt0ViTH6zsxGQsNoh/A/
         pmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IveF9K9ZvQHL0XCm0NhMK8V0t0Mh/Q+IVIFeaL32PDg=;
        b=HU2OWr+Gze8+0jx7oD3Zf16tNmI2Fa/O2jS/nlK9Y7V1a0WFfZ73HVhtoSyTHjBw+P
         nwCfp3GRWs7SUUr0mswvA0muknEwKaFeqooC1g1xSE3zeLRJv9Waqxf3XYTBEjx+UawN
         nxKI00oMAMe2CYfNR4pil2UH7FEj2AA1nn+u2tVCvVz0dM+PqPLApRdMegn9ZzNn2mCX
         pEIJWvgfaFqs6uYhyek4rkYQKMtZzrRA2RZRQt2cnR/lgoc+o/J+2ptS/iTMc2SF9T8l
         /Eko1NgvVlimB1j0ucaRq6TJptJgGNmwhc/ZKwB3yhVQkbWJkqFgEX8cM2KkINXiHJSP
         U5Hw==
X-Gm-Message-State: APjAAAXyqSTM3a4vPPMY0dfhcnS7623vlsXKWBBJFXHU3/To6sst+7lW
        QEc6YobkKz3urY8AviEBVDDiq0A69ulAL/pvzHM89Q==
X-Google-Smtp-Source: APXvYqzEhjenLEHzG+AYX+BQqoKY2hyu8eJGNOhb1pcFBkrZR5Ijv0RrNHTx/pnJ+SIgH09JhG4jxqIioUO98aLqqnc=
X-Received: by 2002:a2e:3609:: with SMTP id d9mr1649272lja.188.1579094814272;
 Wed, 15 Jan 2020 05:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20200115073811.24438-1-bigunclemax@gmail.com>
In-Reply-To: <20200115073811.24438-1-bigunclemax@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 14:26:43 +0100
Message-ID: <CACRpkdbefJsH2km3p433NN2koNck7hgNqLWpD3q4r=Um75GZEw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: clear irq in edge cause register before
 unmask edge irq
To:     Maxim <bigunclemax@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 8:40 AM Maxim <bigunclemax@gmail.com> wrote:

> From: Maxim Kiselev <bigunclemax@gmail.com>
>
> When input GPIO set from 0 to 1, the interrupt bit asserted in the GPIO
> Interrupt Cause Register (ICR) even if the corresponding interrupt
> masked in the GPIO Interrupt Mask Register.
>
> Because interrupt mask register only affects assertion of the interrupt
> bits in Main Interrupt Cause Register and it does not affect the
> setting of bits in the GPIO ICR.
>
> So, there is problem, when we unmask interrupt with already
> asserted bit in the GPIO ICR, then false interrupt immediately occurs
> even if GPIO don't change their value since last unmask.
>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

This looks correct to me, a review from the MVEBU maintainers
would be appreciated.

- Should it be applied to fixes as a regression fix?

- Should it be tagged for stable?

Yours.
Linus Walleij
