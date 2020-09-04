Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0C6C54F45
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EB521D42
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgIDRkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:40:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgIDRkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:40:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA18CB6C2;
        Fri,  4 Sep 2020 17:40:22 +0000 (UTC)
Date:   Fri, 4 Sep 2020 10:24:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200904172432.wgxn6x5tpnt4lcln@linux-p48b>
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
 <20200901174938.GA8158@paulmck-ThinkPad-P72>
 <20200901235821.GA8516@paulmck-ThinkPad-P72>
 <20200902015128.wsulcxhbo7dutcjz@linux-p48b>
 <20200902155410.GH29330@paulmck-ThinkPad-P72>
 <20200903200639.GA8956@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200903200639.GA8956@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020, Paul E. McKenney wrote:

>commit d93a64389f4d544ded241d0ba30b2586497f5dc0
>Author: Paul E. McKenney <paulmck@kernel.org>
>Date:   Tue Sep 1 16:58:41 2020 -0700
>
>    torture: Periodically pause in stutter_wait()
>
>    Running locktorture scenario LOCK05 results in hangs:
>
>    tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
>
>    The lock_torture_writer() kthreads set themselves to MAX_NICE while
>    running SCHED_OTHER.  Other locktorture kthreads run at default niceness,
>    also SCHED_OTHER.  This results in these other locktorture kthreads
>    indefinitely preempting the lock_torture_writer() kthreads.  Note that
>    the cond_resched() in the stutter_wait() function's loop is ineffective
>    because this scenario is built with CONFIG_PREEMPT=y.
>
>    It is not clear that such indefinite preemption is supposed to happen, but
>    in the meantime this commit prevents kthreads running in stutter_wait()
>    from being completely CPU-bound, thus allowing the other threads to get
>    some CPU in a timely fashion.  This commit also uses hrtimers to provide
>    very short sleeps to avoid degrading the sudden-on testing that stutter
>    is supposed to provide.
>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviwed-by: Davidlohr Bueso <dbueso@suse.de>
