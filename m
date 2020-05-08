Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73588C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508D420731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEHDeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 23:34:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:28185 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgEHDeV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 23:34:21 -0400
IronPort-SDR: ZVb5BR4/fFdSz3dp08JGV2NWP/XbON1nhhspkS40rZG0fba2Syjiv+vqaZhSj32mKZyXPmwN5T
 TclygzRx260A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 20:34:20 -0700
IronPort-SDR: OxsBcQCsMMBaNdaZF0cK8Azjuu9bZ+5MIdmVtCAFfumueltSoquUSWSQ6WzMzeAmE97sdo+LWG
 tTfmpNbFMjjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="370321811"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 20:34:17 -0700
Subject: Re: [PATCH v3 3/4] perf stat: Copy counts from prev_raw_counts to
 evsel->counts
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
 <20200507065822.8255-4-yao.jin@linux.intel.com>
 <20200507151950.GG2804092@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d783c490-e474-ffc7-b388-b6e7734196a6@linux.intel.com>
Date:   Fri, 8 May 2020 11:34:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200507151950.GG2804092@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/7/2020 11:19 PM, Jiri Olsa wrote:
> On Thu, May 07, 2020 at 02:58:21PM +0800, Jin Yao wrote:
>> It would be useful to support the overall statistics for perf-stat
>> interval mode. For example, report the summary at the end of
>> "perf-stat -I" output.
>>
>> But since perf-stat can support many aggregation modes, such as
>> --per-thread, --per-socket, -M and etc, we need a solution which
>> doesn't bring much complexity.
>>
>> The idea is to use 'evsel->prev_raw_counts' which is updated in
>> each interval and it's saved with the latest counts. Before reporting
>> the summary, we copy the counts from evsel->prev_raw_counts to
>> evsel->counts, and next we just follow non-interval processing.
> 
> I did not realize we already store the count in prev_raw_counts ;-) nice catch!
> 

Thanks! :)

>>
>> In evsel__compute_deltas, this patch saves counts to the position
>> of [cpu0,thread0] for AGGR_GLOBAL. After copying counts from
>> evsel->prev_raw_counts to evsel->counts, we don't need to
>> modify process_counter_maps in perf_stat_process_counter to let it
>> work well.
> 
> I don't understand why you need to store it in here.. what's the catch
> in process_counter_maps?
> 

Sorry, I didn't explain clearly.

You know the idea is to copy evsel->prev_raw_counts to evsel->counts before 
reporting the summary.

But for AGGR_GLOBAL (cpu = -1 in perf_evsel__compute_deltas), the 
evsel->prev_raw_counts is only stored with the aggr value.

if (cpu == -1) {
	tmp = evsel->prev_raw_counts->aggr;
	evsel->prev_raw_counts->aggr = *count;
} else {
	tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
	*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
}

So after copying evsel->prev_raw_counts to evsel->counts, 
perf_counts(evsel->counts, cpu, thread) are all 0.

Once we go to process_counter_maps again, in process_counter_values, count->val 
is 0.

case AGGR_GLOBAL:
	aggr->val += count->val;
	aggr->ena += count->ena;
	aggr->run += count->run;

And the aggr->val is 0.

So this patch uses a trick that saves the previous aggr value to cpu0/thread0, 
then above aggr->val calculation can work correctly.

Thanks
Jin Yao

> thanks,
> jirka
> 
