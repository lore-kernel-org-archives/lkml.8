Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBFEC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43033207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofeKnhF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGTNSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:18:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E6C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fka4lgVIRhwxWY7wdGf+lk4haYXHjArIUWvf5xU498Y=; b=ofeKnhF0/s4PM7m8Ts7xEgAm6e
        4XrK/EID/UoZrHIy/XUy80Kfb2IsCqgIozBD+tgBLQIk4X/hzgi/XKoV87bcYRGyH8Gk8babQ6SEw
        VRR9r2xkDJMxuE1mX6MywVCKdScWqgW2WgXyf3QPZn30ZBYQBfslwnZmqSKSaaoodSy18XjuZ8EZO
        exHhxhNrizW3i2EOpmHDAzbynm0srJK6PTYw5qMswZoAoCvLMFIfFviLMXUkLp+mZGCtTq/zlKue+
        hRxAqkju2pOYZCsfH3CElYC6st8qlBATrA8RbK08wAFvOKOQ5AN3K5ewGH9Ae7bY8XENNVtCLvsXB
        2eulvBhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxVfy-0000P8-9l; Mon, 20 Jul 2020 13:17:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E40B6300446;
        Mon, 20 Jul 2020 15:17:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDD592215BE46; Mon, 20 Jul 2020 15:17:47 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:17:47 +0200
From:   peterz@infradead.org
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720131747.GD119549@hirez.programming.kicks-ass.net>
References: <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720112623.GF43129@hirez.programming.kicks-ass.net>
 <jhjwo2yidit.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjwo2yidit.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:20:26PM +0100, Valentin Schneider wrote:
> On 20/07/20 12:26, peterz@infradead.org wrote:

> > +	/*
> > +	 * We must re-load prev->state in case ttwu_remote() changed it
> > +	 * before we acquired rq->lock.
> > +	 */
> > +	tmp_state = prev->state;
> > +	if (unlikely(prev_state != tmp_state)) {
> > +		/*
> > +		 * ptrace_{,un}freeze_traced() think it is cool to change
> > +		 * ->state around behind our backs between TASK_TRACED and
> > +		 *  __TASK_TRACED.
> > +		 *
> > +		 * This is safe because this, as well as any __TASK_TRACED
> > +		 * wakeups are under siglock.
> > +		 *
> > +		 * For any other case, a changed prev_state must be to
> > +		 * TASK_RUNNING, such that when it blocks, the load has
> > +		 * happened before the smp_mb().
> > +		 *
> > +		 * Also see the comment with deactivate_task().
> > +		 */
> > +		SCHED_WARN_ON(tmp_state && (prev_state & __TASK_TRACED &&
> > +					   !(tmp_state & __TASK_TRACED)));
> > +
> 
> IIUC if the state changed and isn't TASK_RUNNING it *has* to have
> __TASK_TRACED, so can't that be
> 
>   SCHED_WARN_ON(tmp_state && !(tmp_state & __TASK_TRACED));

Suppose task->state == TASK_UNINTERRUPTIBLE, and task != current, and
then someone goes and does task->state = __TASK_TRACED.

That is, your statement is correct given the current code, but we also
want to verify no new code comes along and does something 'creative'.

Or is the heat getting to me?
