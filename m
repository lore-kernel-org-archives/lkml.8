Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D81320672
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGQDdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:33:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:36174 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgGQDdu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:33:50 -0400
IronPort-SDR: O8qowj2vOxhv9lu+t7MqtLIfFmyOxJ+eP15uPS18Xv+qyDnXTUeyfBWeCew1zvS68iclHxOUm0
 QD8u0/ixU55A==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="234384146"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="234384146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:33:50 -0700
IronPort-SDR: u4UGc5ernv23ce9W5F6Ln9VITLDb+fsoi5jRIYd4dre4UWQd0lgyUDxNILY41enJwRwkk0HEem
 onE7faxJberA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="318646993"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2020 20:33:47 -0700
Subject: Re: [PATCH] perf evsel: Don't set sample_regs_intr/sample_regs_user
 for dummy event
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20200703004215.24418-1-yao.jin@linux.intel.com>
 <20200703110042.GA3282312@krava>
 <9fa0bd83-b21e-7bc2-af81-799f8e99f73b@linux.intel.com>
 <CAP-5=fUjUc7yAA2wyes+DhMkwP9Mw0Lu5gy=XOnugy=vW1jwoQ@mail.gmail.com>
 <b527838b-42e8-b48a-debc-fd91923150d5@linux.intel.com>
Message-ID: <deb02b38-49eb-088d-6ebf-b5396e50c725@linux.intel.com>
Date:   Fri, 17 Jul 2020 11:33:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b527838b-42e8-b48a-debc-fd91923150d5@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/6/2020 8:55 AM, Jin, Yao wrote:
> Hi Ian,
> 
> On 7/6/2020 8:47 AM, Ian Rogers wrote:
>> On Fri, Jul 3, 2020 at 5:31 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>>>
>>> Hi Jiri,
>>>
>>> On 7/3/2020 7:00 PM, Jiri Olsa wrote:
>>>> On Fri, Jul 03, 2020 at 08:42:15AM +0800, Jin Yao wrote:
>>>>> Since commit 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis"),
>>>>> a dummy event is added to capture mmaps.
>>>>>
>>>>> But if we run perf-record as,
>>>>>
>>>>>    # perf record -e cycles:p -IXMM0 -a -- sleep 1
>>>>>    Error:
>>>>>    dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>>>>>
>>
>> Sorry for the breakage caused by modifying the dummy event. Could we
>> add a test to cover the issue? Perhaps in tools/perf/tests/shell/.
>> Trying to reproduce with a register on my skylakex on a 5.6.14 kernel
>> with:
>>
>> $ perf record -e cycles:p -IAX -a -- sleep 1
>>
>> succeeds.
>>
>> Thanks,
>> Ian
>>
> 
> -IAX should be no problem. The issue only occurs on the platform with extended regs supports, such 
> as ICL. So I don't know if it's suitable to add it to perf test suite.
> 
> Thanks
> Jin Yao
> 

Can this fix patch be accepted?

Thanks
Jin Yao

>>>>> The issue is, if we enable the extended regs (-IXMM0), but the
>>>>> pmu->capabilities is not set with PERF_PMU_CAP_EXTENDED_REGS, the kernel
>>>>> will return -EOPNOTSUPP error.
>>>>>
>>>>> See following code pieces.
>>>>>
>>>>> /* in kernel/events/core.c */
>>>>> static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>>>>>
>>>>> {
>>>>>       ....
>>>>>       if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
>>>>>           has_extended_regs(event))
>>>>>               ret = -EOPNOTSUPP;
>>>>>       ....
>>>>> }
>>>>>
>>>>> For software dummy event, the PMU should be not set with
>>>>> PERF_PMU_CAP_EXTENDED_REGS. But unfortunately in current code, the dummy
>>>>> event has possibility to be set with PERF_REG_EXTENDED_MASK bit.
>>>>>
>>>>> In evsel__config, /* tools/perf/util/evsel.c */
>>>>>
>>>>> if (opts->sample_intr_regs) {
>>>>>       attr->sample_regs_intr = opts->sample_intr_regs;
>>>>> }
>>>>>
>>>>> If we use -IXMM0, the attr>sample_regs_intr will be set with
>>>>> PERF_REG_EXTENDED_MASK bit.
>>>>>
>>>>> It doesn't make sense to set attr->sample_regs_intr for a
>>>>> software dummy event.
>>>>>
>>>>> This patch adds dummy event checking before setting
>>>>> attr->sample_regs_intr.
>>>>>
>>>>> After:
>>>>>     # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
>>>>>     [ perf record: Woken up 1 times to write data ]
>>>>>     [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]
>>>>
>>>> LGTM, Adrian (cc-ed) just added another check to the same place,
>>>> but it looks like both of them should be there:
>>>>
>>>>     https://lore.kernel.org/lkml/20200630133935.11150-2-adrian.hunter@intel.com/
>>>>
>>>> jirka
>>>>
>>>
>>> Thanks Jiri! Yes, it looks like both of checks should be added here.
>>>
>>> So do I post v2 (just rebase) once Adrian's patch gets merged?
>>>
>>> Thanks
>>> Jin Yao
>>>
>>>>>
>>>>> Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis")
>>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>>> ---
>>>>>    tools/perf/util/evsel.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>> index 96e5171dce41..df3315543e86 100644
>>>>> --- a/tools/perf/util/evsel.c
>>>>> +++ b/tools/perf/util/evsel.c
>>>>> @@ -1020,12 +1020,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>>>>>       if (callchain && callchain->enabled && !evsel->no_aux_samples)
>>>>>               evsel__config_callchain(evsel, opts, callchain);
>>>>>
>>>>> -    if (opts->sample_intr_regs) {
>>>>> +    if (opts->sample_intr_regs && !is_dummy_event(evsel)) {
>>>>>               attr->sample_regs_intr = opts->sample_intr_regs;
>>>>>               evsel__set_sample_bit(evsel, REGS_INTR);
>>>>>       }
>>>>>
>>>>> -    if (opts->sample_user_regs) {
>>>>> +    if (opts->sample_user_regs && !is_dummy_event(evsel)) {
>>>>>               attr->sample_regs_user |= opts->sample_user_regs;
>>>>>               evsel__set_sample_bit(evsel, REGS_USER);
>>>>>       }
>>>>> -- 
>>>>> 2.17.1
>>>>>
>>>>
