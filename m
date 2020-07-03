Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CB6208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZIna3qR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGCPwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:52:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED89C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 08:52:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so504297pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P5srzmnrxliyzm4cfUkbtbVYQjXZkVAjuTziEaQfSvU=;
        b=ZIna3qR6XPCmofw5G6gVC7O+sxTlE5AL9N5e72acfXCXeFLKrNR/zcci85rHrHZQZ2
         RQwNWkzTkhocEs6ERTMhajh5OcIfFeb56z/cXzMMPbOshlMcrUDcz0xK5t7Q41PV54Eg
         hneRrVB/ZHP8e0L2pg3II/gLwljkrRNdQSEDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P5srzmnrxliyzm4cfUkbtbVYQjXZkVAjuTziEaQfSvU=;
        b=GDE2m3AH0lNYZlelFzIU3OoF6vnuBE/tGlmBWWBpiiYx9EeMWnuOTPen26Jgb0zK2Q
         le84eO5ACAEQMQil+tQEm5fMikWIDjlA4rLVEX57IR1VkZzFynHavgH5H03XDPSJaN3P
         pKPluJ49iuKbnUsYdvhAlgUBCW9hHGjqYz1NgkJcNvr79vQwI9xlCfHc6xNUiIMSiWZs
         ErreTWpR4RQyVUyViyiE67IjRWJul4OlHL65A6k219qbmX34yUL8zdbikVY5Nv6inSdL
         Ir6WO8xGpU7RZFF4Q3M1/wNaKKDB3/zNdihIGFi+Rc1kikC72/mZWIYf727nZPGAcz6r
         TNEA==
X-Gm-Message-State: AOAM530bfAM6WoDzd9cme10huWYJSPnJDfdfK4OGk0ES6Gj9n7wtDaFy
        sQMyxrI1N/h63zoMZS8GwZIkxw==
X-Google-Smtp-Source: ABdhPJxmxW/tiyX+dcRJ/hNHVcnQDQ6JQt/cG9od9dX6M50GDcykqvkQ2Gsapz76NvDYC8h+PVRGCA==
X-Received: by 2002:a63:3587:: with SMTP id c129mr30489056pga.322.1593791526950;
        Fri, 03 Jul 2020 08:52:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a30sm12857121pfr.87.2020.07.03.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:52:06 -0700 (PDT)
Date:   Fri, 3 Jul 2020 08:52:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <202007030851.D11F1EFA@keescook>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
 <202007030815.744AAB35D@keescook>
 <20200703154426.GA19406@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703154426.GA19406@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 04:44:27PM +0100, Will Deacon wrote:
> On Fri, Jul 03, 2020 at 08:17:19AM -0700, Kees Cook wrote:
> > On Fri, Jul 03, 2020 at 09:39:14AM +0100, Will Deacon wrote:
> > > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > > index 5f5b868292f5..a13661f44818 100644
> > > --- a/arch/arm64/kernel/syscall.c
> > > +++ b/arch/arm64/kernel/syscall.c
> > > @@ -121,12 +121,10 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > >  	user_exit();
> > >  
> > >  	if (has_syscall_work(flags)) {
> > > -		/* set default errno for user-issued syscall(-1) */
> > > -		if (scno == NO_SYSCALL)
> > > -			regs->regs[0] = -ENOSYS;
> > > -		scno = syscall_trace_enter(regs);
> > > -		if (scno == NO_SYSCALL)
> > > +		if (syscall_trace_enter(regs))
> > >  			goto trace_exit;
> > > +
> > > +		scno = regs->syscallno;
> > >  	}
> > >  
> > >  	invoke_syscall(regs, scno, sc_nr, syscall_table);
> > 
> > What effect do either of these patches have on the existing seccomp
> > selftests: tools/testing/selftests/seccomp/seccomp_bpf ?
> 
> Tests! Thanks, I'll have a look.

Thanks!

(And either way, that this behavioral difference went unnoticed means we
need to add a test to the selftests for this patch.)

-- 
Kees Cook
