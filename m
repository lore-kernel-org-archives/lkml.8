Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8AAC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BA72072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCTPW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:22:56 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:58855 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbgCTPWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:22:55 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id AE32BF804D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 15:22:53 +0000 (GMT)
Received: (qmail 16808 invoked from network); 20 Mar 2020 15:22:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Mar 2020 15:22:53 -0000
Date:   Fri, 20 Mar 2020 15:22:51 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200320152251.GC3818@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb>
 <20200309203625.GU3818@techsingularity.net>
 <20200312095432.GW3818@techsingularity.net>
 <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net>
 <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net>
 <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 03:37:44PM +0100, Jirka Hladky wrote:
> Hi Mel,
> 
> just a quick update. I have increased the testing coverage and other tests
> from the NAS shows a big performance drop for the low number of threads as
> well:
> 
> sp_C_x - show still the biggest drop upto 50%
> bt_C_x - performance drop upto 40%
> ua_C_x - performance drop upto 30%
> 

MPI or OMP and what is a low thread count? For MPI at least, I saw a 0.4%
gain on an 4-node machine for bt_C and a 3.88% regression on 8-nodes. I
think it must be OMP you are using because I found I had to disable UA
for MPI at some point in the past for reasons I no longer remember.

> My point is that the performance drop for the low number of threads is more
> common than we have initially thought.
> 
> Let me know what you need more data.
> 

I just a clarification on the thread count and a confirmation it's OMP. For
MPI, I did note that some of the other NAS kernels shows a slight dip but
it was nowhere near as severe as SP and the problem was the same as more --
two or more tasks stayed on the same node without spreading out because
there was no pressure to do so. There was enough CPU and memory capacity
with no obvious pattern that could be used to spread the load wide early.

One possibility would be to spread wide always at clone time and assume
wake_affine will pull related tasks but it's fragile because it breaks
if the cloned task execs and then allocates memory from a remote node
only to migrate to a local node immediately.

-- 
Mel Gorman
SUSE Labs
