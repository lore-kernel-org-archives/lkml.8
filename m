Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A622C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F302146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgCKDMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:12:13 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54304 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbgCKDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:12:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TsGH4Kz_1583896327;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TsGH4Kz_1583896327)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Mar 2020 11:12:08 +0800
Subject: Re: [PATCH] sched: avoid scale real weight down to zero
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <bb14528b-08c3-c4c0-5bcf-4bec1d75227a@linux.alibaba.com>
 <CAKfTPtAt43DOT2AnRLyO5tqxDGhaCqFKOc1Ws+WSt2NLtGQ9UQ@mail.gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <63631321-3e25-913e-a061-9ff65c98b76b@linux.alibaba.com>
Date:   Wed, 11 Mar 2020 11:12:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAt43DOT2AnRLyO5tqxDGhaCqFKOc1Ws+WSt2NLtGQ9UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/6 下午11:06, Vincent Guittot wrote:
[snip]
>>
>> Thus when scale_load_down() scale real weight down to 0, it's no
>> longer telling the real story, the caller will have the wrong
>> information and the calculation will be buggy.
>>
>> This patch add check in scale_load_down(), so the real weight will
>> be >= MIN_SHARES after scale, after applied the group C wins as
>> expected.
>>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks for the review :-)

Hi Peter, should we apply this one?

Regards,
Michael Wang


>> ---
>>  kernel/sched/sched.h | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 2a0caf394dd4..75c283f22256 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -118,7 +118,13 @@ extern long calc_load_fold_active(struct rq *this_rq, long adjust);
>>  #ifdef CONFIG_64BIT
>>  # define NICE_0_LOAD_SHIFT     (SCHED_FIXEDPOINT_SHIFT + SCHED_FIXEDPOINT_SHIFT)
>>  # define scale_load(w)         ((w) << SCHED_FIXEDPOINT_SHIFT)
>> -# define scale_load_down(w)    ((w) >> SCHED_FIXEDPOINT_SHIFT)
>> +# define scale_load_down(w) \
>> +({ \
>> +       unsigned long __w = (w); \
>> +       if (__w) \
>> +               __w = max(MIN_SHARES, __w >> SCHED_FIXEDPOINT_SHIFT); \
>> +       __w; \
>> +})
>>  #else
>>  # define NICE_0_LOAD_SHIFT     (SCHED_FIXEDPOINT_SHIFT)
>>  # define scale_load(w)         (w)
>> --
>> 2.14.4.44.g2045bb6
>>
