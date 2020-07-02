Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A82C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DD2208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cbU/1aJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgGBPX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGBPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:23:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6972C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pXEtcPdwJkh0YIo24ydg8Yw7EiugLDqfS0VpDKGt5CQ=; b=cbU/1aJgxTbSpnkotv65uRLc/s
        EhaiHKsFeWdPP9FG73EOTra/zoadr4lCfCEQWk+PWa3jT5uZ2KanSpMLWIKXMjy6GHEiFdA9dx4kO
        Y/axuv0rowswL4YzuNFRwuEQO2E5RrVBt/2em70y7eibmqUZAQeuhGTPRXNsBTZVRb/nq7EhlCgk6
        uEE7Kfa5bRgcaSg35FNmy/9apCS4R7VkRqKGebimckQiXTcNoge4xAyCCLWB54dboSReksalqhUCZ
        uODPA/UOeZ4lbqRBfV9l/HFtaM86YLk2OdHsN45ZHtSeyY9IDaKFSfcPuQSNc21MhkgtpdKbNfQXV
        kkUdhnjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr13a-0006GN-B3; Thu, 02 Jul 2020 15:23:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 737663013E5;
        Thu,  2 Jul 2020 17:23:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B33A203DA8DA; Thu,  2 Jul 2020 17:23:21 +0200 (CEST)
Date:   Thu, 2 Jul 2020 17:23:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        Oleg Nesterov <oleg@redhat.com>, david@fromorbit.com
Subject: Re: [RFC][PATCH] sched: Better document ttwu()
Message-ID: <20200702152321.GD4781@hirez.programming.kicks-ass.net>
References: <20200702125211.GQ4800@hirez.programming.kicks-ass.net>
 <20200702131319.GA186063@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702131319.GA186063@lorien.usersys.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 09:13:19AM -0400, Phil Auld wrote:
> On Thu, Jul 02, 2020 at 02:52:11PM +0200 Peter Zijlstra wrote:

> > + * p->on_cpu <- { 0, 1 }:
> > + *
> > + *   is set by prepare_task() and cleared by finish_task() such that it will be
> > + *   set before p is scheduled-in and cleared after p is scheduled-out, both
> > + *   under rq->lock. Non-zero indicates the task is running on it's CPU.
> 
> s/it's/its/

Fixed.

> > @@ -2494,15 +2608,41 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> >   * @state: the mask of task states that can be woken
> >   * @wake_flags: wake modifier flags (WF_*)
> >   *
> > - * If (@state & @p->state) @p->state = TASK_RUNNING.
> > + * Conceptually does:
> > + *
> > + *   If (@state & @p->state) @p->state = TASK_RUNNING.
> >   *
> >   * If the task was not queued/runnable, also place it back on a runqueue.
> >   *
> > - * Atomic against schedule() which would dequeue a task, also see
> > - * set_current_state().
> > + * This function:
> > + *  - is atomic against schedule() which would dequeue the task;
> > + *  - issues a full memory barrier before accessing @p->state.
> > + * See the comment with set_current_state().
> 
> I think these two above should not be " - " indented to match the other
> partial sentences below (or all the ones below should be bullets, but I
> think that is messier). But this is just a style quibble :)

Fair enough; I'll go rework that.

> > @@ -3134,8 +3274,12 @@ static inline void prepare_task(struct task_struct *next)
> >  	/*
> >  	 * Claim the task as running, we do this before switching to it
> >  	 * such that any running task will have this set.
> > +	 *
> > +	 * __schedule()'s rq->lock and smp_mb__after_spin_lock() orders this
> > +	 * store against prior state change of @next, also see
> > +	 * try_to_wake_up(), specifically smp_load_acquire(&p->on_cpu).
> >  	 */
> > -	next->on_cpu = 1;
> > +	WRITE_ONCE(next->on_cpu, 1);
> 
> This is more than a documentation change.

It had better be an effective no-change though; as documented we only
ever write 0 or 1, so even if the compiler is evil and tears our write,
it is impossible to get this wrong.

The reason I made it WRITE_ONCE() is because the other write is
smp_store_release() and the two loads are smp_load_acquire(), so a plain
store is 'weird'.
