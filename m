Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD42208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="yrmCzq2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgFPQxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbgFPQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:53:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A212C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:53:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so21540043wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Js4gbZUvytBR2hfvID1R/9oSc5bd7gjbU9gzR8H2bqI=;
        b=yrmCzq2Dz3cI/kFHGmaBOhcEKFyToGa51RWjILeHP2431FA9BcWSE2Xxl5mj4Kn6Bo
         keFN3eAgMf3/eDUkkETk7DLpLwUOzBfDAO4l4RGPfDQXD8TiY+H5RK9FctzOjieiF7SF
         8574AXU2FWGbFaq/PWnyfm0NEXznF9ANT32Pvu+HNV+dIS4BAecYiw0D4jO8NetCL3z2
         GnaO8PqHB2EubnJ3oVQ9DSENhWAtJnQEaQryjJPnXjSDnWLpT331w9yuYZm7p7seapiF
         US/o/tmZq3oN2rQGPPn7sGY7BP7d+44Z519+KpiPMDr8ZY+38DVi8RHN4frPsdyh8zHK
         bSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Js4gbZUvytBR2hfvID1R/9oSc5bd7gjbU9gzR8H2bqI=;
        b=F761Al7oOOCkoJ7sxCFWPW+PUqgly0ck+Dx382FkNqP2oJU5XESpmXWEvT6jq/bvkM
         1mvqf0XuwzfTf8x6xT6AZdY4zYJcFDzYIqdrIamfnCqPD9T56kVIK9UuudjSYatA4aGg
         GsXJ0zpte0Mp/cguOsbGTe0pUYV3UfFTngCarxGphXa3F5StUqcIXDsy5KDvS3Lh+b+f
         xqez0+B0G4rtQlZ1WLQEP8QR/9ziXaUGMk3aVtCUFxv+CgSWCmwPRaLDEKCd7kbj55rb
         OK45mND2vPsCJFEykOgdVs63+iEsFbBlMB2JFlEwV/AZjIHYDcS90x5Mgcmzx7pCxKZ0
         JLJw==
X-Gm-Message-State: AOAM5330GXYb4F2l9OF5ABSVs5ecBvc3dL9IUwp47t64byeMhqNdZMEn
        Fs/KPJ9guTHJFxlMm9k9jyNQ2j5MxUQsG5PpaYVJLQ==
X-Google-Smtp-Source: ABdhPJx1Duy2nyWKcMBsMsweJwXW6wkg/x2SGCm7c80oNOMrjc0csEexVTzCSAvCaFJ8mWaS/+IlTiDWjD8QPokwm64=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr3896934wrm.75.1592326430754;
 Tue, 16 Jun 2020 09:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200616095340.GD13515@zn.tnic>
In-Reply-To: <20200616095340.GD13515@zn.tnic>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 16 Jun 2020 09:53:39 -0700
Message-ID: <CALCETrWQJtv6f1zYnWSiPe7qFUx4znthbysVC9NJ-88YqP5-eg@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 2:53 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> here's the fix first so that it goes in. I'll hammer on the test case later.

Does the 32-bit case need FNINIT?

>
> ---
> From: Petteri Aimonen <jpa@git.mail.kapsi.fi>
>
> Previously, kernel floating point code would run with the MXCSR control
> register value last set by userland code by the thread that was active
> on the CPU core just before kernel call. This could affect calculation
> results if rounding mode was changed, or a crash if a FPU/SIMD exception
> was unmasked.
>
> Restore MXCSR to the kernel's default value.
>
>  [ bp: Carve out from a bigger patch by Petteri, add feature check. ]
>
> Signed-off-by: Petteri Aimonen <jpa@git.mail.kapsi.fi>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=207979
> ---
>  arch/x86/include/asm/fpu/internal.h | 5 +++++
>  arch/x86/kernel/fpu/core.c          | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 42159f45bf9c..845e7481ab77 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -623,6 +623,11 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
>   * MXCSR and XCR definitions:
>   */
>
> +static inline void ldmxcsr(u32 mxcsr)
> +{
> +       asm volatile("ldmxcsr %0" :: "m" (mxcsr));
> +}
> +
>  extern unsigned int mxcsr_feature_mask;
>
>  #define XCR_XFEATURE_ENABLED_MASK      0x00000000
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 06c818967bb6..f398fedc590a 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -101,6 +101,9 @@ void kernel_fpu_begin(void)
>                 copy_fpregs_to_fpstate(&current->thread.fpu);
>         }
>         __cpu_invalidate_fpregs_state();
> +
> +       if (boot_cpu_has(X86_FEATURE_XMM))
> +               ldmxcsr(MXCSR_DEFAULT);
>  }
>  EXPORT_SYMBOL_GPL(kernel_fpu_begin);
>
> --
> 2.21.0
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Andy Lutomirski
AMA Capital Management, LLC
