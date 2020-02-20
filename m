Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC6C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9231206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYlXHI4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgBTQW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:22:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45030 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgBTQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:22:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id j23so3243733qtr.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxjPH3EKrwjdqvJZzEhss/or1cFxBJl747SKit3fjVY=;
        b=jYlXHI4XuUHkbBKFFTHD5pozvgeTxolhwS1FHSg7CapmHEqP7QtnMCtDcpKqINrc+B
         ziSq73euelc4iNJiiQvJMTCvINcEQQWt6MzkE1CWc/XcJ/EPNOQyAmTDBt4PiHXl0s07
         ZqKSGffn7i8qxeb9ZM4feXBaT7tYbnAt+stDrBmAs6/B6KO5lyRloU77dfXuIEvK7Bk1
         XizIgRwyAsWd4V4av0Wreugx1lBRroooh9U8nBzZ4ANGPvWDyFcStHeA7irS0UUDSefJ
         LF3aZxrA7y+hmKksghM7hdZSIIwzw7o0c4oUpFxIFlCLYlPSbMj6AKR953pzg2ZB/Dde
         pWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxjPH3EKrwjdqvJZzEhss/or1cFxBJl747SKit3fjVY=;
        b=hDcBMWfQnHFIqSB7QCVwlKYRpes02eI5D1G0h5k0ZppZkrb0iXcYCzCLAxhV1Q7ZDU
         FZBBfNEV1KzyFo5GkYGsOF4ZA1B9SR+8CP3mPXV4gJjp4zey3yLzbm7ocuvwDwI3MxVP
         DkwgfOd49KW6hDgWz2YefHeDibq3swhV6f+f3yJMNWzmjWXqHFWLOIj7Vzn25B1YBBSW
         nmbw3HgKCff2kKXhy/Fd/0y0yL+sDDjeaDL9woPBETVfIEFj8pqkWGhpAgrvfSpYO4K8
         YZnhn4CbMreIYbZ5kTqnw+mlkXVn0OcQmx4IuSAYtDFDdsUgUmYqRpnnQvr/pZ1ujg7n
         dkww==
X-Gm-Message-State: APjAAAWq4qAud7+RYeuBilaI9/enHJYRHzk+chjhzNLC8XL7H63IIaND
        wFwg0siNMRdX17ReYd++CLHxpmm+sHwcw20Q0t3LdA==
X-Google-Smtp-Source: APXvYqza1eEnxPl1LnCg7HX1oJToV/DVBCAxwi8IXvCVDQa1gLTlGDIhz4sKEvXrv9VIyYXqOqBosOBKijh3tPCKmlY=
X-Received: by 2002:ac8:1b18:: with SMTP id y24mr26811345qtj.158.1582215745116;
 Thu, 20 Feb 2020 08:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20200219144724.800607165@infradead.org> <20200219150745.651901321@infradead.org>
 <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
 <20200219163025.GH18400@hirez.programming.kicks-ass.net> <20200219172014.GI14946@hirez.programming.kicks-ass.net>
 <CACT4Y+ZfxqMuiL_UF+rCku628hirJwp3t3vW5WGM8DWG6OaCeg@mail.gmail.com> <20200220120631.GX18400@hirez.programming.kicks-ass.net>
In-Reply-To: <20200220120631.GX18400@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 20 Feb 2020 17:22:14 +0100
Message-ID: <CACT4Y+bj_Onff8jUP97AVRhmdeN0QRrGcd9KRPSfnFTHAHyxtA@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is not sanitized
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 1:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 20, 2020 at 11:37:32AM +0100, Dmitry Vyukov wrote:
> > On Wed, Feb 19, 2020 at 6:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Feb 19, 2020 at 05:30:25PM +0100, Peter Zijlstra wrote:
> > >
> > > > By inlining everything in poke_int3_handler() (except bsearch :/) we can
> > > > mark the whole function off limits to everything and call it a day. That
> > > > simplicity has been the guiding principle so far.
> > > >
> > > > Alternatively we can provide an __always_inline variant of bsearch().
> > >
> > > This reduces the __no_sanitize usage to just the exception entry
> > > (do_int3) and the critical function: poke_int3_handler().
> > >
> > > Is this more acceptible?
> >
> > Let's say it's more acceptable.
> >
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
>
> Thanks, I'll go make it happen.
>
> > I guess there is no ideal solution here.
> >
> > Just a straw man proposal: expected number of elements is large enough
> > to make bsearch profitable, right? I see 1 is a common case, but the
> > other case has multiple entries.
>
> Latency was the consideration; the linear search would dramatically
> increase the runtime of the exception.
>
> The current limit is 256 entries and we're hitting that quite often.
>
> (we can trivially increase, but nobody has been able to show significant
> benefits for that -- as of yet)

I see. Thanks for explaining. Just wanted to check because inlining a
linear search would free us from all these unpleasant problems.
