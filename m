Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E6C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26292072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCIKMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:12:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2519 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgCIKMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:12:18 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A8F9CD9958A6525C1927;
        Mon,  9 Mar 2020 10:12:16 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 10:12:16 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 9 Mar 2020
 10:12:15 +0000
Subject: Re: [PATCH 6/6] perf test: Add pmu-events test
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <james.clark@arm.com>, <qiangqing.zhang@nxp.com>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
 <1583406486-154841-7-git-send-email-john.garry@huawei.com>
 <20200309084924.GA65888@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <82c3fbfe-4ddc-db7d-c17f-29ca6f11e60c@huawei.com>
Date:   Mon, 9 Mar 2020 10:12:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200309084924.GA65888@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> A sample run is as follows for x86:
>>
>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>> 10: PMU event aliases                                     :
>> --- start ---
>> test child forked, pid 30869
>> Using CPUID GenuineIntel-6-9E-9
>> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
>> skipping testing PMU software
>> testing PMU power: skip
>> testing PMU cpu: matched event segment_reg_loads.any
>> testing PMU cpu: matched event dispatch_blocked.any
>> testing PMU cpu: matched event eist_trans
>> testing PMU cpu: matched event bp_l1_btb_correct
>> testing PMU cpu: matched event bp_l2_btb_correct
>> testing PMU cpu: pass
>> testing PMU cstate_core: skip
>> testing PMU uncore_cbox_2: matched event unc_cbo_xsnp_response.miss_eviction
>> testing PMU uncore_cbox_2: pass
>> skipping testing PMU breakpoint
>> testing PMU uncore_cbox_0: matched event unc_cbo_xsnp_response.miss_eviction
>> testing PMU uncore_cbox_0: pass
>> skipping testing PMU tracepoint
>> testing PMU cstate_pkg: skip
>> testing PMU uncore_arb: skip
>> testing PMU msr: skip
>> testing PMU uncore_cbox_3: matched event unc_cbo_xsnp_response.miss_eviction
>> testing PMU uncore_cbox_3: pass
>> testing PMU intel_pt: skip
>> testing PMU uncore_cbox_1: matched event unc_cbo_xsnp_response.miss_eviction
>> testing PMU uncore_cbox_1: pass
>> test child finished with 0
>> ---- end ----
>> PMU event aliases: Ok
> 
> SNIP
> 
>> +int test__pmu_event_aliases(struct test *test __maybe_unused,
>> +			    int subtest __maybe_unused)
>> +{
>> +	struct perf_pmu *pmu = NULL;
>> +
>> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>> +		int count = 0;
> 

Hi jirka,

> I don't follow the pmu iteration in here.. I'd expect
> we create 'test' pmu 

well, that's what we do next in the call to __test__pmu_event_aliases():

static int __test__pmu_event_aliases(char *pmu_name, int *count)
{
	struct perf_pmu_alias *alias;
	struct perf_pmu *pmu;
	LIST_HEAD(aliases);
	int res = 0;

	pmu = zalloc(sizeof(*pmu));
	if (!pmu)
		return -1;

	pmu->name = pmu_name;

	pmu_add_cpu_aliases_map(&aliases, pmu, &pmu_events_map_test);


Here we clone the HW PMU, create the aliases, and verify them against a 
known, expected list.

and check that all the aliasses
> are in place as we expect them.. why do we match them
> to existing events?

The events in test_cpu_aliases[] or test_uncore_aliases[] are checked 
against the events from pmu-events/arch/test/test_cpu/*.json

> 
> or as I'm thinking about that now, would it be enough
> to check pme_test_cpu array to have string that we
> expect?

Right, I might change this.

So currently we iterate the PMU aliases to ensure that we have a 
matching event in pme_test_cpu[]. It may be better to iterate the events 
in pme_test_cpu[] to ensure that we have an alias.

The problem here is uncore PMUs. They have the "Unit" field, which is 
used for matching the PMU. So we cannot ensure test events from 
uncore.json will always have an event alias created per PMU. But maybe I 
could use pmu_uncore_alias_match() to check if the test event matches in 
this case.

Thanks,
John
