Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66549C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4779A2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDTL1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:27:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:27:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KB34S6127499
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:27:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc2vvkqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:27:11 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 20 Apr 2020 12:26:20 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Apr 2020 12:26:16 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03KBR4rI62718008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 11:27:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0A09A4053;
        Mon, 20 Apr 2020 11:27:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18FA3A4040;
        Mon, 20 Apr 2020 11:26:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.176.37])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 11:26:56 +0000 (GMT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        steven.sistare@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <20190905113002.GK2349@hirez.programming.kicks-ass.net>
 <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
 <20200416000235.GA211099@google.com>
 <730928f8-b48b-ea3a-149a-18932eb18c90@arm.com>
 <CAEXW_YTnS7Gz38Rw55M8q5NnJZJntOqxRHPC_AZ0uaQo+G4RqA@mail.gmail.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Mon, 20 Apr 2020 16:56:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAEXW_YTnS7Gz38Rw55M8q5NnJZJntOqxRHPC_AZ0uaQo+G4RqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042011-0020-0000-0000-000003CB302E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042011-0021-0000-0000-000022242304
Message-Id: <7d4637c8-da8c-463d-30c6-a55c0a173316@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 4/18/20 9:31 PM, Joel Fernandes wrote:
> Hi Dietmar,
> 
> On Thu, Apr 16, 2020 at 1:23 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> Hi Joel,
>>
>> On 16.04.20 02:02, Joel Fernandes wrote:
>>> On Thu, Sep 05, 2019 at 12:47:26PM +0100, Qais Yousef wrote:
>>>> On 09/05/19 13:30, Peter Zijlstra wrote:
>>>>> On Thu, Sep 05, 2019 at 12:13:47PM +0100, Qais Yousef wrote:
>>>>>> On 09/05/19 12:46, Peter Zijlstra wrote:
>>>>>
>>>>>>> This is important because we want to be able to bias towards less
>>>>>>> importance to (tail) latency as well as more importantance to (tail)
>>>>>>> latency.
>>>>>>>
>>>>>>> Specifically, Oracle wants to sacrifice (some) latency for throughput.
>>>>>>> Facebook OTOH seems to want to sacrifice (some) throughput for latency.
>>>>>>
>>>>>> Another use case I'm considering is using latency-nice to prefer an idle CPU if
>>>>>> latency-nice is set otherwise go for the most energy efficient CPU.
>>>>>>
>>>>>> Ie: sacrifice (some) energy for latency.
>>>>>>
>>>>>> The way I see interpreting latency-nice here as a binary switch. But
>>>>>> maybe we can use the range to select what (some) energy to sacrifice
>>>>>> mean here. Hmmm.
>>>>>
>>>>> It cannot be binary, per definition is must be ternary, that is, <0, ==0
>>>>> and >0 (or middle value if you're of that persuasion).
>>>>
>>>> I meant I want to use it as a binary.
>>>>
>>>>>
>>>>> In your case, I'm thinking you mean >0, we want to lower the latency.
>>>>
>>>> Yes. As long as there's an easy way to say: does this task care about latency
>>>> or not I'm good.
>>>
>>> Qais, Peter, all,
>>>
>>> For ChromeOS (my team), we are planning to use the upstream uclamp mechanism
>>> instead of the out-of-tree schedtune mechanism to provide EAS with the
>>> latency-sensitivity (binary/ternary) hint. ChromeOS is thankfully quite a bit
>>> upstream focussed :)
>>>
>>> However, uclamp is missing an attribute to provide this biasing to EAS as we
>>> know.
>>>
>>> What was the consensus on adding a per-task attribute to uclamp for providing
>>> this? Happy to collaborate on this front.
>>
>> We're planning to have a session about this topic (latency-nice
>> attribute per task group) during the virtual Pisa OSPM summit
>> retis.sssup.it/ospm-summit in May this year.
> 
> Cool, I registered as well.
> 
>>
>> There are two presentations/discussions planned:
>>
>> "Introducing Latency Nice for Scheduler Hints and Optimizing Scheduler
>> Task Wakeup" and "The latency nice use case for Energy-Aware-Scheduling
>> (EAS) in Android Common Kernel (ACK)"
>>
>> We'll probably merge those two into one presentation/discussion.
>>
>> So far we have Parth's per-task implementation
>>
>> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com
> 
> Cool, I see it has some Reviewed-by tags so that's a good sign. Will
> look more into that.
> 
>> What's missing is the per-taskgroup implementation, at least from the
>> standpoint of ACK.
>>
>> The (mainline) EAS use-case for latency nice is already in ACK
>> (android-5.4):
>>
>> https://android.googlesource.com/kernel/common/+/760b82c9b88d2c8125abfc5f732cc3cd460b2a54
> 
> Yes, I was aware of this. But if we use task groups, then the
> transition from schedtune -> uclamp means now the tasks that use
> uclamp would also be subjected to cpu.shares. That's why we were
> looking into the per-task interface and glad there's some work on this
> already done.
> 

Yes, that series of latency_nice seems to be in good shape to be used for
any usecases. Hopefully, OSPM will lead to its upstreaming sooner :-)
But at the end, we aim to have both the per-task and cgroup based interface
to mark the latency_nice value of a task.
Till, then I'm finding some generic use-cases to show benefits of such task
attribute to increase community interest.


Thanks,
Parth

