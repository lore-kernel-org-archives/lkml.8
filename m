Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB15FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9139820870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHLbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:31:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbgEHLbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:31:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048B34h9065473;
        Fri, 8 May 2020 07:30:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtt0hj9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 07:30:54 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048B4mav072299;
        Fri, 8 May 2020 07:30:54 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtt0hj85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 07:30:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048BJuDl014415;
        Fri, 8 May 2020 11:30:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5w98e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 11:30:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048BUnkj63570376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 11:30:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5149342061;
        Fri,  8 May 2020 11:30:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 103FB4205E;
        Fri,  8 May 2020 11:30:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.16.192])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 May 2020 11:30:45 +0000 (GMT)
Subject: Re: [RFC 1/4] sched/core: Introduce per_cpu counter to track latency
 sensitive tasks
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-2-parth@linux.ibm.com>
 <20200508084002.GK19464@codeaurora.org>
From:   Parth Shah <parth@linux.ibm.com>
Message-ID: <552146c4-abee-1c8e-38fd-7ac3679c2ad9@linux.ibm.com>
Date:   Fri, 8 May 2020 17:00:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200508084002.GK19464@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_08:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/20 2:10 PM, Pavan Kondeti wrote:
> On Thu, May 07, 2020 at 07:07:20PM +0530, Parth Shah wrote:
>> The "nr_lat_sensitive" per_cpu variable provides hints on the possible
>> number of latency-sensitive tasks occupying the CPU. This hints further
>> helps in inhibiting the CPUIDLE governor from calling deeper IDLE states
>> (next patches includes this).
>>
> 
> Can you please explain the intended use case here? Once a latency sensitive
> task is created, it prevents c-state on a CPU whether the task runs again
> or not in the near future.
> 
> I assume, either these latency sensitive tasks won't be around for long time
> or applications set/reset latency sensitive nice value dynamically.
> 

Intended use-cases is to get rid of IDLE states exit_latency for
wakeup-sleep-wakeup pattern workload. This types of tasks (like GPU
workloads, few DB benchmarks) makes CPU go IDLE due to its low runtime on
rq, resulting in higher wakeups due to IDLE states exit_latency.

And this kind of workloads may last for long time as well.

In current scenario, Sysadmins do disable all IDLE states or use PM_QoS to
not have latency penalty on workload. This model was good when core counts
were less. But now higher core count and Turbo frequencies have led to save
power in-order to get higher performance and hence this patch-set tries to
do PM_QoS like thing but at per-task granularity.

If idea seems good to go, then this can potentially be extended to do IDLE
gating upto certain level where latency_nice value hints on which IDLE
states can't be chosen, just like PM_QoS have cpu_dma_latency constraints.


Thanks,
Parth


> Thanks,
> Pavan
> 
