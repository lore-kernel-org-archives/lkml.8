Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B383C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2C7207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGVFAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:00:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:25846 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgGVFAK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:00:10 -0400
IronPort-SDR: U+erDAPj+ce9X+5x9tt5QXpP8eYjU6uF3EUSlaN0E19/iBnxDovEPcWG7v3cqiXWL2klctH4NV
 +LGO/sLHtDoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="130353883"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="130353883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 22:00:07 -0700
IronPort-SDR: Pngk4cExt1fTFdLWchrpLWJAVnwmCqbt75wTcYzAc2lbuOMll1iTVWz4G8DRfprseH56LMhe2u
 Pou+XqJMKBng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="328101117"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2020 22:00:04 -0700
Subject: Re: [PATCH v2] perf evsel: Don't set
 sample_regs_intr/sample_regs_user for dummy event
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20200720010013.18238-1-yao.jin@linux.intel.com>
 <20200720091748.GH760733@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <af1da971-5c60-4c17-e5d9-01430c928592@linux.intel.com>
Date:   Wed, 22 Jul 2020 13:00:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720091748.GH760733@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 7/20/2020 5:17 PM, Jiri Olsa wrote:
> On Mon, Jul 20, 2020 at 09:00:13AM +0800, Jin Yao wrote:
>> Since commit 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis"),
>> a dummy event is added to capture mmaps.
>>
>> But if we run perf-record as,
>>
>>   # perf record -e cycles:p -IXMM0 -a -- sleep 1
>>   Error:
>>   dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>>
>> The issue is, if we enable the extended regs (-IXMM0), but the
>> pmu->capabilities is not set with PERF_PMU_CAP_EXTENDED_REGS, the kernel
>> will return -EOPNOTSUPP error.
>>
>> See following code:
>>
>> /* in kernel/events/core.c */
>> static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>>
>> {
>>          ....
>>          if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
>>              has_extended_regs(event))
>>                  ret = -EOPNOTSUPP;
>>          ....
>> }
>>
>> For software dummy event, the PMU should not be set with
>> PERF_PMU_CAP_EXTENDED_REGS. But unfortunately now, the dummy
>> event has possibility to be set with PERF_REG_EXTENDED_MASK bit.
>>
>> In evsel__config, /* tools/perf/util/evsel.c */
>>
>> if (opts->sample_intr_regs) {
>>          attr->sample_regs_intr = opts->sample_intr_regs;
>> }
>>
>> If we use -IXMM0, the attr>sample_regs_intr will be set with
>> PERF_REG_EXTENDED_MASK bit.
>>
>> It doesn't make sense to set attr->sample_regs_intr for a
>> software dummy event.
>>
>> This patch adds dummy event checking before setting
>> attr->sample_regs_intr and attr->sample_regs_user.
>>
>> After:
>>    # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]
>>
>>   v2:
>>   ---
>>   Rebase to perf/core
>>
>> Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis")
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/evsel.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 9aa51a65593d..11794d3b7879 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1014,12 +1014,14 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>>   	if (callchain && callchain->enabled && !evsel->no_aux_samples)
>>   		evsel__config_callchain(evsel, opts, callchain);
>>   
>> -	if (opts->sample_intr_regs && !evsel->no_aux_samples) {
>> +	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
>> +	    !evsel__is_dummy_event(evsel)) {
> 
> hum, I thought it'd look something like this:
> 
>    if (opts->sample_intr_regs && (!evsel->no_aux_samples || !evsel__is_dummy_event(evsel))
> 
> but I'm not sure how no_aux_samples flag works exactly.. so it might be
> correct.. just making sure ;-)
> 
> cc-ing Adrian
> 
> jirka
> 
> 

no_aux_samples is set to false by default and it's only set to true by pt, right?

So most of the time, !evsel->no_aux_samples is always true.

if (opts->sample_intr_regs && (!evsel->no_aux_samples || !evsel__is_dummy_event(evsel)) {
	attr->sample_regs_intr = opts->sample_intr_regs;
	evsel__set_sample_bit(evsel, REGS_INTR);
}

So even if the evsel is dummy event, the condition check is true. :(

Or maybe I misunderstand anything?

Thanks
Jin Yao

>>   		attr->sample_regs_intr = opts->sample_intr_regs;
>>   		evsel__set_sample_bit(evsel, REGS_INTR);
>>   	}
>>   
>> -	if (opts->sample_user_regs && !evsel->no_aux_samples) {
>> +	if (opts->sample_user_regs && !evsel->no_aux_samples &&
>> +	    !evsel__is_dummy_event(evsel)) {
>>   		attr->sample_regs_user |= opts->sample_user_regs;
>>   		evsel__set_sample_bit(evsel, REGS_USER);
>>   	}
>> -- 
>> 2.17.1
>>
> 
