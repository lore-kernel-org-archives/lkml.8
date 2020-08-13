Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735552065C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMMK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:10:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbgHMMKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:10:20 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8238167A1EB689711781;
        Thu, 13 Aug 2020 13:10:18 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.159) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 13 Aug
 2020 13:10:16 +0100
Subject: Re: [PATCH v2 0/4] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
To:     Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200807071620.11907-1-leo.yan@linaro.org>
 <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
 <20200812185334.GN13995@kernel.org> <20200813095901.GB9894@willie-the-truck>
 <20200813111833.GA10098@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f3cbe339-0daa-054b-4c28-d8f130206a44@huawei.com>
Date:   Thu, 13 Aug 2020 13:08:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200813111833.GA10098@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.159]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2020 12:18, Will Deacon wrote:
> [ Adding John, as I only just realised he wasn't on CC and we were talking
>    about him! ]
> 
> On Thu, Aug 13, 2020 at 10:59:01AM +0100, Will Deacon wrote:
>> On Wed, Aug 12, 2020 at 03:53:34PM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Aug 12, 2020 at 10:06:53AM -0600, Mathieu Poirier escreveu:
>>>> The ARM SPE perf tools code is orphan and I don't have the cycles to
>>>> pick it up.  Leo has spent a lot of time in that code and as such I
>>>> suggest that he starts maintaining it, probably following the same
>>>> kind of arrangement you and I have for coresight.
>>>
>>> Thats ok with me, I think we should reflect that on the MAINTAINERS
>>> file, right?
>>>
>>> We have this already:
>>>
>>> PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
>>> R:      John Garry <john.garry@huawei.com>
>>> R:      Will Deacon <will@kernel.org>
>>> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>> S:      Supported
>>> F:      tools/perf/pmu-events/arch/arm64/
>>>
>>> I think we should have entries for CoreSight and ARM SPE, one listing
>>> you as the maintainer and the other listing Leo, right?
>>
>> Fine by me. I'll continue to maintain the in-kernel SPE driver, but I'd love
>> to see somebody step up to looking after the userspace code. It's seriously
>> unloved on arm64 :(
>>
>> I'd even be happy to see one or two M: entries added for
>> tools/perf/pmu-events/arch/arm64/. I realistically don't have the time to
>> take that on, but I'd be thrilled if any/all of John, Mathieu and Leo were
>> to be listed there if they are willing to do so and can spare the time to
>> look after it. Even just silly things like making sure the thing
>> cross-compiles have been broken in the recent past, so it's not necessarily
>> about handling huge amounts of incoming patches.
>>
>> In other words, rather than slice up the arm64 parts of the perf tool, I'd
>> argue in favour of a joint maintainership model for all the arm64 bits, if
>> we have a few willing volunteers.

Right, it makes sense not to chop up too much, so happy to see 
"PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS" expanded in terms of 
scope and membership.
