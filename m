Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3EC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2933C207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgBUKCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:02:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbgBUKCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:02:05 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L9wZRt119365
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:02:04 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ueffhhj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:02:04 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 21 Feb 2020 10:02:02 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 10:01:58 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LA113e46399914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 10:01:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4374752052;
        Fri, 21 Feb 2020 10:01:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.251])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EDA3A52059;
        Fri, 21 Feb 2020 10:01:54 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
To:     Qais Yousef <qais.yousef@arm.com>,
        chris hyser <chris.hyser@oracle.com>
Cc:     vincent.guittot@linaro.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, dhaval.giani@oracle.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, pavel@ucw.cz,
        qperret@qperret.net, David.Laight@ACULAB.COM, pjt@google.com,
        tj@kernel.org
References: <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
 <971909ed-d4e0-6afa-d20b-365ede5a195e@linux.ibm.com>
 <8e984496-e89b-d96c-d84e-2be7f0958ea4@oracle.com>
 <1e216d18-7ec0-4a0d-e124-b730d6e03e6f@oracle.com>
 <de5d8886-6f70-a3fa-8061-5877cd1d98f5@linux.ibm.com>
 <7429e0ae-41ff-e9c4-dd65-3ef1919f5f50@linux.ibm.com>
 <a332d633-7826-b85d-5d9f-5e34f9de084a@oracle.com>
 <20200220150343.dvweamfnk257pg7z@e107158-lin.cambridge.arm.com>
 <9bb1437b-3de0-b0ca-6319-6be903b0758d@oracle.com>
 <20200221092956.jpsfps2dgmhiu5vg@e107158-lin.cambridge.arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 21 Feb 2020 15:31:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200221092956.jpsfps2dgmhiu5vg@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022110-0008-0000-0000-000003550EE1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022110-0009-0000-0000-00004A76215E
Message-Id: <bf063130-cd08-2d7b-40eb-84575b4ba271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_02:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=2 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/20 2:59 PM, Qais Yousef wrote:
> On 02/20/20 11:34, chris hyser wrote:
>>>> Whether called a hint or not, it is a trade-off to reduce latency of select
>>>> tasks at the expense of the throughput of the other tasks in the the system.
>>>
>>> Does it actually affect the throughput of the other tasks? I thought this will
>>> allow the scheduler to reduce latencies, for instance, when selecting which cpu
>>> it should land on. I can't see how this could hurt other tasks.
>>
>> This is why it is hard to argue about pure abstractions. The primary idea
>> mentioned so far for how these latencies are reduced is by short cutting the
>> brute-force search for something idle. If you don't find an idle cpu because
>> you didn't spend the time to look, then you pre-empted a task, possibly with
>> a large nice warm cache footprint that was cranking away on throughput. It
>> is ultimately going to be the usual latency vs throughput trade off. If
>> latency reduction were "free" we wouldn't need a per task attribute. We
>> would just do the reduction for all tasks, everywhere, all the time.
> 
> This could still happen without the latency nice bias. I'm not sure if this
> falls under DoS; maybe if you end up spawning a lot of task with high latency
> nice value, then you might end up cramming a lot of tasks on a small subset of
> CPUs. But then, shouldn't the logic that uses latency_nice try to handle this
> case anyway since it could be legit?
> 
> Not sure if this can be used by someone to trigger timing based attacks on
> another process.
> 
> I can't fully see the whole security implications, but regardless. I do agree
> it is prudent to not allow tasks to set their own latency_nice. Mainly because
> the meaning of this flag will be system dependent and I think Admins are the
> better ones to decide how to use this flag for the system they're running on.
> I don't think application writers should be able to tweak their tasks
> latency_nice value. Not if they can't get the right privilege at least.
> 

AFAICT if latency_nice is really used for scheduler hints to provide
latency requirements, then the worst that can happen is the user can
request to have all the created tasks get least latency (which might not
even be possible). Hence, unless we bias priority or vruntime, I don't see
the DoS possibility with latency_nice.

Being conservative for future and considering that only Admin may make
correct decision, I do think to not allow non-root user to give -ve values
for latency_nice.

NICE don't allow reducing the task_nice value even if the value has been
increase by the same user in the past. From my understandings, this don't
make sense much for the latency_nice and user should be free to choose any
value in the range [0,19].


- Parth

>>
>>>
>>> Can you expand on the scenario you have in mind please?
>>
>> Hopefully, the above helps. It was my original plan to introduce this with a
>> data laden RFC on the topic, but I felt the need to respond to Parth
>> immediately. I'm not currently pushing any particular change.
> 
> Thanks!
> 
> --
> Qais Yousef
> 

