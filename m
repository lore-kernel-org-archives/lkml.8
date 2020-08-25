Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33253C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186D82071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgHYHyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:54:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:45940 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgHYHyt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:54:49 -0400
IronPort-SDR: rdTZaZ7NCphQ0r4r3D/sYMn2fh2BWjL6o65d/dpYjI0RIYC6gf0hbr/BflI4bniLHU+mlt34LS
 ayWwKkL0sD1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="240884052"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="240884052"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 00:54:43 -0700
IronPort-SDR: hbr7OxG1onbyr6DEV/Fio2KK3zGcIVlC0rTP/tOJ9i7ZH/cPJn2KaHb4jTOs/kmGz2Dn2Py5XJ
 8kTdRAzH8kYg==
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="474246202"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 00:54:40 -0700
Subject: Re: [PATCH v3] perf parse-events: Set exclude_guest=1 for user-space
 counting
To:     Like Xu <like.xu@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200814012120.16647-1-yao.jin@linux.intel.com>
 <20200814124722.GG13995@kernel.org>
 <b061052d-592d-67d7-045f-481974b0687a@linux.intel.com>
 <3521b375-6f00-e815-94e5-49eae2a7c989@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <38922f67-9f99-7fdf-1c54-0980020cd111@linux.intel.com>
Date:   Tue, 25 Aug 2020 15:54:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3521b375-6f00-e815-94e5-49eae2a7c989@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 8/19/2020 11:05 AM, Like Xu wrote:
> Hi Arnaldo,
> 
> On 2020/8/17 10:32, Jin, Yao wrote:
>> Hi Arnaldo,
>>
>> On 8/14/2020 8:47 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Aug 14, 2020 at 09:21:20AM +0800, Jin Yao escreveu:
>>>> Currently if we run 'perf record -e cycles:u', exclude_guest=0.
>>>>
>>>> But it doesn't make sense in most cases that we request for
>>>> user-space counting but we also get the guest report.
>>>>
>>>> Of course, we also need to consider perf kvm usage case that
>>>> authorized perf users on the host may only want to count guest
>>>> user space events. For example,
>>>>
>>>> perf kvm --guest record -e cycles:u
>>> Ok, probably this works, but what if I want to record guest user samples
>>> without using 'perf kvm'?
>>>
>>> Can we have a 'U' modifier, perhaps, for that?
>>>
>>> I.e.
>>>
>>> perf record -e cycles:uU would not set exclude_host not exclude_guest,
>>> cycles:u excludes guest user, cycles:U excludes host user, would that be
>>> possible?
>>>
>>> Anyway, I think that with what we have, your patch makes sense, having a
>>> way to, without using 'perf kvm' still be able to sample the guest can
>>> be done on top. of this.
>>>
>>> Xu, can we get your Reviewed-by if this addresses your concerns?
> 
> My concern is about do not break the perf kvm usages and Yao did it in v3.
> 
> Tested-by: Like Xu <like.xu@linux.intel.com>
> 

Can this patch be accepted?

>>>
>>> - Arnaldo
>>
>> Do you suggest we will create a new modifier 'U' as a follow-up patch?
>>
>> cycles:u - Count host user space but it doesn't count the guest user space (exclude_host = 0, 
>> exclude_guest = 1, exclude_kernel = 1, exclude_user = 0, exclude_hv = 1)
>>
>> cycles:U - Count the guest user space but it doesn't count the host user space (exclude_host = 1, 
>> exclude_guest = 0, exclude_kernel = 1, exclude_user = 0, exclude_hv = 1)
>>
>> Is above understanding correct?
> 
> Do we really need to support sample guests without using perf kvm?
> 
> If it's true, I would prefer "cycles:uG" to cover guest user space
> events only, "cycles:kG" to cover guest kernel space events only,
> and only host events are sampled without the ":G" modifier by default.
> 
> I am not sure if ":G" has been used in perf.
>

That may be another good idea I think. :)

Thanks
Jin Yao

> At the very least, this v3 patch may not
> block the follow-up patch from Yao (if any).
> 
> Thanks,
> Like Xu
> 
>>
>> Thanks
>> Jin Yao
> 
