Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4405AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240A22073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgBLJbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:31:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728530AbgBLJbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:31:10 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7BA28551258B46250CA0;
        Wed, 12 Feb 2020 17:31:07 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Feb 2020
 17:30:56 +0800
Subject: Re: [PATCH] perf tools: Add arm64 version of get_cpuid()
To:     John Garry <john.garry@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
References: <1576245255-210926-1-git-send-email-john.garry@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <4ccf4455-b33d-441b-50ed-28211dd87c7c@hisilicon.com>
Date:   Wed, 12 Feb 2020 17:30:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1576245255-210926-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I tested this patch on my new ARM64 Kunpeng 920 server.
[root@node1 zsk]# ./perf --version
perf version 5.6.rc1.g2cdb955b7252

Both perf list and perf stat can work.

Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks,
Shaokun

On 2019/12/13 21:54, John Garry wrote:
> Add an arm64 version of get_cpuid(), which is used for various annotation
> and headers - for example, I now get the CPUID in "perf report --header",
> as shown in this snippet:
> 
> # hostname : ubuntu
> # os release : 5.5.0-rc1-dirty
> # perf version : 5.5.rc1.gbf8a13dc9851
> # arch : aarch64
> # nrcpus online : 96
> # nrcpus avail : 96
> # cpuid : 0x00000000480fd010
> 
> Since much of the code to read the MIDR is already in get_cpuid_str(),
> factor out this code.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> index a32e4b72a98f..d730666ab95d 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -1,8 +1,10 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <perf/cpumap.h>
> +#include <util/cpumap.h>
>  #include <internal/cpumap.h>
>  #include <api/fs/fs.h>
> +#include <errno.h>
>  #include "debug.h"
>  #include "header.h"
>  
> @@ -12,26 +14,21 @@
>  #define MIDR_VARIANT_SHIFT      20
>  #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
>  
> -char *get_cpuid_str(struct perf_pmu *pmu)
> +static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>  {
> -	char *buf = NULL;
> -	char path[PATH_MAX];
>  	const char *sysfs = sysfs__mountpoint();
> -	int cpu;
>  	u64 midr = 0;
> -	struct perf_cpu_map *cpus;
> -	FILE *file;
> +	int cpu;
>  
> -	if (!sysfs || !pmu || !pmu->cpus)
> -		return NULL;
> +	if (!sysfs || sz < MIDR_SIZE)
> +		return EINVAL;
>  
> -	buf = malloc(MIDR_SIZE);
> -	if (!buf)
> -		return NULL;
> +	cpus = perf_cpu_map__get(cpus);
>  
> -	/* read midr from list of cpus mapped to this pmu */
> -	cpus = perf_cpu_map__get(pmu->cpus);
>  	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
> +		char path[PATH_MAX];
> +		FILE *file;
> +
>  		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
>  				sysfs, cpus->map[cpu]);
>  
> @@ -57,12 +54,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
>  		break;
>  	}
>  
> -	if (!midr) {
> +	perf_cpu_map__put(cpus);
> +
> +	if (!midr)
> +		return EINVAL;
> +
> +	return 0;
> +}
> +
> +int get_cpuid(char *buf, size_t sz)
> +{
> +	struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
> +	int ret;
> +
> +	if (!cpus)
> +		return EINVAL;
> +
> +	ret = _get_cpuid(buf, sz, cpus);
> +
> +	perf_cpu_map__put(cpus);
> +
> +	return ret;
> +}
> +
> +char *get_cpuid_str(struct perf_pmu *pmu)
> +{
> +	char *buf = NULL;
> +	int res;
> +
> +	if (!pmu || !pmu->cpus)
> +		return NULL;
> +
> +	buf = malloc(MIDR_SIZE);
> +	if (!buf)
> +		return NULL;
> +
> +	/* read midr from list of cpus mapped to this pmu */
> +	res = _get_cpuid(buf, MIDR_SIZE, pmu->cpus);
> +	if (res) {
>  		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
>  		free(buf);
>  		buf = NULL;
>  	}
>  
> -	perf_cpu_map__put(cpus);
>  	return buf;
>  }
> 

