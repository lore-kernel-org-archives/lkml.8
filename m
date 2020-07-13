Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F75C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C65F206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeDsLFtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgGMCyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgGMCyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:54:32 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB34C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:54:32 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e3so5171882qvo.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o2kSFHN4HGSBMB4M9W3uTWmnegum+jrs9F0qbYSqLis=;
        b=XeDsLFtuqp0vXCZgf+5jopr5+SV5eXE2lzN+ymKjOvq72JPr8G81zMzrYbL09JDy24
         V2KIqx3t9DaU84xiUbdPzy6juCZcnlgAnvtPSogPbxFy+fkWvAK0WzBs8ViB2Xv4xQb8
         xvUMKHe45yrniM7AyHASI1EWLNVuCUTcONT/dU4s9O9zxAlKObUnM9cl+5gFtZUUhy7O
         zJHstL7ztzB4iP0PPzFNnCLt3ztKZ7vjykiTXqtMZ9f+hcfc4KYj66h45IHUZdjDy39W
         f0f1RHFY+sU9UW0wafApklgR8Y7+uikZqWyyy7s3pvfdNhRhi2987qp3SJ1oleBtghnT
         B15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o2kSFHN4HGSBMB4M9W3uTWmnegum+jrs9F0qbYSqLis=;
        b=spk+gncYQDsMbrtehtl8MnRSOtA9cbNl5NB1s/3WeBfeie9pFiwP1KqSrQRrZKhSbr
         5IUtTy1z9Vr53bgsMFVWC2twR7zdYCaaQjdUx32w35P1IKVulerRj882kWQwJwHLMbip
         w3cYlZXAgc+3Fkzg9HEQiBMO8D17FpuB/0fLw/Z6A5g6kD0mIyLkNVDVlT+rVjy4Xpo3
         HgTT0WTR6l763QpTR9HeLqnsR6dHuT2/CtXjbqK7RYPH/sfRs7j3YK7CsnDeDqOF87G/
         XRdSSWXP+zHVs7PKFifYOqcH6cdDK6zWAn5FZJ9TnKaDrJztmIbnZywvX3BbWB6Oy1Lx
         rx5Q==
X-Gm-Message-State: AOAM532ZN9tbNJkPraJnvJ2EqXGPebsDpw27ci8HmJPOicvEkXsv0rUu
        CjwpeVk8/ykhaDNq4khMjBA=
X-Google-Smtp-Source: ABdhPJx99umM8HjiK0uRdLtcVyuWXntNa4nDsR2sI7MJla9h8rFtDOyLw2bECmA0P7IsRjEK+7YcvA==
X-Received: by 2002:a05:6214:1882:: with SMTP id cx2mr79943466qvb.240.1594608871743;
        Sun, 12 Jul 2020 19:54:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r5sm18161539qtc.20.2020.07.12.19.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 19:54:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 12 Jul 2020 22:54:29 -0400
To:     Jian Cai <caij2003@gmail.com>
Cc:     jiancai@google.com, ndesaulniers@google.com, manojgupta@google.com,
        sedat.dilek@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86/entry: add compatibility with IAS
Message-ID: <20200713025429.GA704795@rani.riverdale.lan>
References: <20200713012428.1039487-1-caij2003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713012428.1039487-1-caij2003@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 06:24:22PM -0700, Jian Cai wrote:
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
> @@ -468,34 +468,32 @@ __visible noinstr void func(struct pt_regs *regs,			\
>   */
>  	.align 8
>  SYM_CODE_START(irq_entries_start)
> -    vector=FIRST_EXTERNAL_VECTOR
> -    pos = .
> +    i = 1
> +    pos1 = .
>      .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
>  	UNWIND_HINT_IRET_REGS
> -	.byte	0x6a, vector
> +	.byte	0x6a, FIRST_EXTERNAL_VECTOR + i - 1
>  	jmp	asm_common_interrupt
>  	nop
>  	/* Ensure that the above is 8 bytes max */
> -	. = pos + 8
> -    pos=pos+8
> -    vector=vector+1
> +	. = pos1 + 8 * i
> +	i = i + 1
>      .endr
>  SYM_CODE_END(irq_entries_start)

I think it would be a little cleaner to initialize i to 0, and drop pos.
i.e. couldn't we do
	i = 0
	...
	.byte	0x6a, FIRST_EXTERNAL_VECTOR + i
	...
	i = i + 1
	. = irq_entries_start + 8 * i

>  
>  #ifdef CONFIG_X86_LOCAL_APIC
>  	.align 8
>  SYM_CODE_START(spurious_entries_start)
> -    vector=FIRST_SYSTEM_VECTOR
> -    pos = .
> +    i = 1
> +    pos2 = .
>      .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
>  	UNWIND_HINT_IRET_REGS
> -	.byte	0x6a, vector
> +	.byte	0x6a, FIRST_SYSTEM_VECTOR + i - 1
>  	jmp	asm_spurious_interrupt
>  	nop
>  	/* Ensure that the above is 8 bytes max */
> -	. = pos + 8
> -    pos=pos+8
> -    vector=vector+1
> +	. = pos2 + 8 * i
> +	i = i + 1
>      .endr
>  SYM_CODE_END(spurious_entries_start)
>  #endif
> -- 
> 2.27.0.383.g050319c2ae-goog
> 
