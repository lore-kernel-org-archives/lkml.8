Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16163C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6B12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390970AbgFXNjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:39:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:10524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389611AbgFXNjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:39:19 -0400
IronPort-SDR: 29vLPpoDReOigzDg6aaRI49bTUYj8/c5nTewYWpoArpahm6AickP041WiexXQRtHvInmJwgUer
 kWBgRbhQR7CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="141939957"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="141939957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 06:39:17 -0700
IronPort-SDR: 4Zdq8ORbX3IdwPqMi39+0SaTcyMF34KWKBds5XXVV9vUcCztHeM31yjZxvPI1FeNuV9iwMk9um
 UeVmaHXzkAlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="265076483"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2020 06:39:15 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id 562555805B5;
        Wed, 24 Jun 2020 06:39:12 -0700 (PDT)
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9bf22a7b-0b56-c55f-c8b2-60c8e6ed0ef9@linux.intel.com>
Date:   Wed, 24 Jun 2020 16:39:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623145458.GG2619137@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.06.2020 17:54, Jiri Olsa wrote:
> On Wed, Jun 17, 2020 at 11:41:30AM +0300, Alexey Budankov wrote:
>>
>> Implement handling of 'enable' and 'disable' control commands
>> coming from control file descriptor. process_evlist() function
>> checks for events on control fds and makes required operations.
>> If poll event splits initiated timeout interval then the reminder
>> is calculated and still waited in the following poll() syscall.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-stat.c | 67 +++++++++++++++++++++++++++++----------
>>  1 file changed, 50 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index f88d5ee55022..cc56d71a3ed5 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -492,6 +492,31 @@ static bool process_timeout(int timeout, unsigned int interval, int *times)
>>  	return print_interval(interval, times);
>>  }
>>  
>> +static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
>> +{
>> +	bool stop = false;
>> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
>> +
>> +	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
>> +		switch (cmd) {
>> +		case EVLIST_CTL_CMD_ENABLE:
>> +			pr_info(EVLIST_ENABLED_MSG);
>> +			stop = print_interval(interval, times);
> 
> why is interval printed in here?
> 
>> +			break;
>> +		case EVLIST_CTL_CMD_DISABLE:
>> +			stop = print_interval(interval, times);
> 
> and here?
> 
> it should be called from the main loop when the interval time is elapsed no?

It is called from the main loop too and it is also additionally called here
to provide indication and counter values on commands processing times.

~Alexey

> 
> jirka
> 
