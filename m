Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCCFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839AC20866
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R179c/Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHRMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgHRMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:02:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB6C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:02:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so14880457qtn.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+glSFv2ulSd5ApcSJxswwERJlyF3iixhLZBdbyIclM=;
        b=R179c/Iyl03Msga29C45pTpjCHov4VwhXzTv4VVfIMTvftSGf6YxLi78dQl9ZDrHUy
         Gry8UOLQviXFuQdzyB0dg+eQ+kCKF8TJR52zcHtCkqwWBQeYM8g7nbdSuLZdAiM1eEu3
         P201/hjzJ7/LCLiMKwUKfXOtXV7l/H8TCLBzHuf92PWt5Se++YAbVp85TWV3klo4GfwL
         lqvv6FIqKsp9VpCVieb2hZY0dasiWEyaaa5M0dyOm4TX020Q5j8EEc6P+hJlNSx0a7/M
         DE6L87wRoMndAsgWcBKHzwGMEip6jPmYvYjjmKHD3GB0e5279KtZxcbQlfU+xrg1IJmM
         638A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+glSFv2ulSd5ApcSJxswwERJlyF3iixhLZBdbyIclM=;
        b=eatY7t2UEo/OCksIjrvCZMypGvvCYPMtP3dj6Qhqr79BaUSpftRK31P3YR3A2VP/Ah
         H+jUI/cljFU1cRb1cU9omEboY0494c5mlvpQfHZT5CYjLHvL+p5kH04q9ZrmCHShZ1B+
         Wp7STAi4T8ymJL/B0WZQyK0eRZXgX2FK7wcNd/ZKccZVUCIWinuDAAgXstw3V5ILkw87
         Kyz7aLwxfR8vJfJzHn8YITwLzwuihMAbnxfFHMDjbnT6UhTbM5IeeIM90UsBbsNCAVrn
         a2vQVVEqIpZrc4PabEPQo7WiH6S0syCxCBmeFykji3FGy1Nd96JzHnKCWaNpgpOKi8Px
         hwWw==
X-Gm-Message-State: AOAM532cta2fzGldCQLN8BLdb00uOq9YrAw1+gSm04AE+YQ/cAbsNDj4
        lAIpw1nQe1km54OSlLQFwdyknAfe700UaX1K+gsl5ToAZkI=
X-Google-Smtp-Source: ABdhPJxyQSbJ3wZQJLJek9yl9WwHwg8qbgt/Zk/igfhualfIoyywy9Duj/4lyZds8+O/Ixp6IDtmhbHO9ajNFCC7d68=
X-Received: by 2002:ac8:154:: with SMTP id f20mr17387688qtg.57.1597752170078;
 Tue, 18 Aug 2020 05:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com>
 <46674d71-1e41-cb68-ed99-72c25a73dfef@i-love.sakura.ne.jp>
 <37b60b14-4eb6-36b3-1195-97c2d27b7ed8@i-love.sakura.ne.jp>
 <CACT4Y+Y0ptJDj1F89jKQEKB_L8U2yFCUUZ7pwxh+fcE-ZpsBkg@mail.gmail.com> <8fc12fea-bf70-874e-fc19-067d504fa5cc@i-love.sakura.ne.jp>
In-Reply-To: <8fc12fea-bf70-874e-fc19-067d504fa5cc@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Aug 2020 14:02:38 +0200
Message-ID: <CACT4Y+bBdRMCAzOMM8u19m_GopaWEK8eY-VMsgmGRZzYko=DVw@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Introduce CONFIG_LOCKDEP_LARGE
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 1:07 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/08/18 18:57, Dmitry Vyukov wrote:
> > On Tue, Aug 4, 2020 at 4:36 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> Hello, Peter, Ingo and Will.
> >>
> >> (Q1) Can we change the capacity using kernel config?
> >>
> >> (Q2) If we can change the capacity, is it OK to specify these constants
> >>      independently? (In other words, is there inter-dependency among
> >>      these constants?)
> >
> >
> > I think we should do this.
> > syzbot uses a very beefy kernel config and very broad load.
> > We are hitting "BUG: MAX_LOCKDEP_ENTRIES too low!" for the part 428
> > days and already hit it 96K times. It's just harming overall kernel
> > testing:
> > https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
> >
> > I think it's better if exact values are not hardcoded, but rather
> > specified in the config. Today we are switching from 4K to 8K, but as
> > we enable more configs and learn to reach more code, we may need 16K.
>
> For short term, increasing the capacity would be fine. But for long term, I doubt.
>
> Learning more locks being held within one boot by enabling more configs, I suspect
> that it becomes more and more timing dependent and difficult to hold all locks that
> can generate a lockdep warning.
>
> >
> >
> >> (Q3) Do you think that we can extend lockdep to be used as a tool for auditing
> >>      locks held in kernel space and rebuilding lock dependency map in user space?
> >
> > This looks like lots of work. Also unpleasant dependencies on
> > user-space. If there is a user-space component, it will need to be
> > deployed to _all_ of kernel testing systems and for all users of
> > syzkaller. And it will also be a dependency for reproducers. Currently
> > one can run a C reproducer and get the errors message from LOCKDEP. It
> > seems that a user-space component will make it significantly more
> > complicated.
>
> My suggestion is to detach lockdep warning from realtime alarming.
>
> Since not all locks are always held (e.g. some locks are held only if exceeding
> some threshold), requiring all locks being held within one boot sounds difficult.
> Such requirement results in flaky bisection like "Fix bisection: failed" in
> https://syzkaller.appspot.com/bug?id=b23ec126241ad0d86628de6eb5c1cff57d282632 .
>
> Then, I'm wishing that we could build non-realtime alarming based on all locks held
> across all boots on each vmlinux file.

Unless I am missing something, deployment/maintenance story for this
for syzbot, syzkaller users, other kernel testing, reproducer
extraction, bisection, resproducer hermeticity is quite complicated. I
don't see it outweighing any potential benefit in reporting quality.

I also don't see how it will improve reproducer/bisection quality: to
confirm presence of a bug we still need to trigger all cycle edges
within a single run anyway, it does not have to be a single VM, but
still needs to be a single test case. And this "having all edges
within a single test case" seems to be the root problem. I don't see
how this proposal addresses this problem.

> >> On 2020/07/25 14:23, Tetsuo Handa wrote:
> >>>> Also somebody may use it to _reduce_ size of the table for a smaller kernel.
> >>>
> >>> Maybe. But my feeling is that it is very rare that the kernel actually deadlocks
> >>> as soon as lockdep warned the possibility of deadlock.
> >>>
> >>> Since syzbot runs many instances in parallel, a lot of CPU resource is spent for
> >>> checking the same dependency tree. However, the possibility of deadlock can be
> >>> warned for only locks held within each kernel boot, and it is impossible to hold
> >>> all locks with one kernel boot.
> >>>
> >>> Then, it might be nice if lockdep can audit only "which lock was held from which
> >>> context and what backtrace" and export that log like KCOV data (instead of evaluating
> >>> the possibility of deadlock), and rebuild the whole dependency (and evaluate the
> >>> possibility of deadlock) across multiple kernel boots in userspace.
> >>
>
