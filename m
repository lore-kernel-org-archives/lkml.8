Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3385CC2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 01:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5192208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 01:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YwjCn3ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJBL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 20:11:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34477 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgBJBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 20:11:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so7712952oig.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 17:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YaJmwBnpr3E8kisAW5q06O5gG08ip3sn9QyXKT4wk/o=;
        b=YwjCn3ZVO8bzbEdT0x+RpLLQQwUYcoJpH2H7z2govbEsy4y6la4Y5Byb+pOG/QhS1Q
         aN81ATOBUPepN0jSyNuthUoHRa0KLKmOZzDXmrIYmI6di6pItBhuTRIR5BgHwZQomR1S
         Jjr7yKhENjyLAnrnqkE9HS+A+s4/3wdWgqI9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YaJmwBnpr3E8kisAW5q06O5gG08ip3sn9QyXKT4wk/o=;
        b=Qu3lV+A/74K67s2WwttWHxM1hLP7FnReknDrgeCJbJLRgheU26MTtR1JG6Rj37dtp0
         eE2r9i14f6bz7rJuMpPc9ZazpBiTEvUgV06seAjeIRVy4Aq4jIfEVtBU9j1qym7Rrno6
         UFyEGSqeP6d/SJ2duAoZzi6+c5eafZxroBc+NPSNr4v+zjG24R9fsICMZZYvVwOFtmWb
         loeVSsUG5aFVT/7AyUXl8/ZqtwFQG8y8kjimXMLSaJzZfpIlYPWdviu6iVRuSs63ba1f
         7QWUA+fJafgPZ9eMGnCllZf8lcpa2ziZNsyGPJbdrgL45PjjSoOXqcJKDGuoaBgbB7BA
         10KQ==
X-Gm-Message-State: APjAAAVhuDNhBO+CYFr/raukjloZLs3UYoMXYO3b6KM8qJEQddXfCvuo
        UCiM0xfWEEQFi4OoPS3GvDV8DQ==
X-Google-Smtp-Source: APXvYqy7ARE8LKD639+raqmWpIr6FSJ5lMe2XE9arL++XQjmHquM1EgXJYHRionJjs4pcsCzclDXHA==
X-Received: by 2002:aca:d610:: with SMTP id n16mr9280153oig.108.1581297087913;
        Sun, 09 Feb 2020 17:11:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s128sm3497271oia.4.2020.02.09.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 17:11:26 -0800 (PST)
Date:   Sun, 9 Feb 2020 17:11:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] riscv: fix seccomp reject syscall code path
Message-ID: <202002091710.A76877B4@keescook>
References: <20200208151817.12383-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208151817.12383-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 08:18:17AM -0700, Tycho Andersen wrote:
> If secure_computing() rejected a system call, we were previously setting
> the system call number to -1, to indicate to later code that the syscall
> failed. However, if something (e.g. a user notification) was sleeping, and
> received a signal, we may set a0 to -ERESTARTSYS and re-try the system call
> again.
> 
> In this case, seccomp "denies" the syscall (because of the signal), and we
> would set a7 to -1, thus losing the value of the system call we want to
> restart.
> 
> Instead, let's return -1 from do_syscall_trace_enter() to indicate that the
> syscall was rejected, so we don't clobber the value in case of -ERESTARTSYS
> or whatever.
> 
> This commit fixes the user_notification_signal seccomp selftest on riscv to
> no longer hang. That test expects the system call to be re-issued after the
> signal, and it wasn't due to the above bug. Now that it is, everything
> works normally.
> 
> Note that in the ptrace (tracer) case, the tracer can set the register
> values to whatever they want, so we still need to keep the code that
> handles out-of-bounds syscalls. However, we can drop the comment.
> 
> We can also drop syscall_set_nr(), since it is no longer used anywhere, and
> the code that re-loads the value in a7 because of it.
> 
> Reported in: https://lore.kernel.org/bpf/CAEn-LTp=ss0Dfv6J00=rCAy+N78U2AmhqJNjfqjr2FDpPYjxEQ@mail.gmail.com/
> 
> Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Funky! Good catch. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/riscv/include/asm/syscall.h |  7 -------
>  arch/riscv/kernel/entry.S        | 11 +++--------
>  arch/riscv/kernel/ptrace.c       | 11 +++++------
>  3 files changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> index 42347d0981e7..49350c8bd7b0 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -28,13 +28,6 @@ static inline int syscall_get_nr(struct task_struct *task,
>  	return regs->a7;
>  }
>  
> -static inline void syscall_set_nr(struct task_struct *task,
> -				  struct pt_regs *regs,
> -				  int sysno)
> -{
> -	regs->a7 = sysno;
> -}
> -
>  static inline void syscall_rollback(struct task_struct *task,
>  				    struct pt_regs *regs)
>  {
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index bad4d85b5e91..208702d8c18e 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -228,20 +228,13 @@ check_syscall_nr:
>  	/* Check to make sure we don't jump to a bogus syscall number. */
>  	li t0, __NR_syscalls
>  	la s0, sys_ni_syscall
> -	/*
> -	 * The tracer can change syscall number to valid/invalid value.
> -	 * We use syscall_set_nr helper in syscall_trace_enter thus we
> -	 * cannot trust the current value in a7 and have to reload from
> -	 * the current task pt_regs.
> -	 */
> -	REG_L a7, PT_A7(sp)
>  	/*
>  	 * Syscall number held in a7.
>  	 * If syscall number is above allowed value, redirect to ni_syscall.
>  	 */
>  	bge a7, t0, 1f
>  	/*
> -	 * Check if syscall is rejected by tracer or seccomp, i.e., a7 == -1.
> +	 * Check if syscall is rejected by tracer, i.e., a7 == -1.
>  	 * If yes, we pretend it was executed.
>  	 */
>  	li t1, -1
> @@ -334,6 +327,7 @@ work_resched:
>  handle_syscall_trace_enter:
>  	move a0, sp
>  	call do_syscall_trace_enter
> +	move t0, a0
>  	REG_L a0, PT_A0(sp)
>  	REG_L a1, PT_A1(sp)
>  	REG_L a2, PT_A2(sp)
> @@ -342,6 +336,7 @@ handle_syscall_trace_enter:
>  	REG_L a5, PT_A5(sp)
>  	REG_L a6, PT_A6(sp)
>  	REG_L a7, PT_A7(sp)
> +	bnez t0, ret_from_syscall_rejected
>  	j check_syscall_nr
>  handle_syscall_trace_exit:
>  	move a0, sp
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 407464201b91..444dc7b0fd78 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -148,21 +148,19 @@ long arch_ptrace(struct task_struct *child, long request,
>   * Allows PTRACE_SYSCALL to work.  These are called from entry.S in
>   * {handle,ret_from}_syscall.
>   */
> -__visible void do_syscall_trace_enter(struct pt_regs *regs)
> +__visible int do_syscall_trace_enter(struct pt_regs *regs)
>  {
>  	if (test_thread_flag(TIF_SYSCALL_TRACE))
>  		if (tracehook_report_syscall_entry(regs))
> -			syscall_set_nr(current, regs, -1);
> +			return -1;
>  
>  	/*
>  	 * Do the secure computing after ptrace; failures should be fast.
>  	 * If this fails we might have return value in a0 from seccomp
>  	 * (via SECCOMP_RET_ERRNO/TRACE).
>  	 */
> -	if (secure_computing() == -1) {
> -		syscall_set_nr(current, regs, -1);
> -		return;
> -	}
> +	if (secure_computing() == -1)
> +		return -1;
>  
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> @@ -170,6 +168,7 @@ __visible void do_syscall_trace_enter(struct pt_regs *regs)
>  #endif
>  
>  	audit_syscall_entry(regs->a7, regs->a0, regs->a1, regs->a2, regs->a3);
> +	return 0;
>  }
>  
>  __visible void do_syscall_trace_exit(struct pt_regs *regs)
> -- 
> 2.20.1
> 

-- 
Kees Cook
