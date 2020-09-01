Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE33C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A671C2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gJHtFWkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIAF50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:57:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgIAF50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:57:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0815j0pw150222;
        Tue, 1 Sep 2020 01:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GKpr7Y/AbhIatG1JNxjGYEZBP+n95TbcZcZI7qxtpKg=;
 b=gJHtFWkHsmer3UyH4zvnbZRAi5iYFpXQJsTEmMOrUfhr+8FSbPE+rebXV8YBAIZSGdIB
 QR4LawO2up0OTMfiaTj6CobBmYnVGL3zgZ7FLlF7eYGkjIQRTwbWXh72Z0GRyIVhm7cu
 cT9Oz1J0uNuwmcBbI5CAXSOrY4ng8TMbQOD+edzb0JUOUJ8c5LRALfAsP0ljz9KBomRz
 1D50w1gqsqDCMD9iKm4/XQ5Q2/jnVYBOZrv5ECHWbezDR93RWoO0Fy3LtztVJe4Bxtv+
 HbiFkuMCzWLGEWJnywI2sQW4j8Xc/2ttGZbzfIU25h6rSPLmchvpotPpQ4kGj4poWqvm Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339ge5g6df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 01:57:02 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0815nkrR177245;
        Tue, 1 Sep 2020 01:57:02 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339ge5g6d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 01:57:01 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0815rLdY031544;
        Tue, 1 Sep 2020 05:57:00 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 337en9b0mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 05:57:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0815v0Pa13697756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 05:57:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1381A112062;
        Tue,  1 Sep 2020 05:57:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC6A1112061;
        Tue,  1 Sep 2020 05:56:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.82.45])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 05:56:52 +0000 (GMT)
Subject: Re: [PATCH v6 1/5] perf/jevents: Remove jevents.h file
To:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-2-kjain@linux.ibm.com> <20200831084348.GB287892@krava>
 <ca73d0ff-0dfa-8d9e-1cb8-5791a78eb4e2@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <92f58d69-849a-5df4-6b24-87542138806d@linux.ibm.com>
Date:   Tue, 1 Sep 2020 11:26:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ca73d0ff-0dfa-8d9e-1cb8-5791a78eb4e2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-08-31,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/20 2:31 PM, John Garry wrote:
> On 31/08/2020 09:43, Jiri Olsa wrote:
>> On Thu, Aug 27, 2020 at 06:39:54PM +0530, Kajol Jain wrote:
>>> This patch removes jevents.h file and add its data inside
>>> jevents.c as this file is only included there.
>>>
>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>> ---
>>>   tools/perf/pmu-events/jevents.c |  9 ++++++++-
>>>   tools/perf/pmu-events/jevents.h | 23 -----------------------
>>>   2 files changed, 8 insertions(+), 24 deletions(-)
>>>   delete mode 100644 tools/perf/pmu-events/jevents.h
>>>
>>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>>> index fa86c5f997cc..1c55cc754b5a 100644
>>> --- a/tools/perf/pmu-events/jevents.c
>>> +++ b/tools/perf/pmu-events/jevents.c
>>> @@ -48,11 +48,18 @@
>>>   #include <linux/list.h>
>>>   #include "jsmn.h"
>>>   #include "json.h"
>>> -#include "jevents.h"
>>>     int verbose;
>>>   char *prog;
>>>   +#ifndef min
>>> +#define min(x, y) ({                \
>>> +    typeof(x) _min1 = (x);            \
>>> +    typeof(y) _min2 = (y);            \
>>> +    (void)(&_min1 == &_min2);        \
>>> +    _min1 < _min2 ? _min1 : _min2; })
>>> +#endif
> 
> Wondering what is special about this definition of min that it's required? Compiled ok for me without it.

Hi John,
     You are right, for me also in power it compiled without any issues, but not sure if somewhere we have dependency,
that's why I didn't remove it. 

Thanks,
Kajol Jain
> 
>>> +
>>>   int eprintf(int level, int var, const char *fmt, ...)
>>>   {
>>>   diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
>>> deleted file mode 100644
>>> index 2afc8304529e..000000000000
>>> --- a/tools/perf/pmu-events/jevents.h
>>> +++ /dev/null
>>> @@ -1,23 +0,0 @@
>>> -/* SPDX-License-Identifier: GPL-2.0 */
>>> -#ifndef JEVENTS_H
>>> -#define JEVENTS_H 1
>>> -
>>> -int json_events(const char *fn,
>>> -        int (*func)(void *data, char *name, char *event, char *desc,
>>> -                char *long_desc,
>>> -                char *pmu,
>>> -                char *unit, char *perpkg, char *metric_expr,
>>> -                char *metric_name, char *metric_group,
>>> -                char *deprecated, char *metric_constraint),
>>> -        void *data);
>>> -char *get_cpu_str(void);
>>
>> I think you can also remove get_cpu_str from jevents.c
>>
>> thanks,
>> jirka
>>
>> .
>>
> 
