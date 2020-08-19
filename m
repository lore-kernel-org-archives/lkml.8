Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A662072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgHSJKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:10:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37021 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgHSJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:09:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id e6so20419563oii.4;
        Wed, 19 Aug 2020 02:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVTm4vOQa6whaO6/eSa1Eurslvl1A1eOKwJkxD7vXBA=;
        b=bbOe2pfhAYKaIEx1TZ5StoSvQNy1SJL9xlBYmHXMYE1n8+VbdVy0CaEepnhY9CthV4
         bc/3rEMYRT0IYtKhaFG/nUcpqX2DGPbYGiTdHVWtcIYzjzbMSKrPHDOvC1xPv5+RR3FD
         0H3jxyYh9IXOgRkil3+8VZAHlBy2/i5hS0dH2w909ukU270oj/ufuM+a5MEymgBXhL+J
         m/hWTgy671BpRi/g9fzyrYefmWrM8PV1ns9dpKA9UKT6gjXMSVQaVvxDKx67LaRz7g+t
         jYugkALnwDkhHgQ6Ld/YkUc0Y5204x4iGrVTco0JK0aO2h5HUBVsUOco8duKubgvcPU9
         vjHA==
X-Gm-Message-State: AOAM533kgYZZOD9XPeRK79uaw/xd7miqSJlMC+7QzJzIQfGjB1IRDNZW
        5aBTdQXGv/eacKOznRRpvtpuxgHbnT9hPNiiALU=
X-Google-Smtp-Source: ABdhPJxyGbLLdSKygv338P0ucHbVhbsigkU92H4n7j5pDNgFNKYLZ3l1ljDOI6l+kVwT0Pzok6VbA6cs0AK3L0NN3LI=
X-Received: by 2002:aca:4b54:: with SMTP id y81mr2633865oia.54.1597828198046;
 Wed, 19 Aug 2020 02:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200819030511.1114-1-liambeguin@gmail.com>
In-Reply-To: <20200819030511.1114-1-liambeguin@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Aug 2020 11:09:46 +0200
Message-ID: <CAMuHMdVYeAqLHuW2fjQk7HQbnGJhY7YJcksMddn_6Cp61cd-AQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sh: add support for cmpxchg on u8 and u16 pointers
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Wed, Aug 19, 2020 at 5:07 AM Liam Beguin <liambeguin@gmail.com> wrote:
> The kernel test bot reported[1] that using set_mask_bits on a u8 causes
> the following issue on SuperH:
>
>     >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/phy/ti/phy-tusb1210.ko] undefined!
>
> Add support for cmpxchg on u8 and u16 pointers.
>
> [1] https://lore.kernel.org/patchwork/patch/1288894/#1485536
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
>
> Hi,
>
> This was reported by the kernel test bot on an architecture I can't
> really test on. I was only able to make sure the build succeeds, but
> nothing more.
> This patch is based on the __cmpxchg_u32 impletmentation and seems
> incomplete based on the different cmpxchg headers I can find.

Indeed. This version is suitable for non-SMP machines only.
BTW, it looks like this version can be replaced by the one in asm-generic?

>
> Do these function need to be impletmented in each header
> simulataneously?

Yes, we need them for all variants.

>  arch/sh/include/asm/cmpxchg-irq.h | 27 +++++++++++++++++++++++++++
>  arch/sh/include/asm/cmpxchg.h     |  5 +++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sh/include/asm/cmpxchg-irq.h b/arch/sh/include/asm/cmpxchg-irq.h
> index 07d3e7f08389..918c4153a930 100644
> --- a/arch/sh/include/asm/cmpxchg-irq.h
> +++ b/arch/sh/include/asm/cmpxchg-irq.h
> @@ -51,4 +51,31 @@ static inline unsigned long __cmpxchg_u32(volatile int *m, unsigned long old,
>         return retval;
>  }
>
> +static inline unsigned long __cmpxchg_u16(volatile u16 *m, unsigned long old,
> +       unsigned long new)
> +{
> +       u16 retval;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       retval = *m;
> +       if (retval == old)
> +               *m = new;
> +       local_irq_restore(flags);
> +       return (unsigned long)retval;
> +}
> +
> +static inline unsigned long __cmpxchg_u8(volatile u8 *m, unsigned long old,
> +       unsigned long new)
> +{
> +       u8 retval;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       retval = *m;
> +       if (retval == old)
> +               *m = new;
> +       local_irq_restore(flags);
> +       return (unsigned long)retval;
> +}
>  #endif /* __ASM_SH_CMPXCHG_IRQ_H */
> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> index e9501d85c278..7d65d0fd1665 100644
> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -56,8 +56,9 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
>                 unsigned long new, int size)
>  {
>         switch (size) {
> -       case 4:
> -               return __cmpxchg_u32(ptr, old, new);
> +       case 4: return __cmpxchg_u32((int *)ptr, old, new);
> +       case 2: return __cmpxchg_u16((u16 *)ptr, old, new);
> +       case 1: return __cmpxchg_u8((u8 *)ptr, old, new);
>         }
>         __cmpxchg_called_with_bad_pointer();
>         return old;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
