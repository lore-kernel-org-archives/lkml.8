Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD465C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4E42077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATIxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:53:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgATIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:53:38 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K8nXFc083810;
        Mon, 20 Jan 2020 03:53:28 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg7gyr7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 03:53:27 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00K8nZEl084091;
        Mon, 20 Jan 2020 03:53:27 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg7gyr6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 03:53:27 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00K8qB9N031902;
        Mon, 20 Jan 2020 08:53:26 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 2xksn6df81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 08:53:26 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00K8rPUT41550268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 08:53:25 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D6626E04E;
        Mon, 20 Jan 2020 08:53:25 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F50F6E04C;
        Mon, 20 Jan 2020 08:53:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.136])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jan 2020 08:53:20 +0000 (GMT)
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200108065844.4030-1-kjain@linux.ibm.com>
 <e866c12a-7328-8524-fd0e-668301da6875@linux.intel.com>
 <822bcb9d-4c08-39c5-e6e7-9c3e20d77852@linux.ibm.com>
 <20200108160249.GD402774@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <dde66abd-6025-31e3-9bda-a6eb1986eea8@linux.ibm.com>
Date:   Mon, 20 Jan 2020 14:23:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200108160249.GD402774@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/20 9:32 PM, Jiri Olsa wrote:
> On Wed, Jan 08, 2020 at 02:41:35PM +0530, kajoljain wrote:
>
> SNIP
>
>>>> -    int i = 0;
>>>> +    int i = 0, j = 0;
>>>>        bool leader_found;
>>>>          evlist__for_each_entry (perf_evlist, ev) {
>>>> +        j++;
>>>> +        if (j <= iterator_perf_evlist)
>>>> +            continue;
>>>>            if (!strcmp(ev->name, ids[i])) {
>>>>                if (!metric_events[i])
>>>>                    metric_events[i] = ev;
>>>> @@ -146,6 +151,7 @@ static struct evsel *find_evsel_group(struct
>>>> evlist *perf_evlist,
>>>>                }
>>>>            }
>>>>        }
>>>> +    iterator_perf_evlist = j;
>>>>          return metric_events[0];
>>>>    }
>>>>
>>> Thanks for reporting and fixing this issue.
>>>
>>> I just have one question, do we really need a *static variable* to track
>>> the matched events? Perhaps using an input parameter?
>> Hi Jin,
>>
>> The other way I come up with to solve this issue is, making change in
>> perf_evlist itself by adding some flag in event name, to keep track of
>> matched events.
>>
>> As if we change event name itself, next time when we compare it won't
>> matched. But in that case we need to remove those flag later. Which will
>> increase the
>>
>> complexity. If you have any suggestions, please let me know.
> we already keep evsel::cpu_iter for similar concept
>
> so I guess we could have some iterator_perf_evlist variable in evlist..
> that is if we don't find other solution (other than static varable)

Hi Jiri,

          Thanks for reviewing the patch. I checked 'evsel::cpu_iter' 
variable, I think it added recently and I am not able to find any 
similar kind of variable in

          evlist. Please let me know if my understanding is fine. Do you 
want me to add new variable in evlist itself or there is any other way 
possible.

Thanks,

Kajol




> thanks,
> jirka
>
