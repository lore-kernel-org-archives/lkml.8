Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA6EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FA220771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="edX3pPAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895694AbgDOJgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895655AbgDOJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:36:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA34C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gzpmZPmtxEm/2WaOlqs6ZzLJj6vb3mNUa4I7Dm8/uDM=; b=edX3pPAoPijTJTeTth2ags5AR0
        Y3DrxNVp/qrkW3CQ4Y0cxF3siDEy8nBU3q0CTfayywsYSmkN+JFYjqnzkYlCJVQ5mXvYRdmOZahb4
        Jg7Yz9W8HDWiOO7DARnB80lfWjll/ly737+HxaBheLglk7HV6VJoIwZWIqq9NRP5jVXcgxI5W3Zp6
        2t1mU2szi32MxsEZIj9hgJXJ5yGEVyTaSeCHHt9pxhU+bSE2p7XDQ+6nTybHeMwsYApgXbu4ovANn
        lzIrS3WoHFQ/C5XuJTXT2/ta4L3/i3lhXdEVucDOrD8OyGjIsZYtUjIes3JVxh9mJCk6ZCFrfW0IV
        7d6OV96Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOeSx-0007Zs-7M; Wed, 15 Apr 2020 09:36:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 333B2305EEC;
        Wed, 15 Apr 2020 11:36:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10E2F2BC6F2D6; Wed, 15 Apr 2020 11:36:17 +0200 (CEST)
Date:   Wed, 15 Apr 2020 11:36:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cpumask: Make cpumask_any() truly random
Message-ID: <20200415093617.GZ20730@hirez.programming.kicks-ass.net>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <20200414150556.10920-3-qais.yousef@arm.com>
 <20200414121956.3687d6e9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414121956.3687d6e9@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:19:56PM -0400, Steven Rostedt wrote:

> > +/**
> > + * cpumask_any - pick a "random" cpu from *srcp
> > + * @srcp: the input cpumask
> > + *
> > + * Returns >= nr_cpu_ids if no cpus set.
> > + */
> > +int cpumask_any(const struct cpumask *srcp)
> > +{
> > +	int next, prev;
> > +
> > +	/* NOTE: our first selection will skip 0. */
> > +	prev = __this_cpu_read(distribute_cpu_mask_prev);
> > +
> > +	next = cpumask_next(prev, srcp);
> > +	if (next >= nr_cpu_ids)
> > +		next = cpumask_first(srcp);
> > +
> > +	if (next < nr_cpu_ids)
> > +		__this_cpu_write(distribute_cpu_mask_prev, next);
> 
> Do we care if this gets preempted and migrated to a new CPU where we read
> "prev" from one distribute_cpu_mask_prev on one CPU and write it to another
> CPU?

I don't think we do; that just adds to the randomness ;-), but you do
raise a good point in that __this_cpu_*() ops assume preemption is
already disabled, which is true of the one exiting
cpumask_any_and_distribute() caller, but is no longer true after patch
1, and this patch repeats the mistake.

So either we need to disable preemption across the function or
transition to this_cpu_*() ops.
