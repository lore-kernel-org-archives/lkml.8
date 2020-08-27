Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E18C22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgH0O5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:57:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:40761 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbgH0Mjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:39:51 -0400
IronPort-SDR: U0MCHEVj2fd/+DS81q6xK9UDqxrTf/8twybOvXIgUq+Cqcv4weObSiAkMn3rfMNsMzy+J8qMlj
 1jNSHlESN7Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136018002"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="136018002"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 05:39:42 -0700
IronPort-SDR: I7hnSZngTxMG/hXNGX0xkQrL0Q7Wfki/FrL/5joXObE0KoYnr9my145U9REKhnegDidLpnUxab
 HAkdoz1iS80Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="475191064"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2020 05:39:41 -0700
Received: from [10.251.24.169] (kliang2-MOBL.ccr.corp.intel.com [10.251.24.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 07989580810;
        Thu, 27 Aug 2020 05:39:40 -0700 (PDT)
Subject: Re: [PATCH 0/4] TopDown metrics support for Ice Lake (perf tool)
To:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com
References: <20200820164532.8011-1-kan.liang@linux.intel.com>
 <20200826155441.GA783610@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7dafad06-0486-753c-1927-e5ea676fdadf@linux.intel.com>
Date:   Thu, 27 Aug 2020 08:39:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826155441.GA783610@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2020 11:54 AM, Jiri Olsa wrote:
> On Thu, Aug 20, 2020 at 09:45:28AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The kernel patches have been merged into the tip's perf/core branch.
>> The patch set is on top of commit 2cb5383b30d4 ("perf/x86/intel: Support
>> per-thread RDPMC TopDown metrics") of the tip's perf/core branch.
>>
>> The changes for the perf tool include:
>> - Extend --topdown option to support per thread TopDown metrics
>> - Support sample-read topdown metric group
>> - Add a complete document for the TopDown usage.
>>
>> Ice Lake has support for measuring the level 1 TopDown metrics
>> directly in hardware. This is implemented by an additional METRICS
>> register, and a new Fixed Counter 3 that measures pipeline SLOTS.
>>
>> New in Icelake
>> - Do not require generic counters. This allows to collect TopDown always
>>    in addition to other events.
>> - Measuring TopDown per thread/process instead of only per core
>>
>> For the Ice Lake implementation of performance metrics, the values in
>> PERF_METRICS MSR are derived from fixed counter 3. Software should start
>> both registers, PERF_METRICS and fixed counter 3, from zero.
>> Additionally, software is recommended to periodically clear both
>> registers in order to maintain accurate measurements. The latter is
>> required for certain scenarios that involve sampling metrics at high
>> rates. Software should always write fixed counter 3 before write to
>> PERF_METRICS.
>>
>> IA32_PERF_GLOBAL_STATUS. OVF_PERF_METRICS[48]: If this bit is set,
>> it indicates that some PERF_METRICS-related counter has overflowed and
>> a PMI is triggered. Software has to synchronize, e.g. re-start,
>> PERF_METRICS as well as fixed counter 3. Otherwise, PERF_METRICS may
>> return invalid values.
>>
>> Limitation
>> - To get accurate result and avoid reading the METRICS register multiple
>>    times, the TopDown metrics events and SLOTS event have to be in the
>>    same group.
>> - METRICS and SLOTS registers have to be cleared after each read by SW.
>>    That is to prevent the lose of precision.
>> - Cannot do sampling read SLOTS and TopDown metric events
>>
>> Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
>> TopDown metrics.
>>
>> Andi Kleen (2):
>>    perf stat: Support new per thread TopDown metrics
>>    perf, tools: Add documentation for topdown metrics
>>
>> Kan Liang (2):
>>    perf tools: Rename group to topdown
>>    perf record: Support sample-read topdown metric group
> 
> I don't have Ice lake to actualy check, but it looks good
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 


Thanks Jirka for the review.

Hi Arnaldo,

Andi has a comment regarding a grammar error in the printf message. I 
once plan to apply a fix in the next version. I'm not sure whether you 
will have more comments for this patch set.
If yes, I will wait for the comments.
If not, should I send a V2 patch set with this fixed?

On 8/20/2020 4:05 PM, Andi Kleen wrote:
 >> +				fprintf(stat_config.output,
 >> +					"Topdown accuracy may decreases when measuring long period.\n"
 > "may decrease" ... "long periods".
 >
 > (s needs to move to the end)


Thanks,
Kan
