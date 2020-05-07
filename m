Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BB7C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C957721835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588874069;
	bh=QJaiSjCjLbAWFDcmuf/Pneq2du1jY9r042RVJds1hO0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=y2o5uI0AbVLo5bvd95ZGOk1vUzJg0CeCDzE6QGfumhuoCbaMRCL/TlR245lUD7UoB
	 +R1UPfNoRMIqzu0hj3TSoOEBvTio+QqkVv8Ptm8i5ouQE72uGviK+F94wq1YFS2O2G
	 sRKIsDXan4ZNy4BE9YnI33x9O2mEtlt6/lW2R7MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEGRy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGRy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:54:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1D52145D;
        Thu,  7 May 2020 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588874067;
        bh=QJaiSjCjLbAWFDcmuf/Pneq2du1jY9r042RVJds1hO0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pKD8QCZKdNeR4cgjo9ugXAKZQS8MIUuvWNTGi+44zq2pg862dujYCMPY35hu47AYD
         O6+hmKJ8TYF7QejWc8yOJ8ND9UfRKhg0yxPYnkEFAzRiYc86ZGk0CbtsKRZqwxRTJR
         +DLTSFziy5UChxjljtQe1VYZCq/s9RWAKawRIo20=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4493C35231BF; Thu,  7 May 2020 10:54:27 -0700 (PDT)
Date:   Thu, 7 May 2020 10:54:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <cai@lca.pw>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu()
Message-ID: <20200507175427.GT2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
 <20200506174019.GA2869@paulmck-ThinkPad-P72>
 <20200507171418.GC3180@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507171418.GC3180@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:14:19PM +0100, Catalin Marinas wrote:
> On Wed, May 06, 2020 at 10:40:19AM -0700, Paul E. McKenney wrote:
> > On Wed, May 06, 2020 at 12:22:37PM -0400, Qian Cai wrote:
> > > == call_rcu() leaks ==
> > > Another issue that might be relevant is that it seems sometimes,
> > > kmemleak will give a lot of false positives (hundreds) because the
> > > memory was supposed to be freed by call_rcu()  (for example, in
> > > dst_release()) but for some reasons, it takes a long time probably
> > > waiting for grace periods or some kind of RCU self-stall, but the
> > > memory had already became an orphan. I am not sure how we are going
> > > to resolve this properly until we have to figure out why call_rcu()
> > > is taking so long to finish?
> > 
> > I know nothing about kmemleak, but I won't let that stop me from making
> > random suggestions...
> > 
> > One approach is to do an rcu_barrier() inside kmemleak just before
> > printing leaked blocks, and check to see if any are still leaked after
> > the rcu_barrier().
> 
> The main issue is that kmemleak doesn't stop the world when scanning
> (which can take over a minute, depending on your hardware), so we get
> lots of transient pointer misses. There are some heuristics but
> obviously they don't always work.
> 
> With RCU, objects are queued for RCU freeing later and chained via
> rcu_head.next (IIUC). Under load, this list can be pretty volatile and
> if this happen during kmemleak scanning, it's sufficient to lose track
> of a next pointer and the rest of the list would be reported as a leak.
> 
> I think rcu_barrier() just before the starting the kmemleak scanning may
> help if it reduces the number of objects queued.

It might, especially if the call_rcu() rate is lower after the
rcu_barrier() than it was beforehand.  Which might well be the case when
a large cleanup activity ended just before rcu_barrier() was invoked.

> Now, I wonder whether kmemleak itself can break this RCU chain. The
> kmemleak metadata is allocated on a slab alloc callback. The freeing,
> however, is done using call_rcu() because originally calling back into
> the slab freeing from kmemleak_free() didn't go well. Since the
> kmemleak_object structure is not tracked by kmemleak, I wonder whether
> its rcu_head would break this directed pointer reference graph.

It is true that kmemleak could decide that being passed to call_rcu()
as being freed.  However, it would need to know the rcu_head offset.
And there are (or were) a few places that pass linked structures to
call_rcu(), and kmemleak would presumably need to mark them all free
at that point.  Or maybe accept the much lower false-positive rate from
not marking them.

> Let's try the rcu_barrier() first and I'll think about the metadata case
> over the weekend.

Looking forward to hearing how it goes!

							Thanx, Paul
