Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5162073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iCv0KBSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFAT3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgFAT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:29:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:29:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so3958825pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ed7K7EnfA24tmuA9VZcYpyrL6EFBUJRTSLAvUbru2w=;
        b=iCv0KBSY453nJzPCzEUvPlbhoxcQwBQwvxKvbAQEw4Si1Ohl8wqh0Q/saXIpPV7KCi
         /OsfiBxdNZzr9PBqbMDUpJlLZeORvjmyQeAp17cGywBk3Wa6aHL5hvyFTN0rJCvRFcNn
         Rk4sxszjnJqlqHvH1nW/KyB79p3ZTs/mKlKqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ed7K7EnfA24tmuA9VZcYpyrL6EFBUJRTSLAvUbru2w=;
        b=c1UVTkEkEkkuLM6WsFXtYAP+K2d3f822j3/0ZQXOc0/dLP+Wi8JbM0G0GIxleMbuOr
         dIORwergFwhC1nSpLhwIxpm80g54AuUCSoxxqiDQE/KFA7WvltkvcT2hdUruBqoYmgYJ
         R/mqcXgKQk+aV0+Pb8j0Z6jHeMsT7tiVDh9rS5ud/k8m8B0Clf6YAbn6gaQnEMNlr83p
         bi93iSn7Z65VpOB+VZ9WoBtitl3o0P0n1GS8aum1si09Z9rXxjRt4quX4aAJtDq7jFCm
         FGDbV9yj52kHucNhNydrCkqmI9Q+TNPDe5v1CGkjhWVL34AFB9G+0pkMB5YJJ3B/A+fe
         WDug==
X-Gm-Message-State: AOAM533AaUjX6eD6yCQxIVUCP+sprw8sPQJUDjxgPf09bV8YbgTBpQly
        LLIl5C1HEBjLTKLBpLqj/NVK5Q==
X-Google-Smtp-Source: ABdhPJxKBL2TdXAecOdIz6xYixOLWmk+602INAjaO7A6CopQZJ5fKikeWLKRpLYYTW3EYGwfvPATHQ==
X-Received: by 2002:a63:6f04:: with SMTP id k4mr20806491pgc.313.1591039769330;
        Mon, 01 Jun 2020 12:29:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm174296pfh.175.2020.06.01.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:29:28 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:29:27 -0700
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
Subject: Re: [PATCH v3 3/4] seccomp: notify about unused filter
Message-ID: <202006011225.E58FC9CCA@keescook>
References: <20200531115031.391515-1-christian.brauner@ubuntu.com>
 <20200531115031.391515-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531115031.391515-3-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 01:50:30PM +0200, Christian Brauner wrote:
> We've been making heavy use of the seccomp notifier to intercept and
> handle certain syscalls for containers. This patch allows a syscall
> supervisor listening on a given notifier to be notified when a seccomp
> filter has become unused.
> 
> A container is often managed by a singleton supervisor process the
> so-called "monitor". This monitor process has an event loop which has
> various event handlers registered. If the user specified a seccomp
> profile that included a notifier for various syscalls then we also
> register a seccomp notify even handler. For any container using a
> separate pid namespace the lifecycle of the seccomp notifier is bound to
> the init process of the pid namespace, i.e. when the init process exits
> the filter must be unused.
> If a new process attaches to a container we force it to assume a seccomp
> profile. This can either be the same seccomp profile as the container
> was started with or a modified one. If the attaching process makes use
> of the seccomp notifier we will register a new seccomp notifier handler
> in the monitor's event loop. However, when the attaching process exits
> we can't simply delete the handler since other child processes could've
> been created (daemons spawned etc.) that have inherited the seccomp
> filter and so we need to keep the seccomp notifier fd alive in the event
> loop. But this is problematic since we don't get a notification when the
> seccomp filter has become unused and so we currently never remove the
> seccomp notifier fd from the event loop and just keep accumulating fds
> in the event loop. We've had this issue for a while but it has recently
> become more pressing as more and larger users make use of this.
> 
> To fix this, we introduce a new "users" reference counter that tracks
> any tasks and dependent filters making use of a filter. When a notifier is
> registered waiting tasks will be notified that the filter is now empty by
> receiving a (E)POLLHUP event.
> The concept in this patch introduces is the same as for signal_struct,
> i.e. reference counting for life-cycle management is decoupled from
> reference counting taks using the object.
> 
> There's probably some trickery possible but the second counter is just
> the correct way of doing this imho and has precedence. The patch also
> lifts the waitqeue from struct notification into sruct seccomp_filter.
> This is cleaner overall and let's us avoid having to take the notifier
> mutex since we neither need to read nor modify the notifier specific
> aspects of the seccomp filter. In the exit path I'd very much like to
> avoid having to take the notifier mutex for each filter in the task's
> filter hierarchy.
> 
> Cc: Tycho Andersen <tycho@tycho.ws>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Sargun Dhillon <sargun@sargun.me>
> Cc: Jann Horn <jannh@google.com>
> Cc: Chris Palmer <palmer@google.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Robert Sesek <rsesek@google.com>
> Cc: Jeffrey Vander Stoep <jeffv@google.com>
> Cc: Linux Containers <containers@lists.linux-foundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> - Jann Horn <jannh@google.com>:
>   - Use more descriptive instead of seccomp_filter_notify().
>     (I went with seccomp_filter_release().)
> 
> /* v3 */
> - Kees Cook <keescook@chromium.org>:
>   - Rename counter from "live" to "users".
> ---
>  kernel/seccomp.c | 68 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 55251b1fe03f..45244f1ba148 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -94,13 +94,11 @@ struct seccomp_knotif {
>   *           filter->notify_lock.
>   * @next_id: The id of the next request.
>   * @notifications: A list of struct seccomp_knotif elements.
> - * @wqh: A wait queue for poll.
>   */

I split the wait queue changes into a separate patch...

>  /**
> - * seccomp_filter_release - Detach the task from its filter tree
> - *			    and drop its reference count during
> - *			    exit.
> + * seccomp_filter_release - Detach the task from its filter tree,
> + *			    drop its reference count, and notify
> + *			    about unused filters
>   *
>   * This function should only be called when the task is exiting as
>   * it detaches it from its filter tree.
>   */
>  void seccomp_filter_release(struct task_struct *tsk)
>  {
> -	struct seccomp_filter *cur = tsk->seccomp.filter;
> +	struct seccomp_filter *orig = tsk->seccomp.filter;
>  
> +	/* Detach task from its filter tree. */
>  	tsk->seccomp.filter = NULL;
> -	__put_seccomp_filter(cur);
> +	/* Notify about any unused filters in the task's former filter tree. */
> +	__seccomp_filter_orphan(orig);
> +	/* Finally drop all references to the task's former tree. */
> +	__put_seccomp_filter(orig);
>  }

I added __seccomp_filter_release() to do the filter-specific parts (the
two functions passing "orig" above, so that it can be reused later...

>  
>  /**
> @@ -419,18 +441,29 @@ static inline void seccomp_sync_threads(unsigned long flags)
>  	/* Synchronize all threads. */
>  	caller = current;
>  	for_each_thread(caller, thread) {
> +		struct seccomp_filter *cur = thread->seccomp.filter;
> +
>  		/* Skip current, since it needs no changes. */
>  		if (thread == caller)
>  			continue;
>  
>  		/* Get a task reference for the new leaf node. */
>  		get_seccomp_filter(caller);
> +
> +		/*
> +		 * Notify everyone as we're forcing the thread
> +		 * to orphan its current filter tree.
> +		 */
> +		__seccomp_filter_orphan(cur);
> +
>  		/*
> -		 * Drop the task reference to the shared ancestor since
> -		 * current's path will hold a reference.  (This also
> -		 * allows a put before the assignment.)
> +		 * Drop the task's reference to the shared ancestor
> +		 * since current's path will hold a reference.
> +		 * (This also allows a put before the assignment.)
>  		 */
> -		__put_seccomp_filter(thread->seccomp.filter);
> +		__put_seccomp_filter(cur);

I switched this around to just call the new __seccomp_release_filter()
(there's no need to open-code this and add "cur"). I also removed the
comment about the notification, because that's not possible: "thread"
shares the same filter hierarchy as "caller", so the counts on "cur"
cannot reach 0 (no notifications can ever happen due to TSYNC).

Everything else looks great! I've applied it to for-next/seccomp.

-- 
Kees Cook
