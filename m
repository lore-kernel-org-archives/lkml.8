Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CA0C34053
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D9D2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBSOCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:02:24 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:39152 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727756AbgBSOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:02:21 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 508D31C1B30
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:02:19 +0000 (GMT)
Received: (qmail 3146 invoked from network); 19 Feb 2020 14:02:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Feb 2020 14:02:19 -0000
Date:   Wed, 19 Feb 2020 14:02:17 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
Message-ID: <20200219140216.GP3466@techsingularity.net>
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200219125513.8953-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:55:13PM +0100, Vincent Guittot wrote:
> Now that runnable_load_avg has been removed, we can replace it by a new
> signal that will highlight the runnable pressure on a cfs_rq. This signal
> track the waiting time of tasks on rq and can help to better define the
> state of rqs.
> 
> At now, only util_avg is used to define the state of a rq:
>   A rq with more that around 80% of utilization and more than 1 tasks is
>   considered as overloaded.
> 
> But the util_avg signal of a rq can become temporaly low after that a task
> migrated onto another rq which can bias the classification of the rq.
> 
> When tasks compete for the same rq, their runnable average signal will be
> higher than util_avg as it will include the waiting time and we can use
> this signal to better classify cfs_rqs.
> 
> The new runnable_avg will track the runnable time of a task which simply
> adds the waiting time to the running time. The runnable _avg of cfs_rq
> will be the /Sum of se's runnable_avg and the runnable_avg of group entity
> will follow the one of the rq similarly to util_avg.
> 
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks.

Picked up and included in "Reconcile NUMA balancing decisions with the
load balancer v4". The only change I made to your patches was move the
reintroduction of cpu_runnable to the patch that requires it to avoid a
build warning.

-- 
Mel Gorman
SUSE Labs
