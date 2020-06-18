Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A722C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53224207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgFRKuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:50:20 -0400
Received: from foss.arm.com ([217.140.110.172]:47882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgFRKuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:50:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85C5431B;
        Thu, 18 Jun 2020 03:50:14 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9935A3F71F;
        Thu, 18 Jun 2020 03:50:12 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] arm64: perf: Add missing ISB in
 armv8pmu_enable_event()
To:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com>
 <20200617113851.607706-2-alexandru.elisei@arm.com>
 <159242406774.62212.13909672383879587787@swboyd.mtv.corp.google.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <f1ab2ea4-97ad-0e27-ba0a-90fe53d54bce@arm.com>
Date:   Thu, 18 Jun 2020 11:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159242406774.62212.13909672383879587787@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you very much for taking the time to review the patches!

Comments below.

On 6/17/20 9:01 PM, Stephen Boyd wrote:
> Quoting Alexandru Elisei (2020-06-17 04:38:45)
>> Writes to the PMXEVTYPER_EL0 register are not self-synchronising. In
>> armv8pmu_enable_event(), the PE can reorder configuring the event type
>> after we have enabled the counter and the interrupt. This can lead to an
>> interrupt being asserted because the of the previous event type that we
> 'because the of the' doesn't read properly.

Typo on my part, will fix it.

>
>> were counting, not the one that we've just enabled.
>>
>> The same rationale applies to writes to the PMINTENSET_EL1 register. The PE
>> can reorder enabling the interrupt at any point in the future after we have
>> enabled the event.
>>
>> Prevent both situations from happening by adding an ISB just before we
>> enable the event counter.
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index 4d7879484cec..ee180b2a5b39 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -605,6 +605,7 @@ static void armv8pmu_enable_event(struct perf_event *event)
>>          * Enable interrupt for this counter
>>          */
>>         armv8pmu_enable_event_irq(event);
>> +       isb();
> Please add a comment before the isb() explaining the situation. Nobody
> knows what this is for when reading the code and they don't want to do
> git archaeology to figure it out.

That's a good idea, I'll do that.

Thanks,
Alex
