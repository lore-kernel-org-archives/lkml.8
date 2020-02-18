Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D1C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E6320801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581989150;
	bh=eUsHrRNXHop8DKwg4yRTLqYNK6mkPQhNJTnx8crz4RI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T2UwZB8yYC6jjhKULLrcudUps9GchmuUQb5S/O9gUTLx2B55cAy7/FuJQB5ue2UIv
	 rtn3FxCoYWOh7r7LqbObXCyKx0b2EDJpdLn1QethG+PUHewvGKIhftGhrDo7jYImXj
	 +p6ZpvBNO/TvjdcdwS7MxWx71E30wEs7e/syYRwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgBRBZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 20:25:49 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:34042 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgBRBZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:25:49 -0500
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 01I1Pjfa029198;
        Tue, 18 Feb 2020 10:25:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 01I1Pjfa029198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581989146;
        bh=aHC68Gt/bTCwhaQGD8YtBd8mxysiY1ksslwULIMw21M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xbEqK3B/f3ZeMYMcEPTAwBLvw/Ioli6bXibu/eckH3BDDXYHgqFmWCrnJYxXXOyGO
         AFeSVqb5NsZHr8kjUSTnwPHpgJgcWnajxN4MDVTrRLBSIERI1ol1T69DCm+lISgKQs
         4wWoHI+CoQSGN9EKnI0jtyJik53CnvaFH4mxJofHuhgFEPNlQfB/vcXtEPErRdL1/y
         c1wLpig6ijRKdqUor0kQTVWy3ygub06fsVPGUIH4PYniCUj0HQZDtbiIexE/aNURzr
         j31xvcEE4jSd2F/XdiuXtI5YUcioAO02a17Gus4CVxAmR73eAkvlpogH7wTwAv6CIN
         h4kbOzU+id4Rw==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id t129so5096644vkg.6;
        Mon, 17 Feb 2020 17:25:45 -0800 (PST)
X-Gm-Message-State: APjAAAW08EiFdmzt9DTEhGkJWYyhxmhcGeSYzBl/9HMu/tRM/qWIW5Le
        MJejCxlktyp1zjb8HoZt42KVQWPsLClRRPe/8v4=
X-Google-Smtp-Source: APXvYqy1ybYtwGWK9rAxqG/hSwwoXAw5Wot5iv+8VzvGaL2uwXfJVUdhHC48DVLj7zfTqgLkFc5MMVzBt7ScX6KrvQ0=
X-Received: by 2002:a1f:6344:: with SMTP id x65mr6933830vkb.26.1581989144317;
 Mon, 17 Feb 2020 17:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20200211210618.GA29823@embeddedor>
In-Reply-To: <20200211210618.GA29823@embeddedor>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Feb 2020 10:25:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASABqhpCjoQkQAZAVOjTvVG+4PDWaP+a8=hcv6GsgeQMQ@mail.gmail.com>
Message-ID: <CAK7LNASABqhpCjoQkQAZAVOjTvVG+4PDWaP+a8=hcv6GsgeQMQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: uniphier: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 6:03 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> ---
>  drivers/gpio/gpio-uniphier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index 0f662b297a95..9843638d99d0 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -33,7 +33,7 @@ struct uniphier_gpio_priv {
>         struct irq_domain *domain;
>         void __iomem *regs;
>         spinlock_t lock;
> -       u32 saved_vals[0];
> +       u32 saved_vals[];
>  };
>
>  static unsigned int uniphier_gpio_bank_to_reg(unsigned int bank)
> --
> 2.25.0
>


-- 
Best Regards
Masahiro Yamada
