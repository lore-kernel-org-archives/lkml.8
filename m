Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9539CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790392063A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgEDPsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:48:14 -0400
Received: from foss.arm.com ([217.140.110.172]:47696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgEDPsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:48:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E5CB1FB;
        Mon,  4 May 2020 08:48:13 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1856A3F68F;
        Mon,  4 May 2020 08:48:11 -0700 (PDT)
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
Date:   Mon, 04 May 2020 16:48:06 +0100
Message-ID: <jhjtv0vd7m1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/05/20 16:17, Vincent Guittot wrote:
> On Sun, 3 May 2020 at 10:34, Peng Liu <iwtbavbm@gmail.com> wrote:
>>
>> commit c5afb6a87f23 ("sched/fair: Fix nohz.next_balance update")
>> During idle load balance, this_cpu(ilb) do load balance for the other
>> idle CPUs, also gather the earliest (nohz.)next_balance.
>>
>> Since commit:
>>   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
>>
>> We update nohz.next_balance like this:
>>
>>   _nohz_idle_balance() {
>>       for_each_cpu(nohz.idle_cpus_mask) {
>>           rebalance_domains() {
>>               update nohz.next_balance <-- compare and update
>>           }
>>       }
>>       rebalance_domains(this_cpu) {
>>           update nohz.next_balance <-- compare and update
>>       }
>>       update nohz.next_balance <-- unconditionally update
>>   }
>>
>> For instance, nohz.idle_cpus_mask spans {cpu2,3,5,8}, and this_cpu is
>> cpu5. After the above loop we could gather the earliest *next_balance*
>> among {cpu2,3,8}, then rebalance_domains(this_cpu) update
>> nohz.next_balance with this_rq->next_balance, but finally overwrite
>> nohz.next_balance with the earliest *next_balance* among {cpu2,3,8},
>> we may end up with not getting the earliest next_balance.
>>
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

I had missed that, good points.

> So instead of removing the code from rebalance_domains, you should
> move the one in _nohz_idle_balance() to make sure that the "if
> (likely(update_next_balance)) ..." is called before calling
> rebalance_domains for the local cpu
>

Why not just get rid of the update in _nohz_idle_balance() entirely then?
The nohz.next_balance update in rebalance_domains() will always happen if
it is required (and we have idle == CPU_IDLE), so the extra update in
_nohz_idle_balance() doesn't seem to be any useful.
