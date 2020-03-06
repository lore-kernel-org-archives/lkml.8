Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F4CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EAA206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osjh9JH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCFTCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:02:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35888 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCFTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:02:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id g12so1244475plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PG9kODOHccMTE4D+yCjI/R04MIPmgOaBfAQnemBNwSk=;
        b=osjh9JH2lwLf+Ar8vAHEbbX4gWGS+K3ge9AZiN6Uba/DtHJOx/XbdTaZcNDOs7hKWJ
         oR+k32Yi/TnSqHIsGLTC6uf6R76HHxnZWVPBQld6bmimbekLjqoue4EBOMGsuPEBqxhW
         T+1e3bToroCLVrjoZmicaEETChGlddG+3xTyxaPZFd3ckakWl6Dfz/7flTKWR7Ue6nrS
         Xk+YTVUUhny46tC+n7fCbrBq6C7BsyAY3IZ5WolugXg0JrRWPbvCY9HKk2GNxkTlj6vG
         wngIrcjtlNHpjCEZfNrNJkoHF4v8g9UxcBx3vnORGm7I8/a4KymZ0cqhmg8Pqq0UrCaF
         5pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PG9kODOHccMTE4D+yCjI/R04MIPmgOaBfAQnemBNwSk=;
        b=EENFJko/YTHPThv7qxHK28AbnzgPZ+yXTKMdfcNy0iy3wESKw7CUstR2dUKBsM6WTz
         edz6w8e6UjLSyDWm+f/CzzCWB6OqwG2213tA44HIzY3A7Bq45Ff3vRjXURclja+UDz8E
         KfaNonehk2OumCtRS2EDCyks95Subl8R2tzYYWU996M1lBB1kyXdNN9Q2YG694PjMjUT
         NuXUT0TnwZdNp0FSeAmEnDqVgEWAQy09PeCXkqc9aCdqQXUrjsHWHudtCX2mntF7NxTk
         2S1zAJAXsHV/u/J0m6CFqLOttoUOLFdHBSj7vj13IjDbY6YNqWbEUTFczfavaDNxuUcx
         XRTw==
X-Gm-Message-State: ANhLgQ04r5d4gTq7wnP6i9/yK7VZBlZDa4H0y+uT01SEKhmyJgmiC2OG
        +myiNVJjYeB7RQ1o1rX6oSzv5Zx06Hp7/jueK+/yNA==
X-Google-Smtp-Source: ADFU+vs73m2x2g1SsUpQWXDbd5GgyX6qOVtUINb4OWJZFi11F+p4/hFXPb/WA5/tKYu0UolMKSuI8KPbncznEdL7sFk=
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr5132336pja.27.1583521342662;
 Fri, 06 Mar 2020 11:02:22 -0800 (PST)
MIME-Version: 1.0
References: <1583509304-28508-1-git-send-email-cai@lca.pw> <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
 <a7503afc9d561ae9c7116b97c7a960d7ad5cbff9.camel@perches.com> <442b7ace85a414c6a01040368f05d6d219f86536.camel@perches.com>
In-Reply-To: <442b7ace85a414c6a01040368f05d6d219f86536.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Mar 2020 11:02:11 -0800
Message-ID: <CAKwvOdmdaDL4bhJc+7Xms=f4YXDw-Rr+WQAknd0Jv6UWOBUcEA@mail.gmail.com>
Subject: Re: [PATCH] sched/cputime: silence a -Wunused-function warning
To:     Joe Perches <joe@perches.com>
Cc:     Qian Cai <cai@lca.pw>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 10:39 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-03-06 at 09:25 -0800, Joe Perches wrote:
> > On Fri, 2020-03-06 at 09:13 -0800, Nick Desaulniers wrote:
> > > On Fri, Mar 6, 2020 at 7:42 AM Qian Cai <cai@lca.pw> wrote:
> > > > account_other_time() is only used when CONFIG_IRQ_TIME_ACCOUNTING=y (in
> > > > irqtime_account_process_tick()) or CONFIG_VIRT_CPU_ACCOUNTING_GEN=y (in
> > > > get_vtime_delta()). When both are off, it will generate a compilation
> > > > warning from Clang,
> > > >
> > > > kernel/sched/cputime.c:255:19: warning: unused function
> > > > 'account_other_time' [-Wunused-function]
> > > > static inline u64 account_other_time(u64 max)
> > > >
> > > > Rather than wrapping around this function with a macro expression,
> > > >
> > > >  if defined(CONFIG_IRQ_TIME_ACCOUNTING) || \
> > > >     defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
> > > >
> > > > just use __maybe_unused for this small function which seems like a good
> > > > trade-off.
> > >
> > > Generally, I'm not a fan of __maybe_unused.  It is a tool in the
> > > toolbox for solving this issue, but it's my least favorite.  Should
> > > the call sites be eliminated, this may mask an unused and entirely
> > > dead function from being removed.  Preprocessor guards based on config
> > > give more context into *why* a particular function may be unused.
> > >
> > > So let's take a look at the call sites of account_other_time().  Looks
> > > like irqtime_account_process_tick() (guarded by
> > > CONFIG_IRQ_TIME_ACCOUNTING) and get_vtime_delta() (guarded by
> > > CONFIG_VIRT_CPU_ACCOUNTING_GEN).  If it were one config guard, then I
> > > would prefer to move the definition to be within the same guard, just
> > > before the function definition that calls it, but we have a more
> > > complicated case here.
> > >
> > > The next thing I'd check to see is if there's a dependency between
> > > configs.  In this case, both CONFIG_IRQ_TIME_ACCOUNTING and
> > > CONFIG_VIRT_CPU_ACCOUNTING_GEN are defined in init/Kconfig.  In this
> > > case there's also no dependency between configs, so specifying one
> > > doesn't imply the other; so guarding on one of the two configs is also
> > > not an option.
> > >
> > > So, as much as I'm not a fan of __maybe_unused, it is indeed the
> > > simplest option.  Though, I'd still prefer the ifdef you describe
> > > instead, maybe the maintainers can provide guidance/preference?
> >
> > Another option might be to move static inline functions
> > where possible to an #include file (like sched.h) but the
> > same possible dead function issue would still exist.
>
> Turns out there are hundreds of unused static inline
> functions in kernel .h files.
>
> A trivial script to find some of them (with likely
> false positives as some might actually be used via ##
> token pasting mechanisms).
>
> (and there's almost certainly a better way to do this
>  too as it takes a _very_ long time to run)
>
> $ grep-2.5.4 -rP --include=*.h '^[ \t]*static\s+inline\s+(?:\w+\s+){1,3}\w+[ \t]*\(' * | \
>   grep -P -oh '\w+\s*\(' | \
>   sort | uniq -c | sort -n | grep -P '^\s+1\b' | \
>   sed -r -e 's/^\s+1\s+//' -e 's/\(//' | \
>   while read line ; do \
>     echo -n "$line: " ; git grep -w $line | wc -l ; \
>   done | \
>   grep ": 1$"

Please start sending patches to remove them and I'll review.  If this
is a good amount of work, I have newbies that are looking to
contribute and can help.
-- 
Thanks,
~Nick Desaulniers
