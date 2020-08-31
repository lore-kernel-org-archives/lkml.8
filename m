Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB816C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2702073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rkvm/zQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgHaXgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgHaXgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:36:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE22C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:36:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so1581723pfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q++3hnNQQLvnvTOiDVi/cUq71Wbo5ew4CsJzhsGozWY=;
        b=Rkvm/zQCxlMbLCCpfiYsXo41ukLbe/JWlDsSZGyK4kEHqne9HbvuVBv0jS9xVSwzun
         TWkwrs52PK+7d9J5ZxnrzKrxGXaCZy+pMajFjq4zVufL8RlA53Gs0/Me5OJwPTwLbfn4
         K4Jwq+flItCpWKwfcD7N5UN9rFtveyonTmSX89V7RaBA4vhUvpQS33f4hgsAH+/0CM3h
         EjmmH+02G47YHNgOjSm8XDnfHFQGBj14bzdGJxcJ4a6XjYeBye3DPS7HI8U64fgba6ag
         yeTGtJoFO5BIMIqoLUTl20Kk91VQ+Jw7WLxMuIDH+t3Hktg9UO2fvCmQ9cJ3gtot5+3r
         u2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q++3hnNQQLvnvTOiDVi/cUq71Wbo5ew4CsJzhsGozWY=;
        b=nT0R3sRBsvCvkyxWRdSjNmoYWNupZhlrG4GSWXtJKlm7oXFKlapohORKjQiITsSLdm
         wrlF/EljwLbnJ6QU8HBn9LcpJbob95CbRU7bx98c3Tw9LLy3vdWhKKLvItSTS93d5QCa
         jjWHW+FJn9oYCS5eDpgU0QDw2oMwkBGneunGEVgnw195xbcRCNEL8KqYd3h2jQvMUizC
         Lztswi+p/+pWG0oeQ8zxcK9/seNENec2CtO0IOCOABi3CtjAraBhVYfyijNEK1rFAijh
         zJg6KvouEw45IBudxbmVy4KWrZeQh2e3c6M6gMPFUa64LDZkv0dgZ7fDYcdiDhIdt4G4
         nvKg==
X-Gm-Message-State: AOAM533ny/n4nAsuWwAMKwScCNktfivwhJ0Mr4HkR7iNKRf2fwGfmVF8
        5taMRL6LSagVX3qGua2jxsdqz4hoUKgFtrlip4XIKw==
X-Google-Smtp-Source: ABdhPJxNurugrBLaCMipIWzwSsvonXD/0qQ5s7/oJDF73h/tYClicbXEI52KuB2IAyz9MugaLpdVj9ne7mwFGdOuSLk=
X-Received: by 2002:aa7:947b:: with SMTP id t27mr3282669pfq.240.1598916994333;
 Mon, 31 Aug 2020 16:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200826201420.3414123-1-ndesaulniers@google.com>
 <20200826214228.GB1005132@ubuntu-n2-xlarge-x86> <CAKwvOdkTN4BbVvwh8MPrVXERdHjQusmp9yAo09uW=698_fi0Fg@mail.gmail.com>
In-Reply-To: <CAKwvOdkTN4BbVvwh8MPrVXERdHjQusmp9yAo09uW=698_fi0Fg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Aug 2020 16:36:22 -0700
Message-ID: <CAKwvOdkRHY5pR8b81Zbp5xifcL+wYNeSv-gPsMXqsB-GEBqxQg@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 4:32 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Aug 26, 2020 at 2:42 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Aug 26, 2020 at 01:14:19PM -0700, Nick Desaulniers wrote:
> > > During Plumbers 2020, we voted to just support the latest release of
> > > Clang for now.  Add a compile time check for this.
> > >
> > > Older clang's may work, but we will likely drop workarounds for older
> > > versions.
> >
> > I think this part of the commit message is a little wishy-washy. If we
> > are breaking the build for clang < 10.0.1, we are not saying "may work",
> > we are saying "won't work". Because of this, we should take the
> > opportunity to clean up behind us and revert/remove parts of:
> >
> > 87e0d4f0f37f ("kbuild: disable clang's default use of -fmerge-all-constants")
> > b0fe66cf0950 ("ARM: 8905/1: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer")
> > b9249cba25a5 ("arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support")
> > 3acf4be23528 ("arm64: vdso: Fix compilation with clang older than 8")
>
> I'd prefer to see this land in mainline first; otherwise, I'm worried
> about this patch "racing" to mainline with those patches if they go
> via separate trees.  Thoughts?

Maybe I should send such a series (including Marco's recommendations)
to Mr. Morton or Yamada-san?
-- 
Thanks,
~Nick Desaulniers
