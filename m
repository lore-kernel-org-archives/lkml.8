Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA04BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E71B2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFCDDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:03:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgFCDDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:03:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E19243405ACD07594765;
        Wed,  3 Jun 2020 11:03:33 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.91) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 11:03:21 +0800
Subject: Re: [PATCH 2/4] perf svghelper: Fix memory leak in
 svg_build_topology_map
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Wei Li <liwei391@huawei.com>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
References: <20200521133218.30150-1-liwei391@huawei.com>
 <20200521133218.30150-3-liwei391@huawei.com>
 <20200521141545.GC3898@kernel.org>
From:   "LiBin (Huawei)" <huawei.libin@huawei.com>
Message-ID: <36b0d67c-f8a0-09b2-c2c7-964e202710d2@huawei.com>
Date:   Wed, 3 Jun 2020 11:03:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200521141545.GC3898@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.91]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/5/21 22:15, Arnaldo Carvalho de Melo Ð´µÀ:
> Em Thu, May 21, 2020 at 09:32:16PM +0800, Wei Li escreveu:
>> From: Li Bin <huawei.libin@huawei.com>
>>
>> Fix leak of memory pointed to by t.sib_thr and t.sib_core in
>> svg_build_topology_map.
>>
>> Signed-off-by: Li Bin <huawei.libin@huawei.com>
>> ---
>>   tools/perf/util/svghelper.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
>> index 96f941e01681..e2b3b0e2fafe 100644
>> --- a/tools/perf/util/svghelper.c
>> +++ b/tools/perf/util/svghelper.c
>> @@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
>>   	int i, nr_cpus;
>>   	struct topology t;
>>   	char *sib_core, *sib_thr;
>> +	int ret;
> Please set ret to -1 here
>
> 	int ret = -1;
> 	
> So that you don't have to add all those lines below...
>
>>   
>>   	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
>>   
>> @@ -767,12 +768,14 @@ int svg_build_topology_map(struct perf_env *env)
>>   
>>   	if (!t.sib_core || !t.sib_thr) {
>>   		fprintf(stderr, "topology: no memory\n");
>> +		ret = -1;
>>   		goto exit;
>>   	}
>>   
>>   	for (i = 0; i < env->nr_sibling_cores; i++) {
>>   		if (str_to_bitmap(sib_core, &t.sib_core[i], nr_cpus)) {
>>   			fprintf(stderr, "topology: can't parse siblings map\n");
>> +			ret = -1;
>>   			goto exit;
>>   		}
>>   
>> @@ -782,6 +785,7 @@ int svg_build_topology_map(struct perf_env *env)
>>   	for (i = 0; i < env->nr_sibling_threads; i++) {
>>   		if (str_to_bitmap(sib_thr, &t.sib_thr[i], nr_cpus)) {
>>   			fprintf(stderr, "topology: can't parse siblings map\n");
>> +			ret = -1;
>>   			goto exit;
>>   		}
>>   
>> @@ -791,6 +795,7 @@ int svg_build_topology_map(struct perf_env *env)
>>   	topology_map = malloc(sizeof(int) * nr_cpus);
>>   	if (!topology_map) {
>>   		fprintf(stderr, "topology: no memory\n");
>> +		ret = -1;
>>   		goto exit;
>>   	}
>>   
>> @@ -798,12 +803,11 @@ int svg_build_topology_map(struct perf_env *env)
>>   		topology_map[i] = -1;
>>   
>>   	scan_core_topology(topology_map, &t, nr_cpus);
>> -
>> -	return 0;
> ... as you'll set it to zero here :-)


Thank you for your comments. I will fix it.

Thanks,

Li Bin


>> +	ret = 0;
>>   
>>   exit:
>>   	zfree(&t.sib_core);
>>   	zfree(&t.sib_thr);
>>   
>> -	return -1;
>> +	return ret;
>>   }
>> -- 
>> 2.17.1
>>

