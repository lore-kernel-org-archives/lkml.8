Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7AFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8027820738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390967AbgFXN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:27:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:9530 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388365AbgFXN1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:27:34 -0400
IronPort-SDR: iJoK++frYMTOh4efWO2QOAjZ1sbV5DX7KAK/aE980u73ZvwTUiCjHo16Fyq+ona96pqNjIYLAp
 0YD3f818uceg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="141937117"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="141937117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 06:27:33 -0700
IronPort-SDR: cThq9LSaBv5fKEdVFLn7tFTuH25KgEDKBA5g3Xz7GgkH8h7JFIZkBPmbgXQukHKloiaIngpn7U
 +2TdYLvrk33A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="265073909"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2020 06:27:33 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id 4DB685805B5;
        Wed, 24 Jun 2020 06:27:28 -0700 (PDT)
Subject: Re: [PATCH v8 07/13] perf stat: factor out event handling loop into
 dispatch_events()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <4d90938c-429a-586c-0cc7-767f804c6bce@linux.intel.com>
 <20200623145622.GJ2619137@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4aa8c212-7bc7-3689-03ad-5ce6fd0e6356@linux.intel.com>
Date:   Wed, 24 Jun 2020 16:27:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623145622.GJ2619137@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.06.2020 17:56, Jiri Olsa wrote:
> On Wed, Jun 17, 2020 at 11:40:03AM +0300, Alexey Budankov wrote:
>>
>> Consolidate event dispatching loops for fork, attach and system
>> wide monitoring use cases into common dispatch_events() function.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-stat.c | 35 ++++++++++++++++++++++++-----------
>>  1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 3bc538576607..39749c290508 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -557,6 +557,27 @@ static bool is_target_alive(struct target *_target,
>>  	return false;
>>  }
>>  
>> +static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
>> +{
>> +	bool stop = false;
>> +	int child = 0, status = 0;
>> +
>> +	while (1) {
>> +		if (forks)
>> +			child = waitpid(child_pid, &status, WNOHANG);
>> +		else
>> +			child = !is_target_alive(&target, evsel_list->core.threads) ? 1 : 0;
> 
> please renme child to something more accurate, so the condition
> below makes more sense, like child_stoped or such

Well, let's have it named like  child_stopped.

~Alexey

> 
> jirka
> 
>> +
>> +		if (done || stop || child)
>> +			break;
>> +
>> +		nanosleep(ts, NULL);
>> +		stop = process_timeout(timeout, interval, times);
>> +	}
>> +
>> +	return status;
>> +}
>> +
> 
> SNIP
> 
