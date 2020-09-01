Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70CAC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27D4206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnafQcK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgIAOIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgIANzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:55:53 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84CC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 06:55:52 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 185so1197105oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=auSG8HzNptzzyjz8pWXNKZpHnASP/U1wFsRM2hl4jxE=;
        b=FnafQcK5lXm3bhu0cCVFWZizmcV+C/urYujVcRRD7wFjx/26W625gsFka+DrzAH4yH
         qvBBd6iTueg7QcmAF4pzKV+95RpEO238dnHdqQhNF7j4OECOm1uFBz/7fTSl1Mt5Nvhp
         oiQkNfX44dkgHt93H/50SSLIfnROSFlfgf/Ptjzd1eokbtTQvlNLHsK80ngzhMRCGZHn
         CbX8cOKtqm2SYKSvUiCEHdFvk3cLRHRmBDRU0H70g8P19WGE30WhqX6HdYomp1GRf73/
         j8kcsAPr4PhlXiQhkueeAmk4YSoKyVBiPqaI1T3oTcdE7mqV6llFXmA6CAIZFCXk0rEI
         fMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=auSG8HzNptzzyjz8pWXNKZpHnASP/U1wFsRM2hl4jxE=;
        b=E/WpYU63vSFyM8XuqlYGzEdCf/PvB/bonMbJ7fbJFP7gxGvLZ4y3fLxByklG6brq8V
         sQkmxq559iAzGU3EhzWaxcHcB3AhpPJj4Emis7MbNAHoVzAIrCfaxEvDkiMSQbFEJNfM
         tpqOGp2u6gxiElOFSgPDIA7OwOjQoWoooXodx885GR/DHMB/qAxs3mmsMV2vMIqJTjau
         dPBwe2qS6ovT3e5Iv1loClpCSGbWKcFg60QDfPWpTNev/bNiGT7Itgi1o4mobK5Whwtw
         EVtDdVhFNFqXuDkNcUaPq0yvScXMYpHIek4byXsESFh6OOhv0fUt/fLHy8xa2JsHazmi
         jMjQ==
X-Gm-Message-State: AOAM530l17a+Z/TnrqolnzZnlDzMg/3l3bAfaA7zj+8Xda/ciwuyI1EV
        Z/3IRNc/Z635ys9Qv4sRXFl9y+sPg4mQDpIgEBI=
X-Google-Smtp-Source: ABdhPJxOgu/SBzSJUbzGRXsFcPAyk+uvfyzm0xIugxWNxGdxhHqLbXvLp03Svb73z+LrPMJt3WfbkAuPBBRF5+2Q1OY=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr1161530oih.35.1598968552301;
 Tue, 01 Sep 2020 06:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com>
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 1 Sep 2020 15:55:40 +0200
Message-ID: <CA+icZUVWMXFJ1K1Mkfm9mnTAgoM4-avww=9BPn5msDNMvrvN+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] set clang minimum version to 10.0.1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 2:23 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Adds a compile time #error to compiler-clang.h setting the effective
> minimum supported version to clang 10.0.1. A separate patch has already
> been picked up into the Documentation/ tree also confirming the version.
>
> Next are a series of reverts. One for 32b arm is a partial revert.
>
> Then Marco suggested fixes to KASAN docs.
>
> Finally, improve the warning for GCC too as per Kees.
>
> Patches after 001 are new for v2.
>
> Marco Elver (1):
>   kasan: Remove mentions of unsupported Clang versions
>
> Nick Desaulniers (6):
>   compiler-clang: add build check for clang 10.0.1
>   Revert "kbuild: disable clang's default use of -fmerge-all-constants"
>   Revert "arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support"
>   Revert "arm64: vdso: Fix compilation with clang older than 8"
>   Partial revert "ARM: 8905/1: Emit __gnu_mcount_nc when using Clang
>     10.0.0 or newer"
>   compiler-gcc: improve version warning
>

I have tested theses 7 patches together with v2 of "Documentation: add
minimum clang/llvm version".

- Sedat -

>  Documentation/dev-tools/kasan.rst | 4 ++--
>  Makefile                          | 9 ---------
>  arch/arm/Kconfig                  | 2 +-
>  arch/arm64/Kconfig                | 2 --
>  arch/arm64/kernel/vdso/Makefile   | 7 -------
>  include/linux/compiler-clang.h    | 8 ++++++++
>  include/linux/compiler-gcc.h      | 2 +-
>  lib/Kconfig.kasan                 | 9 ++++-----
>  8 files changed, 16 insertions(+), 27 deletions(-)
>
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
