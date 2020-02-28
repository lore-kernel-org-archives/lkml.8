Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C6C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692522468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDbxfYCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB1TAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:00:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37280 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1TAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:00:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so3580306otp.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3314c38kKdtMv4Y2j3OsEk0lExKN7QFZinFcFgHh+g=;
        b=CDbxfYCQGyLYWZXtgsAAzKZWocWuMGcNi3SI40M5Bs2P8Y5oTKGyA6Htu83Jq/QW2O
         8kGpjiBUEKQF+4XMwyDtl2dZb4moj9ZRjTy2XbbBKUqFQaLSNPNkDzwOR32B8jh5Gyug
         seOD10J8ng7s9gXr3u/yYqdMI51uaCsR3qZM3LqFB8KAGFvhi7sXf7HXhFCy9w5472pq
         2Hmc1jCRNO9eQF6iwB+FX61pE02zv26KUoTSV6nXrh3nMmd/+sHFSeEGCuHKrI3WlLA6
         SEprXY+Dm+nR9PdFpmMOh+pkxwmAVzBNeeu2cJQ0Ry3QhW+9VIvRNRO5xP9T7uKsU7XR
         TKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3314c38kKdtMv4Y2j3OsEk0lExKN7QFZinFcFgHh+g=;
        b=KQS1zLCozn+46/kivuG/VJ1XhDD32DunV0wKaIGhaL2gRGRcxAA5iWJSoZuijS9Miq
         Hyfca1frRRXEBuyoD0yA6xZmNSP76vnogtLMSPsfbVkpNHuPf+e4LvwNrWGPlUaDWYRM
         79f0wmEmFQwg+C/sZBkku50TnMH1CUCKhcWKWycT13ba8JdnKVCLKm65JXmxhYLeS7kv
         s3E9YEt9uubU0hNM6XBbjx0hqdjDLy2726kmTwDLZ7oDWo41r4IYxqSHfCaaW2mWfS/w
         u2yzAnT7tfCV+F00ZTpbtoxikMmNOJo6DeoPhkFfx2tjKzG+xd35fqIMONPn0Xq2BNXC
         lTyQ==
X-Gm-Message-State: APjAAAVmRu/YUeexHirlRdj0KMv0yrzY6Juk4lLh422n4qBW3cH3rlKV
        M9LB18ekauwUMbIbnSHVPL+f45MM+BZVCzY7ibduhg==
X-Google-Smtp-Source: APXvYqwg8MRlv4njFzQwXkgA6ADc+ZiNV2ucPm6a+G9ByS0YrGTiaLZlbRsx8h00OM/jbwF5zGSfvvfDb0g18MtYp3Y=
X-Received: by 2002:a9d:906:: with SMTP id 6mr2079998otp.251.1582916421150;
 Fri, 28 Feb 2020 11:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20200228164621.87523-1-elver@google.com> <Pine.LNX.4.44L0.2002281202230.1599-100000@iolanthe.rowland.org>
 <CANpmjNPHfZbBgyJu3hS2sGaN4G+F6_dfavW8Mn7ZmFj60Lb6hg@mail.gmail.com>
In-Reply-To: <CANpmjNPHfZbBgyJu3hS2sGaN4G+F6_dfavW8Mn7ZmFj60Lb6hg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 28 Feb 2020 20:00:09 +0100
Message-ID: <CANpmjNMOmirPRKbjX9=V+eZD-YsEvfhUU8r6EDefkOJTBLDYNQ@mail.gmail.com>
Subject: Re: [PATCH] tools/memory-model/Documentation: Fix "conflict" definition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 at 19:54, Marco Elver <elver@google.com> wrote:
>
> On Fri, 28 Feb 2020 at 18:24, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, 28 Feb 2020, Marco Elver wrote:
> >
> > > For language-level memory consistency models that are adaptations of
> > > data-race-free, the definition of "data race" can be summarized as
> > > "concurrent conflicting accesses, where at least one is non-sync/plain".
> > >
> > > The definition of "conflict" should not include the type of access nor
> > > whether the accesses are concurrent or not, which this patch addresses
> > > for explanation.txt.
> >
> > Why shouldn't it?  Can you provide any references to justify this
> > assertion?
>
> The definition of "conflict" as we know it and is cited by various
> papers on memory consistency models appeared in [1]: "Two accesses to
> the same variable conflict if at least one is a write; two operations
> conflict if they execute conflicting accesses."
>
> The LKMM as well as C11 are adaptations of data-race-free, which are
> based on the work in [2]. Necessarily, we need both conflicting data
> operations (plain) and synchronization operations (marked). C11's
> definition is based on [3], which defines a "data race" as:  "Two
> memory operations conflict if they access the same memory location,
> and at least one of them is a store, atomic store, or atomic
> read-modify-write operation. In a sequentially consistent execution,
> two memory operations from different threads form a type 1 data race
> if they conflict, at least one of them is a data operation, and they
> are adjacent in <T (i.e., they may be executed concurrently)."
>
> [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
> Programs that Share Memory", 1988.
>       URL: http://snir.cs.illinois.edu/listed/J21.pdf
>
> [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
> Multiprocessors", 1993.
>       URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
>
> [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
> Model", 2008.
>      URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
>
> > Also, note two things: (1) The existing text does not include
> > concurrency in the definition of "conflict".  (2) Your new text does
> > include the type of access in the definition (you say that at least one
> > of the accesses must be a write).
>
> Yes, "conflict" is defined in terms of "access to the same memory
> location and at least one performs a write" (can be any operation that
> performs a write, including RMWs etc.). It should not include
> concurrency. We can have conflicting operations that are not
> concurrent, but these will never be data races.
>
> > > The definition of "data race" remains unchanged, but the informal
> > > definition for "conflict" is restored to what can be found in the
> > > literature.
> >
> > It does not remain unchanged.  You removed the portion that talks about
> > accesses executing on different CPUs or threads.  Without that
> > restriction, you raise the nonsensical possibility that a single thread
> > may by definition have a data race with itself (since modern CPUs use
> > multiple-instruction dispatch, in which several instructions can
> > execute at the same time).
>
> Andrea raised the point that "occur on different CPUs (or in different
> threads on the same CPU)" can be interpreted as "in different threads
> [even if they are serialized via some other synchronization]".
>
> Arguably, no sane memory model or abstract machine model permits
> observable intra-thread concurrency of instructions in the same
> thread. At the abstract machine level, whether or not there is true
> parallelism shouldn't be something that the model concerns itself
> with. Simply talking about "concurrency" is unambiguous, unless the
> model says intra-thread concurrency is a thing.
>
> I can add it back if it helps make this clearer, but we need to mention both.
>
> > > Signed-by: Marco Elver <elver@google.com>
> > > ---
> > >  tools/memory-model/Documentation/explanation.txt | 15 ++++++---------
> > >  1 file changed, 6 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> > > index e91a2eb19592a..11cf89b5b85d9 100644
> > > --- a/tools/memory-model/Documentation/explanation.txt
> > > +++ b/tools/memory-model/Documentation/explanation.txt
> > > @@ -1986,18 +1986,15 @@ violates the compiler's assumptions, which would render the ultimate
> > >  outcome undefined.
> > >
> > >  In technical terms, the compiler is allowed to assume that when the
> > > -program executes, there will not be any data races.  A "data race"
> > > -occurs when two conflicting memory accesses execute concurrently;
> > > -two memory accesses "conflict" if:
> > > +program executes, there will not be any data races. A "data race"
> >
> > Unnecessary (and inconsistent with the rest of the document) whitespace
> > change.
>
> Reverted.
>
> > > +occurs if:
> > >
> > > -     they access the same location,
> > > +     two concurrent memory accesses "conflict";
> > >
> > > -     they occur on different CPUs (or in different threads on the
> > > -     same CPU),
> > > +     and at least one of the accesses is a plain access;
> > >
> > > -     at least one of them is a plain access,
> > > -
> > > -     and at least one of them is a store.
> > > +     where two memory accesses "conflict" if they access the same
> > > +     memory location, and at least one performs a write;
> > >
> > >  The LKMM tries to determine whether a program contains two conflicting
> > >  accesses which may execute concurrently; if it does then the LKMM says
> >
> > To tell the truth, the only major change I can see here (apart from the
> > "differenct CPUs" restriction) is that you want to remove the "at least
> > one is plain" part from the definition of "conflict" and instead make
> > it a separate requirement for a data race.  That's fine with me in
> > principle, but there ought to be an easier way of doing it.
>
> Yes pretty much. The model needs to be able to talk about "conflicting
> synchronization accesses" where all accesses are marked. Right now the
> definition of conflict doesn't permit that.
>
> > Furthermore, this section of explanation.txt goes on to use the words
> > "conflict" and "conflicting" in a way that your patch doesn't address.
> > For example, shortly after this spot it says "Determining whether two
> > accesses conflict is easy"; you should change it to say "Determining
> > whether two accesses conflict and at least one of them is plain is
> > easy" -- but this looks pretty ungainly.  A better approach might be to
> > introduce a new term, define it to mean "conflicting accesses at least
> > one of which is plain", and then use it instead throughout.
>
> The definition of "conflict" as used in the later text is synonymous
> with "data race".

Correction: it's "data race" minus "concurrent" which makes things
more difficult. In which case, fixing this becomes more difficult.

> > Alternatively, you could simply leave the text as it stands and just
> > add a parenthetical disclaimer pointing out that in the CS literature,
> > the term "conflict" is used even when both accesses are marked, so the
> > usage here is somewhat non-standard.
>
> The definition of what a "conflict" is, is decades old [1, 2]. I
> merely thought we should avoid changing fundamental definitions that
> have not changed in decades, to avoid confusing people. The literature
> on memory models is confusing enough, so fundamental definitions that
> are "common ground" shouldn't be changed if it can be avoided. I think
> here it is pretty trivial to avoid.
>
> Thanks,
> -- Marco
