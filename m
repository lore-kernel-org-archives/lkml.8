Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92CAC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C8E24688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgB0PPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:15:41 -0500
Received: from foss.arm.com ([217.140.110.172]:53446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbgB0PPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:15:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92B3D31B;
        Thu, 27 Feb 2020 07:15:40 -0800 (PST)
Received: from [10.0.8.126] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83AD83F7B4;
        Thu, 27 Feb 2020 07:15:38 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tao Zhou <zhout@vivaldi.net>
Cc:     Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
 <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com>
 <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
 <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com>
 <20200227131228.GA5872@geo.homenetwork>
 <CAKfTPtBXYTORWdx9fGOBgEMYk6noa7X-4RSdSM+gKgv47nmjXw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <fe35049b-eef0-580f-aac6-b525a5e7f2a5@arm.com>
Date:   Thu, 27 Feb 2020 15:15:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBXYTORWdx9fGOBgEMYk6noa7X-4RSdSM+gKgv47nmjXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.20 13:12, Vincent Guittot wrote:
> On Thu, 27 Feb 2020 at 14:10, Tao Zhou <zhout@vivaldi.net> wrote:
>>
>> Hi Dietmar,
>>
>> On Thu, Feb 27, 2020 at 11:20:05AM +0000, Dietmar Eggemann wrote:
>>> On 26.02.20 21:01, Vincent Guittot wrote:
>>>> On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
>>>>>
>>>>> Vincent Guittot <vincent.guittot@linaro.org> writes:
>>>>>
>>>>>> When a cfs_rq is throttled, its group entity is dequeued and its running
>>>>>> tasks are removed. We must update runnable_avg with current h_nr_running
>>>>>> and update group_se->runnable_weight with new h_nr_running at each level
>>>
>>>                                               ^^^
>>>
>>> Shouldn't his be 'curren' rather 'new' h_nr_running for
>>> group_se->runnable_weight? IMHO, you want to cache the current value
>>> before you add/subtract task_delta.
>>
>> /me think Vincent is right. h_nr_running is updated in the previous
>> level or out. The next level will use current h_nr_running to update
>> runnable_avg and use the new group cfs_rq's h_nr_running which was
>> updated in the previous level or out to update se runnable_weight.

Ah OK, 'old' as in 'old' cached value se->runnable_weight and 'new' as
the 'new' se->runnable_weight which gets updated *after* update_load_avg
and before +/- task_delta.


So when we throttle e.g. /tg1/tg11

previous level is: /tg1/tg11

next level:        /tg1


loop for /tg1:

for_each_sched_entity(se)
  cfs_rq = cfs_rq_of(se);

  update_load_avg(cfs_rq, se ...) <-- uses 'old' se->runnable_weight

  se->runnable_weight = se->my_q->h_nr_running <-- 'new' value
                                                   (updated in previous
                                                    level, group cfs_rq)

[...]
