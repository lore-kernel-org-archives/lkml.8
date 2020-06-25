Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F82C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0958820768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405457AbgFYOwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:52:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:53483 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405385AbgFYOwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:52:23 -0400
IronPort-SDR: I5/g2OrUKPHX3/z1mMo+t0vURMI86KgCxJUflk5T+ku6G2nUaVZ4r7OYvJfAuHisPghVytygJE
 +0kvZWL0xY+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="132349991"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="132349991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 07:52:21 -0700
IronPort-SDR: 7/qhnrTE8F52QUrj2cNi185t2jut9xND9SEOHzcRmsPXv5GsfNRw65ZjV2Hr9Xj7SP1LBMcUEk
 oyH+9a10HeSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="312010769"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2020 07:52:20 -0700
Received: from [10.249.229.54] (abudanko-mobl.ccr.corp.intel.com [10.249.229.54])
        by linux.intel.com (Postfix) with ESMTP id D9D195804D6;
        Thu, 25 Jun 2020 07:52:18 -0700 (PDT)
Subject: Re: [PATCH v8 09/13] perf stat: implement control commands handling
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <5ed69a1e-052a-9790-7642-cb9c9a53d786@linux.intel.com>
 <20200623145458.GG2619137@krava>
 <9bf22a7b-0b56-c55f-c8b2-60c8e6ed0ef9@linux.intel.com>
 <20200625121218.GG2719003@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b3c7ab03-d2ba-ac60-fd45-42cfb5b57a28@linux.intel.com>
Date:   Thu, 25 Jun 2020 17:52:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625121218.GG2719003@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2020 15:12, Jiri Olsa wrote:
> On Wed, Jun 24, 2020 at 04:39:11PM +0300, Alexey Budankov wrote:
>>
>>
>> On 23.06.2020 17:54, Jiri Olsa wrote:
>>> On Wed, Jun 17, 2020 at 11:41:30AM +0300, Alexey Budankov wrote:
>>>>
>>>> Implement handling of 'enable' and 'disable' control commands
>>>> coming from control file descriptor. process_evlist() function
>>>> checks for events on control fds and makes required operations.
>>>> If poll event splits initiated timeout interval then the reminder
>>>> is calculated and still waited in the following poll() syscall.
>>>>
>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> ---
>>>>  tools/perf/builtin-stat.c | 67 +++++++++++++++++++++++++++++----------
>>>>  1 file changed, 50 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>> index f88d5ee55022..cc56d71a3ed5 100644
>>>> --- a/tools/perf/builtin-stat.c
>>>> +++ b/tools/perf/builtin-stat.c
>>>> @@ -492,6 +492,31 @@ static bool process_timeout(int timeout, unsigned int interval, int *times)
>>>>  	return print_interval(interval, times);
>>>>  }
>>>>  
>>>> +static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
>>>> +{
>>>> +	bool stop = false;
>>>> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
>>>> +
>>>> +	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
>>>> +		switch (cmd) {
>>>> +		case EVLIST_CTL_CMD_ENABLE:
>>>> +			pr_info(EVLIST_ENABLED_MSG);
>>>> +			stop = print_interval(interval, times);
>>>
>>> why is interval printed in here?
>>>
>>>> +			break;
>>>> +		case EVLIST_CTL_CMD_DISABLE:
>>>> +			stop = print_interval(interval, times);
>>>
>>> and here?
>>>
>>> it should be called from the main loop when the interval time is elapsed no?
>>
>> It is called from the main loop too and it is also additionally called here
>> to provide indication and counter values on commands processing times.
> 
> so it prints interval out of order?

Looks like it does. The only issue with it I see is change in times value.

~Alexey

> 
> jirka
> 
