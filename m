Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC79DC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCB521775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny7zYbr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgD2MMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbgD2MMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:12:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C9C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:12:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b12so1892429ion.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wd8lOCeqQ2ItEqGZDnjyks12gqFKWxAWXv3HuNsd0+E=;
        b=Ny7zYbr+kyEI0SPmUrtIxkRdtWg/XHrxnH+pMPF2f4aQC7IeZS7quHBLPbCiFBSC3t
         COyKfTVMugvzNW4V8UEGa5SHUXPpRKZRqiCW3PAqBBeGFSEgfjVKdx6LU4j+gVuVdctM
         0NePfFG6pCZjsqBgse2eqWM6I6WQpO3Bm8qD0/eNUId1WCAd+4chVv0bRw06MCbl4WTc
         arV7KyEjRAsZHCgVlrfld49cjMINw1XCtZt/2Mc9QliPB7EJkeADibVKZc83vwCWzVIb
         AXDWkA6H8vbGXZ35F1fOkOfn8BRgmaavamRvpXCeMxdkv1RBHyxap5euG5pKhhvVDR2G
         XQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd8lOCeqQ2ItEqGZDnjyks12gqFKWxAWXv3HuNsd0+E=;
        b=mjfrQm+PQ3Pvgx3bK7bzsMLT6uEIdd0ern4cr+NrCkglqX43pmCcuvg678hO1R8FAa
         27IzE1VMckBSoLEZjnwngIkpopFecUV946Z68cG2OTyoICk+kXELb/pjgUaHRRwrih8c
         AhXRd2NOur9XFZPS9h8acyPXWlKoUaLhJDWEtS1s975SEdKBNRyw6WvJ60yOgZOXfdKq
         4PQn59Wy9b2plYA2ziK/S4EQQmLzjkQTNkKMtYoFV4ezVcRC9Y7HVVYeoxpqqIbPQxRt
         F4cHRnSTLzwMK8mQjqqmdvorMcr6+At0MRbxMzK63RrltIZxP5B73q+Ort9TE3+dKy4Q
         XUsw==
X-Gm-Message-State: AGi0PuayJyf/Orr62DCwivl9LPt9ZiwYid9cEoJfHF9JQ7HbLa9nTdAV
        GPf/ABq2RckvwrrBYvW84sibRRfq+gQ1bqsi/A==
X-Google-Smtp-Source: APiQypKEShQr15+0QhApJle2M1tm0JToGOYQw2P3O1oX0KBoe8bzJwocQbxrFAmX0x5AIE2ZxrnLNsLMRRg3AWgJ2mk=
X-Received: by 2002:a6b:b512:: with SMTP id e18mr6967348iof.168.1588162354101;
 Wed, 29 Apr 2020 05:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200428191101.886208539@infradead.org> <20200428191659.558899462@infradead.org>
 <CAMzpN2jp1mtnf61eXPaj2O5=-8Fp42v+t6Br3ce9Fioq8h=0YA@mail.gmail.com>
 <20200429083053.GE13592@hirez.programming.kicks-ass.net> <20200429101802.GI13592@hirez.programming.kicks-ass.net>
In-Reply-To: <20200429101802.GI13592@hirez.programming.kicks-ass.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 29 Apr 2020 08:12:23 -0400
Message-ID: <CAMzpN2ixz_W9G-Ez=YCSMOp=nEk1-27DpRBrDRk70V6mdDqxLg@mail.gmail.com>
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

On Wed, Apr 29, 2020 at 6:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 29, 2020 at 10:30:53AM +0200, Peter Zijlstra wrote:
> > > POPF is an expensive instruction that should be avoided if possible.
> > > A better solution would be to have the alternative jump over the
> > > push/pop when SMAP is disabled.
> >
> > Yeah. I think I had that, but then confused myself again. I don't think
> > it matters much if you look at where it's used though.
> >
> > Still, let me try the jmp thing again..
>
> Here goes..
>
> ---
> Subject: x86,smap: Fix smap_{save,restore}() alternatives
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Apr 28 19:57:59 CEST 2020
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
> when it hits between the PUSH and POP instructions.
>
> Rewrite the functions to only have a conditional jump.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/smap.h |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -57,8 +57,10 @@ static __always_inline unsigned long sma
>  {
>         unsigned long flags;
>
> -       asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
> -                                 X86_FEATURE_SMAP)
> +       asm volatile ("# smap_save\n\t"
> +                     ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
> +                     "pushf; pop %0; " __ASM_CLAC "\n\t"
> +                     "1:"
>                       : "=rm" (flags) : : "memory", "cc");
>
>         return flags;
> @@ -66,7 +68,10 @@ static __always_inline unsigned long sma
>
>  static __always_inline void smap_restore(unsigned long flags)
>  {
> -       asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
> +       asm volatile ("# smap_restore\n\t"
> +                     ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
> +                     "push %0; popf\n\t"
> +                     "1:"
>                       : : "g" (flags) : "memory", "cc");
>  }
>

Looks good.  Alternatively, you could use static_cpu_has(X86_FEATURE_SMAP).

--
Brian Gerst
