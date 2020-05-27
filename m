Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D775AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E942078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbgE0NtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:49:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:11584 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388082AbgE0NtQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:49:16 -0400
IronPort-SDR: skwNYpY2nv5y9Rb7FpdaO7a/4EJMagyL5aFF3No1K/JPqdCN6bjP2UvdIUPxdkoDQqsd0xbXRZ
 zP1dFb2WgO/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 06:49:15 -0700
IronPort-SDR: BxuuS2MK37yuMLoYpwK5GiQeXD2f446GJqObQzqghFwZHQZmX52Hj7YLDLysoE/hGrPqz8cs0E
 XOwQzQB4EQtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="376032251"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.213.129]) ([10.254.213.129])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2020 06:49:12 -0700
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <19b749fa-fa96-85ac-8c7d-10336ff7475a@linux.intel.com>
Date:   Wed, 27 May 2020 21:49:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527102805.GA420698@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/27/2020 6:28 PM, Jiri Olsa wrote:
> On Wed, May 27, 2020 at 02:31:03PM +0800, Jin, Yao wrote:
> 
> SNIP
> 
>>> Thanks
>>> Jin Yao
>>
>> Issue is found!
>>
>> It looks we can't set "pos->leader = pos" in either for_each_group_member()
>> or in for_each_group_evsel() because it may exit the iteration immediately.
>>
>> 	evlist__for_each_entry(evlist, evsel) {
>> 		if (evsel->leader == evsel)
>> 			continue;
>>
>> 		if (cpu_maps_matched(evsel->leader, evsel))
>> 			continue;
>>
>> 		pr_warning("WARNING: event cpu maps are not fully matched, "
>> 			   "disable group\n");
>>
>> 		for_each_group_member(pos, evsel->leader) {
>> 			pos->leader = pos;
>> 			pos->core.nr_members = 0;
>> 		}
>>
>> Let me use the example of '{cycles,unc_cbo_cache_lookup.any_i}' again.
>>
>> In evlist:
>> cycles,
>> unc_cbo_cache_lookup.any_i,
>> unc_cbo_cache_lookup.any_i,
>> unc_cbo_cache_lookup.any_i,
>> unc_cbo_cache_lookup.any_i,
>>
>> When we reach the for_each_group_member at first time, evsel is the first
>> unc_cbo_cache_lookup.any_i and evsel->leader is cycles. pos is same as the
>> evsel (the first unc_cbo_cache_lookup.any_i).
>>
>> Once we execute "pos->leader = pos;", it's actually "evsel->leader = evsel".
>> So now evsel->leader is changed to the first unc_cbo_cache_lookup.any_i.
>>
>> In next iteration, pos is the second unc_cbo_cache_lookup.any_i. pos->leader
>> is cycles but unfortunately evsel->leader has been changed to the first
>> unc_cbo_cache_lookup.any_i. So iteration stops immediately.
> 
> hum, AFAICS the iteration will not break but continue to next evsel and
> pass the 'continue' for another group member.. what do I miss?
> 
> jirka
> 

Let me use this example again.

cycles,
unc_cbo_cache_lookup.any_i,
unc_cbo_cache_lookup.any_i,
unc_cbo_cache_lookup.any_i,
unc_cbo_cache_lookup.any_i,

Yes, once for_each_group_member breaks (due to the issue in 'pos->leader = pos'), 
evlist__for_each_entry will continue to the second unc_cbo_cache_lookup.any_i. But now evsel->leader 
!= evsel (evsel->leader is "cycles"), so it will go to cpu_maps_matched.

But actually we don't need to go to cpu_maps_matched again.

for_each_group_member(pos, evsel->leader) {
	pos->leader = pos;
	pos->core.nr_members = 0;
}

If we solve the issue in above code, for_each_group_member doesn't break, the leaders of all members 
in this group will be set to themselves.

if (evsel->leader == evsel)
	continue;

So the iteration will continue to the next evsel.

Thanks
Jin Yao
