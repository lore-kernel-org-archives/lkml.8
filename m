Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803C42080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qNsS4/2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgHZMRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:17:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729204AbgHZMRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:17:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QB3ICa112291;
        Wed, 26 Aug 2020 07:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xrlSE8I/COK0D2YzSZC8jDllNcYvqK1EXk4ZYuX00Vc=;
 b=qNsS4/2cUIv7fdcRD+PNW6bA372jfherwSW8p81CQVuSUioZQ9FBt1PmMu/L9C5/mMCG
 ypyXIeyfgymqHIqEHLShjGjuaSg1KQG2Ap7178CX5wE1hy5LovgLH78GUFl/c+3D3Xtp
 f2jrUCkQVG9iAC21nKbf1R2YEiq0po3xbdVbl0kxhpuHypK1c7hmEyWWB7S4eMuIZLkc
 Q35N45m/S8E0fncu31ev3cq/EFjkYvlhTX0mDLfcz0Dwy+/oisdbX2Rko/YA+6FuA8qY
 kmHqF6wlSkOPBOnzZgrkn0dSYXx3AiCR8iIQ8l+XGOPBos9aYIAlxY2h/CHd8oQNva8n 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335pfn8psp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:24:53 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QB6Y5I124743;
        Wed, 26 Aug 2020 07:24:53 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335pfn8ps8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:24:53 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QBN2lt022536;
        Wed, 26 Aug 2020 11:24:52 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 332uwah973-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 11:24:52 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QBOptV45023642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:24:51 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8D24AE060;
        Wed, 26 Aug 2020 11:24:51 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45C32AE05C;
        Wed, 26 Aug 2020 11:24:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.94])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 11:24:47 +0000 (GMT)
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
To:     Jiri Olsa <jolsa@redhat.com>, John Garry <john.garry@huawei.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
 <20200826110046.GF703542@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <5d91b929-cffd-265a-dd0c-f63bc3d1565d@linux.ibm.com>
Date:   Wed, 26 Aug 2020 16:54:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826110046.GF703542@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 4:30 PM, Jiri Olsa wrote:
> On Tue, Aug 25, 2020 at 09:14:11AM +0100, John Garry wrote:
> 
> SNIP
> 
>>>   				goto free_strings;
>>>   		}
>>> -		err = func(data, name, real_event(name, event), desc, long_desc,
>>> -			   pmu, unit, perpkg, metric_expr, metric_name,
>>> -			   metric_group, deprecated, metric_constraint);
>>> +		je->event = real_event(je->name, je->event);
>>> +		err = func(data, je);
>>>   free_strings:
>>> -		free(event);
>>> -		free(desc);
>>> -		free(name);
>>> -		free(long_desc);
>>>   		free(extra_desc);
>>> -		free(pmu);
>>>   		free(filter);
>>> -		free(perpkg);
>>> -		free(deprecated);
>>> -		free(unit);
>>> -		free(metric_expr);
>>> -		free(metric_name);
>>> -		free(metric_group);
>>> -		free(metric_constraint);
>>>   		free(arch_std);
>>> +		free(je);
>>>   		if (err)
>>>   			break;
>>> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
>>> index 2afc8304529e..e696edf70e9a 100644
>>> --- a/tools/perf/pmu-events/jevents.h
>>> +++ b/tools/perf/pmu-events/jevents.h
>>
>> Somewhat unrelated - this file only seems to be included in jevents.c, so I
>> don't see why it exists...
> 
> ah right.. I won't mind getting rid of it

Hi John and  Jiri
     Thanks for reviewing the patch. I can remove this file and add these structure inside jevents.c

Thanks,
Kajol Jain
>  
>>> @@ -2,14 +2,28 @@
>>>   #ifndef JEVENTS_H
>>>   #define JEVENTS_H 1
>>> +#include "pmu-events.h"
>>> +
>>> +struct json_event {
>>> +	char *name;
>>> +	char *event;
>>> +	char *desc;
>>> +	char *topic;
>>> +	char *long_desc;
>>> +	char *pmu;
>>> +	char *unit;
>>> +	char *perpkg;
>>> +	char *metric_expr;
>>> +	char *metric_name;
>>> +	char *metric_group;
>>> +	char *deprecated;
>>> +	char *metric_constraint;
>>
>> This looks very much like struct event_struct, so could look to consolidate:
>>
>> struct event_struct {
>> 	struct list_head list;
>> 	char *name;
>> 	char *event;
>> 	char *desc;
>> 	char *long_desc;
>> 	char *pmu;
>> 	char *unit;
>> 	char *perpkg;
>> 	char *metric_expr;
>> 	char *metric_name;
>> 	char *metric_group;
>> 	char *deprecated;
>> 	char *metric_constraint;
>> };
> 
> as Andi said they come from different layers, I think it's
> better to keep them separated even if they share some fields
> 
> thanks,
> jirka
> 
