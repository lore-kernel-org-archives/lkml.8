Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE21C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0681120661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgBLJXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:23:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33748 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgBLJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:23:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so1256835otp.0;
        Wed, 12 Feb 2020 01:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUJglwWT4yeZe9Lh+O1oa+CnC/XnwAm/Q6YITICL3Zc=;
        b=SOHEwdzfaaBBc0PoHoPgoluP35AeVpHiG5cEZjNJqXxrmFgZ1wRVb5QuB82/3ThgPx
         K0O2AB/BLVmf+r6CDJwUFieNXqlg+4DPowAiwhcXi4n9Yoh+4DOnQdxGZ3sN8TyvTyPi
         3u7Nvvl30DDhkuG6qzOcsPLUDcVvFg70DzcZd78OuG1+j5pj6tb/pM/FT0Jk5DsZtCJ1
         Rwhru4WWqi/by+ebt4x8fzIrrwZTWfP+dGdNC/UI0THwv3it6pAbhSE/5ePNMVgV8m+v
         q+AnW6xkG/1OIxK/KIH+otSduxNJENZTZHrrQFeWRCRbka1Q9iyE5/ahoDyJA0EQJY61
         8DEw==
X-Gm-Message-State: APjAAAXZYUqAEYbGSwUH7b66/c7+gzuX/9fbHpLsedYhpe6Z6M29/4cq
        UAoOY55QGXsZdXxX9kI8J9vMkvbGAc+gq/NlFlk=
X-Google-Smtp-Source: APXvYqyPBZkgQpSHkxDVA/do02CfDtbtpOB3D8fNkrYLGdPLp7891ZvOrFBlVUt7fT1cYp8iaS4lCTLIPhBSOgKicEY=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr8474526oth.145.1581499409612;
 Wed, 12 Feb 2020 01:23:29 -0800 (PST)
MIME-Version: 1.0
References: <dcdd615f77dacf8a98e18950b66fb5a675277f38.1581498987.git.michal.simek@xilinx.com>
In-Reply-To: <dcdd615f77dacf8a98e18950b66fb5a675277f38.1581498987.git.michal.simek@xilinx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Feb 2020 10:23:07 +0100
Message-ID: <CAMuHMdXt1CUqRjOyz9i0uVzQUJJU3UsFGzDaoTBcWVF=qTH48g@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: Fix unistd_32.h generation format
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Feb 12, 2020 at 10:16 AM Michal Simek <michal.simek@xilinx.com> wrote:
> Generated files are also checked by sparse that's why add newline
> to remove sparse (C=1) warning.
>
> The issue was found on Microblaze and reported like this:
> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
> warning: no newline at end of file
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>

Thanks for your patch!

>  arch/alpha/kernel/syscalls/syscallhdr.sh      | 1 +
>  arch/ia64/kernel/syscalls/syscallhdr.sh       | 1 +
>  arch/m68k/kernel/syscalls/syscallhdr.sh       | 1 +

Bummer, I had noticed that before
https://lore.kernel.org/lkml/CAMuHMdVsBwL9vcqejfc47GN793wMXdQ=SwEsSUP1fbpMt-OoWw@mail.gmail.com/
and even claimed I fixed it while applying
https://lore.kernel.org/lkml/CAMuHMdW6JiponxLiGNEXUX4xJk3hK4b8dTOCNvVBr7s2LyfhJw@mail.gmail.com/
but something must have gone wrong...

>  arch/microblaze/kernel/syscalls/syscallhdr.sh | 1 +
>  arch/parisc/kernel/syscalls/syscallhdr.sh     | 1 +
>  arch/sh/kernel/syscalls/syscallhdr.sh         | 1 +
>  arch/sparc/kernel/syscalls/syscallhdr.sh      | 1 +
>  arch/xtensa/kernel/syscalls/syscallhdr.sh     | 1 +
>  8 files changed, 8 insertions(+)
>
> diff --git a/arch/alpha/kernel/syscalls/syscallhdr.sh b/arch/alpha/kernel/syscalls/syscallhdr.sh
> index e5b99bd2e5e7..524c69fbcab7 100644
> --- a/arch/alpha/kernel/syscalls/syscallhdr.sh
> +++ b/arch/alpha/kernel/syscalls/syscallhdr.sh
> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>         printf "#endif\n"
>         printf "\n"
>         printf "#endif /* %s */" "${fileguard}"
> +       printf "\n"

Why not add the "\n" to the end of the previous line?

Anyway,
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
