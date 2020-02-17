Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D6DC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCD420725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581981292;
	bh=ka3ET9vgcGmJZhqnp++/rpmYHRFB7WBmLJG5PCOt4mE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=szid/zzlTCzqJWp3c22/orum1W1zKvzYcwFsbc2n9Qs4E9aYOcKKyoKdOANHcIcGW
	 Gl7b/Ev4GUzFoNFKMTYWJF+FxZgGPmmodn4dlDPWoA0p1OcXLcisrvNV5qNcvm+KFG
	 ec2/FcXX+sojhH/r3ntYlE9bjUHof/PGWmyitA58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgBQXOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:14:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgBQXOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:14:50 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF81E206E2;
        Mon, 17 Feb 2020 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581981289;
        bh=ka3ET9vgcGmJZhqnp++/rpmYHRFB7WBmLJG5PCOt4mE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0tIto54V0WSrg6IEKghUDK77A848/YWCWeASkijP/9BElL4uNSsthagCLiTYppqGm
         Q/zrvgsK/RxQitXEKRPya8RIUUNifpGkUGHNsofMRBnqRimWtJ3YmgcNEK9UsEzJNT
         Q8EBLEtpo6xA6m1eJ+ZRppzZvYvq+fZixlGetIMw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 836F735227A8; Mon, 17 Feb 2020 15:14:49 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:14:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>, andreyknvl@google.com,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, x86@kernel.org
Subject: Re: [PATCH v2] kcsan, trace: Make KCSAN compatible with tracing
Message-ID: <20200217231449.GB2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214211035.209972-1-elver@google.com>
 <20200214234004.GT2935@paulmck-ThinkPad-P72>
 <1581959174.7365.88.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581959174.7365.88.camel@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 12:06:14PM -0500, Qian Cai wrote:
> On Fri, 2020-02-14 at 15:40 -0800, Paul E. McKenney wrote:
> > On Fri, Feb 14, 2020 at 10:10:35PM +0100, Marco Elver wrote:
> > > Previously the system would lock up if ftrace was enabled together with
> > > KCSAN. This is due to recursion on reporting if the tracer code is
> > > instrumented with KCSAN.
> > > 
> > > To avoid this for all types of tracing, disable KCSAN instrumentation
> > > for all of kernel/trace.
> > > 
> > > Furthermore, since KCSAN relies on udelay() to introduce delay, we have
> > > to disable ftrace for udelay() (currently done for x86) in case KCSAN is
> > > used together with lockdep and ftrace. The reason is that it may corrupt
> > > lockdep IRQ flags tracing state due to a peculiar case of recursion
> > > (details in Makefile comment).
> > > 
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Reported-by: Qian Cai <cai@lca.pw>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Queued for review and further testing, thank you!
> > 
> > Qian, does this also fix things for you?
> 
> It works fine. Feel free to use,
> 
> Tested-by: Qian Cai <cai@lca.pw>

Applied, thank you!

							Thanx, Paul

> > > ---
> > > v2:
> > > *  Fix KCSAN+lockdep+ftrace compatibility.
> > > ---
> > >  arch/x86/lib/Makefile | 5 +++++
> > >  kernel/kcsan/Makefile | 2 ++
> > >  kernel/trace/Makefile | 3 +++
> > >  3 files changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> > > index 432a077056775..6110bce7237bd 100644
> > > --- a/arch/x86/lib/Makefile
> > > +++ b/arch/x86/lib/Makefile
> > > @@ -8,6 +8,11 @@ KCOV_INSTRUMENT_delay.o	:= n
> > >  
> > >  # KCSAN uses udelay for introducing watchpoint delay; avoid recursion.
> > >  KCSAN_SANITIZE_delay.o := n
> > > +ifdef CONFIG_KCSAN
> > > +# In case KCSAN+lockdep+ftrace are enabled, disable ftrace for delay.o to avoid
> > > +# lockdep -> [other libs] -> KCSAN -> udelay -> ftrace -> lockdep recursion.
> > > +CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
> > > +endif
> > >  
> > >  # Early boot use of cmdline; don't instrument it
> > >  ifdef CONFIG_AMD_MEM_ENCRYPT
> > > diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> > > index df6b7799e4927..d4999b38d1be5 100644
> > > --- a/kernel/kcsan/Makefile
> > > +++ b/kernel/kcsan/Makefile
> > > @@ -4,6 +4,8 @@ KCOV_INSTRUMENT := n
> > >  UBSAN_SANITIZE := n
> > >  
> > >  CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
> > > +CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
> > > +CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
> > >  
> > >  CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
> > >  	$(call cc-option,-fno-stack-protector,)
> > > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > > index f9dcd19165fa2..6b601d88bf71e 100644
> > > --- a/kernel/trace/Makefile
> > > +++ b/kernel/trace/Makefile
> > > @@ -6,6 +6,9 @@ ifdef CONFIG_FUNCTION_TRACER
> > >  ORIG_CFLAGS := $(KBUILD_CFLAGS)
> > >  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> > >  
> > > +# Avoid recursion due to instrumentation.
> > > +KCSAN_SANITIZE := n
> > > +
> > >  ifdef CONFIG_FTRACE_SELFTEST
> > >  # selftest needs instrumentation
> > >  CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)
> > > -- 
> > > 2.25.0.265.gbab2e86ba0-goog
> > > 
