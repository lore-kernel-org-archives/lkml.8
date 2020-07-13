Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2413BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65A02072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jCo9jqpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgGMNnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgGMNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:43:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116CFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H60QSIEvtp8VyWGFJoKXns6uiYF+y78pd7daWzoQwYQ=; b=jCo9jqpl7dbYSIom/mcJQyx9HS
        KKrtGxbK1lB5K7t37mmVfXYR89s1IMRB6dS3zb0WWRosi09emlrt7fWFGIKllZ4ccf+/yB3Bb6kSQ
        XcOtLZQ6KQszXO+Aayo//JvHjQK0m1cLlJ9eHn02d9L37yJBOdVKGKsLtAQUKpX9WO4/52/bUFL/r
        zDjbqhY38ouCsU7e0cNUfzRjuWXrYdRrmEKTuiXWLU2qjUq654VG0hODS0F/kDAwUdG5wQ9w5F7Kn
        kF2BKZqhWfSUW900zd9rj94wL5YCrxiNikJ8ETer/1atu6wWV/qVCtRmslXRoagjfXsL1/gyWSTj4
        fe6ha3hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juykH-0004HQ-DU; Mon, 13 Jul 2020 13:43:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F6C3300DB4;
        Mon, 13 Jul 2020 15:43:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D76B2141F065; Mon, 13 Jul 2020 15:43:47 +0200 (CEST)
Date:   Mon, 13 Jul 2020 15:43:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: Re: [PATCH v3 7/7] sched/topology: Use prebuilt SD flag degeneration
 mask
Message-ID: <20200713134347.GL10769@hirez.programming.kicks-ass.net>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-8-valentin.schneider@arm.com>
 <20200713125543.GJ10769@hirez.programming.kicks-ass.net>
 <jhjimerlf2a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjimerlf2a.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:28:29PM +0100, Valentin Schneider wrote:
> 
> On 13/07/20 13:55, Peter Zijlstra wrote:
> > On Wed, Jul 01, 2020 at 08:06:55PM +0100, Valentin Schneider wrote:
> >> Leverage SD_DEGENERATE_GROUPS_MASK in sd_degenerate() and
> >> sd_degenerate_parent().
> >>
> >> Note that this changes sd_degenerate() somewhat: I'm using the negation of
> >> SD_DEGENERATE_GROUPS_MASK as the mask of flags not requiring groups, which
> >> is equivalent to:
> >>
> >> SD_WAKE_AFFINE | SD_SERIALIZE | SD_NUMA
> >>
> >> whereas the current mask for that is simply
> >>
> >> SD_WAKE_AFFINE
> >>
> >> I played with a few toy NUMA topologies on QEMU and couldn't cause a
> >> different degeneration than what mainline does currently. If that is deemed
> >> too risky, we can go back to using SD_WAKE_AFFINE explicitly.
> >
> > Arguably SD_SERIALIZE needs groups, note how we're only having that
> > effective for machines with at least 2 nodes. It's a bit shit how we end
> > up there, but IIRC that's what it ends up as.
> >
> 
> Right, AFAICT we get SD_SERIALIZE wherever we have SD_NUMA, which is any
> level above NODE.

Oh, right, I forgot we have NODE, d'0h. But in that case these lines:

	if (nr_node_ids == 1)
		pflags &= ~SD_SERIALIZE;

are dead code, right?

> > SD_NUMA is descriptive, and not marking a group as degenerates because
> > it has SD_NUMA seems a bit silly.
> 
> It does, although we can still degenerate it, see below.
> 
> > But then, it would be the top domain
> > and would survive anyway?
> 
> So from what I've tested we still get rid of those via
> sd_parent_degenerate(): child and parent have the same flags and same span,
> so parent goes out.
> 
> That happens in the middle of the NUMA topology levels on that borked
> topology with weird distances, aka
> 
>   node distances:
>   node   0   1   2   3
>     0:  10  12  20  22
>     1:  12  10  22  24
>     2:  20  22  10  12
>     3:  22  24  12  10
> 
> which ought to look something like (+local distance to end result)
> 
>       2      10      2
>   1 <---> 0 <---> 2 <---> 3
> 
> We end up with the following NUMA levels (i.e. deduplicated distances)
>   NUMA (<= 12)
>   NUMA (<= 20)
>   NUMA (<= 22)
>   NUMA (<= 24)
> 
> For e.g. any CPU of node1, NUMA(<=20) is gonna have the same span as
> NUMA(<=12), so we'll degenerate it.

Man, that's horrible :-) OK, fair enough, keep it as is, we'll see what
if anything breaks.
