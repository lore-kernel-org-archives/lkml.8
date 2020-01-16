Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F7DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC78720663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgAPME7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:04:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbgAPME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:04:58 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GBvihx023815
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:04:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfaw2cnka-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:04:56 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 16 Jan 2020 12:04:53 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Jan 2020 12:04:49 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00GC4mMq44827046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 12:04:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98BB3A405B;
        Thu, 16 Jan 2020 12:04:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53105A405C;
        Thu, 16 Jan 2020 12:04:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 12:04:46 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] Introduce per-task latency_tolerance for scheduler
 hints
To:     Dhaval Giani <dhaval.giani@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, qperret@qperret.net,
        David.Laight@ACULAB.COM, pjt@google.com, tj@kernel.org,
        dietmar.eggemann@arm.com, Chris Deon Hyser <chris.hyser@oracle.com>
References: <20191208060410.17814-1-parth@linux.ibm.com>
 <5a13d54a-7e16-8d6c-8362-bd5f056004db@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 16 Jan 2020 17:34:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5a13d54a-7e16-8d6c-8362-bd5f056004db@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011612-0008-0000-0000-00000349E277
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011612-0009-0000-0000-00004A6A3C08
Message-Id: <a3fd8b12-1860-0f60-f8b1-ae97894b2eb4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_03:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhaval,

On 1/16/20 2:03 AM, Dhaval Giani wrote:
> 
> 
> On 12/7/19 10:04 PM, Parth Shah wrote:
>> This is the 2nd revision of the patch set to introduce latency_tolerance as
>> a per task attribute.
>>
>> The previous version can be found at:
>> v1: https://lkml.org/lkml/2019/11/25/151
>>
>> Changes in this revision are:
>> v1 -> v2:
>> - Addressed comments from Qais Yousef
>> - As per suggestion from Dietmar, moved content from newly created
>>   include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
>> - Extend sched_setattr() to support latency_tolerance in tools headers UAPI
>>
>>
>> This patch series introduces a new per-task attribute latency_tolerance to
>> provide the scheduler hints about the latency requirements of the task [1].
>>
>> Latency_tolerance is a ranged attribute of a task with the value ranging
>> from [-20, 19] both inclusive which makes it align with the task nice
>> value.
>>
>> The value should provide scheduler hints about the relative latency
>> requirements of tasks, meaning the task with "latency_tolerance = -20"
>> should have lower latency than compared to those tasks with higher values.
>> Similarly a task with "latency_tolerance = 19" can have higher latency and
>> hence such tasks may not care much about latency.
>>
>> The default value is set to 0. The usecases discussed below can use this
>> range of [-20, 19] for latency_tolerance for the specific purpose. This
>> patch does not implement any use cases for such attribute so that any
>> change in naming or range does not affect much to the other (future)
>> patches using this. The actual use of latency_tolerance during task wakeup
>> and load-balancing is yet to be coded for each of those usecases.
>>
>> As per my view, this defined attribute can be used in following ways for a
>> some of the usecases:
>> 1 Reduce search scan time for select_idle_cpu():
>> - Reduce search scans for finding idle CPU for a waking task with lower
>>   latency_tolerance values.
>>
>> 2 TurboSched:
>> - Classify the tasks with higher latency_tolerance values as a small
>>   background task given that its historic utilization is very low, for
>>   which the scheduler can search for more number of cores to do task
>>   packing.  A task with a latency_tolerance >= some_threshold (e.g, >= +18)
>>   and util <= 12.5% can be background tasks.
>>
>> 3 Optimize AVX512 based workload:
>> - Bias scheduler to not put a task having (latency_tolerance == -20) on a
>>   core occupying AVX512 based workload.
> 
> Have you been able to adapt any of these use cases to this new interface?
> 
> Does the interface translate well to them?
> 
> Do you have any code that you can share?

Yes, I am able to adapt this patch set for TurboSched and proves useful for
classifying low latency requiring tasks and pack those on fewer number of
cores. I am able to pack the tasks having
latency_tolerance==MAX_LATENCY_TOLERANCE.

I will send the RFC v6 of the TurboSched soon on the lkml, which uses the
latency_{nice/tolerance}.


Thanks,
Parth

> 
> Dhaval
> 

