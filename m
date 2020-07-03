Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6C3208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7xLiC+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgGCPRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:17:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE97C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 08:17:21 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so12755719plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQoaO14EaS5b6YMbPDUFuhJJwubGyeInK0Uhm2izrow=;
        b=l7xLiC+VmsoAXhSSr0rdkXYOoj+xiWLpO56jPFrD69RJQtZKS/rNAmFgtTsmPJikDz
         BqV6CMRbgamYaauOgxS5v1msuiCTTA/ReDj14RbFbSxW+YE2r1lSgqTt2Ini4nlJOx3t
         dkLn1EiRv8VHIySFfWJXdNjajyjQCEdw2Sb9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQoaO14EaS5b6YMbPDUFuhJJwubGyeInK0Uhm2izrow=;
        b=iw59fJXLtFSceqn18POdypKXaSFBJcuXa7cpwWbL6AQtup6LW22WTyFS3iqnjXd2TK
         1WDiHqZtJb0NbVuz3e+Ai9v+cZb6jZfjcL7WD1FgQJ+rjZaad5I4mtTKngao81j4EmCE
         x8DfrZ2qWxTSPvUzAIXVgmBTzWRj8BLX6Vr+AlLFUICqFXt4CTcmZ7ZlVIue4m+7doTs
         HHQQg1ypBr3QjMG0vDKUtxTRmtaQQH6Rwt/nREGoMVh11RbqPrux0KJ0LqsC7H4BQuT1
         QXj2rFQawy4WunPGJHBcx3mg8K59MsBlEd3kbmAtBnVYFf7nlkJn5iFv/PxrkuDEwKej
         iOWQ==
X-Gm-Message-State: AOAM5317dsLuJj0aJrrlo7AFEtjd3pSC5RHceKILAqveOlBES97orJ06
        0y25CbqFh3LkDwcve53NJpKibQ==
X-Google-Smtp-Source: ABdhPJwOn1ig28sc0JHhO/23CWki6UHs8oGqQpPZltv+FYmKOj0IBYRrjHfKUvPmhcSVmqEpPiwqSA==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr30123847pls.204.1593789441351;
        Fri, 03 Jul 2020 08:17:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm11149170pjz.11.2020.07.03.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:17:20 -0700 (PDT)
Date:   Fri, 3 Jul 2020 08:17:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <202007030815.744AAB35D@keescook>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703083914.GA18516@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 09:39:14AM +0100, Will Deacon wrote:
> Hi Keno,
> 
> On Fri, May 22, 2020 at 09:01:01PM -0400, Keno Fischer wrote:
> > I'm seeing the following while porting a ptracer from
> > x86_64 to arm64 (cc'ing arm64 folks, but in this case
> > x86_64 is the odd one out, I think other archs would
> > be consistent with arm64).
> > 
> > Consider userspace code like the following:
> > ```
> > int ret = syscall(-10, 0);
> > assert(ret == -ENOSYS);
> > ```
> > 
> > (Never mind the fact that this is something userspace
> > shouldn't do, I saw this in our test suite that tests
> > corner cases where the ptracer shouldn't affect behavior).
> > 
> > Now, if we have a seccomp filter that simply does
> > SECCOMP_RET_TRACE, and a ptracer that simply
> > does PTRACE_CONT
> 
> Ok, so this means that we're _skipping_ the system call, right?
> 
> > then the assert will fire/fail on arm64, but not on x86_64.
> 
> It feels weird to me that skipping the system call has any effect on the
> tracee registers...
> 
> > Interestingly, arm64 does do something different
> > if the syscall is -1 rather than -10, where early
> > in the ptrace stop it does.
> > ```
> > /* set default errno for user-issued syscall(-1) */
> > if (scno == NO_SYSCALL)
> >     regs->regs[0] = -ENOSYS;
> 
> ... so I think this should be fixed too. How about the diff below?
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 68b7f34a08f5..cb3f653c9688 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1833,12 +1833,12 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
>  		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
>  		if (!in_syscall(regs) || (flags & _TIF_SYSCALL_EMU))
> -			return -1;
> +			return -ENOSYS;
>  	}
>  
>  	/* Do the secure computing after ptrace; failures should be fast. */
>  	if (secure_computing() == -1)
> -		return -1;
> +		return -ENOSYS;
>  
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, regs->syscallno);
> @@ -1846,7 +1846,7 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
>  			    regs->regs[2], regs->regs[3]);
>  
> -	return regs->syscallno;
> +	return 0;
>  }
>  
>  void syscall_trace_exit(struct pt_regs *regs)
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 5f5b868292f5..a13661f44818 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -121,12 +121,10 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  	user_exit();
>  
>  	if (has_syscall_work(flags)) {
> -		/* set default errno for user-issued syscall(-1) */
> -		if (scno == NO_SYSCALL)
> -			regs->regs[0] = -ENOSYS;
> -		scno = syscall_trace_enter(regs);
> -		if (scno == NO_SYSCALL)
> +		if (syscall_trace_enter(regs))
>  			goto trace_exit;
> +
> +		scno = regs->syscallno;
>  	}
>  
>  	invoke_syscall(regs, scno, sc_nr, syscall_table);

What effect do either of these patches have on the existing seccomp
selftests: tools/testing/selftests/seccomp/seccomp_bpf ?

-- 
Kees Cook
