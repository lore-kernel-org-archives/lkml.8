Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B810BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2E62075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHYN6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:58:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHYN6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:58:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69977AFAE;
        Tue, 25 Aug 2020 13:59:14 +0000 (UTC)
Date:   Tue, 25 Aug 2020 14:58:41 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/numa: use runnable_avg to classify node
Message-ID: <20200825135841.GC3033@suse.de>
References: <20200825121818.30260-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200825121818.30260-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:18:18PM +0200, Vincent Guittot wrote:
> Use runnable_avg to classify numa node state similarly to what is done for
> normal load balancer. This helps to ensure that numa and normal balancers
> use the same view of the state of the system.
> 
> - large arm64system: 2 nodes / 224 CPUs
> hackbench -l (256000/#grp) -g #grp
> 
> grp    tip/sched/core         +patchset              improvement
> 1      14,008(+/- 4,99 %)     13,800(+/- 3.88 %)     1,48 %
> 4       4,340(+/- 5.35 %)      4.283(+/- 4.85 %)     1,33 %
> 16      3,357(+/- 0.55 %)      3.359(+/- 0.54 %)    -0,06 %
> 32      3,050(+/- 0.94 %)      3.039(+/- 1,06 %)     0,38 %
> 64      2.968(+/- 1,85 %)      3.006(+/- 2.92 %)    -1.27 %
> 128     3,290(+/-12.61 %)      3,108(+/- 5.97 %)     5.51 %
> 256     3.235(+/- 3.95 %)      3,188(+/- 2.83 %)     1.45 %
> 

Intuitively the patch makes sense but I'm not a fan of using hackbench
for evaluating NUMA balancing. The tasks are too short-lived and it's
not sensitive enough to data placement because of the small footprint
and because hackbench tends to saturate a machine.

As predicting NUMA balancing behaviour in your head can be difficult, I've
queued up a battery of tests on a few different NUMA machines and will see
what falls out. It'll take a few days as some of the tests are long-lived.

Baseline will be 5.9-rc2 as I haven't looked at the topology rework in
tip/sched/core and this patch should not be related to it.

-- 
Mel Gorman
SUSE Labs
