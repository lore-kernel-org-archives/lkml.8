Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C87C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E087E208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgIKPJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:09:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:44099 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgIKPCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:02:36 -0400
IronPort-SDR: qjBrqU2C/hDcyoS6hFfjaJHC8/tLYIe4FyjT0xmJAEbZDnJqUJfD7uSL9pTWTlqVkrxDZ3LqMS
 /lPGyq1Qsggg==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="222960845"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="222960845"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 07:12:11 -0700
IronPort-SDR: FJkBPqTlV7drwVzUoMaUpPusqGTZsZ6QB3TTPgi7OfjiuyCrwhIQ1CxqHZ12ULcEV4aubi+rxo
 E3vmJPwOEsPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="286902885"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2020 07:12:10 -0700
Received: from [10.251.9.220] (kliang2-MOBL.ccr.corp.intel.com [10.251.9.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 91E97580039;
        Fri, 11 Sep 2020 07:12:09 -0700 (PDT)
Subject: Re: [PATCH V2 3/4] perf stat: Support new per thread TopDown metrics
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20200910134501.11352-1-kan.liang@linux.intel.com>
 <20200910134501.11352-4-kan.liang@linux.intel.com>
 <CAM9d7ci1p1Ej-9=RuJLHJWQ76GR6gjHS2Y=rsQQ0LhNW5YKUBg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b7d8dbb6-be8f-9c15-256b-fc57936aaa1e@linux.intel.com>
Date:   Fri, 11 Sep 2020 10:12:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ci1p1Ej-9=RuJLHJWQ76GR6gjHS2Y=rsQQ0LhNW5YKUBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2020 11:37 PM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Sep 10, 2020 at 10:48 PM <kan.liang@linux.intel.com> wrote:
>>
>> From: Andi Kleen <ak@linux.intel.com>
>>
>> Icelake has support for reporting per thread TopDown metrics.
>> These are reported differently than the previous TopDown support,
>> each metric is standalone, but scaled to pipeline "slots".
>> We don't need to do anything special for HyperThreading anymore.
>> Teach perf stat --topdown to handle these new metrics and
>> print them in the same way as the previous TopDown metrics.
>> The restrictions of only being able to report information per core is
>> gone.
>>
>> Acked-by: Jiri Olsa <jolsa@redhat.com>
>> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>   tools/perf/Documentation/perf-stat.txt |  7 +-
>>   tools/perf/builtin-stat.c              | 30 ++++++++-
>>   tools/perf/util/stat-shadow.c          | 89 ++++++++++++++++++++++++++
>>   tools/perf/util/stat.c                 |  4 ++
>>   tools/perf/util/stat.h                 |  8 +++
>>   5 files changed, 134 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>> index c9bfefc051fb..e803dbdc88a8 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -357,6 +357,11 @@ if the workload is actually bound by the CPU and not by something else.
>>   For best results it is usually a good idea to use it with interval
>>   mode like -I 1000, as the bottleneck of workloads can change often.
>>
>> +This enables --metric-only, unless overridden with --no-metric-only.
>> +
>> +The following restrictions only apply to older Intel CPUs and Atom,
>> +on newer CPUs (IceLake and later) TopDown can be collected for any thread:
>> +
>>   The top down metrics are collected per core instead of per
>>   CPU thread. Per core mode is automatically enabled
>>   and -a (global monitoring) is needed, requiring root rights or
>> @@ -368,8 +373,6 @@ echo 0 > /proc/sys/kernel/nmi_watchdog
>>   for best results. Otherwise the bottlenecks may be inconsistent
>>   on workload with changing phases.
>>
>> -This enables --metric-only, unless overridden with --no-metric-only.
>> -
>>   To interpret the results it is usually needed to know on which
>>   CPUs the workload runs on. If needed the CPUs can be forced using
>>   taskset.
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 5583e22ca808..6290da5bd142 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -128,6 +128,15 @@ static const char * topdown_attrs[] = {
>>          NULL,
>>   };
>>
>> +static const char *topdown_metric_attrs[] = {
>> +       "slots",
>> +       "topdown-retiring",
>> +       "topdown-bad-spec",
>> +       "topdown-fe-bound",
>> +       "topdown-be-bound",
>> +       NULL,
>> +};
>> +
>>   static const char *smi_cost_attrs = {
>>          "{"
>>          "msr/aperf/,"
>> @@ -1691,6 +1700,24 @@ static int add_default_attributes(void)
>>                  char *str = NULL;
>>                  bool warn = false;
>>
>> +               if (!force_metric_only)
>> +                       stat_config.metric_only = true;
>> +
>> +               if (topdown_filter_events(topdown_metric_attrs, &str, 1) < 0) {
>> +                       pr_err("Out of memory\n");
>> +                       return -1;
>> +               }
>> +               if (topdown_metric_attrs[0] && str) {
>> +                       if (!stat_config.interval && !stat_config.metric_only) {
>> +                               fprintf(stat_config.output,
>> +                                       "Topdown accuracy may decrease when measuring long periods.\n"
>> +                                       "Please print the result regularly, e.g. -I1000\n");
>> +                       }
>> +                       goto setup_metrics;
>> +               }
>> +
>> +               str = NULL;
> 
> zfree(&str) ?

Yes, even the topdown events don't exist, str is still allocated.
The str should be free.

I will send V3 to fix it shortly.

Thanks,
Kan

> 
> Thanks
> Namhyung
> 
> 
>> +
>>                  if (stat_config.aggr_mode != AGGR_GLOBAL &&
>>                      stat_config.aggr_mode != AGGR_CORE) {
>>                          pr_err("top down event configuration requires --per-core mode\n");
>> @@ -1702,8 +1729,6 @@ static int add_default_attributes(void)
>>                          return -1;
>>                  }
>>
>> -               if (!force_metric_only)
>> -                       stat_config.metric_only = true;
>>                  if (topdown_filter_events(topdown_attrs, &str,
>>                                  arch_topdown_check_group(&warn)) < 0) {
>>                          pr_err("Out of memory\n");
>> @@ -1712,6 +1737,7 @@ static int add_default_attributes(void)
>>                  if (topdown_attrs[0] && str) {
>>                          if (warn)
>>                                  arch_topdown_group_warn();
>> +setup_metrics:
>>                          err = parse_events(evsel_list, str, &errinfo);
>>                          if (err) {
>>                                  fprintf(stderr,
