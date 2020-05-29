Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF00C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F2A2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgE2Ihz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:37:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36554 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Ihz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:37:55 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeaWW-00079Z-Om; Fri, 29 May 2020 08:37:52 +0000
Date:   Fri, 29 May 2020 10:37:51 +0200
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
Subject: Re: [PATCH v2 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200529083751.jykf2k7ajsymwldx@wittgenstein>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <202005281404.276641223F@keescook>
 <20200529075641.eoogczu6t5gmv3e3@wittgenstein>
 <202005290102.3BB21C875@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005290102.3BB21C875@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:06:59AM -0700, Kees Cook wrote:
> On Fri, May 29, 2020 at 09:56:41AM +0200, Christian Brauner wrote:
> > On Thu, May 28, 2020 at 04:11:00PM -0700, Kees Cook wrote:
> > > void seccomp_filter_release(const struct task_struct *tsk)
> > > {
> > > 	struct seccomp_filter *orig = READ_ONCE(tsk->seccomp.filter);
> > > 
> > > 	smp_store_release(&tsk->seccomp.filter, NULL);
> > 
> > I need to go through the memory ordering requirements before I can say
> > yay or nay confidently to this. :)
> > 
> > > 	__seccomp_filter_release(orig);
> > > }
> 
> The only caller will be release_task() after dethread, so honestly this
> was just me being paranoid. I don't think it actually needs the
> READ_ONCE() nor the store_release. I think I wrote all that before I'd
> convinced myself it was safe to remove a filter then. But I'm still
> suspicious given the various ways release_task() gets called... I just
> know that if mode 2 is set and filter == NULL, seccomp will fail closed,
> so I went the paranoid route. :)

release_task() should only be called once per thread otherwise we'd have
big problems. And every time we call release_task() we're already
EXIT_DEAD iirc. So there should be no way someone else can find us (in a
relevant way and especially not from userspace).
exit_notify() -> if we're autoreaping we're EXIT_DEAD anyway, if we're
not autoreaping we'll wait_task_zombie() eventually -> we're EXIT_DEAD
(parent has reaped us)

find_child_reaper() -> we couldn't find a child reaper for us, i.e. we
were (namespace) init -> unlink all tasks we were ptracing
(exit_ptrace()) and if they're EXIT_DEAD move them to the dead list ->
release_task()'s that are EXIT_DEAD that we ptraced.

and de_thread() relies on EXIT_DEAD too:
/*
 * We are going to release_task()->ptrace_unlink() silently,
 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
 * the tracer wont't block again waiting for this thread.
*/

(This is a very _rough_ sketch.)
So I think that's safe.

Christian
