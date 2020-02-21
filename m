Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D93C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8370208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eAXmvtsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgBUQvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:51:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53010 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBUQvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:51:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LGmvhZ192967;
        Fri, 21 Feb 2020 16:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=71MavVmrPvpOGPamK3jUDjcxHU6zKPseRfT+7KN2tgQ=;
 b=eAXmvtsTsAaXneK94skMatt/ZRC7xJqrX92pwi2EVGp9kTZSAbH/3aMXYD+aLbxSz5VT
 yGgVyUOcOvyEVu82LGCXSzHKlAs86RZm0zKP1xu/lnwXDfRxI42RkGzvoR9HlK9Vwpq3
 jyW5A6xUtsCJtVILdMjJ0KRbrLEi+ABj/5c/UsjU0dZBqLDebJ6KqiBuGjdK52X8zliH
 vZjSW3kuhmzdYlZ0ty3FsiFcaP1W03SDgARBzQEZUraX2s+8FcwehCWFwG8DXJ3cT4o8
 zjC5d+3Yi5qbJOiZD0xF0z5i4+o8mXplDLYNe7IBpQzAKICVaGsl+yZN0b0Pt5dkX2pF Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8uddhqe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 16:51:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LGmt7D043940;
        Fri, 21 Feb 2020 16:51:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y8udnw61c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 16:51:18 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01LGpBo7017970;
        Fri, 21 Feb 2020 16:51:12 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 08:51:11 -0800
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
To:     Parth Shah <parth@linux.ibm.com>, Qais Yousef <qais.yousef@arm.com>
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
 <bf063130-cd08-2d7b-40eb-84575b4ba271@linux.ibm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <2983937b-d2de-d1ab-e387-271c7caf2a81@oracle.com>
Date:   Fri, 21 Feb 2020 11:51:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bf063130-cd08-2d7b-40eb-84575b4ba271@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=2 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=2
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 5:01 AM, Parth Shah wrote:
> 
> 
> On 2/21/20 2:59 PM, Qais Yousef wrote:
>> On 02/20/20 11:34, chris hyser wrote:
>>>>> Whether called a hint or not, it is a trade-off to reduce latency of select
>>>>> tasks at the expense of the throughput of the other tasks in the the system.
>>>>
>>>> Does it actually affect the throughput of the other tasks? I thought this will
>>>> allow the scheduler to reduce latencies, for instance, when selecting which cpu
>>>> it should land on. I can't see how this could hurt other tasks.
>>>
>>> This is why it is hard to argue about pure abstractions. The primary idea
>>> mentioned so far for how these latencies are reduced is by short cutting the
>>> brute-force search for something idle. If you don't find an idle cpu because
>>> you didn't spend the time to look, then you pre-empted a task, possibly with
>>> a large nice warm cache footprint that was cranking away on throughput. It
>>> is ultimately going to be the usual latency vs throughput trade off. If
>>> latency reduction were "free" we wouldn't need a per task attribute. We
>>> would just do the reduction for all tasks, everywhere, all the time.
>>
>> This could still happen without the latency nice bias. I'm not sure if this
>> falls under DoS; maybe if you end up spawning a lot of task with high latency
>> nice value, then you might end up cramming a lot of tasks on a small subset of
>> CPUs. But then, shouldn't the logic that uses latency_nice try to handle this
>> case anyway since it could be legit?
>>
>> Not sure if this can be used by someone to trigger timing based attacks on
>> another process.
>>
>> I can't fully see the whole security implications, but regardless. I do agree
>> it is prudent to not allow tasks to set their own latency_nice. Mainly because
>> the meaning of this flag will be system dependent and I think Admins are the
>> better ones to decide how to use this flag for the system they're running on.
>> I don't think application writers should be able to tweak their tasks
>> latency_nice value. Not if they can't get the right privilege at least.
>>
> 
> AFAICT if latency_nice is really used for scheduler hints to provide
> latency requirements, then the worst that can happen is the user can
> request to have all the created tasks get least latency (which might not
> even be possible). Hence, unless we bias priority or vruntime, I don't see
> the DoS possibility with latency_nice.

A latency nice that does not allow reducing the latency of select tasks at the expense of the throughput of other tasks 
(ie the classic trade-off) doesn't seem to be all that useful and would fail to meet the requirements. Latency nice in 
this view is a directive on how to make that trade-off much like nice is a directive on how to trade-off what should get 
to run next and we don't accept the system optionally treating +19 and -20 tasks the same. Even when we don't get 
exactly what we want we expect "best effort" and that is not the same as optional.

-chrish


