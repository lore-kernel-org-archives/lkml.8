Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F95C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B877A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMM1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:27:42 -0500
Received: from foss.arm.com ([217.140.110.172]:38796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgAMM1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:27:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5595913D5;
        Mon, 13 Jan 2020 04:27:41 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92EBD3F68E;
        Mon, 13 Jan 2020 04:27:39 -0800 (PST)
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
To:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd@arm.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <fd4f4278-fa43-86dc-1f2f-3439f19fea9e@arm.com>
Date:   Mon, 13 Jan 2020 12:27:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191223034852.GB3981@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 23/12/2019 03:48, Leo Yan wrote:
> Hi James,
> 
> On Fri, Dec 20, 2019 at 11:05:25AM +0000, James Clark wrote:
>> This patch fixes an issue when non Arm SPE events are specified after an
>> Arm SPE event. In that case, perf will exit with an error code and not
>> produce a record file. This is because a loop index is used to store the
>> location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
>> index will be overwritten. Fix this issue by saving the PMU into a
>> variable instead of using the index, and also add an error message.
>>
>> Before the fix:
>>      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
>>      237
>>
>> After the fix:
>>      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
>>      ...
>>      0
> 
> Just bring up a question related with PMU event registration.  Let's
> see the DT binding in arch/arm64/boot/dts/arm/fvp-base-revc.dts:
> 
>           spe-pmu {
>                   compatible = "arm,statistical-profiling-extension-v1";
>                   interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
>           };
> 
> 
> Now SPE registers PMU event for every CPU; seem to me, though SPE is an

Do you mean "SPE PMU" here ? SPE is different from ETM, where the trace
data is micro-architecture dependent. And thus you cannot mix the trace
on different CPUs with different micro-archs.

As such I don't see any issue with this patch.

Suzuki
