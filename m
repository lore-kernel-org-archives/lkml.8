Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDDBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4B42084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgCEBIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:08:24 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43688 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgCEBIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:08:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Trh.EBT_1583370490;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Trh.EBT_1583370490)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Mar 2020 09:08:21 +0800
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net>
 <241603dd-1149-58aa-85cf-43f3da2de43f@linux.alibaba.com>
 <CAKfTPtB=+sMXYXEeb2WppUracxLNXQPJj0H7d-MqEmgrB3gTDw@mail.gmail.com>
 <20200304095209.GK2596@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <0489ca96-29a3-921e-ca29-00108929a041@linux.alibaba.com>
Date:   Thu, 5 Mar 2020 09:08:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200304095209.GK2596@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/4 下午5:52, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 09:47:34AM +0100, Vincent Guittot wrote:
>> you will add +1 of nice prio for each device
>>
>> should we use instead
>> # define scale_load_down(w) ((w >> SCHED_FIXEDPOINT_SHIFT) ? (w >>
>> SCHED_FIXEDPOINT_SHIFT) : MIN_SHARES)
> 
> That's '((w >> SHIFT) ?: MIN_SHARES)', but even that is not quite right.
> 
> I think we want something like:
> 
> #define scale_load_down(w) \
> ({ unsigned long ___w = (w); \
>    if (___w) \
>      ____w = max(MIN_SHARES, ___w >> SHIFT); \
>    ___w; })
> 
> That is, we very much want to retain 0 I'm thinking.

Should works, I'll give this one a test and send another fix :-)

Regards,
Michael Wang

> 
