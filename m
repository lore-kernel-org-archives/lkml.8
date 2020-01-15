Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E469FC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB332467C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAmEbppX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAOOn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:43:27 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45680 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgAOOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:43:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so15790772qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dsov92auA7/G12RJ9hsAhzPgLmMj5NcPBeP6nNJDSO0=;
        b=HAmEbppXjeEjGFlyjzVhaLxJPK6Qu2TL7zFYWoJ+6xa7AMU7f8xGwf2Pzg99BRj++8
         RvmJHwFmUUh4S5athIHqzOwqDZLEUhNxjEiQK9XVd4nrV+B01TTnZczJQE2bcpTekpw2
         n6L4wFGMG6zO9x9aZT8ci6v9mM1zpqges4LhDd2kBEXpAdu0q+goONUh4uissEOW2n+j
         lQV7502daTXdwVDVOYsLIP6os+IibkP+OYMirLgI8gSuMWPKe5QQEzEWvHUksVAROFZT
         1LXCscvvcXbfvLyI4Nyo67cA34Y4T379odeXBQ7uz+eoJnT6eXfPRTE9U0o/5NY+5b3d
         EYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dsov92auA7/G12RJ9hsAhzPgLmMj5NcPBeP6nNJDSO0=;
        b=b20jSYTke1RA+sxwrT1grd6ushLgeO0hX+X4hl3cQgG9oUSlg6K8mPZJ/nXfe1G3FS
         k4Cd/+sPHCEBdET18+YKwx5D8mD4RH7wxh1ndnYGUivsIWB93LZT39Sleo2De7CitEwC
         R6twvoIGq5sQ7Kslkbjq24XNEOywKXx8H/zZ+OvV1O4N4qaQAlqOJpzFtnqssHqeEIsc
         E3pGCYIyNOXqTSBRfS555hjjnVJ/xb8A1Bl1EpUN897PBZzhnSeysAFAvq6q4l3ee7G5
         DHKBbqHZBIrAtT7ekFU+ps1KBmolpw1W8vL8EugiF5igluOeVBik471s4ld6j+Lbv8rQ
         w05A==
X-Gm-Message-State: APjAAAWi61W1/23H9EIw5osn52gn91y0EmRtUTKGqnNIxIU5Y9G3in2/
        V4XjPedN3dpd0ePXwi1NTW9i3N6dsy1FCb7uq1qPZCRj
X-Google-Smtp-Source: APXvYqyUwMjABHutPLZrK97jNVFWLT7TfwkGKBtOm4Z15o33FBoKxwGilBQv+LujNRvkTq3H/64pu/pRwGwVkNNWReE=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr28110133qkk.8.1579099404892;
 Wed, 15 Jan 2020 06:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20200115063710.15796-1-dja@axtens.net> <20200115063710.15796-2-dja@axtens.net>
In-Reply-To: <20200115063710.15796-2-dja@axtens.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Jan 2020 15:43:12 +0100
Message-ID: <CACT4Y+bAuaeHOcTHqp-=ckOb58fRajpGYk4khNzpS7_OyBDQYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 7:37 AM Daniel Axtens <dja@axtens.net> wrote:
>
> 3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
> memchr, memcmp and strlen.
>
> When FORTIFY_SOURCE is on, a number of functions are replaced with
> fortified versions, which attempt to check the sizes of the operands.
> However, these functions often directly invoke __builtin_foo() once they
> have performed the fortify check. The compiler can detect that the result=
s
> of these functions are not used, and knows that they have no other side
> effects, and so can eliminate them as dead code.
>
> Why are only memchr, memcmp and strlen affected?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Of string and string-like functions, kasan_test tests:
>
>  * strchr  ->  not affected, no fortified version
>  * strrchr ->  likewise
>  * strcmp  ->  likewise
>  * strncmp ->  likewise
>
>  * strnlen ->  not affected, the fortify source implementation calls the
>                underlying strnlen implementation which is instrumented, n=
ot
>                a builtin
>
>  * strlen  ->  affected, the fortify souce implementation calls a __built=
in
>                version which the compiler can determine is dead.
>
>  * memchr  ->  likewise
>  * memcmp  ->  likewise
>
>  * memset ->   not affected, the compiler knows that memset writes to its
>                first argument and therefore is not dead.
>
> Why does this not affect the functions normally?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In string.h, these functions are not marked as __pure, so the compiler
> cannot know that they do not have side effects. If relevant functions are
> marked as __pure in string.h, we see the following warnings and the
> functions are elided:
>
> lib/test_kasan.c: In function =E2=80=98kasan_memchr=E2=80=99:
> lib/test_kasan.c:606:2: warning: statement with no effect [-Wunused-value=
]
>   memchr(ptr, '1', size + 1);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/test_kasan.c: In function =E2=80=98kasan_memcmp=E2=80=99:
> lib/test_kasan.c:622:2: warning: statement with no effect [-Wunused-value=
]
>   memcmp(ptr, arr, size+1);
>   ^~~~~~~~~~~~~~~~~~~~~~~~
> lib/test_kasan.c: In function =E2=80=98kasan_strings=E2=80=99:
> lib/test_kasan.c:645:2: warning: statement with no effect [-Wunused-value=
]
>   strchr(ptr, '1');
>   ^~~~~~~~~~~~~~~~
> ...
>
> This annotation would make sense to add and could be added at any point, =
so
> the behaviour of test_kasan.c should change.
>
> The fix
> =3D=3D=3D=3D=3D=3D=3D
>
> Make all the functions that are pure write their results to a global,
> which makes them live. The strlen and memchr tests now pass.
>
> The memcmp test still fails to trigger, which is addressed in the next
> patch.
>
> Cc: Daniel Micay <danielmicay@gmail.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Fixes: 0c96350a2d2f ("lib/test_kasan.c: add tests for several string/memo=
ry API functions")
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  lib/test_kasan.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 328d33beae36..58a8cef0d7a2 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -23,6 +23,14 @@
>
>  #include <asm/page.h>
>
> +/*
> + * We assign some test results to these globals to make sure the tests
> + * are not eliminated as dead code.
> + */
> +
> +int int_result;
> +void *ptr_result;

These are globals, but are not static and don't have kasan_ prefix.
But I guess this does not matter for modules?
Otherwise:

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> +
>  /*
>   * Note: test functions are marked noinline so that their names appear i=
n
>   * reports.
> @@ -603,7 +611,7 @@ static noinline void __init kasan_memchr(void)
>         if (!ptr)
>                 return;
>
> -       memchr(ptr, '1', size + 1);
> +       ptr_result =3D memchr(ptr, '1', size + 1);
>         kfree(ptr);
>  }
>
> @@ -618,8 +626,7 @@ static noinline void __init kasan_memcmp(void)
>         if (!ptr)
>                 return;
>
> -       memset(arr, 0, sizeof(arr));
> -       memcmp(ptr, arr, size+1);
> +       int_result =3D memcmp(ptr, arr, size + 1);
>         kfree(ptr);
>  }
>
> @@ -642,22 +649,22 @@ static noinline void __init kasan_strings(void)
>          * will likely point to zeroed byte.
>          */
>         ptr +=3D 16;
> -       strchr(ptr, '1');
> +       ptr_result =3D strchr(ptr, '1');
>
>         pr_info("use-after-free in strrchr\n");
> -       strrchr(ptr, '1');
> +       ptr_result =3D strrchr(ptr, '1');
>
>         pr_info("use-after-free in strcmp\n");
> -       strcmp(ptr, "2");
> +       int_result =3D strcmp(ptr, "2");
>
>         pr_info("use-after-free in strncmp\n");
> -       strncmp(ptr, "2", 1);
> +       int_result =3D strncmp(ptr, "2", 1);
>
>         pr_info("use-after-free in strlen\n");
> -       strlen(ptr);
> +       int_result =3D strlen(ptr);
>
>         pr_info("use-after-free in strnlen\n");
> -       strnlen(ptr, 1);
> +       int_result =3D strnlen(ptr, 1);
>  }
>
>  static noinline void __init kasan_bitops(void)
> @@ -724,11 +731,12 @@ static noinline void __init kasan_bitops(void)
>         __test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
>
>         pr_info("out-of-bounds in test_bit\n");
> -       (void)test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> +       int_result =3D test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
>
>  #if defined(clear_bit_unlock_is_negative_byte)
>         pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
> -       clear_bit_unlock_is_negative_byte(BITS_PER_LONG + BITS_PER_BYTE, =
bits);
> +       int_result =3D clear_bit_unlock_is_negative_byte(BITS_PER_LONG +
> +               BITS_PER_BYTE, bits);
>  #endif
>         kfree(bits);
>  }
> --
> 2.20.1
>
