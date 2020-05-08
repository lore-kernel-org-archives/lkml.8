Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14933C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC60207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3cc34Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHIob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEHIoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:44:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CDAC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:44:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so441967plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=915+QmVjKADgTrNjynlNsZzwO0kN0qHio8Yi40UhdHs=;
        b=q3cc34Wk/hxCKxn3te8R8oTruWN9zYDe/NsB7qnilJBZ7vqfgzHHk7BedwhkqGvtXm
         IbQ4r51kwoSpT9RD5c+5DtgY7wBd4MdjHbOBKsGntjv6DTAK/9U3Q2pzHSA1WmtEA8o2
         wNX3FldEKlrgP3lwQY5iJ32w3/oMIWoA0a845hf8Cija+cqPgpaB2+okkcTzCZ4rW/IT
         Lru8u09N6B/NL8/2afDpu0NnAbolB3uMAsHcXUe11D3yzl0WmevZyxiiL4CDYyb3OH8J
         uVMbUt3WFyr3M/4Vm5ZSTWKSG2VcH+ABUW5+XJQyoyTMYQx2ZLAjgOSh8h9hsBvJ08s+
         ccWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=915+QmVjKADgTrNjynlNsZzwO0kN0qHio8Yi40UhdHs=;
        b=RSflOtsqnfbWvqodg52xIEO1L1Cd4ijsH9dcOybnZe+kZsfCErAmVzpPWk+jRdUuaK
         YOvO7NCcO+MjfGU8Mnev9dpYowTVyic9zlNNx9vZb9a6iM4b+ngVINoOSh0FYj3JDnvZ
         o9Le53WZSm1dITRY9DRu1/wZ2IvmVPZgKPMBfXsqlgE4KQ503+aG88RbD2cnHdsqJ8RH
         GsLwykGvglhruoklCQ8xr9bs3gePAhGFiVz9u5qwvxuDz6gMreaJwNBUWYcSFhCGn/KI
         F6Z8XAiDcETKSBuklufkiNNNvkw+jqptiBm1lYecJ81sLzf8G4hp95xvmn0SeRR05yL2
         nPuQ==
X-Gm-Message-State: AGi0PuazpFleS2Q4nbeZFg4cydJS3ByhEvCEoD/rVIokmb5V0giRo4GM
        4DXViYejg2RoA4xZfdhH2wgru3JNbkw=
X-Google-Smtp-Source: APiQypJm9P9hFI8hvKD9ynUPuoFrla7HCRuJFon7talvwRqDVolnoih7cvsiDbASXydoyO5s4xExVw==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr5094842pjb.146.1588927469485;
        Fri, 08 May 2020 01:44:29 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id j26sm875560pgm.20.2020.05.08.01.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 01:44:28 -0700 (PDT)
Date:   Fri, 8 May 2020 16:44:19 +0800
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
Message-ID: <20200508084419.GA120223@aaronlu-desktop>
References: <20200414135624.GU20730@hirez.programming.kicks-ass.net>
 <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain>
 <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506143506.GH5298@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:35:06PM +0200, Peter Zijlstra wrote:
> 
> Sorry for being verbose; I've been procrastinating replying, and in
> doing so the things I wanted to say kept growing.
> 
> On Fri, Apr 24, 2020 at 10:24:43PM +0800, Aaron Lu wrote:
> 
> > To make this work, the root level sched entities' vruntime of the two
> > threads must be directly comparable. So one of the hyperthread's root
> > cfs_rq's min_vruntime is chosen as the core wide one and all root level
> > sched entities' vruntime is normalized against it.
> 
> > +/*
> > + * This is called in stop machine context so no need to take the rq lock.
> > + *
> > + * Core scheduling is going to be enabled and the root level sched entities
> > + * of both siblings will use cfs_rq->min_vruntime as the common cfs_rq
> > + * min_vruntime, so it's necessary to normalize vruntime of existing root
> > + * level sched entities in sibling_cfs_rq.
> > + *
> > + * Update of sibling_cfs_rq's min_vruntime isn't necessary as we will be
> > + * only using cfs_rq->min_vruntime during the entire run of core scheduling.
> > + */
> > +void sched_core_normalize_se_vruntime(int cpu)
> > +{
> > +	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> > +	int i;
> > +
> > +	for_each_cpu(i, cpu_smt_mask(cpu)) {
> > +		struct sched_entity *se, *next;
> > +		struct cfs_rq *sibling_cfs_rq;
> > +		s64 delta;
> > +
> > +		if (i == cpu)
> > +			continue;
> > +
> > +		sibling_cfs_rq = &cpu_rq(i)->cfs;
> > +		if (!sibling_cfs_rq->nr_running)
> > +			continue;
> > +
> > +		delta = cfs_rq->min_vruntime - sibling_cfs_rq->min_vruntime;
> > +		rbtree_postorder_for_each_entry_safe(se, next,
> > +				&sibling_cfs_rq->tasks_timeline.rb_root,
> > +				run_node) {
> > +			se->vruntime += delta;
> > +		}
> > +	}
> > +}
> 
> Aside from this being way to complicated for what it does -- you
> could've saved the min_vruntime for each rq and compared them with
> subtraction -- it is also terminally broken afaict.
>
> Consider any infeasible weight scenario. Take for instance two tasks,
> each bound to their respective sibling, one with weight 1 and one with
> weight 2. Then the lower weight task will run ahead of the higher weight
> task without bound.

I don't follow how this could happen. Even the lower weight task runs
first, after some time, the higher weight task will get its turn and
from then on, the higher weight task will get more chance to run(due to
its higher weight and thus, slower accumulation of vruntime).

We used to have the following patch as a standalone one in v4:
sched/fair : Wake up forced idle siblings if needed
https://lore.kernel.org/lkml/cover.1572437285.git.vpillai@digitalocean.com/T/#md22d25d0e2932d059013e9b56600d8a847b02a13
Which originates from:
https://lore.kernel.org/lkml/20190725143344.GD992@aaronlu/

And in this series, it seems to be merged in:
[RFC PATCH 07/13] sched: Add core wide task selection and scheduling
https://lore.kernel.org/lkml/e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com/

My local test shows that when two cgroup's share are both set to 1024
and each bound to one sibling of a core, start a cpu intensive task in
each cgroup, then the cpu intensive task will each consume 50% cpu. When
one cgroup's share set to 512, it will consume about 33% while the other
consumes 67%, as expected.

I think the current patch works fine when 2 differently tagged tasks are
competing CPU, but when there are 3 tasks or more, things can get less
fair.
