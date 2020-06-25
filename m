Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CABC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4C720767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406582AbgFYTcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:32:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:51336 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406116AbgFYTcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:32:35 -0400
IronPort-SDR: L87Y24AbTm1zSuo3jM9hq2lwaK+R+LuXj0tjK1R/Yxh4/A8s1zA/o48s3WyMuotBV73RUgCAMC
 F0OvuO0H4F5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="229771891"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="229771891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 12:32:35 -0700
IronPort-SDR: etYHETo53L1uPh13M3zLNlnSPV2BuCw99dFxHIzzOhgBoNotpSxUwwXkOJDL8cbzRwOXGUCVVV
 jMYptsNm4wjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="479753275"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2020 12:32:35 -0700
Received: from [10.249.229.54] (abudanko-mobl.ccr.corp.intel.com [10.249.229.54])
        by linux.intel.com (Postfix) with ESMTP id DD0915804B4;
        Thu, 25 Jun 2020 12:32:30 -0700 (PDT)
Subject: Re: [PATCH v8 01/13] tools/libperf: avoid moving of fds at
 fdarray__filter() call
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <3d36dc7a-4249-096c-7554-80e6d290eac5@linux.intel.com>
 <fada6325-2e6a-0de4-918f-0bc7d1410c52@linux.intel.com>
 <20200625171405.GL2719003@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <688910f3-289e-d63e-79e3-0a17a6df0e9e@linux.intel.com>
Date:   Thu, 25 Jun 2020 22:32:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625171405.GL2719003@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.06.2020 20:14, Jiri Olsa wrote:
> On Wed, Jun 24, 2020 at 08:19:32PM +0300, Alexey Budankov wrote:
>>
>> On 17.06.2020 11:35, Alexey Budankov wrote:
>>>
>>> Skip fds with zeroed revents field from count and avoid fds moving
>>> at fdarray__filter() call so fds indices returned by fdarray__add()
>>> call stay the same and can be used for direct access and processing
>>> of fd revents status field at entries array of struct fdarray object.
>>>
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> ---
>>>  tools/lib/api/fd/array.c   | 11 +++++------
>>>  tools/perf/tests/fdarray.c | 20 ++------------------
>>>  2 files changed, 7 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
>>> index 58d44d5eee31..97843a837370 100644
>>> --- a/tools/lib/api/fd/array.c
>>> +++ b/tools/lib/api/fd/array.c
>>> @@ -93,22 +93,21 @@ int fdarray__filter(struct fdarray *fda, short revents,
>>>  		return 0;
>>>  
>>>  	for (fd = 0; fd < fda->nr; ++fd) {
>>> +		if (!fda->entries[fd].revents)
>>> +			continue;
>>> +
>>
>> So it looks like this condition also filters out non signaling events fds, not only
>> control and others fds, and this should be somehow avoided so such event related fds
>> would be counted. Several options have been proposed so far:
>>
>> 1) Explicit typing of fds via API extension and filtering based on the types:
>>    a) with separate fdarray__add_stat() call
>>    b) with type arg of existing fdarray__add() call
>>    c) various memory management design is possible
>>
>> 2) Playing tricks with fd positions inside entries and assumptions on fdarray API calls ordering
>>    - looks more like a hack than a designed solution
>>
>> 3) Rewrite of fdarray class to allocate separate object for every added fds
>>    - can be replaced with nonscrewing of fds by __filter()
>>
>> 4) Distinct between fds types at fdarray__filter() using .revents == 0 condition
>>    - seems to have corner cases and thus not applicable
>>
>> 5) Extension of fdarray__poll(, *arg_ptr, arg_size) with arg of fds array to atomically poll
>>    on fdarray_add()-ed fds and external arg fds and then external arg fds processing
>>
>> 6) Rewrite of fdarray class on epoll() call basis
>>    - introduces new scalability restrictions for Perf tool
> 
> hum, how many fds for polling do you expect in your workloads?

Currently it is several hundreds so default of 1K is easily hit and 
"Profile a Large Number of PMU Events on Multi-Core Systems" section [1]
recommends:

soft nofile 65535
hard nofile 65535

for for /etc/security/limits.conf settings.

~Alexey

[1] https://software.intel.com/content/www/us/en/develop/documentation/vtune-cookbook/top/configuration-recipes/profiling-hardware-without-sampling-drivers.html

> 
> jirka
> 
