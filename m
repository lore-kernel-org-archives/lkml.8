Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D45C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B3A207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgBRKx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:53:59 -0500
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:58063 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgBRKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:53:59 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 0846AFA7A3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:53:57 +0000 (GMT)
Received: (qmail 11687 invoked from network); 18 Feb 2020 10:53:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Feb 2020 10:53:56 -0000
Date:   Tue, 18 Feb 2020 10:53:55 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] sched/numa: Use similar logic to the load balancer
 for moving between domains with spare capacity
Message-ID: <20200218105355.GN3466@techsingularity.net>
References: <20200217104402.11643-1-mgorman@techsingularity.net>
 <20200217132019.6684-1-hdanton@sina.com>
 <20200218033244.6860-1-hdanton@sina.com>
 <20200218095915.844-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200218095915.844-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:59:15PM +0800, Hillf Danton wrote:
> > Given that adjust_numa_imbalance takes the imbalance as the first
> > parameter, not a boolean and it's not unconditionally true, I don't
> > get what you mean.
> 
> My bad.
> 
> > Can you propose a patch on top of the entire series
> > explaining what you suggest please?
> 
> I just want to avoid splitting the pair of tasks on the src node as
> described by the comment in adjust_numa_imbalance() across two nodes
> despite idle cpus that are available on the dst node.
> 

Ah ok, so yes, this is something that needs to be done but it should be
a separate patch after this series is complete. It's very easy to get it
wrong and introduce regressions so I want to get the NUMA balancer and
load balancer reconciled first.

> If there are more than 2 tasks running on src node then try to migrate
> task to dst node in order to decrease imbalance.
> 

That should be happening already because 

	imbalance = max(0, dst_running - src_running);

I didn't take the absolute difference and excess tasks on the src should
still be able to migrate

-- 
Mel Gorman
SUSE Labs
