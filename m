Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1941C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B33206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgFAHiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:38:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:18830 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgFAHix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:38:53 -0400
IronPort-SDR: RO+u2b1ILQCR87Orlc5/P0Ml/wyyGwWOiNGw9w5XRMvSU70T6PG05NmYTdNaJy0KPOSjcCbCOz
 dYn4zQpFYxwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 00:38:53 -0700
IronPort-SDR: oTr7efKpF1LBjHvugbQV1jWKZFQHAaTL2jTKz+wm3tcKNJ7aiGxoJfVQzn6M6RA9Ecb/xFUEFt
 WRaVUcnQIfiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,460,1583222400"; 
   d="scan'208";a="271912796"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2020 00:38:53 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 45D39580522;
        Mon,  1 Jun 2020 00:38:50 -0700 (PDT)
Subject: Re: [PATCH v4 04/10] perf stat: factor out event handling loop into a
 function
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
 <5f42c6c5-c301-accd-928e-4304fb1c15d0@linux.intel.com>
 <20200531181905.GB881900@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <63f1e2dd-ca1d-125a-cb83-d89f40433edc@linux.intel.com>
Date:   Mon, 1 Jun 2020 10:38:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200531181905.GB881900@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31.05.2020 21:19, Jiri Olsa wrote:
> On Mon, May 25, 2020 at 05:19:45PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> @@ -544,12 +598,10 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
>>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>  {
>>  	int interval = stat_config.interval;
>> -	int times = stat_config.times;
>>  	int timeout = stat_config.timeout;
>>  	char msg[BUFSIZ];
>>  	unsigned long long t0, t1;
>>  	struct evsel *counter;
>> -	struct timespec ts;
>>  	size_t l;
>>  	int status = 0;
>>  	const bool forks = (argc > 0);
>> @@ -558,17 +610,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>  	int i, cpu;
>>  	bool second_pass = false;
>>  
>> -	if (interval) {
>> -		ts.tv_sec  = interval / USEC_PER_MSEC;
>> -		ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
>> -	} else if (timeout) {
>> -		ts.tv_sec  = timeout / USEC_PER_MSEC;
>> -		ts.tv_nsec = (timeout % USEC_PER_MSEC) * NSEC_PER_MSEC;
>> -	} else {
>> -		ts.tv_sec  = 1;
>> -		ts.tv_nsec = 0;
>> -	}
>> -
>>  	if (forks) {
>>  		if (perf_evlist__prepare_workload(evsel_list, &target, argv, is_pipe,
>>  						  workload_exec_failed_signal) < 0) {
>> @@ -725,16 +766,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>  		perf_evlist__start_workload(evsel_list);
>>  		enable_counters();
>>  
>> -		if (interval || timeout) {
>> -			while (!waitpid(child_pid, &status, WNOHANG)) {
>> -				nanosleep(&ts, NULL);
>> -				if (timeout)
>> -					break;
>> -				process_interval();
>> -				if (interval_count && !(--times))
>> -					break;
>> -			}
>> -		}
>> +		if (interval || timeout)
>> +			dispatch_events(child_pid, &stat_config);
>> +
>>  		if (child_pid != -1) {
>>  			if (timeout)
>>  				kill(child_pid, SIGTERM);
>> @@ -751,18 +785,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>  			psignal(WTERMSIG(status), argv[0]);
>>  	} else {
>>  		enable_counters();
>> -		while (!done) {
>> -			nanosleep(&ts, NULL);
>> -			if (!is_target_alive(&target, evsel_list->core.threads))
>> -				break;
>> -			if (timeout)
>> -				break;
>> -			if (interval) {
>> -				process_interval();
>> -				if (interval_count && !(--times))
>> -					break;
>> -			}
>> -		}
>> +		dispatch_events(-1, &stat_config);
> 
> hum, from the discussion we had on v3  I expected more smaller patches
> with easy changes, so the change is more transparent and easy to review
> 
> as I said before this part really makes me worried and needs to be as clear
> as possible.. please introdce the new function first and replace the factored
> places separately, also more verbose changelog would help ;-)

Ok. Will try to reshape the patch that way.

~Alexey
