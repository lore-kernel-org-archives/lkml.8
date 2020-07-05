Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 04:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A362088E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 04:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RHOugun7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGEE4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 00:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGEE4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 00:56:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072FBC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 21:56:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f2so14064643plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 21:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hk9Xb46s0HA05k2AliYM1cAP/H+z0yxhR3RbIpRRNns=;
        b=RHOugun7I0mjBZaN6nDx0tAcduf1GDPM7uZU6AtTl194aIHwKmuOJmvCdK0yo+4PEd
         kLWo2CysMxrij3wrqgn+7B5tcFbCn/a9jU9OY1ZdSBl1Z/13v1XXrqgXmS6WQT046cpj
         StjGY2ckU9dxEl8gEXWdhX4Tgq/nsFQgUUBGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hk9Xb46s0HA05k2AliYM1cAP/H+z0yxhR3RbIpRRNns=;
        b=QgOgGZ0ZJq7bp1q0FR14NO52ONHuqVwyGXmLKxd0GJEgHHTVcEzOprM0Elnx8rNdUe
         2lMrOybmVWA7Fbev7rCjUo1aIlGa3Kp9XPS19w77QrzDGV/i9kFiBBVMlefToDPi3TyI
         lwLEuzAQ27AaNhQoZ7x9hRLoP2EiTrnWpGsHg1/b2aXhSeWmS8Tne1kI9v63Uo+X0TDO
         HgY9xXcEG+K7lSqqA6/l/r16ASQID6KZjQnHGAV/ftGQKIj5HQfbtLD4a+ZB4AzYpBQI
         5mZT/TvvpDHs1t8xDP/p8HFMAaaDVP9Lk1EoVxkIjDcmUC+oK79m6tAQiogpOurjUF33
         2ZSA==
X-Gm-Message-State: AOAM531Ss20Z2+GkCPFr7rMVIzbzpfJy/OvSolRrl0LxCOh3NHawJbWv
        MAS9AzGyBO2NUPnOF3EZuxFphQ==
X-Google-Smtp-Source: ABdhPJyzncEyQFV+H6LbJ1hWrEX3ZvEFydKSu37Z22L5R34lFIS4JHzqTKaheOX8al0P1V9ubWch9A==
X-Received: by 2002:a17:90a:21c3:: with SMTP id q61mr25600934pjc.207.1593925012323;
        Sat, 04 Jul 2020 21:56:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm15547709pfa.71.2020.07.04.21.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 21:56:51 -0700 (PDT)
Date:   Sat, 4 Jul 2020 21:56:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <202007042132.DAFA2C2@keescook>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
 <202007030815.744AAB35D@keescook>
 <20200703154426.GA19406@willie-the-truck>
 <202007030851.D11F1EFA@keescook>
 <20200704123355.GA21185@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704123355.GA21185@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 01:33:56PM +0100, Will Deacon wrote:
> On Fri, Jul 03, 2020 at 08:52:05AM -0700, Kees Cook wrote:
> > On Fri, Jul 03, 2020 at 04:44:27PM +0100, Will Deacon wrote:
> > > On Fri, Jul 03, 2020 at 08:17:19AM -0700, Kees Cook wrote:
> > > > On Fri, Jul 03, 2020 at 09:39:14AM +0100, Will Deacon wrote:
> > > > > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > > > > index 5f5b868292f5..a13661f44818 100644
> > > > > --- a/arch/arm64/kernel/syscall.c
> > > > > +++ b/arch/arm64/kernel/syscall.c
> > > > > @@ -121,12 +121,10 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > > > >  	user_exit();
> > > > >  
> > > > >  	if (has_syscall_work(flags)) {
> > > > > -		/* set default errno for user-issued syscall(-1) */
> > > > > -		if (scno == NO_SYSCALL)
> > > > > -			regs->regs[0] = -ENOSYS;
> > > > > -		scno = syscall_trace_enter(regs);
> > > > > -		if (scno == NO_SYSCALL)
> > > > > +		if (syscall_trace_enter(regs))
> > > > >  			goto trace_exit;
> > > > > +
> > > > > +		scno = regs->syscallno;
> > > > >  	}
> > > > >  
> > > > >  	invoke_syscall(regs, scno, sc_nr, syscall_table);
> > > > 
> > > > What effect do either of these patches have on the existing seccomp
> > > > selftests: tools/testing/selftests/seccomp/seccomp_bpf ?
> > > 
> > > Tests! Thanks, I'll have a look.
> > 
> > Thanks!
> > 
> > (And either way, that this behavioral difference went unnoticed means we
> > need to add a test to the selftests for this patch.)
> 
> Unsurprisingly, I don't think the tests go near this. I get 75/77 passes
> on arm64 defconfig with or without these changes.

(What doesn't pass for you? I tried to go find kernelci.org test output,
but it doesn't appear to actually run selftests yet?)

Anyway, good that the test output doesn't change, bad that seccomp has
missed a corner of this architecture interface. (i.e. the entire
TRACE_syscall fixture is dedicated to exercising the changing/skipping
interface, but I see now that it doesn't at all exercise any area of
ENOSYS results.)

> We could add a test, but then we'd have to agree on what it's supposed to
> be doing ;)

Well, if you look at change_syscall() in seccomp_bpf.c (once you stop
screaming) you'll likely share my desire to have more things that are
common across architectures. ;) So, to that end, yes, please, let's
define what we'd like to see, and then build out the (likely wildly
different per-architecture expectations). If I read this thread
correctly, we need to test:

	syscall(-1), direct,  returns ENOSYS
	syscall(-10), direct, returns ENOSYS
	syscall(-1), SECCOMP_RET_TRACE+PTRACE_CONT, returns ENOSYS
	syscall(-10), SECCOMP_RET_TRACE+PTRACE_CONT, returns ENOSYS
	syscall(-1), ptrace+PTRACE_SYSCALL, returns ENOSYS
	syscall(-10), ptrace+PTRACE_SYSCALL, returns ENOSYS

do we need to double-check that registers before/after are otherwise
unchanged too? (I *think* just looking at syscall return should be
sufficient to catch the visible results.)

-- 
Kees Cook
