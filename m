Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A31C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4732D20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgDVLzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:55:32 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2079 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgDVLzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:55:32 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7DBD82D1E6F71322D1FA;
        Wed, 22 Apr 2020 12:55:30 +0100 (IST)
Received: from [127.0.0.1] (10.47.10.232) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 22 Apr
 2020 12:55:29 +0100
Subject: Re: [RFC PATCH v2 07/13] perf pmu: Add pmu_id()
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <qiangqing.zhang@nxp.com>, <irogers@google.com>,
        <robin.murphy@arm.com>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-8-git-send-email-john.garry@huawei.com>
 <20200422114122.GG962614@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1b2c2b91-173b-2656-597c-551aac750784@huawei.com>
Date:   Wed, 22 Apr 2020 12:54:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200422114122.GG962614@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.232]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Wi
On 22/04/2020 12:41, Jiri Olsa wrote:
> On Fri, Apr 17, 2020 at 06:41:18PM +0800, John Garry wrote:
>> Add a function to read the PMU id sysfs entry. We only do it for uncore
>> PMUs where this would be relevant.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   tools/perf/util/pmu.c | 36 ++++++++++++++++++++++++++++++++++++
>>   tools/perf/util/pmu.h |  1 +
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index ef6a63f3d386..6a67c6a28d08 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -594,6 +594,7 @@ static struct perf_cpu_map *__pmu_cpumask(const char *path)
>>    * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
>>    * may have a "cpus" file.
>>    */
>> +#define CPUS_TEMPLATE_ID	"%s/bus/event_source/devices/%s/identifier"
>>   #define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
>>   #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
>>   
>> @@ -632,6 +633,39 @@ static bool pmu_is_uncore(const char *name)
>>   	return file_available(path);
>>   }
>>   
>> +static char *pmu_id(const char *name)
>> +{
>> +	char path[PATH_MAX], *id;
>> +	const char *sysfs;
>> +	FILE *file;
>> +	int n;
>> +
>> +	sysfs = sysfs__mountpoint();
>> +	snprintf(path, PATH_MAX, CPUS_TEMPLATE_ID, sysfs, name);
>> +
>> +	id = malloc(PATH_MAX);
>> +	if (!id)
>> +		return NULL;
>> +
>> +	file = fopen(path, "r");
>> +	if (!file) {
>> +		free(id);
>> +		return NULL;
>> +	}
>> +
>> +	n = fscanf(file, "%s", id);
>> +
>> +	fclose(file);
>> +
>> +	if (!n) {
>> +		free(id);
>> +		return NULL;
>> +	}
>> +
>> +	return id;
>> +}
> 
> I still need to go through this patchset in more detail,

ok, great.

But, could you check patch #1 also, as this *may* be fixing something 
broken in mainline? Not sure. Without it, we get a spew of warnings for 
metrics.

> but just quick note, that we have sysfs__read_str that you
> could use in here
> 

ok, there may be more functions in current pmu.c then which can use 
this. I can check.

Cheers,
John
