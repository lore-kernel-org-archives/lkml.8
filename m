Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4AAC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059032070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brsAwQH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCZRuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:50:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36437 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZRub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:50:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id i13so3151932pfe.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVhUI8kuQt6IgMPqeY7HijNVaAh3KiroMym2JdHvBYQ=;
        b=brsAwQH29iSE8mshBIMEsiJaEJF+MtC9co7LTYM1s5iPoWfOYvOIqiYqjH3sBuZOf3
         aqds8K3ipNIbPBdAadLcYagS/lTtdbVlhTUmrIBZ9mbDJeONgOv1vCWhB5tI+4Aw+/Pi
         ot1xySrBGpzLiofvPdq7upFm4UOmM7bPls6Q3hPSIKH1C7D/h3F1h6uyB+NwBPWo3ylv
         vmazfw07csCTogMxGj5mLULnk1IQzywQQIDkM7rGQQmKlBoXRkuQ1KmGjjn/jc8Bew1c
         HJpG6xjrI35S1PYv8QsHru2S9u8+pEsACI1sA0tWL8Bv8i1MpKyJywC0yUpmTwWtFADV
         QLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVhUI8kuQt6IgMPqeY7HijNVaAh3KiroMym2JdHvBYQ=;
        b=Gg5Xx6COaeCqstcGSwODUgkMy/qSwAX/XWz1SvND3mmfsjL24lpABVxvY2i20fWYlM
         XiPRSjl7zji5dVMs72mvxy/JQK2e7W2lsIN35+kKu9a4qaaB4L7AIBGUoabPduZ8YZ5g
         FwZknvmxgcueR9gENru5cedztyTu3Z4soCstGunq5Fj5JnK4Angh0dp65EoLcN7FFiWi
         ublQRBNU9uFYdIZiszxPZ9p0q2LICXdqhdBM691p0M4mX+224Sx7XwcDHBXb8ROqVOQw
         UBfhJWn4ninO75wn/btG0z/zhP7ZpihPyv5hFsJc9bSlowtCOCr0tY4u6Nd0RHgVw+mE
         I2xw==
X-Gm-Message-State: ANhLgQ1jxBCyp91XorSeLaM0RYddrj/cKk4mwtgdCXzg14LiUFYfG3AB
        esrDOyVgNR72Sv5M9h8RDyS0492vSYMisUqWeEA1Kw==
X-Google-Smtp-Source: ADFU+vv6mvUpG3SoGM36A9hiSxDUzQIQRzXI7YPfyK/2v9UhaSb0YZ1BviJKZdV84glpZdJUYol+/IfpWD7nc7hqWTs=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr9894991pgb.263.1585245029988;
 Thu, 26 Mar 2020 10:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200326080104.27286-1-masahiroy@kernel.org> <20200326080104.27286-12-masahiroy@kernel.org>
In-Reply-To: <20200326080104.27286-12-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Mar 2020 10:50:17 -0700
Message-ID: <CAKwvOd=3APTxrLD7U+hhMYoQm_ZTktckk-jurpwundm=w-pqKw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] x86: add comments about the binutils version to
 support code in as-instr
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 1:02 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> We raise the minimal supported binutils version from time to time.
> The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
> required binutils version to 2.21").
>
> We need to keep these as-instr checks because binutils 2.21 does not
> support them.
>
> I hope this will be a good hint which one can be dropped when we
> bump the minimal binutils version next time.
>
> As for the Clang/LLVM builds, we require very new LLVM version,
> so the LLVM integrated assembler supports all of them.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>   - Change the patch order and rebase
>
>  arch/x86/Kconfig.assembler | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
> index 91230bf11a14..a5a1d2766b3a 100644
> --- a/arch/x86/Kconfig.assembler
> +++ b/arch/x86/Kconfig.assembler
> @@ -3,15 +3,25 @@
>
>  config AS_AVX2
>         def_bool $(as-instr,vpbroadcastb %xmm0$(comma)%ymm1)
> +       help
> +         Supported by binutils >= 2.22 and LLVM integrated assembler
>
>  config AS_AVX512
>         def_bool $(as-instr,vpmovm2b %k1$(comma)%zmm5)
> +       help
> +         Supported by binutils >= 2.25 and LLVM integrated assembler
>
>  config AS_SHA1_NI
>         def_bool $(as-instr,sha1msg1 %xmm0$(comma)%xmm1)
> +       help
> +         Supported by binutils >= 2.24 and LLVM integrated assembler
>
>  config AS_SHA256_NI
>         def_bool $(as-instr,sha256msg1 %xmm0$(comma)%xmm1)
> +       help
> +         Supported by binutils >= 2.24 and LLVM integrated assembler
>
>  config AS_ADX
>         def_bool $(as-instr,adox %eax$(comma)%eax)
> +       help
> +         Supported by binutils >= 2.23 and LLVM integrated assembler
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
