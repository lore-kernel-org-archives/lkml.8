Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0859C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3E721D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCKFim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:38:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:59689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgCKFim (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:38:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 22:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="389159058"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2020 22:38:38 -0700
Subject: Re: [PATCH v1 02/14] perf util: Create streams for managing top N
 hottest callchains
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
 <20200310070245.16314-3-yao.jin@linux.intel.com>
 <20200310151117.GG15931@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <66542e03-e8b3-14aa-526e-ba3b59ebe076@linux.intel.com>
Date:   Wed, 11 Mar 2020 13:38:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310151117.GG15931@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2020 11:11 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 10, 2020 at 03:02:33PM +0800, Jin Yao escreveu:
>> We think the stream is a callchain which is aggregated by the LBR
>> records from samples. By browsing the stream, we can understand
>> the code flow.
>>
>> The struct callchain_node represents one callchain and we use the
>> callchain_node->hit to measure the hot level of this callchain.
>> Higher is hotter.
>>
>> Since in perf data file, there may be many callchains so we just
>> need to focus on the top N hottest callchains. N is a user defined
>> parameter or just a predefined default value.
>>
>> This patch saves the top N hottest callchains in 'struct stream_node'
>> type array, which is defined in a per event 'struct callchain_streams'.
>>
>> So now we can get the per-event top N hottest callchains.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/callchain.c | 125 ++++++++++++++++++++++++++++++++++++
>>   tools/perf/util/callchain.h |  16 +++++
>>   2 files changed, 141 insertions(+)
>>
>> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
>> index 818aa4efd386..d9c68a8e7619 100644
>> --- a/tools/perf/util/callchain.c
>> +++ b/tools/perf/util/callchain.c
>> @@ -31,6 +31,7 @@
>>   #include "callchain.h"
>>   #include "branch.h"
>>   #include "symbol.h"
>> +#include "evlist.h"
>>   #include "../perf.h"
>>   
>>   #define CALLCHAIN_PARAM_DEFAULT			\
>> @@ -1599,3 +1600,127 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
>>   	for (node = cursor->first; node != NULL; node = node->next)
>>   		map__zput(node->ms.map);
>>   }
>> +
>> +static void free_evsel_streams(struct callchain_streams *callchain_streams,
>> +			       int nr_evsel)
>> +{
>> +	for (int i = 0; i < nr_evsel; i++) {
>> +		if (callchain_streams[i].streams)
>> +			free(callchain_streams[i].streams);
> 
> free(NULL) is valid, so remove that extra check and use zfree() to reset
> that entry to NULL, i.e.:
> 
> 	for ()
> 		zfree(&callchain_streams[i].streams);
> 

Yes, will use zfree() here.

>> +	}
>> +
>> +	free(callchain_streams);
>> +}
>> +
>> +static struct callchain_streams *create_evsel_streams(int nr_evsel,
>> +						      int nr_streams_max)
>> +{
>> +	struct callchain_streams *callchain_streams;
>> +
>> +	callchain_streams = calloc(nr_evsel, sizeof(struct callchain_streams));
> 
> calloc is the right thing here, as this is an array
> 

Yes. If just allocation for one element, I should use zalloc().

Thanks
Jin Yao

>> +	if (!callchain_streams)
>> +		return NULL;
>> +
>> +	for (int i = 0; i < nr_evsel; i++) {
>> +		struct callchain_streams *s = &callchain_streams[i];
>> +
>> +		s->streams = calloc(nr_streams_max, sizeof(struct stream_node));
>> +		if (!s->streams)
>> +			goto err;
>> +
>> +		s->nr_streams_max = nr_streams_max;
>> +		s->evsel_idx = -1;
>> +	}
>> +
>> +	return callchain_streams;
>> +
>> +err:
>> +	free_evsel_streams(callchain_streams, nr_evsel);
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * The cnodes with high hit number are hot callchains.
>> + */
>> +static void set_hot_cnode(struct callchain_streams *s,
>> +			  struct callchain_node *cnode)
>> +{
>> +	int i, idx = 0;
>> +	u64 hit;
>> +
>> +	if (s->nr_streams < s->nr_streams_max) {
>> +		i = s->nr_streams;
>> +		s->streams[i].cnode = cnode;
>> +		s->nr_streams++;
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Since only a few number of hot streams, so only use simple
>> +	 * way to find the cnode with smallest hit number and replace.
>> +	 */
>> +	hit = (s->streams[0].cnode)->hit;
>> +	for (i = 1; i < s->nr_streams; i++) {
>> +		if ((s->streams[i].cnode)->hit < hit) {
>> +			hit = (s->streams[i].cnode)->hit;
>> +			idx = i;
>> +		}
>> +	}
>> +
>> +	if (cnode->hit > hit)
>> +		s->streams[idx].cnode = cnode;
>> +}
>> +
>> +static void update_hot_streams(struct hist_entry *he,
>> +			       struct callchain_streams *s)
>> +{
>> +	struct rb_root *root = &he->sorted_chain;
>> +	struct rb_node *rb_node = rb_first(root);
>> +	struct callchain_node *node;
>> +
>> +	while (rb_node) {
>> +		node = rb_entry(rb_node, struct callchain_node, rb_node);
>> +		set_hot_cnode(s, node);
>> +		rb_node = rb_next(rb_node);
>> +	}
>> +}
>> +
>> +static void get_hot_streams(struct hists *hists,
>> +			    struct callchain_streams *s)
>> +{
>> +	struct rb_node *next;
>> +
>> +	next = rb_first_cached(&hists->entries);
>> +	while (next) {
>> +		struct hist_entry *he;
>> +
>> +		he = rb_entry(next, struct hist_entry, rb_node);
>> +		update_hot_streams(he, s);
>> +		next = rb_next(&he->rb_node);
>> +	}
>> +}
>> +
>> +struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
>> +							 int nr_streams_max,
>> +							 int *nr_evsel_streams)
>> +{
>> +	int nr_evsel = evlist->core.nr_entries, i = 0;
>> +	struct callchain_streams *callchain_streams;
>> +	struct evsel *pos;
>> +
>> +	callchain_streams = create_evsel_streams(nr_evsel, nr_streams_max);
>> +	if (!callchain_streams)
>> +		return NULL;
>> +
>> +	evlist__for_each_entry(evlist, pos) {
>> +		struct hists *hists = evsel__hists(pos);
>> +
>> +		hists__output_resort(hists, NULL);
>> +		get_hot_streams(hists, &callchain_streams[i]);
>> +		callchain_streams[i].evsel_idx = pos->idx;
>> +		i++;
>> +	}
>> +
>> +	*nr_evsel_streams = nr_evsel;
>> +	return callchain_streams;
>> +}
>> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
>> index 706bb7bbe1e1..5852990cdf60 100644
>> --- a/tools/perf/util/callchain.h
>> +++ b/tools/perf/util/callchain.h
>> @@ -13,6 +13,7 @@ struct ip_callchain;
>>   struct map;
>>   struct perf_sample;
>>   struct thread;
>> +struct evlist;
>>   
>>   #define HELP_PAD "\t\t\t\t"
>>   
>> @@ -159,6 +160,17 @@ struct callchain_cursor {
>>   	struct callchain_cursor_node	*curr;
>>   };
>>   
>> +struct stream_node {
>> +	struct callchain_node	*cnode;
>> +};
>> +
>> +struct callchain_streams {
>> +	struct stream_node	*streams;
>> +	int			nr_streams_max;
>> +	int			nr_streams;
>> +	int			evsel_idx;
>> +};
>> +
>>   extern __thread struct callchain_cursor callchain_cursor;
>>   
>>   static inline void callchain_init(struct callchain_root *root)
>> @@ -289,4 +301,8 @@ int callchain_branch_counts(struct callchain_root *root,
>>   			    u64 *branch_count, u64 *predicted_count,
>>   			    u64 *abort_count, u64 *cycles_count);
>>   
>> +struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
>> +							 int nr_streams_max,
>> +							 int *nr_evsel_streams);
>> +
>>   #endif	/* __PERF_CALLCHAIN_H */
>> -- 
>> 2.17.1
>>
> 
