Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C63206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHZIz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:55:29 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38472 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgHZIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:55:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id j18so884829oig.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZeUK8THxl3gGFBaWshaAnlIvnsQJXffWHqOKGUSxHI=;
        b=NTl+kqcoTaKknilWqDUAdDjsgHZvdlFkb2r8nUNx15Y3bYCLkhUqUF7vrJ8KSRugVA
         Ns8JpQFWm+rWQOIhfx/ZZ1RLIaQ1y7F/BxqzVULHQIIvpsmxgD51C3vkKuF5TcDKbZ6z
         nEX4n64Dd+JhpZHiQLKNEq0JwvrFZKvZnOhTnnGC5YBUOBbqemJCCn7dLxzF/Rmim1ia
         ddarLQGeIXV22AnJYRZQmX1LworTNlRxtYgCnd0YAPdYVOEGyB7+Aqb1TybgCwPzi2hB
         lfmz28MTaPPAJPy7AfLLhIm32l5llpiIn/bF+kYNJfMLilV9o2s32vvowForaZcW6WCN
         6n+w==
X-Gm-Message-State: AOAM532iY2ilQPQuv3NhAvqAQLRFZEnCcMQCiDr5SEnqW8u9mfEjDmw2
        smJ+lkRemvrNxVR0HVOyd3EjbSrl1OuryiQoHiXp4cAs
X-Google-Smtp-Source: ABdhPJwrNm2flNDJyw4eAZDbk6R3tk8xpETILVv/y1XJ6PQKJxNXuttGBthgrUPeYDfaEMI314g0ojPmuoIcn6dFdUY=
X-Received: by 2002:aca:3402:: with SMTP id b2mr790853oia.153.1598432125496;
 Wed, 26 Aug 2020 01:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <f54e99e9bd1e25ad70a6a1d7a7ec9ab2b4e50d68.1595460351.git.fthain@telegraphics.com.au>
In-Reply-To: <f54e99e9bd1e25ad70a6a1d7a7ec9ab2b4e50d68.1595460351.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Aug 2020 10:55:13 +0200
Message-ID: <CAMuHMdW7eWtkUURxvAwAz6cAHABLBk4qs4bLUXR3wuowQbn5Fw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Correct some typos in comments
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Thu, Jul 23, 2020 at 1:50 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

> --- a/arch/m68k/kernel/head.S
> +++ b/arch/m68k/kernel/head.S

> @@ -1547,7 +1547,7 @@ func_return       get_bi_record
>   *     seven bits of the logical address (LA) are used as an
>   *     index into the "root table."  Each entry in the root
>   *     table has a bit which specifies if it's a valid pointer to a
> - *     pointer table.  Each entry defines a 32KMeg range of memory.
> + *     pointer table.  Each entry defines a 32Meg range of memory.
>   *     If an entry is invalid then that logical range of 32M is

Ah, lots of opportunities to switch to SI prefixes (MiB) ;-)

>   *     invalid and references to that range of memory (when the MMU
>   *     is enabled) will fault.  If the entry is valid, then it does

> @@ -2654,7 +2654,7 @@ func_start        mmu_get_page_table_entry,%d0/%a1
>         jne     2f
>
>         /* If the page table entry doesn't exist, we allocate a complete new
> -        * page and use it as one continues big page table which can cover
> +        * page and use it as one continuous big page table which can cover

Usually I use "contiguous", but the dictionary seems to permit both.

>          * 4MB of memory, nearly almost all mappings have that alignment.
>          */
>         get_new_page

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.10 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
