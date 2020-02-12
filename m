Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A1C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95220661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTmZWD45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgBLJXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:23:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33405 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgBLJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:23:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so748039plb.0;
        Wed, 12 Feb 2020 01:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDe1AgAtZMTBswle0D6FGWKTb7hbTE9PCf3WEVHRGts=;
        b=NTmZWD45lEPn6L7REaUGWdMZAGXUIsVeAXTcDm09kMdQPRZkDnK1ZnJiAxj8cH8tFz
         g2xSmoyEdJdU7x1X/DgPqY9ERd8rMB+Aftc4CKnB4nUfUSkB73us/ujbjCiEhZUT2HxJ
         zBhjq6QYgtWoT+Gip38EWBgPkVbrMcT6Tj3+YZ23iIZzdKSkDo9g5WCj3tnR0ISuGbhJ
         cUC7DpE3d8+6UxrBQXIe312wuKs5guDtoWhid3vJfpP2Gzh0N0CZyrCojASPbY9pRvq6
         2Zh5QNldMzhDsdJxitNi88nCyBmmWgX5WF5D5x/NX9Y5G++ggIYBAGfPkiIVguw8H03M
         2gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDe1AgAtZMTBswle0D6FGWKTb7hbTE9PCf3WEVHRGts=;
        b=K0ovO/TsbbLMlVy9iwMg52MGbTw3F3DmmHh7FKx1NVcgK/K3FIiP7kQ7EV3wafAUst
         Axo1/ucIFw5rsyRTij4TyKeanJOgphcmXBgEeY36jYrY61Zsj/yufmcMJCWHtJ21208R
         7mFNMoxtMlNihKLpbLFIMzoazQcrrlAb4sQnMjDulh0O+3LiIWJTqCasOd+UwLLqCNaR
         skaHJWg4I+XwBd0QOARHcobDUDyYzfwwDP/TF+BncGK8OqJV1M4WpXc7G3bNHQrqbM84
         lbpwcSXctToEBrNdlzWfr3Zs/rYtwPuKuVOBy2Sle3M4rZEqSLI15wU7NUHH94ryz04C
         K48g==
X-Gm-Message-State: APjAAAVjbjoorWyTJUGH7KE7VTujAb1CZ8bfc7mdmYWeOtRv0019kvak
        f515MItYlfj9gZXqJWoaTapoK4zLtVJLQQwZ5LA=
X-Google-Smtp-Source: APXvYqyZ4tXa/Bz1TU2WB8Qw8s2ub4TYrIldIrHS/DRv6Hw7VztBunHuynb35UMhAgrhnK6n/IvcD4LLg/cdxO9Jwbc=
X-Received: by 2002:a17:902:a588:: with SMTP id az8mr7671909plb.123.1581499429334;
 Wed, 12 Feb 2020 01:23:49 -0800 (PST)
MIME-Version: 1.0
References: <dcdd615f77dacf8a98e18950b66fb5a675277f38.1581498987.git.michal.simek@xilinx.com>
In-Reply-To: <dcdd615f77dacf8a98e18950b66fb5a675277f38.1581498987.git.michal.simek@xilinx.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 12 Feb 2020 01:23:38 -0800
Message-ID: <CAMo8BfLYM-_SbqmMUCVjwqL7MpA2W7toTg_F6HTY4Sg5QxGzfw@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: Fix unistd_32.h generation format
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matt Turner <mattst88@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 1:16 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Generated files are also checked by sparse that's why add newline
> to remove sparse (C=1) warning.
>
> The issue was found on Microblaze and reported like this:
> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
> warning: no newline at end of file
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> ---
>
> Changes in v2:
> - Update also others archs not just microblaze - Arnd
> - Align subject and description to match multiarch chagne
>
>  arch/alpha/kernel/syscalls/syscallhdr.sh      | 1 +
>  arch/ia64/kernel/syscalls/syscallhdr.sh       | 1 +
>  arch/m68k/kernel/syscalls/syscallhdr.sh       | 1 +
>  arch/microblaze/kernel/syscalls/syscallhdr.sh | 1 +
>  arch/parisc/kernel/syscalls/syscallhdr.sh     | 1 +
>  arch/sh/kernel/syscalls/syscallhdr.sh         | 1 +
>  arch/sparc/kernel/syscalls/syscallhdr.sh      | 1 +
>  arch/xtensa/kernel/syscalls/syscallhdr.sh     | 1 +
>  8 files changed, 8 insertions(+)

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

...

> diff --git a/arch/m68k/kernel/syscalls/syscallhdr.sh b/arch/m68k/kernel/syscalls/syscallhdr.sh
> index 6f357d68ef44..8ac15be01ac2 100644
> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>         printf "#endif\n"
>         printf "\n"
>         printf "#endif /* %s */\n" "${fileguard}"

Here there's already \n at the end, so no need for another one?

> +       printf "\n"
>  ) > "$out"

...

-- 
Thanks.
-- Max
