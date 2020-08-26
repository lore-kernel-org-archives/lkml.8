Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377E5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8852067C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUYqtN2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHZJvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgHZJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:51:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VEw0fSExpNbRt5vwrktYz/cnO18y6hD3RYPNSwCk5go=; b=dUYqtN2SHDmWh1OIFlhhSLRHI9
        NCN4t7qkFgMkv/L9dwV+EsRdlXRkHTf7RId7iYueSJrYCLXCewQPvoChzk4352DcthUd2+63dM/rj
        wuqMc0vXfQl89wn0u9yVcTBVIE3NCphfVRr8GCQhN+waIe7A14QnhowcljmA9hCNxDeWEPH11NXWV
        a3LNhXVsGgMZrbUuylg0NVqAohOL/f6WQjQAJsB/D9smOQe8LebiL7bquTv0tcBb0boOuW7Hymf/8
        tHr/uePsi8AIuTRxWUrGYjWYPNsR+CUVoxjW8+MESH0WsneF26bwlFa17MyHbQwgp1kpgQsPEnGW9
        a4vIlihg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAs5p-00071s-OH; Wed, 26 Aug 2020 09:51:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17FEC301A66;
        Wed, 26 Aug 2020 11:51:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F09FF2BF6E0F8; Wed, 26 Aug 2020 11:51:44 +0200 (CEST)
Date:   Wed, 26 Aug 2020 11:51:44 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com>,
        fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: INFO: rcu detected stall in smp_call_function
Message-ID: <20200826095144.GD1362448@hirez.programming.kicks-ass.net>
References: <000000000000903d5805ab908fc4@google.com>
 <20200729125811.GA70158@hirez.programming.kicks-ass.net>
 <20200825132411.GR35926@hirez.programming.kicks-ass.net>
 <20200825154841.GQ2855@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825154841.GQ2855@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 08:48:41AM -0700, Paul E. McKenney wrote:

> > Paul, I wanted to use this function, but found it has very weird
> > semantics.
> > 
> > Why do you need it to (remotely) call @func when p is current? The user
> > in rcu_print_task_stall() explicitly bails in this case, and the other
> > in rcu_wait_for_one_reader() will attempt an IPI.
> 
> Good question.  Let me look at the invocations:
> 
> o	trc_wait_for_one_reader() bails on current before
> 	invoking try_invoke_on_locked_down_task():
> 
> 	if (t == current) {
> 		t->trc_reader_checked = true;
> 		trc_del_holdout(t);
> 		WARN_ON_ONCE(t->trc_reader_nesting);
> 		return;
> 	}
> 
> o	rcu_print_task_stall() might well invoke on the current task,
> 	low though the probability of this happening might be.	(The task
> 	has to be preempted within an RCU read-side critical section
> 	and resume in time for the scheduling-clock irq that will report
> 	the RCU CPU stall to interrupt it.)
> 
> 	And you are right, no point in an IPI in this case.
> 
> > Would it be possible to change this function to:
> > 
> >  - blocked task: call @func with p->pi_lock held
> >  - queued, !running task: call @func with rq->lock held
> >  - running task: fail.
> > 
> > ?
> 
> Why not a direct call in the current-task case, perhaps as follows,
> including your change above?  This would allow the RCU CPU stall
> case to work naturally and without the IPI.
> 
> Would that work for your use case?

It would in fact, but at this point I'd almost be inclined to stick the
IPI in as well. But small steps I suppose. So yes.
