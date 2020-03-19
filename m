Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B00C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5C520775
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCHznEO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCSPju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:39:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40768 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbgCSPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:39:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id l184so1620364pfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJgQNwFa53gC09TOaQbw283OU+sAvTexYYepz9mHTvk=;
        b=JCHznEO1d/dPI9KmbxT2UsYTSPVWGTO0JQFu8zE9Fku9PNaj9S2RVahq9q4azOe7TY
         DB3r4LVZshUvFI+JziN5cuQI/p09dpe9ivMspo3Iq1qRGmMi13twglOy9KFGWW26IvGI
         /SrsvEs0J7F7Iwd7E+0B9+XZvr4/3yL7Y77tgOn2DzNnZi1x5uxpDxHCv57yLv1CgMKR
         TlT9yP8UwkscK8hacTGD1u7xfMWgMcmX0NFv+5i29qpEHOxTINNISLyU0U+4pivtDMLi
         eBm6ksRB4i1fRQp4DTWW6Gx9kGvr03dHsByqHng7qkyKoYoQpWoneR7lMELh06kh7VvK
         Bk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJgQNwFa53gC09TOaQbw283OU+sAvTexYYepz9mHTvk=;
        b=D0d8nNFvVGDljtcSGISFUYjxhbT547yAInnNRkbJ2IDNAGvXFEeoyG2rOFsfeVHePE
         /VFaVoyJwRJoPcODvqdDPqNtwy3VGnJGCG/Dz7LK5aVyjKyy2OZQ6jdzsBPWC/MCjvIS
         fCBm4csoH5BjSCw/9LufT+3vMCEmgF+P6svWSzl4feEM4qYsth/Ty9+AuxYx/ELwYrqy
         5djCgEFfV0jC0ZB1zwnOqzQIrW8/h6mWc8GRwplnd7UG/nmGLTRFK8HpjxLVrzR9xNPK
         IB+hI2/rvTUwLFOs5D5aigDXB/TQsXSyp9K7Wnt+H9Kin82qEjnJF+e48uxQ1EH82IVg
         iDYQ==
X-Gm-Message-State: ANhLgQ0mFpunZls73HyD423CEygeUNK/9wbWLoz6yRrfyZKHoOFw2N3v
        xA8j3cm4WhGWYOu38vy3l39wCT4e6dFuiykuyJO4fw==
X-Google-Smtp-Source: ADFU+vvmDa2IbJuoRz7OqaXc97kIF7ReJt2HPcxDcSY6tuLJIrsnsTmzlMTMcc9bp5uVkabytdEutxv4gci9jRtn7xk=
X-Received: by 2002:aa7:8b54:: with SMTP id i20mr4577798pfd.39.1584632387767;
 Thu, 19 Mar 2020 08:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200319141138.19343-1-vincenzo.frascino@arm.com>
In-Reply-To: <20200319141138.19343-1-vincenzo.frascino@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 19 Mar 2020 08:39:36 -0700
Message-ID: <CAKwvOdnnsE2FyqajP4_FrwpgekptfLJsr3J9EgB3Ac37NgZszQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: compat: Fix syscall number of compat_clock_getres
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 7:11 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> The syscall number of compat_clock_getres was erroneously set to 247
> instead of 264. This causes the vDSO fallback of clock_getres to land
> on the wrong syscall.
>
> Address the issue fixing the syscall number of compat_clock_getres.
>
> Fixes: 53c489e1dfeb6 ("arm64: compat: Add missing syscall numbers")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/unistd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 1dd22da1c3a9..803039d504de 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -25,8 +25,8 @@
>  #define __NR_compat_gettimeofday       78
>  #define __NR_compat_sigreturn          119
>  #define __NR_compat_rt_sigreturn       173
> -#define __NR_compat_clock_getres       247
>  #define __NR_compat_clock_gettime      263
> +#define __NR_compat_clock_getres       264

This seems to match up with the glibc sources:
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/arm/arch-syscall.h;h=c6554a8a6a6e7fe3359f1272f619c3da7c90629b;hb=HEAD#l27
Here's bionic's headers for good measure:
https://android.googlesource.com/platform/bionic/+/refs/heads/master/libc/kernel/uapi/asm-arm/asm/unistd-common.h#240

I assume the _compat_ prefixes are the aarch32 syscall numbers?
Otherwise here's the list for aarch64:
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/aarch64/arch-syscall.h;h=c8471947b9c209be6add1e528f892f1a6c54f966;hb=HEAD

Looks like 247 was __NR_io_cancel; that's a subtle bug I'm glad was noticed!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>  #define __NR_compat_clock_gettime64    403
>  #define __NR_compat_clock_getres_time64        406
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200319141138.19343-1-vincenzo.frascino%40arm.com.



-- 
Thanks,
~Nick Desaulniers
