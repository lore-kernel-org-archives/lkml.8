Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FDCC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32B52070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL1OtJH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgD2AyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbgD2AyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:54:17 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C925C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:54:17 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o127so436961iof.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVCKB95iwC9L0s73/1b4PgZEDXMYea5f6aOdPbuhrfs=;
        b=oL1OtJH1jZEWtCPxmKJWypuIAYkdBy09ZSMxolC4nff8zPfhHJvTWaLFzl9rd8jAsn
         m+xvaZ/7yGzh16JkO39Ixpkh5D3rXmxtoTbukJTPK54Jg6ZFMcgkvFJy5UqEBkS1YfYk
         Fd0XnkPqOvyuPu99reJQA4k4e+dvBSs5Yu4A7hl9GoZtrW8kW0HxNJrHCSg1EFVx7GsW
         8G/gGT8yjLLFLMRMIVIgK7PlB8JN+4/ve/I9y54mE5phN3Mg/FJYUdJRJTQTV/9AeiV4
         YSL6g+duyYOFvAHndPv7x3cecfuogeHfidYAv2Wb4PG7wqr2QtZCt9AqEyIzMOyh6YSo
         4aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVCKB95iwC9L0s73/1b4PgZEDXMYea5f6aOdPbuhrfs=;
        b=DGn0eNWqHUTq9aAkINZIFQyOAYo3vc/9LmONKFiXIH3a5Pi/vQijSijgP3P/Aukxzl
         QrnFTY5jjT1DSeGiEmaCL9HGmgCN3y1TPkpjUg3ZEXAZYnh4VQmImJ4VruDP3et/vSBG
         FiWH5DlL6FWvn7lqRzSQ+PAwA7m9smh0Kp8GnXDG90yJa5kW6DY8s83VeUV342OhVdv6
         ng7WBlsfKuzeDOc7MF5faZLcB/X51gef8bEBDak1H23qGA9xglFOaLu3NKnxpdy8K3Cf
         UY8WJXaSAqdCr2/aFjEXf4+akD9Q0ks8J6xy5v3Y41054a0/JAojyneHftrLrhLsZvmi
         zhOQ==
X-Gm-Message-State: AGi0PubncU2GqW4K+XMZAflT9jExXQcMpMivK1dnqZNG2bRcBsMW7d9L
        BFnHDZ4rkJtck3NbIqhjwSFgGLid00zQ629JcQ==
X-Google-Smtp-Source: APiQypITAXxCTs0uKEAlDGYInBa5o8Mn2Ns7jyWD8cHLnvtll7VpZVda9N78Kqas+aAjF53EHbMfdN/mFM/oxhCl4ig=
X-Received: by 2002:a05:6602:1695:: with SMTP id s21mr29169787iow.40.1588121656779;
 Tue, 28 Apr 2020 17:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200428191101.886208539@infradead.org> <20200428191659.558899462@infradead.org>
In-Reply-To: <20200428191659.558899462@infradead.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 28 Apr 2020 20:54:05 -0400
Message-ID: <CAMzpN2jp1mtnf61eXPaj2O5=-8Fp42v+t6Br3ce9Fioq8h=0YA@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] x86,smap: Fix smap_{save,restore}() alternatives
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jthierry@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 3:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> As reported by objtool:
>
>   lib/ubsan.o: warning: objtool: .altinstr_replacement+0x0: alternative modifies stack
>   lib/ubsan.o: warning: objtool: .altinstr_replacement+0x7: alternative modifies stack
>
> the smap_{save,restore}() alternatives violate (the newly enforced)
> rule on stack invariance. That is, due to there only being a single
> ORC table it must be valid to any alternative. These alternatives
> violate this with the direct result that unwinds will not be correct
> in between these calls.
>
> [ In specific, since we force SMAP on for objtool, running on !SMAP
> hardware will observe a different stack-layout and the ORC unwinder
> will stumble. ]
>
> So rewrite the functions to unconditionally save/restore the flags,
> which gives an invariant stack layout irrespective of the SMAP state.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/smap.h |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -57,16 +57,19 @@ static __always_inline unsigned long sma
>  {
>         unsigned long flags;
>
> -       asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
> -                                 X86_FEATURE_SMAP)
> -                     : "=rm" (flags) : : "memory", "cc");
> +       asm volatile ("# smap_save\n\t"
> +                     "pushf; pop %0"
> +                     : "=rm" (flags) : : "memory");
> +
> +       clac();
>
>         return flags;
>  }
>
>  static __always_inline void smap_restore(unsigned long flags)
>  {
> -       asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
> +       asm volatile ("# smap_restore\n\t"
> +                     "push %0; popf"
>                       : : "g" (flags) : "memory", "cc");
>  }

POPF is an expensive instruction that should be avoided if possible.
A better solution would be to have the alternative jump over the
push/pop when SMAP is disabled.

--
Brian Gerst
