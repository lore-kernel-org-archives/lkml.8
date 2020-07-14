Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D5FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A789220773
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kr9gHgmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgGNUPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgGNUPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:15:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBC2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:15:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b9so7486075plx.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5vDU3SOZNppPWReu/BX/vwqcknmkketPDxz7Ge1r0o=;
        b=kr9gHgmxKDu0EBjEX0V5IS6Xq2Syluix1i+0k1/PUcyd33F5IVOCcWz+balk3uHC0N
         3wOUePy1rw+Wz3MEerpNxT5Kwab1FWadUrChIrVnFAdUlktwp1UptAE04M6XZEjbiS52
         6vKDmGt9rdNRyMFN6054T8rvs8cQloUQVZA0q7Etj8xnJ/mOJexwnG/nQDOadHW+cHVi
         LRRFQuQC/eV3X23NTjrkmj3eIeQUJvDqUcsHZqOyNGfmdsp4NPtUzzv4EoWHAQ5yHvjX
         tsYNoWdDjBBQKPoI/8ZoctcDRnMdSOv8JAPtnZAUTOBaWOUvtNEDv/Odzx98SRq9DwhB
         ixpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5vDU3SOZNppPWReu/BX/vwqcknmkketPDxz7Ge1r0o=;
        b=RManFCPEe4cT0t5vaRMinDzo/yoMcQb7rUV5ir/SSXu2MeCcozGUxSQxuroJE7d0BY
         l+IlaqJI6839Ze6Ss4zzDm9ew2Eru+hJQ63VCtmCphKqszkG3sgXq812dwjB0XjCC+JS
         QVOyVoO+KlwNNzVOvtTFU3SDYxMDcUn9l3U4UN6ie6TEYZgVXSH+nWj1KKY5rerpchJI
         XnL0CdyZ0GBrgd7evrZP8cKaKwuKwVm81kYbOwYHX5oYEZQuzdWuUh33rlLXcoH105Vg
         A3wcXasuG2xWBfd+HXx8En6xqrRET3aQ1PIkUURvtlRWPrwRhUkmkEDLR2xijbb4x+N2
         90CA==
X-Gm-Message-State: AOAM532X6z7C7oHb3xaPRVUrBSlSt3/SB38a67SOXdzssM58bfawDCZD
        RdmY/moDaF5BZfWY8NcLBnOCuWowtGrm6NjlMCYxLw==
X-Google-Smtp-Source: ABdhPJyzulOEx1fy2GykYkyj3JCQYO7OOS59od2dzv/wxSO2KJoNNIRfTeYJeSunW2/6Ok1Rk/5CgzeiWYPpG0N3DEg=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr6448817pjb.32.1594757721132;
 Tue, 14 Jul 2020 13:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200714194740.4548-1-sedat.dilek@gmail.com>
In-Reply-To: <20200714194740.4548-1-sedat.dilek@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Jul 2020 13:15:08 -0700
Message-ID: <CAKwvOdnahj-izQo7BfC9cWDH9BXbnSBMdz=TjB9Rtn8ftvz7Og@mail.gmail.com>
Subject: Re: [PATCH v3] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Wei Liu <wei.liu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> When assembling with Clang via `make LLVM_IAS=1` and CONFIG_HYPERV enabled,
> we observe the following error:
>
> <instantiation>:9:6: error: expected absolute expression
>  .if HYPERVISOR_REENLIGHTENMENT_VECTOR == 3
>      ^
> <instantiation>:1:1: note: while in macro instantiation
> idtentry HYPERVISOR_REENLIGHTENMENT_VECTOR asm_sysvec_hyperv_reenlightenment sysvec_hyperv_reenlightenment has_error_code=0
> ^
> ./arch/x86/include/asm/idtentry.h:627:1: note: while in macro instantiation
> idtentry_sysvec HYPERVISOR_REENLIGHTENMENT_VECTOR sysvec_hyperv_reenlightenment;
> ^
> <instantiation>:9:6: error: expected absolute expression
>  .if HYPERVISOR_STIMER0_VECTOR == 3
>      ^
> <instantiation>:1:1: note: while in macro instantiation
> idtentry HYPERVISOR_STIMER0_VECTOR asm_sysvec_hyperv_stimer0 sysvec_hyperv_stimer0 has_error_code=0
> ^
> ./arch/x86/include/asm/idtentry.h:628:1: note: while in macro instantiation
> idtentry_sysvec HYPERVISOR_STIMER0_VECTOR sysvec_hyperv_stimer0;
>
> This is caused by typos in arch/x86/include/asm/idtentry.h:
>
> HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
> HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR
>
> For more details see ClangBuiltLinux issue #1088.
>
> Cc: Jian Cai <caij2003@gmail.com>
> Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1088
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

LGTM, thanks Sedat.

> ---
> Personal note:
> I also needed Jian's patch to completely build with LLVM_IAS=1" but
> I don't think that should be in the message that gets committed per
> se. Without Jian's patch we did NOT catch this one!
> Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> Link: https://lore.kernel.org/patchwork/patch/1272115/
>
> Changes v2->v3:
> - Fold in comments suggested by Nick
> - Add Nick's Suggested-by
> - Drop unneeded tags and order the rest alphabetically
> - Move comments and links to Jian's patch to a personal note
>
> Changes v1->v2:
> - Add Wei Liu's Reviewed-by
> - Add note to clarify my patch is independent from Jian's patch
> - Add link to latest version of Jian's patch
>
>  arch/x86/include/asm/idtentry.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index eeac6dc2adaa..d79541bfc36f 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -626,8 +626,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,  sysvec_kvm_posted_intr_nested
>
>  #if IS_ENABLED(CONFIG_HYPERV)
>  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,    sysvec_hyperv_callback);
> -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,     sysvec_hyperv_reenlightenment);
> -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,     sysvec_hyperv_stimer0);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR, sysvec_hyperv_reenlightenment);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR, sysvec_hyperv_stimer0);
>  #endif
>
>  #if IS_ENABLED(CONFIG_ACRN_GUEST)
> --
> 2.28.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
