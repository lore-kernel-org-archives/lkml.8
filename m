Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9708BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A062206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiwlCzmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGMCdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMCdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:33:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE9C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:33:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y2so11898061ioy.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86gu0C74GPG2i+vB7R9610DsdyKxfiqdWZYUsHZUDv4=;
        b=qiwlCzmoF1Ifu7JhCGm296pf4B7cE1gM0U+okcuH+60FW0dZARwgDIfCXqZTtXS+ke
         JGRp17Cryv2Kfzi0DiYurzd0KwaTQe4rebSJA6Qqjbl1I8ddHfXT3//VYD0SkKNZBwOa
         B5/DbmFTzE8J0GMKp1hu3bfqVTyztZsjkbKta3bfGXpiU8mMSU20nKGW/ap7Ozo6lMWW
         lInaxM+b/sj2Hn8nDJPSLa7SWx0Qy6aqlHvmlIF4IdUfr6DYGFKmMazpMn6B2Biyyim8
         m9b2wlS2LuN6siqi3M8ZXy5thuaN9TDwqH+yknze2wkuzEEjzJUOSxPKsDw6whEmJZNT
         sb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86gu0C74GPG2i+vB7R9610DsdyKxfiqdWZYUsHZUDv4=;
        b=FZ8T1mooi75WkJVwIOOtcpgC7RwBGbOliDVekMfW24c8iFFX50HmuFW61pwlIsNdow
         R6Z6Gjg4IU9l0L6FAICrMmvp0PJworcyDxmfSnh6DM4IrOSObwDRgQ4AqcElbo/Sv05f
         qE/ddBOuD4hpwXBsVfJRZIFvwqEYlxl5pWT8O5vk2YFS718fWHoxG0qi9kcdyER2Y6on
         5MlMQ76ZUCWs8j15dpDno4O+iFHTMmlX80cITEyS2GU5ize9GEXt0yWb1phDw4n4Hzdb
         cb1YvqUByxL1zrw1ShemIljuH/IlqieNekofNcWNOwqLoh30ADPhki+FvzzNHR8RIs2S
         otVw==
X-Gm-Message-State: AOAM533I7YwxKkhTJR/uEGTOjHciL1atrEdK7jIzSpSQDjZeMgbOMWP1
        Dlmw1yoQgR3CVVbG4/xvKVgD8l7Yw76siwgb7Q==
X-Google-Smtp-Source: ABdhPJwXii6lE9Pg0aooYszGl0ijQ68C08AEMzcMt1mxPz4tsfxiaZZ5DPbQiYEmzwuLE9ZMjhrE+zRlDBcwFk/+vhQ=
X-Received: by 2002:a02:a008:: with SMTP id a8mr85486997jah.68.1594607611745;
 Sun, 12 Jul 2020 19:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200713012428.1039487-1-caij2003@gmail.com>
In-Reply-To: <20200713012428.1039487-1-caij2003@gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 12 Jul 2020 22:33:20 -0400
Message-ID: <CAMzpN2idjMEFXvxZKOwDggO1MAFESRE4E_Ch55gfPeLFipxDqw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry: add compatibility with IAS
To:     Jian Cai <caij2003@gmail.com>
Cc:     jiancai@google.com, Nick Desaulniers <ndesaulniers@google.com>,
        manojgupta@google.com, Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 9:26 PM Jian Cai <caij2003@gmail.com> wrote:
>
> Clang's integrated assembler does not allow symbols with non-absolute
> values to be reassigned. This patch allows the affected code to be
> compatible with IAS.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Jian Cai <caij2003@gmail.com>
> ---
>  arch/x86/include/asm/idtentry.h | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index f3d70830bf2a..77beed2cd6d9 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -468,34 +468,32 @@ __visible noinstr void func(struct pt_regs *regs,                 \
>   */
>         .align 8
>  SYM_CODE_START(irq_entries_start)
> -    vector=FIRST_EXTERNAL_VECTOR
> -    pos = .
> +    i = 1

Start with index 0.

> +    pos1 = .

pos1 is unnecessary, as it's equal to irq_entries_start.

>      .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
>         UNWIND_HINT_IRET_REGS
> -       .byte   0x6a, vector
> +       .byte   0x6a, FIRST_EXTERNAL_VECTOR + i - 1
>         jmp     asm_common_interrupt
>         nop
>         /* Ensure that the above is 8 bytes max */
> -       . = pos + 8
> -    pos=pos+8
> -    vector=vector+1
> +       . = pos1 + 8 * i
> +       i = i + 1

If you swap these two lines then the index will be correct for the
next stub if you start at 0..

>      .endr
>  SYM_CODE_END(irq_entries_start)
>
>  #ifdef CONFIG_X86_LOCAL_APIC
>         .align 8
>  SYM_CODE_START(spurious_entries_start)
> -    vector=FIRST_SYSTEM_VECTOR
> -    pos = .
> +    i = 1
> +    pos2 = .
>      .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
>         UNWIND_HINT_IRET_REGS
> -       .byte   0x6a, vector
> +       .byte   0x6a, FIRST_SYSTEM_VECTOR + i - 1
>         jmp     asm_spurious_interrupt
>         nop
>         /* Ensure that the above is 8 bytes max */
> -       . = pos + 8
> -    pos=pos+8
> -    vector=vector+1
> +       . = pos2 + 8 * i
> +       i = i + 1
>      .endr
>  SYM_CODE_END(spurious_entries_start)
>  #endif

--
Brian Gerst
