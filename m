Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C282BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A715420775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbgFYQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:01:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:8994 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389860AbgFYQBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:01:23 -0400
IronPort-SDR: wvsPCB3kDduSRBI331zVH+XSJnddDkk8j6qg9DMLt63ATMFG4KCgjRD5i+Xiob9ZqCI41F9yn7
 LkkhiJi7ILZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="210045459"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="210045459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 09:01:12 -0700
IronPort-SDR: CsQygifcDk8DFAey5CQ6LeHuWnnplDbIaS7GGyUPOy5hXwKJNkUbqOCkMF+MZf9XogK5icvkpg
 3IbgctGxI+Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="297634961"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2020 09:01:11 -0700
Received: from [10.249.229.54] (abudanko-mobl.ccr.corp.intel.com [10.249.229.54])
        by linux.intel.com (Postfix) with ESMTP id 0EFE45804D6;
        Thu, 25 Jun 2020 09:01:09 -0700 (PDT)
Subject: Re: [PATCH v8 04/13] perf stat: factor out body of event handling
 loop for system wide
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <eeeff629-925a-530b-9803-f274337ae473@linux.intel.com>
 <20200623145630.GK2619137@krava>
 <51d5511a-e9a7-2865-c81b-57488e820f8d@linux.intel.com>
 <20200625121719.GI2719003@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fdaba173-a046-beae-f8f2-07840c879475@linux.intel.com>
Date:   Thu, 25 Jun 2020 19:01:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625121719.GI2719003@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.06.2020 15:17, Jiri Olsa wrote:
> On Wed, Jun 24, 2020 at 05:27:41PM +0300, Alexey Budankov wrote:
>>
>> On 23.06.2020 17:56, Jiri Olsa wrote:
>>> On Wed, Jun 17, 2020 at 11:37:43AM +0300, Alexey Budankov wrote:
>>>>
>>>> Introduce process_timeout() and process_interval() functions that
>>>> factor out body of event handling loop for attach and system wide
>>>> monitoring use cases.
>>>>
>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> ---
>>>>  tools/perf/builtin-stat.c | 28 ++++++++++++++++++++--------
>>>>  1 file changed, 20 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>> index 9be020e0098a..31f7ccf9537b 100644
>>>> --- a/tools/perf/builtin-stat.c
>>>> +++ b/tools/perf/builtin-stat.c
>>>> @@ -475,6 +475,23 @@ static void process_interval(void)
>>>>  	print_counters(&rs, 0, NULL);
>>>>  }
>>>>  
>>>> +static bool print_interval(unsigned int interval, int *times)
>>>> +{
>>>> +	if (interval) {
>>>> +		process_interval();
>>>> +		if (interval_count && !(--(*times)))
>>>> +			return true;
>>>> +	}
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static bool process_timeout(int timeout, unsigned int interval, int *times)
>>>> +{
>>>> +	if (timeout)
>>>> +		return true;
>>>> +	return print_interval(interval, times);
>>>> +}
>>>
>>> I think it's confusing to keep this together, that
>>> process_timeout triggers also interval processing
>>>
>>> I think you can keep the timeout separated from interval
>>> processing and rename the print_interval to process_interval
>>> and process_interval to __process_interval
>>
>> Well, ok.
>>
>> I will rename process_interval() to __process_interval() and
>> then print_interval() to process_interval().
>>
>> Regarding timeout let's have it like this:
>>
>> static bool process_timeout(int timeout)
>> {
>> 	return timeout ? true : false;
>> }
> 
> can't this just stay as value check after finished poll?
> 
> 	if (timeout)
> 		break;
> 
> and then separate call to process_interval(interval, times)?

Like this? Still makes sense to have it in a single function.

static bool process_timing_settings(int timeout, unsigned int interval, int *times)
{
	bool res = timeout ? true : false;
        if (!res)
 		res = process_interval(interval, times);
 	return res;
}

~Alexey
