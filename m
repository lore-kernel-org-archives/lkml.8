Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E28C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66592075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEN9zSw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437793AbgE1XxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437677AbgE1Xwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:52:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F9C08C5CB
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:32:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so315315ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6ocTYqS1ytsKPxtF8vN6tIy7DtKH5+fD7iyXL+yR74=;
        b=DEN9zSw3qsLo9yvtTr88DSUjceHyQzaJs07kMe/MGRcduQi+u/Yg7XPAKWIWD4Uebi
         7meJqiqgCQlkf1ksgk686mzidyLcdDCAAmjksI/Ep28pnsFd9hgU25fPsYTMBfOnsaYG
         jn3z/gSHTVhVQ89C/WSO3cMACa3zGkzAzM2/88ke+APMYUiNWsb7tGn+HVKZ0Z0oJ+0H
         RYMS6FOUGsPtY2Aan92EjR+6QGMQoNRFq6S+H8U/PM58mv6nzixeodvLrxSltKA8BhQl
         +A7NMAa5ENtL08Uie4ulExlC72SzpUj0sBibw5laRnFAZ21ZSaVWLjXmBm9aWofYTLS7
         9p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6ocTYqS1ytsKPxtF8vN6tIy7DtKH5+fD7iyXL+yR74=;
        b=ZvEUxHYDjUx0cfaPO7gZ7B0zt/poAYVUYVbul0gT0pSyd41l/0udGRib+sVE1C+JLe
         K4BHs2d68s6tiYtHO0J0AizfjwdWup+uuV3I8NaTCUREVF0siP2PCIC1HIGCi9bMQdA0
         sUT/aKnQJz/7XBTsD3hF4qD4n1iPr9yT4DrywI1cG1PTscTm97QXEjXYuHTR7knWMhl1
         +v8dUiODNwzdGS6lA2ekvkRoPNkObelylCEW+8YUPen7qASgWGbyNSbxUA0ax4MoKJkj
         fr8REVPU4YRTDpORCIROH+Z7aIlsxUs9ftcW9bIQ/IKfOCKNiJQiRZ6H3vxVqxJFgXjw
         xy5A==
X-Gm-Message-State: AOAM532xFKkKYLAz88wJsAwMTDjD9rTAs/RYgKAG1mWqVlVRPkUYblc4
        X01rePVydBJPFOqlo/f9KlFRaB0GpQITKBLOPRys0g==
X-Google-Smtp-Source: ABdhPJxhCO8yq7MICHiA12O2mds71igoeMtLHDguSzi4McQ2QB0zB2szqTfT+eWc0yEzwKPBmDeBJdZG06IVwOBL0Fg=
X-Received: by 2002:a2e:9455:: with SMTP id o21mr2672685ljh.415.1590708749570;
 Thu, 28 May 2020 16:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200528151412.265444-1-christian.brauner@ubuntu.com> <202005281404.276641223F@keescook>
In-Reply-To: <202005281404.276641223F@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 May 2020 01:32:03 +0200
Message-ID: <CAG48ez0k23qM2QEi42VTjCbnoY9_nfTH09B_Qr2zu+m3KWWUiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] seccomp: notify user trap about unused filter
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 1:11 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, May 28, 2020 at 05:14:11PM +0200, Christian Brauner wrote:
> >   * @usage: reference count to manage the object lifetime.
> >   *         get/put helpers should be used when accessing an instance
> >   *         outside of a lifetime-guarded section.  In general, this
> >   *         is only needed for handling filters shared across tasks.
> > [...]
> > + * @live: Number of tasks that use this filter directly and number
> > + *     of dependent filters that have a non-zero @live counter.
> > + *     Altered during fork(), exit(), and filter installation
> > [...]
> >       refcount_set(&sfilter->usage, 1);
> > +     refcount_set(&sfilter->live, 1);
[...]
> After looking at these other lifetime management examples in the kernel,
> I'm convinced that tracking these states separately is correct, but I
> remain uncomfortable about task management needing to explicitly make
> two calls to let go of the filter.
>
> I wonder if release_task() should also detach the filter from the task
> and do a put_seccomp_filter() instead of waiting for task_free(). This
> is supported by the other place where seccomp_filter_release() is
> called:
>
> > @@ -396,6 +400,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
> >                * allows a put before the assignment.)
> >               */
> >               put_seccomp_filter(thread);
> > +             seccomp_filter_release(thread);
>
> This would also remove the only put_seccomp_filter() call outside of
> seccomp.c, since the free_task() call will be removed now in favor of
> the task_release() call.
>
> So, is it safe to detach the filter in release_task()? Has dethreading
> happened yet? i.e. can we race TSYNC? -- is there a possible
> inc-from-zero?

release_task -> __exit_signal -> __unhash_process ->
list_del_rcu(&p->thread_node) drops us from the thread list under
siglock, which is the same lock TSYNC uses.

One other interesting thing that can look at seccomp state is
task_seccomp() in procfs - that can still happen at this point. At the
moment, procfs only lets you see the numeric filter state, not the
actual filter contents, so that's not a problem; but if we ever add a
procfs interface for dumping seccomp filters (in addition to the
ptrace interface that already exists), that's something to keep in
mind.

> (Actually, all our refcount_inc()s should be
> refcount_inc_not_zero() just for robustness.)

Eeeh... wouldn't that just make the code more complicated for no good reason?

> I *think* we can do it
> before the release_thread() call (instead of after cgroup_release()).
