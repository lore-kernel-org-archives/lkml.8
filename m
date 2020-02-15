Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64965C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 21:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4017E2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 21:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBOV6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:35378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgBOV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 16:58:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EA4CFADD7;
        Sat, 15 Feb 2020 21:58:28 +0000 (UTC)
Date:   Sat, 15 Feb 2020 21:58:24 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com
Subject: Re: [PATCH v2 0/5] remove runnable_load_avg and improve
 group_classify
Message-ID: <20200215215823.GY3420@suse.de>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200214152729.6059-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:27:24PM +0100, Vincent Guittot wrote:
> This new version stays quite close to the previous one and should 
> replace without problems the previous one that part of Mel's patchset:
> https://lkml.org/lkml/2020/2/14/156
> 

As far as I can see, the differences are harmless and look sane. I do think
that an additional fix is mandatory as I see no reason why the regression
was fixed. As such, I'll release a v3 of the series that includes your
new patches with the minimal fix inserted where appropriate. I'll have
tests running over the rest of the weekend.

> Some hackbench results:
> 
> - small arm64 dual quad cores system
> hackbench -l (2560/#grp) -g #grp
> 
> grp    tip/sched/core         +patchset              improvement
> 1       1,327(+/-10,06 %)     1,247(+/-5,45 %)       5,97 %
> 4       1,250(+/- 2,55 %)     1,207(+/-2,12 %)       3,42 %
> 8       1,189(+/- 1,47 %)     1,179(+/-1,93 %)       0,90 %
> 16      1,221(+/- 3,25 %)     1,219(+/-2,44 %)       0,16 %						
> 
> - large arm64 2 nodes / 224 cores system
> hackbench -l (256000/#grp) -g #grp
> 
> grp    tip/sched/core         +patchset              improvement
> 1      14,197(+/- 2,73 %)     13,917(+/- 2,19 %)     1,98 %
> 4       6,817(+/- 1,27 %)      6,523(+/-11,96 %)     4,31 %
> 16      2,930(+/- 1,07 %)      2,911(+/- 1,08 %)     0,66 %
> 32      2,735(+/- 1,71 %)      2,725(+/- 1,53 %)     0,37 %
> 64      2,702(+/- 0,32 %)      2,717(+/- 1,07 %)    -0,53 %
> 128     3,533(+/-14,66 %)     3,123(+/-12,47 %)     11,59 %
> 256     3,918(+/-19,93 %)     3,390(+/- 5,93 %)     13,47 %
> 
> The significant improvement for 128 and 256 should be taken with care
> because of some instabilities over iterations without the patchset.
> 

For the most part I do not see similar results to this with hackbench with
one exception -- EPYC first generation. I don't have results for EPYC 2
yet but I'm curious if the machine you have has multiple L3 caches per
NUMA domain? Various Intel CPU generations show improvements but they're
not as dramatic.  Tests will tell me for sure but I have some confidence
that it'll look like

Small tracing patches -- no difference
Vincent Patches 1-2   -- regressions
Fix from Mel          -- small overall improvement on baseline
Vincent patches 3-5   -- small improvements mostly, sometimes big ones
                         on hackbench depending on the machine
Rest of Mel series    -- generally ok across machines and CPU generations

Even if the improvements are not dramatic, I think it'll be worth it to
have NUMA and CPU balancer using similarly sane logic and overall I find
the load balancer easier to understand with the new logic so yey!

-- 
Mel Gorman
SUSE Labs
