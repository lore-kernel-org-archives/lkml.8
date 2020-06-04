Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE01C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F07F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgFDLu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:50:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37376 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgFDLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:50:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id m67so4798950oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 04:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tn4ciUEqYDRuzKpYldMo242AzTN0dml31bWeRYNSHM0=;
        b=KJnrLSn0kiIjQoqS0lpyyT9rrb1jl/I56RqF9qBRdrQaxTzJy87ExvjIEzi00U3zu9
         FqlN4mWk+rvpzlprQTGagqowEQDFMzRJ0sD7Y1scwSH6tSOBuf//0CtssTc0Gpk5VP91
         Kg6Z6tmS7O1fpd/MTo7ItZzxAH6jhv4cJlG8U6OGdUnB7/rbY9k89PvhE5686kKle3fO
         40ucxS4jK0ZSrZcjT7q+Dbxf+QF8OnPalS8wwT4y/4GsUkSy23ygxoXKhKnxswv2wkzD
         7RRD+sTeAwFkkJMp7Eh12KHKMJ8AsvfitYW/08oO4U5Ozqth8RJnX105EP/SXgzGLfX4
         pLvA==
X-Gm-Message-State: AOAM533gZJcXjNHlLPcRswlMm3Vmmj7BfycnqforC/KVvx0bQ0oOLUn0
        kcGKLA5evL3+TWLeN+fFUC5P77pkteG2hKSjWXw=
X-Google-Smtp-Source: ABdhPJxtIxrW6tZGQvZm+OYoHtBBDGpxFSfJInGP0eTzA+QKXqvFWSJejqcgi6r7GLgku4bBTnF9BMUqZTv2w2xtbog=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr2821601oia.54.1591271425314;
 Thu, 04 Jun 2020 04:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
In-Reply-To: <20200602223728.32722-1-richard.weiyang@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Jun 2020 13:50:13 +0200
Message-ID: <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Wed, Jun 3, 2020 at 1:11 AM Wei Yang <richard.weiyang@gmail.com> wrote:
> Add some test for get_count_order/long in test_bitops.c.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Thanks for your patch, which is now commit 7851d6639caeea40 ("lib:
test get_count_order/long in test_bitops.c") in linux-next.

> --- a/lib/test_bitops.c
> +++ b/lib/test_bitops.c

> @@ -24,6 +28,26 @@ enum bitops_fun {
>
>  static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
>
> +unsigned int order_comb[][2] = {
> +       {0x00000003,  2},
> +       {0x00000004,  2},
> +       {0x00001fff, 13},
> +       {0x00002000, 13},
> +       {0x50000000, 31},
> +       {0x80000000, 31},
> +       {0x80003000, 32},
> +};
> +
> +unsigned long order_comb_long[][2] = {
> +       {0x0000000300000000, 34},
> +       {0x0000000400000000, 34},
> +       {0x00001fff00000000, 45},
> +       {0x0000200000000000, 45},
> +       {0x5000000000000000, 63},
> +       {0x8000000000000000, 63},
> +       {0x8000300000000000, 64},
> +};

noreply@ellerman.id.au reported for m68k-allmodconfig:

lib/test_bitops.c:42:3: error: unsigned conversion from 'long long
int' to 'long unsigned int' changes value from '12884901888' to '0'
[-Werror=overflow]
lib/test_bitops.c:43:3: error: unsigned conversion from 'long long
int' to 'long unsigned int' changes value from '17179869184' to '0'
[-Werror=overflow]
lib/test_bitops.c:44:3: error: unsigned conversion from 'long long
int' to 'long unsigned int' changes value from '35180077121536' to '0'
[-Werror=overflow]
lib/test_bitops.c:45:3: error: unsigned conversion from 'long long
int' to 'long unsigned int' changes value from '35184372088832' to '0'
[-Werror=overflow]
lib/test_bitops.c:46:3: error: unsigned conversion from 'long long
int' to 'long unsigned int' changes value from '5764607523034234880'
to '0' [-Werror=overflow]
lib/test_bitops.c:47:3: error: conversion from 'long long unsigned
int' to 'long unsigned int' changes value from '9223372036854775808'
to '0' [-Werror=overflow]
lib/test_bitops.c:48:3: error: conversion from 'long long unsigned
int' to 'long unsigned int' changes value from '9223424813412909056'
to '0' [-Werror=overflow]

Indeed, on 32-bit, none of these values fit in unsigned long.

>  static int __init test_bitops_startup(void)
>  {
>         pr_warn("Loaded test module\n");
> @@ -32,6 +56,18 @@ static int __init test_bitops_startup(void)
>         set_bit(BITOPS_11, g_bitmap);
>         set_bit(BITOPS_31, g_bitmap);
>         set_bit(BITOPS_88, g_bitmap);
> +
> +       for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
> +               if (order_comb[i][1] != get_count_order(order_comb[i][0]))
> +                       pr_warn("get_count_order wrong for %x\n",
> +                                      order_comb[i][0]); }
> +
> +       for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
> +               if (order_comb_long[i][1] !=
> +                              get_count_order_long(order_comb_long[i][0]))
> +                       pr_warn("get_count_order_long wrong for %lx\n",
> +                                      order_comb_long[i][0]); }
> +
>         return 0;

BTW, shouldn't get_count_order_long() be tested with the values in
order_comb[], too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
