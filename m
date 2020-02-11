Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BB9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6493920842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgBKPgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:36:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2409 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728767AbgBKPgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:36:42 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1FBCFC341D361AE824A0;
        Tue, 11 Feb 2020 15:36:41 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Feb 2020 15:36:40 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 11 Feb
 2020 15:36:40 +0000
Subject: Re: [PATCH RFC 4/7] perf pmu: Rename uncore symbols to include system
 PMUs
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-5-git-send-email-john.garry@huawei.com>
 <20200210120715.GC1907700@krava>
 <fac99c40-dace-3e2e-c8f4-b2afed8b7c61@huawei.com>
 <20200211144308.GC93194@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <52e18a50-1e62-f2fa-7639-f96268c5d243@huawei.com>
Date:   Tue, 11 Feb 2020 15:36:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200211144308.GC93194@krava>
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

On 11/02/2020 14:43, Jiri Olsa wrote:
>> root@(none)$ pwd
>> /sys/bus/event_source/devices/smmuv3_pmcg_100020
>> root@(none)$ ls -l
>> total 0
>> -r--r--r--    1 root     root          4096 Feb 10 14:50 cpumask
>> drwxr-xr-x    2 root     root             0 Feb 10 14:50 events
>> drwxr-xr-x    2 root     root             0 Feb 10 14:50 format
>> -rw-r--r--    1 root     root          4096 Feb 10 14:50
>> perf_event_mux_interval_ms
>> drwxr-xr-x    2 root     root             0 Feb 10 14:50 power
>> lrwxrwxrwx    1 root     root             0 Feb 10 14:50 subsystem ->
>> ../../bus/event_source
>> -r--r--r--    1 root     root          4096 Feb 10 14:50 type
>> -rw-r--r--    1 root     root          4096 Feb 10 14:50 uevent
>>
>>
>> Other PMU drivers which I have checked in drivers/perf also have the same.
>>
>> Indeed I see no way to differentiate whether a PMU is an uncore or system.
>> So that is why I change the name to cover both. Maybe there is a better name
>> than the verbose pmu_is_uncore_or_sys().
>>
>>> I don't see the connection here with the sysid or '_sys' checking,
>>> that's just telling which ID to use when looking for an alias, no?
>> So the connection is that in perf_pmu__find_map(), for a given PMU, the
>> matching is now extended from only core or uncore PMUs to also these system
>> PMUs. And I use the sysid to find an aliasing table for any system PMUs
>> present.

Hi Jirka,

 > I see.. can't we just check sysid for uncore PMUs?

x86 will still alias PMUs (uncore or CPU) based on an alias table 
matched to the cpuid, as it is today. x86 has the benefit of fixed 
uncore PMUs for a given cpuid.

For other archs whose uncore or system PMUs are not fixed for a given 
CPU - like arm - we will support matching uncore and system PMUs on 
cpuid or sysid.

Uncore PMUs are a grey area for arm, as they may or may not be tied to a 
specific cpuid, so we will need to support both matching methods.

because
 > that's what the code is doing, right?

Not exactly.

The code will match on an alias table matched to the cpuid and also an 
alias table matched to the sysid (if perf could actually get a sysid and 
there is a table matching that sysid).

I hope that this makes sense....

having pmu_is_uncore_or_sys
 > makes me think there's some sysid-type PMU
 >
 > jirka
 >

Thanks,
John
