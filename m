Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7147C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F7E206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTiKrsJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgEKTe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729453AbgEKTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:34:59 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30952C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:34:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b71so2975220ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxzW0ANI9kIQTWoAt3YTFrrJiXpICLFsuHzSz+FA2EI=;
        b=ZTiKrsJONnsTSzo4B5O6rFXU7drWFH6rv9O8IHjFYu0TO9LPJ4kSiKlVFjAyJq0ddm
         2eUKt3CJ1kqc0+UtjAouPdI9d1l4IIlEH0mJANA31mCNJoXrSHSVA5FOJU2J8sC46mO0
         W40T38zInvJHbdHIKz7W7FNYELyiXQMYcYGDsWbr0vKzp3Ozek2q6OvVK7pTwajPTWgG
         ktChwxEKgsFTtcKWbqmPZVS5l7zEdFmmvGXadz5Q7NcTkNX8BNv6hzUXyzRSgpN4bkh9
         mI6DMlVPm+6q5j6N/INjZ7zHrTXS3tjFaqX8qHMKB5rjc48BeIXzp9Hy28a2ODirhcY6
         2Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxzW0ANI9kIQTWoAt3YTFrrJiXpICLFsuHzSz+FA2EI=;
        b=AKV6hgf/Ya03nilV8ZpElMpINDFcRG9hyb6OO5pGWfxVk/VcR/H4mLrJTDI7tvGw/Y
         5TC+TyIRarwCArw/VqdimssnCawU6ovFgB+iI1q1jtCqohrsiNSiFj+ub1n9QAS35+o3
         4h/HNzDb3vsSiPaJhdUB2LkWhO9s49jwf1gJzp21I7ndJio6rBeEKxUv97SV2fp0uOBb
         vlW26mJYKY457jIFwTpFYO7ak/RSZpdxrsmS08NFKQlVgC2DfWhlvWDy72KGgy6bxGz6
         +qkWTJ+fJ2Y0vaJ5AlehWc5IGkOh4Ym1MQL2J2oUeaCNOVVQx2mOOwiKpTCPy77bE2zA
         In8A==
X-Gm-Message-State: AGi0Pua7DlFNYoCUjVVxCDrG4zx3q26rBMrdaLZ7nQ9bQLhLJ1CBa1Kr
        5oRQFv+zVnnB5EKsat6WAEaoll/aZCTkQvgAYw==
X-Google-Smtp-Source: APiQypK6h82ghOPKtxrcGp8Ap4m53spUzcW1S5Jhvm9YDUCy/KCFVFvZ/pll2plAL5UVf4fuTc4X/rgSemQ3zmJokJk=
X-Received: by 2002:a92:bf06:: with SMTP id z6mr16608400ilh.191.1589225698562;
 Mon, 11 May 2020 12:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
 <CAMzpN2iDottAY3p=GS0A_7XX7bpmWsmSOEcztMXNEEvcwHirjg@mail.gmail.com> <CAKwvOdnxV_KwC-q73e3basJvo4-9FCGeMUOrZLj5xyt6Yyeh2A@mail.gmail.com>
In-Reply-To: <CAKwvOdnxV_KwC-q73e3basJvo4-9FCGeMUOrZLj5xyt6Yyeh2A@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 11 May 2020 15:34:47 -0400
Message-ID: <CAMzpN2gTEwGh0U+L3_R6pC8Qmv1iY7bRTiTEXD86mF3u9Nnkqg@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 2:46 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, May 11, 2020 at 11:09 AM Brian Gerst <brgerst@gmail.com> wrote:
> > This looks like the same issue that we just discussed for bitops.h.
> > Add the "b" operand size modifier to force it to use the 8-bit
> > register names (and probably also needs the "w" modifier in the 16-bit
> > case).
>
> While it does feel familiar, it is slightly different.
> https://godbolt.org/z/Rme4Zg
> That case was both compilers validating the inline asm, yet generating
> assembly that the assembler would choke on.  This case is validation
> in the front end failing.

> long long ret;
> switch (sizeof(ret)) {
> case 1:
>         asm ("movb $5, %0" : "=q" (ret));
>         break;
> case 8:;
> }

So if the issue here is that the output variable type is long long,
what code is using a 64-bit percpu variable on a 32-bit kernel?  Can
you give a specific file that fails to build with Clang?  If Clang is
choking on it it may be silently miscompiling on GCC.

--
Brian Gerst
