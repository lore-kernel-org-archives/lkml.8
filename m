Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3412084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgE0XQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:16:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53028 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0XQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:16:49 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1je5Hy-0005uN-T4; Wed, 27 May 2020 23:16:47 +0000
Date:   Thu, 28 May 2020 01:16:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200527231646.4v743erjpzh6qe5f@wittgenstein>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
 <20200527220532.jplypougn3qzwrms@wittgenstein>
 <202005271537.75548B6@keescook>
 <20200527224501.jddwcmvtvjtjsmsx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527224501.jddwcmvtvjtjsmsx@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:45:02AM +0200, Christian Brauner wrote:
> On Wed, May 27, 2020 at 03:37:58PM -0700, Kees Cook wrote:
> > On Thu, May 28, 2020 at 12:05:32AM +0200, Christian Brauner wrote:
> > > The main question also is, is there precedence where the kernel just
> > > closes the file descriptor for userspace behind it's back? I'm not sure
> > > I've heard of this before. That's not how that works afaict; it's also
> > > not how we do pidfds. We don't just close the fd when the task
> > > associated with it goes away, we notify and then userspace can close.
> > 
> > But there's a mapping between pidfd and task struct that is separate
> > from task struct itself, yes? I.e. keeping a pidfd open doesn't pin
> > struct task in memory forever, right?
> 
> No, but that's an implementation detail and we discussed that. It pins
> struct pid instead of task_struct. Once the process is fully gone you
> just get ESRCH.
> For example, fds to /proc/<pid>/<tid>/ fds aren't just closed once the
> task has gone away, userspace will just get ESRCH when it tries to open
> files under there but the fd remains valid until close() is called.
> 
> In addition, of all the anon inode fds, none of them have the "close the
> file behind userspace back" behavior: io_uring, signalfd, timerfd, btf,
> perf_event, bpf-prog, bpf-link, bpf-map, pidfd, userfaultfd, fanotify,
> inotify, eventpoll, fscontext, eventfd. These are just core kernel ones.
> I'm pretty sure that it'd be very odd behavior if we did that. I'd
> rather just notify userspace and leave the close to them. But maybe I'm
> missing something.

I'm also starting to think this isn't even possible or currently doable
safely.
The fdtable in the kernel would end up with a dangling pointer, I would
think. Unless you backtrack all fds that still have a reference into the
fdtable and refer to that file and close them all in the kernel which I
don't think is possible and also sounds very dodgy. This also really
seems like we would be breaking a major contract, namely that fds stay
valid until userspace calls close, execve(), or exits.

Christian
