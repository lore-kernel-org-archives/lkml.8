Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F1BC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFC52070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWtR8S5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCZRtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:49:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43931 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZRtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:49:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id f206so3136717pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CVzG402jrx7Vd35GjafKVyfM1rK8OmiRNaJdvsplVw=;
        b=tWtR8S5N8i7CSQpF75RdTJqrclnkHBzrTkFsobGRb5RvayOAGjvnYX7e5Jiwqi0e1F
         DKsr/8FXlyN5QwtNU4WQSgxvFGKXvhyqrMRf553H7qvySX3rnhOEDf1jKoQ20GfJd1KM
         +iyCLvH1gfZ2Tm2oCepNd1p1bbogOtYTwlphX7TlRWHddaosKgrnT1nZ7yd2QGWQwM4M
         XDjLh7Bt17MbXDtsbJwohlH0UBjKCZA3XfKHLZhpz+PC4wDm5fCmef8szKKgaqNRJOcb
         43xnlOZIpPevDHpbw/2hB79ebTG3VmXhu6iPZJFMEIYyOwlOEKTUb/9tSL9d1OjP2S2G
         +YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CVzG402jrx7Vd35GjafKVyfM1rK8OmiRNaJdvsplVw=;
        b=mppVjAuH+H48lDVqFKJ0B9HFL7ZdswhypskjVX79rssNLU7kGjNr03G+X3iLBpd9ec
         zSYO7BNmQtthEbi+H4n95ahKAYAWC/Qa88duF1OIOpzeb2Sg3T70SuOz41WNifQ9qQ52
         FVuPbXtYe246FJGaohp/z8EC2waUL74632Aoq925VOo5wMkz0RFdVZNsDDa38iiRqnX5
         D0sIkqEBcq/M2J/fIJgjvYabTzr8xWJ4M+KjCOK/BVWfv9JQQirecfIfyqDTn6DbURxE
         f/UDXUGAi0cEPKxvY1x06IWlgWxzI3jMb/UBZ2jGORp5PKlvzJttAedB23jFy+AaAaAG
         uAzg==
X-Gm-Message-State: ANhLgQ0EPzd0gTi9jbrIEDL27P5FEx/GPg3lCLMQuES/2nqR8PTJigyf
        Q2fNTPVgCx4nCfxgThmyYEx5a6j+m+HwQmucoKRvJg==
X-Google-Smtp-Source: ADFU+vv5oWbBE0yh4vdP3Fh5MNHR5ig5PyKcuy01rreCKcHqUoWvJwRpjYTpYiMFUB1ttRrBSIrAQ0fA6ehNlAbQaXA=
X-Received: by 2002:a05:6a00:42:: with SMTP id i2mr10055970pfk.108.1585244987994;
 Thu, 26 Mar 2020 10:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200326080104.27286-1-masahiroy@kernel.org> <20200326080104.27286-11-masahiroy@kernel.org>
In-Reply-To: <20200326080104.27286-11-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Mar 2020 10:49:35 -0700
Message-ID: <CAKwvOdk=MCePWHD=Kj3K7fD0y8TBZfiFLB0X+gnhPUd=RnrH6A@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] x86: probe assembler capabilities via kconfig
 instead of makefile
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
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
>
> Doing this probing inside of the Makefiles means we have a maze of
> ifdefs inside the source code and child Makefiles that need to make
> proper decisions on this too. Instead, we do it at Kconfig time, like
> many other compiler and assembler options, which allows us to set up the
> dependencies normally for full compilation units. In the process, the
> ADX test changes to use %eax instead of %r10 so that it's valid in both
> 32-bit and 64-bit mode.

Does KConfig generate -D<foo> flags for KBUILD_CFLAGS and KBUILD_AFLAGS?
Looks like lib/raid6/test/Makefile also generates some of these?

>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2: None
>
>  arch/x86/Kconfig           |  2 ++
>  arch/x86/Kconfig.assembler | 17 +++++++++++++++++
>  arch/x86/Makefile          | 10 ----------
>  3 files changed, 19 insertions(+), 10 deletions(-)
>  create mode 100644 arch/x86/Kconfig.assembler
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index beea77046f9b..707673227837 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2935,3 +2935,5 @@ config HAVE_ATOMIC_IOMAP
>  source "drivers/firmware/Kconfig"
>
>  source "arch/x86/kvm/Kconfig"
> +
> +source "arch/x86/Kconfig.assembler"
> diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
> new file mode 100644
> index 000000000000..91230bf11a14
> --- /dev/null
> +++ b/arch/x86/Kconfig.assembler
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> +
> +config AS_AVX2
> +       def_bool $(as-instr,vpbroadcastb %xmm0$(comma)%ymm1)
> +
> +config AS_AVX512
> +       def_bool $(as-instr,vpmovm2b %k1$(comma)%zmm5)
> +
> +config AS_SHA1_NI
> +       def_bool $(as-instr,sha1msg1 %xmm0$(comma)%xmm1)
> +
> +config AS_SHA256_NI
> +       def_bool $(as-instr,sha256msg1 %xmm0$(comma)%xmm1)
> +
> +config AS_ADX
> +       def_bool $(as-instr,adox %eax$(comma)%eax)
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index f32ef7b8d5ca..b65ec63c7db7 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -177,16 +177,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
>         KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
>  endif
>
> -# does binutils support specific instructions?
> -avx2_instr :=$(call as-instr,vpbroadcastb %xmm0$(comma)%ymm1,-DCONFIG_AS_AVX2=1)
> -avx512_instr :=$(call as-instr,vpmovm2b %k1$(comma)%zmm5,-DCONFIG_AS_AVX512=1)
> -sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=1)
> -sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
> -adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
> -
> -KBUILD_AFLAGS += $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> -KBUILD_CFLAGS += $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> -
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>
>  #
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
