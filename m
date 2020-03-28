Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66633C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE4920714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHFWWE4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgC1TF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 15:05:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45119 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgC1TF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 15:05:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id b9so4884777pls.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTAzCGUSvJV4ncy7HJGaGxbbxkFN5aj53LA11biejuc=;
        b=jHFWWE4FsMXTAti3zTrm9AsSkQYoGbPusIRxbAQ5zaMNQl5MgxO2+z14t8+Pcfhq1J
         HXYwYsN/spsOQYG+lDxU4X2qxPQUJYSvOmaqIBXrQimUGJjlorci/nOs6DHmLGiao+LW
         NBe3XaQndatNldhNUgxJeWu7nODnepv2kqdcYV/w2GiULlol/lEt8ymq0IlplWB8U+r8
         taKKW53wRNa/3RdJKUM0GEHaTdMBO6eA7EB5AV+sSSEdj4EJkiLMgXyewRS2HuJX7vh5
         M/WLTQSuEg6m+1Pj85t6uMwnIFy6tgHBttAoeUXbI/Htly9weUa5WN66O/KtO4OUylf3
         C0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTAzCGUSvJV4ncy7HJGaGxbbxkFN5aj53LA11biejuc=;
        b=DYSVWkPN0xnmwqSxtucJt2PSGv8I6jCI1qJWdCP7WIvNr4mLdWrw63spC5f7npcQ+q
         xD8pO82aniq4xG/OOyBZAn1LillTypRY/mNhPd6Qb8lJC3dvRM63DMTp392Uc2iDNqFR
         qKy0Ji2wxiKTV5++bOL9rsgQl72PQg4cni6IyhdIw8vAtTTAWJ2h2IMV/w++2WzavFvA
         m6rV8PNRgrRMMbYNUc/Tm/3DByKa68SAYXvjrFHDN+urykYwLyBLGrTXgIxtciuC+ozX
         f6oCFc/23OKwY9GsJmWAJf/ctbhDhiga7W88eGUwhn94kh8pJfvkf5dVeVWNLpsriRTt
         MutA==
X-Gm-Message-State: ANhLgQ1csZjisViJaIL29H6roDYVL29Ct4QpddLD0obj2xuWVaqSgaV6
        DQk5xorY81I3qLBovdugza9asRt3n2EsILnO1o8=
X-Google-Smtp-Source: ADFU+vsYgRDoa0Pgfpj2+O1rHrb7IVmlU2IVNWERmhlk+FmFmmJRzNmGNCAXNVdIJgFh7ady64c1DbwC7dDgLVPrfw4=
X-Received: by 2002:a17:902:b28c:: with SMTP id u12mr4100082plr.262.1585422327086;
 Sat, 28 Mar 2020 12:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <202003281643.02SGhJI8005124@sdf.org>
In-Reply-To: <202003281643.02SGhJI8005124@sdf.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 21:05:15 +0200
Message-ID: <CAHp75VdM9gCC6YUDW0j82kvDMcdadRkYvo1UOMCcanYpXOK8ug@mail.gmail.com>
Subject: Re: [RFC PATCH v1 32/50] lib/test*.c: Use prandom_u32_max()
To:     George Spelvin <lkml@sdf.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 6:47 PM George Spelvin <lkml@sdf.org> wrote:
>
> lib/reed_solomon/test_rslib.c alreasy uses prandom_u32();
> lib/test_hexdump.c and lib/test-string_helpers.c were using
> get_random_int() % range, which is needlessly expensive for
> test code.
>

Fine with me, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  lib/reed_solomon/test_rslib.c |  4 ++--
>  lib/test-string_helpers.c     |  2 +-
>  lib/test_hexdump.c            | 10 +++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
> index 4eb29f365ece0..58e767c142ef8 100644
> --- a/lib/reed_solomon/test_rslib.c
> +++ b/lib/reed_solomon/test_rslib.c
> @@ -183,7 +183,7 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
>
>                 do {
>                         /* Must not choose the same location twice */
> -                       errloc = prandom_u32() % len;
> +                       errloc = prandom_u32_max(len);
>                 } while (errlocs[errloc] != 0);
>
>                 errlocs[errloc] = 1;
> @@ -194,7 +194,7 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
>         for (i = 0; i < eras; i++) {
>                 do {
>                         /* Must not choose the same location twice */
> -                       errloc = prandom_u32() % len;
> +                       errloc = prandom_u32_max(len);
>                 } while (errlocs[errloc] != 0);
>
>                 derrlocs[i] = errloc;
> diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
> index 25b5cbfb7615b..3349f3ddc528c 100644
> --- a/lib/test-string_helpers.c
> +++ b/lib/test-string_helpers.c
> @@ -398,7 +398,7 @@ static int __init test_string_helpers_init(void)
>         for (i = 0; i < UNESCAPE_ANY + 1; i++)
>                 test_string_unescape("unescape", i, false);
>         test_string_unescape("unescape inplace",
> -                            get_random_int() % (UNESCAPE_ANY + 1), true);
> +                            prandom_u32_max(UNESCAPE_ANY + 1), true);
>
>         /* Without dictionary */
>         for (i = 0; i < (ESCAPE_ANY_NP | ESCAPE_HEX) + 1; i++)
> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
> index 5144899d3c6b8..54e4efb28b974 100644
> --- a/lib/test_hexdump.c
> +++ b/lib/test_hexdump.c
> @@ -149,7 +149,7 @@ static void __init test_hexdump(size_t len, int rowsize, int groupsize,
>  static void __init test_hexdump_set(int rowsize, bool ascii)
>  {
>         size_t d = min_t(size_t, sizeof(data_b), rowsize);
> -       size_t len = get_random_int() % d + 1;
> +       size_t len = prandom_u32_max(d) + 1;
>
>         test_hexdump(len, rowsize, 4, ascii);
>         test_hexdump(len, rowsize, 2, ascii);
> @@ -208,11 +208,11 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
>  static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
>  {
>         unsigned int i = 0;
> -       int rs = (get_random_int() % 2 + 1) * 16;
> +       int rs = (prandom_u32() % 2 + 1) * 16;
>
>         do {
>                 int gs = 1 << i;
> -               size_t len = get_random_int() % rs + gs;
> +               size_t len = prandom_u32_max(rs) + gs;
>
>                 test_hexdump_overflow(buflen, rounddown(len, gs), rs, gs, ascii);
>         } while (i++ < 3);
> @@ -223,11 +223,11 @@ static int __init test_hexdump_init(void)
>         unsigned int i;
>         int rowsize;
>
> -       rowsize = (get_random_int() % 2 + 1) * 16;
> +       rowsize = (prandom_u32() % 2 + 1) * 16;
>         for (i = 0; i < 16; i++)
>                 test_hexdump_set(rowsize, false);
>
> -       rowsize = (get_random_int() % 2 + 1) * 16;
> +       rowsize = (prandom_u32() % 2 + 1) * 16;
>         for (i = 0; i < 16; i++)
>                 test_hexdump_set(rowsize, true);
>
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
