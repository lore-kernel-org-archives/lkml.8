Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F092C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631992070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgGFNIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:08:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:60362 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgGFNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:08:00 -0400
IronPort-SDR: PAUZQ4jXmiTfEPef6XXj32r3N08D+GF9xHWioZtT4ElwZNhDKnTx8BkDqe2OJLi0bJnhoEvV/v
 grjTFT3OZE/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="148907933"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="148907933"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 06:08:00 -0700
IronPort-SDR: d6CGC1Xspusv/7UecsX08VdaFWTPpZODBPwIKLGeYXPYQVon6+IBZqHzJBbQTN0r3P+5+2I0SK
 xpkv3X2yCcww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="305291735"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2020 06:07:59 -0700
Received: from [10.249.225.12] (abudanko-mobl.ccr.corp.intel.com [10.249.225.12])
        by linux.intel.com (Postfix) with ESMTP id 67800580378;
        Mon,  6 Jul 2020 06:07:56 -0700 (PDT)
Subject: Re: [PATCH v9 09/15] perf stat: factor out event handling loop into
 dispatch_events()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <e4ccb3e9-5f5e-36bf-4a87-dd9d7098d83b@linux.intel.com>
 <20200706122717.GC3401866@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6af18510-0a01-f2a6-bc5c-27ee3283f3ad@linux.intel.com>
Date:   Mon, 6 Jul 2020 16:07:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706122717.GC3401866@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.07.2020 15:27, Jiri Olsa wrote:
> On Fri, Jul 03, 2020 at 10:46:15AM +0300, Alexey Budankov wrote:
>>
>> Consolidate event dispatching loops for fork, attach and system
>> wide monitoring use cases into common dispatch_events() function.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-stat.c | 42 +++++++++++++++++++++++++--------------
>>  1 file changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 3e11f854ffc8..723f1fe27d63 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -550,6 +550,30 @@ static bool is_target_alive(struct target *_target,
>>  	return false;
>>  }
>>  
>> +static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
>> +{
>> +	bool stop = false;
>> +	int child_exited = 0, status = 0;
>> +
>> +	while (1) {
>> +		if (forks)
>> +			child_exited = waitpid(child_pid, &status, WNOHANG);
>> +		else
>> +			child_exited = !is_target_alive(&target, evsel_list->core.threads) ? 1 : 0;
>> +
>> +		if (done || stop || child_exited)
>> +			break;
> 
> can (done || stop) be in the while condition and
> we'd check just child_exited in here?
> 
>> +
>> +		nanosleep(ts, NULL);
>> +		if (timeout)
>> +			stop = true;
> 
> can we just break out in here? like the original code?
> I don't think we need the extra iteration
> 
>> +		else
>> +			stop = handle_interval(interval, times);
> 
> same here..?

Accepted. In v10.

Alexey
