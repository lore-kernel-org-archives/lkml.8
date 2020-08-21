Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3005D20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3x+eQ8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHUGh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHUGhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:37:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B45C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:37:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so914759wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QItSkxomgZddqKFgXhd2Dp3/b385ih5CrxI3SGmUc1k=;
        b=E3x+eQ8CUXoja0ZbVom1sy7IZSb4mZS+ZwPu+pHgpeHLG/Zm1yANzw6iY2iRqFlcgw
         3lKsutxt762BLx0lzZmhC5pV8f0waSEVccD1sIGTlSzHkWX4uu/0kitlHncsyh+jLuTp
         0QO/mn3rGOxdUnK8lvdjdX3owUpojvrsNQu3TPUtmesTsQosb80ykKk8h+c3U0wYusPu
         GXmL7SmEWlp8kAJjUSkJbTrOME2wITMLvxUl5Qe9EMPW8/0v60P/+qfagaScZQTU/Q1Z
         KdZPR3QmGsf4WPrIU/2y6erDex6MaZDYLv660T7CtwRj6n3LoJQbcouCd26bLWoCVXZU
         ZUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QItSkxomgZddqKFgXhd2Dp3/b385ih5CrxI3SGmUc1k=;
        b=NPiwSMo9JqLo1Ecb2NwNFZnzTGRO4K7ux+RLxPLtmJIeBLVHZPpnWiOMcmz6sZ087q
         OS/DWPxdg4wUH/OtAaX2tR5+265FK2qfT35Q7EV4sVGtGfKdqgdDtZvEPUGETklTp6z+
         qes/xdv3I/PW5u05hHLqFZ3FYosJe7pbmmOx4VG1Zacd1gx1i/rTCbqSgGZi0Ygq1eY9
         H7azCgPlYkoVCfE2BUWi6UADUFBrtvCgM9rfNoYa+pcxr8nkcaUXgUgtw8dviloEpLJh
         mcfOch9bEesxIEhUBZs2cHDbOFOyt6Xu0tYKiZe76BSaxdP1I4Z41UH5gBiUSDaxnLin
         lGvg==
X-Gm-Message-State: AOAM532j8Pb/BNjA+inmlCh4lPKzLqDSzmlppBgbJIQ8fVKouXOb895g
        cKFLIHlVxYarxPkt+/gInNr8aRDZe92Evg==
X-Google-Smtp-Source: ABdhPJyqBHrOSxiz02DxFq4JTWhGDvpiON9R4ATj2W1u1WmincfvddakxNDzMvRjtHrOvmideyd7oA==
X-Received: by 2002:a5d:5682:: with SMTP id f2mr1242594wrv.248.1597991863080;
        Thu, 20 Aug 2020 23:37:43 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id 68sm2321466wra.39.2020.08.20.23.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 23:37:42 -0700 (PDT)
Date:   Fri, 21 Aug 2020 08:37:36 +0200
From:   Marco Elver <elver@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, will@kernel.org, npiggin@gmail.com,
        jgross@suse.com, paulmck@kernel.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 0/9] TRACE_IRQFLAGS wreckage
Message-ID: <20200821063736.GA1722858@elver.google.com>
References: <20200820073031.886217423@infradead.org>
 <20200820103643.1b9abe88@oasis.local.home>
 <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
 <20200820172046.GA177701@elver.google.com>
 <20200820155923.3d5c4873@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820155923.3d5c4873@oasis.local.home>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 03:59PM -0400, Steven Rostedt wrote:
> On Thu, 20 Aug 2020 19:20:46 +0200
> Marco Elver <elver@google.com> wrote:
> 
> > On Thu, Aug 20, 2020 at 04:58PM +0200, peterz@infradead.org wrote:
> > > On Thu, Aug 20, 2020 at 10:36:43AM -0400, Steven Rostedt wrote:  
> > > > 
> > > > I tested this series on top of tip/master and triggered the below
> > > > warning when running the irqsoff tracer boot up test (config attached).
> > > > 
> > > > -- Steve
> > > > 
> > > >  Testing tracer irqsoff: 
> > > >  
> > > >  =============================
> > > >  WARNING: suspicious RCU usage
> > > >  5.9.0-rc1-test+ #92 Not tainted
> > > >  -----------------------------
> > > >  include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!  
> > ...
> > > 
> > > Shiny, I think that wants something like the below, but let me go frob
> > > my config and test it.
> > > 
> > > ---
> > > --- a/drivers/cpuidle/cpuidle.c
> > > +++ b/drivers/cpuidle/cpuidle.c  
> > ...
> > 
> > With that applied (manually, due to conflicts), I still get warnings for
> > certain call locations with KCSAN on (that is with my fix from the other
> > email):
> > 
> > | =============================
> > | WARNING: suspicious RCU usage
> > | 5.9.0-rc1+ #23 Tainted: G        W        
> > | -----------------------------
> > | include/trace/events/random.h:310 suspicious rcu_dereference_check() usage!
> > | 
> > | other info that might help us debug this:
> > | 
> > | 
> > | rcu_scheduler_active = 2, debug_locks = 0
> > | RCU used illegally from extended quiescent state!
> > | no locks held by swapper/1/0.
> > | 
> > | stack backtrace:
> > | CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.9.0-rc1+ #23
> > | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > | Call Trace:
> > |  __dump_stack lib/dump_stack.c:77 [inline]
> > |  dump_stack+0xf1/0x14d lib/dump_stack.c:118
> > |  trace_prandom_u32 include/trace/events/random.h:310 [inline]
> > |  prandom_u32+0x1ee/0x200 lib/random32.c:86
> > |  prandom_u32_max include/linux/prandom.h:46 [inline]
> > |  reset_kcsan_skip kernel/kcsan/core.c:277 [inline]
> > |  kcsan_setup_watchpoint+0x9b/0x600 kernel/kcsan/core.c:424
> > |  is_idle_task+0xd/0x20 include/linux/sched.h:1671 		<==== inline, but not noinstr
> > |  irqentry_enter+0x17/0x50 kernel/entry/common.c:293 		<==== noinstr function
> > 
> 
> What happens if you apply the below patch?
> 
> -- Steve
> 
> diff --git a/lib/random32.c b/lib/random32.c
> index 932345323af0..1c5607a411d4 100644
> --- a/lib/random32.c
> +++ b/lib/random32.c
> @@ -83,7 +83,7 @@ u32 prandom_u32(void)
>  	u32 res;
>  
>  	res = prandom_u32_state(state);
> -	trace_prandom_u32(res);
> +	trace_prandom_u32_rcuidle(res);
>  	put_cpu_var(net_rand_state);
>  
>  	return res;

Thank you, this resolves the problem. It also works if I remove my 2
other patches (for now, I think I still need the recursion-guard but
it's not urgent, will send that separately).

And my apologies, it seems 5.9-rc1 is already broken, which I should
have noticed. I sent a separate patch, which should be picked up into
5.9: https://lkml.kernel.org/r/20200821063043.1949509-1-elver@google.com

With that fix + start_critical_timings-switcheroo, this series is:

Tested-by: Marco Elver <elver@google.com>

Thanks,
-- Marco
