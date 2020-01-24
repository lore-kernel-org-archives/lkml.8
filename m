Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95165C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C9F2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbgAXLBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:01:50 -0500
Received: from foss.arm.com ([217.140.110.172]:49168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387786AbgAXLBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:01:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 303D3328;
        Fri, 24 Jan 2020 03:01:48 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D9983F68E;
        Fri, 24 Jan 2020 03:01:46 -0800 (PST)
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
To:     Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Wei Wang <wvw@google.com>, wei.vince.wang@gmail.com,
        dietmar.eggemann@arm.com, chris.redpath@arm.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20200124002811.228334-1-wvw@google.com>
 <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
 <20200124095125.GA121494@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
Date:   Fri, 24 Jan 2020 11:01:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124095125.GA121494@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2020 09:51, Quentin Perret wrote:
>>> +static inline bool iowait_boosted(struct task_struct *p)
>>> +{
>>> +	return p->in_iowait && uclamp_eff_value(p, UCLAMP_MIN) > 0;
>>
>> I think this is overloading the usage of util clamp. You're basically using
>> cpu.uclamp.min to temporarily switch iowait boost on/off.
>>
>> Isn't it better to add a new cgroup attribute to toggle this feature?
>>
>> The problem does seem generic enough and could benefit other battery-powered
>> devices outside of the Android world. I don't think the dependency on uclamp &&
>> energy model are necessary to solve this.
> 
> I think using uclamp is not a bad idea here, but perhaps we could do
> things differently. As of today the iowait boost escapes the clamping
> mechanism, so one option would be to change that. That would let us set
> a low max clamp in the 'background' cgroup, which in turns would limit
> the frequency request for those tasks even if they're IO-intensive.
> 

So I'm pretty sure we *do* want tasks with the default clamps to get iowait
boost'd. What we don't want are background tasks driving up the frequency,
and that should be via uclamp.max (as Quentin is suggesting) rather than
uclamp.min (as is suggested in the patch).

Now, whether that is overloading the usage of uclamp... I'm not sure.
One of the argument for uclamp was actually frequency selection, so if
we just make iowait boost respect that, IOW not boost further than
uclamp.max (which is a bit better than a simple on/off switch), that
wouldn't be too crazy I think.

> That'll have to be done at the RQ level, but figuring out what's the
> current max clamp on the rq should be doable from sugov I think.
> 
> Wei: would that work for your use case ?
> 
> Also, the iowait boost really should be per-task and not per-cpu, so it
> can be taken into account during wake-up balance on big.LITTLE. That
> might also help on SMP if a task doing a lot of IO migrates, as the
> boost would migrate with it. But that's perhaps for later ...
> 
> Thanks,
> Quentin
> 
