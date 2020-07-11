Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49B2C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8900920725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHHa8+6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgGKVKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgGKVKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 17:10:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13FAC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:10:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so5151019lfd.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOWgRRxR4UWenTLYws4CoXraeapBalWta2FCOM+uc9k=;
        b=sHHa8+6nIlJJQuvFQMaZWOUBweW42w+3iYH98jk4CNIe3q1h+bSrZhVqyAbwXh4v6K
         v/NcpV0QtlOQktytKw1wi8Fs2HtHByvIiHAwIFxHz5cQiG/HSL4cjZanmC9csp0QUTWX
         yIhN1baYwRytN3ha2eS8FZtwsVtrvYnO+112s9svp5ZkE9shCqN1k0MPn6/2eMZgtcS9
         2Jt0m4Xa680WGnXG5JL4xJk6W3MdpNVjb5IDwm8SgKHyQpVPxvoKGWud+l1kwKlVTvKr
         2I1hov+fTMzeNr8XLyEWHJIxNiTcuDwhzG5q2FJd3LCLFCN6rRyG8t0hThIlXYuCZ0cY
         3cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOWgRRxR4UWenTLYws4CoXraeapBalWta2FCOM+uc9k=;
        b=o5Bp2mKS7rs1/4rUD39dty7xTi100f7qmVNu3zhBYFOpTWVr4hfjg+2gbhbZRmgSTo
         iBuH40Hn5/PLrbxxp8bqtG2fVh5ez87O9OKrNIDUStXvBaUmhHcKFzmBxdNijce1AXRE
         SJwnY0st85/L77Wh4EKaCpmZLAncvQUznL9iegS/DKceFTlykNrA8b2TaHA/ZcJieg7l
         /4i7rs2nlJ+yRYCulSFHL76hmwzZGdMck0+VBxmKf12lgcVC00pCzAe84udMQr+YBZLR
         x7GAbPl/PjKjN+NGKt1Vnk2UC5qJkz2uY8BYFXxSL9f0/vXQIGOXQf0cdvgNzDWj+ZDo
         vw+w==
X-Gm-Message-State: AOAM530uQ3aRMj34VPy4ish39Ow0QW7dSD293V+63lh8OmkiOH6LCM6a
        M1RfbpwtWJuhGlgr5sgpUt7GMdK465FD8w9vV+NXY9Pp
X-Google-Smtp-Source: ABdhPJxArz9xVZdtoBR1nRK2V/Mwb4q0ExFsmBO6kekDQ2LETFFvaz78PtE0fDSpM7+xYZACgqAmHP1c4lDjcJAd+mc=
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr47703923lfp.21.1594501800249;
 Sat, 11 Jul 2020 14:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200703011830.15655-1-mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20200703011830.15655-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Jul 2020 23:09:49 +0200
Message-ID: <CACRpkdZ_YYhSn1FpxOGX5V9HrcMwQ553RWAbtDq56KPv8FCEzg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: nsp: Set irq handler based on trig type
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 3:18 AM Mark Tomlinson
<mark.tomlinson@alliedtelesis.co.nz> wrote:

> Rather than always using handle_simple_irq() as the gpio_irq_chip
> handler, set a more appropriate handler based on the IRQ trigger type
> requested. This is important for level triggered interrupts which need
> to be masked during handling. Also, fix the interrupt acknowledge so
> that it clears only one interrupt instead of all interrupts which are
> currently active. Finally there is no need to clear the interrupt during
> the interrupt handler, since the edge-triggered handler will do that for
> us.
>
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - Don't perform unnecessary acks.

Patch applied.

Yours,
Linus Walleij
