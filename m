Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02262C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71142071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQIa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:30:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:18659 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQIaZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:30:25 -0400
IronPort-SDR: HxekXXhi6DoOlG1zroLV4fsvncdXV2U9p6slQaiTk7lrg3iPyjVW4+JEaCDlUwXDFVqDeFuRXK
 Za0+E4f/zK9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="234407702"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="234407702"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 01:30:24 -0700
IronPort-SDR: w8WkAX0oZ+Gqf+zvSRh0270fwmCdV+UjPlxxsIMM4nsAoB+3EjXO3S/KDWM0zDHgOuvB56mbml
 5g4UxdXP0PWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="318705545"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2020 01:30:22 -0700
Subject: Re: [PATCH] perf evsel: Don't set sample_regs_intr/sample_regs_user
 for dummy event
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
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
 <deb02b38-49eb-088d-6ebf-b5396e50c725@linux.intel.com>
 <20200717082412.GA522549@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d6af19b3-a766-0c4a-a9fe-332f4b05aa72@linux.intel.com>
Date:   Fri, 17 Jul 2020 16:30:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717082412.GA522549@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 4:24 PM, Jiri Olsa wrote:
> On Fri, Jul 17, 2020 at 11:33:46AM +0800, Jin, Yao wrote:
>> Hi,
>>
>> On 7/6/2020 8:55 AM, Jin, Yao wrote:
>>> Hi Ian,
>>>
>>> On 7/6/2020 8:47 AM, Ian Rogers wrote:
>>>> On Fri, Jul 3, 2020 at 5:31 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>>>>>
>>>>> Hi Jiri,
>>>>>
>>>>> On 7/3/2020 7:00 PM, Jiri Olsa wrote:
>>>>>> On Fri, Jul 03, 2020 at 08:42:15AM +0800, Jin Yao wrote:
>>>>>>> Since commit 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis"),
>>>>>>> a dummy event is added to capture mmaps.
>>>>>>>
>>>>>>> But if we run perf-record as,
>>>>>>>
>>>>>>>     # perf record -e cycles:p -IXMM0 -a -- sleep 1
>>>>>>>     Error:
>>>>>>>     dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>>>>>>>
>>>>
>>>> Sorry for the breakage caused by modifying the dummy event. Could we
>>>> add a test to cover the issue? Perhaps in tools/perf/tests/shell/.
>>>> Trying to reproduce with a register on my skylakex on a 5.6.14 kernel
>>>> with:
>>>>
>>>> $ perf record -e cycles:p -IAX -a -- sleep 1
>>>>
>>>> succeeds.
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>
>>> -IAX should be no problem. The issue only occurs on the platform with
>>> extended regs supports, such as ICL. So I don't know if it's suitable to
>>> add it to perf test suite.
>>>
>>> Thanks
>>> Jin Yao
>>>
>>
>> Can this fix patch be accepted?
> 
> hi,
> my only concern was that it would conflict with Adrian's patch,
> other than that:
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 

Thanks Jiri!

Adrian's patch has not been merged otherwise I can rebase my patch on top of Adrian's patch.

Thanks
Jin Yao
