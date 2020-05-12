Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B95DC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B9220747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCFA2dV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgELWBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:01:08 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA22FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:01:08 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k133so19459155oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r919tpUIjzuRxoZ5Yps7DZLSIsY9ElfTOSP9gLEZ7kQ=;
        b=LCFA2dV/bKYR0BKsqQ8kFfzVjfHymn4z2cMpX14C3LKyYdrNCqR9q7ID8oIadZyjED
         d9/c6yOHMCwnMfLcE0DEZ/1kly4vLn0Le5UU9VdkQm+wdTylJrQTLczJrIxXvS0VQDVJ
         lCgOKXTJBS/4tf2KVmJ4g6CoiiW0xbo64nuWLUBtMeNeQq/mYNq9+DBuihXzB6UopYV8
         5WH8B9ZWa44MX9L1CF0YR2CutPo/4Oc1xQ9Df2r29y22uLa23ZooQFfcLy0xbhs1C3t4
         n8xqR6hYSLaPKUDskvQ5n7ivrRlNUHgtKy4Rd0GkvT0YwdhaE+Ar9fUxzuN5D8S82RSb
         1hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r919tpUIjzuRxoZ5Yps7DZLSIsY9ElfTOSP9gLEZ7kQ=;
        b=G1/m1CnrAWp3PA5wPtbkHEIgOOTNm5syo14uS6q3DrkC0fzldAy6Ldd4+YokcVEU34
         BGt36qr6YlTPITxWzxtZYurE00R68rmlT116rObLHrcu/+6oBcMgF5lsF50zhUZLho7r
         w1WS4JGfw0oPPdHedSFbJCUDkEciDDAMmrE1amHpdzwU/lmsamLTY5BZMMXlS1/2Aiu2
         cRA4lirovVvOFhsje2VqDLZngOcohnKPsu6DpN3S4kB2miKH/+tR1vlvsfyCqPWKuxnj
         gT6SiQ/D4Eo5wEL410Iq3UWDyI746rCnjGiLWjNnStMds+F+CSK0mA1D+EoeurRBTlDl
         tc3w==
X-Gm-Message-State: AGi0PuYsN9iHlupxiQv5CIMZ6inYJ5JZCGwai8g7862eflvluDbgWGVV
        wIQ7/kQx4YPyeiEh9NYC4MaUEucBDQ0gwybiYax+uA==
X-Google-Smtp-Source: APiQypL2SnQbUeabl9l8uEGMle0NuS3JyDkzveSMnaCxixp1eTsVQhvXkDHCGhBjPfjlT/eizYYajAszV4YKVTrlsII=
X-Received: by 2002:aca:3254:: with SMTP id y81mr4949358oiy.172.1589320867527;
 Tue, 12 May 2020 15:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-1-will@kernel.org> <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net> <20200512211450.GA11062@willie-the-truck>
In-Reply-To: <20200512211450.GA11062@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 May 2020 00:00:55 +0200
Message-ID: <CANpmjNM6Q+ucPtoDMYanc_n17DCaZ7mkGCWk+CepBSKQXQsvLQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 23:15, Will Deacon <will@kernel.org> wrote:
>
> On Tue, May 12, 2020 at 09:07:55PM +0200, Peter Zijlstra wrote:
> > On Tue, May 12, 2020 at 07:53:00PM +0200, Marco Elver wrote:
> > > I just ran a bunch of KCSAN tests. While this series alone would have
> > > passed the tests, there appears to be a problem with
> > > __READ_ONCE/__WRITE_ONCE. I think they should already be using
> > > 'data_race()', as otherwise we will get lots of false positives in
> > > future.
> > >
> > > I noticed this when testing -tip/locking/kcsan, which breaks
> > > unfortunately, because I see a bunch of spurious data races with
> > > arch_atomic_{read,set} because "locking/atomics: Flip fallbacks and
> > > instrumentation" changed them to use __READ_ONCE()/__WRITE_ONCE().
> > > From what I see, the intent was to not double-instrument,
> > > unfortunately they are still double-instrumented because
> > > __READ_ONCE/__WRITE_ONCE doesn't hide the access from KCSAN (nor KASAN
> > > actually). I don't think we can use __no_sanitize_or_inline for the
> > > arch_ functions, because we really want them to be __always_inline
> > > (also to avoid calls to these functions in uaccess regions, which
> > > objtool would notice).
> > >
> > > I think the easiest way to resolve this is to wrap the accesses in
> > > __*_ONCE with data_race().
> >
> > But we can't... because I need arch_atomic_*() and __READ_ONCE() to not
> > call out to _ANYTHING_.
> >
> > Sadly, because the compilers are 'broken' that whole __no_sanitize thing
> > didn't work, but I'll be moving a whole bunch of code into .c files with
> > all the sanitizers killed dead. And we'll be validating it'll not be
> > calling out to anything.
>
> Hmm, I may have just run into this problem too. I'm using clang 11.0.1,
> but even if I do something like:
>
> unsigned long __no_sanitize_or_inline foo(unsigned long *p)
> {
>         return READ_ONCE_NOCHECK(*p);
> }
>
> then I /still/ get calls to __tcsan_func_{entry,exit} emitted by the
> compiler. Marco -- how do you turn this thing off?!

For Clang we have an option ("-mllvm
-tsan-instrument-func-entry-exit=0"), for GCC, I don't think we have
the option.

I had hoped we could keep these compiler changes optional for now, to
not require a very recent compiler. I'll send a patch to enable the
option, but keep it optional for now. Or do you think we require the
compiler to support this? Because then we'll only support Clang.

> I'm also not particularly fond of treating __{READ,WRITE}ONCE() as "atomic",
> since they're allowed to tear and I think callers should probably either be
> using data_race() explicitly or disabling instrumentation (assuming that's
> possible).

That point is fair enough. But how do we fix arch_atomic_{read,set} then?

Thanks,
-- Marco
