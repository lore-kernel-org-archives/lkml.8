Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDFFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D46208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgE1Brz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:47:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:62093 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgE1Brz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:47:55 -0400
IronPort-SDR: L24yTQKrww9fAaFQW7cmryUiuYkLgt2+GbeUOtzNeXl8WLv9ZKtHwX9k2jStbL0dTjK9rerhCC
 77aPrPmyZQ2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 18:47:52 -0700
IronPort-SDR: b0b5QU3LB8ar+xcFU3rRLap57wrS2qQRqXLqu2EQ1g41g1Ws+OykaEpZSYl4qBZhSwRLuub/V3
 jktUuHeMRA+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="376212752"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2020 18:47:50 -0700
Subject: Re: [PATCH v2 1/2] perf evlist: Ensure grouped events with same cpu
 map
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200525065559.6422-1-yao.jin@linux.intel.com>
 <20200526115155.GE333164@krava>
 <32c4663a-6934-2a2d-79e2-7a335e3629a2@linux.intel.com>
 <d6986a15-1e21-3414-9d68-c265e7db03f4@linux.intel.com>
 <20200527102805.GA420698@krava>
 <19b749fa-fa96-85ac-8c7d-10336ff7475a@linux.intel.com>
 <20200527162800.GC420698@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <06a84164-98e9-f301-756a-a25c09297ae0@linux.intel.com>
Date:   Thu, 28 May 2020 09:47:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527162800.GC420698@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/28/2020 12:28 AM, Jiri Olsa wrote:
> On Wed, May 27, 2020 at 09:49:11PM +0800, Jin, Yao wrote:
>> Hi Jiri,
>>
>> On 5/27/2020 6:28 PM, Jiri Olsa wrote:
>>> On Wed, May 27, 2020 at 02:31:03PM +0800, Jin, Yao wrote:
>>>
>>> SNIP
>>>
>>>>> Thanks
>>>>> Jin Yao
>>>>
>>>> Issue is found!
>>>>
>>>> It looks we can't set "pos->leader = pos" in either for_each_group_member()
>>>> or in for_each_group_evsel() because it may exit the iteration immediately.
>>>>
>>>> 	evlist__for_each_entry(evlist, evsel) {
>>>> 		if (evsel->leader == evsel)
>>>> 			continue;
>>>>
>>>> 		if (cpu_maps_matched(evsel->leader, evsel))
>>>> 			continue;
>>>>
>>>> 		pr_warning("WARNING: event cpu maps are not fully matched, "
>>>> 			   "disable group\n");
>>>>
>>>> 		for_each_group_member(pos, evsel->leader) {
>>>> 			pos->leader = pos;
>>>> 			pos->core.nr_members = 0;
>>>> 		}
>>>>
>>>> Let me use the example of '{cycles,unc_cbo_cache_lookup.any_i}' again.
>>>>
>>>> In evlist:
>>>> cycles,
>>>> unc_cbo_cache_lookup.any_i,
>>>> unc_cbo_cache_lookup.any_i,
>>>> unc_cbo_cache_lookup.any_i,
>>>> unc_cbo_cache_lookup.any_i,
>>>>
>>>> When we reach the for_each_group_member at first time, evsel is the first
>>>> unc_cbo_cache_lookup.any_i and evsel->leader is cycles. pos is same as the
>>>> evsel (the first unc_cbo_cache_lookup.any_i).
>>>>
>>>> Once we execute "pos->leader = pos;", it's actually "evsel->leader = evsel".
>>>> So now evsel->leader is changed to the first unc_cbo_cache_lookup.any_i.
>>>>
>>>> In next iteration, pos is the second unc_cbo_cache_lookup.any_i. pos->leader
>>>> is cycles but unfortunately evsel->leader has been changed to the first
>>>> unc_cbo_cache_lookup.any_i. So iteration stops immediately.
>>>
>>> hum, AFAICS the iteration will not break but continue to next evsel and
>>> pass the 'continue' for another group member.. what do I miss?
>>>
>>> jirka
>>>
>>
>> Let me use this example again.
>>
>> cycles,
>> unc_cbo_cache_lookup.any_i,
>> unc_cbo_cache_lookup.any_i,
>> unc_cbo_cache_lookup.any_i,
>> unc_cbo_cache_lookup.any_i,
>>
>> Yes, once for_each_group_member breaks (due to the issue in 'pos->leader =
>> pos'), evlist__for_each_entry will continue to the second
>> unc_cbo_cache_lookup.any_i. But now evsel->leader != evsel (evsel->leader is
>> "cycles"), so it will go to cpu_maps_matched.
>>
>> But actually we don't need to go to cpu_maps_matched again.
>>
>> for_each_group_member(pos, evsel->leader) {
>> 	pos->leader = pos;
>> 	pos->core.nr_members = 0;
>> }
>>
>> If we solve the issue in above code, for_each_group_member doesn't break,
>> the leaders of all members in this group will be set to themselves.
>>
>> if (evsel->leader == evsel)
>> 	continue;
> 
> I see.. the problem is in the for_each_group_member, how about
> saving the leader into separate variable, like below
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f789103d8306..a754cad3f5a0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -189,6 +189,51 @@ static struct perf_stat_config stat_config = {
>   	.big_num		= true,
>   };
>   
> +static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> +{
> +	if (!a->core.cpus && !b->core.cpus)
> +		return true;
> +
> +	if (!a->core.cpus || !b->core.cpus)
> +		return false;
> +
> +	if (a->core.cpus->nr != b->core.cpus->nr)
> +		return false;
> +
> +	for (int i = 0; i < a->core.cpus->nr; i++) {
> +		if (a->core.cpus->map[i] != b->core.cpus->map[i])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +
> +static void evlist__check_cpu_maps(struct evlist *evlist)
> +{
> +	struct evsel *evsel, *pos, *leader;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		char buf[1024];
> +
> +		leader = evsel->leader;
> +		if (leader == evsel)
> +			continue;
> +		if (cpus_map_matched(leader, evsel))
> +			continue;
> +
> +		evsel__group_desc(leader, buf, sizeof(buf));
> +		WARN_ONCE(1, "WARNING: event cpu maps do not match, disabling group:\n");
> +		pr_warning("  %s\n", buf);
> +
> +		for_each_group_evsel(pos, leader) {
> +			pos->leader = pos;
> +			pos->core.nr_members = 0;
> +		}
> +		evsel->leader->core.nr_members = 0;
> +	}
> +}
> +
>   static inline void diff_timespec(struct timespec *r, struct timespec *a,
>   				 struct timespec *b)
>   {
> @@ -1956,6 +2001,8 @@ int cmd_stat(int argc, const char **argv)
>   	} else if (argc && !strncmp(argv[0], "rep", 3))
>   		return __cmd_report(argc, argv);
>   
> +	evlist__check_cpu_maps(evsel_list);
> +
>   	interval = stat_config.interval;
>   	timeout = stat_config.timeout;
>   
> 

This patch looks good. I guess you will post this patch, right? Thanks so much! :)

Thanks
Jin Yao
