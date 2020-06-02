Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744F2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AA8206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFBLfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:35:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60507 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgFBLfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:35:16 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jg5CJ-00009m-CA; Tue, 02 Jun 2020 11:35:11 +0000
Date:   Tue, 2 Jun 2020 13:35:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robert Sesek <rsesek@google.com>, Chris Palmer <palmer@google.com>,
        Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 3/4] seccomp: notify about unused filter
Message-ID: <20200602113510.hhfd5oysofuaq7tk@wittgenstein>
References: <20200531115031.391515-1-christian.brauner@ubuntu.com>
 <20200531115031.391515-3-christian.brauner@ubuntu.com>
 <202006011225.E58FC9CCA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006011225.E58FC9CCA@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:29:27PM -0700, Kees Cook wrote:
> On Sun, May 31, 2020 at 01:50:30PM +0200, Christian Brauner wrote:
> > We've been making heavy use of the seccomp notifier to intercept and
> > handle certain syscalls for containers. This patch allows a syscall
> > supervisor listening on a given notifier to be notified when a seccomp
> > filter has become unused.
> > 
> > A container is often managed by a singleton supervisor process the
> > so-called "monitor". This monitor process has an event loop which has
> > various event handlers registered. If the user specified a seccomp
> > profile that included a notifier for various syscalls then we also
> > register a seccomp notify even handler. For any container using a
> > separate pid namespace the lifecycle of the seccomp notifier is bound to
> > the init process of the pid namespace, i.e. when the init process exits
> > the filter must be unused.
> > If a new process attaches to a container we force it to assume a seccomp
> > profile. This can either be the same seccomp profile as the container
> > was started with or a modified one. If the attaching process makes use
> > of the seccomp notifier we will register a new seccomp notifier handler
> > in the monitor's event loop. However, when the attaching process exits
> > we can't simply delete the handler since other child processes could've
> > been created (daemons spawned etc.) that have inherited the seccomp
> > filter and so we need to keep the seccomp notifier fd alive in the event
> > loop. But this is problematic since we don't get a notification when the
> > seccomp filter has become unused and so we currently never remove the
> > seccomp notifier fd from the event loop and just keep accumulating fds
> > in the event loop. We've had this issue for a while but it has recently
> > become more pressing as more and larger users make use of this.
> > 
> > To fix this, we introduce a new "users" reference counter that tracks
> > any tasks and dependent filters making use of a filter. When a notifier is
> > registered waiting tasks will be notified that the filter is now empty by
> > receiving a (E)POLLHUP event.
> > The concept in this patch introduces is the same as for signal_struct,
> > i.e. reference counting for life-cycle management is decoupled from
> > reference counting taks using the object.
> > 
> > There's probably some trickery possible but the second counter is just
> > the correct way of doing this imho and has precedence. The patch also
> > lifts the waitqeue from struct notification into sruct seccomp_filter.
> > This is cleaner overall and let's us avoid having to take the notifier
> > mutex since we neither need to read nor modify the notifier specific
> > aspects of the seccomp filter. In the exit path I'd very much like to
> > avoid having to take the notifier mutex for each filter in the task's
> > filter hierarchy.
> > 
> > Cc: Tycho Andersen <tycho@tycho.ws>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Matt Denton <mpdenton@google.com>
> > Cc: Sargun Dhillon <sargun@sargun.me>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Chris Palmer <palmer@google.com>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Robert Sesek <rsesek@google.com>
> > Cc: Jeffrey Vander Stoep <jeffv@google.com>
> > Cc: Linux Containers <containers@lists.linux-foundation.org>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */
> > - Jann Horn <jannh@google.com>:
> >   - Use more descriptive instead of seccomp_filter_notify().
> >     (I went with seccomp_filter_release().)
> > 
> > /* v3 */
> > - Kees Cook <keescook@chromium.org>:
> >   - Rename counter from "live" to "users".
> > ---
> >  kernel/seccomp.c | 68 +++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 53 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 55251b1fe03f..45244f1ba148 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -94,13 +94,11 @@ struct seccomp_knotif {
> >   *           filter->notify_lock.
> >   * @next_id: The id of the next request.
> >   * @notifications: A list of struct seccomp_knotif elements.
> > - * @wqh: A wait queue for poll.
> >   */
> 
> I split the wait queue changes into a separate patch...
> 
> >  /**
> > - * seccomp_filter_release - Detach the task from its filter tree
> > - *			    and drop its reference count during
> > - *			    exit.
> > + * seccomp_filter_release - Detach the task from its filter tree,
> > + *			    drop its reference count, and notify
> > + *			    about unused filters
> >   *
> >   * This function should only be called when the task is exiting as
> >   * it detaches it from its filter tree.
> >   */
> >  void seccomp_filter_release(struct task_struct *tsk)
> >  {
> > -	struct seccomp_filter *cur = tsk->seccomp.filter;
> > +	struct seccomp_filter *orig = tsk->seccomp.filter;
> >  
> > +	/* Detach task from its filter tree. */
> >  	tsk->seccomp.filter = NULL;
> > -	__put_seccomp_filter(cur);
> > +	/* Notify about any unused filters in the task's former filter tree. */
> > +	__seccomp_filter_orphan(orig);
> > +	/* Finally drop all references to the task's former tree. */
> > +	__put_seccomp_filter(orig);
> >  }
> 
> I added __seccomp_filter_release() to do the filter-specific parts (the
> two functions passing "orig" above, so that it can be reused later...
> 
> >  
> >  /**
> > @@ -419,18 +441,29 @@ static inline void seccomp_sync_threads(unsigned long flags)
> >  	/* Synchronize all threads. */
> >  	caller = current;
> >  	for_each_thread(caller, thread) {
> > +		struct seccomp_filter *cur = thread->seccomp.filter;
> > +
> >  		/* Skip current, since it needs no changes. */
> >  		if (thread == caller)
> >  			continue;
> >  
> >  		/* Get a task reference for the new leaf node. */
> >  		get_seccomp_filter(caller);
> > +
> > +		/*
> > +		 * Notify everyone as we're forcing the thread
> > +		 * to orphan its current filter tree.
> > +		 */
> > +		__seccomp_filter_orphan(cur);
> > +
> >  		/*
> > -		 * Drop the task reference to the shared ancestor since
> > -		 * current's path will hold a reference.  (This also
> > -		 * allows a put before the assignment.)
> > +		 * Drop the task's reference to the shared ancestor
> > +		 * since current's path will hold a reference.
> > +		 * (This also allows a put before the assignment.)
> >  		 */
> > -		__put_seccomp_filter(thread->seccomp.filter);
> > +		__put_seccomp_filter(cur);
> 
> I switched this around to just call the new __seccomp_release_filter()
> (there's no need to open-code this and add "cur"). I also removed the
> comment about the notification, because that's not possible: "thread"
> shares the same filter hierarchy as "caller", so the counts on "cur"
> cannot reach 0 (no notifications can ever happen due to TSYNC).
> 
> Everything else looks great! I've applied it to for-next/seccomp.

Excellent, thanks!

Just in case this isn't obvious to everyone, I want to point out, that
this patchset means the seccomp notifier can be (ab)used to receive exit
notifications for a task tree (given some caveats) sharing the same
filter. In any case, I'd rather have a proper thread management
implementation of this through pidfds in the future if there's a need
for this. But one can abuse seccomp to achieve something similar with
my change here.
(Technically, we could also expand the notifier to have a "listen" mode
 whereby it only notifies about e.g. filter installation and filter)
 orphanage.)

Christian
