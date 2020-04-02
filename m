Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4668C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704102077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585850808;
	bh=alBVDyMu6yCtRuUnJlivJHyajZdKZdi+gZB3M881sUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0GquEmxjspS51FXt/50iUxjMcqrOVbg31lZttfuQuNvqxgF+NXwiha6FgsbYMiOjM
	 yeTqYBme+jigzvqx5OvDmNBxFSHlrnzj7o56nlFlzIlnMSYGwKQy9MYdJdcnoUHlHy
	 WjD0hXzmVQJvARZd6nwds9Pv2Pc4UVCVElmj+iZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbgDBSGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:06:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38489 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:06:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id v16so4254988ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlBOg0dum66ebZmfIZrWlU1IBkKC8efn4oYc6hOU1L0=;
        b=hvEITigZV32UOF8ubiUjd+p22kCZAiMJFfBqDEEHBqM8+KyLyY3+cjtQPsswx+RUpm
         HJ1KgeDiJRSfzbkwXPk1cZ6pfQGvYJULSwuj6II4fCP3quqyDwcIFxIxB2CVRWFVsr87
         Cmk6cMB40cebsPRptNEHYRfJuiAA45R2UT23k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlBOg0dum66ebZmfIZrWlU1IBkKC8efn4oYc6hOU1L0=;
        b=Bg43PsJRSzAZCyexC793mcLueFY6WCiUhK35dOunM3J65IXE3s6dEURCO4zAfZo/eH
         vzSGVCp1qDEYTXjVmrIwoZmEPTeviz/hl4Tq9s1vkSxr7Z/krnf4gRnPVYK2vMxvBzsc
         AYHRhpqmRm1Cc9MG+Bka2FrA0jCoTRmj/xJapaCnmUZDY7+bN6rCjW56uXgtfnPKdst2
         sWf8og2bB3uNg9gC3SrIbt1T0pAsHI2q7t7KP8IPRJPGaTgRFxKYXy58endLvHnwpbWI
         BEyFhwM5E9IoBrhdpkgDz/LN3yY9fPl6u0U8iBgyYQ2Rk6gJi19U/WwyUZifKdDJNYp7
         WnYw==
X-Gm-Message-State: AGi0PuYeIwqVV811PUgGdUfK75uMDVkI8PBWnwqqFeCuzfVf8eXkj11Z
        FlaOi0gmVS2EVLUaDmlHywWUxhAtr40=
X-Google-Smtp-Source: APiQypIKLh20zRO3lbVrGh4D/zhV17sXEKqNfXbCESWv2GpxPYb/xk0nt+5bQXOi/qnleCgOQ7t1SA==
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr2785176ljm.201.1585850803940;
        Thu, 02 Apr 2020 11:06:43 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b4sm2063742lfo.36.2020.04.02.11.06.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:06:43 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id g27so4195928ljn.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:06:42 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr2793744ljj.265.1585850802219;
 Thu, 02 Apr 2020 11:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200324215049.GA3710@pi3.com.pl> <202003291528.730A329@keescook>
 <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org> <CAG48ez3nYr7dj340Rk5-QbzhsFq0JTKPf2MvVJ1-oi1Zug1ftQ@mail.gmail.com>
 <CAHk-=wjz0LEi68oGJSQzZ--3JTFF+dX2yDaXDRKUpYxtBB=Zfw@mail.gmail.com>
 <CAHk-=wgM3qZeChs_1yFt8p8ye1pOaM_cX57BZ_0+qdEPcAiaCQ@mail.gmail.com>
 <CAG48ez1f82re_V=DzQuRHpy7wOWs1iixrah4GYYxngF1v-moZw@mail.gmail.com>
 <CAHk-=whks0iE1f=Ka0_vo2PYg774P7FA8Y30YrOdUBGRH-ch9A@mail.gmail.com> <877dyym3r0.fsf@x220.int.ebiederm.org>
In-Reply-To: <877dyym3r0.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 11:06:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOS4Fi2tsXQrvLOiW69g4HiJYsqL6RPeTd14b4+2-Ykg@mail.gmail.com>
Message-ID: <CAHk-=wiOS4Fi2tsXQrvLOiW69g4HiJYsqL6RPeTd14b4+2-Ykg@mail.gmail.com>
Subject: Re: [PATCH] signal: Extend exec_id to 64bits
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jann Horn <jannh@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Adam Zabrocki <pi3@pi3.com.pl>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 6:14 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > tasklist_lock is aboue the hottest lock there is in all of the kernel.
>
> Do you know code paths you see tasklist_lock being hot?

It's generally not bad enough to show up on single-socket machines.

But the problem with tasklist_lock is that it's one of our remaining
completely global locks. So it scales like sh*t in some circumstances.

On single-socket machines, most of the truly nasty hot paths aren't a
huge problem, because they tend to be mostly readers. So you get the
cacheline bounce, but you don't (usually) get much busy looping. The
cacheline bounce is "almost free" on a single socket.

But because it's one of those completely global locks, on big
multi-socket machines people have reported it as a problem forever.
Even just readers can cause problems (because of the cacheline
bouncing even when you just do the reader increment), but you also end
up having more issues with writers scaling badly.

Don't get me wrong - you can get bad scaling on other locks too, even
when they aren't really global - we had that with just the reference
counter increment for the user signal accounting, after all. Neither
of the reference counts were actually global, but they were just
effectively single counters under that particular load (ie the count
was per-user, but the load ran as a single user).

The reason tasklist_lock probably doesn't come up very much is that
it's _always_ been expensive. It has also caused some fundamental
issues (I think it's the main reason we have that rule that
reader-writer locks are unfair to readers, because we have readers
from interrupt context too, but can't afford to make normal readers
disable interrupts).

A lot of the tasklist lock readers end up looping quite a bit inside
the lock (looping over threads etc), which is why it can then be a big
deal when the rare reader shows up.

We've improved a _lot_ of those loops. That has definitely helped for
the common cases. But we've never been able to really fix the lock
itself.

                 Linus
