Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA81FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13C1206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgFWRkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:40:16 -0400
Received: from foss.arm.com ([217.140.110.172]:41562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387757AbgFWRkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:40:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3B6A31B;
        Tue, 23 Jun 2020 10:40:09 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2763F73C;
        Tue, 23 Jun 2020 10:40:07 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] sched: Optionally skip uclamp logic in fast path
To:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
References: <20200619172011.5810-1-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6c1a6003-8f51-dadc-53e4-a2fa034dbe36@arm.com>
Date:   Tue, 23 Jun 2020 19:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619172011.5810-1-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2020 19:20, Qais Yousef wrote> This series attempts to address the report that uclamp logic could be expensive
> sometimes and shows a regression in netperf UDP_STREAM under certain
> conditions.
> 
> The first patch is a fix for how struct uclamp_rq is initialized which is
> required by the 2nd patch which contains the real 'fix'.
> 
> Worth noting that the root cause of the overhead is believed to be system
> specific or related to potential certain code/data layout issues, leading to
> worse I/D $ performance.
> 
> Different systems exhibited different behaviors and the regression did
> disappear in certain kernel version while attempting to reporoduce.
> 
> More info can be found here:
> 
> https://lore.kernel.org/lkml/20200616110824.dgkkbyapn3io6wik@e107158-lin/
> 
> Having the static key seemed the best thing to do to ensure the effect of
> uclamp is minimized for kernels that compile it in but don't have a userspace
> that uses it, which will allow distros to distribute uclamp capable kernels by
> default without having to compromise on performance for some systems that could
> be affected.

My test data indicates that the static key w/o any uclamp users (3)
brings the performance number for the 'perf bench sched pipe'
workload back (i.e. from w/ !CONFIG_UCLAMP_TASK) (1).

platform:

    Arm64 Hikey960 (only little CPUs [0-3]), no CPUidle,
    performance CPUfreq governor

workload:

    perf stat -n -r 20 -- perf bench sched pipe -T -l 100000


(A) *** Performance results ***

(1) tip/sched/core
    # CONFIG_UCLAMP_TASK is not set

    *1.39285* +- 0.00191 seconds time elapsed  ( +-  0.14% )

(2) tip/sched/core
    CONFIG_UCLAMP_TASK=y

    *1.42877* +- 0.00181 seconds time elapsed  ( +-  0.13% )

(3) tip/sched/core + opt_skip_uclamp_v2
    CONFIG_UCLAMP_TASK=y

    *1.38833* +- 0.00291 seconds time elapsed  ( +-  0.21% )

(4) tip/sched/core + opt_skip_uclamp_v2
    CONFIG_UCLAMP_TASK=y
    echo 512 > /proc/sys/kernel/sched_util_clamp_min (enable uclamp)

    *1.42062* +- 0.00238 seconds time elapsed  ( +-  0.17% )


(B) *** Profiling on CPU0 and CPU1  ***

    (further hp'ing out CPU2 and CPU3 to get consistent hit numbers)

(1)

CPU0:  Function             Hit    Time            Avg             s^2
       --------             ---    ----            ---             ---
       deactivate_task  1997346    2207642 us      *1.105* us      0.033 us
       activate_task    1997391    1840057 us      *0.921* us      0.054 us

CPU1:  Function             Hit    Time            Avg             s^2
       --------             ---    ----            ---             ---
       deactivate_task  1997455    2225960 us      1.114 us        0.034 us
       activate_task    1997410    1842603 us      0.922 us        0.052 us

(2)

CPU0:  Function             Hit    Time            Avg             s^2
       --------             ---    ----            ---             ---
       deactivate_task  1998538    2419719 us      *1.210* us      0.061 us
       activate_task    1997119    1960401 us      *0.981* us      0.034 us

CPU1:  Function             Hit    Time            Avg             s^2
       --------             ---    ----            ---             ---
       deactivate_task  1996597    2400760 us      1.202 us        0.059 us
       activate_task    1998016    1985013 us      0.993 us        0.028 us

(3)

CPU0:  Function             Hit    Time            Avg             s^2
       --------             ---    ----            ---             ---
       deactivate_task  1997525    2155416 us      *1.079* us      0.020 us
       activate_task    1997874    1899002 us      *0.950* us      0.044 us

CPU1:  Function             Hit    Time            Avg             s^2
       --------             ---    ----            ---             ---
       deactivate_task  1997935    2118648 us      1.060 us        0.017 us
       activate_task    1997586    1895162 us      0.948 us        0.044 us

(4)

CPU0:  Function             Hit    Time            Avg             s^2
       --------             ---    ----            ---             ---
       deactivate_task  1998246    2428121 us      *1.215* us      0.062 us
       activate_task    1998252    2132141 us      *1.067* us      0.020 us

CPU1:  Function             Hit    Time            Avg             s^2
       --------             ---    ----            ---             ---
       deactivate_task  1996154    2414194 us      1.209 us        0.060 us
       activate_task    1996148    2140667 us      1.072 us        0.021 us
