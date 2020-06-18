Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23056C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EC4207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgFRKuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:50:51 -0400
Received: from foss.arm.com ([217.140.110.172]:47968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgFRKuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:50:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 304F231B;
        Thu, 18 Jun 2020 03:50:50 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606CD3F71F;
        Thu, 18 Jun 2020 03:50:48 -0700 (PDT)
Subject: Re: [PATCH v5 3/7] arm64: perf: Remove PMU locking
To:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com>
 <20200617113851.607706-4-alexandru.elisei@arm.com>
 <159242503203.62212.1690942414916053920@swboyd.mtv.corp.google.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <bc265120-0d48-bcab-a58e-3b94f8c540ce@arm.com>
Date:   Thu, 18 Jun 2020 11:51:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159242503203.62212.1690942414916053920@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/17/20 9:17 PM, Stephen Boyd wrote:
> Quoting Alexandru Elisei (2020-06-17 04:38:47)
>> From: Julien Thierry <julien.thierry@arm.com>
>>
>> The PMU is disabled and enabled, and the counters are programmed from
>> contexts where interrupts or preemption is disabled.
>>
>> The functions to toggle the PMU and to program the PMU counters access the
>> registers directly and don't access data modified by the interrupt handler.
>> That, and the fact that they're always called from non-preemptible
>> contexts, means that we don't need to disable interrupts or use a spinlock.
> Maybe we should add a lockdep assertion that the code isn't preemptible?
> I.e. add a cant_sleep() call? Or is it more that we don't need locking
> because we're just doing register accesses and don't need to protect
> those accesses from each other?

It's both. The spinlocks were there to protect the functions from being preempted
and possibly migrated to another CPU, and from being interrupted by the PMU irq
handler.

There was no data race with the interrupt handler, but before the previous patch
("arm64: perf: Avoid PMXEV* indirection"), in order to read/write/program a
counter, one had to write the counter number to a counter selection register, and
then write/read the desired value from another register. This was done from both
the armv8pmu_{enable,disable}_event() functions and the irq handler, and the
spinlock was necessary. Now that we can access a counter using a single register
access, there's no need to protect the functions from being interrupted by the IRQ
handler. As for armv8pmu_{start,stop}(), they consist of one register write, so
it's also safe for the irq handler to interrupt them.

For the preemption part of the locking. The armv8pmu_{enable,disable}_event(),
when called by the perf core code via the pmu->{start,stop,add,del} callbacks, are
guaranteed to be called with IRQs and preemption disabled, as per the comment in
include/linux/perf_event.h. They are also called from the arm_pmu driver by the
CPU PM notifiers, which should also be executed with interrupts disabled. Should
we check here that the top level code respects these guarantees?

The armv8pmu_{start,stop}() functions are called from the irq handler, so we're
safe from preemption in this case. They are also called via
pmu->pmu_{enable,disable} callbacks, and I didn't find an explicit contract
regarding preemption in include/linux/perf_event.h. I've checked the other call
sites, and I didn't find any instances where they are called with preemption
enabled, which makes sense as we don't want to disable the PMU on a another CPU by
accident.

I would be inclined to add cant_sleep() calls to armv8pmu_{start,stop}(). In the
previous iteration, there were WARN_ONs in these functions, and Will said [1] they
can be removed because they are per-CPU operations. Will, what do you think about
adding the lockdep assertions?

[1] https://www.spinics.net/lists/arm-kernel/msg745161.html

Thanks,
Alex
