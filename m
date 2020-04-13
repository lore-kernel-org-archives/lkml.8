Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4946CC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FC320737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsUxuzO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgDMSHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387625AbgDMSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:07:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CD9C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:07:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v23so4868861pfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGx7qFwHLiVd4V1d68uSwgIpjNRKonWDkoXdUUpJdmU=;
        b=MsUxuzO8lWza4IDAgKmbcE58BeSxidJVPD8d41B6WQkHuYQiWuox58R4hrZyfYImH+
         aG62uSXK90iOIw6wd/xPilPwCkapK+hPKP4pFn2CfMlIMYGiCND/S1J0Yz5/uj9vWZQb
         +ANK8Thwg3DqA4R5z5sF3HQGcwVTb0rUo/pFXkUlb0Tqp2xl8GlvruWuLqK6sveKzvOW
         cYbOgQhjtNcauJqQtCifBfn8eB+bn0G0UVG00DSR6GDHK9UMn+wHcd3K0TYWEfysj7lE
         QmdDQ02RPvWbZA6bOpV62Sd/ZLNdk4hQ8NCmKN5QRVwhadATPJocCJgmmEtl2lfWLwZr
         m6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGx7qFwHLiVd4V1d68uSwgIpjNRKonWDkoXdUUpJdmU=;
        b=S5uW6IBVagFbSnOCco76/1fmg+Z3hxVhzHoLRZWdE0y5805D7NlHoS4ccB9bWBIbhF
         tnPgcV/yILh7Wd5hqaC9bWN+5XJDIN55Il0akT+yAZLzsyBVhXE7vwtJGNI5/OwlCiqy
         D5iOKOONxh0i0nNeSxPQPaoZW1KU5lZ2E2kw0fcbvcujKP+L3PTLZiI2UadXx+6iuttX
         1SON3QPuyyfOonNVEiVHb3eQs/LEhAYvQFxriz+TtAGqn3M22ffUeglkT4frnCw7QMgA
         9bCWdhTfRBtoddcrmlQBFUvHC54VSfcs6C+WmuYC8ut8INxVQoYunQl/oF/K36y9qt2V
         9C4A==
X-Gm-Message-State: AGi0PuY9E5o0npM4G8U2LvsOh29rWM3XqAsACWEI9yFHC/sxGs7TrNlu
        pXOHHi+Z7HJ8EC/jPbWc+bs+ZSPVt18J1d2Wu4Rv9w==
X-Google-Smtp-Source: APiQypL5Itwso83J6130zSW1Vy0Vx1a7F1inJTmOwekbLOse4lUtOAVtXjT8lXgdWc+kouQdtpbj0NenWGIEDGqpSkQ=
X-Received: by 2002:a63:6604:: with SMTP id a4mr17243102pgc.381.1586801268806;
 Mon, 13 Apr 2020 11:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200413033811.75074-1-maskray@google.com>
In-Reply-To: <20200413033811.75074-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 11:07:37 -0700
Message-ID: <CAKwvOdkwpAJp2aw+PFybi11rjxvk5tc5zOhaFw9=Xim0k73DAQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Delete the space separator in __emit_inst
To:     Fangrui Song <maskray@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Jian Cai <jiancai@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 8:38 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Many instances of __emit_inst(x) expand to a directive. In a few places
> it is used as a macro argument, e.g.
>
>   arch/arm64/include/asm/sysreg.h
>   #define __emit_inst(x)                       .inst (x)
>
>   arch/arm64/include/asm/sysreg.h
>   #define SET_PSTATE_PAN(x)            __emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
>
>   arch/arm64/kvm/hyp/entry.S
>   ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
>
> Clang integrated assembler parses `.inst (x)` as two arguments passing
> to a macro. We delete the space separator so that `.inst(x)` will be
> parsed as one argument.
>
> Note, GNU as parsing `.inst (x)` as one argument is unintentional (for
> example the x86 backend will parse the construct as two arguments).
> See https://sourceware.org/bugzilla/show_bug.cgi?id=25750#c10

Thanks for the patch and for leading the discussion with the binutils
developers on this curious parsing case.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/939
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Fangrui Song <maskray@google.com>

Shouldn't this have:
Suggested-by: Ilie Halip <ilie.halip@gmail.com>
Since Ilie sugguested this in
https://github.com/ClangBuiltLinux/linux/issues/939#issuecomment-601776123?

> ---
>  arch/arm64/include/asm/sysreg.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index ebc622432831..af21e2ec5e3e 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -49,7 +49,9 @@
>  #ifndef CONFIG_BROKEN_GAS_INST
>
>  #ifdef __ASSEMBLY__
> -#define __emit_inst(x)                 .inst (x)
> +// The space separator is omitted so that __emit_inst(x) can be parsed as
> +// either a directive or a macro argument.
> +#define __emit_inst(x)                 .inst(x)
>  #else
>  #define __emit_inst(x)                 ".inst " __stringify((x)) "\n\t"

What happens if someone starts using `__emit_inst` from inline
assembly, and passes that subexpression to a macro?  There are no
users today in arch/arm64/, but I think it's better to change both.

With this applied on -next, and testing via:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make LLVM=1 LLVM_IAS=1
-j71 defconfig
$ qemu-system-aarch64 -kernel arch/arm64/boot/Image.gz -machine virt
-cpu cortex-a57 -nographic --append "console=ttyAMA0" -m 2048 -initrd
<path to my buildroot.cpio>

I was able to build and boot, modulo:
https://github.com/ClangBuiltLinux/linux/issues/988 (new)
https://github.com/ClangBuiltLinux/linux/issues/716
https://github.com/ClangBuiltLinux/linux/issues/510 (more specific to
LLD than AS)
so we're pretty close to being able to assemble an arm64 defconfig with Clang.
-- 
Thanks,
~Nick Desaulniers
