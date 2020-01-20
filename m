Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10A9C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A481D207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="drlf/lv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgATJqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:46:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r+1nAWmStsx1W0Mncj8oslK7JAfdKBwT1U0UP3+9CI8=; b=drlf/lv9jdhA3+nIIljdFgXOw
        xnEEHXo9FnzKHUFisLCRxb2Kfpdany1orOIHPH1Uw9jqc1X6NI6lgtjMvnTq7WcrG+wzJ1P1hP4JA
        QShg/1NN0l0QdI+uFcsl1QL9lGwu+IE/nbaZ9oXBRkAh7qqkaI1yp3zV+DPnoHx1U7ClITG0MgSJ3
        mKyQhOjgL5T4wCN99+VEuU7t5n++ymT6v5Pl47fXufxaShUmoiE8/5s0LhSbCh9Vz+Eg8ioYvBh81
        2PTY+1lNS4oubxZZFCoiZdKsdH23a6NGPreJokrQOjxedBmoWJE/IYkQrrxZ7uX2Ji66XMvNPBtiO
        L47DipvRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itTdb-0008JF-7H; Mon, 20 Jan 2020 09:46:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B24A9305E4E;
        Mon, 20 Jan 2020 10:44:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43A002041FB24; Mon, 20 Jan 2020 10:46:25 +0100 (CET)
Date:   Mon, 20 Jan 2020 10:46:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     bsegall@google.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair : prevent unlimited runtime on throttled group
Message-ID: <20200120094625.GL14879@hirez.programming.kicks-ass.net>
References: <1579011236-31256-1-git-send-email-vincent.guittot@linaro.org>
 <xm26blr5oprc.fsf@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26blr5oprc.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:29:43AM -0800, bsegall@google.com wrote:
> Vincent Guittot <vincent.guittot@linaro.org> writes:
> 
> > When a running task is moved on a throttled task group and there is no
> > other task enqueued on the CPU, the task can keep running using 100% CPU
> > whatever the allocated bandwidth for the group and although its cfs rq is
> > throttled. Furthermore, the group entity of the cfs_rq and its parents are
> > not enqueued but only set as curr on their respective cfs_rqs.
> >
> > We have the following sequence:
> >
> > sched_move_task
> >   -dequeue_task: dequeue task and group_entities.
> >   -put_prev_task: put task and group entities.
> >   -sched_change_group: move task to new group.
> >   -enqueue_task: enqueue only task but not group entities because cfs_rq is
> >     throttled.
> >   -set_next_task : set task and group_entities as current sched_entity of
> >     their cfs_rq.
> >
> > Another impact is that the root cfs_rq runnable_load_avg at root rq stays
> > null because the group_entities are not enqueued. This situation will stay
> > the same until an "external" event triggers a reschedule. Let trigger it
> > immediately instead.
> 
> Sounds reasonable to me, "moved group" being an explicit resched check
> doesn't sound like a problem in general.

Do I read that as an Ack from you Ben? :-)
