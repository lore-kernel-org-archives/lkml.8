Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E08C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4096920773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGGNYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:24:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:27899 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGNYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:24:36 -0400
IronPort-SDR: dM4fAHXCSOqiMbwrtsCjvasmO9Vxg3mT62/75zPI/h0MxvUL8iJQzRoSPiZ2mgI5C0Qm285R5r
 iDK4BycGSKmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="165665572"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
   d="scan'208";a="165665572"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 06:24:31 -0700
IronPort-SDR: ZFLeA61xltcZjID7ySDX1uskHp1oMNqGY0bUd/ytzD1NQZXVib6rgc0Jr1dYt7TlsjlKT/K7hD
 kXgudScoqh+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
   d="scan'208";a="305652795"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2020 06:24:32 -0700
Received: from [10.249.228.33] (abudanko-mobl.ccr.corp.intel.com [10.249.228.33])
        by linux.intel.com (Postfix) with ESMTP id 88A6D5807C8;
        Tue,  7 Jul 2020 06:24:29 -0700 (PDT)
Subject: Re: [PATCH v9 11/15] perf stat: implement control commands handling
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
 <20200706123436.GD3401866@krava>
 <6cf91811-ea6a-3c7c-8bbf-7f96bfa1fc82@linux.intel.com>
 <20200706193418.GB3424581@krava>
 <b28806b9-b66e-aa2e-5425-4d9f00341387@linux.intel.com>
 <20200707131403.GD3424581@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <865ad42a-6085-41d6-06d5-730cb9904ce8@linux.intel.com>
Date:   Tue, 7 Jul 2020 16:24:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707131403.GD3424581@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.07.2020 16:14, Jiri Olsa wrote:
> On Tue, Jul 07, 2020 at 04:07:42PM +0300, Alexey Budankov wrote:
>>
>> On 06.07.2020 22:34, Jiri Olsa wrote:
>>> On Mon, Jul 06, 2020 at 05:47:54PM +0300, Alexey Budankov wrote:
>>>>
>>>> On 06.07.2020 15:34, Jiri Olsa wrote:
>>>>> On Fri, Jul 03, 2020 at 10:47:22AM +0300, Alexey Budankov wrote:
>>>>>>
>>>>>> Implement handling of 'enable' and 'disable' control commands
>>>>>> coming from control file descriptor. process_evlist() function
>>>>>> checks for events on control fds and makes required operations.
>>>>>> If poll event splits initiated timeout interval then the reminder
>>>>>> is calculated and still waited in the following poll() syscall.
>>>>>>
>>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>>> ---
>>>>>>  tools/perf/builtin-stat.c | 75 ++++++++++++++++++++++++++++-----------
>>>>>>  1 file changed, 55 insertions(+), 20 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>>>> index 9e4288ecf2b8..5021f7286422 100644
>>>>>> --- a/tools/perf/builtin-stat.c
>>>>>> +++ b/tools/perf/builtin-stat.c
>>>>>> @@ -485,6 +485,31 @@ static bool handle_interval(unsigned int interval, int *times)
>>>>>>  	return false;
>>>>>>  }
>>>>>>  
>>>>>> +static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
>>>>>> +{
>>>>>> +	bool stop = false;
>>>>>> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
>>>>>> +
>>>>>> +	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
>>>>>> +		switch (cmd) {
>>>>>> +		case EVLIST_CTL_CMD_ENABLE:
>>>>>> +			pr_info(EVLIST_ENABLED_MSG);
>>>>>> +			stop = handle_interval(interval, times);
>>>>>> +			break;
>>>>>> +		case EVLIST_CTL_CMD_DISABLE:
>>>>>> +			stop = handle_interval(interval, times);
>>>>>
>>>>> I still don't understand why you call handle_interval in here
>>>>>
>>>>> I don't see it being necessary.. you enable events and handle_interval,
>>>>> wil be called in the next iteration of dispatch_events, why complicate
>>>>> this function with that?
>>>>
>>>> Printing event counts at the moment of command processing lets scripts
>>>> built on top of stat output to provide more plain and accurate metrics.
>>>> Otherwise it may get spikes in the beginning of the next time interval
>>>> because not all counts lay inside [Events enabled, Events disable]
>>>> If -I interval is large tail event count can be also large. Compare the
>>>> output below with the output in the cover letter. Either way is possible
>>>> but the latter one likely complicates the scripts I mentioned above.
>>>>
>>>> perf=tools/perf/perf
>>>> ${perf} stat -D -1 -e cpu-cycles -a -I 1000       \
>>>>              --control fd:${ctl_fd},${ctl_fd_ack} \
>>>>              -- sleep 40 &
>>>>
>>>> Events disabled
>>>> #           time             counts unit events
>>>>      1.001100723      <not counted>      cpu-cycles                                                  
>>>>      2.003146566      <not counted>      cpu-cycles                                                  
>>>>      3.005073317      <not counted>      cpu-cycles                                                  
>>>>      4.006337062      <not counted>      cpu-cycles                                                  
>>>> Events enabled
>>>> enable acked(ack)
>>>>      5.011182000         54,128,692      cpu-cycles <===                                                 
>>>>      6.012300167      3,648,804,827      cpu-cycles                                                  
>>>>      7.013631689        590,438,536      cpu-cycles                                                  
>>>>      8.015558583        406,935,663      cpu-cycles                                                  
>>>>      9.017455505        407,806,862      cpu-cycles                                                  
>>>>     10.019300780        399,351,824      cpu-cycles                                                  
>>>>     11.021180025        404,584,417      cpu-cycles                                                  
>>>>     12.023033661        537,787,981      cpu-cycles                                                  
>>>>     13.024422354        699,395,364      cpu-cycles                                                  
>>>>     14.026325749        397,871,324      cpu-cycles                                                  
>>>> disable acked()
>>>> Events disabled
>>>>     15.027857981        396,956,159      cpu-cycles <===
>>>>     16.029279264      <not counted>      cpu-cycles                                                  
>>>>     17.031131311      <not counted>      cpu-cycles                                                  
>>>>     18.033010580      <not counted>      cpu-cycles                                                  
>>>>     19.034918883      <not counted>      cpu-cycles                                                  
>>>> enable acked(ack)
>>>> Events enabled
>>>>     20.036758793        183,544,975      cpu-cycles <===                                             
>>>>     21.038163289        419,054,544      cpu-cycles                                                  
>>>>     22.040108245        413,993,309      cpu-cycles                                                  
>>>>     23.042042365        403,584,493      cpu-cycles                                                  
>>>>     24.043985381        416,512,094      cpu-cycles                                                  
>>>>     25.045925682        401,513,429      cpu-cycles                                                  
>>>> #           time             counts unit events
>>>>     26.047822238        461,205,096      cpu-cycles                                                  
>>>>     27.049784263        414,319,162      cpu-cycles                                                  
>>>>     28.051745360        403,706,915      cpu-cycles                                                  
>>>>     29.053674600        416,502,883      cpu-cycles                                                  
>>>> disable acked()
>>>> Events disabled
>>>>     30.054750685        414,184,409      cpu-cycles <===
>>>
>>> ok, but we could still take handle_interval out of process_evlist
>>> and the interval process will be more clear for me (with some
>>> additional comments in the code) ... perhaps something like below?
>>>
>>> thanks,
>>> jirka
>>>
>>>
>>> ---
>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>> index 5021f7286422..af83bf6b2db0 100644
>>> --- a/tools/perf/builtin-stat.c
>>> +++ b/tools/perf/builtin-stat.c
>>> @@ -485,19 +485,18 @@ static bool handle_interval(unsigned int interval, int *times)
>>>  	return false;
>>>  }
>>>  
>>> -static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
>>> +static bool process_evlist(struct evlist *evlist)
>>>  {
>>> -	bool stop = false;
>>>  	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
>>> +	bool enabled = false;
>>>  
>>>  	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
>>>  		switch (cmd) {
>>>  		case EVLIST_CTL_CMD_ENABLE:
>>>  			pr_info(EVLIST_ENABLED_MSG);
>>> -			stop = handle_interval(interval, times);
>>> +			enabled = true;
>>>  			break;
>>>  		case EVLIST_CTL_CMD_DISABLE:
>>> -			stop = handle_interval(interval, times);
>>>  			pr_info(EVLIST_DISABLED_MSG);
>>>  			break;
>>>  		case EVLIST_CTL_CMD_ACK:
>>> @@ -507,7 +506,7 @@ static bool process_evlist(struct evlist *evlist, unsigned int interval, int *ti
>>>  		}
>>>  	}
>>>  
>>> -	return stop;
>>> +	return enabled;
>>>  }
>>>  
>>>  static void enable_counters(void)
>>> @@ -618,7 +617,8 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times)
>>>  				stop = handle_interval(interval, times);
>>>  			time_to_sleep = sleep_time;
>>>  		} else { /* fd revent */
>>> -			stop = process_evlist(evsel_list, interval, times);
>>> +			if (process_evlist(evsel_list))
>>> +				stop = handle_interval(interval, times);
>>
>> It will call only on enable command and lead to artificial spikes in the beginning of interval.
>> May be just take handle_interval() out of process_evlist() and have it similar to record case?
> 
> it can be called also for disable case then


Made it like this so now times counter is not affected during commands processing:

static void process_evlist(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
{
	if (evlist__ctlfd_process(evlist, cmd) > 0) {
		switch (*cmd) {
		case EVLIST_CTL_CMD_ENABLE:
			pr_info(EVLIST_ENABLED_MSG);
			break;
		case EVLIST_CTL_CMD_DISABLE:
			pr_info(EVLIST_DISABLED_MSG);
			break;
		case EVLIST_CTL_CMD_ACK:
		case EVLIST_CTL_CMD_UNSUPPORTED:
		default:
			break;
		}
	}
}

...

		clock_gettime(CLOCK_MONOTONIC, &time_start);
		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
			if (timeout)
				break;
			else
				stop = handle_interval(interval, times);
			time_to_sleep = sleep_time;
		} else { /* fd revent */
			process_evlist(evsel_list, &cmd);
			if (interval) {
				switch (cmd) {
				case EVLIST_CTL_CMD_ENABLE:
				case EVLIST_CTL_CMD_DISABLE:
					process_interval();
				case EVLIST_CTL_CMD_ACK:
				case EVLIST_CTL_CMD_UNSUPPORTED:
				default:
					break;
				}
			}
			clock_gettime(CLOCK_MONOTONIC, &time_stop);
			compute_tts(&time_start, &time_stop, &time_to_sleep);
		}

Alexey
