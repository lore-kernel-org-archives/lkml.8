Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E495B2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgE0DUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:20:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:30098 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgE0DUq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:20:46 -0400
IronPort-SDR: ggVbxo1AGAtRZljSyyw1YWgxdzqUDWc8XmJIZDILRUI4bnnGJT3NVZHjxtkavtAHxZKSRp6ttp
 eRDRwmytByvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 20:20:46 -0700
IronPort-SDR: 0aMB3LKWY/hO5wWwA7c/OFfmFeaGUSsYhY3Bff8cmgtDPpyI0wVsftjF7LPi4MUfsPuHVQjiSU
 jjhvkP+HWjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="375899075"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2020 20:20:43 -0700
Subject: Re: [PATCH v2 1/2] perf evlist: Ensure grouped events with same cpu
 map
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200525065559.6422-1-yao.jin@linux.intel.com>
 <20200526115155.GE333164@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <32c4663a-6934-2a2d-79e2-7a335e3629a2@linux.intel.com>
Date:   Wed, 27 May 2020 11:20:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526115155.GE333164@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/26/2020 7:51 PM, Jiri Olsa wrote:
> On Mon, May 25, 2020 at 02:55:58PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 2a9de6491700..1161cffc0688 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1704,3 +1704,52 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
>>   	}
>>   	return leader;
>>   }
>> +
>> +static bool cpus_map_matched(struct evsel *prev, struct evsel *evsel)
>> +{
>> +	if (evsel->core.cpus->nr != prev->core.cpus->nr)
>> +		return false;
>> +
>> +	for (int i = 0; i < evsel->core.cpus->nr; i++) {
>> +		if (evsel->core.cpus->map[i] != prev->core.cpus->map[i])
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +bool evlist__cpus_map_matched(struct evlist *evlist)
>> +{
>> +	struct evsel *prev = evlist__first(evlist), *evsel = prev;
>> +	int nr_members = prev->core.nr_members;
>> +
>> +	evlist__for_each_entry_continue(evlist, evsel) {
>> +		if (nr_members <= 1) {
>> +			prev = evsel;
>> +			nr_members = evsel->core.nr_members;
>> +			continue;
>> +		}
>> +
>> +		nr_members--;
>> +
>> +		if (!cpus_map_matched(prev, evsel))
>> +			return false;
>> +
>> +		prev = evsel;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +void evlist__force_disable_group(struct evlist *evlist)
>> +{
>> +	struct evsel *evsel;
>> +
>> +	pr_warning("WARNING: event cpu maps are not fully matched, "
>> +		   "stop event grouping\n");
>> +
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		evsel->leader = evsel;
>> +		evsel->core.nr_members = 0;
>> +	}
>> +}
> 
> I think this is too much, we need to disable only groups with not
> matching cpus, not all of them, how about something like this
> 

Yes, that's too much.

> 
>          struct evsel *pos;
> 
>          evlist__for_each_entry(evlist, evsel) {
>                  if (evsel->leader == evsel)
>                          continue;
>                  if (!cpus_map_matched(evsel->leader, evsel))
>                          continue;
>                          
>                  pr_warn("Disabling group...
> 
>                  for_each_group_member(pos, evsel->leader) {
>                          pos->leader = pos;
>                          evsel->core.nr_members = 0;
>                  }
>          }
> 
> jirka
> 

Hmm, change "!cpus_map_matched()" to "cpus_map_matched()"? and use for_each_group_evsel() to replace 
for_each_group_member()?

How about something like following?

void evlist__check_cpu_maps(struct evlist *evlist)
{
	struct evsel *evsel, *pos;

	evlist__for_each_entry(evlist, evsel) {
		if (evsel->leader == evsel)
			continue;

		if (cpu_maps_matched(evsel->leader, evsel))
			continue;

		pr_warning("WARNING: event cpu maps are not fully matched, "
			   "disable group\n");

		for_each_group_evsel(pos, evsel->leader) {
			pos->leader = pos;
			pos->core.nr_members = 0;
		}

		/*
		 * For core & uncore mixed event group, for example,
		 * '{cycles,unc_cbo_cache_lookup.any_i}',
		 * In evlist:
		 * cycles,
		 * unc_cbo_cache_lookup.any_i,
		 * unc_cbo_cache_lookup.any_i,
		 * unc_cbo_cache_lookup.any_i,
		 * unc_cbo_cache_lookup.any_i,
		 *
		 * cycles is leader and all unc_cbo_cache_lookup.any_i
		 * point to this leader. But for_each_group_evsel can't
		 * iterate all members from cycles. It only iterates
		 * cycles and one unc_cbo_cache_lookup.any_i. So we
		 * set extra evsel here.
		 */
		evsel->leader = evsel;
		evsel->core.nr_members = 0;
	}
}

Thanks
Jin Yao
