Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5EDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8922BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0SW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:22:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgH0SW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:22:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B5EAACE3;
        Thu, 27 Aug 2020 18:22:55 +0000 (UTC)
Date:   Thu, 27 Aug 2020 19:22:21 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/numa: use runnable_avg to classify node
Message-ID: <20200827182221.GG3033@suse.de>
References: <20200825121818.30260-1-vincent.guittot@linaro.org>
 <20200827153534.GF3033@suse.de>
 <CAKfTPtCRmts+qH+hexKbhZ7595zGs1U3Q5V4-XzHgpU0dJd+1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtCRmts+qH+hexKbhZ7595zGs1U3Q5V4-XzHgpU0dJd+1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 05:43:11PM +0200, Vincent Guittot wrote:
> > The testing was a mixed bag of wins and losses but wins more than it
> > loses. Biggest loss was a 9.04% regression on nas-SP using openmp for
> > parallelisation on Zen1. Biggest win was around 8% gain running
> > specjbb2005 on Zen2 (with some major gains of up to 55% for some thread
> > counts). Most workloads were stable across multiple Intel and AMD
> > machines.
> >
> > There were some oddities in changes in NUMA scanning rate but that is
> > likely a side-effect because the locality over time for the same loads
> > did not look obviously worse. There was no negative result I could point
> > at that was not offset by a positive result elsewhere. Given it's not
> > a univeral win or loss, matching numa and lb balancing as closely as
> > possible is best so
> >
> > Reviewed-by: Mel Gorman <mgorman@suse.de>
> 
> Thanks.
> 
> I will try to reproduce the nas-SP test on my setup to see what is going one
> 

You can try but you might be chasing ghosts. Please note that this nas-SP
observation was only on zen1 and only for C-class and OMP. The other
machines tested for the same class and OMP were fine (including zen2). Even
D-class on the same machine with OMP was fine as was MPI in both cases. The
bad result indicated that NUMA scanning and faulting was higher but that
is more likely to be a problem with NUMA balancing than your patch.

In the five iterations, two iterations showed a large spike in scan rate
towards the end of an iteration but not the other three. The scan rate
was also not consistently high so there is a degree of luck involved with
SP specifically and there is not a consistently penalty as a result of
your patch.

The only thing to be aware of is that this patch might show up in
bisections once it's merged for both performance gains and losses.

-- 
Mel Gorman
SUSE Labs
