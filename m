Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA791C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEAE22CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgGTO00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:26:26 -0400
Received: from foss.arm.com ([217.140.110.172]:50158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgGTO0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:26:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67341D6E;
        Mon, 20 Jul 2020 07:26:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14B763F718;
        Mon, 20 Jul 2020 07:26:20 -0700 (PDT)
References: <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org> <20200718171406.GB16791@redhat.com> <20200718174448.4btbjcvp6wbbdgts@wittgenstein> <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org> <20200720064326.GA6612@redhat.com> <20200720082657.GC6612@redhat.com> <20200720084106.GJ10769@hirez.programming.kicks-ass.net> <20200720105924.GE43129@hirez.programming.kicks-ass.net> <20200720112623.GF43129@hirez.programming.kicks-ass.net> <jhjwo2yidit.mognet@arm.com> <20200720131747.GD119549@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
In-reply-to: <20200720131747.GD119549@hirez.programming.kicks-ass.net>
Date:   Mon, 20 Jul 2020 15:26:16 +0100
Message-ID: <jhjv9iii7p3.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/07/20 14:17, peterz@infradead.org wrote:
> On Mon, Jul 20, 2020 at 01:20:26PM +0100, Valentin Schneider wrote:
>> On 20/07/20 12:26, peterz@infradead.org wrote:
>
>> > +	/*
>> > +	 * We must re-load prev->state in case ttwu_remote() changed it
>> > +	 * before we acquired rq->lock.
>> > +	 */
>> > +	tmp_state = prev->state;
>> > +	if (unlikely(prev_state != tmp_state)) {
>> > +		/*
>> > +		 * ptrace_{,un}freeze_traced() think it is cool to change
>> > +		 * ->state around behind our backs between TASK_TRACED and
>> > +		 *  __TASK_TRACED.
>> > +		 *
>> > +		 * This is safe because this, as well as any __TASK_TRACED
>> > +		 * wakeups are under siglock.
>> > +		 *
>> > +		 * For any other case, a changed prev_state must be to
>> > +		 * TASK_RUNNING, such that when it blocks, the load has
>> > +		 * happened before the smp_mb().
>> > +		 *
>> > +		 * Also see the comment with deactivate_task().
>> > +		 */
>> > +		SCHED_WARN_ON(tmp_state && (prev_state & __TASK_TRACED &&
>> > +					   !(tmp_state & __TASK_TRACED)));
>> > +
>>
>> IIUC if the state changed and isn't TASK_RUNNING it *has* to have
>> __TASK_TRACED, so can't that be
>>
>>   SCHED_WARN_ON(tmp_state && !(tmp_state & __TASK_TRACED));
>
> Suppose task->state == TASK_UNINTERRUPTIBLE, and task != current, and
> then someone goes and does task->state = __TASK_TRACED.
>
> That is, your statement is correct given the current code, but we also
> want to verify no new code comes along and does something 'creative'.
>

That is what I was trying to go for; AFAICT your approach only warns if
__TASK_TRACED gets removed between the two loads (IOW it was already
there). The way I was seeing it is:

- We only get here if prev_state != tmp_state; IOW we know we raced with
  something
- if (tmp_state), then it wasn't with ttwu_remote()
- thus it must only be with ptrace shenanigans, IOW __TASK_TRACED must be
  there.

Now, what I suggested still doesn't detect what you pointed out, or some
crazier thing that sets __TASK_TRACED *and* some other stuff. IIUC the
ptrace transformation does TASK_TRACED -> __TASK_TRACED, so we could have
it as:

  /* TODO: name me */
  #define foobar TASK_TRACED ^ __TASK_TRACED

  ...

  /* not TASK_RUNNING; check against allowed transformations
  SCHED_WARN_ON(tmp_state && ((prev_state ^ tmp_state) & ~foobar));


That said...

> Or is the heat getting to me?

... that may apply to me as well :-)
