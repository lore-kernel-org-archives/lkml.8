Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A0DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D40F2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgAPQff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:35:35 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:36214 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgAPQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:35:35 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 72E321C38FE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 16:35:32 +0000 (GMT)
Received: (qmail 32691 invoked from network); 16 Jan 2020 16:35:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jan 2020 16:35:32 -0000
Date:   Thu, 16 Jan 2020 16:35:29 +0000
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
Message-ID: <20200116163529.GP3466@techsingularity.net>
References: <20200114101319.GO3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200114101319.GO3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:13:20AM +0000, Mel Gorman wrote:
> Changelog since V3
> o Allow a fixed imbalance a basic comparison with 2 tasks. This turned out to
>   be as good or better than allowing an imbalance based on the group weight
>   without worrying about potential spillover of the lower scheduler domains.
> 
> Changelog since V2
> o Only allow a small imbalance when utilisation is low to address reports that
>   higher utilisation workloads were hitting corner cases.
> 
> Changelog since V1
> o Alter code flow 						vincent.guittot
> o Use idle CPUs for comparison instead of sum_nr_running	vincent.guittot
> o Note that the division is still in place. Without it and taking
>   imbalance_adj into account before the cutoff, two NUMA domains
>   do not converage as being equally balanced when the number of
>   busy tasks equals the size of one domain (50% of the sum).
> 
> The CPU load balancer balances between different domains to spread load
> and strives to have equal balance everywhere. Communicating tasks can
> migrate so they are topologically close to each other but these decisions
> are independent. On a lightly loaded NUMA machine, two communicating tasks
> pulled together at wakeup time can be pushed apart by the load balancer.
> In isolation, the load balancer decision is fine but it ignores the tasks
> data locality and the wakeup/LB paths continually conflict. NUMA balancing
> is also a factor but it also simply conflicts with the load balancer.
> 
> This patch allows a fixed degree of imbalance of two tasks to exist
> between NUMA domains regardless of utilisation levels. In many cases,
> this prevents communicating tasks being pulled apart. It was evaluated
> whether the imbalance should be scaled to the domain size. However, no
> additional benefit was measured across a range of workloads and machines
> and scaling adds the risk that lower domains have to be rebalanced. While
> this could change again in the future, such a change should specify the
> use case and benefit.
> 

Any thoughts on whether this is ok for tip or are there suggestions on
an alternative approach?

-- 
Mel Gorman
SUSE Labs
