Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EBDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C13217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uikBkA3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAUPIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:08:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38830 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgAUPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:08:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id l9so2828142oii.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sORnSh7V9XjzjlniDOWj1Q+C/fnBMkuk2ZbJfbkUnZI=;
        b=uikBkA3XWuiUqAuqjuD4vJoU7Y0e+UBkIRJrrJt781yThOkz0Dur1veCygtc716BPr
         QreYZDSWi32PCRuep2Q/nUHGfksWxONsfLhwa5oW5LKBZ//rt9rhu9fPW5YPNQ4pe1EJ
         Yd2t4fhwjY/dtnNM1e2CAsJU95sXeCsLb3xf4wPE+imOrpSoRXA3fQIOLyL/7Lp5BlLj
         wwsMuxMzT22zEvDFkYwU8/ynEkOJYjleOabMYL/KQ8HqfAMftMHcRHHD2TvGcbXOMC1/
         02ryIuVEN1fEMdb3kvjWAYzz53A9Brnd6uojhF/MAQpgH6zh3ROYx15IQNQily1Ghxmy
         WTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sORnSh7V9XjzjlniDOWj1Q+C/fnBMkuk2ZbJfbkUnZI=;
        b=fbVLNnYyHOyJn+EA75SIfsgZVJPxADiQxjUIymc8A2vdajLzJdjyADE19GeK9OpWPm
         rrUwXSCSCacwnz364cYFk3EsvZ+8deZRor8ZtaRyGGupCYg/v1G6O/jW2bot9nkrvvj7
         NVn9AnztaUAGhlzHlp34oJww05MOQHKrWt9M92LbBZyrrhXfalcTuqR4hxURjOlMicSH
         h1jRm2PqLFt0ThVJR9SXQWvNiIw7qhVxvI/PS6Qu38l2HA5PpCW11/ugtxRteEkObQQN
         tCMgVwOy1ujz5Ib60fvUIQl7ThOqVQWMzm4n09ap5o95kYvPPgTaN+es468ifXmbIjpB
         BvuQ==
X-Gm-Message-State: APjAAAXCFGOiNKRlq4GC92C0MdUIYjWrN9TW+QiMdZiwgOWIVZR90MpV
        ZA6xIC73qz4OC8HXwqB0CjUgLoojc/KuEHBJUsuO0w==
X-Google-Smtp-Source: APXvYqyxumxvZouMDyyag8HD3JUS4Ek3fy/D2qUN9iIljHceXFceVt/vtjZ51bR5XlMrOaYYsdewYXPRUl5utK8STbU=
X-Received: by 2002:aca:2112:: with SMTP id 18mr3156833oiz.155.1579619288271;
 Tue, 21 Jan 2020 07:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net> <20200120162725.GE2935@paulmck-ThinkPad-P72>
 <20200120165223.GC14914@hirez.programming.kicks-ass.net> <20200120202359.GF2935@paulmck-ThinkPad-P72>
 <20200121091501.GF14914@hirez.programming.kicks-ass.net> <20200121142109.GQ2935@paulmck-ThinkPad-P72>
 <20200121144716.GQ14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200121144716.GQ14879@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jan 2020 16:07:56 +0100
Message-ID: <CANpmjNNM_5=tBJhPdgGKbG6kaFpniyHZ1RyPypC-7qxEYBBkPA@mail.gmail.com>
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for bitops
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com,
        Kees Cook <keescook@chromium.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 at 15:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 21, 2020 at 06:21:09AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 21, 2020 at 10:15:01AM +0100, Peter Zijlstra wrote:
> > > On Mon, Jan 20, 2020 at 12:23:59PM -0800, Paul E. McKenney wrote:
> > > > We also don't have __atomic_read() and __atomic_set(), yet atomic_read()
> > > > and atomic_set() are considered to be non-racy, right?
> > >
> > > What is racy? :-) You can make data races with atomic_{read,set}() just
> > > fine.
> >
> > Like "fairness", lots of definitions of "racy".  ;-)
> >
> > > Anyway, traditionally we call the read-modify-write stuff atomic, not
> > > the trivial load-store stuff. The only reason we care about the
> > > load-store stuff in the first place is because C compilers are shit.
> > >
> > > atomic_read() / test_bit() are just a load, all we need is the C
> > > compiler not to be an ass and split it. Yes, we've invented the term
> > > single-copy atomicity for that, but that doesn't make it more or less of
> > > a load.
> > >
> > > And exactly because it is just a load, there is no __test_bit(), which
> > > would be the exact same load.
> >
> > Very good!  Shouldn't KCSAN then define test_bit() as non-racy just as
> > for atomic_read()?
>
> Sure it does; but my comment was aimed at the gripe that test_bit()
> lives in the non-atomic bitops header. That is arguably entirely
> correct.

I will also point out that test_bit() is listed in
Documentation/atomic_bitops.txt.  What I gather from
atomic_bitops.txt, is that the semantics of test_bit() is simply an
unordered atomic operation: the interface promises that the load will
be executed as one indivisible step, i.e. (single-copy) atomically
(after compiler optimizations etc.).

Although at this point probably not too important, I checked Alpha's
implementation of test_bit(), and there is no
smp_read_barrier_depends(). Is it safe to say that test_bit() should
then be weaker in terms of ordering than READ_ONCE()?

My assumption was that test_bit() is as strong as READ_ONCE().

Thanks,
-- Marco
