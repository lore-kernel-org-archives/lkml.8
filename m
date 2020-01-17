Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6EC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF622082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAQOPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:15:07 -0500
Received: from outbound-smtp23.blacknight.com ([81.17.249.191]:50825 "EHLO
        outbound-smtp23.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgAQOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:15:07 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id C8240B8BC3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:15:05 +0000 (GMT)
Received: (qmail 8437 invoked from network); 17 Jan 2020 14:15:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2020 14:15:05 -0000
Date:   Fri, 17 Jan 2020 14:15:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200117141503.GQ3466@techsingularity.net>
References: <20200114101319.GO3466@techsingularity.net>
 <20200116163529.GP3466@techsingularity.net>
 <CAKfTPtBznUt20QFzeQBPELcmN6+F=BOx09oSqVMzSGvXF5ByHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBznUt20QFzeQBPELcmN6+F=BOx09oSqVMzSGvXF5ByHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:08:13PM +0100, Vincent Guittot wrote:
> > > This patch allows a fixed degree of imbalance of two tasks to exist
> > > between NUMA domains regardless of utilisation levels. In many cases,
> > > this prevents communicating tasks being pulled apart. It was evaluated
> > > whether the imbalance should be scaled to the domain size. However, no
> > > additional benefit was measured across a range of workloads and machines
> > > and scaling adds the risk that lower domains have to be rebalanced. While
> > > this could change again in the future, such a change should specify the
> > > use case and benefit.
> > >
> >
> > Any thoughts on whether this is ok for tip or are there suggestions on
> > an alternative approach?
> 
> I have just finished to run some tests on my system with your patch
> and I haven't seen any noticeable any changes so far which was a bit
> expected. The tests that I usually run, use more than 4 tasks on my 2
> nodes system;

This is indeed expected. With more active tasks, normal load balancing
applies.

> the only exception is perf sched  pipe and the results
> for this test stays the same with and without your patch.

I never saw much difference with perf sched pipe either. It was
generally within the noise.

> I'm curious
> if this impacts Phil's tests which run LU.c benchmark with some
> burning cpu tasks

I didn't see any problem with LU.c whether parallelised by openMPI or
openMP but an independent check would be nice.

-- 
Mel Gorman
SUSE Labs
