Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2CEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E73C20787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctMOpVo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbgDODeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389615AbgDODeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:34:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 20:34:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so6210886pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 20:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32JTQsSOiGMnOtaV4osk6e3NaJQfnH9OiK4r6o9eqvk=;
        b=ctMOpVo2IvMmoGRN3FmF2VEikuRu8T13jg2r7gISZlSgIMXyaNKQuF1j0m40ktWcN7
         ZPiWgVZ6MTClUCKAFDI7QCL4QuyBF2gFdRRVp50JncVCSB4jd86uc19TtnWQ+OzBT6fP
         TvT0fXBMuqVPyZvt6bJr6SjjX48dLUyDkrXzKI1lzrF7aq4TQBZg1Wq2NPD7G4ZP+Gyh
         uK15ICM0J9k1ekvn9bVdUjuOifyUT+v7Ylab0BlxXertjGDNaliC1xC5g9UVh6U3KJ0/
         g17fCrUXu0y7iJbxM5GUsjQ6nJ0L4rBDlhXjA2R+XA9Z3/LPf27+QZrtFDIjcGbSsgVB
         fhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32JTQsSOiGMnOtaV4osk6e3NaJQfnH9OiK4r6o9eqvk=;
        b=LYvyH+YfiV7ohQ5dW0aQv7EWe9P7WWTW2yyg4AIAI9uWGQBjXZKTzNRwVFCSEXY0om
         vrWrXyvAP7TlfHr874f5YI3cUehv69dVoYNcF/40MluIhMF79zXzLvMXMaBsaMtB0+p9
         FR2Hqare2VRkeKGyGEBLY+zyYdL9UszYezWCAM2gDdsnypR9IQ+3wWwAmWBJnytXabiS
         x0270gtFAVz8+6SNN3Zh9KFpJ6Ceatm81OZ0jsOehQmaG8YlXBYQCRztJ9TPos60nUOL
         PsLunfW6BvIVQuqvj8zA9V39h8h4fH4BTbhHATNZZ+YNtCohEwWwUXfqlrs5HfEmZkCJ
         i+XA==
X-Gm-Message-State: AGi0PuYJbKIGmmt4l668ZKHoBXTyKowgi+HKAe1Pi6X4bwBke8KO0QIh
        yrdG50LLl643GcHcwrll2yg=
X-Google-Smtp-Source: APiQypLSLXF80UtZPTdPJCbDwoFZArf4jgIGs+PqvYDsHkNXQnxjqHVHmAR8MeEkViTtYBPLWBnBAw==
X-Received: by 2002:a17:90a:c401:: with SMTP id i1mr3678168pjt.131.1586921663111;
        Tue, 14 Apr 2020 20:34:23 -0700 (PDT)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id 71sm1759746pfw.111.2020.04.14.20.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 20:34:22 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:34:08 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: Re: [RFC PATCH 09/13] sched/fair: core wide vruntime comparison
Message-ID: <20200415033408.GA168322@ziqianlu-desktop.localdomain>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414135624.GU20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 03:56:24PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 04:59:59PM +0000, vpillai wrote:
> > From: Aaron Lu <aaron.lu@linux.alibaba.com>
> > 
> > This patch provides a vruntime based way to compare two cfs task's
> > priority, be it on the same cpu or different threads of the same core.
> > 
> > When the two tasks are on the same CPU, we just need to find a common
> > cfs_rq both sched_entities are on and then do the comparison.
> > 
> > When the two tasks are on differen threads of the same core, the root
> > level sched_entities to which the two tasks belong will be used to do
> > the comparison.
> > 
> > An ugly illustration for the cross CPU case:
> > 
> >    cpu0         cpu1
> >  /   |  \     /   |  \
> > se1 se2 se3  se4 se5 se6
> >     /  \            /   \
> >   se21 se22       se61  se62
> > 
> > Assume CPU0 and CPU1 are smt siblings and task A's se is se21 while
> > task B's se is se61. To compare priority of task A and B, we compare
> > priority of se2 and se6. Whose vruntime is smaller, who wins.
> > 
> > To make this work, the root level se should have a common cfs_rq min
> > vuntime, which I call it the core cfs_rq min vruntime.
> > 
> > When we adjust the min_vruntime of rq->core, we need to propgate
> > that down the tree so as to not cause starvation of existing tasks
> > based on previous vruntime.
> 
> You forgot the time complexity analysis.

This is a mistake and the adjust should be needed only once when core
scheduling is initially enabled. It is an initialization thing and there
is no reason to do it in every invocation of coresched_adjust_vruntime().

Vineeth,

I think we have talked about this before and you agreed that it is
needed only once:
https://lore.kernel.org/lkml/20191012035503.GA113034@aaronlu/
https://lore.kernel.org/lkml/CANaguZBevMsQ_Zy1ozKn2Z5Uj6WBviC6UU+zpTQOVdDDLK6r2w@mail.gmail.com/

I'll see how to fix it, but feel free to beat me to it.
 
> > +static void coresched_adjust_vruntime(struct cfs_rq *cfs_rq, u64 delta)
> > +{
> > +	struct sched_entity *se, *next;
> > +
> > +	if (!cfs_rq)
> > +		return;
> > +
> > +	cfs_rq->min_vruntime -= delta;
> > +	rbtree_postorder_for_each_entry_safe(se, next,
> > +			&cfs_rq->tasks_timeline.rb_root, run_node) {
> 
> Which per this ^
> 
> > +		if (se->vruntime > delta)
> > +			se->vruntime -= delta;
> > +		if (se->my_q)
> > +			coresched_adjust_vruntime(se->my_q, delta);
> > +	}
> > +}
> 
> > @@ -511,6 +607,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
> >  
> >  	/* ensure we never gain time by being placed backwards. */
> >  	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
> > +	update_core_cfs_rq_min_vruntime(cfs_rq);
> >  #ifndef CONFIG_64BIT
> >  	smp_wmb();
> >  	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
> 
> as called from here, is exceedingly important.
> 
> Worse, I don't think our post-order iteration is even O(n).
> 
> 
> All of this is exceedingly yuck.
