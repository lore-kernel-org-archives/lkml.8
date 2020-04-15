Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3CBC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E546920767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414764AbgDOPga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:36:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:46889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414755AbgDOPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:36:27 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N1Oo7-1jHTtb3PEx-012mIa for <linux-kernel@vger.kernel.org>; Wed, 15 Apr
 2020 17:36:25 +0200
Received: by mail-qt1-f171.google.com with SMTP id x2so13577351qtr.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:36:24 -0700 (PDT)
X-Gm-Message-State: AGi0PubUrgJH+B8roOSSeQunEy5YpBii1s+9myXJUP7BXtnedS6CoUGY
        0Avzwjg3fjxhCNsI9jQcFEAEWZzS7G9nwwBZExA=
X-Google-Smtp-Source: APiQypJIUuuzcLdHHn2E9oSQH9GkrGPhjt4IZpFRZmL1irhVR/KZ+X1MWvLnL+BAuL5y8kjP6g+U6bLsXmnJCMwOAAc=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr21209126qtb.142.1586964983698;
 Wed, 15 Apr 2020 08:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586757922.git.baolin.wang7@gmail.com> <ca403b816af38eae68ca7399640c82d0345a2296.1586757922.git.baolin.wang7@gmail.com>
In-Reply-To: <ca403b816af38eae68ca7399640c82d0345a2296.1586757922.git.baolin.wang7@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Apr 2020 17:36:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a06fed_WVmO84iod2VpY386_3J+V=A-M+W7yE57N04a8w@mail.gmail.com>
Message-ID: <CAK8P3a06fed_WVmO84iod2VpY386_3J+V=A-M+W7yE57N04a8w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] soc: sprd: Add Spreadtrum special bits
 updating support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MQnvqLOoWwqTuhAeHc2QB61aLz/NzXqAPWq5pVuRAUy5+fSKJ5S
 MsMTXCs9DWVAOXPA5xj4V2z9QP33FytL6zYK271HtnLtnH1bNnya0vvKcLtQqUen9olsIYU
 iRLi2MyvRkPDt5Dcd96anlK4/wOZtkUmeB0ui00TuP5EazC1Pn/Llb1PF10PNYj5fixl5id
 pg/X+n594Il2zKK9gwNVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fbRXHR7l6S4=:4cKBIH25KCcvxXWvp7z+xD
 hYFi2KNrLLdqRiELpGfhaF9qQyK8G524b1MasvKsYpSUf0GLEMdzVjj6AOSF0FLJ9ZPQZYqr7
 LkN5xr4TcB9szTQE3AweCXIypobUvYPE/GVgTaCV40LUUmhwfZaq/go3wqPDkiehE3R+VaoSY
 /HESg9O7k05nP0ifcTLjVwj5EoFjI8BiCEuzf+BeBuoUo2EvUbpP1bWtbksxSlPNa/9tswqa/
 Ia3nRPyGm7bzt+BBj+9P9VEqfk4VKYwvNhEWYx60BicIRGKVHPhPHc5GrwvZC5UgiiRMI8wdB
 XlsoqKK1r2o9lYH9GeopBv0UKg6u4ib9HBKosDgEVXp/Mp9M9U1q0VmB+8GJfgC2di/cPxcEf
 pO8RL1TgElmr+J775t0i5SZwb128oZqKDSQkt0LvSMP23YaUK1g0z3aYlF1YfM56ZHqLi41Ld
 QRoqfLnhDsoONpTNFvH0PeL8rh+qFt5nuFM4PkJtINBoUHfqHGwIVVM5KJPhLcoOKomZwwhXY
 9ZODzLNeUWfYzr/dUKsL57uKooaXWLEyiSoWBD7ZiLOhjTPrmGUBW8WtmZK+mHK1dv6ak6fe2
 fjT8y7B4I6UT/Mx7yD1CXvnxtU01257KjyEJguzhkLflH7tIyJAa6HNNZp6AdrXncZuuB7nsI
 7Ygbza32FAVZVhsycPpF/O/bo8o0bZR0FR2EMxfC5yrdhfC8b7sLGzBfi/Jz6FqNIWq43UK07
 egJ3si3gpE2kS8eJ9n6jJHygPyYFKSkkOAQiFC9DEbhFrooaTIX3xWjxyC47rLeexY2CWboc9
 9O/YVWE1RgziX9xkLpBD/M/Gqdvlm0OCeiKKd2P8bCqMTZ13CE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 8:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> The spreadtrum platform uses a special set/clear method to update
> registers' bits, which can remove the race of updating the global
> registers between the multiple subsystems. Thus we can register
> a physical regmap bus into syscon core to support this.
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

I'd hope to avoid complicating the syscon driver further for this.
Have you tried to use something other than syscon here to
provide the regmap?

> +#define SPRD_REG_SET_OFFSET    0x1000
> +#define SPRD_REG_CLR_OFFSET    0x2000
> +
> +/*
> + * The Spreadtrum platform defines a special set/clear method to update
> + * registers' bits, which means it can write values to the register's SET
> + * address (offset is 0x1000) to set bits, and write values to the register's
> + * CLEAR address (offset is 0x2000) to clear bits.
> + *
> + * This set/clear method can help to remove the race of accessing the global
> + * registers between the multiple subsystems instead of using hardware
> + * spinlocks.
> + */
> +static int sprd_syscon_update_bits(void *context, unsigned int reg,
> +                                  unsigned int mask, unsigned int val)
> +{
> +       void __iomem *base = context;
> +       unsigned int set, clr;
> +
> +       set = val & mask;
> +       clr = ~set & mask;
> +
> +       if (set)
> +               writel(set, base + reg + SPRD_REG_SET_OFFSET);
> +
> +       if (clr)
> +               writel(clr, base + reg + SPRD_REG_CLR_OFFSET);
> +
> +       return 0;
> +}

Regarding the implementation: Doesn't this introduce a new race
between setting and clearing bits if you do both at the same time?

This may not be a problem if you never do.

> +static int sprd_syscon_init(void)
> +{
> +       syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
> +
> +       return 0;
> +}
> +core_initcall_sync(sprd_syscon_init);

I don't think this part can be done at all: If you load the module on a
generic kernel running on a random other platform, it will break as
there is no check at all to ensure the platform is compatible.

The same thing happens on a platform that may have multiple
syscon nodes, when not all of them use the same register layout.

The only sane way that I can see would be to do it based on
properties of the syscon node itself.

        Arnd
