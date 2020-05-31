Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC68C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A692074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgEaJwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 05:52:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35016 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:52:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id 69so5602393otv.2;
        Sun, 31 May 2020 02:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roxC3CND33L6cDqM+nIMd1F3blCqTuLEFWuIiWLEPJA=;
        b=FFU3dWGranoMRQ4GVdAjyQoX71jy9ILSps3VZ3mAR5Aywdzb1b/AdOeSZzDkGs7VvP
         kkph53FFPY4H2Yk/VHKXDTbMb2FsaGs2Vq0AWieKRYtsklO6HzzU0GPfnvPg063IIZho
         5ib270ASkFeVG9HfmKNgnbRPivT8/1/1Rg9uW9vG/bXcIHMv+xr2PLbiz1P6ZLyPDAxm
         B2v0+RbhSFOPUtBiRnZg6jHsVKLhfq6oRkYi+l0ORSKzPaW2nKWg9Nyo1pN56lqL5Or5
         VDFyGQHyR4emC7CIDrbnink4m62JuymKnrXFWqxBDju3U29vphjteC+f0t+yE9BYBpne
         ikkA==
X-Gm-Message-State: AOAM532zA37bILX1oT5Ctt37/9E301YOEpLQlqGaZiLN9L62Ii2J6x+4
        HTjRdR71QcceLO89D0gtSoP4fMj+U0VOUtKvhBsCThqC
X-Google-Smtp-Source: ABdhPJyllXeiDq8UcWYFSUxiAXueuRI9zuy5Jupa5nCBUxu15Cm//71yMa8TfWqUtmqEc+Q5KBJQ8PpHisSafhDOv0s=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr12441708otp.145.1590918761529;
 Sun, 31 May 2020 02:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de> <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 31 May 2020 11:52:30 +0200
Message-ID: <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, May 29, 2020 at 7:46 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Trying to build the kernel with CONFIG_INFINIBAND_USER_ACCESS enabled fails
>
>      ERROR: "__get_user_unknown" [drivers/infiniband/core/ib_uverbs.ko] undefined!
>
> with on SH since the kernel misses a 64-bit implementation of get_user().
>
> Implement the missing 64-bit get_user() as __get_user_u64(), matching the
> already existing __put_user_u64() which implements the 64-bit put_user().
>
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for your patch!

> --- a/arch/sh/include/asm/uaccess_32.h
> +++ b/arch/sh/include/asm/uaccess_32.h
> @@ -26,6 +26,9 @@ do {                                                          \
>         case 4:                                                 \
>                 __get_user_asm(x, ptr, retval, "l");            \
>                 break;                                          \
> +       case 8:                                                 \
> +               __get_user_u64(x, ptr, retval);                 \
> +               break;                                          \
>         default:                                                \
>                 __get_user_unknown();                           \
>                 break;                                          \
> @@ -66,6 +69,52 @@ do {                                                 \
>
>  extern void __get_user_unknown(void);
>
> +#if defined(CONFIG_CPU_LITTLE_ENDIAN)
> +#define __get_user_u64(x, addr, err) \
> +({ \
> +__asm__ __volatile__( \
> +       "1:\n\t" \
> +       "mov.l  %2,%R1\n\t" \
> +       "mov.l  %T2,%S1\n\t" \
> +       "2:\n" \
> +       ".section       .fixup,\"ax\"\n" \
> +       "3:\n\t" \
> +       "mov    #0, %1\n\t" \

As this is the 64-bit variant, I think this single move should be
replaced by a double move:

       "mov  #0,%R1\n\t" \
       "mov  #0,%S1\n\t" \

Same for the big endian version below.

Disclaimer: uncompiled, untested, no SH assembler expert.

> +       "mov.l  4f, %0\n\t" \
> +       "jmp    @%0\n\t" \
> +       " mov   %3, %0\n\t" \
> +       ".balign        4\n" \
> +       "4:     .long   2b\n\t" \
> +       ".previous\n" \
> +       ".section       __ex_table,\"a\"\n\t" \
> +       ".long  1b, 3b\n\t" \
> +       ".previous" \
> +       :"=&r" (err), "=&r" (x) \
> +       :"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
