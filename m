Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F894C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3336D214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OAD7nK7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCCFsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:48:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45860 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCCFsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:48:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so878146pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 21:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5j43Mr/bIrOBMk42mKrN2eImbOvbfPNmFOTHSb411kg=;
        b=OAD7nK7jEoAlZecHBF+pnbuP/UPbpiVptrt3hVUEk4WE3IiIyEzFqMVYyAfhlzvDYB
         tMbkY8MXm6lWVLO8RpQ3Wfsd1LJ6XnEYwgjQGp7KBUI503tqt0Kv3BhKjoVIgTPHSXfQ
         zu20aUo7oMZw5nJnLi+MJqJWi+OsA9bj6ZCmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5j43Mr/bIrOBMk42mKrN2eImbOvbfPNmFOTHSb411kg=;
        b=LyJ6yZ9ArlMbTUZsSS6kiSzf1Ibb3hkQ61o690K6PVfdxlBszyRlMEvP/YGstEROyx
         Lczu4uzqt5ZOWdNGmNUFnsQe2rHI1KjfCrML2oi+3LLfWbUh9wQreVA+zkWR+7ioe3Uh
         Ot17dcAEJ/Nl+vbH/DFA44qmzputKur6wRnH4ZgnzLTX8QlTWbV9CKjsLIkvNXIJAW3K
         mfwsgYNx/zGHfhewfDF8EQ4hZO+/YPGtq/92LH3X+tbDBODZ11pGvk8Smd1lXGs1bjq8
         RL7QwMEJbaqjC6SMvGM9nKU0zQVm7pRG/SvJ+mJysfvaz3ALwGUTI7TB4gd8ySORmesy
         xLEw==
X-Gm-Message-State: ANhLgQ2xTRBBtT3NQ4MSoUNBhenPnu0AVXq/kgpn/ap48CtYDXBR9u1u
        Z0sIkXKNpPyAHrO9AJbhTu/+MhyXvuc=
X-Google-Smtp-Source: ADFU+vvAWValoWq+mvhmEKBoPMhA9c5Z1OYRN9ioAJ+TBELqd7BE10KhyP8MTNGLiYHsRpYijY11WA==
X-Received: by 2002:a63:e053:: with SMTP id n19mr1049656pgj.64.1583214516048;
        Mon, 02 Mar 2020 21:48:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y142sm14629115pfb.25.2020.03.02.21.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 21:48:35 -0800 (PST)
Date:   Mon, 2 Mar 2020 21:48:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, Matthew Denton <mpdenton@google.com>
Subject: Re: [PATCH] seccomp: allow TSYNC and USER_NOTIF together
Message-ID: <202003022137.9DAB55E6F0@keescook>
References: <20200206165027.18415-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206165027.18415-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:50:27AM -0700, Tycho Andersen wrote:
> The restriction introduced in 7a0df7fbc145 ("seccomp: Make NEW_LISTENER and
> TSYNC flags exclusive") is mostly artificial: there is enough information
> in a seccomp user notification to tell which thread triggered a
> notification. The reason it was introduced is because TSYNC makes the
> syscall return a thread-id on failure, and NEW_LISTENER returns an fd, and
> there's no way to distinguish between these two cases (well, I suppose the
> caller could check all fds it has, then do the syscall, and if the return
> value was an fd that already existed, then it must be a thread id, but
> bleh).
> 
> Matthew would like to use these two flags together in the Chrome sandbox
> which wants to use TSYNC for video drivers and NEW_LISTENER to proxy
> syscalls.
> 
> So, let's fix this ugliness by adding another flag, NO_TID_ON_TSYNC_ERR,
> which tells the kernel to just return -EAGAIN on a TSYNC error. This way,
> NEW_LISTENER (and any subsequent seccomp() commands that want to return
> positive values) don't conflict with each other.
> 
> Suggested-by: Matthew Denton <mpdenton@google.com>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Thanks for this! (And thanks for waiting on my review!) Yeah, this
makes things much more sensible. If we get a third thing that wants
to be returned, we'll have to rev the userspace struct API to have an
"output" area. :P

Bike shedding below...

> ---
>  include/linux/seccomp.h                       |  3 +-
>  include/uapi/linux/seccomp.h                  |  1 +
>  kernel/seccomp.c                              | 14 +++-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 74 ++++++++++++++++++-
>  4 files changed, 86 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 03583b6d1416..e0560a941ed1 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -7,7 +7,8 @@
>  #define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC | \
>  					 SECCOMP_FILTER_FLAG_LOG | \
>  					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
> -					 SECCOMP_FILTER_FLAG_NEW_LISTENER)
> +					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
> +					 SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR)
>  
>  #ifdef CONFIG_SECCOMP
>  
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index be84d87f1f46..64678cc20e18 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -22,6 +22,7 @@
>  #define SECCOMP_FILTER_FLAG_LOG			(1UL << 1)
>  #define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
>  #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
> +#define SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR	(1UL << 4)

Bikeshed: what do you think about calling this

SECCOMP_FILTER_FLAG_TSYNC_ESRCH

to mean "I don't care _which_ thread, just fail" (See below about the
ESRCH bit...)

>  
>  /*
>   * All BPF programs must return a 32-bit value.
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index b6ea3dcb57bf..fa01ec085d60 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -528,8 +528,12 @@ static long seccomp_attach_filter(unsigned int flags,
>  		int ret;
>  
>  		ret = seccomp_can_sync_threads();
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			if (flags & SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR)
> +				return -EAGAIN;

Hm hm, I think EAGAIN is wrong here: this isn't likely to be a transient
failure (unless the offending thread dies). The two ways TSYNC can fail
are if a thread has seccomp mode 1 set, or if the thread's filter
ancestry has already diverged. Trying again isn't really going to help
(which is why the original motivation was to return thread details to
help debug why TSYNC failed).

In the case where the thread id can't be found (container visibility??),
we fail with -ESRCH. That might be more sensible than -EAGAIN here. (Or
maybe -EBUSY?)

> +			else
> +				return ret;
> +		}
>  	}
>  
>  	/* Set log flag, if present. */
> @@ -1288,10 +1292,12 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  	 * In the successful case, NEW_LISTENER returns the new listener fd.
>  	 * But in the failure case, TSYNC returns the thread that died. If you
>  	 * combine these two flags, there's no way to tell whether something
> -	 * succeeded or failed. So, let's disallow this combination.
> +	 * succeeded or failed. So, let's disallow this combination if the user
> +	 * has not explicitly requested no errors from TSYNC.
>  	 */
>  	if ((flags & SECCOMP_FILTER_FLAG_TSYNC) &&
> -	    (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER))
> +	    (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) &&
> +	    ((flags & SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR) == 0))
>  		return -EINVAL;
>  
>  	/* Prepare the new filter before holding any locks. */
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index ee1b727ede04..b7ec8655dd1c 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -212,6 +212,10 @@ struct seccomp_notif_sizes {
>  #define SECCOMP_USER_NOTIF_FLAG_CONTINUE 0x00000001
>  #endif
>  
> +#ifndef SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR
> +#define SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR (1UL << 4)
> +#endif
> +
>  #ifndef seccomp
>  int seccomp(unsigned int op, unsigned int flags, void *args)
>  {
> @@ -2187,7 +2191,8 @@ TEST(detect_seccomp_filter_flags)
>  	unsigned int flags[] = { SECCOMP_FILTER_FLAG_TSYNC,
>  				 SECCOMP_FILTER_FLAG_LOG,
>  				 SECCOMP_FILTER_FLAG_SPEC_ALLOW,
> -				 SECCOMP_FILTER_FLAG_NEW_LISTENER };
> +				 SECCOMP_FILTER_FLAG_NEW_LISTENER,
> +				 SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR };
>  	unsigned int exclusive[] = {
>  				SECCOMP_FILTER_FLAG_TSYNC,
>  				SECCOMP_FILTER_FLAG_NEW_LISTENER };
> @@ -2645,6 +2650,55 @@ TEST_F(TSYNC, two_siblings_with_one_divergence)
>  	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
>  }
>  
> +TEST_F(TSYNC, two_siblings_with_one_divergence_no_tid_in_err)
> +{
> +	long ret, flags;
> +	void *status;
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> +	}
> +
> +	ret = seccomp(SECCOMP_SET_MODE_FILTER, 0, &self->root_prog);
> +	ASSERT_NE(ENOSYS, errno) {
> +		TH_LOG("Kernel does not support seccomp syscall!");
> +	}
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support SECCOMP_SET_MODE_FILTER!");
> +	}
> +	self->sibling[0].diverge = 1;
> +	tsync_start_sibling(&self->sibling[0]);
> +	tsync_start_sibling(&self->sibling[1]);
> +
> +	while (self->sibling_count < TSYNC_SIBLINGS) {
> +		sem_wait(&self->started);
> +		self->sibling_count++;
> +	}
> +
> +	flags = SECCOMP_FILTER_FLAG_TSYNC | \
> +		SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR;
> +	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &self->apply_prog);
> +	ASSERT_EQ(EAGAIN, errno) {
> +		TH_LOG("Did not return EAGAIN for diverged sibling.");
> +	}
> +	ASSERT_EQ(-1, ret) {
> +		TH_LOG("Did not fail on diverged sibling.");
> +	}
> +
> +	/* Wake the threads */
> +	pthread_mutex_lock(&self->mutex);
> +	ASSERT_EQ(0, pthread_cond_broadcast(&self->cond)) {
> +		TH_LOG("cond broadcast non-zero");
> +	}
> +	pthread_mutex_unlock(&self->mutex);
> +
> +	/* Ensure they are both unkilled. */
> +	PTHREAD_JOIN(self->sibling[0].tid, &status);
> +	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
> +	PTHREAD_JOIN(self->sibling[1].tid, &status);
> +	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
> +}
> +
>  TEST_F(TSYNC, two_siblings_not_under_filter)
>  {
>  	long ret, sib;
> @@ -3196,6 +3250,24 @@ TEST(user_notification_basic)
>  	EXPECT_EQ(0, WEXITSTATUS(status));
>  }
>  
> +TEST(user_notification_with_tsync)
> +{
> +	int ret;
> +	unsigned int flags;
> +
> +	/* these were exclusive */
> +	flags = SECCOMP_FILTER_FLAG_NEW_LISTENER |
> +		SECCOMP_FILTER_FLAG_TSYNC;
> +	ASSERT_EQ(-1, user_trap_syscall(__NR_getppid, flags));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	/* but now they're not */
> +	flags |= SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR;
> +	ret = user_trap_syscall(__NR_getppid, flags);
> +	close(ret);
> +	ASSERT_LE(0, ret);
> +}
> +
>  TEST(user_notification_kill_in_middle)
>  {
>  	pid_t pid;
> -- 
> 2.20.1
> 

Otherwise, yes, let's do this. Much saner. :)

-- 
Kees Cook
