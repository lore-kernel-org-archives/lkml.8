Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B80C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0CB2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M2KqIvrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIAFug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:50:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgIAFue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:50:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0815Wjfi181438;
        Tue, 1 Sep 2020 01:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aSbxaMH+A3QRu+Kf+eDhiPblQC4mg+HYmfTQenYZu/A=;
 b=M2KqIvrmNjKCfiUbMFRun4bcPwEd2D1S+fRwVTPlX8YqxUYlTECezVjbIa12SjxjkMEC
 Etn/ZHgJmBLyiDEVi1vW38WRZwdDl2rISfkglTKO7vWq14pLuUjkEgmFTNsv09uXHkqv
 WMpC+cr2xx7gxqptb3azwYOX0VM/j64slmZaUDEWLr4pvpwvoB1ovoUkDNef4275eHzR
 idTvm1WueDhfiXaSh/eSY7KXZS5/SGzCVd+Kx+6W3qBUvIBIrMckDnuQAw15kYW5deLf
 FlWxWlv08Jxg1h0caiJGmuB+4qf0vjJFEQwTAfB3lPJ7PHAW1MAPKsADwLKiLuR5jq9j oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 339g8aracd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 01:50:19 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0815XdLl182819;
        Tue, 1 Sep 2020 01:50:19 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 339g8arac5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 01:50:18 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0815m0iE026426;
        Tue, 1 Sep 2020 05:50:18 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 337en930hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 05:50:18 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0815oHKY55312884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 05:50:17 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 333E7112067;
        Tue,  1 Sep 2020 05:50:17 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72B68112061;
        Tue,  1 Sep 2020 05:50:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.82.45])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 05:50:09 +0000 (GMT)
Subject: Re: [PATCH v6 1/5] perf/jevents: Remove jevents.h file
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-2-kjain@linux.ibm.com> <20200831084348.GB287892@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <98ae2072-f336-d6e9-28bf-eb1d633ed234@linux.ibm.com>
Date:   Tue, 1 Sep 2020 11:20:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200831084348.GB287892@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-08-31,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/20 2:13 PM, Jiri Olsa wrote:
> On Thu, Aug 27, 2020 at 06:39:54PM +0530, Kajol Jain wrote:
>> This patch removes jevents.h file and add its data inside
>> jevents.c as this file is only included there.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  tools/perf/pmu-events/jevents.c |  9 ++++++++-
>>  tools/perf/pmu-events/jevents.h | 23 -----------------------
>>  2 files changed, 8 insertions(+), 24 deletions(-)
>>  delete mode 100644 tools/perf/pmu-events/jevents.h
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index fa86c5f997cc..1c55cc754b5a 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -48,11 +48,18 @@
>>  #include <linux/list.h>
>>  #include "jsmn.h"
>>  #include "json.h"
>> -#include "jevents.h"
>>  
>>  int verbose;
>>  char *prog;
>>  
>> +#ifndef min
>> +#define min(x, y) ({				\
>> +	typeof(x) _min1 = (x);			\
>> +	typeof(y) _min2 = (y);			\
>> +	(void)(&_min1 == &_min2);		\
>> +	_min1 < _min2 ? _min1 : _min2; })
>> +#endif
>> +
>>  int eprintf(int level, int var, const char *fmt, ...)
>>  {
>>  
>> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
>> deleted file mode 100644
>> index 2afc8304529e..000000000000
>> --- a/tools/perf/pmu-events/jevents.h
>> +++ /dev/null
>> @@ -1,23 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef JEVENTS_H
>> -#define JEVENTS_H 1
>> -
>> -int json_events(const char *fn,
>> -		int (*func)(void *data, char *name, char *event, char *desc,
>> -				char *long_desc,
>> -				char *pmu,
>> -				char *unit, char *perpkg, char *metric_expr,
>> -				char *metric_name, char *metric_group,
>> -				char *deprecated, char *metric_constraint),
>> -		void *data);
>> -char *get_cpu_str(void);
> 
> I think you can also remove get_cpu_str from jevents.c

Hi Jiri,
     Yes, I will check that part.

Thanks,
Kajol Jain
> 
> thanks,
> jirka
> 
