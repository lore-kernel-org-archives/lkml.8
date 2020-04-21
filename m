Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47D0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981912070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587483794;
	bh=R/NUADyVb0jPVXUwpPx85cw01ErbiN3Dhg1JGLpE6VI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vt7tPYOuB17eq4BwcMxwDo1Qor+gendckYBRZVNV7z/hLNlUKSgkzQvoMlIg1GCnd
	 dt0921aPP6BIGfHFo0L7/e5NRhUPkUdY+Bw8OVr6FnvNZppG32bPGY/Mmb03bXj/hf
	 p7I+PbRb6xjgUxuZSkzraZNu4rCPuDiJ4yfrrr3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgDUPnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgDUPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:43:13 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7D9206E9;
        Tue, 21 Apr 2020 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587483792;
        bh=R/NUADyVb0jPVXUwpPx85cw01ErbiN3Dhg1JGLpE6VI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ao8x/58ZZn7la+yBfyCFYFfuYED3lx9rg33fSVBDhbUeyu6r+7+Ru8Pj7mzLKt+0A
         WQZoZJcNG+1Trmv3u/3eNwm5VKgPLCpp/hykxPlpPatRLIpIXBaDlvOjE4T2qorEhn
         aiS5/YieEeUqadhHEYAdSPgVuKtxZs2IS4QheqKY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C0ED33523432; Tue, 21 Apr 2020 08:43:12 -0700 (PDT)
Date:   Tue, 21 Apr 2020 08:43:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        joel@joelfernandes.org
Subject: Re: [PATCH] sched/fair: Fix call walk_tg_tree_from() without hold
 rcu_lock
Message-ID: <20200421154312.GO17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200406121008.62903-1-songmuchun@bytedance.com>
 <20200421135258.GS20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421135258.GS20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:52:58PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 06, 2020 at 08:10:08PM +0800, Muchun Song wrote:
> > The walk_tg_tree_from() caller must hold rcu_lock,
> 
> Not quite; with the RCU unification done 'recently' having preemption
> disabled is sufficient. AFAICT preemption is disabled.
> 
> In fact; and I mentioned this to someone the other day, perhaps Joel; we
> can go and delete a whole bunch of rcu_read_lock() from the scheduler --
> basically undo all the work we did after RCU was split many years ago.

"If only I knew then what I know now..."

Then again, I suspect that we all have ample opportunity to use that
particular old phrase.  ;-)

							Thanx, Paul
