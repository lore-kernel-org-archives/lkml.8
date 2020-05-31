Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7363C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0D12074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEaKnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 06:43:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39825 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgEaKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 06:43:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id g5so5116219otg.6;
        Sun, 31 May 2020 03:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y93NE+xI4kJbaaC1vx3VOuPkEuZSNm6EYNKf/ZkVGqk=;
        b=MqJ0WMcL2gwZ+dgGsgb51EtLtpAMhYRObRuHwuMN+pL88++tOM1D/gtxOur8ZiK24+
         iLMlEsN2qjiPf+rTauUHDFCcZYOysfjfejMU4BZhIX7Jx6Z72PxlqJggmVCkggxunjfI
         2eRSW8tgOnL2aC0Tfi2Phe85CE78XL519q2ULbHMkRjwzSc39ooE+HtELbyRnURYXiJ9
         aRFKHPq2hNw8dEQ+Fs5KCHUBPhu1hayF3VZaXmEb6+HH5XlzOSanXjK5kQ0P3Yr1M4hE
         Ql6SEj713PhjUNKMLZmMxJZ1RBaTb7j9malUdtVzH9EzRfADpYLfyCRB7xTvAeeD5Fsv
         R7eA==
X-Gm-Message-State: AOAM532nnK+K69z4vgpImcaqSlWU0h5syKpRj0/Oyluv6GrVfFBsUjFn
        q2VRL9SI7Kz/VUK/ZmZIcGAVVQgt3aYDH/Vl838=
X-Google-Smtp-Source: ABdhPJzPu8C4SJ9gJn6jawcpaz69C4dMihm/zKG1JoOxAMFVNzRginWIAITEFrGZ+WIKFdyRMsX3H3ncySvKpTfukhk=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr994358otp.250.1590921802388;
 Sun, 31 May 2020 03:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
 <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de> <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
 <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de> <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
In-Reply-To: <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 31 May 2020 12:43:11 +0200
Message-ID: <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
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

On Sun, May 31, 2020 at 11:59 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/31/20 11:54 AM, John Paul Adrian Glaubitz wrote:
> > On 5/31/20 11:52 AM, Geert Uytterhoeven wrote:
> >> As this is the 64-bit variant, I think this single move should be
> >> replaced by a double move:
> >>
> >>        "mov  #0,%R1\n\t" \
> >>        "mov  #0,%S1\n\t" \
> >>
> >> Same for the big endian version below.
> >>
> >> Disclaimer: uncompiled, untested, no SH assembler expert.
> >
> > Right, this makes sense. I'll send a new patch shortly.
>
> Hmm, this change is not the case for __put_user_asm() vs. __put_user_u64().
> But I have to admit, I don't know what the part below "3:\n\t" is for.

It's part of the exception handling, in case the passed (userspace) pointer
points to an inaccessible address, and triggers an exception.

For an invalid store, nothing is done, besides returning -EFAULT.
Hence there's no "mov #0, %1\n\t" in the put_user case.
For an invalid load, the data is replaced by zero, and -EFAULT is returned.

> +__asm__ __volatile__( \
> +       "1:\n\t" \
> +       "mov.l  %2,%R1\n\t" \
> +       "mov.l  %T2,%S1\n\t" \
> +       "2:\n" \

(reordering the two sections for easier explanation)

> +       ".section       __ex_table,\"a\"\n\t" \
> +       ".long  1b, 3b\n\t" \

In case an exception happens for the instruction at 1b, jump to 3b.

Note that the m68k version has two entries here: one for each half of
the 64-bit access[*].
I don't know if that is really needed (and thus SH needs it, too), or if
the exception code handles subsequent instructions automatically.

> +       ".section       .fixup,\"ax\"\n" \
> +       "3:\n\t" \
> +       "mov    #0, %1\n\t" \

Return zero instead of the data at the (invalid) address.

> +       "mov.l  4f, %0\n\t" \
> +       "jmp    @%0\n\t" \

Resume at 2b.
Remember: branch delay slot, so the instruction below is executed first!

> +       " mov   %3, %0\n\t" \

Set err to -EFAULT.

> +       ".balign        4\n" \
> +       "4:     .long   2b\n\t" \
> +       ".previous\n" \

> +       ".previous" \
> +       :"=&r" (err), "=&r" (x) \
> +       :"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })

[*] arch/m68k/include/asm/uaccess_mm.h

                        "1:     "MOVES".l       (%2)+,%1\n"             \
                        "2:     "MOVES".l       (%2),%R1\n"             \

                        "       .section __ex_table,\"a\"\n"            \
                        "       .align  4\n"                            \
                        "       .long   1b,10b\n"                       \
                        "       .long   2b,10b\n"                       \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
