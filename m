Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8755BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D85B2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgEFK2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:28:38 -0400
Received: from foss.arm.com ([217.140.110.172]:33244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgEFK2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:28:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBCA530E;
        Wed,  6 May 2020 03:28:35 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B01B3F71F;
        Wed,  6 May 2020 03:28:34 -0700 (PDT)
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ> <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peng Liu <iwtbavbm@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
In-reply-to: <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
Date:   Wed, 06 May 2020 11:28:27 +0100
Message-ID: <jhjh7wt1ho4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/05/20 16:17, Vincent Guittot wrote:
>> Since we can gather all the updated rq->next_balance, including this_cpu,
>> in _nohz_idle_balance(), it's safe to remove the extra lines in
>> rebalance_domains() which are originally intended for this_cpu. And
>> finally the updating only happen in _nohz_idle_balance().
>
> I'm not sure that's always true. Nothing prevents nohz_idle_balance()
> to return false . Then run_rebalance_domains() calls
> rebalance_domains(this_rq ,SCHED_IDLE) outside _nohz_idle_balance().
> In this case we must keep the code in rebalance_domains().
>
> For example when the tick is not stopped when entering idle. Or when
> need_resched() returns true.
>

Going back to this; nohz_idle_balance() will return true regardless of the
return value of _nohz_idle_balance(), so AFAICT we won't fall through to
the rebalance_domains() in run_rebalance_domains() in case we had
need_resched() in _nohz_idle_balance().

This was changed in b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK");
before then we would always have the local rebalance_domains(). Now, since
the bail out is caused by need_resched(), I think it's not such a crazy
thing *not* to do the local rebalance_domains(), but I wasn't super clear
on all of this.
