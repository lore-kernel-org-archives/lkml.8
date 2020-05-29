Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17CCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F0D2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgE2Hvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:51:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35207 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Hvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:51:41 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeZnm-0003Rl-Tz; Fri, 29 May 2020 07:51:39 +0000
Date:   Fri, 29 May 2020 09:51:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v2 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200529075137.gkwclirogbe3ae2a@wittgenstein>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <202005281404.276641223F@keescook>
 <CAG48ez0k23qM2QEi42VTjCbnoY9_nfTH09B_Qr2zu+m3KWWUiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0k23qM2QEi42VTjCbnoY9_nfTH09B_Qr2zu+m3KWWUiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:32:03AM +0200, Jann Horn wrote:
> On Fri, May 29, 2020 at 1:11 AM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, May 28, 2020 at 05:14:11PM +0200, Christian Brauner wrote:
> > >   * @usage: reference count to manage the object lifetime.
> > >   *         get/put helpers should be used when accessing an instance
> > >   *         outside of a lifetime-guarded section.  In general, this
> > >   *         is only needed for handling filters shared across tasks.
> > > [...]
> > > + * @live: Number of tasks that use this filter directly and number
> > > + *     of dependent filters that have a non-zero @live counter.
> > > + *     Altered during fork(), exit(), and filter installation
> > > [...]
> > >       refcount_set(&sfilter->usage, 1);
> > > +     refcount_set(&sfilter->live, 1);
> [...]
> > After looking at these other lifetime management examples in the kernel,
> > I'm convinced that tracking these states separately is correct, but I
> > remain uncomfortable about task management needing to explicitly make
> > two calls to let go of the filter.
> >
> > I wonder if release_task() should also detach the filter from the task
> > and do a put_seccomp_filter() instead of waiting for task_free(). This
> > is supported by the other place where seccomp_filter_release() is
> > called:
> >
> > > @@ -396,6 +400,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
> > >                * allows a put before the assignment.)
> > >               */
> > >               put_seccomp_filter(thread);
> > > +             seccomp_filter_release(thread);
> >
> > This would also remove the only put_seccomp_filter() call outside of
> > seccomp.c, since the free_task() call will be removed now in favor of
> > the task_release() call.
> >
> > So, is it safe to detach the filter in release_task()? Has dethreading
> > happened yet? i.e. can we race TSYNC? -- is there a possible
> > inc-from-zero?
> 
> release_task -> __exit_signal -> __unhash_process ->
> list_del_rcu(&p->thread_node) drops us from the thread list under
> siglock, which is the same lock TSYNC uses.
> 
> One other interesting thing that can look at seccomp state is
> task_seccomp() in procfs - that can still happen at this point. At the
> moment, procfs only lets you see the numeric filter state, not the
> actual filter contents, so that's not a problem; but if we ever add a
> procfs interface for dumping seccomp filters (in addition to the
> ptrace interface that already exists), that's something to keep in
> mind.

Aside from this being not an issue now, can we please not dump seccomp
filter contents in proc. That sounds terrible and what's the rationale,
libseccomp already let's you dump filter contents while loading and you
could ptrace it. But maybe I'm missing a giant need for this...

Christian
