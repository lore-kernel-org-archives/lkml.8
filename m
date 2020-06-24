Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8543DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621D420B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbgFXM0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:26:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbgFXM0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:26:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E1B01F1;
        Wed, 24 Jun 2020 05:26:20 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE7B43F6CF;
        Wed, 24 Jun 2020 05:26:18 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:26:16 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] sched: Optionally skip uclamp logic in fast path
Message-ID: <20200624122616.jw7wqnvzfp3hw4lm@e107158-lin.cambridge.arm.com>
References: <20200619172011.5810-1-qais.yousef@arm.com>
 <6c1a6003-8f51-dadc-53e4-a2fa034dbe36@arm.com>
 <CAKfTPtDh+D9AdzcsjYuv8LmtWag2MaHx7Ysrxb7JQittKa_K0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDh+D9AdzcsjYuv8LmtWag2MaHx7Ysrxb7JQittKa_K0A@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/20 11:00, Vincent Guittot wrote:
> On Tue, 23 Jun 2020 at 19:40, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

[...]

> > (4)
> >
> > CPU0:  Function             Hit    Time            Avg             s^2
> >        --------             ---    ----            ---             ---
> >        deactivate_task  1998246    2428121 us      *1.215* us      0.062 us
> >        activate_task    1998252    2132141 us      *1.067* us      0.020 us
> >
> > CPU1:  Function             Hit    Time            Avg             s^2
> >        --------             ---    ----            ---             ---
> >        deactivate_task  1996154    2414194 us      1.209 us        0.060 us
> >        activate_task    1996148    2140667 us      1.072 us        0.021 us
> 
> I have rerun the tests that I ran previously on my octo core arm64 (hikey):
> 20 iteration of perf bench sched pipe -T -l 50000
> tip stands for tip/sched/core
> uclamp enabled means both uclamp task and uclamp cgroup
> the stdev is around 0.25% for all tests
> 
>                            root           level 1       level 2       level 3
> 
> tip uclamp disabled        50653          47188         44568         41925
> tip uclamp enabled         48800(-3.66%)  45600(-3.37%) 42822(-3.92%)
> 40257(-3.98%)
> /w patch uclamp disabled   50615(-0.08%)  47198(+0.02%) 44609(+0.09%)
> 41735(-0.45%)
> /w patch uclamp enabled    49661(-1.96%)  46611(-1.22%) 43803(-1.72%)
> 41243(-1.63%)
> 
> Results are better with your patch

Thanks both for testing!

Cheers

--
Qais Yousef
