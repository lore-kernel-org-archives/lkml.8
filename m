Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E79C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DA020776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OmJBhJ/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391558AbgE1XLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbgE1XLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:11:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C02FC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:11:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so197417plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hhHN359Ew47gJ5gX5WV0SNMAZS6D9j63wv90uny4S/0=;
        b=OmJBhJ/0IOIFDk5mPrGlIKKqb2/s3ePzbjtaWJQDOCZlPx/tukVzOJxLUVy8+usxc9
         ie2xnQk1GQKWJFPEEfspASUg4SxD6HOIkE3LbppNsxHjIOu1OpFsAj8zTc/AcsY+rjaZ
         jRReSg1yY82ZNFp0NLVC3jH2lqR5KyWzJ63Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hhHN359Ew47gJ5gX5WV0SNMAZS6D9j63wv90uny4S/0=;
        b=QKAUvxsRKgEX7rwvMM74VpBr4VGqSbZbKVYUjYm3Gfq7ZDccMoMDGAwQVwo9BUPzmG
         zO9WuQXpHwXTJtE9lIPvoKoTQMIv+QXBNhu75P/sLv0aEtH/ZCI+MWInsxGa8C+KJr94
         xqeq8FTMQu51UdmiM1ug6Ftlbdpln2in9+kzS0ERojQsep1praNgs0JWK2i+BQJygYIw
         dLGpgj8EMdwSfL0Xu1rG0ygPuT32GLfuh11LQGqS5k70QUlOon09iO7EYhr87t2N5lcK
         GRKmTqBIDOyE8jeM5gK6WUtYnSMNsl6Bj8ahpPoJilY3ayvA4GxN/Ib4nyp6pZJRumq5
         8zUg==
X-Gm-Message-State: AOAM532XvIxnO6aVbGUgKKl5seO4RbzUmYLlzh4gpu/32Ra4HW3aDmxT
        Kb/cAy3b8qyR7R2/PBGdTDLGRSMCmVzTjg==
X-Google-Smtp-Source: ABdhPJwLHjBFG1zCoyVNQBoVW72L17zkcrxlZ82pL3WrE04iAHIMsfVEpLPHDZHbFqpOFoBq2SV78g==
X-Received: by 2002:a17:90a:f0cd:: with SMTP id fa13mr6055915pjb.95.1590707462976;
        Thu, 28 May 2020 16:11:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x20sm5422372pfc.211.2020.05.28.16.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:11:01 -0700 (PDT)
Date:   Thu, 28 May 2020 16:11:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Message-ID: <202005281404.276641223F@keescook>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528151412.265444-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 05:14:11PM +0200, Christian Brauner wrote:
>   * @usage: reference count to manage the object lifetime.
>   *         get/put helpers should be used when accessing an instance
>   *         outside of a lifetime-guarded section.  In general, this
>   *         is only needed for handling filters shared across tasks.
> [...]
> + * @live: Number of tasks that use this filter directly and number
> + *	  of dependent filters that have a non-zero @live counter.
> + *	  Altered during fork(), exit(), and filter installation
> [...]
>  	refcount_set(&sfilter->usage, 1);
> +	refcount_set(&sfilter->live, 1);

I'd like these reference counters to have more descriptive names. "usage"
by what? "live" from what perspective? At the least, I think we need
to be explicit in the comment, and at best we should do that and rename
them to be a bit more clear.

A filter's "usage" is incremented for each directly-attached task
(task::seccomp_data.filter, via fork() or thread_sync), once for the
dependent filter (filter::prev), and once for an open user_notif file
(file::private_data). When it reaches zero, there are (should be) no more
active memory references back to the struct filter and it can be freed.

A filter's "live" is incremented for each directly-attached task
(task::seccomp_data.filter, via fork() or thread_sync), and once for
the dependent filter (filter::prev). When it reaches zero there is no
way for new tasks to get associated with the filter, but there may still
be user_notif file::private_data references pointing at the filter.

But we're tracking "validity lifetime" (live) and "memory reference
safety" (usage).

signal_struct has "sigcnt" and "live". I find "sigcnt" to be an
unhelpful name too. (And why isn't it refcount_t?)

So, perhaps leave "live", but rename "usage" -> "references".

After looking at these other lifetime management examples in the kernel,
I'm convinced that tracking these states separately is correct, but I
remain uncomfortable about task management needing to explicitly make
two calls to let go of the filter.

I wonder if release_task() should also detach the filter from the task
and do a put_seccomp_filter() instead of waiting for task_free(). This
is supported by the other place where seccomp_filter_release() is
called:

> @@ -396,6 +400,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
>  		 * allows a put before the assignment.)
>  		*/
>   		put_seccomp_filter(thread);
> +		seccomp_filter_release(thread);

This would also remove the only put_seccomp_filter() call outside of
seccomp.c, since the free_task() call will be removed now in favor of
the task_release() call.

So, is it safe to detach the filter in release_task()? Has dethreading
happened yet? i.e. can we race TSYNC? -- is there a possible
inc-from-zero? (Actually, all our refcount_inc()s should be
refcount_inc_not_zero() just for robustness.) I *think* we can do it
before the release_thread() call (instead of after cgroup_release()).

With that, then seccomp_filter_release() could assign the filter to NULL
and do the clean up:

void seccomp_filter_release(const struct task_struct *tsk)
{
	struct seccomp_filter *orig = READ_ONCE(tsk->seccomp.filter);

	smp_store_release(&tsk->seccomp.filter, NULL);
	__seccomp_filter_release(orig);
}

All other refcounting is then internal to seccomp.c. Which brings me
back to TSYNC, since we don't want to write NULL to task->seccomp.filter
during TSYNC. TSYNC can use:

void __seccomp_filter_release(struct seccomp_filter *filter)
{
	while (filter && refcount_dec_and_test(&filter->live)) {
		if (waitqueue_active(&filter->wqh))
			wake_up_poll(&filter->wqh, EPOLLHUP);
		filter = filter->prev;
	}
	__put_seccomp_filter(filter);
}

Thoughts?

-- 
Kees Cook
