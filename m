Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629A5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A812078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgE0WFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:05:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0WFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:05:37 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1je4B3-0000kh-Tm; Wed, 27 May 2020 22:05:34 +0000
Date:   Thu, 28 May 2020 00:05:32 +0200
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
Message-ID: <20200527220532.jplypougn3qzwrms@wittgenstein>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005271408.58F806514@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 02:43:49PM -0700, Kees Cook wrote:
> On Wed, May 27, 2020 at 01:19:01PM +0200, Christian Brauner wrote:
> > loop. But this is problematic since we don't get a notification when the
> > seccomp filter has become unused and so we currently never remove the
> > seccomp notifier fd from the event loop and just keep accumulating fds
> > in the event loop. We've had this issue for a while but it has recently
> > become more pressing as more and larger users make use of this.
> 
> I had been under the (seemingly very wrong) understanding that when
> all the tasks associated with a filter cease to exist, the notif fd is
> effectively closed. But I see now where I got confused: this is only
> half implemented: if the userspace end of the fd is closed, it'll get
> cleaned up in the kernel, but we have nothing going the other direction
> except the general object lifetime management on the filter itself.
> 
> So, yes, I accept the basic problem statement, "we have fds hanging
> around that will never be used again, we need to notice that". :)
> 
> Why is EPOLLHUP needed? Can't the fd just get closed on the kernel end?
> I would expect that to be visible as EPOLLHUP internally (though I
> haven't looked through the VFS yet). And I haven't found how to
> close/detach a anon file from the listener task. It strikes me that this
> would actually be much cleaner: then we actually don't need the
> additional __get_seccomp_filter() in init_listener() -- we simply
> invalidate the file during __put_seccomp_filter().
> 
> (While I'm here -- why can there be only one listener per task? The
> notifications are filter-specific, not task-specific?)
> 
> > To fix this, we introduce a new "live" reference counter that tracks the
> > live tasks making use of a given filter and when a notifier is
> > registered waiting tasks will be notified that the filter is now empty
> > by receiving a (E)POLLHUP event.
> > The concept in this patch introduces is the same as for signal_struct,
> > i.e. reference counting for life-cycle management is decoupled from
> > reference counting live taks using the object.
> 
> I will need convincing that life-cycle ref-counting needs to be decoupled
> from usage ref-counting. I see what you're saying here and in the other
> reply about where the notification is coming from (release vs put, etc),
> but I think it'd be better if the EPOLLHUP was handled internally to the
> VFS due to the kernel end of the file being closed.
> 
> > There's probably some trickery possible but the second counter is just
> > the correct way of doing this imho and has precedence. The patch also
> > lifts the waitqeue from struct notification into into sruct
> > seccomp_filter. This is cleaner overall and let's us avoid having to
> > take the notifier mutex since we neither need to read nor modify the
> > notifier specific aspects of the seccomp filter. In the exit path I'd
> > very much like to avoid having to take the notifier mutex for each
> > filter in the task's filter hierarchy.
> 
> I guess this is a minor size/speed trade-off (every seccomp_filter
> struct grows by 1 pointer regardless of the presence of USER_NOTIF
> rules attached...). But I think this is an optimization detail, and I
> need to understand why we can't just close the file on filter free.

The usage count is not just notify + tasks, it's also incremented when
e.g. ptrace is inspecting the filter and everytime someone takes a
refrence to it that is not using the filter. So "usage" never had a 1:1
correspondence with tasks in the first place. Filter free can happen way
after any task _used_ that filter, either because of where that filter
free happens due to call_rcu, or because someone is mucking with the
filter but not using it (ptrace etc. pp.). So a separate counter doesn't
seem wrong. We also need it even if we were to do the kernel close thing
you suggested.

The main question also is, is there precedence where the kernel just
closes the file descriptor for userspace behind it's back? I'm not sure
I've heard of this before. That's not how that works afaict; it's also
not how we do pidfds. We don't just close the fd when the task
associated with it goes away, we notify and then userspace can close.

Christian
