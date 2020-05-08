Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794E4C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDC220731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHCpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:45:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:25296 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEHCpa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:45:30 -0400
IronPort-SDR: Ms4l4NaN+mshlkx5cycT5bdzaTYIBJm/QY22whBqGEK/BE0Ek9svPpBX5cG2RMuWVMO+xuMMZ/
 M47E2/8q37Xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 19:45:29 -0700
IronPort-SDR: BrOYFgamPJ3rfr1PPMaGVkVxvFJcfRNYVwGJgtZwT8LWdh2L3yStc2Nknba451K/HT1DTmF4fY
 462cF4/NXJ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="370312768"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 19:45:26 -0700
Subject: Re: [PATCH v3 2/4] perf counts: Reset prev_raw_counts counts
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
 <20200507065822.8255-3-yao.jin@linux.intel.com>
 <20200507151932.GF2804092@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0d7cbbb0-9c35-c6c8-839b-2f12d6ed2808@linux.intel.com>
Date:   Fri, 8 May 2020 10:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200507151932.GF2804092@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/7/2020 11:19 PM, Jiri Olsa wrote:
> On Thu, May 07, 2020 at 02:58:20PM +0800, Jin Yao wrote:
>> The evsel->prev_raw_counts is updated in perf_evsel__compute_deltas:
>>
>> perf_evsel__compute_deltas()
>> {
>> 	tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
>> 	*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
>> }
>>
>> When we want to reset the evsel->prev_raw_counts in
>> perf_evsel__reset_prev_raw_counts, zeroing the aggr is not enough,
>> we need to reset the counts too.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/counts.c | 5 +++++
>>   tools/perf/util/counts.h | 2 ++
>>   tools/perf/util/stat.c   | 1 +
>>   3 files changed, 8 insertions(+)
>>
>> diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
>> index f94e1a23dad6..af3bf36f7c63 100644
>> --- a/tools/perf/util/counts.c
>> +++ b/tools/perf/util/counts.c
>> @@ -64,3 +64,8 @@ void perf_evsel__free_counts(struct evsel *evsel)
>>   	perf_counts__delete(evsel->counts);
>>   	evsel->counts = NULL;
>>   }
>> +
>> +void perf_evsel__reset_raw_counts(struct evsel *evsel)
>> +{
>> +	perf_counts__reset(evsel->prev_raw_counts);
>> +}
>> diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
>> index 92196df4945f..15bb9acb7cb0 100644
>> --- a/tools/perf/util/counts.h
>> +++ b/tools/perf/util/counts.h
>> @@ -42,4 +42,6 @@ void perf_evsel__reset_counts(struct evsel *evsel);
>>   int perf_evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
>>   void perf_evsel__free_counts(struct evsel *evsel);
>>   
>> +void perf_evsel__reset_raw_counts(struct evsel *evsel);
>> +
>>   #endif /* __PERF_COUNTS_H */
>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>> index 774468341851..89e541564ed5 100644
>> --- a/tools/perf/util/stat.c
>> +++ b/tools/perf/util/stat.c
>> @@ -168,6 +168,7 @@ static void perf_evsel__reset_prev_raw_counts(struct evsel *evsel)
>>   		evsel->prev_raw_counts->aggr.val = 0;
>>   		evsel->prev_raw_counts->aggr.ena = 0;
>>   		evsel->prev_raw_counts->aggr.run = 0;
>> +		perf_evsel__reset_raw_counts(evsel);
> 
> that seems needed, but we have it scathered all over the place,
> could you centralize the reset? the way I see it the perf_counts__reset
> should zero all the members of struct perf_counts.. so also
> the aggr values
> 
> it could also check for counts != NULL and we could call it
> instead of:
>    perf_evsel__reset_prev_raw_counts
>      perf_evsel__reset_raw_counts
>        perf_counts__reset
> 
> jirka
> 

While sometime, we may want to only reset evsel->counts and sometime we just 
want to reset the evsel->prev_raw_counts. So maybe we improve 
perf_evsel__reset_counts to:

void perf_evsel__reset_counts(struct evsel *evsel, bool counts, bool 
prev_raw_counts)
{
	if (counts)
		perf_counts__reset(evsel->counts);

	if (prev_raw_counts && evsel->prev_raw_counts);
		perf_counts__reset(evsel->prev_raw_counts);
}

static void perf_counts__reset(struct perf_counts *counts)
{
	counts->aggr.val = 0;
	counts->aggr.ena = 0;
	counts->aggr.run = 0;
	xyarray__reset(counts->loaded);
	xyarray__reset(counts->values);
}

So we will only keep perf_evsel__reset_counts and remove 
perf_evsel__reset_prev_raw_counts.

Thanks
Jin Yao
