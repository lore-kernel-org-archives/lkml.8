Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4CAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668DA24688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAVNzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:55:13 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:42736 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgAVNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:55:13 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 62638981C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:55:11 +0000 (GMT)
Received: (qmail 9722 invoked from network); 22 Jan 2020 13:55:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Jan 2020 13:55:11 -0000
Date:   Wed, 22 Jan 2020 13:55:09 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] sched/fair: Optimize select_idle_core
Message-ID: <20200122135509.GW3466@techsingularity.net>
References: <20191206172422.6578-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191206172422.6578-1-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 10:54:22PM +0530, Srikar Dronamraju wrote:
> Currently we loop through all threads of a core to evaluate if the core is
> idle or not. This is unnecessary. If a thread of a core is not idle, skip
> evaluating other threads of a core. Also while clearing the cpumask, bits
> of all CPUs of a core can be cleared in one-shot.
> 
> Collecting ticks on a Power 9 SMT 8 system around select_idle_core
> while running schbench shows us
> 
> (units are in ticks, hence lesser is better)
> Without patch
>     N        Min     Max     Median         Avg      Stddev
> x 130        151    1083        284   322.72308   144.41494
> 
> 
> With patch
>     N        Min     Max     Median         Avg      Stddev   Improvement
> x 164         88     610        201   225.79268   106.78943        30.03%
> 
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

I'm a bit surprised to not see this in linux-next or tip. Did this get
rejected or did it accidentally get overlooked because the subject is so
similar to 60588bfa223f ("sched/fair: Optimize select_idle_cpu") ?

-- 
Mel Gorman
SUSE Labs
