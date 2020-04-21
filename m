Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8545BC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E9C206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="eCuJRkEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgDUREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgDUREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:04:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9BFC061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:04:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so17263912wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMH7LFHGjke0ecop6Ck37MhaqJozu4/xdSqYH1Nj1NM=;
        b=eCuJRkEOayneNiTHhGB1PYMY2orZhaGSb/KOKIohfqoyYSCZNGbtlztY3blkbaVk+2
         RnA953vmTpFpq6DSwvsCXy2eeQKIZsaz8iku/u6362mwKNW3Ag4lc+zO7ilxtQESJteQ
         PXumE+UnihMQTBslwGmz0qmCy8xDgWOzXgxgesQiv+TwB1IXopoCyDfie5Kxb7/7Uzjz
         4FeWmZ71AC9buVWlkb+lJm7B5aff9eB9rck9tjkpj8H99ZtXEkpXPkWSi1fGBswOe4Mf
         8NAzZrM9O0fk6eiHzk+dqrxlqiAYu9s9LVSAhDmzknCTcppBQWWd8380mxddsuzyUnZc
         //OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMH7LFHGjke0ecop6Ck37MhaqJozu4/xdSqYH1Nj1NM=;
        b=TDoArVYpP/JnueOpRmOl+2yAP3/l8Ir3OCNUhIFqgExQEre0u+cYiCv+6zW+fAWUah
         gRVqmscwIRsP7swVNLsghCf8pJ4q2p3nG5ZPiG5XXt5U/rPRm8iGDdNurIUEYvmmNg8h
         Bq2Xqt3WLFkvz7BjegC0GGgsLS7lbKek58u81O6+/zB8DPa1qmx24BoMgLsDftYrSwmw
         f8zRFm4DhzfSeEtPkQyzz2PSRsx8aqY05Q2pvFy+mFq9N8Hswh8IVRkujnfwDEJEJnOy
         GSUfIqFwOJS3DpdUKd7mw7Ynls9cUTVroRSfPeBDJCEg0XQntap8ORdItkBPWuTmjMUO
         7Y+w==
X-Gm-Message-State: AGi0PuYqTpkQrRoMiEKkTgOhdI97sHMCCJ3z+rTX11dTqWCgLOGLlRJp
        FORwJFFtEGVW1Q2W+AJSGB3B2O5A23+UO1HWel2Krw==
X-Google-Smtp-Source: APiQypIMxoZ74j/mvkwctZ6t3tkTxF6XniIoBBNzZ3AT5u5hWEB9j/vZr+YeJ1dK2vLgzZohXMICQ7/uvjMz+0EU8L0=
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr24429721wrv.75.1587488688393;
 Tue, 21 Apr 2020 10:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200421092027.591582014@linutronix.de> <20200421092558.848064318@linutronix.de>
In-Reply-To: <20200421092558.848064318@linutronix.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 21 Apr 2020 10:04:37 -0700
Message-ID: <CALCETrW-5cR0DFpfKCdmiTxKHpzA+FBep5JuTJv3P--78SiKwA@mail.gmail.com>
Subject: Re: [patch V2 01/16] x86/tlb: Uninline __get_current_cr3_fast()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 2:26 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> cpu_tlbstate is exported because various TLB related functions need access
> to it, but cpu_tlbstate is sensitive information which should only be
> accessed by well contained kernel functions and not be directly exposed to
> modules.
>
> In preparation of unexporting cpu_tlbstate move __get_current_cr3_fast()
> into the x86 TLB management code.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Andy Lutomirski <luto@kernel.org>

> ---
>  arch/x86/include/asm/mmu_context.h |   19 +------------------
>  arch/x86/mm/tlb.c                  |   20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 18 deletions(-)
>
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -225,24 +225,7 @@ static inline bool arch_vma_access_permi
>         return __pkru_allows_pkey(vma_pkey(vma), write);
>  }
>
> -/*
> - * This can be used from process context to figure out what the value of
> - * CR3 is without needing to do a (slow) __read_cr3().
> - *
> - * It's intended to be used for code like KVM that sneakily changes CR3
> - * and needs to restore it.  It needs to be used very carefully.
> - */
> -static inline unsigned long __get_current_cr3_fast(void)
> -{
> -       unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
> -               this_cpu_read(cpu_tlbstate.loaded_mm_asid));
> -
> -       /* For now, be very restrictive about when this can be called. */
> -       VM_WARN_ON(in_nmi() || preemptible());
> -
> -       VM_BUG_ON(cr3 != __read_cr3());
> -       return cr3;
> -}
> +unsigned long __get_current_cr3_fast(void);
>
>  typedef struct {
>         struct mm_struct *mm;
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -844,6 +844,26 @@ void flush_tlb_kernel_range(unsigned lon
>  }
>
>  /*
> + * This can be used from process context to figure out what the value of
> + * CR3 is without needing to do a (slow) __read_cr3().
> + *
> + * It's intended to be used for code like KVM that sneakily changes CR3
> + * and needs to restore it.  It needs to be used very carefully.
> + */
> +unsigned long __get_current_cr3_fast(void)
> +{
> +       unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
> +               this_cpu_read(cpu_tlbstate.loaded_mm_asid));
> +
> +       /* For now, be very restrictive about when this can be called. */
> +       VM_WARN_ON(in_nmi() || preemptible());
> +
> +       VM_BUG_ON(cr3 != __read_cr3());
> +       return cr3;
> +}
> +EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
> +
> +/*
>   * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.
>   * This means that the 'struct flush_tlb_info' that describes which mappings to
>   * flush is actually fixed. We therefore set a single fixed struct and use it in
>


-- 
Andy Lutomirski
AMA Capital Management, LLC
