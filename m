Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB993C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFE1208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgCKFoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:44:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:27964 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgCKFoO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:44:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 22:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="389159899"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2020 22:44:11 -0700
Subject: Re: [PATCH v1 05/14] perf util: Calculate the sum of all streams hits
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
 <20200310070245.16314-6-yao.jin@linux.intel.com>
 <20200310151405.GH15931@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a099b2a1-e254-ff3d-77ca-0f2d232389d0@linux.intel.com>
Date:   Wed, 11 Mar 2020 13:44:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310151405.GH15931@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2020 11:14 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 10, 2020 at 03:02:36PM +0800, Jin Yao escreveu:
>> We have used callchain_node->hit to measure the hot level of one
>> stream. This patch calculates the sum of hits of all streams.
>>
>> Then in next patch, we can use following formula to report hot
>> percent for one stream.
>>
>> hot percent = callchain_node->hit / sum of all hits
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/callchain.c | 35 +++++++++++++++++++++++++++++++++++
>>   tools/perf/util/callchain.h |  1 +
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
>> index a9dd91268b00..040995405664 100644
>> --- a/tools/perf/util/callchain.c
>> +++ b/tools/perf/util/callchain.c
>> @@ -1685,6 +1685,39 @@ static void update_hot_streams(struct hist_entry *he,
>>   	}
>>   }
>>   
>> +static u64 count_callchain_hits(struct hist_entry *he)
>> +{
>> +	struct rb_root *root = &he->sorted_chain;
>> +	struct rb_node *rb_node = rb_first(root);
>> +	struct callchain_node *node;
>> +	u64 chain_hits = 0;
>> +
>> +	while (rb_node) {
>> +		node = rb_entry(rb_node, struct callchain_node, rb_node);
>> +		chain_hits += node->hit;
>> +		rb_node = rb_next(rb_node);
>> +	}
>> +
>> +	return chain_hits;
>> +}
>> +
>> +static u64 total_callchain_hits(struct hists *hists)
>> +{
>> +	struct rb_node *next;
>> +	u64 chain_hits = 0;
>> +
>> +	next = rb_first_cached(&hists->entries);
> 
> Try to combine the variable decl line with its initial assignment,
> saving one line, i.e.:
> 
> +static u64 total_callchain_hits(struct hists *hists)
> +{
> +	struct rb_node *next = rb_first_cached(&hists->entries);
> +	u64 chain_hits = 0;
> +

Yes, combining to one line is easy for reading. I will update the code.

>> +	while (next) {
>> +		struct hist_entry *he;
>> +
>> +		he = rb_entry(next, struct hist_entry, rb_node);
> 
> Ditto:
> 
> +		struct hist_entry *he = rb_entry(next, struct hist_entry, rb_node);
> 

Got it.

Thanks
Jin Yao

>> +		chain_hits += count_callchain_hits(he);
>> +		next = rb_next(&he->rb_node);
>> +	}
>> +
>> +	return chain_hits;
>> +}
>> +
>>   static void get_hot_streams(struct hists *hists,
>>   			    struct callchain_streams *s)
>>   {
>> @@ -1698,6 +1731,8 @@ static void get_hot_streams(struct hists *hists,
>>   		update_hot_streams(he, s);
>>   		next = rb_next(&he->rb_node);
>>   	}
>> +
>> +	s->chain_hits = total_callchain_hits(hists);
>>   }
>>   
>>   struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
>> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
>> index c996ab4fb108..3c0e0b45656b 100644
>> --- a/tools/perf/util/callchain.h
>> +++ b/tools/perf/util/callchain.h
>> @@ -173,6 +173,7 @@ struct callchain_streams {
>>   	int			nr_streams_max;
>>   	int			nr_streams;
>>   	int			evsel_idx;
>> +	u64			chain_hits;
>>   };
>>   
>>   extern __thread struct callchain_cursor callchain_cursor;
>> -- 
>> 2.17.1
>>
> 
