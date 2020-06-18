Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0923C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989A3207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksbBZY96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgFRPN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFRPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:13:57 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17B8C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:13:56 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id q188so1241517ooq.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO4GINLTqRPNQqITpuXVhFaUv7xlTQUTH2mrBTAzQv8=;
        b=ksbBZY96J7SnvGtlTve3J3SqjR6CAXehOpIYzIb0OdARGchl6NKK4Xn+TdQ3i8Y/K5
         xeMev+1/0WxRTSMPrqYppwHlLwHOpH+401TlWjVS5iyDj6WPNXYBcn0X1ONfNJshJ9gE
         zQDMTlcEH/ByaIadS2y3fycvjMUczwll0Bw3NMMSkZ1wtk2UoxRYDBddROZ2hB+LOHf+
         sjM/IcRhtoAd7dvpeRd0pFCFD34N5W48Ln3/2fTXwJl2HR5PNGaAxPsXQoCh0MmMDZX3
         IeGmfqzrJW8uJ2FCJv0h3VQ2l50CItP9NsLuBExTaMHve67TjoLhRcBokk3rNwYOcymw
         XxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO4GINLTqRPNQqITpuXVhFaUv7xlTQUTH2mrBTAzQv8=;
        b=mId9QxrnuxT/DSKiNONhLe+i3DgRJXR44ch21eiaAB+xNKPaHA6Z6tQbbjKkGG98Mo
         EiQrYlmqP+JrvRhE07mJGDU5UZ6n+l/tqC4xMg7xyiicvFgieOFSXhWJ9w+Z3GmcdZPH
         ccqR2G7TWk8z8xK/ZeE2YRrnAQiOh2BJG7mWBhGUYo6hHut0764nJrcgs3FwVwjNfQXH
         /P1ndz4noXfUlnrqasnqTTVJ2cpB9kVgZz5ZPPIBIqsjoUazWL8ofExfkGYW1JgGK6ij
         l6I3/4WlsnWmZDAJ+92EdmvA3P3BkQhvv32VwOcDM4Hgi2MvWnP0Brruor5cZ9k6sFoK
         1K4A==
X-Gm-Message-State: AOAM533S52HCgTBkX5vDvOlFQP+sK54RoxXK0PYIj2D3FE4pgu4btzbj
        lXj8ul/tIDo8oSTiL8iBsNt9MUcV0l5vFry25Qput+j8WTqyfA==
X-Google-Smtp-Source: ABdhPJzAGueKTJlAqRIBsUfbNxJ5G7F8FRnatiN+3y77dD4LLMFwCK9iKdDECNEX+Od8rxG2uNum7XzYeXZVuLEQH6Y=
X-Received: by 2002:a05:6820:50a:: with SMTP id m10mr4543140ooj.54.1592493236068;
 Thu, 18 Jun 2020 08:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200618144407.520952071@infradead.org> <20200618144801.760070502@infradead.org>
In-Reply-To: <20200618144801.760070502@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 18 Jun 2020 17:13:45 +0200
Message-ID: <CANpmjNMdrM7T-To0nqv5NGBWztD-Oq6uBy0Vbi9ejg0h3raWoQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] x86/entry: Fixup bad_iret vs noinstr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>, mhelsley@vmware.com,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 at 16:50, Peter Zijlstra <peterz@infradead.org> wrote:
>
> vmlinux.o: warning: objtool: fixup_bad_iret()+0x8e: call to memcpy() leaves .noinstr.text section
>
> Worse, when KASAN there is no telling what memcpy() actually is. Force
> the use of __memcpy() which is our assmebly implementation.
>
> Reported-by: Marco Elver <elver@google.com>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

KASAN no longer crashes, although the stack size increase appears to
be sufficient for the particular case I ran into.

Tested-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  arch/x86/kernel/traps.c  |    6 +++---
>  arch/x86/lib/memcpy_64.S |    4 ++++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -685,13 +685,13 @@ struct bad_iret_stack *fixup_bad_iret(st
>                 (struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
>
>         /* Copy the IRET target to the temporary storage. */
> -       memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
> +       __memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
>
>         /* Copy the remainder of the stack from the current stack. */
> -       memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
> +       __memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
>
>         /* Update the entry stack */
> -       memcpy(new_stack, &tmp, sizeof(tmp));
> +       __memcpy(new_stack, &tmp, sizeof(tmp));
>
>         BUG_ON(!user_mode(&new_stack->regs));
>         return new_stack;
> --- a/arch/x86/lib/memcpy_64.S
> +++ b/arch/x86/lib/memcpy_64.S
> @@ -8,6 +8,8 @@
>  #include <asm/alternative-asm.h>
>  #include <asm/export.h>
>
> +.pushsection .noinstr.text, "ax"
> +
>  /*
>   * We build a jump to memcpy_orig by default which gets NOPped out on
>   * the majority of x86 CPUs which set REP_GOOD. In addition, CPUs which
> @@ -184,6 +186,8 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
>         retq
>  SYM_FUNC_END(memcpy_orig)
>
> +.popsection
> +
>  #ifndef CONFIG_UML
>
>  MCSAFE_TEST_CTL
>
>
