Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFDC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B07208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VQZW+OLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgIAGEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:04:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgIAGEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:04:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08163331121009;
        Tue, 1 Sep 2020 02:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vRUOCjKNhfU4jC//SKcvUi/GAEvaaV/usn9kEKuTUcA=;
 b=VQZW+OLaKjIRGdE3ROu5xoHAaPqdZ6Q+MvYWFC9ak8M5zJwKeF8BrKqF35YO+WAIfL9s
 T7LyAZ/opx5hBYAwQf4oJHgxyG1VugO8Kc/vuT9tSOQu8mTU8DBwQ7ZgslSeIgyutYUQ
 7LrQ7aPe1oyI6waZQcTJi2lv6Z5ZAoMi1Af+4D5C81NSzxgSerJ4gM0/hbXrFYOHwmGl
 CcqkCefdFj0gIXFRzqTSCPevJOQd5lcn3IOQvtAnqp4g8FS84I3j1p88n4fpJRmoN8Jz
 won6MaXDwIa00ut8GnCq8KjELd1FTNFevWbNqB0MgUw6VJx6QigrwwZ/XQN17neNqEJj Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339g8j8pt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 02:03:35 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08163CKx121869;
        Tue, 1 Sep 2020 02:03:35 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339g8j8ps9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 02:03:35 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 081637Gg025175;
        Tue, 1 Sep 2020 06:03:33 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 337en95ns2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 06:03:33 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08163WJS36766188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 06:03:33 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5338112062;
        Tue,  1 Sep 2020 06:03:32 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2DD3112061;
        Tue,  1 Sep 2020 06:03:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.82.45])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 06:03:24 +0000 (GMT)
Subject: Re: [PATCH v6 3/5] perf jevents: Add support for parsing
 perchip/percore events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-4-kjain@linux.ibm.com> <20200831084404.GD287892@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <466a0e9a-ad01-f436-8f70-10aba586796e@linux.ibm.com>
Date:   Tue, 1 Sep 2020 11:33:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200831084404.GD287892@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/20 2:14 PM, Jiri Olsa wrote:
> On Thu, Aug 27, 2020 at 06:39:56PM +0530, Kajol Jain wrote:
>> Initially, every time we want to add new terms like chip, core thread etc,
>> we need to create corrsponding fields in pmu_events and event struct.
>> This patch adds an enum called 'aggr_mode_class' which store all these
>> aggregation like perchip/percore. It also adds new field 'aggr_mode'
>> to capture these terms.
>> Now, if user wants to add any new term, they just need to add it in
>> the enum defined.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  tools/perf/pmu-events/jevents.c    | 16 ++++++++++++++++
>>  tools/perf/pmu-events/pmu-events.h |  6 ++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index b205cd904a4f..f4ad2d403533 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -48,6 +48,7 @@
>>  #include <linux/list.h>
>>  #include "jsmn.h"
>>  #include "json.h"
>> +#include "pmu-events.h"
>>  
>>  int verbose;
>>  char *prog;
>> @@ -60,6 +61,7 @@ struct json_event {
>>  	char *pmu;
>>  	char *unit;
>>  	char *perpkg;
>> +	char *aggr_mode;
>>  	char *metric_expr;
>>  	char *metric_name;
>>  	char *metric_group;
>> @@ -74,6 +76,14 @@ struct json_event {
>>  	(void)(&_min1 == &_min2);		\
>>  	_min1 < _min2 ? _min1 : _min2; })
>>  #endif
> 
> please add new line in here
> 

yes, will add.

>> +enum aggr_mode_class convert(const char *aggr_mode)
>> +{
>> +	if (!strcmp(aggr_mode, "PerCore"))
>> +		return PerCore;
>> +	else if (!strcmp(aggr_mode, "PerChip"))
>> +		return PerChip;
>> +	return -1;
> 
> should we display some warning in here?

Sure can do that.

Thanks,
Kajol Jain
> 
> thanks,
> jirka
> 
