Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB676C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04D42073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgD2LvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:51:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:21491 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2LvT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:51:19 -0400
IronPort-SDR: J2OP1BgeI2AszwR1fhWuUS3EUa8A5b/BngAlde5zLQTBSd9q9nTjPM5+lp83GLobpFNbZL9HLI
 TxeBcwQykc7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 04:50:57 -0700
IronPort-SDR: ZmnLxnuTdWZlaw/i1Am6MGyFdOIqPswoJt5vdE08OfpIb9S8g7E/3NJYjfF5YlSp06fawJrR71
 DwBG1X1POHRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,331,1583222400"; 
   d="scan'208";a="257939108"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.212.103]) ([10.254.212.103])
  by orsmga003.jf.intel.com with ESMTP; 29 Apr 2020 04:50:49 -0700
Subject: Re: [PATCH] perf stat: Fix uncore event mixed metric with workload
 error issue
To:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <20200427144116.27330-1-yao.jin@linux.intel.com>
 <20200428105155.GG1476763@krava>
 <20200428211922.GA874567@tassilo.jf.intel.com>
 <20200429081639.GJ1476763@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a73d121d-d457-fc17-032f-b1b572cad858@linux.intel.com>
Date:   Wed, 29 Apr 2020 19:50:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429081639.GJ1476763@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/29/2020 4:16 PM, Jiri Olsa wrote:
> On Tue, Apr 28, 2020 at 02:19:22PM -0700, Andi Kleen wrote:
>>> I wonder this would break some expectations.. would it be
>>> more safe to detect duration event and bypass it from the
>>> decission? but maybe the case I'm worried about is not a
>>> problem at all.. Andi?
>>
>> Don't see what it would break.
>>
>> Yes maybe we need to special case duration_time more, but that would
>> be a much bigger patch.
> 
> would below change work for you? if duration_time is the only
> case, I'd rather go with the special case for it
> 
> jirka
> 
> 

Just tested, for the case of DRAM_BW_Use, it can work.

root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -- sleep 1

  Performance counter stats for 'system wide':

               9.54 MiB  uncore_imc/cas_count_read/
               3.26 MiB  uncore_imc/cas_count_write/
         1002109793 ns   duration_time

        1.002109793 seconds time elapsed

Thanks
Jin Yao

> ---
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 9207b6c45475..2518204cffd1 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1853,6 +1853,8 @@ static void setup_system_wide(int forks)
>   		struct evsel *counter;
>   
>   		evlist__for_each_entry(evsel_list, counter) {
> +			if (counter->tool_event == PERF_TOOL_DURATION_TIME)
> +				continue;
>   			if (!counter->core.system_wide)
>   				return;
>   		}
> 
