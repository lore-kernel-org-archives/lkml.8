Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14548C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63A3221F1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttqb2LzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGHIo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgGHIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:44:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01A5C08C5DC;
        Wed,  8 Jul 2020 01:44:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 1so1969307pfn.9;
        Wed, 08 Jul 2020 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONAKYsQcGLB0KWO9KsZT23jzd5EzR7wWWBqrHyYhthU=;
        b=Ttqb2LzVr4jdMhwS90PiN3eXEZTPMhLRvHAuB7cIMZTaws+zpoVzQazaOYkWsFEqQJ
         zFGxMgENxCv0AbyM2d7TXvTvjMqTj7vU3ncb5/zhjujcB1uO8OeYXTmzSoSNatzFQ7eg
         FbEgnX90VjrUmTiVEFW/J0rVFBFMG8bm8Bex/hPbsLW/gmjkqimsIcK1s+vKvxxfnFYG
         nnt62ZMExM5g0WbuvIgc22NQ2hE2dKTpOlcd0rPWYaOWyAVmVeIwA9epLe5w1F67Whx2
         1NiwU9mnLZlij2st55r598GKq0mh6DvewpgZZ7o81RW1mHrwahD14jZXuxMQGr+NshuN
         BaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONAKYsQcGLB0KWO9KsZT23jzd5EzR7wWWBqrHyYhthU=;
        b=Yud1J7eNUAc0nRQlc8sSgCrnL5l+vu91y1psHKo2jlDu4pvic13aTnLtLuaKx8F0k0
         hhl9hxdJBRiNTTz6llwch4wsAsoquZd7wERn5iMwQAFM0sAUpu1UE08q+lJM5safg5LE
         L/HW+zq9xR60FvSewK+Qt1Cr2fHL1jnmsyO0vW+HwQNH02Kjtss778sY8SITZaOoblvE
         lx1JeC0rmQBGZcbcOcjWNWAYhtLWqiTrkWP8ES5kKoSdhPWWS92ustR/KrHhifGY1QcM
         zGzc1ok/X8bqOtDtN/5YYh8e1SA9qtPS+DSErIr8wNe0Nq2J/Om46VnFvRUwLy21Ry4d
         Zf9A==
X-Gm-Message-State: AOAM5335zBOQf7zOIwl1jhfJ8JMPor6paIM6XC/WbOgSOFXmkBV3OsBs
        0nUZXPLH0XAx81s+BVkUY1w/HLIsgPbm3LGKNQKnNKAK
X-Google-Smtp-Source: ABdhPJzuScYlOoIVA8NU8tZY3aB6xmD2tggybXIP8XOeUyJDR6i6kYq7rB12dKLxskNo4NfKE1JkQI7FxMR6NILRIzE=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr25429559pgi.203.1594197865186;
 Wed, 08 Jul 2020 01:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200708082634.30191-1-digetx@gmail.com> <20200708082634.30191-4-digetx@gmail.com>
In-Reply-To: <20200708082634.30191-4-digetx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jul 2020 11:44:08 +0300
Message-ID: <CAHp75Vc56D5QeL2WArUj4OGGk4XgkiK37FnFr=5+XsisLpng1A@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] gpio: max77620: Replace interrupt-enable array
 with bitmap
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 11:30 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> There is no need to dedicate an array where a bitmap could be used.
> Let's replace the interrupt's enable-array with the enable-mask in order
> to improve the code a tad.

...

> +#include <linux/bitops.h>

>         unsigned int            irq_type[MAX77620_GPIO_NR];
> -       bool                    irq_enabled[MAX77620_GPIO_NR];
> +       unsigned long           irq_enb_mask;

I would rather to move to DECLARE_BITMAP()
(the macro is defined in types.h IIRC)

-- 
With Best Regards,
Andy Shevchenko
