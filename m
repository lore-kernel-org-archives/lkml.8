Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98735C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7398C20752
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCSBOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:14:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:1628 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSBO3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:14:29 -0400
IronPort-SDR: kaAmtRy5a/vPwJNMLOyDwOzyyIY7SWAA1nBrjVEWyLO/0ZoHA4Fjnh8FRqLT3q/x5DCrX+q5mP
 dgBqtYLYUPWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 18:14:29 -0700
IronPort-SDR: 60KqooA82fMLfdFC0i18/UOS1m4ds9rC7PJio6OLSC2iDwekRr/+W86FWS7Wis+dgVpNgiF/l2
 bbRwvXf85xCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="236796397"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2020 18:14:27 -0700
Subject: Re: [PATCH v7 1/3] perf report: Change sort order by a specified
 event in group
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200220013616.19916-1-yao.jin@linux.intel.com>
 <20200220013616.19916-2-yao.jin@linux.intel.com>
 <20200318184535.GK11531@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <5ac67a9a-49e8-ba0d-2adf-5b2fd939332f@linux.intel.com>
Date:   Thu, 19 Mar 2020 09:14:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318184535.GK11531@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2020 2:45 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 20, 2020 at 09:36:14AM +0800, Jin Yao escreveu:
>> When performing "perf report --group", it shows the event group information
>> together. By default, the output is sorted by the first event in group.
>>
>> It would be nice for user to select any event for sorting. This patch
>> introduces a new option "--group-sort-idx" to sort the output by the
>> event at the index n in event group.
>>
>> For example,
>>
>> Before:
> 
> Tested and applied, I also did the following simplifications, to try and
> follow naming conventions and use less lines to do the same thing:
> 
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index 35224b366305..025f4c7f96bf 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -151,44 +151,35 @@ static int field_cmp(u64 field_a, u64 field_b)
>   	return 0;
>   }
>   
> -static int pair_fields_alloc(struct hist_entry *a, struct hist_entry *b,
> -			     hpp_field_fn get_field, int nr_members,
> -			     u64 **fields_a, u64 **fields_b)
> +static int hist_entry__new_pair(struct hist_entry *a, struct hist_entry *b,
> +				hpp_field_fn get_field, int nr_members,
> +				u64 **fields_a, u64 **fields_b)
>   {
> -	struct evsel *evsel;
> +	u64 *fa = calloc(nr_members, sizeof(*fa)),
> +	    *fb = calloc(nr_members, sizeof(*fb));
>   	struct hist_entry *pair;
> -	u64 *fa, *fb;
> -	int ret = -1;
> -
> -	fa = calloc(nr_members, sizeof(*fa));
> -	fb = calloc(nr_members, sizeof(*fb));
>   
>   	if (!fa || !fb)
> -		goto out;
> +		goto out_free;
>   
>   	list_for_each_entry(pair, &a->pairs.head, pairs.node) {
> -		evsel = hists_to_evsel(pair->hists);
> +		struct evsel *evsel = hists_to_evsel(pair->hists);
>   		fa[perf_evsel__group_idx(evsel)] = get_field(pair);
>   	}
>   
>   	list_for_each_entry(pair, &b->pairs.head, pairs.node) {
> -		evsel = hists_to_evsel(pair->hists);
> +		struct evsel *evsel = hists_to_evsel(pair->hists);
>   		fb[perf_evsel__group_idx(evsel)] = get_field(pair);
>   	}
>   
>   	*fields_a = fa;
>   	*fields_b = fb;
> -	ret = 0;
> -
> -out:
> -	if (ret != 0) {
> -		free(fa);
> -		free(fb);
> -		*fields_a = NULL;
> -		*fields_b = NULL;
> -	}
> -
> -	return ret;
> +	return 0;
> +out_free:
> +	free(fa);
> +	free(fb);
> +	*fields_a = *fields_b = NULL;
> +	return -1;
>   }
>   
>   static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
> @@ -206,8 +197,7 @@ static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
>   	if (idx < 1 || idx >= nr_members)
>   		return cmp;
>   
> -	ret = pair_fields_alloc(a, b, get_field, nr_members,
> -				&fields_a, &fields_b);
> +	ret = hist_entry__new_pair(a, b, get_field, nr_members, &fields_a, &fields_b);
>   	if (ret) {
>   		ret = cmp;
>   		goto out;
> @@ -254,8 +244,7 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
>   		return ret;
>   
>   	nr_members = evsel->core.nr_members;
> -	i = pair_fields_alloc(a, b, get_field, nr_members,
> -			      &fields_a, &fields_b);
> +	i = hist_entry__new_pair(a, b, get_field, nr_members, &fields_a, &fields_b);
>   	if (i)
>   		goto out;
>   
> 

Thanks for refining the patch!

Thanks
Jin Yao
