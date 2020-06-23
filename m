Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5407CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A066206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgFWJrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:47:00 -0400
Received: from foss.arm.com ([217.140.110.172]:48086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731921AbgFWJq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0921F1;
        Tue, 23 Jun 2020 02:46:59 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C9993F6CF;
        Tue, 23 Jun 2020 02:46:56 -0700 (PDT)
Subject: Re: [PATCH v5 4/7] arm64: perf: Defer irq_work to IPI_IRQ_WORK
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20200617113851.607706-1-alexandru.elisei@arm.com>
 <20200617113851.607706-5-alexandru.elisei@arm.com>
 <20200622141918.GF88608@C02TD0UTHF1T.local>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <c044fbd2-238b-2309-f08d-56f20e845fc1@arm.com>
Date:   Tue, 23 Jun 2020 10:47:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622141918.GF88608@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 6/22/20 3:19 PM, Mark Rutland wrote:
> On Wed, Jun 17, 2020 at 12:38:48PM +0100, Alexandru Elisei wrote:
>> From: Julien Thierry <julien.thierry@arm.com>
>>
>> perf_event_overflow() can queue an irq_work on the current PE, which is
>> executed via an IPI. Move the processing of the irq_work from the PMU IRQ
>> handler to the IPI handler, which gets executed immediately afterwards.
>>
>> This also makes the IRQ handler NMI safe, because it removes the call to
>> irq_work_run().
> It wasn't entirely clear to me what the situation was today, and why
> this was sound. How about the following to spell that out more
> explicitly:
>
> | When handling events armv8pmu_handle_irq() calls
> | perf_event_overflow(), and subsequently calls irq_work_run() to handle
> | any work queued by perf_event_overflow(). As perf_event_overflow()
> | raises IPI_IRQ_WORK when queing the work, this isn't strictly
> | necessary and the work could be handled as part of the IPI_IRQ_WORK
> | handler.
> |
> | In the common case the IPI handler will run immediately after the PMU
> | IRQ handler, and where the PE is heavily loaded with interrupts other
> | handlers may run first, widening the window where some counters are
> | disabled.
> |
> | In practice this window is unlikely to be a significant issue, and
> | removing the call to irq_work_run() would make the PMU IRQ handler NMI
> | safe in addition to making it simpler, so let's do that.
>
> Thanks,
> Mark.

That is much better than my commit message, I will definitely update it with your
suggestion.

Thanks,
Alex
>
>> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> [Reworded commit]
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> ---
>>  arch/arm64/kernel/perf_event.c | 14 +++++---------
>>  1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index a6195022be7d..cf1d92030790 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -750,20 +750,16 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>  		if (!armpmu_event_set_period(event))
>>  			continue;
>>  
>> +		/*
>> +		 * Perf event overflow will queue the processing of the event as
>> +		 * an irq_work which will be taken care of in the handling of
>> +		 * IPI_IRQ_WORK.
>> +		 */
>>  		if (perf_event_overflow(event, &data, regs))
>>  			cpu_pmu->disable(event);
>>  	}
>>  	armv8pmu_start(cpu_pmu);
>>  
>> -	/*
>> -	 * Handle the pending perf events.
>> -	 *
>> -	 * Note: this call *must* be run with interrupts disabled. For
>> -	 * platforms that can have the PMU interrupts raised as an NMI, this
>> -	 * will not work.
>> -	 */
>> -	irq_work_run();
>> -
>>  	return IRQ_HANDLED;
>>  }
>>  
>> -- 
>> 2.27.0
>>
