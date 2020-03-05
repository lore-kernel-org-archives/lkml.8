Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A7C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D932146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1Yh3iJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgCEIIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:08:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgCEIIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2vUxcWSBxgMRCqEOlrTWW9ANDdfkmk3/6kkvI8hO640=; b=J1Yh3iJYCdzTiyRjHAGpxloqMJ
        H44e90CLausiPgHBi6VoFQscgRWRAmga9EIDgiA9I7wVwIC+lH1v8pcPm7a2NBsBQnLzsiqdsZmGt
        3z4sEBikx4oXkZzSc/r8IYmbK+0k1kdafd7fjaSVYNWOKk0YVcbENf66vOczhIu+1COWzEDPB0RA0
        0TPVO77H6dmet6DiJsBn3+j3bsPwVNnVoSqrz6BijH/aKgIlXOw7F+jM4iARazSUKfcvUPv10rIHf
        0D9q6wVQaNYYVry4sGMZ5BrmmVE7KD7VRoPZ+GiYIMM9gY/x3eMmqwB8Q30KdxuEVGum95/42jHFZ
        TLilqaVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9lXx-0000BV-QA; Thu, 05 Mar 2020 08:07:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3CCD300606;
        Thu,  5 Mar 2020 09:05:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6CE923D4FA08; Thu,  5 Mar 2020 09:07:55 +0100 (CET)
Date:   Thu, 5 Mar 2020 09:07:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Pinning down a blocked task to extract diagnostics
Message-ID: <20200305080755.GS2596@hirez.programming.kicks-ass.net>
References: <20200305005049.GA21120@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305005049.GA21120@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:50:49PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> Suppose that I need to extract diagnostics information from a blocked
> task, but that I absolutely cannot tolerate this task awakening in the
> midst of this extraction process.  Is the following code the right way
> to make this work given a task "t"?
> 
> 	raw_spin_lock_irq(&t->pi_lock);
> 	if (t->on_rq) {
> 		/* Task no longer blocked, so ignore it. */
> 	} else {
> 		/* Extract consistent diagnostic information. */
> 	}
> 	raw_spin_unlock_irq(&t->pi_lock);
> 
> It looks like all the wakeup paths acquire ->pi_lock, but I figured I
> should actually ask...

Close, the thing pi_lock actually guards is the t->state transition *to*
TASK_WAKING/TASK_RUNNING, so something like this:

	raw_spin_lock_irq(&t->pi_lock);
	switch (t->state) {
	case TASK_RUNNING:
	case TASK_WAKING:
		/* ignore */
		break;

	default:
		/* Extract consistent diagnostic information. */
		break;
	}
	raw_spin_unlock_irq(&t->pi_lock);

ought to work. But if you're going to do this, please add a reference to
that code in a comment on top of try_to_wake_up(), such that we can
later find all the code that relies on this.
