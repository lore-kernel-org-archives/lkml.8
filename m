Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F2DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 11:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AB02078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 11:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS/37sQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFMLLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgFMLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 07:11:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB73C03E96F;
        Sat, 13 Jun 2020 04:11:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so4706651pjb.0;
        Sat, 13 Jun 2020 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/TGhDnUmXe+dQywFvMJ+UQjU1pTW/aTR3c8S3kN/vc=;
        b=NS/37sQ6kCt0foJykakL9Kfn5mruX4+OEMrRW/04pdApBfwk9WS/8XdjkOksS4U1Oz
         EZ7UgJwZUiUWNmpoSgJE9wo4Ee1fjnxxBfSRoN4qA+cFCQaipSRzdg2Mlzri/p0WZnHX
         izPCvDrufcJXGmao3F5B/SKiOE5oesKR4HFDXKfCZCtaVnvkvFbcz+UM/yrKOI+cGRXQ
         7NeLLX385S5TouBfa+QQ/O20HwAy2WmoprqmhAGIBh614p4/9hinzLx/pgGX1v5mVbAq
         XOZPT36kbPaasMiP1ex0mBxTSMVfCcQDTZexTT26ykKPHlftl9OxSCBXw7KqE49zJaJ1
         NDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/TGhDnUmXe+dQywFvMJ+UQjU1pTW/aTR3c8S3kN/vc=;
        b=ssq0lkA3rFXWuj5dQpVkzP2kQSmwK7mpvT1WWheiziqj41Plf8DhGRaaSPfHz8xLJp
         w7wWD3bkvQrCkT2v3LSqPwaqM+A+D4C+God3SzdywfL4VlcWg1YAAOBzRxT+Y/r2xGIC
         j/Ek/E2Q9Cj4E1o2xXPtfU2ZDoiZFZfzdZnqTJ+rX+jDd/+nJX8BTiQJSoRDYel4YrCc
         hBShgAGF859vQo7zSqR0af6b/iklhSC8W9un3IVtZZV5uf5Rwp8HZ4YilgTdPPe1u3Dc
         A8GjeJky/Sj7a7qppHPUdHwcnV4DlrxHeUYzvuVg9EDrBz/E3RbZbPvZyoIWRYp91fEJ
         haNw==
X-Gm-Message-State: AOAM530a2rFmbvGPAJkin/JXFkInM6imDpMsVeAr0fAoJuU2wDUEK4aD
        2hM5rvoeTmSoOCsiLFmgBJyPqpCrQrJnjT4XE30=
X-Google-Smtp-Source: ABdhPJygAmlM22k//xyZLrfutgeeylWraEDO/m93o1DYXCDezfgp72/hd6FuPJPeVDhsTy7zWE0tcNkHctGHzw2oYTk=
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr12934597pll.18.1592046707124;
 Sat, 13 Jun 2020 04:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200612124844.19422-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200612124844.19422-1-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Jun 2020 14:11:30 +0300
Message-ID: <CAHp75VdMPt60CKnP1HtkN8=3iY7+Kgrv6b9DTjcj-KMKaRknvw@mail.gmail.com>
Subject: Re: [PATCH] lib: update DEBUG_SHIRQ docs to match reality
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 3:54 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> There is no extra interrupt when registering a shared interrupt handler
> since 2011. Update the Kconfig text to make it clear and to avoid wrong
> assumptions when debugging issues found by it.
>

I'm not sure.
I have recently fixed a bug in the IIO sensor during ->probe() due to
an issued test interrupt exactly as soon as the handler is registered.

...

> -         Enable this to generate a spurious interrupt as soon as a shared
> -         interrupt handler is registered, and just before one is deregistered.
> -         Drivers ought to be able to handle interrupts coming in at those
> -         points; some don't and need to be caught.
> +         Enable this to generate a spurious interrupt just before a shared
> +         interrupt handler is deregistered (generating one when registering
> +         is currently disabled). Drivers need to handle this correctly. Some
> +         don't and need to be caught.

-- 
With Best Regards,
Andy Shevchenko
