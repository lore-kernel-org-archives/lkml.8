Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97129C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC692072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yjYfo81n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgCDJwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:52:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgCDJwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tKeqTycVyzl7DYa83kr4ZG5LIFgM+C0+xw2HEdA4qUM=; b=yjYfo81n1EmRA/Vrnh0lQnkx/k
        5xXLtLgwJ10Y9SLDxuI4PBjCO1W2r4cvmVeKywMJOJVacUf4nOs0xlHZmHqjBpOm1GTqaw02TV1ZM
        rg8sqrC5iQI+ZtsTS3UK5mCT6v6NyC/a0Y6K1n3LedZOWexjSQQdHDhcE9KwIGkcIfyE+UzltDDyA
        63ZEH7V4LkiiJqvAKpIRDoFb+z+j3ZmcYTAvxhEHFBWrnRhLbzHI3cNYswND2ZdAIZ8FnKwNhZE5c
        k8gLaOsEcz5HzfqQq2c8HZQokvYkHxuYy4L1OqFakL1toaDKw9e0uWp1SiKMt9TFiPvfOZsTKcYNd
        j8DCBvCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9QhI-00082P-V4; Wed, 04 Mar 2020 09:52:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DBE43012C3;
        Wed,  4 Mar 2020 10:50:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F140820BCBDC5; Wed,  4 Mar 2020 10:52:09 +0100 (CET)
Date:   Wed, 4 Mar 2020 10:52:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq
 is too, small
Message-ID: <20200304095209.GK2596@hirez.programming.kicks-ass.net>
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net>
 <241603dd-1149-58aa-85cf-43f3da2de43f@linux.alibaba.com>
 <CAKfTPtB=+sMXYXEeb2WppUracxLNXQPJj0H7d-MqEmgrB3gTDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB=+sMXYXEeb2WppUracxLNXQPJj0H7d-MqEmgrB3gTDw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:47:34AM +0100, Vincent Guittot wrote:
> you will add +1 of nice prio for each device
> 
> should we use instead
> # define scale_load_down(w) ((w >> SCHED_FIXEDPOINT_SHIFT) ? (w >>
> SCHED_FIXEDPOINT_SHIFT) : MIN_SHARES)

That's '((w >> SHIFT) ?: MIN_SHARES)', but even that is not quite right.

I think we want something like:

#define scale_load_down(w) \
({ unsigned long ___w = (w); \
   if (___w) \
     ____w = max(MIN_SHARES, ___w >> SHIFT); \
   ___w; })

That is, we very much want to retain 0 I'm thinking.
