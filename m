Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B837FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B62020656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4nnEJcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgGPUwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgGPUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:52:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35748C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:52:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so5244072pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aquIO2FGAE3lkoXCYp5iGwupgQI/65LCYOM68Vjw6Tk=;
        b=e4nnEJcZ/2dm2oYM392D+Ygv7VRrVE4tmm+yuKAqRtbsZNjS/1PkZ46Uxg8lMawtjg
         El2Z81ViYhNC0aaun3sECRkjhMsnRv98wWpt8kupNRE2/dtD/TMRkXdwdzaMZqMcaa4L
         ei0O+fZuVfuoMtxgfqNKcekKxywb2hDgAl3ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aquIO2FGAE3lkoXCYp5iGwupgQI/65LCYOM68Vjw6Tk=;
        b=oF05Aj5n+gcdBFxOAt1R2vYk5fn1RWjXlkDY7b4HAgN0jEN5kxp9CQQv/x9FJHCkK4
         Fwu7eALHu0w8rTeBTrCiz0XmrUxtl8FZgli8wbZPxj0pUVcDkOLGLlc6aa0uc5yOcaxF
         9smuTkndXX5mura5VinaKHpMt5y0ikv05vfMST4FOwimaUVrQYeux7A0ibvbDb99OLnZ
         IZbHuHupXgBulQsJkouiLneyjX/tLCTx6RmjmzoMq8lNuj/AThS9ZH3HPJFq7S1bc1+0
         yDUyBdrH4adZnEXuaioEEUVAGxJr3TOYXAb55Ym2UXZIZF9RQgzyh3LWQ30kgP0QmjY4
         QBAg==
X-Gm-Message-State: AOAM533IZgMmtP9k32XN3Weg7ZXS8opFvyut5t4DndMrqxGHdyUeMDFL
        3MPDgcVnP7PypSAMuIuEgCRQYw==
X-Google-Smtp-Source: ABdhPJzbQgJCDG9LnefQx5i570VFQUbYsZndgRWWuoW2VeaNkft010xcMMlGVftM1UOa8T+so1E6cQ==
X-Received: by 2002:a17:902:a611:: with SMTP id u17mr5040902plq.263.1594932755485;
        Thu, 16 Jul 2020 13:52:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4sm5532894pgk.68.2020.07.16.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:52:34 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:52:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry
 functionality
Message-ID: <202007161336.B993ED938@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.011950288@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716185424.011950288@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:09PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> On syscall entry certain work needs to be done:
> 
>    - Establish state (lockdep, context tracking, tracing)
>    - Conditional work (ptrace, seccomp, audit...)
> 
> This code is needlessly duplicated and  different in all
> architectures.
> 
> Provide a generic version based on the x86 implementation which has all the
> RCU and instrumentation bits right.

Ahh! You're reading my mind! I was just thinking about this while
reviewing the proposed syscall redirection series[1], and pondering the
lack of x86 TIF flags, and that nearly everything in the series (and for
seccomp and other things) didn't need to be arch-specific. And now that
series absolutely needs to be rebased and it'll magically work for every
arch that switches to the generic entry code. :)

Notes below...

[1] https://lore.kernel.org/lkml/20200716193141.4068476-2-krisman@collabora.com/

> +/*
> + * Define dummy _TIF work flags if not defined by the architecture or for
> + * disabled functionality.
> + */

When I was thinking about this last week I was pondering having a split
between the arch-agnositc TIF flags and the arch-specific TIF flags, and
that each arch could have a single "there is agnostic work to be done"
TIF in their thread_info, and the agnostic flags could live in
task_struct or something. Anyway, I'll keep reading...

> +/**
> + * syscall_enter_from_user_mode - Check and handle work before invoking
> + *				 a syscall
> + * @regs:	Pointer to currents pt_regs
> + * @syscall:	The syscall number
> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * disabled. The calling code has to be non-instrumentable. When the
> + * function returns all state is correct and the subsequent functions can be
> + * instrumented.
> + *
> + * Returns: The original or a modified syscall number
> + *
> + * If the returned syscall number is -1 then the syscall should be
> + * skipped. In this case the caller may invoke syscall_set_error() or
> + * syscall_set_return_value() first.  If neither of those are called and -1
> + * is returned, then the syscall will fail with ENOSYS.

There's been some recent confusion over "has the syscall changed,
or did seccomp request it be skipped?" that was explored in arm64[2]
(though I see Will and Keno in CC already). There might need to be a
clearer way to distinguish between "wild userspace issued a -1 syscall"
and "seccomp or ptrace asked for the syscall to be skipped". The
difference is mostly about when ENOSYS gets set, with respect to calls
to syscall_set_return_value(), but if the syscall gets changed, the arch
may need to recheck the value and consider ENOSYS, etc. IIUC, what Will
ended up with[3] was having syscall_trace_enter() return the syscall return
value instead of the new syscall.

[2] https://lore.kernel.org/lkml/20200704125027.GB21185@willie-the-truck/
[3] https://lore.kernel.org/lkml/20200703083914.GA18516@willie-the-truck/

> +static long syscall_trace_enter(struct pt_regs *regs, long syscall,
> +				unsigned long ti_work)
> +{
> +	long ret = 0;
> +
> +	/* Handle ptrace */
> +	if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> +		ret = arch_syscall_enter_tracehook(regs);
> +		if (ret || (ti_work & _TIF_SYSCALL_EMU))
> +			return -1L;
> +	}
> +
> +	/* Do seccomp after ptrace, to catch any tracer changes. */
> +	if (ti_work & _TIF_SECCOMP) {
> +		ret = arch_syscall_enter_seccomp(regs);
> +		if (ret == -1L)
> +			return ret;
> +	}
> +
> +	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
> +		trace_sys_enter(regs, syscall);
> +
> +	arch_syscall_enter_audit(regs);
> +
> +	return ret ? : syscall;
> +}

Modulo the notes about -1 vs syscall number above, this looks correct to
me for ptrace and seccomp.

-- 
Kees Cook
