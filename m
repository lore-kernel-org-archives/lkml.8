Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB34CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5922076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHDHHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:07:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:58093 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHDHHY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:07:24 -0400
IronPort-SDR: pJ3dT/4dtQdX7R/WpTPn8Tr1yy6NIOE1BUB7ey3ug50AIjCXOO+WzDhRomFIvNLhW9uaCYl2Px
 g14dKSTgdvCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="132322612"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="132322612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 00:07:23 -0700
IronPort-SDR: aK3gG8XPUzHf6xw1EIiDqUUENEDtcIUESKPPjTAf4Tw+S2cF+peTsyhA6Lp/wDtxwJtulr+G1v
 r5Y3py+3JUhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="330510365"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2020 00:07:20 -0700
Subject: Re: [PATCH v2] perf evsel: Don't set
 sample_regs_intr/sample_regs_user for dummy event
To:     "Jin, Yao" <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com
References: <20200720010013.18238-1-yao.jin@linux.intel.com>
 <20200720091748.GH760733@krava>
 <af1da971-5c60-4c17-e5d9-01430c928592@linux.intel.com>
 <20200722110810.GD981884@krava>
 <6f732f7f-7c5a-726f-5b09-2c6761f3b534@linux.intel.com>
 <dc2c18fa-85d3-84b7-8eff-53c9d1e61ce5@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <32664190-9a2b-6ce6-3cbc-87b46c85d21e@intel.com>
Date:   Tue, 4 Aug 2020 10:06:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dc2c18fa-85d3-84b7-8eff-53c9d1e61ce5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/20 10:23 am, Jin, Yao wrote:
> Hi Adrian,
> 
> Could you help to check if following condition will break PT?
> 
> "(opts->sample_intr_regs && !evsel->no_aux_samples &&
> !evsel__is_dummy_event(evsel))"

Sorry for slow response - I've been away.

This is fine.  It will not break PT.

no_aux_samples is useful for evsels that have been added by the code rather
than requested by the user.  For old kernels PT adds sched_switch tracepoint
to track context switches (before the current context switch event was
added) and having auxiliary sample information unnecessarily uses up space
in the perf buffer.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Thanks
> Jin Yao
> 
> On 7/23/2020 9:01 AM, Jin, Yao wrote:
>> Hi Jiri, Adrian,
>>
>> On 7/22/2020 7:08 PM, Jiri Olsa wrote:
>>> On Wed, Jul 22, 2020 at 01:00:03PM +0800, Jin, Yao wrote:
>>>
>>> SNIP
>>>
>>>>>>
>>>>>> If we use -IXMM0, the attr>sample_regs_intr will be set with
>>>>>> PERF_REG_EXTENDED_MASK bit.
>>>>>>
>>>>>> It doesn't make sense to set attr->sample_regs_intr for a
>>>>>> software dummy event.
>>>>>>
>>>>>> This patch adds dummy event checking before setting
>>>>>> attr->sample_regs_intr and attr->sample_regs_user.
>>>>>>
>>>>>> After:
>>>>>>     # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
>>>>>>     [ perf record: Woken up 1 times to write data ]
>>>>>>     [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]
>>>>>>
>>>>>>    v2:
>>>>>>    ---
>>>>>>    Rebase to perf/core
>>>>>>
>>>>>> Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide
>>>>>> synthesis")
>>>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>>>> ---
>>>>>>    tools/perf/util/evsel.c | 6 ++++--
>>>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>>> index 9aa51a65593d..11794d3b7879 100644
>>>>>> --- a/tools/perf/util/evsel.c
>>>>>> +++ b/tools/perf/util/evsel.c
>>>>>> @@ -1014,12 +1014,14 @@ void evsel__config(struct evsel *evsel, struct
>>>>>> record_opts *opts,
>>>>>>        if (callchain && callchain->enabled && !evsel->no_aux_samples)
>>>>>>            evsel__config_callchain(evsel, opts, callchain);
>>>>>> -    if (opts->sample_intr_regs && !evsel->no_aux_samples) {
>>>>>> +    if (opts->sample_intr_regs && !evsel->no_aux_samples &&
>>>>>> +        !evsel__is_dummy_event(evsel)) {
>>>>>
>>>>> hum, I thought it'd look something like this:
>>>>>
>>>>>     if (opts->sample_intr_regs && (!evsel->no_aux_samples ||
>>>>> !evsel__is_dummy_event(evsel))
>>>>>
>>>>> but I'm not sure how no_aux_samples flag works exactly.. so it might be
>>>>> correct.. just making sure ;-)
>>>>>
>>>>> cc-ing Adrian
>>>>>
>>>>> jirka
>>>>>
>>>>>
>>>>
>>>> no_aux_samples is set to false by default and it's only set to true by
>>>> pt, right?
>>>>
>>>> So most of the time, !evsel->no_aux_samples is always true.
>>>>
>>>> if (opts->sample_intr_regs && (!evsel->no_aux_samples ||
>>>> !evsel__is_dummy_event(evsel)) {
>>>>     attr->sample_regs_intr = opts->sample_intr_regs;
>>>>     evsel__set_sample_bit(evsel, REGS_INTR);
>>>> }
>>>>
>>>> So even if the evsel is dummy event, the condition check is true. :(
>>>>
>>>> Or maybe I misunderstand anything?
>>>
>>> I was just curious, because I did not follow the no_aux_samples
>>> usage in detail.. so how about a case where:
>>>
>>>     evsel->no_aux_samples == true and evsel__is_dummy_event(evsel) = false
>>>
>>> then the original condition will be false for non dummy event
>>>
>>>    (opts->sample_intr_regs && !evsel->no_aux_samples &&
>>> !evsel__is_dummy_event(evsel))
>>>
>>> is that ok?
>>>
>>
>> I searched the perf source and found the no_aux_samples was only set to
>> true in intel-pt.c. So I assume for the non-pt usage, the no_aux_samples
>> is always false.
>>
>> For non-pt usage,
>> (opts->sample_intr_regs && !evsel->no_aux_samples &&
>> !evsel__is_dummy_event(evsel)) is equal to
>> (opts->sample_intr_regs && !evsel__is_dummy_event(evsel))
>>
>> For pt usage, we need to consider the case that
>> evsel__is_dummy_event(evsel) is true or false.
>>
>> If evsel__is_dummy_event(evsel) is true:
>> (opts->sample_intr_regs && !evsel->no_aux_samples &&
>> !evsel__is_dummy_event(evsel)) is false.
>> It's expected.
>>
>> If evsel__is_dummy_event(evsel) is false:
>> (opts->sample_intr_regs && !evsel->no_aux_samples &&
>> !evsel__is_dummy_event(evsel)) is equal to
>> (opts->sample_intr_regs && !evsel->no_aux_samples)
>> That's the current code logic.
>>
>> So I think the condition "(opts->sample_intr_regs &&
>> !evsel->no_aux_samples && !evsel__is_dummy_event(evsel))" looks reasonable.
>>
>> Adrian, please correct me if I'm wrong here.
>>
>> Thanks
>> Jin Yao
>>
>>> jirka
>>>

