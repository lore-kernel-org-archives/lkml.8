Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D661C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A38C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEYPs998"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgENXrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgENXrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:47:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E35C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:47:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so182184plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJ319p+W05TbtIHodnmslKmxvaislCF8XQX/X/cRrWQ=;
        b=SEYPs998J8EWU2hjALQreAwc4NjDwFAysfzWzr7uoSSmx1pwv4YS8tlO+w7px5ULBR
         yPya5dHOQxFl1ZrOtUtt4b9B9m2829UCEKeaZ37Vy9c9iFEDaBiUgjQrpp2O6xbMLhrg
         WUTOJp9bWCZJOen7ErMBngCbfg6dTJNg+Lhqg9uGcZk/yOkZsIeA0lW1uDXjYc7g4CPU
         G349CKzFMb5bfTgpKZdYsgZ4RJcuvoOIGDnE+JAh63lVUC3nBVNRg4VsP6Fpk1dyovS7
         /Ic3oOUdhGqMqv++U6LU669vxzuxBBWyCSZirc1YtzBwPIo8VLhUfaNz1NZZxZgmw7xk
         BYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJ319p+W05TbtIHodnmslKmxvaislCF8XQX/X/cRrWQ=;
        b=G4dLb1rhe8tAf8QaXbbrbwivEU6I9Am3hIJYtZr8OdwJn6sFYDXERwZbvxcQ6xrfks
         E/nAguuAFapDlhivspSYETSKZAp0C7zuZFsK/uXi2nSdhWr1qFeZ2RjN3hSzWh9GmefB
         1G1zJIbjP5KmdYlsSUvw2yJZhrNubxwDCCl/jTnHvpAdCfgEg4Yi+uRRq7k3cjCva+TC
         /gbM9gqsBjG08pYmHZ0Sk//O58DwakPe98fKSFNjv1JKtyvVuqWbN/bCVlRoBD9ZfvrH
         7TtHo/UXwoSTIJdiPHYyvYm1lZfSdFNT/60LANRNOQn/bW7mwgWOA8ZhGyCRUKWW+hfw
         3tXg==
X-Gm-Message-State: AOAM532rHW1hWlfdybb7J/ezdpOpgr7PKhAEu//IdapawNoyYyQ7Roby
        vcK+9b3eI80qwQkz/AeW4A9WA8oBuTN8+bwPBan74A==
X-Google-Smtp-Source: ABdhPJz17XodqRPhi9pi5lxUK762RIT74/Y0FHO9sf4tNUhHNegjqQggEcRgmlnLHME079dP6RCEBi4Afxi+QYxidQU=
X-Received: by 2002:a17:902:c3c1:: with SMTP id j1mr960276plj.179.1589500040518;
 Thu, 14 May 2020 16:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200508182835.228107-1-ndesaulniers@google.com>
 <20200508183230.229464-1-ndesaulniers@google.com> <CAMzpN2hUQwGoYQnsKZJHFY=p-=-zXTwhRnCejhoztCvPX8e=CA@mail.gmail.com>
In-Reply-To: <CAMzpN2hUQwGoYQnsKZJHFY=p-=-zXTwhRnCejhoztCvPX8e=CA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 May 2020 16:47:08 -0700
Message-ID: <CAKwvOdmPEVAVkKUYwojnvANCFJ27WF8Z3W75fC3OaWMDBL=7-g@mail.gmail.com>
Subject: Re: [PATCH v5] x86: bitops: fix build regression
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
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
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bumping for this to get reviewed+picked up.  Fixes a regression I
would prefer didn't ship in 5.7.

On Mon, May 11, 2020 at 11:52 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Fri, May 8, 2020 at 2:32 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > This is easily reproducible via CC=clang+CONFIG_STAGING=y+CONFIG_VT6656=m.
> >
> > It turns out that if your config tickles __builtin_constant_p via
> > differences in choices to inline or not, these statements produce
> > invalid assembly:
> >
> > $ cat foo.c
> > long a(long b, long c) {
> >   asm("orb\t%1, %0" : "+q"(c): "r"(b));
> >   return c;
> > }
> > $ gcc foo.c
> > foo.c: Assembler messages:
> > foo.c:2: Error: `%rax' not allowed with `orb'
> >
> > Use the `%b` "x86 Operand Modifier" to instead force register allocation
> > to select a lower-8-bit GPR operand.
> >
> > The "q" constraint only has meaning on -m32 otherwise is treated as
> > "r". Not all GPRs have low-8-bit aliases for -m32.
> >
> > Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/961
> > Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
> > Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers
> > Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Reported-by: kernelci.org bot <bot@kernelci.org>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Suggested-by: Brian Gerst <brgerst@gmail.com>
> > Suggested-by: H. Peter Anvin <hpa@zytor.com>
> > Suggested-by: Ilie Halip <ilie.halip@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reviewed-By: Brian Gerst <brgerst@gmail.com>



-- 
Thanks,
~Nick Desaulniers
