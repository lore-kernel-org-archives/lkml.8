Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62712C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446BB207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgE2H4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:56:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35285 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgE2H4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:56:43 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeZsf-0003iW-Uc; Fri, 29 May 2020 07:56:42 +0000
Date:   Fri, 29 May 2020 09:56:41 +0200
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
Message-ID: <20200529075641.eoogczu6t5gmv3e3@wittgenstein>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <202005281404.276641223F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005281404.276641223F@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:11:00PM -0700, Kees Cook wrote:
> On Thu, May 28, 2020 at 05:14:11PM +0200, Christian Brauner wrote:
> >   * @usage: reference count to manage the object lifetime.
> >   *         get/put helpers should be used when accessing an instance
> >   *         outside of a lifetime-guarded section.  In general, this
> >   *         is only needed for handling filters shared across tasks.
> > [...]
> > + * @live: Number of tasks that use this filter directly and number
> > + *	  of dependent filters that have a non-zero @live counter.
> > + *	  Altered during fork(), exit(), and filter installation
> > [...]
> >  	refcount_set(&sfilter->usage, 1);
> > +	refcount_set(&sfilter->live, 1);
> 
> I'd like these reference counters to have more descriptive names. "usage"
> by what? "live" from what perspective? At the least, I think we need
> to be explicit in the comment, and at best we should do that and rename
> them to be a bit more clear.
> 
> A filter's "usage" is incremented for each directly-attached task
> (task::seccomp_data.filter, via fork() or thread_sync), once for the
> dependent filter (filter::prev), and once for an open user_notif file
> (file::private_data). When it reaches zero, there are (should be) no more
> active memory references back to the struct filter and it can be freed.
> 
> A filter's "live" is incremented for each directly-attached task
> (task::seccomp_data.filter, via fork() or thread_sync), and once for
> the dependent filter (filter::prev). When it reaches zero there is no
> way for new tasks to get associated with the filter, but there may still
> be user_notif file::private_data references pointing at the filter.
> 
> But we're tracking "validity lifetime" (live) and "memory reference
> safety" (usage).
> 
> signal_struct has "sigcnt" and "live". I find "sigcnt" to be an
> unhelpful name too. (And why isn't it refcount_t?)
> 
> So, perhaps leave "live", but rename "usage" -> "references".
> 
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
> >  		 * allows a put before the assignment.)
> >  		*/
> >   		put_seccomp_filter(thread);
> > +		seccomp_filter_release(thread);
> 
> This would also remove the only put_seccomp_filter() call outside of
> seccomp.c, since the free_task() call will be removed now in favor of
> the task_release() call.
> 
> So, is it safe to detach the filter in release_task()? Has dethreading
> happened yet? i.e. can we race TSYNC? -- is there a possible

So I've just gone through this and this is safe. I suspect that it was
moved to free_task() because it was not considered high-priority work,
i.e. nobody depended on the filter being released at a certain point.
That's changed with the notifier so yes, we could move this.

> inc-from-zero? (Actually, all our refcount_inc()s should be
> refcount_inc_not_zero() just for robustness.) I *think* we can do it

I think this was mentioned in another mail refcount_inc() does that
check. Believe me, I know that from other debugging experience. ;)

> before the release_thread() call (instead of after cgroup_release()).
> 
> With that, then seccomp_filter_release() could assign the filter to NULL
> and do the clean up:
> 
> void seccomp_filter_release(const struct task_struct *tsk)
> {
> 	struct seccomp_filter *orig = READ_ONCE(tsk->seccomp.filter);
> 
> 	smp_store_release(&tsk->seccomp.filter, NULL);

I need to go through the memory ordering requirements before I can say
yay or nay confidently to this. :)

> 	__seccomp_filter_release(orig);
> }
> 
> All other refcounting is then internal to seccomp.c. Which brings me
> back to TSYNC, since we don't want to write NULL to task->seccomp.filter
> during TSYNC. TSYNC can use:
> 
> void __seccomp_filter_release(struct seccomp_filter *filter)
> {
> 	while (filter && refcount_dec_and_test(&filter->live)) {
> 		if (waitqueue_active(&filter->wqh))
> 			wake_up_poll(&filter->wqh, EPOLLHUP);
> 		filter = filter->prev;
> 	}
> 	__put_seccomp_filter(filter);
> }
> 
> Thoughts?
> 
> -- 
> Kees Cook
