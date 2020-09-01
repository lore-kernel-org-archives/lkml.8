Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D985EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B296B2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bsLkINae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbgIAPuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbgIAPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:46:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D9C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:46:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ba12so1932469edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+9aVf+WSnx8CBq0GMCkAfZ1rE+F3TmQ51w7zDfTEpU=;
        b=bsLkINae79fmFro/p0x4TrU0JPjb70SfWRMj/SD8wyDYjWGqfNFVN3cF82yY9YgE3o
         OZ8NSRIM1f9IzBldCUDaNmWdyUyWf72VTcIerawmb/ionJGJyExm4vAsAj6TU3Y1UVQJ
         I4deO4GlLU3Xh7d6RRHWNAa/sCZ0XR5/UDCnHDiiXcf5IBLgQ/GPTm06XO33k+2bNQM8
         PJOxxlJ5x7aYbCLPHp9ykMJ4txU7sLGT8x3NqLliRcSYdV3ADCkKXfOgMkOfoy3w5eB1
         nBJbNzr7FoprbxP7G/pNLzIdL3/AqO+NhKi+76PuBzuDHP+yrSMlP2FunNH1zMGNcsts
         meIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+9aVf+WSnx8CBq0GMCkAfZ1rE+F3TmQ51w7zDfTEpU=;
        b=aHDgJy5qB3RXltkAlSk27TVayRYpRxqnbZiWreT3HGVr4WFwC3Hhs4tMR867Nm884O
         jvy8/wf6Q55JSKHQDaGlcRUsDhN8aqqBVrRfrW229wYEZ+J2hh3X5LtoZ0Yy6LEOYQSN
         3qsjN2FCFRQksRHhZbs15B6ih7KyXy1XAV60nbbeM6zdnUJ3VSZ2xpK3l0EzlER1SkTI
         1oD9PKv3GwSnxV4Qi33+d0V+UYo6E3zas1FZuJrKZ4uBvReZjy6lBL+5r73Y6p7zk13N
         QQfOm47mej5MjtaCQWZwR3OS3fIMi51TJOkRuo2y7nkdtS9iKLbA2o44QqHFFvZIiAwo
         +Jug==
X-Gm-Message-State: AOAM531JetOleUji6j9OCwGlrwck3AE0DzbMNw+LZxZMS8gYHhjhyfmB
        GmNMkFS2cUSroLOL0Qj1Xm00d9nqP8Z/5uTIHYOtFQ==
X-Google-Smtp-Source: ABdhPJy9BsUfD5Aq/2j2MP/wrG+Xf4MWg6SG1u0JNFyLS/rxN4ufnUmjbfZBOe7rG30qhP3tLqEd6MwFC42qu97zKq8=
X-Received: by 2002:a05:6402:17ec:: with SMTP id t12mr2167525edy.328.1598975202861;
 Tue, 01 Sep 2020 08:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <1598858073-5285-1-git-send-email-dillon.minfei@gmail.com> <1598858073-5285-2-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1598858073-5285-2-git-send-email-dillon.minfei@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 1 Sep 2020 17:46:31 +0200
Message-ID: <CAMpxmJW9iMVJgm6czSz5fPpRVHFnnp4=6x_7fTcJxGL1f10RGA@mail.gmail.com>
Subject: Re: [PATCH: 1/2] gpio: tc35894: fix up tc35894 interrupt configuration
To:     dillon.minfei@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 9:14 AM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
> The offset of regmap is incorrect, j * 8 is move to the
> wrong register.
>
> for example:
>
> asume i = 0, j = 1. we want to set KPY5 as interrupt
> falling edge mode, regmap[0][1] should be TC3589x_GPIOIBE1 0xcd
> but, regmap[i] + j * 8 = TC3589x_GPIOIBE0 + 8 ,point to 0xd4,
> this is TC3589x_GPIOIE2 not TC3589x_GPIOIBE1.
>
> Fixes: c103de240439 ("gpio: reorganize drivers")
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  drivers/gpio/gpio-tc3589x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
> index 58b0da9eb76f..ea3f68a28fea 100644
> --- a/drivers/gpio/gpio-tc3589x.c
> +++ b/drivers/gpio/gpio-tc3589x.c
> @@ -212,7 +212,7 @@ static void tc3589x_gpio_irq_sync_unlock(struct irq_data *d)
>                                 continue;
>
>                         tc3589x_gpio->oldregs[i][j] = new;
> -                       tc3589x_reg_write(tc3589x, regmap[i] + j * 8, new);
> +                       tc3589x_reg_write(tc3589x, regmap[i] + j, new);
>                 }
>         }
>
> --
> 2.7.4
>

I suppose this patch may be correct but I don't see how commit
c103de240439 ("gpio: reorganize drivers") could be the culprit. It's
been like this since the original driver implementation from commit
d88b25be3584 ("gpio: Add TC35892 GPIO driver").

It's been over a decade since this driver was merged and nobody ever
reported this. Either nobody ever used the GPIO module with interrupts
(unless the bug's impact is not significant) for this chip or this is
a quirk of some specific model you're using. Could you double-check
this?

Bartosz
