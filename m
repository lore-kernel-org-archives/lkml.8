Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A7C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F37E20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgBTQDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:03:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:36515 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgBTQDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:03:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 08:03:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="269640221"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2020 08:03:37 -0800
Received: from [10.251.25.159] (kliang2-mobl.ccr.corp.intel.com [10.251.25.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 171FE58056A;
        Thu, 20 Feb 2020 08:03:37 -0800 (PST)
Subject: Re: [PATCH 0/5] Support metric group constraint
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
 <20200220113924.GB565976@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <534b4b99-466a-0a5b-e9f5-b4711abd8a4a@linux.intel.com>
Date:   Thu, 20 Feb 2020 11:03:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220113924.GB565976@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2020 6:39 AM, Jiri Olsa wrote:
> On Wed, Feb 19, 2020 at 11:08:35AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Some metric groups, e.g. Page_Walks_Utilization, will never count when
>> NMI watchdog is enabled.
>>
>>   $echo 1 > /proc/sys/kernel/nmi_watchdog
>>   $perf stat -M Page_Walks_Utilization
>>
>>   Performance counter stats for 'system wide':
>>
>>   <not counted>      itlb_misses.walk_pending       (0.00%)
>>   <not counted>      dtlb_load_misses.walk_pending  (0.00%)
>>   <not counted>      dtlb_store_misses.walk_pending (0.00%)
>>   <not counted>      ept.walk_pending               (0.00%)
>>   <not counted>      cycles                         (0.00%)
>>
>>         2.343460588 seconds time elapsed
>>
>>   Some events weren't counted. Try disabling the NMI watchdog:
>>          echo 0 > /proc/sys/kernel/nmi_watchdog
>>          perf stat ...
>>          echo 1 > /proc/sys/kernel/nmi_watchdog
>>   The events in group usually have to be from the same PMU. Try
>>   reorganizing the group.
>>
>> A metric group is a weak group, which relies on group validation
>> code in the kernel to determine whether to be opened as a group or
>> a non-group. However, group validation code may return false-positives,
>> especially when NMI watchdog is enabled. (The metric group is allowed
>> as a group but will never be scheduled.)
>>
>> The attempt to fix the group validation code has been rejected.
>> https://lore.kernel.org/lkml/20200117091341.GX2827@hirez.programming.kicks-ass.net/
>> Because we cannot accurately predict whether the group can be scheduled
>> as a group, only by checking current status.
>>
>> This patch set provides another solution to mitigate the issue.
>> Add "MetricConstraint" in event list, which provides a hint for perf tool,
>> e.g. "MetricConstraint": "NO_NMI_WATCHDOG". Perf tool can change the
>> metric group to non-group (standalone metrics) if NMI watchdog is enabled.
> 
> the problem is in the missing counter, that's taken by NMI watchdog, right?
>
> and it's problem for any metric that won't fit to the available
> counters.. shouldn't we rather do this workaround for any metric
> that wouldn't fit in available counters? 

I think current perf already did this.
All metric groups are weak group. Kernel (validate_group()) tells perf 
tool whether a metric group fit to available counters.
If yes, the metric group will be scheduled as a group.
If no, perf tool will not using a group and re-try. The code is as below.

  try_again:
  		if (create_perf_stat_counter(counter, &stat_config, &target) < 0) {

  			/* Weak group failed. Reset the group. */
  			if ((errno == EINVAL || errno == EBADF) &&
  			    counter->leader != counter &&
  			    counter->weak_group) {
  				counter = perf_evlist__reset_weak_group(evsel_list, counter);
  				goto try_again;
  			}


This patch set is to workaroud the false-positives from the kernel.
Kernel only validate the group itself. It assumes that all counters are 
available. So, when any counter is permanently occupied by others, e.g. 
watchdog, the validate_group() may return false-positives.

? not just for chosen
> ones..?

For now, I think we only need to workaround the Page_Walks_Utilization 
metric group. Because it has 5 events, and one of the events is cycles.
The cycles has to be scheduled on fixed counter 2. But it's already 
occupied by watchdog.
The false-positives of validate_group() will trigger the issue (metric 
group never be scheduled.).

For other metric groups, even they have cycles, the issue should not be 
triggered.
For example, if they have 4 or less events, the cycles can be scheduled 
to GP counter instead.
If they have 6 or more events, the weak group will be reject anyway.
Perf tool will open it as non-group (standalone metrics).

I think we only need to apply the constraint for the 
Page_Walks_Utilization metric group for now.


Thanks,
Kan

> 
> thanks,
> jirka
> 
