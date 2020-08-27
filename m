Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37866C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1190922B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgH0Pfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:35:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgH0Pfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:35:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9666AB1F3;
        Thu, 27 Aug 2020 15:36:08 +0000 (UTC)
Date:   Thu, 27 Aug 2020 16:35:34 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/numa: use runnable_avg to classify node
Message-ID: <20200827153534.GF3033@suse.de>
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
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

The testing was a mixed bag of wins and losses but wins more than it
loses. Biggest loss was a 9.04% regression on nas-SP using openmp for
parallelisation on Zen1. Biggest win was around 8% gain running
specjbb2005 on Zen2 (with some major gains of up to 55% for some thread
counts). Most workloads were stable across multiple Intel and AMD
machines.

There were some oddities in changes in NUMA scanning rate but that is
likely a side-effect because the locality over time for the same loads
did not look obviously worse. There was no negative result I could point
at that was not offset by a positive result elsewhere. Given it's not
a univeral win or loss, matching numa and lb balancing as closely as
possible is best so

Reviewed-by: Mel Gorman <mgorman@suse.de>

Thanks.

-- 
Mel Gorman
SUSE Labs
