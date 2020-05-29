Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63E8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B39206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgE2Iud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:50:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36916 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2Iuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:50:32 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeaik-0008KT-5f; Fri, 29 May 2020 08:50:30 +0000
Date:   Fri, 29 May 2020 10:50:29 +0200
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
Message-ID: <20200529085029.7eranatdkak6nbaf@wittgenstein>
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

We should move us after write_unlock_irq(&tasklist_lock). We're after
__exit_signal() so we're unhashed and can't be discovered by tsync too
anymore and we also don't require the tasklist_lock to be held:

diff --git a/kernel/exit.c b/kernel/exit.c
index b332e3635eb5..5490cc04f436 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -193,8 +193,6 @@ void release_task(struct task_struct *p)

        cgroup_release(p);

        write_lock_irq(&tasklist_lock);
        ptrace_release_task(p);
        thread_pid = get_pid(p->thread_pid);
@@ -220,6 +218,7 @@ void release_task(struct task_struct *p)
        }

        write_unlock_irq(&tasklist_lock);
+       seccomp_filter_release(p);
        proc_flush_pid(thread_pid);
        put_pid(thread_pid);
        release_thread(p);

Christian
