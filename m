Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5791CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B81020714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgBJPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:55:05 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2403 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727584AbgBJPzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:55:04 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 06EF21ADA86E6B7EE9B3;
        Mon, 10 Feb 2020 15:55:02 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Feb 2020 15:55:01 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 10 Feb
 2020 15:55:01 +0000
Subject: Re: [PATCH RFC 3/7] perf jevents: Add support for a system events PMU
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-4-git-send-email-john.garry@huawei.com>
 <20200210120749.GF1907700@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b148f0b6-d2ae-6520-8da1-7aed2c9e1d6b@huawei.com>
Date:   Mon, 10 Feb 2020 15:55:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200210120749.GF1907700@krava>
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

On 10/02/2020 12:07, Jiri Olsa wrote:
> On Fri, Jan 24, 2020 at 10:35:01PM +0800, John Garry wrote:
> 
> SNIP
> 
>>   	- Set of 'PMU events tables' for all known CPUs in the architecture,
>> @@ -83,11 +93,11 @@ NOTES:
>>   	2. The 'pmu-events.h' has an extern declaration for the mapping table
>>   	   and the generated 'pmu-events.c' defines this table.
>>   
>> -	3. _All_ known CPU tables for architecture are included in the perf
>> -	   binary.
>> +	3. _All_ known CPU and system tables for architecture are included in
>> +	   the perf binary.
>>   
>> -At run time, perf determines the actual CPU it is running on, finds the
>> -matching events table and builds aliases for those events. This allows
>> +At run time, perf determines the actual CPU or system it is running on, finds
>> +the matching events table and builds aliases for those events. This allows
>>   users to specify events by their name:
>>   
>>   	$ perf stat -e pm_1plus_ppc_cmpl sleep 1
>> @@ -150,3 +160,18 @@ where:
>>   
>>   	i.e the three CPU models use the JSON files (i.e PMU events) listed
>>   	in the directory 'tools/perf/pmu-events/arch/x86/silvermont'.
>> +
>> +The mapfile_sys.csv format is slightly different, in that it contains a SYSID
>> +instead of the CPUID:
>> +
>> +	Header line
>> +	SYSID,Version,Dir/path/name,Type
> 

Hi jirka,

> can't we just add prefix to SYSID types? like:
> 
> 	SYSID-HIP08,v1,hisilicon/hip08/sys,sys
> 	0x00000000480fd010,v1,hisilicon/hip08/cpu,core
> 	0x00000000500f0000,v1,ampere/emag,core
> 
> because the rest of the line is the same, right?

I did consider that already. It should be workable.

> 
> seems to me that having one mapfile type would be less confusing

I thought that having it all in a single file would be more confusing :)

> 
As for this separate comment:

 >> +		if (!strcmp(bname, "mapfile_sys.csv")) {
 >> +			mapfile_sys = strdup(fpath);
 >
 >
 > we could release that in the cleanup code at the end of main
 > together with 'mapfile',

That should now go away.

 >  which is also missing

Right, I'll look to fix that.

Thanks,
John

> .
> 

