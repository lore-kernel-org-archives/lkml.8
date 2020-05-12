Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB50AC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76DF20740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVt1sse/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgELUfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731204AbgELUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:35:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C6C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:35:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so6349532pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fA+SFwBMG0B5q95uQj1Y/25AozYOQi3LQJpnB/wY8BA=;
        b=dVt1sse/36kMvyQZ7SdShYsjAHg2CeZhz7Zucj1eJ6xyjAZoaG7YXH9LVJTofoiHoJ
         Fn/kXQ8xNwJfVW+qX58+1aopWn5WBOVaM5vMUPbpLCsqYJ0ESQjtV0cF4/2UVGcAjyPV
         54tfeSq01hKoj+TnT66yYB5mVPEdWWaCRWVjttK9Stb8BfJLH2IlJCOZWKflZt65eCY+
         ronz3+RQOuNIHdojaZ3ED0chh13WJKch96qCwmAPkP80djafLZkkBZ9qGt175uE9ENQ7
         HW9ldYLxe2nNbwm0+SOC/5qgSv9GvYIEcI+Q0rwWuR94sIJcS+V4j45gD7epInhggPA5
         oLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fA+SFwBMG0B5q95uQj1Y/25AozYOQi3LQJpnB/wY8BA=;
        b=Le4N2TH4anIMflkW3GiF3a6OBFWlmjuVivfWwgYWyl/JIXpkD9d41r063mkR6erd1Q
         g4CneCSiqa5nhdShDUbJNeMbZfZihTw+F+XQ0scPydlaM3F63lUMbKae5ywyRLfUzMsh
         zF3S+wgrCG10FvGZXoegso6SEFkkXHylOBZFigNaE1Fv9DyQ4hvaZ1wknXgP3Lp7mfqZ
         sFJ5QUVeeJ2mJR7OGuZy84qsc/5uwn1cKoiO7ktidVVmEEHD2ro3+w/b1HcWdktSCyrv
         jH0iv9nWZ3c6FRo6Qm2lU3fkKW2XAffR1k/4NKQQXLl7yAWcQHGu98NuLd9+MXO1YJOO
         LorQ==
X-Gm-Message-State: AGi0Pubh9JKQVKc63Nt3GaSom8H1tdgu2dah6F4L0a+P72xRSGdMS8GK
        3QoL2UNjUf09TmEsW0AaWiNO9to2Q5x0Jn2RwX5kkw==
X-Google-Smtp-Source: APiQypJ6H41fh6onW8zLe/xPsIRxIYgPQLe97qrmScd1PFD/ibLLGVNGbydoWQ9fnurxECNed/aKgdLkiVSAWynH4nA=
X-Received: by 2002:a65:5b84:: with SMTP id i4mr21863134pgr.263.1589315745789;
 Tue, 12 May 2020 13:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
 <CAHk-=wif=_ZomkWJAmQRCUAMHQ72V3NEQ-OteiPE56K7KoSjbQ@mail.gmail.com>
 <CAHk-=whhCBvjXtRiFM2JEZ4XyBmuPprvdo5tpPVBqUhkRszxiQ@mail.gmail.com>
 <CAKwvOdn06jCe_FhKiF_wSQavytVVD++RXD-bHbMdqnEA-wO-9w@mail.gmail.com>
 <CAHk-=wh8zOnTN17XcGfnfihGgM5R5XG71qP+V54iLqBgZON4hw@mail.gmail.com> <7fa3a927ff63ca2f6587cfbac0ac76d2c11c4b5f.camel@infradead.org>
In-Reply-To: <7fa3a927ff63ca2f6587cfbac0ac76d2c11c4b5f.camel@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 May 2020 13:35:34 -0700
Message-ID: <CAKwvOdmT4Yp40sG9CTYRjke02ddhE=LoYPkHOzOX0e-sP9gKLA@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Mon, May 11, 2020 at 1:03 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Mon, 2020-05-11 at 13:01 -0700, Linus Torvalds wrote:
> > On Mon, May 11, 2020 at 12:52 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Interesting approach.  Researching __builtin_choose_expr, it looks
> > > like it was cited as prior art for C11's _Generic keyword.
> >
> > Well, the thing that made me think that __builtin_choose_expr() would
> > work is that unlike the switch statement, you absolutely _have_ to do
> > the choice in the front end. You can't leave it as some kind of
> > optimization for later phases, because the choice od expression ends
> > up also determining the type of the result, so it isn't just a local
> > choice - it affects everything around that expression.
> >
> > But clang still doesn't like that "qi" constraint with a (non-chosen)
> > expression that has a "u64" type.
> >
> > I guess we can take the stupid extra cast, but I think it would at
> > least need a comment (maybe through a helper function) about why "qi"
> > needs it, but "ri" does not, and why the cast to "unsigned long" is
> > needed, even though "clearly" the type is already just 8 bits.
> >
> > Otherwise somebody will just remove that "obviously pointless" cast,
> > and gcc will eat the result happily, and clang will fail.
>
> I'm also mildly concerned that LLVM will start to whine about the 'ri'
> case too. It's odd that it doesn't, even when GCC does.

Ah, sorry, it took me a while to understand what case you meant by
this.  I recall you pointing this out previously in
https://bugs.llvm.org/show_bug.cgi?id=33587#c16, but at the time I
simply wasn't well versed enough in inline asm to understand.  The
case you're referring to is 64b operands, "r" constraint, -m32 target.
Yes, if I fix that: https://reviews.llvm.org/D79804, then this whole
patch needs to be reworked.  Back to the drawing board.
-- 
Thanks,
~Nick Desaulniers
