Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03724C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D085320721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590056559;
	bh=YDVhiTqdw9h91cNgg9IDJt6mrZsY5vOL0/OFq87+awo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eBG+4uFttVKkyPceQZsbhMA/D4GU7v8zgz6+q9407R0DqjFILHkMA/m4VgzDS9OWr
	 rTr8YivjGxy2vMLkYIdZyghNI5EV/5/e5hQWkd0HDyIjNNPLeHWrUcNkiZF1sZEBSB
	 Xdxk5H24fjm8d+KTyYMa2D0Eba/VS6/8HXQFr6Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgEUKWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgEUKWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:22:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB3720721;
        Thu, 21 May 2020 10:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590056539;
        bh=YDVhiTqdw9h91cNgg9IDJt6mrZsY5vOL0/OFq87+awo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sb5C65+dwKXXpHua1CujvupmKZV57PUlQU8D82rqCVCbPvsMumOwdL77sh6IsLMMs
         v7ll+ydBZUDEV1K09drPV1jseA2v09Q3E3M10VYGZVvgJSUbTZ5Z5mVh/+fBcOF3u1
         yjUM5U+fEu6uAwzhR/LxMsgjo0lFq/zMdc5GmK4k=
Date:   Thu, 21 May 2020 11:22:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH -tip 08/10] READ_ONCE, WRITE_ONCE: Remove data_race()
 wrapping
Message-ID: <20200521102214.GC5360@willie-the-truck>
References: <20200515150338.190344-1-elver@google.com>
 <20200515150338.190344-9-elver@google.com>
 <CANpmjNNdBrO=dJ1gL+y0w2zBFdB7G1E9g4uk7oDDEt_X9FaRVA@mail.gmail.com>
 <CANpmjNPLVMTSUAARL94Pug21ab4+zNikO1HYN2fVO3LfM4aMuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPLVMTSUAARL94Pug21ab4+zNikO1HYN2fVO3LfM4aMuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:18:14PM +0200, Marco Elver wrote:
> On Thu, 21 May 2020 at 11:47, Marco Elver <elver@google.com> wrote:
> > On Fri, 15 May 2020 at 17:04, Marco Elver <elver@google.com> wrote:
> > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > index 17c98b215572..fce56402c082 100644
> > > --- a/include/linux/compiler.h
> > > +++ b/include/linux/compiler.h
> > > @@ -229,7 +229,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > >  #define __READ_ONCE_SCALAR(x)                                          \
> > >  ({                                                                     \
> > >         typeof(x) *__xp = &(x);                                         \
> > > -       __unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));  \
> > > +       __unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);             \
> > >         kcsan_check_atomic_read(__xp, sizeof(*__xp));                   \
> >
> > Some self-review: We don't need kcsan_check_atomic anymore, and this
> > should be removed.
> >
> > I'll send v2 to address this (together with fix to data_race()
> > removing nested statement expressions).
> 
> The other thing here is that we no longer require __xp, and can just
> pass x into __READ_ONCE.
> 
> > >         smp_read_barrier_depends();                                     \
> > >         (typeof(x))__x;                                                 \
> > > @@ -250,7 +250,7 @@ do {                                                                        \
> > >  do {                                                                   \
> > >         typeof(x) *__xp = &(x);                                         \
> > >         kcsan_check_atomic_write(__xp, sizeof(*__xp));                  \
> >
> > Same.
> 
> __xp can also be removed.
> 
> Note that this effectively aliases __WRITE_ONCE_SCALAR to
> __WRITE_ONCE. To keep the API consistent with READ_ONCE, I assume we
> want to keep __WRITE_ONCE_SCALAR, in case it is meant to change in
> future?

Ha! So I think this ends up being very similar to what I had *before* I
rebased onto KCSAN:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/tree/include/linux/compiler.h?h=rwonce/cleanup#n202

in which case you can drop __WRITE_ONCE_SCALAR; the _SCALAR things shouldn't
be used outside of the implementation anyway.

Will
