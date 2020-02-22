Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5965DC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD7B2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejYQOQqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBVJkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 04:40:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43131 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgBVJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 04:40:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so2267791pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 01:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8Ztf084J9USzPL1dEx2mVWqtPlL0g/EL9tbykVLcaQ=;
        b=ejYQOQquNfggHBgxOs7aHRcX8sS9QEJQXzYQ20J5LlQsRCrPa+OptZ+uuuA/rsnBO3
         qJE92SIDesrERlAAjcYskfV8Q5p5ijrX96EYpyl856dj4YBsvbfyHBhVIo8Apm5N91nO
         Vu7qja2iNLj0Bfp9AhizylRoes/RqMtkEmfJks7bWnnMYYhLC2hZnSUf3L5Xpz9+Q8CQ
         RJQq8SuujPKI/rlX6JpDKHih3bntihnXl+BiwrG9uBbyhVOUu+x6cEmekCCwIIuaHUGf
         I3UcSN8mwE5pMOIaL9XI+JIygF3AyoQsbqZpcn7pARiNgxc4RIaIYdrK98g0Ot9JrjnD
         /D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8Ztf084J9USzPL1dEx2mVWqtPlL0g/EL9tbykVLcaQ=;
        b=DZ2eTt0JDhm+AP4JIJYAS77xSSajaKrZBMAO5pzTs1Ir3TDYuik3UTQKwB6Lvfju5e
         qT9A7R2BdVPvGllf498qI6QLD+1toj2LLFDdaVEqvusnH7loq0nD9xujr7yFDKDHCW+G
         iRhNuQw4Xl84N240AAt4WUBk0rE9RwbgozRgll45qq8InTewGh/tn+VKZVZ43Y0U3Rb9
         7fxZ0UaPR4Ish0KQQuT2O+o95hDGOHKS/fbcn/ZxOU6GGrqjF8mwV/5wf+lz9D8Tu31F
         WCe2rSltvCdTtvQotDrKzwqgKJJOZHF6ud7mGEAvQP9cms43KiEb5Jc54IF9h42upECY
         /Y3w==
X-Gm-Message-State: APjAAAWDN/BI/YFhBgOIg2y1fs2hBq03YipaYkRHj5ILouDqv52qYBg0
        wYWSPJHHLgICRhBWhms/evtuiBEr6BcROBGgtuu6aMwgl5M=
X-Google-Smtp-Source: APXvYqwWtr4FR/LS1ortbPsVne0DJQ7ymzUA9LObVo0rnFTPSgJXgyRl07oTCUoH3DgtG530Km9MEza76/Wc7Byps18=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr41966037pfa.64.1582364409550;
 Sat, 22 Feb 2020 01:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20200222000214.2169531-1-jesse.brandeburg@intel.com>
In-Reply-To: <20200222000214.2169531-1-jesse.brandeburg@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 Feb 2020 11:39:57 +0200
Message-ID: <CAHp75Vc=9aSt1DH-LzDHnX1+fnPpkJWHkkh0-ApTL0zm+ZA2oQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86: fix bitops.h warning with a moved cast
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 2:04 AM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> Fix many sparse warnings when building with C=1.
>
> When the kernel is compiled with C=1, there are lots of messages like:
>   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
>
> CONST_MASK() is using a signed integer "1" to create the mask which
> is later cast to (u8) when used. Move the cast to the definition and
> clean up the calling sites to prevent sparse from warning.
>
> The reason the warning was occurring is because certain bitmasks that
> end with a mask next to a natural boundary like 7, 15, 23, 31, end up
> with a mask like 0x7f, which then results in sign extension when doing
> an invert (but I'm not a compiler expert). It was really only
> "clear_bit" that was having problems, and it was only on bit checks next
> to a byte boundary (top bit).
>
> Verified with a test module (see next patch) and assembly inspection
> that the patch doesn't introduce any change in generated code.
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> v4: reverse argument order as suggested by David Laight, added reviewed-by
> v3: Clean up the header file changes as per peterz.
> v2: use correct CC: list
> ---
>  arch/x86/include/asm/bitops.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 062cdecb2f24..fed152434ed0 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -46,7 +46,7 @@
>   * a mask operation on a byte.
>   */
>  #define CONST_MASK_ADDR(nr, addr)      WBYTE_ADDR((void *)(addr) + ((nr)>>3))
> -#define CONST_MASK(nr)                 (1 << ((nr) & 7))
> +#define CONST_MASK(nr)                 ((u8)1 << ((nr) & 7))
>
>  static __always_inline void
>  arch_set_bit(long nr, volatile unsigned long *addr)
> @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
>         if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "orb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
> -                       : "iq" ((u8)CONST_MASK(nr))
> +                       : "iq" (CONST_MASK(nr))
>                         : "memory");
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
>         if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "andb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
> -                       : "iq" ((u8)~CONST_MASK(nr)));
> +                       : "iq" (CONST_MASK(nr) ^ 0xff));

I'm wondering if the original, by Peter Z, order allows us to drop
(u8) casting in the CONST_MASK completely.

>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
>
> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> --
> 2.24.1
>


-- 
With Best Regards,
Andy Shevchenko
