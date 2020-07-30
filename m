Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF1420838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgG3Pyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:54:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:59416 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgG3Pyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:54:39 -0400
IronPort-SDR: ifLtQHcDM77wRI68OZ7bTaVlA4HCg2BIya+GYRpFKCVpejRgYDkJTQFNfIn3f7klcx5OWiT83+
 XYymTDAA/XJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="152847747"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="152847747"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 08:54:38 -0700
IronPort-SDR: 2Oyh9SXnTy6vG12/ri2tPBygah7XluuALPmzWR6vkA8h2TV1nXjygQ2xBIkQbh2swXB9Vgrlsh
 /MUmYKpKVWXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="322939885"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2020 08:54:38 -0700
Received: from [10.251.2.11] (kliang2-mobl.ccr.corp.intel.com [10.251.2.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 41406580378;
        Thu, 30 Jul 2020 08:54:37 -0700 (PDT)
Subject: Re: [PATCH] perf/x86: Reset the counter to prevent the leak for a
 RDPMC task
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, Mark Rutland <mark.rutland@arm.com>
References: <20200730123815.18518-1-kan.liang@linux.intel.com>
 <20200730125817.GL2655@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cd65635b-d226-3089-cb4a-8f60ae408db5@linux.intel.com>
Date:   Thu, 30 Jul 2020 11:54:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730125817.GL2655@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2020 8:58 AM, peterz@infradead.org wrote:
> On Thu, Jul 30, 2020 at 05:38:15AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The counter value of a perf task may leak to another RDPMC task.
> 
> Sure, but nowhere did you explain why that is a problem.
> 
>> The RDPMC instruction is only available for the X86 platform. Only apply
>> the fix for the X86 platform.
> 
> ARM64 can also do it, although I'm not sure what the current state of
> things is here.
> 
>> After applying the patch,
>>
>>      $ taskset -c 0 ./rdpmc_read_all_counters
>>      index 0x0 value 0x0
>>      index 0x1 value 0x0
>>      index 0x2 value 0x0
>>      index 0x3 value 0x0
>>
>>      index 0x0 value 0x0
>>      index 0x1 value 0x0
>>      index 0x2 value 0x0
>>      index 0x3 value 0x0
> 
> You forgot about:
> 
>   - telling us why it's a problem,

The non-privileged RDPMC user can get the counter information from other 
perf users. It is a security issue. I will add it in the next version.

>   - telling us how badly it affects performance.

I once did performance test on a HSX machine. There is no notable slow 
down with the patch. I will add the performance data in the next version.

> 
> I would feel much better if we only did this on context switches to
> tasks that have RDPMC enabled.

AFAIK, at least for X86, we can only enable/disable RDPMC globally.
How can we know if a specific task that have RDPMC enabled/disabled?

> 
> So on del() mark the counter dirty (if we don't already have state that
> implies this), but don't WRMSR. And then on
> __perf_event_task_sched_in(), _after_ programming the new tasks'
> counters, check for inactive dirty counters and wipe those -- IFF RDPMC
> is on for that task.
> 

The generic code doesn't have counters' information. It looks like we 
need to add a new callback to cleanup the dirty counters as below.

In the specific implementation of pmu_cleanup(), we can check and wipe 
all inactive dirty counters.

Is it OK?

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1cbf57dc2ac8..3daaf0a7746d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3774,6 +3781,15 @@ static void perf_event_context_sched_in(struct 
perf_event_context *ctx,
         if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
                 cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
         perf_event_sched_in(cpuctx, ctx, task);
+
+	/*
+	 * Some leftovers from the previous task may still exist on the unused
+	 * counters. The new task may illegally read the counters, e.g. via
+	 * RDPMC. The information from the previous task will be leaked. Clean
+	 * up the PMU before enabling it.
+	 */
+	if (ctx->pmu->pmu_cleanup)
+		ctx->pmu->pmu_cleanup(pmu);
	perf_pmu_enable(ctx->pmu);

  unlock:



Thanks,
Kan
