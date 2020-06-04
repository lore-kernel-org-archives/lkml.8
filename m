Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDE7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81177206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFDMvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:51:53 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:34872 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFDMvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:51:53 -0400
Received: by mail-oo1-f68.google.com with SMTP id e12so1216539oou.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZN38JmrN8vqGz8+PUtDOXoeKLTv7lNfegH7QoQuS+Cg=;
        b=DUAKQqVw43qLIxB2578m07C5zwQwHR7OQGrWkOrdDZuAsXRgGTPWl4ireGic1IYrTZ
         7XbW9VGs7bf93NW5ywrqHSkL6QDyxltJvTmYMNiJc7CY5RNRVDUJAhtwJTf68lzw7VME
         01SDeQ6d1WNssu1OdpTPvzqKl9NPsM8UjFWDLRS4fKVxdZU6Dvss+XPlho7pv82N3cI2
         mjUTwW48WZjBhkBfqP3LTCWS4a2ArDQIzWlQMPM6nX651LI2mz+V7gqv43wgORQMBIiV
         8j7vdjYjaj4kR5UIJzLkGRv8/DhQW/eJkVStNKic7gHPpi/VJ4A4AV9Z8rBAucPrsY9l
         UAvA==
X-Gm-Message-State: AOAM530tMnutF3tuck0SxqHk+3bcbOyfzhzXON+SPx3mE6UMX8V1coeR
        Ay1RuOzYYwsnYJqr5zaSzTifDfdbAkvG12uFAgQ=
X-Google-Smtp-Source: ABdhPJwrNMqwRNBWMNB6iDUETVg0jP+4RAZlz7cdtMQXWLZ9o0j7yx6n8S0CWGGrr2qF7G5m8T1QtwuOtggTMUZXork=
X-Received: by 2002:a4a:95d0:: with SMTP id p16mr3638116ooi.40.1591275112310;
 Thu, 04 Jun 2020 05:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com> <20200604122805.d2ndjmkmti6wl3nz@master>
In-Reply-To: <20200604122805.d2ndjmkmti6wl3nz@master>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Jun 2020 14:51:40 +0200
Message-ID: <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
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

On Thu, Jun 4, 2020 at 2:28 PM Wei Yang <richard.weiyang@gmail.com> wrote:
> On Thu, Jun 04, 2020 at 01:50:13PM +0200, Geert Uytterhoeven wrote:
> >On Wed, Jun 3, 2020 at 1:11 AM Wei Yang <richard.weiyang@gmail.com> wrote:
> >> Add some test for get_count_order/long in test_bitops.c.
> >>
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >
> >Thanks for your patch, which is now commit 7851d6639caeea40 ("lib:
> >test get_count_order/long in test_bitops.c") in linux-next.
> >
> >> --- a/lib/test_bitops.c
> >> +++ b/lib/test_bitops.c
> >
> >> @@ -24,6 +28,26 @@ enum bitops_fun {
> >>
> >>  static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
> >>
> >> +unsigned int order_comb[][2] = {
> >> +       {0x00000003,  2},
> >> +       {0x00000004,  2},
> >> +       {0x00001fff, 13},
> >> +       {0x00002000, 13},
> >> +       {0x50000000, 31},
> >> +       {0x80000000, 31},
> >> +       {0x80003000, 32},
> >> +};
> >> +
> >> +unsigned long order_comb_long[][2] = {
> >> +       {0x0000000300000000, 34},
> >> +       {0x0000000400000000, 34},
> >> +       {0x00001fff00000000, 45},
> >> +       {0x0000200000000000, 45},
> >> +       {0x5000000000000000, 63},
> >> +       {0x8000000000000000, 63},
> >> +       {0x8000300000000000, 64},
> >> +};
> >
> >noreply@ellerman.id.au reported for m68k-allmodconfig:
> >
> >lib/test_bitops.c:42:3: error: unsigned conversion from 'long long
> >int' to 'long unsigned int' changes value from '12884901888' to '0'
> >[-Werror=overflow]
> >lib/test_bitops.c:43:3: error: unsigned conversion from 'long long
> >int' to 'long unsigned int' changes value from '17179869184' to '0'
> >[-Werror=overflow]
> >lib/test_bitops.c:44:3: error: unsigned conversion from 'long long
> >int' to 'long unsigned int' changes value from '35180077121536' to '0'
> >[-Werror=overflow]
> >lib/test_bitops.c:45:3: error: unsigned conversion from 'long long
> >int' to 'long unsigned int' changes value from '35184372088832' to '0'
> >[-Werror=overflow]
> >lib/test_bitops.c:46:3: error: unsigned conversion from 'long long
> >int' to 'long unsigned int' changes value from '5764607523034234880'
> >to '0' [-Werror=overflow]
> >lib/test_bitops.c:47:3: error: conversion from 'long long unsigned
> >int' to 'long unsigned int' changes value from '9223372036854775808'
> >to '0' [-Werror=overflow]
> >lib/test_bitops.c:48:3: error: conversion from 'long long unsigned
> >int' to 'long unsigned int' changes value from '9223424813412909056'
> >to '0' [-Werror=overflow]
> >
> >Indeed, on 32-bit, none of these values fit in unsigned long.
> >
>
> Hmm... I didn't test on 32bit platform. Sorry for that.
>
> >>  static int __init test_bitops_startup(void)
> >>  {
> >>         pr_warn("Loaded test module\n");
> >> @@ -32,6 +56,18 @@ static int __init test_bitops_startup(void)
> >>         set_bit(BITOPS_11, g_bitmap);
> >>         set_bit(BITOPS_31, g_bitmap);
> >>         set_bit(BITOPS_88, g_bitmap);
> >> +
> >> +       for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
> >> +               if (order_comb[i][1] != get_count_order(order_comb[i][0]))
> >> +                       pr_warn("get_count_order wrong for %x\n",
> >> +                                      order_comb[i][0]); }
> >> +
> >> +       for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
> >> +               if (order_comb_long[i][1] !=
> >> +                              get_count_order_long(order_comb_long[i][0]))
> >> +                       pr_warn("get_count_order_long wrong for %lx\n",
> >> +                                      order_comb_long[i][0]); }
> >> +
> >>         return 0;
> >
> >BTW, shouldn't get_count_order_long() be tested with the values in
> >order_comb[], too?
> >
>
> You mean
>
>        {0x0000000000000003,  2},
>        {0x0000000000000004,  2},
>        {0x0000000000001fff, 13},
>        {0x0000000000002000, 13},
>        {0x0000000050000000, 31},
>        {0x0000000080000000, 31},
>        {0x0000000080003000, 32},

Yes, those values.  And those should work with get_count_order_long()
on both 32-bit and 64-bit.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
