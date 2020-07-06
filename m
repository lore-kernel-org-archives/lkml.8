Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D78C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0FC2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgGFNKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:10:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:60068 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgGFNKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:10:19 -0400
IronPort-SDR: SLj7Mnz2XTPTQ89mJXCQORtU4KMghDkUbVd7xlUL+V2K/3A/1v2k3H5kAX0RJutDGE3SZzyvu6
 bE6QIbkEHYUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127484103"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="127484103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 06:10:18 -0700
IronPort-SDR: 4QI7l/L3S1SdwuCmFTFMu+6dnMHcnOhbm1mqvg4y60IowS0rGap0WYIdcQeIgFNQwqWEizbRxY
 6fBTzu9qh77Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="283033062"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2020 06:10:17 -0700
Received: from [10.249.225.12] (abudanko-mobl.ccr.corp.intel.com [10.249.225.12])
        by linux.intel.com (Postfix) with ESMTP id C9C6B580378;
        Mon,  6 Jul 2020 06:10:15 -0700 (PDT)
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
 <20200706123743.GE3401866@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b43873d9-2b29-23ed-2187-9e2eb31ee587@linux.intel.com>
Date:   Mon, 6 Jul 2020 16:10:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706123743.GE3401866@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.07.2020 15:37, Jiri Olsa wrote:
> On Fri, Jul 03, 2020 at 10:47:22AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  
>>  	while (1) {
>>  		if (forks)
>> @@ -574,11 +610,22 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times, st
>>  		if (done || stop || child_exited)
>>  			break;
>>  
>> -		nanosleep(ts, NULL);
>> -		if (timeout)
>> -			stop = true;
>> -		else
>> -			stop = handle_interval(interval, times);
>> +		clock_gettime(CLOCK_MONOTONIC, &time_start);
>> +		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
>> +			if (timeout)
>> +				stop = true;
>> +			else
>> +				stop = handle_interval(interval, times);
>> +			time_to_sleep = sleep_time;
>> +		} else { /* fd revent */
>> +			stop = process_evlist(evsel_list, interval, times);
>> +			clock_gettime(CLOCK_MONOTONIC, &time_stop);
>> +			diff_timespec(&time_diff, &time_stop, &time_start);
>> +			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
>> +					 time_diff.tv_nsec / NSEC_PER_MSEC;
>> +			if (time_to_sleep < 0)
>> +				time_to_sleep = 0;
> 
> could this computation go to a separate function? something like:
> 
> time_to_sleep = compute_tts(time_start, time_stop);

Accepted. In v10.

Alexey
