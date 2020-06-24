Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6780DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F4620723
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbgFXOKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:10:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:55876 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388395AbgFXOKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:10:14 -0400
IronPort-SDR: 1Ac6gNhkTP1hrlbKTsO2jEMV9KXo+Tq+IZe0J5+VkfgGTd+B7mlgCuBBGfSnrFKBVozm6Vgsci
 VVF1K5pOLEOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="131908188"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="131908188"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 07:10:14 -0700
IronPort-SDR: t0uIJzxyP/VfGpmEe3QbKxoaX0aTTRDE3lTL/THB5tOhy1M2k4/mqmTIlLz3TOXdGG34AHGUPd
 0/eGk/BTOT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="479272410"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2020 07:10:13 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id A3AC65804D6;
        Wed, 24 Jun 2020 07:10:11 -0700 (PDT)
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
 <20200623145442.GE2619137@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5d6bab4b-d743-609e-e08c-8eabcb9adfef@linux.intel.com>
Date:   Wed, 24 Jun 2020 17:10:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623145442.GE2619137@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.06.2020 17:54, Jiri Olsa wrote:
> On Wed, Jun 17, 2020 at 11:41:30AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  
>>  	while (1) {
>>  		if (forks)
>> @@ -581,8 +617,17 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times, st
>>  		if (done || stop || child)
>>  			break;
>>  
>> -		nanosleep(ts, NULL);
>> -		stop = process_timeout(timeout, interval, times);
>> +		clock_gettime(CLOCK_MONOTONIC, &time_start);
>> +		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
>> +			stop = process_timeout(timeout, interval, times);
>> +			time_to_sleep = sleep_time;
>> +		} else { /* fd revent */
>> +			stop = process_evlist(evsel_list, interval, times);
>> +			clock_gettime(CLOCK_MONOTONIC, &time_stop);
>> +			diff_timespec(&time_diff, &time_stop, &time_start);
>> +			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
>> +					time_diff.tv_nsec / NSEC_PER_MSEC;
> 
> should we check time_to_sleep > time_diff first?

Probably and if time_diff > time_to_sleep then time_to_sleep = 0 ?

~Alexey

> 
> jirka
> 
