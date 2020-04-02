Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A282FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A02072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbgDBPGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:06:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:37176 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbgDBPGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:06:51 -0400
IronPort-SDR: snwEHxhRBeF8lZ7LFcTeE409nSrPgzp7X6CDrd0EzrbqPugLA2Fxt6/DTw5rvy0tvJ77HPrOFN
 h1XGrhurSXXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 08:06:50 -0700
IronPort-SDR: fNlonlI0I89sk9q/XBqo6eeO98honIyGDlA1N2Hj0K9KjBM3a27BXb+O27SLJpc9gexbriXSzV
 PJaQFJA4McOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="396396983"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2020 08:06:50 -0700
Received: from [10.249.226.252] (abudanko-mobl.ccr.corp.intel.com [10.249.226.252])
        by linux.intel.com (Postfix) with ESMTP id B4FA85802C8;
        Thu,  2 Apr 2020 08:06:48 -0700 (PDT)
Subject: Re: [PATCH v1 4/8] perf stat: implement resume and pause control
 commands handling
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
 <20afb83b-efc4-6cba-6512-eebbb4e0707a@linux.intel.com>
 <20200402141740.GO2518490@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6853c0bd-3659-12ce-dfc3-b2d8c655a0d4@linux.intel.com>
Date:   Thu, 2 Apr 2020 18:06:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402141740.GO2518490@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.04.2020 17:17, Jiri Olsa wrote:
> On Fri, Mar 27, 2020 at 11:48:31AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
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
>> @@ -688,18 +745,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
>> -		if (child_pid != -1)
>> +		if (stat_config.ctl_fd == -1 && !interval && !timeout)
>>  			wait4(child_pid, &status, 0, &stat_config.ru_data);
>> +		else
>> +			status = handle_events(child_pid, &stat_config);
>>  
>>  		if (workload_exec_errno) {
>>  			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
>> @@ -711,18 +760,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
> 
> could you please separate the change to have:
>   - factor out the above too loops to the new function
>   - adding control fds handling to that function
> 
> so it's more obvious we don't break anything

Accepted.

~Alexey

