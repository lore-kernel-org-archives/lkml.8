Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5874E2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391225AbgFXO1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:27:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:24571 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390161AbgFXO1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:27:46 -0400
IronPort-SDR: 3rSQZum80KgUce0ntlmukb+tubTRWwgB65E9HwMcAcbHbsVqnqH77Jq5HZzdSW2G0VfpeTsc4A
 M12fMgUMKaOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="205977620"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="205977620"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 07:27:45 -0700
IronPort-SDR: IwuspaFTdccUo4/zTDhyS8Lktv94JDXAuCj4abrx1EC9Q7WTqu3raWweEWZFGzdeH1U7kMdkpo
 X1a8XaTXWUHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="263652173"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2020 07:27:44 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id 5667B5805B5;
        Wed, 24 Jun 2020 07:27:42 -0700 (PDT)
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <51d5511a-e9a7-2865-c81b-57488e820f8d@linux.intel.com>
Date:   Wed, 24 Jun 2020 17:27:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623145630.GK2619137@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.06.2020 17:56, Jiri Olsa wrote:
> On Wed, Jun 17, 2020 at 11:37:43AM +0300, Alexey Budankov wrote:
>>
>> Introduce process_timeout() and process_interval() functions that
>> factor out body of event handling loop for attach and system wide
>> monitoring use cases.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-stat.c | 28 ++++++++++++++++++++--------
>>  1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 9be020e0098a..31f7ccf9537b 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -475,6 +475,23 @@ static void process_interval(void)
>>  	print_counters(&rs, 0, NULL);
>>  }
>>  
>> +static bool print_interval(unsigned int interval, int *times)
>> +{
>> +	if (interval) {
>> +		process_interval();
>> +		if (interval_count && !(--(*times)))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static bool process_timeout(int timeout, unsigned int interval, int *times)
>> +{
>> +	if (timeout)
>> +		return true;
>> +	return print_interval(interval, times);
>> +}
> 
> I think it's confusing to keep this together, that
> process_timeout triggers also interval processing
> 
> I think you can keep the timeout separated from interval
> processing and rename the print_interval to process_interval
> and process_interval to __process_interval

Well, ok.

I will rename process_interval() to __process_interval() and
then print_interval() to process_interval().

Regarding timeout let's have it like this:

static bool process_timeout(int timeout)
{
	return timeout ? true : false;
}

static bool process_timing_settings(int timeout, unsigned int interval, int *times)
{
        bool res = process_timeout(timeout);
        if (!res)
		res = process_interval(interval, times);
	return res; 
}

Ok?

~Alexey

> 
> jirka
> 
>> +
>>  static void enable_counters(void)
>>  {
>>  	if (stat_config.initial_delay)
>> @@ -611,6 +628,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>  	struct affinity affinity;
>>  	int i, cpu;
>>  	bool second_pass = false;
>> +	bool stop = false;
>>  
>>  	if (interval) {
>>  		ts.tv_sec  = interval / USEC_PER_MSEC;
>> @@ -805,17 +823,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>  			psignal(WTERMSIG(status), argv[0]);
>>  	} else {
>>  		enable_counters();
>> -		while (!done) {
>> +		while (!done && !stop) {
>>  			nanosleep(&ts, NULL);
>>  			if (!is_target_alive(&target, evsel_list->core.threads))
>>  				break;
>> -			if (timeout)
>> -				break;
>> -			if (interval) {
>> -				process_interval();
>> -				if (interval_count && !(--times))
>> -					break;
>> -			}
>> +			stop = process_timeout(timeout, interval, &times);
>>  		}
>>  	}
>>  
>> -- 
>> 2.24.1
>>
>>
> 
