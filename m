Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE0FC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AEF212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLwNFfEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGNJeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgGNJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:34:23 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE57C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:34:23 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so16546142iom.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lRrq57w397KEjj99F1eu0ePTuse9TMJvNbmNZttcxV4=;
        b=rLwNFfEAV7GLFEiTgkQgQk2b/z2xQrGaqrzARHdrOTEe13DqUx2PnFjkH77qxGjF/R
         Fv3Q/3LbdjlAOGVznWQD4x9CcjBK7ihwBu705cJa7lwQP5/i+R+Xy+uTDbXvnrypexbU
         2963CHA/XU+KsPE8PtqjDVSuHgC3MFJQu7v0fViYQW3QNJrhhbsJsj/0pTad1RDrM0Tt
         Mqz91jZcI6T+Y+fNZtwDE1Ik6+ZeguJtcYkeDQ+A+BATo3zTpAXOS+iRP/fDsoFWFoey
         pdEQTxm6R7ihnqSaNzBjg91MQznybOp3M+TPrKnL3Fq+1S/HhIApGOyVGyZoPAUqrMD3
         76Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lRrq57w397KEjj99F1eu0ePTuse9TMJvNbmNZttcxV4=;
        b=U3CGI58KELR5APONPct2PYbHqATaf1Kr+S7UPwL09LMKZ0hImimDmlGCUcIO+t/few
         Dkjp8NxJNTvdSUJpdMiWe7ZP5gZaqXjP+dW2bsqqzZbOXgpB7xpLhlU4o9ovY7opLNqw
         Ph++052Zrc0hLogWQSxKTRkwI6M3PeKcGtV9VK/OOKQu/mZin0dYeNVwvsj22pNRoOp1
         O3/Ty1sKavwjttU+uW8bHKSs9HyKCxYThbxCAx1ACFwBr0MwPaFIq4GnIYfv7meuyulp
         UQkJ180gGc0cg6i03Em5H1d+hnBlhMhJTejqrOWFhVmzlgUHMmyGXRNr176Oi1stvvwi
         e9tw==
X-Gm-Message-State: AOAM530l7G7InEHbXKI3T7W8/XG/DPr+sdq7M/RjdTY7MzZKPPdGfSxn
        84/PgKZC4C+Q6Y552ORxsdPuIGfnYx9wEEjqtw5H8wKep7Q=
X-Google-Smtp-Source: ABdhPJwS4wgJ27bo1brklCCpRKCkVjZCwXpGXhfSv6nEWYPAh527AqIgY2tUEsDuYCUxOaB0yqifF6cOrJO5MbDS5PI=
X-Received: by 2002:a5e:9309:: with SMTP id k9mr3962748iom.135.1594719262995;
 Tue, 14 Jul 2020 02:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200713012428.1039487-1-caij2003@gmail.com> <20200713224020.1297154-1-caij2003@gmail.com>
In-Reply-To: <20200713224020.1297154-1-caij2003@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 11:34:12 +0200
Message-ID: <CA+icZUUXZmDLOXbcj6vZi6+ZTC41VbH77CViHFRmQfxiMBqYtw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry: add compatibility with IAS
To:     Jian Cai <caij2003@gmail.com>
Cc:     jiancai@google.com, Nick Desaulniers <ndesaulniers@google.com>,
        manojgupta@google.com, Brian Gerst <brgerst@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:40 AM Jian Cai <caij2003@gmail.com> wrote:
>
> Clang's integrated assembler does not allow symbols with non-absolute
> values to be reassigned. This patch allows the affected code to be
> compatible with IAS.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Jian Cai <caij2003@gmail.com>

Hi Jian,

thanks for the update!

I am glad to see that some Linux/x86 assembler "monsters" jumped on the train.

So, your patch with reviewer's comment got several iterations?
Not sure if you are aware of the process of submitting patches (see [1])?

It is common to add a ChangeLog below commit-message-body and diffstat
means add below "--".
Something like:
--
Changes v1 -> v2:
- I did some cool stuff to improve this

While at it... Please add your version-of-patch to the subject-line:
You can do this via "git format-patch --signoff --subject-prefix="PATCH v2".
There might be other cool git tricks I do not know.

Hope I was no "Uberlehrer".

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

> ---
>  arch/x86/include/asm/idtentry.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index f3d70830bf2a..5efaaed34eda 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -469,16 +469,15 @@ __visible noinstr void func(struct pt_regs *regs,                 \
>         .align 8
>  SYM_CODE_START(irq_entries_start)
>      vector=FIRST_EXTERNAL_VECTOR
> -    pos = .
>      .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
>         UNWIND_HINT_IRET_REGS
> +0 :
>         .byte   0x6a, vector
>         jmp     asm_common_interrupt
>         nop
>         /* Ensure that the above is 8 bytes max */
> -       . = pos + 8
> -    pos=pos+8
> -    vector=vector+1
> +       . = 0b + 8
> +       vector = vector+1
>      .endr
>  SYM_CODE_END(irq_entries_start)
>
> @@ -486,16 +485,15 @@ SYM_CODE_END(irq_entries_start)
>         .align 8
>  SYM_CODE_START(spurious_entries_start)
>      vector=FIRST_SYSTEM_VECTOR
> -    pos = .
>      .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
>         UNWIND_HINT_IRET_REGS
> +0 :
>         .byte   0x6a, vector
>         jmp     asm_spurious_interrupt
>         nop
>         /* Ensure that the above is 8 bytes max */
> -       . = pos + 8
> -    pos=pos+8
> -    vector=vector+1
> +       . = 0b + 8
> +       vector = vector+1
>      .endr
>  SYM_CODE_END(spurious_entries_start)
>  #endif
> --
> 2.27.0.383.g050319c2ae-goog
>
