Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49412C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A162078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592238214;
	bh=XalKfGZb8n85Dlowgyhn+CM2djvVHZZnTX/8wIWHJ7w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=oTE2LsoZfFaCqhWaxVq89p98IJwkG2mfrfeM0gFHt4/OnoKhKVLBSOqROJ5msVN17
	 q71gYKC22rQ08YQK+OMiisLzFLyzjJvZaXWU9qkKAfD9uynaCDzbFaP1AXYaIkaaMZ
	 tSGVxb+rsItFQa1zMBvk9yNEG79M09hVi+y6v3cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbgFOQXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbgFOQXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:23:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2D72078A;
        Mon, 15 Jun 2020 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592238211;
        bh=XalKfGZb8n85Dlowgyhn+CM2djvVHZZnTX/8wIWHJ7w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G80YnnLbQpmqujLdva4c9XxxuubAh89NU3DkHMzNo/CP4kG0h5Ml/XfwwnXIUBG5j
         mA2zb2XW9oORXy/lSyUhYA2bHKe0TAgaLKYatuf8Id7nYFcP5c7Xo4LGQz38L23ENF
         65vAefPlo9mavATRzrlriaLouZAAxHxSZ6Qs8SJ0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CAECE3522EFD; Mon, 15 Jun 2020 09:23:30 -0700 (PDT)
Date:   Mon, 15 Jun 2020 09:23:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200615162330.GF2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615125654.678940605@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615125654.678940605@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 02:56:54PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> So Paul reported rcutorture hitting a NULL dereference, and patch #1 fixes it.
> 
> Now, patch #1 is obviously correct, but I can't explain how exactly it leads to
> the observed NULL pointer dereference. The NULL pointer deref happens in
> find_matching_se()'s last while() loop when is_same_group() fails even though
> both parents are NULL.

My bisection of yet another bug sometimes hits the scheduler NULL pointer
dereference on older commits.  I will try out patch #2.

Whether this is reassuring or depressing, I have no idea.  :-/

> The only explanation I have for that is that we just did an activate_task()
> while: 'task_cpu(p) != cpu_of(rq)', because then 'p->se.cfs_rq' doesn't match.
> However, I can't see how the lack of #1 would lead to that. Never-the-less,
> patch #2 adds assertions to warn us of this case.
> 
> Patch #3 is a trivial rename that ought to eradicate some confusion.
> 
> The last 3 patches is what I ended up with for cleaning up the whole
> smp_call_function/irq_work/ttwu thing more.

Would it be possible to allow a target CPU # on those instances of
__call_single_data?  This is extremely helpful for debugging lost
smp_call_function*() calls.

						Thanx, Paul
