Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E96822BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BtIqOyZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgH0M6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:58:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbgH0M5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:57:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RCWHkq124207;
        Thu, 27 Aug 2020 08:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=C3993iEI8cespXe9G6ubljnSqXfbCcQAx5wYMlYe4GE=;
 b=BtIqOyZmMcPA/mqrpRzomGZMOubzCktAITWa7NunGx6IZeKQG/MsK99aeZX4FrDWtQ6j
 Y/FGV+xk4FnOo3FtUy+l5dRcwdaIN4SWQUWlBI2391Azgiit2k7p7oeRskFvsY8E/XtR
 ORpTy1NjgVL3zD39mDmPbbaHtJxv1rv9/almqih4eTW35zMkmHWtTTGCmM2W2oRCJCNx
 vp6d/O/TrKg0MhINak9SyFbJ6RrBSyfzA2nDkRfBk60EfIuM3AweLhV1EfFxMNt1luMy
 2Y4KdgOxmjWiFHcoRTAQil04DmqwZjeuKKlM6OpEYlLqmFtAfdjLZ/yjC767b6rwnkMf Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336ayhvbjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:57:25 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RCWSxw125225;
        Thu, 27 Aug 2020 08:57:24 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336ayhvbhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:57:24 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RCqs7T005092;
        Thu, 27 Aug 2020 12:57:23 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 332uw7swxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 12:57:23 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RCvMmK55247148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 12:57:22 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6729AE05F;
        Thu, 27 Aug 2020 12:57:22 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AC5DAE05C;
        Thu, 27 Aug 2020 12:57:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.210.202])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 12:57:18 +0000 (GMT)
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
To:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
 <20200826110046.GF703542@krava>
 <5d91b929-cffd-265a-dd0c-f63bc3d1565d@linux.ibm.com>
 <ac9acc5f-7ce1-c9c9-91f5-598ca13a4a89@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <db9dd8b3-e2ca-6773-a8bb-0f635eb84953@linux.ibm.com>
Date:   Thu, 27 Aug 2020 18:27:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ac9acc5f-7ce1-c9c9-91f5-598ca13a4a89@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_06:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=2 lowpriorityscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 5:03 PM, John Garry wrote:
> On 26/08/2020 12:24, kajoljain wrote:
>>
>>
>> On 8/26/20 4:30 PM, Jiri Olsa wrote:
>>> On Tue, Aug 25, 2020 at 09:14:11AM +0100, John Garry wrote:
>>>
>>> SNIP
>>>
>>>>>                    goto free_strings;
>>>>>            }
>>>>> -        err = func(data, name, real_event(name, event), desc, long_desc,
>>>>> -               pmu, unit, perpkg, metric_expr, metric_name,
>>>>> -               metric_group, deprecated, metric_constraint);
>>>>> +        je->event = real_event(je->name, je->event);
>>>>> +        err = func(data, je);
>>>>>    free_strings:
>>>>> -        free(event);
>>>>> -        free(desc);
>>>>> -        free(name);
>>>>> -        free(long_desc);
>>>>>            free(extra_desc);
>>>>> -        free(pmu);
>>>>>            free(filter);
>>>>> -        free(perpkg);
>>>>> -        free(deprecated);
>>>>> -        free(unit);
>>>>> -        free(metric_expr);
>>>>> -        free(metric_name);
>>>>> -        free(metric_group);
>>>>> -        free(metric_constraint);
> 
> Hi Kajol Jain,
> 
> Do we need to free je->metric_name and the rest still? From a glance, that memory is still separately alloc'ed in addfield.

Hi John,
    yes right we should free them as well. Thanks for pointing it, I will update.

Thanks,
Kajol Jain
> 
>>>>>            free(arch_std);
>>>>> +        free(je);
>>>>>            if (err)
>>>>>                break;
>>>>> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
>>>>> index 2afc8304529e..e696edf70e9a 100644
>>>>> --- a/tools/perf/pmu-events/jevents.h
>>>>> +++ b/tools/perf/pmu-events/jevents.h
>>>>
>>>> Somewhat unrelated - this file only seems to be included in jevents.c, so I
>>>> don't see why it exists...
>>>
>>> ah right.. I won't mind getting rid of it
>>
>> Hi John and  Jiri
>>       Thanks for reviewing the patch. I can remove this file and add these structure inside jevents.c
> 
> thanks
> 
>>
>> Thanks,
>> Kajol Jain
>>>  
>>>>> @@ -2,14 +2,28 @@
>>>>>    #ifndef JEVENTS_H
>>>>>    #define JEVENTS_H 1
>>>>> +#include "pmu-events.h"
>>>>> +
>>>>> +struct json_event {
>>>>> +    char *name;
>>>>> +    char *event;
>>>>> +    char *desc;
>>>>> +    char *topic;
>>>>> +    char *long_desc;
>>>>> +    char *pmu;
>>>>> +    char *unit;
>>>>> +    char *perpkg;
>>>>> +    char *metric_expr;
>>>>> +    char *metric_name;
>>>>> +    char *metric_group;
>>>>> +    char *deprecated;
>>>>> +    char *metric_constraint;
>>>>
>>>> This looks very much like struct event_struct, so could look to consolidate:
>>>>
>>>> struct event_struct {
>>>>     struct list_head list;
>>>>     char *name;
>>>>     char *event;
>>>>     char *desc;
>>>>     char *long_desc;
>>>>     char *pmu;
>>>>     char *unit;
>>>>     char *perpkg;
>>>>     char *metric_expr;
>>>>     char *metric_name;
>>>>     char *metric_group;
>>>>     char *deprecated;
>>>>     char *metric_constraint;
>>>> };
>>>
>>> as Andi said they come from different layers, I think it's
>>> better to keep them separated even if they share some fields
> 
> I was just suggesting to make:
>  struct event_struct {
>     struct list_head list;
>     struct json_event je;
>  }
> 
> No biggie if against this.
> 
> Cheers,
> John
