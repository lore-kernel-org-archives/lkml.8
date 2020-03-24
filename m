Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D64AC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076AF2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdrJdf/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgCXQnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:43:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42544 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgCXQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:43:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id 22so5961213pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ckbAFa8zCaMccZFo+Gs27f6PIvd3NdOwxh/HtsnAf4=;
        b=PdrJdf/5ys6G3EkHhtXeLqfbI+F9R/JtXgfxhdtfi7xtfWtwBLpicCmJD0uQPiayuy
         KILQctVB/KRsDuF/iAO4i2lDkvrLBE361kCvNgGZzuoGNOwlS3Hos+htfICMB8QgcuM0
         8Zf6o6oIEWs+jLE656I8sssd65dAtKsBVPGpL5EZQtxQ7wncHCIzUUHcZZ76h20mAVy7
         Ybwt4nRtTUceiL5jelbX+fketk0uQvSKIWbV8D6CBucW9drzAfu9FgDMMUxIK+AV/clX
         6ABIVm85WrKDWOdv5G8YreS7FpcX0IDYwIAGpPYgH/Ii+2xwB5d2LHV1KX3APugdazIt
         f3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ckbAFa8zCaMccZFo+Gs27f6PIvd3NdOwxh/HtsnAf4=;
        b=cC/8WnCQIIX2bRg7S4b5KUWTAlKJIJrGD+/3NjEpCIrSftmlgqH/KvqCfbQ7Kch6KT
         5qhDECAEGaeu+KDseC34DQIKVXT6KYVrGnhyDhYsxeN9XLFgLM2VBp71VomWP6yQcUXa
         cWvfMeOM2tOSmgE0DBRJ4V298Gkpbq5HtoSx5IzebgXdh+lhElBaognX3fk9l1sUoAhs
         bHMbDJjCFs1VT0D/yAsk1lk9aoJx4OSG/2KPEFos9XNMmgokW0vf7ANIkX3GnZ12BT0r
         7YKlA4itjsU9uecBoc+jfqmwVUpKqoRlIwzAsR9YLRR1GJw6lZ9Vq2cIK2NblQgyRg2y
         7d2g==
X-Gm-Message-State: ANhLgQ2YkCHnNcZVPSJKP5Uo1vZGlb5/Zh0wXgebommmCf2nzvneBL/x
        Ts+9W4IIdvdiemva0L5uEISi4MAELVamvzZSxQ3w7Q==
X-Google-Smtp-Source: ADFU+vsYLJpgvdYUU6R2yZeo2upmrFukYJCYvpMGWGdaxSJf6OvZ3OIxFLbqDmEhy/067UwZ716Po3aVR6VwoqLuFIA=
X-Received: by 2002:a63:a34d:: with SMTP id v13mr7028614pgn.10.1585068217691;
 Tue, 24 Mar 2020 09:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200324084821.29944-1-masahiroy@kernel.org> <20200324084821.29944-3-masahiroy@kernel.org>
In-Reply-To: <20200324084821.29944-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Mar 2020 09:43:26 -0700
Message-ID: <CAKwvOdk6aUuAH_o+P8b+WneQ96yhTPGAXqgzH+FJ5DHB9AqYYA@mail.gmail.com>
Subject: Re: [PATCH 02/16] x86: remove unneeded defined(__ASSEMBLY__) check
 from asm/dwarf2.h
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This header file has the following check at the top:
>
>   #ifndef __ASSEMBLY__
>   #warning "asm/dwarf2.h should be only included in pure assembly files"
>   #endif
>
> So, we expect defined(__ASSEMBLY__) is always true.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  arch/x86/include/asm/dwarf2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index ae391f609840..5a0502212bc5 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -36,7 +36,7 @@
>  #define CFI_SIGNAL_FRAME
>  #endif
>
> -#if defined(CONFIG_AS_CFI_SECTIONS) && defined(__ASSEMBLY__)
> +#if defined(CONFIG_AS_CFI_SECTIONS)
>  #ifndef BUILD_VDSO
>         /*
>          * Emit CFI data in .debug_frame sections, not .eh_frame sections.
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200324084821.29944-3-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
