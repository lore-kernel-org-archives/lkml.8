Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3B6C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBC8208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIGIBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:01:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:65454 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgIGIBi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:01:38 -0400
IronPort-SDR: fnaCPQVv+YKBXF+l5yS4XVXv2XZdJ10gVdjnRxeGoKz33AHISbLx4ly6HH/wbQQbcenIAk/DH/
 bpHXwy1SLuCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="176024230"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="176024230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 01:01:37 -0700
IronPort-SDR: ljQt7u3FmYLG98tXC62bgoQQvyXiqrOPvVvS1sSB8R5UDFgLcVDUJ9lmNdWd6fY3JhXlWyqcIJ
 QoibD0AnhCVg==
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="479555941"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 01:01:34 -0700
Subject: Re: [PATCH 0/2] Update CascadelakeX and SkylakeX events list
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
References: <20200603021818.27028-1-yao.jin@linux.intel.com>
 <911b4132-d1a1-f3c4-a2ed-2fcfe9a28fc6@linux.intel.com>
 <CAP-5=fW3OCuVkQ8csYfHXj5c_pCSY5-6vDrj2r=MNDZmpo0f8g@mail.gmail.com>
 <c7edd282-f58a-4efe-5961-6c1369b6b77b@linux.intel.com>
 <20200616193856.GC6393@kernel.org>
 <681a333b-e4dc-9481-715e-a65a34e10f83@linux.intel.com>
Message-ID: <82271c45-4a7d-d892-eccd-ed042b86a333@linux.intel.com>
Date:   Mon, 7 Sep 2020 16:01:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <681a333b-e4dc-9481-715e-a65a34e10f83@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 7/17/2020 2:06 PM, Jin, Yao wrote:
> Hi,
> 
> On 6/17/2020 3:38 AM, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Jun 16, 2020 at 02:27:40PM +0800, Jin, Yao escreveu:
>>> On 6/16/2020 2:16 PM, Ian Rogers wrote:
>>>> On Mon, Jun 15, 2020 at 6:00 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>>>>> Can I get an ACK for this patchset?
>>>>> On 6/3/2020 10:18 AM, Jin Yao wrote:
>>>>>> This patchset updates CascadelakeX events to v1.08 and
>>>>>> updates SkylakeX events to v1.21.
>>
>>>>>> The events have been tested on CascadelakeX and SkylakeX
>>>>>> servers with latest perf/core branch.
>>
>>>> could you rebase this on Arnaldo's tmp.perf/core tree?
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core
>>>> I tried using git am but get:
>>>> Applying: perf vendor events: Update CascadelakeX events to v1.08
>>>> error: patch fragment without header at line 279: @@ -213,14 +220,14 @@
>>>> error: could not build fake ancestor
>>>> Patch failed at 0001 perf vendor events: Update CascadelakeX events to v1.08
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>
>>> The patchset are applied OK on perf/core branch.
>>>
>>> As far as I understand, the patch for posting should be based on perf/core branch, is it right?
>>
>> Sorry, I've been testing with using tmp.perf/core as a way to more
>> quickly make available what I've processed, before I test it thoroughly
>> both with container builds and with manual testing, so the bleeding edge
>> is there, perf/core becoming a bit more stable, as I'll try not to
>> rebase it like before.
>>
>> - Arnaldo
>>
> 
> Can this event update be accepted?
> 
> Thanks
> Jin Yao

Can this event list update be accepted?

Thanks
Jin Yao
