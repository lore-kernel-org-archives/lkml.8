Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDEEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 690EB2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgETFgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:36:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:58244 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgETFgo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:36:44 -0400
IronPort-SDR: 6QE4SB5lb+7MX0ZJbG35mFZ9Zh9eGY46aS790F4EYM8LiAQOrsDlBNhrqQmkPdKbwer1EvBMkO
 XEEfDTRpzrdw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 22:36:43 -0700
IronPort-SDR: 87gc2lov21YAmGt3hHVbONHx3bH/K5qKm/iMkLTJkaMCftMIYpxn4KPqrUtVoJ19OBanL+diPi
 Yn+sAvLNj6bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="373965863"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2020 22:36:41 -0700
Subject: Re: [PATCH] perf evsel: Get group fd from CPU0 for system wide event
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200430013451.17196-1-yao.jin@linux.intel.com>
 <20200501102337.GA1761222@krava>
 <b799b66a-42aa-6c55-647e-7b718473632a@linux.intel.com>
 <20200505000352.GH1916255@krava>
 <3e813227-4954-0d4b-bc7a-ca272b18454a@linux.intel.com>
 <68e53765-6f45-9483-7543-0a2f961cdc62@linux.intel.com>
 <20200515083312.GB3511648@krava>
 <5fe2efe4-f8a3-04ef-f5e8-7b9c433d4142@linux.intel.com>
Message-ID: <82da23c8-94dd-4096-a987-a17087e2642f@linux.intel.com>
Date:   Wed, 20 May 2020 13:36:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5fe2efe4-f8a3-04ef-f5e8-7b9c433d4142@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/18/2020 11:28 AM, Jin, Yao wrote:
> Hi Jiri,
> 
> On 5/15/2020 4:33 PM, Jiri Olsa wrote:
>> On Fri, May 15, 2020 at 02:04:57PM +0800, Jin, Yao wrote:
>>
>> SNIP
>>
>>> I think I get the root cause. That should be a serious bug in get_group_fd, access violation!
>>>
>>> For a group mixed with system-wide event and per-core event and the group
>>> leader is system-wide event, access violation will happen.
>>>
>>> perf_evsel__alloc_fd allocates one FD member for system-wide event (only FD(evsel, 0, 0) is valid).
>>>
>>> But for per core event, perf_evsel__alloc_fd allocates N FD members (N =
>>> ncpus). For example, for ncpus is 8, FD(evsel, 0, 0) to FD(evsel, 7, 0) are
>>> valid.
>>>
>>> get_group_fd(struct evsel *evsel, int cpu, int thread)
>>> {
>>>      struct evsel *leader = evsel->leader;
>>>
>>>      fd = FD(leader, cpu, thread);    /* access violation may happen here */
>>> }
>>>
>>> If leader is system-wide event, only the FD(leader, 0, 0) is valid.
>>>
>>> When get_group_fd accesses FD(leader, 1, 0), access violation happens.
>>>
>>> My fix is:
>>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index 28683b0eb738..db05b8a1e1a8 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -1440,6 +1440,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>>>          if (evsel__is_group_leader(evsel))
>>>                  return -1;
>>>
>>> +       if (leader->core.system_wide && !evsel->core.system_wide)
>>> +               return -2;
>>
>> so this effectively stops grouping system_wide events with others,
>> and I think it's correct, how about events that differ in cpumask?
>>
> 
> My understanding for the events that differ in cpumaks is, if the leader's cpumask is not fully 
> matched with the evsel's cpumask then we stop the grouping. Is this understanding correct?
> 
> I have done some tests and get some conclusions:
> 
> 1. If the group is mixed with core and uncore events, the system_wide checking can distinguish them.
> 
> 2. If the group is mixed with core and uncore events and "-a" is specified, the system_wide for core 
> event is also false. So system_wide checking can distinguish them too
> 
> 3. In my test, the issue only occurs when we collect the metric which is mixed with uncore event and 
> core event, so maybe checking the system_wide is OK.
> 
>> should we perhaps ensure this before we call open? go throught all
>> groups and check they are on the same cpus?
>>
> 
> The issue doesn't happen at most of the time (only for the metric consisting of uncore event and 
> core event), so fallback to stop grouping if call open is failed looks reasonable.
> 
> Thanks
> Jin Yao
> 
>> thanks,
>> jirka
>>
>>
>>> +
>>>          /*
>>>           * Leader must be already processed/open,
>>>           * if not it's a bug.
>>> @@ -1665,6 +1668,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>>>                                  pid = perf_thread_map__pid(threads, thread);
>>>
>>>                          group_fd = get_group_fd(evsel, cpu, thread);
>>> +                       if (group_fd == -2) {
>>> +                               errno = EINVAL;
>>> +                               err = -EINVAL;
>>> +                               goto out_close;
>>> +                       }
>>>   retry_open:
>>>                          test_attr__ready();
>>>
>>> It enables the perf_evlist__reset_weak_group. And in the second_pass (in
>>> __run_perf_stat), the events will be opened successfully.
>>>
>>> I have tested OK for this fix on cascadelakex.
>>>
>>> Thanks
>>> Jin Yao
>>>
>>

Is this fix OK?

Another thing is, do you think if we need to rename "evsel->core.system_wide" to 
"evsel->core.has_cpumask".

The "system_wide" may misleading.

evsel->core.system_wide = pmu ? pmu->is_uncore : false;

"pmu->is_uncore" is true if PMU has a "cpumask". But it's not just uncore PMU which has cpumask. 
Some other PMUs, e.g. cstate_pkg, also have cpumask. So for this case, "has_cpumask" should be better.

But I'm not sure if the change is OK for other case, e.g. PT, which also uses 
"evsel->core.system_wide".

Thanks
Jin Yao
