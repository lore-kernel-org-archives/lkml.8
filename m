Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403A5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114E92076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZe6HvY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHRT6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHRT6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:58:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FDFC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:58:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so10235465pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqU4BC6tUsjcEJr/U162KnXra6DrJvlD2KShIytlY2w=;
        b=gZe6HvY1Wn42oNIPkZd4GNzugvaoW6QAFKJSoN2USbuUhs41Zmmkn//dVKTG2hBMKx
         sqRaPKIoE6CHWVmyUXbOjRbQp7bxKJYri+lGyRLBCp9+FCMq3OSBhtJdR38FJvkNxY2G
         fUUbwsksChQSG1szN7bcyXVdhRqqIAVmg1dI17DlFtBdfl7ACmXH3tCYGXPIMOy7oa1D
         QNY+GXXaF2//a/9q4c/0+YsRQ8k5VOU8/+cheazCez+doO5RSykpudD0MY9/I0qq/D5K
         UmFgyuH0c5Rm5NOHG1YTL7fC0FWlxFrt1p5hz9/SREiX5H8ix8uuAq5L8+ItRqCXyNB5
         8JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqU4BC6tUsjcEJr/U162KnXra6DrJvlD2KShIytlY2w=;
        b=L1VzH13LD7N0sLQICGyj/HMjxTz5YnX7dXU/3OoOilyHENzbrt4MIRhIG7sviuQHdC
         rSF413kqgl3I5f+eD5JTK0db1amkdIG98dixmAzKB4G1owxznQcDsQVvWRUpdEK2NbUq
         x7P1/Cv5gx26s9gkXHFf7XDhL0+/ivbgjyUICBriyX7EjThnRoE0VO5bqaah879PPZJP
         Zu1TpOXPR9TbXJkCnQi5eG82eCTIh1r2K7Yfif9uVHV1OANSQFl/Rb+JgLNCt9XtN7BG
         0DIqHwbAznInQ3TjKB46w+9wGNVCfqfO4Q913hmgTFd1+vlZGBR/r7oe30xoUoodMPVx
         oE+g==
X-Gm-Message-State: AOAM531K6Q+H613TQvqp1NA0n8/u5T/yWyrZpyzX1zohxMsvsFhFBe3v
        4VsNXrw97WUaxa3ijSwktjoTp301eoprFkuSgHe1lA==
X-Google-Smtp-Source: ABdhPJwO1H28Renw4sheYoT/T62OSLiGKOqyNNgG/FD33zAIxlVPXiFK7uQV/CTYYHmAfH5BnhE+eVFhR4uixQa8NYQ=
X-Received: by 2002:aa7:96e5:: with SMTP id i5mr13553753pfq.108.1597780719010;
 Tue, 18 Aug 2020 12:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com> <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
 <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com> <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
 <CAKwvOdkut+GTLxX9U=hxDC8SaugW487XD_98d9yFU2VzShyz0A@mail.gmail.com>
In-Reply-To: <CAKwvOdkut+GTLxX9U=hxDC8SaugW487XD_98d9yFU2VzShyz0A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Aug 2020 12:58:27 -0700
Message-ID: <CAKwvOdkJxmSXg+v1pG4+DkhoJzEE47smce6pB=Zhy6viY_++xw@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Clement Courbet <courbet@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
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
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Aug 18, 2020 at 12:19 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Aug 18, 2020 at 12:03 PM H. Peter Anvin <hpa@zytor.com> wrote:
> > >
> > > I'm not saying "change the semantics", nor am I saying that playing
> > > whack-a-mole *for a limited time* is unreasonable. But I would like to go back
> > > to the compiler authors and get them to implement such a #pragma: "this
> > > freestanding implementation *does* support *this specific library function*,
> > > and you are free to call it."
> >
> > I'd much rather just see the library functions as builtins that always
> > do the right thing (with the fallback being "just call the standard
> > function").
> >
> > IOW, there's nothing wrong with -ffreestanding if you then also have
> > __builtin_memcpy() etc, and they do the sane compiler optimizations
> > for memcpy().
> >
> > What we want to avoid is the compiler making *assumptions* based on
> > standard names, because we may implement some of those things
> > differently.

That's asking for trouble; please don't implement routines with
identifiers from libc but with differing function signatures, and then
proceed to *not* use -ffreestanding.  You can't have it both ways
(optimizations from *not* using -ffreestanding, then breaking all
kinds of assumptions based on conventions used across userspace), at
least not with the tools you currently have.

> >
> > And honestly, a compiler that uses 'bcmp' is just broken. WTH? It's
> > the year 2020, we don't use bcmp. It's that simple. Fix your damn
> > broken compiler and use memcmp. The argument that memcmp is more
> > expensive than bcmp is garbage legacy thinking from four decades ago.
> >
> > It's likely the other way around, where people have actually spent
> > time on memcmp, but not on bcmp.
> >
> > If somebody really *wants* to use bcmp, give them the "Get off my
> > lawn" flag,

I wrote a paper in college on the philosophy and symbolism in "Gran
Torino."  Would recommend (the movie, not the paper).

> > and leave them alone. But never ever should "use bcmp" be
> > any kind of default behavior. That's some batshit crazy stuff.
> >
> >                Linus
>
> You'll have to ask Clement about that.  I'm not sure I ever saw the
> "faster bcmp than memcmp" implementation, but I was told "it exists"
> when I asked for a revert when all of our kernel builds went red.

Also, to Clement's credit, every patch I've ever seen from Clement is
backed up by data; typically fleetwide profiles at Google.  "we spend
a lot of time in memcmp, particularly comparing the result against
zero and no other value; hmm...how do we spend less time in
memcmp...oh, well there's another library function with slightly
different semantics we can call instead."  I don't think anyone would
consider the optimization batshit crazy given the number of cycles
saved across the fleet.  That an embedded project didn't provide an
implementation, is a footnote that can be fixed in the embedded
project, either by using -ffreestanding or -fno-builtin-bcmp, which is
what this series proposes to do.
-- 
Thanks,
~Nick Desaulniers
