Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A48CC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214E9206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NO2cixJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDUQZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:25:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9B3C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E+VZuP5UASvBlDVg5ti5uG0guhQC0Mhbi6U/Zkjtonc=; b=NO2cixJ2hIhwMNoJ1ZRM/R+AtG
        A56+vQ8wKWc0juCuxi51VCpVD9+dwqZ99vpf3VzITFoYd6NTCauBXrlBbYop/Fcq72SDYEDh9rLMe
        JoapZYEgV3j7wb+wtANIw6a8YivRbIKTKymEiaKvP+oAN7jzmoQmQFFfDYnHqCcRixCWm9oakn7Bf
        ImFJKUT1RzRvAgKo5ZWTmOLJewL+3oUQX009Gwwco47p9Ea9LpuGSeNevKZME1s5kkF3U3TEfa86O
        5Kckis7VJtRNw1mO1TGWZK8eg2fYvxbCEYcNOkpheLUOazwj6YRP29v7Z9c5uq7aEKiq1HrDH02UG
        ndilG9Cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQvhg-00022Z-Jq; Tue, 21 Apr 2020 16:24:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6980D306064;
        Tue, 21 Apr 2020 18:24:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27ED12BAC8715; Tue, 21 Apr 2020 18:24:52 +0200 (CEST)
Date:   Tue, 21 Apr 2020 18:24:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        joel@joelfernandes.org
Subject: Re: [PATCH] sched/fair: Fix call walk_tg_tree_from() without hold
 rcu_lock
Message-ID: <20200421162452.GV20730@hirez.programming.kicks-ass.net>
References: <20200406121008.62903-1-songmuchun@bytedance.com>
 <20200421135258.GS20730@hirez.programming.kicks-ass.net>
 <20200421154312.GO17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421154312.GO17661@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 08:43:12AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 21, 2020 at 03:52:58PM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 06, 2020 at 08:10:08PM +0800, Muchun Song wrote:
> > > The walk_tg_tree_from() caller must hold rcu_lock,
> > 
> > Not quite; with the RCU unification done 'recently' having preemption
> > disabled is sufficient. AFAICT preemption is disabled.
> > 
> > In fact; and I mentioned this to someone the other day, perhaps Joel; we
> > can go and delete a whole bunch of rcu_read_lock() from the scheduler --
> > basically undo all the work we did after RCU was split many years ago.
> 
> "If only I knew then what I know now..."
> 
> Then again, I suspect that we all have ample opportunity to use that
> particular old phrase.  ;-)

Quite so; I'm just fearing that rcu-lockdep annotation stuff. IIRC that
doesn't (nor can it, in general) consider the implicit preempt-disable
from locks and such for !PREEMPT builds.

