Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A3AC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27D7206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZdQn+Tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAPFXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 00:23:15 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37164 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPFXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:23:15 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so17927111qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 21:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYiCDbJIjI5Gc+HCG21eDD5I0VhMo0bA/4w6OlV0KM0=;
        b=OZdQn+TvUSWi/oF2OJXBWYergJZIBJToM3HOQU6970b09/FLyJPx63uozadrIKOSke
         7WQfW38XDvSv/ei69rGnz+BMbLc7RsmzG0R8DjIwDh4d8sh5LI7J6rx1v4pGEGP+2OmU
         rvIlS1hXGHMkWvy8Yj7bvaLiK7paHjRYm6hpU+Qt88QjCp5nW1QwQrubI+c45EJJQhWW
         1Hrz76UGwF/MsCKxVvXnfs8jDzA/gDWziOlQgDkAEjg6Or1cqYyvyCqlWDm7R7s+j4pY
         JuOChq4Z1ceGy/gf72gVjXTzq0EUo63uR5Evy5iVYkBBiyiC9x/ooDoPPQQlWf0NHfkY
         hJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYiCDbJIjI5Gc+HCG21eDD5I0VhMo0bA/4w6OlV0KM0=;
        b=OE3om7IW5DCWIkMIJAde3oKtHf/t/a58n4suxRr+8+8LfT6fiswtd2WYjdi3NcFDsS
         LvVN4levZeLMv0J/54DWciXDrtjsvUGFZNopaOrdsiw8h6hEc9oST+jC4GS4EJOBM3On
         CYi/p59gC/IcEMCWXgOY56vBuFfj4qwu3ohGjeARXF276o/SsZuJavljLuAEkK7FKuT6
         FjQpaGe9uF98T5jjdpxqf1I4T2+kwWo/ENimuRH5094mSLozRSRMc5nhHECN35ASysK8
         uz8vZShGINOCDSAlwkGoCuDGTmzpx2jfYn6wPe/1JNBg+tA425Ze992IuwOWIyrb3aNM
         vr1Q==
X-Gm-Message-State: APjAAAURREzG0KMh0rFwc1cRX85oB3J7IZAPeEJjxbp9Rro6jrbypzI8
        EsAY7rqr0/BXlPEizbV65cTloPQ5ZqKYRtX+amZF3Q==
X-Google-Smtp-Source: APXvYqyc2uMQyHBLqa2xRW14JXfYwcgrlEF0pcUP7UrNbOp8FUjMFUfn4BIGXFvt+xh+6usK+SZ0+OlCkP1VAjWRSOI=
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr784628qtp.50.1579152193440;
 Wed, 15 Jan 2020 21:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20200116012321.26254-1-keescook@chromium.org> <20200116012321.26254-6-keescook@chromium.org>
In-Reply-To: <20200116012321.26254-6-keescook@chromium.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 06:23:01 +0100
Message-ID: <CACT4Y+batRaj_PaDnfzLjpLDOCChhpiayKeab-rNLx5LAj1sSQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] kasan: Unset panic_on_warn before calling panic()
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 2:24 AM Kees Cook <keescook@chromium.org> wrote:
>
> As done in the full WARN() handler, panic_on_warn needs to be cleared
> before calling panic() to avoid recursive panics.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/kasan/report.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 621782100eaa..844554e78893 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -92,8 +92,16 @@ static void end_report(unsigned long *flags)
>         pr_err("==================================================================\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>         spin_unlock_irqrestore(&report_lock, *flags);
> -       if (panic_on_warn)
> +       if (panic_on_warn) {
> +               /*
> +                * This thread may hit another WARN() in the panic path.
> +                * Resetting this prevents additional WARN() from panicking the
> +                * system on this thread.  Other threads are blocked by the
> +                * panic_mutex in panic().

I don't understand part about other threads.
Other threads are not necessary inside of panic(). And in fact since
we reset panic_on_warn, they will not get there even if they should.
If I am reading this correctly, once one thread prints a warning and
is going to panic, other threads may now print infinite amounts of
warning and proceed past them freely. Why is this the behavior we
want?

> +                */
> +               panic_on_warn = 0;
>                 panic("panic_on_warn set ...\n");
> +       }
>         kasan_enable_current();
>  }
