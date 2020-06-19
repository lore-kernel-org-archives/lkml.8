Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199AAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11A920776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbgFSMzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:55:47 -0400
Received: from foss.arm.com ([217.140.110.172]:56960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgFSMzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:55:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF6F2B;
        Fri, 19 Jun 2020 05:55:46 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2013F6CF;
        Fri, 19 Jun 2020 05:55:44 -0700 (PDT)
Date:   Fri, 19 Jun 2020 13:55:42 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200619125541.taqbvttb3s7ktso6@e107158-lin.cambridge.arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-3-qais.yousef@arm.com>
 <jhjwo43cpfl.mognet@arm.com>
 <20200619115723.GF3129@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619115723.GF3129@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 12:57, Mel Gorman wrote:
> On Fri, Jun 19, 2020 at 11:36:46AM +0100, Valentin Schneider wrote:
> > >                                    nouclamp                 uclamp      uclamp-static-key
> > > Hmean     send-64         162.43 (   0.00%)      157.84 *  -2.82%*      163.39 *   0.59%*
> > > Hmean     send-128        324.71 (   0.00%)      314.78 *  -3.06%*      326.18 *   0.45%*
> > > Hmean     send-256        641.55 (   0.00%)      628.67 *  -2.01%*      648.12 *   1.02%*
> > > Hmean     send-1024      2525.28 (   0.00%)     2448.26 *  -3.05%*     2543.73 *   0.73%*
> > > Hmean     send-2048      4836.14 (   0.00%)     4712.08 *  -2.57%*     4867.69 *   0.65%*
> > > Hmean     send-3312      7540.83 (   0.00%)     7425.45 *  -1.53%*     7621.06 *   1.06%*
> > > Hmean     send-4096      9124.53 (   0.00%)     8948.82 *  -1.93%*     9276.25 *   1.66%*
> > > Hmean     send-8192     15589.67 (   0.00%)    15486.35 *  -0.66%*    15819.98 *   1.48%*
> > > Hmean     send-16384    26386.47 (   0.00%)    25752.25 *  -2.40%*    26773.74 *   1.47%*
> > >
> > 
> > Am I reading this correctly in that compiling in uclamp but having the
> > static key enabled gives a slight improvement compared to not compiling in
> > uclamp? I suppose the important bit is that we're not seeing regressions
> > anymore, but still.
> > 
> 
> I haven't reviewed the series in depth because from your review, another
> version is likely in the works. However, it is not that unusual to
> see small fluctuations like this that are counter-intuitive. The report
> indicates the difference is likely outside of the noise with * around the
> percentage difference instead of () but it could be small boot-to-boot
> variance, differences in code layout, slight differences in slab usage
> patterns etc. The definitive evidence that uclamp overhead is no there
> is whether the uclamp functions show up in annotated profiles or not.

I certainly have seen weird variations in the numbers. If you've seen my
numbers in the links below, I was buffled when I moved to 5.7-rc2 and couldn't
reproduce again.

https://lore.kernel.org/lkml/20200616110824.dgkkbyapn3io6wik@e107158-lin/

I think the hot path can be sensitive to code/data layout variations and now
uclamp added more variables to be accesses, this sensitivity could be
manifested in more ways, me thinks.

I am re-running the test now with perf record. But not sure if I'll be able to
provide the numbers by the end of the day. If it is easy for you to pick this
up, I'd appreciate if you can kick off a test.

But it's Friday after all.. :-)

Thanks

--
Qais Yousef
