Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D51C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF4A2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403878AbgDCO3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:29:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:15121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCO3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:29:07 -0400
IronPort-SDR: lxkOUMurYjhN0Y7l5fVYl8hVuGT7Tv2y6Nn6e4HkS3v4sbjKM6Ci8b80w1fz1QH1XtBSKc0NP4
 oGfjxiJUY8qw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 07:29:03 -0700
IronPort-SDR: QYYCSMTHxnMmHUYdTN6qK8Da/qeXWJtpW9hr4z2CR28Woc6Zx24PddrIMX5hFpFjSByE1cBk6A
 Lpx/dB5rmG0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="329180493"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2020 07:29:03 -0700
Received: from [10.249.254.224] (abudanko-mobl.ccr.corp.intel.com [10.249.254.224])
        by linux.intel.com (Postfix) with ESMTP id C813E58077B;
        Fri,  3 Apr 2020 07:29:00 -0700 (PDT)
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
 <20200108160713.GI2844@hirez.programming.kicks-ass.net>
 <4e528ce4-a937-358b-47b6-7d7085ab4eaa@linux.intel.com>
Organization: Intel Corp.
Message-ID: <930384c0-e852-a7bf-cd61-829cb9993234@linux.intel.com>
Date:   Fri, 3 Apr 2020 17:28:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4e528ce4-a937-358b-47b6-7d7085ab4eaa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.04.2020 23:49, Alexey Budankov wrote:
> Hi Peter,
> 
> On 08.01.2020 19:07, Peter Zijlstra wrote:
>> On Wed, Dec 18, 2019 at 12:25:35PM +0300, Alexey Budankov wrote:
>>>
>>> Open access to perf_events monitoring for CAP_SYS_PERFMON privileged
>>> processes. For backward compatibility reasons access to perf_events
>>> subsystem remains open for CAP_SYS_ADMIN privileged processes but
>>> CAP_SYS_ADMIN usage for secure perf_events monitoring is discouraged
>>> with respect to CAP_SYS_PERFMON capability.
>>>
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> ---
>>>  include/linux/perf_event.h | 6 +++---
>>>  kernel/events/core.c       | 6 +++---
>>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index 34c7c6910026..f46acd69425f 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -1285,7 +1285,7 @@ static inline int perf_is_paranoid(void)
>>>  
>>>  static inline int perf_allow_kernel(struct perf_event_attr *attr)
>>>  {
>>> -	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
>>> +	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
>>>  		return -EACCES;
>>>  
>>>  	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
>>> @@ -1293,7 +1293,7 @@ static inline int perf_allow_kernel(struct perf_event_attr *attr)
>>>  
>>>  static inline int perf_allow_cpu(struct perf_event_attr *attr)
>>>  {
>>> -	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
>>> +	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
>>>  		return -EACCES;
>>>  
>>>  	return security_perf_event_open(attr, PERF_SECURITY_CPU);
>>> @@ -1301,7 +1301,7 @@ static inline int perf_allow_cpu(struct perf_event_attr *attr)
>>>  
>>>  static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
>>>  {
>>> -	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
>>> +	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
>>>  		return -EPERM;
>>>  
>>>  	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
>>
>> These are OK I suppose.
>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 059ee7116008..d9db414f2197 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -9056,7 +9056,7 @@ static int perf_kprobe_event_init(struct perf_event *event)
>>>  	if (event->attr.type != perf_kprobe.type)
>>>  		return -ENOENT;
>>>  
>>> -	if (!capable(CAP_SYS_ADMIN))
>>> +	if (!perfmon_capable())
>>>  		return -EACCES;
>>>  
>>>  	/*
>>
>> This one only allows attaching to already extant kprobes, right? It does
>> not allow creation of kprobes.
>>
>>> @@ -9116,7 +9116,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
>>>  	if (event->attr.type != perf_uprobe.type)
>>>  		return -ENOENT;
>>>  
>>> -	if (!capable(CAP_SYS_ADMIN))
>>> +	if (!perfmon_capable())
>>>  		return -EACCES;
>>>  
>>>  	/*
>>
>> Idem, I presume.
>>
>>> @@ -11157,7 +11157,7 @@ SYSCALL_DEFINE5(perf_event_open,
>>>  	}
>>>  
>>>  	if (attr.namespaces) {
>>> -		if (!capable(CAP_SYS_ADMIN))
>>> +		if (!perfmon_capable())
>>>  			return -EACCES;
>>>  	}
>>
>> And given we basically make the entire kernel observable with this CAP,
>> busting namespaces shoulnd't be a problem either.
>>
>> So yeah, I suppose that works.
> 
> Could this have you explicit Reviewed-by or Acked-by tag
> so the changes could be driven into the kernel?
> Latest v7 is here:
> https://lore.kernel.org/lkml/c8de937a-0b3a-7147-f5ef-69f467e87a13@linux.intel.com/

Posted v8 with all acquired tags so far:
https://lore.kernel.org/lkml/f96f8f8a-e65c-3f36-dc85-fc3f5191e8c5@linux.intel.com/

Thanks,
Alexey
