Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01311C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D7420866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pwI1A3Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHaOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgHaOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:24:30 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B220C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:24:30 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y11so2744476qvl.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LC6hHsez6NgjC9+Zof4pUQRs/VHakWUcVzw4v4y8fiE=;
        b=pwI1A3Lfye7AO1rJqR9fju6P2wl2tFiVNxEqOv3nYyJr5P/zysabyjyqM9cFxf6jfH
         bdPhIwPKof+ALWWpuu0TmyLFrredeAk9ciHCgTSnFZo5Ym9XN1+ORfTvrjDXmXqFgxig
         nKT8tWlbGRZoU5rKpDJtyTdqfNo2OI6Wk3+Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LC6hHsez6NgjC9+Zof4pUQRs/VHakWUcVzw4v4y8fiE=;
        b=rvFs6XIhjQPVxxnU28A+RxKwGXRhnXJEWZVk7kTz10RG7XxBEZ3SetSH+81oDexzjl
         kPr9mqUy5B+XVLxhIhbpvI3JurQUnRLba8qA0PvYJnFDGAj1najqAJSwiyTlPcmnoC40
         c8lmkQWiO5IUcCgizZd4IcUR8niDz6bQWZbUAayP0OeiuIpQ6FhUJZ8KipnTJtpc8+M5
         JLdy0r4RzG00BgUEA9F8qMQ13JI+XurWzNGDoXUYMYcwwXUesM4hgciKUR/UwUG2FTwc
         YbYtdSm/jIwtugkPovlKvu4GxIAV3pfygml2Wvmcv3oyv9FTYU4XUr3sApEnwPdVcGBQ
         9nPw==
X-Gm-Message-State: AOAM531A6frCJZxjZLxw3xMZLQpAcNyojheVulo9BApGizLrUtCVTNHf
        p6BXjHYgZsIDr5lH3oZsMAnT8A==
X-Google-Smtp-Source: ABdhPJwBZCUtoODRUiVLz1mkBEfdTx7bNGM2mDPJq1O4p4EKg1+gAcKBvEmmEsOmflA5Uk5MPmL1/g==
X-Received: by 2002:a0c:fdc4:: with SMTP id g4mr1326744qvs.30.1598883869006;
        Mon, 31 Aug 2020 07:24:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x13sm10184619qts.23.2020.08.31.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 07:24:28 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:24:27 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     peterz@infradead.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200831142427.GA3437943@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
 <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sat, Aug 29, 2020 at 09:47:19AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 06:02:25PM -0400, Vineeth Pillai wrote:
> > On 8/28/20 4:51 PM, Peter Zijlstra wrote:
> 
> > > So where do things go side-ways?
> 
> > During hotplug stress test, we have noticed that while a sibling is in
> > pick_next_task, another sibling can go offline or come online. What
> > we have observed is smt_mask get updated underneath us even if
> > we hold the lock. From reading the code, looks like we don't hold the
> > rq lock when the mask is updated. This extra logic was to take care of that.
> 
> Sure, the mask is updated async, but _where_ is the actual problem with
> that?
> 
> On Fri, Aug 28, 2020 at 06:23:55PM -0400, Joel Fernandes wrote:
> > Thanks Vineeth. Peter, also the "v6+" series (which were some addons on v6)
> > detail the individual hotplug changes squashed into this patch:
> > https://lore.kernel.org/lkml/20200815031908.1015049-9-joel@joelfernandes.org/
> > https://lore.kernel.org/lkml/20200815031908.1015049-11-joel@joelfernandes.org/
> 
> That one looks fishy, the pick is core wide, making that pick_seq per rq
> just doesn't make sense.

I think Vineeth was trying to handle the case where rq->core_pick happened to
be NULL for an offline CPU, and then schedule() is called when it came online
but its sched_seq != core-wide pick_seq. The reason for this situation is
because a sibling did selection for the offline CPU and ended up leaving its
rq->core_pick as NULL as the then-offline CPU was missing from the
cpu_smt_mask, but it incremented the core-wide pick_seq anyway.

Due to this, the pick_next_task() can crash after entering this if() block:
+	if (rq->core_pick_seq == rq->core->core_task_seq &&
+	    rq->core_pick_seq != rq->core_sched_seq) {

How would you suggest to fix it? Maybe we can just assign rq->core_sched_seq
== rq->core_pick_seq for an offline CPU (or any CPU where rq->core_pick ==
NULL), so it does not end up using rq->core_pick and does a full core-wide
selcetion again when it comes online?

Or easier, check for rq->core_pick == NULL and skip this fast-path if() block
completely.

> > https://lore.kernel.org/lkml/20200815031908.1015049-12-joel@joelfernandes.org/
> 
> This one reads like tinkering, there is no description of the actual
> problem just some code that makes a symptom go away.
> 
> Sure, on hotplug the smt mask can change, but only for a CPU that isn't
> actually scheduling, so who cares.
> 
> /me re-reads the hotplug code...
> 
> ..ooOO is the problem that we clear the cpumasks on take_cpu_down()
> instead of play_dead() ?! That should be fixable.

I think Vineeth explained this in his email, there is logic across the loops
in the pick_next_task() that depend on the cpu_smt_mask not change. I am not
sure if play_dead() will fix it, the issue is seen in the code doing the
selection and the cpu_smt_mask changing under it due to possibly other CPUs
going offline.

Example, you have a splat and null pointer dereference possibilities in the
below loop if rq_i ->core_pick == NULL, because a sibling CPU came online but
a task was not selected for it in the for loops prior to this for loop:

        /*
         * Reschedule siblings
         *
         * NOTE: L1TF -- at this point we're no longer running the old task and
         * sending an IPI (below) ensures the sibling will no longer be running
         * their task. This ensures there is no inter-sibling overlap between
         * non-matching user state.
         */
        for_each_cpu(i, smt_mask) {
                struct rq *rq_i = cpu_rq(i);

                WARN_ON_ONCE(!rq_i->core_pick);

                if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
                        rq_i->core_forceidle = true;

                rq_i->core_pick->core_occupation = occ;

Probably the code can be rearchitected to not depend on cpu_smt_mask
changing.  What I did in my old tree is I made a copy of the cpu_smt_mask in
the beginning of this function, and that makes all the problems go away. But
I was afraid of overhead of that copying.

(btw, I would not complain one bit if this function was nuked and rewritten
to be simpler).

> > https://lore.kernel.org/lkml/20200815031908.1015049-13-joel@joelfernandes.org/
> 
> This is the only one that makes some sense, it makes rq->core consistent
> over hotplug.

Cool at least we got one thing right ;)

> > Agreed we can split the patches for the next series, however for final
> > upstream merge, I suggest we fix hotplug issues in this patch itself so that
> > we don't break bisectability.
> 
> Meh, who sodding cares about hotplug :-). Also you can 'fix' such things
> by making sure you can't actually enable core-sched until after
> everything is in place.

Fair enough :)

thanks,

 - Joel

