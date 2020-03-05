Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D5EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361FA20684
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgCEVCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:02:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:9691 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgCEVCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:02:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 13:02:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234566101"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 13:02:13 -0800
Received: from [10.251.16.243] (kliang2-mobl.ccr.corp.intel.com [10.251.16.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 219345802A3;
        Thu,  5 Mar 2020 13:02:12 -0800 (PST)
Subject: Re: [PATCH 02/12] perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200228163011.19358-3-kan.liang@linux.intel.com>
 <20200305202509.GA17483@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <74b01cee-12dc-2a95-9817-4f89a3fbd441@linux.intel.com>
Date:   Thu, 5 Mar 2020 16:02:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305202509.GA17483@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2020 3:25 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 28, 2020 at 08:30:01AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A new branch sample type PERF_SAMPLE_BRANCH_HW_INDEX has been introduced
>> in latest kernel.
>>
>> Enable HW_INDEX by default in LBR call stack mode.
>> If kernel doesn't support the sample type, switching it off.
>>
>> Add HW_INDEX in attr_fprintf as well. User can check whether the branch
>> sample type is set via debug information or header.
> 
> So while this works with a kernel where PERF_SAMPLE_BRANCH_HW_INDEX is
> present and we get, from the committer notes I was putting together
> while testing/applying this cset:
> 
> First collect some samples with LBR callchains, system wide, for a few
> seconds:
> 
>    # perf record --call-graph lbr -a sleep 5
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.625 MB perf.data (224 samples) ]
>    #
> 
> Now lets use 'perf evlist -v' to look at the branch_sample_type:
> 
>    # perf evlist -v
>    cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
>    #
> 
> So the machine has the kernel feature, and it was correctly added to
> perf_event_attr.branch_sample_type, for the default 'cycles' event.
> 
> Cool, and look at that 'attr.precise_ip: 3' part, the kernel is OK with
> having that together with attr.branch_sample_type with HW_INDEX set.
> 
> The problem happens when I go test this in an older kernel, where the
> kernel doesn't know about HW_INDEX, we get it disabled but then
> precise_ip is set to zero in its detection , even if at the end we get
> it to 3, as expected, which got me a bit confused, I'll investigate this
> a bit more to try and avoid these extra probes for the max precise level
> that fails in older kernels due to branch_sample_type having HW_INDEX
> :-\

It looks like this is an expected behavior for the event with maximum 
precise config for current perf tool.

The related commits are as below:
commit ID: 4e8a5c155137 ("perf evsel: Fix max perf_event_attr.precise_ip 
detection")
commit ID: cd136189370c ("perf evsel: Do not rely on errno values for 
precise_ip fallback")

Before handling any standard fallback (not just HW_INDEX), perf tool 
will try all the precise_ip value first.

Thanks,
Kan

> 
> 
> # perf record -vv --call-graph lbr -a sleep 5
> <SNIP>
> ------------------------------------------------------------
> perf_event_attr:
>    size                             120
>    { sample_period, sample_freq }   4000
>    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
>    read_format                      ID
>    disabled                         1
>    inherit                          1
>    mmap                             1
>    comm                             1
>    freq                             1
>    task                             1
>    precise_ip                       3
>    sample_id_all                    1
>    exclude_guest                    1
>    mmap2                            1
>    comm_exec                        1
>    ksymbol                          1
>    bpf_event                        1
>    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -95
> decreasing precise_ip by one (2)
> ------------------------------------------------------------
> perf_event_attr:
>    size                             120
>    { sample_period, sample_freq }   4000
>    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
>    read_format                      ID
>    disabled                         1
>    inherit                          1
>    mmap                             1
>    comm                             1
>    freq                             1
>    task                             1
>    precise_ip                       2
>    sample_id_all                    1
>    exclude_guest                    1
>    mmap2                            1
>    comm_exec                        1
>    ksymbol                          1
>    bpf_event                        1
>    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -95
> decreasing precise_ip by one (1)
> ------------------------------------------------------------
> perf_event_attr:
>    size                             120
>    { sample_period, sample_freq }   4000
>    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
>    read_format                      ID
>    disabled                         1
>    inherit                          1
>    mmap                             1
>    comm                             1
>    freq                             1
>    task                             1
>    precise_ip                       1
>    sample_id_all                    1
>    exclude_guest                    1
>    mmap2                            1
>    comm_exec                        1
>    ksymbol                          1
>    bpf_event                        1
>    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -95
> decreasing precise_ip by one (0)
> ------------------------------------------------------------
> perf_event_attr:
>    size                             120
>    { sample_period, sample_freq }   4000
>    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
>    read_format                      ID
>    disabled                         1
>    inherit                          1
>    mmap                             1
>    comm                             1
>    freq                             1
>    task                             1
>    sample_id_all                    1
>    exclude_guest                    1
>    mmap2                            1
>    comm_exec                        1
>    ksymbol                          1
>    bpf_event                        1
>    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off branch HW index support
> ------------------------------------------------------------
> perf_event_attr:
>    size                             120
>    { sample_period, sample_freq }   4000
>    sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK
>    read_format                      ID
>    disabled                         1
>    inherit                          1
>    mmap                             1
>    comm                             1
>    freq                             1
>    task                             1
>    precise_ip                       3
>    sample_id_all                    1
>    exclude_guest                    1
>    mmap2                            1
>    comm_exec                        1
>    ksymbol                          1
>    bpf_event                        1
>    branch_sample_type               USER|CALL_STACK|NO_FLAGS|NO_CYCLES
> ------------------------------------------------------------
> 
> 
>   
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/util/evsel.c                   | 15 ++++++++++++---
>>   tools/perf/util/evsel.h                   |  1 +
>>   tools/perf/util/perf_event_attr_fprintf.c |  1 +
>>   3 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 05883a45de5b..816d930d774e 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -712,7 +712,8 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
>>   				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
>>   							PERF_SAMPLE_BRANCH_CALL_STACK |
>>   							PERF_SAMPLE_BRANCH_NO_CYCLES |
>> -							PERF_SAMPLE_BRANCH_NO_FLAGS;
>> +							PERF_SAMPLE_BRANCH_NO_FLAGS |
>> +							PERF_SAMPLE_BRANCH_HW_INDEX;
>>   			}
>>   		} else
>>   			 pr_warning("Cannot use LBR callstack with branch stack. "
>> @@ -763,7 +764,8 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
>>   	if (param->record_mode == CALLCHAIN_LBR) {
>>   		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
>>   		attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
>> -					      PERF_SAMPLE_BRANCH_CALL_STACK);
>> +					      PERF_SAMPLE_BRANCH_CALL_STACK |
>> +					      PERF_SAMPLE_BRANCH_HW_INDEX);
>>   	}
>>   	if (param->record_mode == CALLCHAIN_DWARF) {
>>   		perf_evsel__reset_sample_bit(evsel, REGS_USER);
>> @@ -1673,6 +1675,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>>   		evsel->core.attr.ksymbol = 0;
>>   	if (perf_missing_features.bpf)
>>   		evsel->core.attr.bpf_event = 0;
>> +	if (perf_missing_features.branch_hw_idx)
>> +		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
>>   retry_sample_id:
>>   	if (perf_missing_features.sample_id_all)
>>   		evsel->core.attr.sample_id_all = 0;
>> @@ -1784,7 +1788,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>>   	 * Must probe features in the order they were added to the
>>   	 * perf_event_attr interface.
>>   	 */
>> -	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
>> +	if (!perf_missing_features.branch_hw_idx &&
>> +	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
>> +		perf_missing_features.branch_hw_idx = true;
>> +		pr_debug2("switching off branch HW index support\n");
>> +		goto fallback_missing_features;
>> +	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
>>   		perf_missing_features.aux_output = true;
>>   		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
>>   		goto out_close;
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 99a0cb60c556..33804740e2ca 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -119,6 +119,7 @@ struct perf_missing_features {
>>   	bool ksymbol;
>>   	bool bpf;
>>   	bool aux_output;
>> +	bool branch_hw_idx;
>>   };
>>   
>>   extern struct perf_missing_features perf_missing_features;
>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
>> index 651203126c71..355d3458d4e6 100644
>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>> @@ -50,6 +50,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
>>   		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
>>   		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
>>   		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
>> +		bit_name(HW_INDEX),
>>   		{ .name = NULL, }
>>   	};
>>   #undef bit_name
>> -- 
>> 2.17.1
>>
> 
