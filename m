Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DACC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29DC20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBKow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:44:52 -0400
Received: from foss.arm.com ([217.140.110.172]:35416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBKov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:44:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294B6D6E;
        Wed,  2 Sep 2020 03:44:50 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D01D3F66F;
        Wed,  2 Sep 2020 03:44:43 -0700 (PDT)
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Phil Auld <pauld@redhat.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
Date:   Wed, 2 Sep 2020 12:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Phil Auld <pauld@redhat.com>

On 28/08/2020 19:26, Qais Yousef wrote:
> On 08/28/20 19:10, Dietmar Eggemann wrote:
>> On 28/08/2020 12:27, Qais Yousef wrote:
>>> On 08/28/20 10:00, vincent.donnefort@arm.com wrote:
>>>> From: Vincent Donnefort <vincent.donnefort@arm.com>

[...]

>> Can you remind me why we have all these helper functions like
>> sched_trace_rq_cpu_capacity?
> 
> struct rq is defined in kernel/sched/sched.h. It's not exported. Exporting
> these helper functions was the agreement to help modules trace internal info.
> By passing generic info you decouple the tracepoint from giving specific info
> and allow the modules to extract all the info they need from the same
> tracepoint. IE: if you need more than just cpu_capacity from this tracepoint,
> you can get that without having to continuously add extra arguments everytime
> you need an extra piece of info. Unless this info is not in the rq of course.

I think this decoupling is not necessary. The natural place for those
scheduler trace_event based on trace_points extension files is
kernel/sched/ and here the internal sched.h can just be included.

If someone really wants to build this as an out-of-tree module there is
an easy way to make kernel/sched/sched.h visible.

CFLAGS_sched_tp.o := -I$KERNEL_SRC/kernel/sched

all:
    make -C $KERNEL_SRC M=$(PWD) modules

This allowed me to build our trace_event extension module (sched_tp.c,
sched_events.h) out-of-tree and I was able to get rid of all the
sched_trace_foo() functions (in fair.c, include/linux/sched.h) and code
there content directly in foo.c

There are two things we would need exported from the kernel:

(1) cfs_rq_tg_path() to print the path of a taskgroup cfs_rq or se.

(2) sched_uclamp_used so uclamp_rq_util_with() can be used in
    sched_events.h.

I put Phil Auld on cc because of his trace_point
sched_update_nr_running_tp. I think Phil was using sched_tp as a base so
I can't see an issue why we can't also remove sched_trace_rq_nr_running().

>> In case we would let the extra code (which transforms trace points into
>> trace events) know the internals of struct rq we could handle those
>> things in the TRACE_EVENT and/or the register_trace_##name(void
>> (*probe)(data_proto), void *data) thing.
>> We always said when the internal things will change this extra code will
>> break. So that's not an issue.
> 
> The problem is that you need to export struct rq in a public header. Which we
> don't want to do. I have been trying to find out how to use BTF so we can
> remove these functions. Haven't gotten far away yet - but it should be doable
> and it's a question of me finding enough time to understand what was currently
> done and if I can re-use something or need to come up with extra infrastructure
> first.

Let's keep the footprint of these trace points as small as possible in
the scheduler code.

I'm putting the changes I described above in our monthly EAS integration
right now and when this worked out nicely I will share the patches on lkml.
