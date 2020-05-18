Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186D8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2D020787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEROpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:45:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:54773 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgEROpE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:45:04 -0400
IronPort-SDR: EF5Lfdgy74IYwQ86r6wmatB8YvQZgY4mOO2VY8Hpc0r5bZlzckU+h0RJG30/qDXn4CzCiDVp7y
 AqOB7iLARSeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 07:45:04 -0700
IronPort-SDR: u5e5rPM4MNDxyUv86aT/GN85X7sYKIzuJJ9PQTchWQ99t3JEN/+ExEJ5A3dAkHVdka8nRL/+6b
 /9izMuLA2scA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="254460697"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.208.114]) ([10.254.208.114])
  by fmsmga008.fm.intel.com with ESMTP; 18 May 2020 07:45:01 -0700
Subject: Re: [PATCH v5 4/5] perf stat: Save aggr value to first member of
 prev_raw_counts
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200514053638.3736-1-yao.jin@linux.intel.com>
 <20200514053638.3736-5-yao.jin@linux.intel.com>
 <20200518124826.GF3726797@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <8ea36c95-3b38-a31e-b05a-41c9ccbada51@linux.intel.com>
Date:   Mon, 18 May 2020 22:44:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518124826.GF3726797@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2020 8:48 PM, Jiri Olsa wrote:
> On Thu, May 14, 2020 at 01:36:37PM +0800, Jin Yao wrote:
>> To collect the overall statistics for interval mode, we copy the
>> counts from evsel->prev_raw_counts to evsel->counts.
>>
>> For AGGR_GLOBAL mode, because the perf_stat_process_counter creates
>> aggr values from per cpu values, but the per cpu values are 0,
>> so the calculated aggr values will be always 0.
>>
>> This patch uses a trick that saves the previous aggr value to
>> the first member of perf_counts, then aggr calculation in
>> process_counter_values can work correctly for AGGR_GLOBAL.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/stat.c | 10 ++++++++++
>>   tools/perf/util/stat.h |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>> index aadc723ce871..fbabdd5b9b62 100644
>> --- a/tools/perf/util/stat.c
>> +++ b/tools/perf/util/stat.c
>> @@ -249,6 +249,16 @@ void perf_evlist__copy_prev_raw_counts(struct evlist *evlist)
>>   		perf_evsel__copy_prev_raw_counts(evsel);
>>   }
>>   
> 
> much better, please put some comments in here explaning wha
> is this for, because it's not obvious ;-)
> 
> thanks,
> jirka
> 

Thanks, I will put some comments in v6.

Thanks
Jin Yao

>> +void perf_evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>> +{
>> +	struct evsel *evsel;
>> +
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		*perf_counts(evsel->prev_raw_counts, 0, 0) =
>> +			evsel->prev_raw_counts->aggr;
>> +	}
>> +}
>> +
>>   static void zero_per_pkg(struct evsel *counter)
>>   {
>>   	if (counter->per_pkg_mask)
>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>> index 62cf72c71869..18ead55756cc 100644
>> --- a/tools/perf/util/stat.h
>> +++ b/tools/perf/util/stat.h
>> @@ -199,6 +199,7 @@ void perf_evlist__free_stats(struct evlist *evlist);
>>   void perf_evlist__reset_stats(struct evlist *evlist);
>>   void perf_evlist__reset_prev_raw_counts(struct evlist *evlist);
>>   void perf_evlist__copy_prev_raw_counts(struct evlist *evlist);
>> +void perf_evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
>>   
>>   int perf_stat_process_counter(struct perf_stat_config *config,
>>   			      struct evsel *counter);
>> -- 
>> 2.17.1
>>
> 
