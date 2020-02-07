Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43AFC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D60021775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:41:50 -0500
Received: from foss.arm.com ([217.140.110.172]:39896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgBGMlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:41:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEBF8328;
        Fri,  7 Feb 2020 04:41:49 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1C643F68E;
        Fri,  7 Feb 2020 04:41:48 -0800 (PST)
Subject: Re: [PATCH v4 0/4] sched/fair: Capacity aware wakeup rework
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org, pkondeti@codeaurora.org
References: <20200206191957.12325-1-valentin.schneider@arm.com>
 <20200207104244.GA228234@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ac20beb4-6f21-3138-2e8d-e9bfdd7110ed@arm.com>
Date:   Fri, 7 Feb 2020 12:41:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207104244.GA228234@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 10:42, Quentin Perret wrote:
>> Phantom domains (MC + DIE)
>> --------------------------
>>
>> This is mostly included for the sake of completeness.
>>
>> 100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':
>>
>> |      |      -PATCH |      +PATCH | DELTA (%) |
>> |------+-------------+-------------+-----------|
>> | mean | 7317.940000 | 9328.470000 |   +27.474 |
>> | std  |  460.372682 |  181.528886 |   -60.569 |
>> | min  | 5888.000000 | 8832.000000 |   +50.000 |
>> | 50%  | 7271.000000 | 9348.000000 |   +28.566 |
>> | 75%  | 7497.500000 | 9477.250000 |   +26.405 |
>> | 99%  | 8464.390000 | 9634.160000 |   +13.820 |
>> | max  | 8602.000000 | 9650.000000 |   +12.183 |
> 
> 
> So, it feels like the most interesting test would be
> 
>  'baseline w/ phantom domains' vs 'this patch w/o phantom domains'
> 
> right ? The 'baseline w/o phantom domains' case is arguably borked today,
> so it isn't that interesting (even though it performs well for the
> particular workload you choose here, as expected, but I guess you might
> see issues in others).
> 
> So, IIUC, based on your results above, that would be:
> 
> |      |     base+PD |  patch+noPD | DELTA (%) |
> |------+-------------+-------------+-----------|
> | mean | 7317.940000 | 8731.610000 |   +19.318 |
> | std  |  460.372682 |  206.826912 |   -55.074 |
> | min  | 5888.000000 | 8251.000000 |   +40.132 |
> | 50%  | 7271.000000 | 8705.000000 |   +19.722 |
> | 75%  | 7497.500000 | 8868.250000 |   +18.283 |
> | 99%  | 8464.390000 | 9155.520000 |    +8.165 |
> | max  | 8602.000000 | 9207.000000 |    +7.033 |
> 
> Is that correct ?
> 

That does look like it!

> If so, this patch series is still a very big win, and I'm all for
> getting it merged. But I find it interesting that the results aren't as
> good as having this patch _and_ phantom domains at the same time ...
> 
> Any idea why having phantom domains helps ? select_idle_capacity()
> should behave the same w/ or w/o phantom domains given that you use
> sd_asym_cpucapacity directly.

My thoughts as well.

> I'm guessing something else has an impact
> here ? LB / misfit behaving a bit differently perhaps ?
> 

Mm so phantom domains further restrict which CPUs can pull during LB (see
should_we_balance()). On a "flat" topology with just an MC domain, any
CPU is free to pull from any other CPU at any time. With phantom domains,
LB isn't restricted at MC (i.e. within a group of equal capacities), but
is at DIE, so we'll bail out more often there.

So even though we go through load balance more often with phantom domains
(here it would be every 4 jiffies for MC, 8 for DIE), we may end up bailing
out more often that without phantom domains. Then again, there barely is
more than one task per CPU in the sysbench case, so we don't have a very
expensive task scan.

Also, I don't think it plays a role here, but phantom domains are more
conservative in terms of up/downmigration.
Since you balance first at MC level, if you have an imbalance you will try
to solve it within CPUs of same capacity value. Without phantom domains,
you just have a single domain that spans everything, so you could move a
small task to a big CPU, despite there being spare LITTLEs.

Investing this some more is dangling somewhere on my todo-list.

> Thanks,
> Quentin
> 
