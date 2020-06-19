Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA12C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B153F20786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oAa/oi+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390764AbgFSRp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbgFSRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:45:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=13ZJQzrfJj7+YLK0QljS5Z5b2OI+ht2N1tTNhzsfu/g=; b=oAa/oi+mt7/J7uNq9VlNs9miJG
        Rz+2LCWRkHlWLwMABa/upa6/LXowJwXqTfxTUlkuSpubB7gPn5UWVAAjZ2rol7vk/Ioj9w29cBdZq
        eeADyCdxRcjAk9Ya5jppcFeSPaAuhHUHxU5O3FhnWJK6Rqtd3ty+F447oTrXXiXE7A4VJ9MRihxgb
        qPqMYNrv3yvPrjp9LC3bpiI0HZNA7COs8x7steq+w8QqOdgevYnUUqfZeYdO7IUnSdHL0vxfo3hsC
        ZK5HTda6ViymwBaTrODD6l5M1+Yn80goPJPisNM+W+l2IuigvBdAHDIFeBqCBG1xwb+OUYJYy4swr
        m1kANaDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmL4j-0006Q6-BZ; Fri, 19 Jun 2020 17:45:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DB1B307159;
        Fri, 19 Jun 2020 19:45:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E23B421390E42; Fri, 19 Jun 2020 19:45:10 +0200 (CEST)
Date:   Fri, 19 Jun 2020 19:45:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200619174510.GB576888@hirez.programming.kicks-ass.net>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618195525.7889-3-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 08:55:25PM +0100, Qais Yousef wrote:

> +/*
> + * This static key is used to reduce the uclamp overhead in the fast path. It
> + * only disables the call to uclamp_rq_{inc, dec}() in enqueue/dequeue_task().
> + *
> + * This allows users to continue to enable uclamp in their kernel config with
> + * minimum uclamp overhead in the fast path.
> + *
> + * As soon as userspace modifies any of the uclamp knobs, the static key is
> + * disabled, since we have an actual users that make use of uclamp
> + * functionality.
> + *
> + * The knobs that would disable this static key are:
> + *
> + *   * A task modifying its uclamp value with sched_setattr().
> + *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
> + *   * An admin modifying the cgroup cpu.uclamp.{min, max}
> + */
> +DEFINE_STATIC_KEY_TRUE(sched_uclamp_unused);

Maybe call the thing: 'sched_uclamp_users', instead?


> +		if (static_branch_unlikely(&sched_uclamp_unused))
> +			static_branch_disable(&sched_uclamp_unused);


> +	if (static_branch_unlikely(&sched_uclamp_unused))
> +		static_branch_disable(&sched_uclamp_unused);


> +	if (static_branch_unlikely(&sched_uclamp_unused))
> +		static_branch_disable(&sched_uclamp_unused);

That's an anti-pattern... just static_branch_disable(), or _enable()
with a 'better' name is sufficient.
