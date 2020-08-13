Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57265C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A07320781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMG5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:57:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:62228 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgHMG5N (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:57:13 -0400
IronPort-SDR: zCC9T4ODmvL+SHLVJ8NMLqpKo7Kfg9CSBzP+gvRHVVgU2wNBitEiCvANjD/gtTC4BQ7j8uL6Xi
 W6sRkUpruvHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="133700482"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="133700482"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 23:57:13 -0700
IronPort-SDR: 7QaemX0bgsLpp343x+ma8ndG/nySUeeL1jprmhLgbtL3ismi4m1I7fzmk51OY/XDbrAyQzneDE
 C5/V2Z/SkIoQ==
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="495764323"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.128]) ([10.238.4.128])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 23:57:10 -0700
Subject: Re: [PATCH] perf parse-events: Set exclude_guest for user-space
 counting
To:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200812065953.22143-1-yao.jin@linux.intel.com>
 <20200812121504.GE13995@kernel.org>
 <74097816-3f36-abea-1eaa-8942aedd7322@linux.intel.com>
 <ab4ae047-ba0b-fed6-36e4-d667e3437e34@linux.intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <75360db6-0574-aef5-8c90-6eb8f2a6afb3@linux.intel.com>
Date:   Thu, 13 Aug 2020 14:57:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ab4ae047-ba0b-fed6-36e4-d667e3437e34@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yao,

On 2020/8/13 11:11, Jin, Yao wrote:
> Hi Like,
> 
> On 8/12/2020 9:02 PM, Like Xu wrote:
>> On 2020/8/12 20:15, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Aug 12, 2020 at 02:59:53PM +0800, Jin Yao escreveu:
>>>> Currently if we run 'perf record -e cycles:u', exclude_guest is 0.
>>>>
>>>> But it doesn't make sense that we request for user-space counting
>>>> but we also get the guest report.
>>>>
>>
>> Please hold the horse and allow this possibility.
>>
>> Some authorized perf users on the host may
>> only want to count (KVM) guest user space events.
>>
>> Thanks,
>> Like Xu
>>
> 
> Without this patch, if we don't set the ":u" modifier, exclude_guest = 1.

It's true for the non ":u" case.

> 
> perf record -e cycles ./div
> perf evlist -v
> cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: 
> IP|TID|TIME|PERIOD, read_format: ID, disabled: 1, inherit: 1, mmap: 1, 
> comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, 
> exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> 
> So this patch doesn't change perf's original behavior.

The patch changes the "perf kvm" original behavior.

Testcase: perf kvm --host --guest --guestkallsyms=guest-kallsyms \
--guestmodules=guest-modules record -e cycles:u ...

From:

cycles:u: size: 120, { sample_period, sample_freq }: 4000, sample_type: 
IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, 
exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1
dummy:HG: type: 1, size: 120, config: 0x9, { sample_period, sample_freq }: 
4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, inherit: 1, 
mmap: 1, comm: 1, freq: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 
1, ksymbol: 1, bpf_event: 1

To:

cycles:u: size: 120, { sample_period, sample_freq }: 4000, sample_type: 
IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, 
exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1,
	
exclude_guest: 1

dummy:HG: type: 1, size: 120, config: 0x9, { sample_period, sample_freq }: 
4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, inherit: 1, 
mmap: 1, comm: 1, freq: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 
1, ksymbol: 1, bpf_event: 1

Thanks,
Like Xu
> 
> Thanks
> Jin Yao
> 
>>>> To keep perf semantics consistent and clear, this patch sets
>>>> exclude_guest for user-space counting.
>>>
>>> Applied, and also added this, that you should consider doing in the
>>> future (modulo the "Committer testing:" header :) ):
>>>
>>> Committer testing:
>>>
>>> Before:
>>>
>>>    # perf record -e cycles:u
>>>    ^C[ perf record: Woken up 1 times to write data ]
>>>    [ perf record: Captured and wrote 1.231 MB perf.data (91 samples) ]
>>>    #
>>>    # perf evlist -v
>>>    cycles:u: size: 120, { sample_period, sample_freq }: 4000, 
>>> sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, 
>>> inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1
>>>    <SNIP>
>>>    #
>>>
>>> After:
>>>
>>>    # perf record -e cycles:u
>>>    ^C[ perf record: Woken up 1 times to write data ]
>>>    [ perf record: Captured and wrote 1.263 MB perf.data (403 samples) ]
>>>    #
>>>    # perf evlist -v
>>>    cycles:u: size: 120, { sample_period, sample_freq }: 4000, 
>>> sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, 
>>> inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1, 
>>> exclude_guest: 1
>>>    #
>>>
>>> ----
>>>
>>> I.e. show actual command output before and after that demonstrates the
>>> problem and then the solution.
>>>
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>> ---
>>>>   tools/perf/util/parse-events.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/tools/perf/util/parse-events.c 
>>>> b/tools/perf/util/parse-events.c
>>>> index 9f7260e69113..4d809f1fe269 100644
>>>> --- a/tools/perf/util/parse-events.c
>>>> +++ b/tools/perf/util/parse-events.c
>>>> @@ -1794,6 +1794,8 @@ static int get_event_modifier(struct 
>>>> event_modifier *mod, char *str,
>>>>           if (*str == 'u') {
>>>>               if (!exclude)
>>>>                   exclude = eu = ek = eh = 1;
>>>> +            if (!exclude_GH)
>>>> +                eG = 1;
>>>>               eu = 0;
>>>>           } else if (*str == 'k') {
>>>>               if (!exclude)
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>

