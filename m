Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5114CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3359D20DD4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbgE1J5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:57:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46311 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387660AbgE1J5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:57:45 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeFIF-0002s4-9R; Thu, 28 May 2020 09:57:43 +0000
Date:   Thu, 28 May 2020 11:57:42 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200528095742.cjwemtucwgvhxnxv@wittgenstein>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <CAG48ez3z4TTKHwQmZbeyb+egAdKsFb0kkReSLtJsA+9MP6VUBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3z4TTKHwQmZbeyb+egAdKsFb0kkReSLtJsA+9MP6VUBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 06:04:48AM +0200, Jann Horn wrote:
> On Wed, May 27, 2020 at 1:19 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > We've been making heavy use of the seccomp notifier to intercept and
> > handle certain syscalls for containers. This patch allows a syscall
> > supervisor listening on a given notifier to be notified when a seccomp
> > filter has become unused.
> [...]
> > To fix this, we introduce a new "live" reference counter that tracks the
> > live tasks making use of a given filter and when a notifier is
> > registered waiting tasks will be notified that the filter is now empty
> > by receiving a (E)POLLHUP event.
> > The concept in this patch introduces is the same as for signal_struct,
> > i.e. reference counting for life-cycle management is decoupled from
> > reference counting live taks using the object.
> [...]
> > + * @live: tasks that actually use this filter, only to be altered
> > + *          during fork(), exit()/free_task(), and filter installation
> 
> This comment is a bit off. Actually, @live counts the number of tasks
> that use the filter directly plus the number of dependent filters that
> have non-zero @live.

I'll update the comment.

> 
> [...]
> > +void seccomp_filter_notify(const struct task_struct *tsk)
> > +{
> > +       struct seccomp_filter *orig = tsk->seccomp.filter;
> > +
> > +       while (orig && refcount_dec_and_test(&orig->live)) {
> > +               if (waitqueue_active(&orig->wqh))
> > +                       wake_up_poll(&orig->wqh, EPOLLHUP);
> > +               orig = orig->prev;
> > +       }
> > +}
> 
> /me fetches the paint bucket
> 
> Maybe name this seccomp_filter_unuse() or
> seccomp_filter_unuse_notify() or something like that? The current name
> isn't very descriptive.

I think seccomp_filter_release() might be the right color. It would also
line-up nicely with:
- cgroup_release()
- exit_mm_release()
- exec_mm_release()
- futex_exec_release()
- ptrace_release_task()
and others.

Christian
