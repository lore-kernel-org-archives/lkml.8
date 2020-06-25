Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF7EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751F120706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404057AbgFYKmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:42:33 -0400
Received: from mail.itouring.de ([188.40.134.68]:35408 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404000AbgFYKmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:42:32 -0400
Received: from tux.applied-asynchrony.com (p5ddd79e0.dip0.t-ipconnect.de [93.221.121.224])
        by mail.itouring.de (Postfix) with ESMTPSA id AF248416080F;
        Thu, 25 Jun 2020 12:42:29 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 615B1F01605;
        Thu, 25 Jun 2020 12:42:29 +0200 (CEST)
Subject: Re: [PATCH] sched/cfs: change initial value of runnable_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>
References: <20200624154422.29166-1-vincent.guittot@linaro.org>
 <7f2b3135-328b-a510-ce23-49e3f5c20965@applied-asynchrony.com>
 <CAKfTPtD4+gUkz7Z2o9yyuK09M0bmP=Y+pZTYswNt=yVC4WVkyQ@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <c4574b9e-852d-8f04-91cb-0fbae9f89833@applied-asynchrony.com>
Date:   Thu, 25 Jun 2020 12:42:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD4+gUkz7Z2o9yyuK09M0bmP=Y+pZTYswNt=yVC4WVkyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 11:56, Vincent Guittot wrote:
> On Thu, 25 Jun 2020 at 11:24, Holger Hoffstätte
> <holger@applied-asynchrony.com> wrote:
>>
>> On 2020-06-24 17:44, Vincent Guittot wrote:
>>> Some performance regression on reaim benchmark have been raised with
>>>     commit 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
>>>
>>> The problem comes from the init value of runnable_avg which is initialized
>>> with max value. This can be a problem if the newly forked task is finally
>>> a short task because the group of CPUs is wrongly set to overloaded and
>>> tasks are pulled less agressively.
>>>
>>> Set initial value of runnable_avg equals to util_avg to reflect that there
>>> is no waiting time so far.
>>>
>>> Fixes: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>    kernel/sched/fair.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 0424a0af5f87..45e467bf42fc 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>>>                }
>>>        }
>>>
>>> -     sa->runnable_avg = cpu_scale;
>>> +     sa->runnable_avg = sa->util_avg;
>>>
>>>        if (p->sched_class != &fair_sched_class) {
>>>                /*
>>>
>>
>> Something is wrong here. I woke up my machine from suspend-to-RAM this morning
>> and saw that a completely idle machine had a loadavg of ~7. According to my
> 
> Just to make sure: Are you speaking about loadavg that is output by
> /proc/loadavg or load_avg which is the PELT load ?

/proc/loadavg

>> monitoring system this happened to be the loadavg right before I suspended.
>> I've reverted this, rebooted, created a loadavg >0, suspended and after wake up
>> loadavg again correctly ranges between 0 and whatever, as expected.
> 
> I'm not sure to catch why ~7 is bad compared to correctly ranges
> between 0 and whatever. Isn't ~7 part of the whatever ?

After wakeup the _baseline_ for loadavg seemed to be the last value before suspend,
not 0. The 7 then was the base loadavg for a _mostly idle machine_ (just reading
mail etc.), i.e. it never went below said baseline again, no matter the
_actual_ load.

Here's an image: https://imgur.com/a/kd2stqO

Before 02:00 last night the load was ~7 (compiled something), then all processes
were terminated and the machine was suspended. After wakeup the machine was mostly
idle (9am..11am), yet measured loadavg continued with the same value as before.
I didn't notice this right away since my CPU meter on the desktop didn't show any
*actual* activity (because there was none). The spike at ~11am is the revert/reboot.
After that loadavg became normal again, i.e. representative of the actual load,
even after suspend/resume cycles.
I suspend/resume every night and the only thing that changed recently was this
patch, so.. :)

-h
