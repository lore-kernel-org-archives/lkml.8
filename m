Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86593C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFFB20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbBEkmgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgEKSwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731198AbgEKSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:52:29 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:52:29 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b71so2827189ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTCOmg8Lu45FSlE0YEbxP+MF1nPzk5IAZBv8bJFRLRw=;
        b=vbBEkmgSK85oY+vxRZC1osCwudndVFKMCeTNym/mh2sSWP5BuafaU/fqMM4tyMzYSJ
         vFf7KCghS35C/3+K1U2N/9qnLeXU74a6qoekCaZKzAiKgZZDLOLvFVEu6Zi1wF0QU8e/
         WeC4QziV41rhxCXWuudTiGCwGuPuRGbCG6x5Zjf98rHK2s1LKL5FFf4i0jkrKf55ulJU
         iAQY2COLLuULM7sV6EkAV91tk9nPKtLwsKOid77BRlE8Qy+XJsH/k1xUcl0TkfpXD0pb
         07JQGAyX02YIzQew2l/Dopaaxz5Nhj7iq2lHnXqQeOueVvnxLReV96/o4NIptmgbLM6M
         18Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTCOmg8Lu45FSlE0YEbxP+MF1nPzk5IAZBv8bJFRLRw=;
        b=rQJhftd1JgFofpb6WNp6I1pYUiicrFDNxxI19J3gadL+175ZK5seUcCE4nqKnI4Kxl
         UdkcwNjjIzWq3V6NLRVQ6lWh/hixJbEhQZLTN3304bKFXcZ9iuqIyyzbce9+Etn4Huzz
         TXhyKvFQy7mIzsd+pXyPj7o3AaxrYCUphOKLzKoDLLK36a83XxEItewEu5thdIbvDRwc
         e22/IO1tNmFXAd4WhrVfZKokQw+VnDp3IMD0tykwwABLYDGfk1jPXsJ3yYR9VQAwWXVf
         AWCtMBBkTWmRLqMQReKZTOTMkKO+kYEvOcyZqwx0BSv6Ai5UqNOavBSH2ADDplFqEJuz
         Es7Q==
X-Gm-Message-State: AGi0PuYqBof4QC5CvNyrTwHOdObRyoDFgb0qULRj36e/3RaabpuXUPx/
        y9goiCIjpQ1lH8bOEXsouxxTSRn1VzKpftN0KQ==
X-Google-Smtp-Source: APiQypL/DApkOcWUS8mpKi+CmS9HQIfuw1B10rr8ZBJgvWbIOu1VecdC3XBssG1mNb8aVWv3sYi4QMiCv79L/mD591k=
X-Received: by 2002:a05:6e02:5a3:: with SMTP id k3mr11399870ils.11.1589223148150;
 Mon, 11 May 2020 11:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200508182835.228107-1-ndesaulniers@google.com> <20200508183230.229464-1-ndesaulniers@google.com>
In-Reply-To: <20200508183230.229464-1-ndesaulniers@google.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 11 May 2020 14:52:16 -0400
Message-ID: <CAMzpN2hUQwGoYQnsKZJHFY=p-=-zXTwhRnCejhoztCvPX8e=CA@mail.gmail.com>
Subject: Re: [PATCH v5] x86: bitops: fix build regression
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 2:32 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> This is easily reproducible via CC=clang+CONFIG_STAGING=y+CONFIG_VT6656=m.
>
> It turns out that if your config tickles __builtin_constant_p via
> differences in choices to inline or not, these statements produce
> invalid assembly:
>
> $ cat foo.c
> long a(long b, long c) {
>   asm("orb\t%1, %0" : "+q"(c): "r"(b));
>   return c;
> }
> $ gcc foo.c
> foo.c: Assembler messages:
> foo.c:2: Error: `%rax' not allowed with `orb'
>
> Use the `%b` "x86 Operand Modifier" to instead force register allocation
> to select a lower-8-bit GPR operand.
>
> The "q" constraint only has meaning on -m32 otherwise is treated as
> "r". Not all GPRs have low-8-bit aliases for -m32.
>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/961
> Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
> Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers
> Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Suggested-by: Ilie Halip <ilie.halip@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-By: Brian Gerst <brgerst@gmail.com>
