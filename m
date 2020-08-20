Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CB1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74372072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597966797;
	bh=n2QAn/1goPcaeLKMigsmYp49bNsUT4+qrLnO9GT9XiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fFJb5ym4BoJXV21KkZZppkAqXBJDGPkjq/7hg6ALUl3X2QHL/S8qPfrBiNncS7BTv
	 FdcrqmzrpsEjIIZr8BjdYI2imWMW7x+nSWHN3v8+oFAU5JsT0tqcojoeV+atSAYrEg
	 iduZHxZkcNJuWK96Ypkw/ZW2C3lYLiaOVCZxTSns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgHTXj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgHTXjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:39:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1DC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:39:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t6so3971995ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLsHxNY14nYfsmOcH0Wmsm+uJTY/HQXjErhm/+DBOIM=;
        b=UYwaeNYbl6ONJY+uj1aPnbq4RonZdvr6c0g/dIaT7MEKE5ZHlUPU1a0W9mzWMnnlq0
         LYCnfmFVjndAWdQCVMEuvCifSqbfjsZQFpLH3BhJhZEqpjbz+hc/gbmL/ktiyv9mbSaJ
         jade3mOlBkspOHfdEfYJQRJvz3EL50Yw/xHsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLsHxNY14nYfsmOcH0Wmsm+uJTY/HQXjErhm/+DBOIM=;
        b=sUJIrVmdpGPeJiZErlvXPD++a6uKLm9kf6YY/Hm8jJFzP3LilRKc6h2s4HMTsYcTKu
         JDlOi3/3m2dEQY/LctDFFkP2kHy/eIb2EMSXf1Snp0o+7LMaSTSAiQBo2L41skX+Dl7w
         JcsjB6AJOQm0+pVLkRB1LPtK3zcXVKNtz3mrcVpOy9qwHpo3cPx7MnzVFXR5Rg7+1d7G
         yP+Zbcel38nDPYeZdXRtUZJOVqJSb8xKc9/4zaJjuE3BbHl5jtCRgUc/v72Oma5eIaqS
         PvEwZdiJnv7D+T1mYyCDmjkkiMwKooumUDlQjKpb24LdZymTlP7UQGZkDOCkr7neTPPg
         RTDw==
X-Gm-Message-State: AOAM531Q6BzQtGeDtaCzJHrR8pU9mvk51lhHVh6/DgOPpoB2UWU21tgu
        O5GG+mfPfR2P/SAOx/dcT/IS7931gT2l3g==
X-Google-Smtp-Source: ABdhPJzSR5UMfebObxoRi/X8wzVcc1DF3jsa0Vlg8G7WmsmLqCNggHAh1NB6U8qxjaraLHokt2dzTw==
X-Received: by 2002:a2e:9ce:: with SMTP id 197mr168891ljj.369.1597966792872;
        Thu, 20 Aug 2020 16:39:52 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m15sm22974ljh.62.2020.08.20.16.39.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 16:39:52 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c15so45819lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:39:52 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr168592ljf.285.1597966399329;
 Thu, 20 Aug 2020 16:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com> <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
 <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com> <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
 <20200818202407.GA3143683@rani.riverdale.lan> <CAKwvOdnfh9nWwu1xV=WDbETGiabwDxXxQDRCAfpa-+kSZijb9w@mail.gmail.com>
 <CAKwvOdkA4SC==vGZ4e7xqFG3Zo=fnhU=FgnSazmWkkVWhkaSYw@mail.gmail.com>
 <20200818214146.GA3196105@rani.riverdale.lan> <df6c1da4-b910-ecb8-0de2-6156dd651be6@rasmusvillemoes.dk>
 <20200820175617.GA604994@rani.riverdale.lan>
In-Reply-To: <20200820175617.GA604994@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Aug 2020 16:33:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn91ar+EbcBXQb9UXad00Q5WjU-TCB6UBzVba682a4ew@mail.gmail.com>
Message-ID: <CAHk-=whn91ar+EbcBXQb9UXad00Q5WjU-TCB6UBzVba682a4ew@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:56 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Clang's interpretation is more useful for embedded, since you can use
> -fno-builtin-foo and avoid calling __builtin_foo directly, and be
> guaranteed that there will be no calls to foo that you didn't write
> explicitly (outside of memcpy/memset/memcmp). In this case you are free
> to implement foo with non-standard semantics, or avoid implementing it
> altogether, and be reasonably confident that it will all work.

Honestly, I think concentrating on whether __builtin_foo() works or
not misses the point entirely.

That has never _ever_ been a problem for us, and I doubt it has been a
problem for anybody else either.

If you use __builtin_memcpy() in your source tree, then why would you
possibly ever want to disable it? And if you _don't_ use it, then
again - why would you ever want to disable it?

No, the real (and only) problem has always been about the compilers
magically and silently "recognizing" certain source patterns, and
turning them into function calls behind the users back.

And that has nothing to do with __builtin_foo(). At least it
_shouldn't_ have anything to do with it.

So this is things like the compiler silently seeing "oh, you called
your function 'free()', so we know that the stores you did to it are
dead and we'll remove them".

Or this is the compiler doing "Oh, you did four stores of zero in a
row, and and you asked for size optimizations, so we'll turn those
into a 'bzero()' call".

Or the compiler doing completely broken things, and turning a
"!memcmp()" expression into a "!bcmp()" because the compilier
incorrectly assumes it's faster.

Notice? Not a single one of those had any __builtin_xyz() pattern in
them. Quite the reverse. The compiler took something completely
different, and assumed builtin semantics without us having told it to.

So I think "-fno-builtin-xyz" is barking *completely* up the wrong
tree. It's missing the problem. The problem is not "I have some
builtin patterns, here, you can use them".

It's the same as all the vector intrinsics. Those don't hurt anybody -
as long as they only get used when people use the intrinsics. If the
compiler starts to suddenly use vector intrinsics without being told
to, *THAT* can be a problem. But there is never any reson to turn off
any particular intrinsic otherwise.

If you don't want it used, don't use it. And if you do use it, the
compiler generates the vector code sequence. It's that simple.

So to me, a compiler flag like "-fno-builtin-memcpy" is completely
insane. The flag adds absolutely no value.

The real value would be "-fno-magic-bcmp" which turns off stupid
optimizations that magically turn non-bcmp things into bcmp. But it
should not turn off *actual* __builtin_bcmp() if such a thing exists
and people want to explicitly use it.

             Linus
