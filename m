Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B54CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 03:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E9520728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 03:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0veagOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEPDml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 23:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEPDml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 23:42:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8714C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 20:42:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so1707138plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mKqFUGEpyOzh5EDjGZEzsSGhAwncVKK5vZxIN0U3Adg=;
        b=q0veagOuNuyfpNLSzKh64qQX5UvCFHvFVakIuHep0QHWDBSejP13oSCuGtHAUYLp5v
         ANe2I0xefPUfCApgRhP0fWpaxU93W0sZOI4j+ffb7/Rf8SlCDRVwKSYtgYkawk/a6TBh
         gGdFqAIMs4P1aBzqXQ3swLNoAZKTHfwblwfpaIogG/GOir9lHY+kIqjEy2uWZxP9mNyw
         HlImqp/Q1Dfy0DOU3fCFSHu3h89FBfsjfkFccSuieu9JIeqbxq2xwuh+otUbRcOYj6yJ
         vtsQCiWYOTgtHvXA7R2APcnZddSltWq1Om+a9fsyvnLeczEzWyH1XN4UPA+1OyX3wapq
         aaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mKqFUGEpyOzh5EDjGZEzsSGhAwncVKK5vZxIN0U3Adg=;
        b=HS0+aZawQCkTNm95+7m54Pzks712l5DtM5i1BOIhBf2yeb9SCgcP8/iJI4vcJvexXI
         lG82p6KhgVaGnBDbZbHjyayXH2pMaX+aw+Ph1tX3k40w3t8Hs4GqZRehF+66REKaWBXt
         MwhkIneRDJt6gM1Z5usHOjf0MT5sZ/RsB6lLsevAfuSvrEEPUyLJLP89fT3vQe8O0LGV
         y2FH+mteJKOL7QYhC5shSP6YMG3nARA7H2YZ1J3h+OvjbAKCCIDp3FxHTeZvDIv0Kvhl
         DDdsZc788VQFozy5vzlwyOIUTcdeccIhEqrBVVQWHJ/u4ubRJwEO9FlyHWe5WW3VM1Hq
         ZvMQ==
X-Gm-Message-State: AOAM532ZcZNv4CPAL6pGoICZp2PEilZOaa6xlP3PvqMTNFPI0T0Ezx98
        gMGmkbUP1xmYK5pup3U5LNvmVx9K/Wo=
X-Google-Smtp-Source: ABdhPJyDmBBcIeamek9YB6owGv43JcdWRJo0EZnJxqc0gbsI5kNhDzeLiJcJFSkMQ7ZO/mC0+G1Csw==
X-Received: by 2002:a17:902:d913:: with SMTP id c19mr6179538plz.229.1589600560329;
        Fri, 15 May 2020 20:42:40 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id s15sm2808497pgv.5.2020.05.15.20.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 20:42:39 -0700 (PDT)
Date:   Sat, 16 May 2020 11:42:30 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200516034230.GA72980@aaronlu-desktop>
References: <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
 <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net>
 <20200508123457.GA122180@aaronlu-desktop>
 <20200514130248.GD2940@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514130248.GD2940@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:02:48PM +0200, Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 08:34:57PM +0800, Aaron Lu wrote:
> > With this said, I realized a workaround for the issue described above:
> > when the core went from 'compatible mode'(step 1-3) to 'incompatible
> > mode'(step 4), reset all root level sched entities' vruntime to be the
> > same as the core wide min_vruntime. After all, the core is transforming
> > from two runqueue mode to single runqueue mode... I think this can solve
> > the issue to some extent but I may miss other scenarios.
> 
> A little something like so, this syncs min_vruntime when we switch to
> single queue mode. This is very much SMT2 only, I got my head in twist
> when thikning about more siblings, I'll have to try again later.

Thanks a lot for the patch, I now see that "there is no need to adjust
every se's vruntime". :-)

> This very much retains the horrible approximation of S we always do.
> 
> Also, it is _completely_ untested...

I've been testing it.

One problem below.

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4293,10 +4281,11 @@ static struct task_struct *
>  pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  	struct task_struct *next, *max = NULL;
> +	int old_active = 0, new_active = 0;
>  	const struct sched_class *class;
>  	const struct cpumask *smt_mask;
> -	int i, j, cpu;
>  	bool need_sync = false;
> +	int i, j, cpu;
>  
>  	cpu = cpu_of(rq);
>  	if (cpu_is_offline(cpu))
> @@ -4349,10 +4338,14 @@ pick_next_task(struct rq *rq, struct tas
>  		rq_i->core_pick = NULL;
>  
>  		if (rq_i->core_forceidle) {
> +			// XXX is_idle_task(rq_i->curr) && rq_i->nr_running ??
>  			need_sync = true;
>  			rq_i->core_forceidle = false;
>  		}
>  
> +		if (!is_idle_task(rq_i->curr))
> +			old_active++;
> +
>  		if (i != cpu)
>  			update_rq_clock(rq_i);
>  	}
> @@ -4463,8 +4456,12 @@ next_class:;
>  
>  		WARN_ON_ONCE(!rq_i->core_pick);
>  
> -		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
> -			rq_i->core_forceidle = true;
> +		if (is_idle_task(rq_i->core_pick)) {
> +			if (rq_i->nr_running)
> +				rq_i->core_forceidle = true;
> +		} else {
> +			new_active++;
> +		}
>  
>  		if (i == cpu)
>  			continue;
> @@ -4476,6 +4473,16 @@ next_class:;
>  		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
>  	}
>  
> +	/* XXX SMT2 only */
> +	if (new_active == 1 && old_active > 1) {

There is a case when incompatible task appears but we failed to 'drop
into single-rq mode' per the above condition check. The TLDR is: when
there is a task that sits on the sibling rq with the same cookie as
'max', new_active will be 2 instead of 1 and that would cause us missing
the chance to do a sync of core min_vruntime.

This is how it happens:
1) 2 tasks of the same cgroup with different weight running on 2 siblings,
   say cg0_A with weight 1024 bound at cpu0 and cg0_B with weight 2 bound
   at cpu1(assume cpu0 and cpu1 are siblings);
2) Since new_active == 2, we didn't trigger min_vruntime sync. For
   simplicity, let's assume both siblings' root cfs_rq's min_vruntime and
   core_vruntime are all at 0 now;
3) let the two tasks run a while;
4) a new task cg1_C of another cgroup gets queued on cpu1. Since cpu1's
   existing task has a very small weight, its cfs_rq's min_vruntime can
   be much larger than cpu0's cfs_rq min_vruntime. So cg1_C's vruntime is
   much larger than cg0_A's and the 'max' of the core wide task
   selection goes to cg0_A;
5) Now I suppose we should drop into single-rq mode and by doing a sync
   of core min_vruntime, cg1_C's turn shall come. But the problem is, our
   current selection logic prefer not to waste CPU time so after decides
   cg0_A as the 'max', the sibling will also do a cookie_pick() and
   get cg0_B to run. This is where problem asises: new_active is 2
   instead of the expected 1.
6) Due to we didn't do the sync of core min_vruntime, the newly queued
   cg1_C shall wait a long time before cg0_A's vruntime catches up.

One naive way of precisely determine when to drop into single-rq mode is
to track how many tasks of a particular tag exists and use that to
decide if the core is in compatible mode(all tasks belong to the same
cgroup, IOW, have the same core_cookie) or not and act accordingly,
except that: does this sound too complex and inefficient?...

> +		/*
> +		 * We just dropped into single-rq mode, increment the sequence
> +		 * count to trigger the vruntime sync.
> +		 */
> +		rq->core->core_sync_seq++;
> +	}
> +	rq->core->core_active = new_active;
> +
>  done:
>  	set_next_task(rq, next);
>  	return next;
