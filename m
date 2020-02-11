Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8881BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6618320870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgBKLVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:21:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37350 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727728AbgBKLVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:21:44 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BBKjlg196478;
        Tue, 11 Feb 2020 06:21:33 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1uck67g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 06:21:29 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01BBLDPY001680;
        Tue, 11 Feb 2020 06:21:13 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1uck678j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 06:21:13 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01BBK22Q027906;
        Tue, 11 Feb 2020 11:20:47 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 2y1mm6xww1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 11:20:47 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01BBKkUO58982824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 11:20:46 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75025BE056;
        Tue, 11 Feb 2020 11:20:46 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85EB1BE062;
        Tue, 11 Feb 2020 11:20:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.123])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Feb 2020 11:20:42 +0000 (GMT)
Subject: Re: [PATCH v3] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     Jiri Olsa <jolsa@redhat.com>, Joe Perches <joe@perches.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200131052522.7267-1-kjain@linux.ibm.com>
 <20200206184510.GA1669706@krava>
 <51a4b570eb47e80801a460c89acf20d13a269600.camel@perches.com>
 <20200210121135.GI1907700@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <c168e38f-ee24-f02c-9510-912ef4d3d6b4@linux.ibm.com>
Date:   Tue, 11 Feb 2020 16:50:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200210121135.GI1907700@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_03:2020-02-10,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 5:41 PM, Jiri Olsa wrote:
> On Thu, Feb 06, 2020 at 10:58:12AM -0800, Joe Perches wrote:
>> On Thu, 2020-02-06 at 19:45 +0100, Jiri Olsa wrote:
>>> On Fri, Jan 31, 2020 at 10:55:22AM +0530, Kajol Jain wrote:
>>>
>>> SNIP
>>>
>>>>  				ev->metric_leader = metric_events[i];
>>>>  			}
>>>> +			j++;
>>>>  		}
>>>> +		ev = metric_events[i];
>>>> +		evlist_used[ev->idx] = true;
>>>>  	}
>>>>  
>>>>  	return metric_events[0];
>>>> @@ -160,6 +161,9 @@ static int metricgroup__setup_events(struct list_head *groups,
>>>>  	int ret = 0;
>>>>  	struct egroup *eg;
>>>>  	struct evsel *evsel;
>>>> +	bool evlist_used[perf_evlist->core.nr_entries];
>>>> +
>>>> +	memset(evlist_used, 0, perf_evlist->core.nr_entries);
>>>
>>> I know I posted this in the previous email, but are we sure bool
>>> is always 1 byte?  would sizeod(evlist_used) be safer?


Hi jiri,
     Yes you are right. We should use 'evlist_used' size itself.

>>>
>>> other than that it looks ok
>>>
>>> Andi, you're ok with this?
>>
>> stack declarations of variable length arrays are not
>> a good thing.
>>
>> https://lwn.net/Articles/749089/
>>
>> and
>>
>> 	bool evlist_used[perf_evlist->core.nr_entries] = {};


I am planning to use calloc and free that memory later in function 'metricgroup__setup_events'.
Something like this. 


+       bool *evlist_used;
+
+       evlist_used = (bool *)calloc(perf_evlist->core.nr_entries,
+                                    sizeof(bool));
+       if (!evlist_used) {
+               ret = -ENOMEM;
+               break;
+       }

Please let me know if its looking fine.

Thanks,
Kajol

> 
> hum, I think we already have few of them in perf ;-)
> thanks for the link
> 
> right, that initialization is of course much better, thanks
> 
> jirka
> 
