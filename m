Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5908F206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n6DYWrYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGIXeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:33:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7EBC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 16:33:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so1790755pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMVMERBa3n6t1yy42c7xcXYZrq+9HmJyYFckhx5FBC4=;
        b=n6DYWrYqvA0mSbr7kAaCvE8dGSSwWmpUAYgt0K1jhG6T7tqUVwL/HIpa7JKKo2wh/c
         4IelPg4pzSTffak/BNQRr9fZ9l5SWVFOY5RBD3ks3IFE6Z/XWs58QvhAS13XJTuMXPSf
         G63Iwq1rBVLVJLSTJPe5RqpVV13ecKMkHk9KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMVMERBa3n6t1yy42c7xcXYZrq+9HmJyYFckhx5FBC4=;
        b=prreJwrlIfKaM+SMChmHZkJ2bO9lHYpj+bQlTxmLXCscAmqUVV0tsBwPcrh3Om/PPP
         T4J/4i1OpoqYliIiOYZlguQkejX2FO4smNTvzkQ2pTiiZKiR1J4XfNGbvrZxvjCxVQoF
         w8VhZozLQgSPrw3BIJgXD21JXJxs0PW0PL5kQPU4ce2Z9258lSQCoBrTEenfrSvH+NIJ
         OLnQ4MGOS+gfTzsctjDTyJW1ysYmlsgt7Wvb+cKONQ9bm8oX4pDklOaKIx79KksF8x2i
         uyOwGxNSJ8KjgomuLgFRUF58Egm7N+iI7COr+JiVBKPhJGNxahwmo9fy5A6MJV+3BRmc
         Wcsw==
X-Gm-Message-State: AOAM532qI6jwpOlgXt8kj/loDlFwtEXGt5hWGIMnJdyO+ABO3/ai3fQj
        jYwFdhrBQmVC6W+OVzPFlm4xsg==
X-Google-Smtp-Source: ABdhPJxODRndQmbz4BmMtkFTntbupkXRNKY3tqWqBrXw+yR+1UGEvrsIZGo+1pRksQ8SBFy7BRK6eg==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr45216879pll.175.1594337639048;
        Thu, 09 Jul 2020 16:33:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e195sm3741442pfh.218.2020.07.09.16.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:33:58 -0700 (PDT)
Date:   Thu, 9 Jul 2020 16:33:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>
Subject: Re: [PATCH v2] kernel: Implement selective syscall userspace
 redirection
Message-ID: <202007091549.1E457D4@keescook>
References: <20200709043840.4189530-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709043840.4189530-1-krisman@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 12:38:40AM -0400, Gabriel Krisman Bertazi wrote:
> [...]
> +config SYSCALL_USER_DISPATCH
> +	bool "Support rejecting syscalls not coming from a dispatcher"

bike shed: this doesn't really describe why it's useful. Maybe:

	bool "Support syscall redirection to userspace dispatcher"

> +	depends on HAVE_ARCH_SYSCALL_USER_DISPATCH
> +	help
> +	  Enable tasks to ask the kernel to redirect syscalls not
> +	  issued from a predefined dispatcher back to userspace,
> +	  depending on a userspace selector.

	depending on a userspace memory selector.

?

> [...]
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -138,6 +138,11 @@ static long syscall_trace_enter(struct pt_regs *regs)
>  			return -1L;
>  	}
>  
> +	if (work & _TIF_SYSCALL_USER_DISPATCH) {
> +		if (do_syscall_user_dispatch(regs))
> +			return -1L;
> +	}
> +

Nice; I like this! It's very small, and now I want to refactor seccomp
to be so pretty. :)

> [...]
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a70327..44f0ce352a0d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1502,6 +1502,8 @@ void setup_new_exec(struct linux_binprm * bprm)
>  
>  	arch_setup_new_exec();
>  
> +	clear_tsk_syscall_user_dispatch(me);
> +

To keep this as arch-agnostic as possible, I actually think this belongs
in begin_new_exec() instead, after the personality clearing. If it were
to be less arch-agnostic, I'd recommend it live in arch_setup_new_exec()
(which most other TIF flags get cleared), but I'd like to have this
feature as a good example of an "easy" refactor into arch-agnostic in
the future. :P

> [...]
> @@ -285,6 +285,7 @@ typedef struct siginfo {
>   */
>  #define SYS_SECCOMP	1	/* seccomp triggered */
>  #define NSIGSYS		1
> +#define SYS_USER_REDIRECT 2

More than just what willy suggested, but you also need to bump NSIGSYS
(I missed that in the RFC). This should read as:

#define SYS_SECCOMP		1	/* seccomp triggered */
#define SYS_USER_REDIRECT	2
#define NSIGSYS			2

(i.e. NSIGSYS is "how many si codes are there for sigsys?")

> [...]
> +int do_syscall_user_dispatch(struct pt_regs *regs)
> +{
> +	int state;
> +
> +	if (current->syscall_dispatch.dispatcher == instruction_pointer(regs))
> +		return 0;

Just to clarify what willy was talking about -- since you're using
"dispatcher" as a scalar (and not dereferencing it, etc), it can just
stay "unsigned long" without __user.

In the documentation for the future "range inclusive" check, maybe also
note that it's the inclusive ranger covering the _starting_ address of
the syscall entry, in case anyone thinks they need to decode instruction
lengths to get the right range, which they don't and I imagine you don't
care about.

> +
> +	if (current->syscall_dispatch.selector) {
> +		if (__get_user(state, current->syscall_dispatch.selector))
> +			do_exit(SIGSEGV);
> +
> +		switch (state) {
> +		case PR_SYSCALL_DISPATCH_DISABLE:
> +			return 0;
> +		case PR_SYSCALL_DISPATCH_ENABLE:
> +			break;
> +		default:
> +			do_exit(SIGSEGV);
> +		}
> +	}
> +
> +	syscall_rollback(current, regs);
> +	trigger_sigsys(regs);
> +
> +	return 1;

How should do_syscall_user_dispatch() approach branch hinting? For example,
is dispatcher == instruction_pointer going to be the common case for
users of this? I would expect not. So maybe, at the top:

	if (unlikely(current->syscall_dispatch.dispatcher == instruction_pointer(regs)))
		return 0;

and what about the selector? I assume it would be common for the selector
to be set, and enabled:

	if (likely(current->syscall_dispatch.selector)) {
		if (__get_user(state, current->syscall_dispatch.selector))
			do_exit(SIGSEGV);

		if (unlikely(state != PR_SYSCALL_DISPATCH_ENABLE)) {
			if (likely(state == PR_SYSCALL_DISPATCH_DISABLE))
				return 0;
			do_exit(SIGSEGV);
		}
	}

	syscall_rollback...

Or, perhaps micro-optimization doesn't matter at all here give the
overhead of signal delivery, and you can just ignore me and leave this
as-is, which is fine too. :)


This continues to look really nice. Very simple, very powerful. I think
I'd like to see one more thing: a selftest! I think it should be very
easy to add; model it after the seccomp selftests:

tools/testing/selftests/seccomp/seccomp_bpf.c

The testing harness there should make it very easy to produce a test,
and it's easy to wire up to the Makefiles. I'm happy to help point you
in the right directions. If you want, you could even share seccomp's
directory, but maybe you want your own. :)

-- 
Kees Cook
