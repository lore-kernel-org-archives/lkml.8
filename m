Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC83C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3D121481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgIGN6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:58:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2775 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729619AbgIGNt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:49:57 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 42244569D0965377F815;
        Mon,  7 Sep 2020 14:49:51 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.208) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 7 Sep 2020
 14:49:50 +0100
Subject: Re: [PATCH 8/9] perf test: Free aliases for PMU event map aliases
 test
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
References: <20200907034502.753230-1-namhyung@kernel.org>
 <20200907034502.753230-9-namhyung@kernel.org>
 <78911dd7-8a93-0f1b-7805-1fad87ad6979@huawei.com>
 <CAM9d7ci=knY_Wu8vbdfOzCtJX_onciz2eri8E=d2KM2qwG6QGQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <04594390-55ab-9063-aee6-ab0f560f3e0d@huawei.com>
Date:   Mon, 7 Sep 2020 14:47:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAM9d7ci=knY_Wu8vbdfOzCtJX_onciz2eri8E=d2KM2qwG6QGQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.208]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 14:20, Namhyung Kim wrote:
>> I also notice that we have other paths like this, where the allocated
>> pmu (and aliases) are not freed for later error paths, it seems:
>>
>> parse_events_add_pmu() -> perf_pmu_find() -> pmu_lookup() ->
>> pmu_add_cpu_aliases().
>>
>> I had a quick look at the rest of the series, and could not see if we
>> fix up any of this.

Hi Namhyung,

> Right, I also found that and wondered why ASAN didn't report it.
> I think we should free all pmu instances from the pmus list.
> But this can be a later work..

ok, good. I was going to say that we could at least add a pmu free 
helper in pmu.c now (and reference it here, from this test code, for 
now), but maybe you just want to fix the reported leaks for now and work 
on this as a follow up.

Thanks,
John
