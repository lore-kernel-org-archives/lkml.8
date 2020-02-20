Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17894C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4A920659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W7Xbyozo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBTP4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:56:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36784 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgBTP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:56:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KFlRVe131311;
        Thu, 20 Feb 2020 15:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=G+CFuAFevU0UvGzgyujY9EHrI4dfidkI/fcfUAghG+4=;
 b=W7XbyozorUajWdI0DAxjDS4ikVXI6pha0O/yUYkQE0l6ZvBpAwfvPBIu0uT2ldGBm6JV
 2noaNC8ZksCzTEOis8r4yq6VF+z6HWa/r+oWxc9UVpk1CdKS4OINeZHEI4FVOfBVysK0
 4lkB2MDBgZimm5SyoLHoKO/1stLhSqHbLgN5HmjcrRWFP5bGBlToum0/IZhHSZnDWelU
 hyNJZXHSxLQLhRdULphUSs2fRZB/0hR0914G8NUWhfvz+SfdpbpObd+rlSVDe96RdY5Q
 ldDn9JZNKAhC7dvF4rm8mv1SrriBrXVhqezsb3Hf3OP7ec0OP7Bo385YgSZFS5BNf90X MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y8udkjnam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:56:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KFlsYW012773;
        Thu, 20 Feb 2020 15:56:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y8ud43uqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:56:12 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01KFu9GJ023160;
        Thu, 20 Feb 2020 15:56:09 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 07:56:09 -0800
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
To:     David Laight <David.Laight@ACULAB.COM>,
        Parth Shah <parth@linux.ibm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dhaval.giani@oracle.com" <dhaval.giani@oracle.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "qperret@qperret.net" <qperret@qperret.net>,
        "pjt@google.com" <pjt@google.com>, "tj@kernel.org" <tj@kernel.org>
References: <20200116120230.16759-1-parth@linux.ibm.com>
 <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
 <3ce2e8940fb14d95b011c8b30892aa62@AcuMS.aculab.com>
 <10f42efa-3750-491a-74fe-d84c9c4924e3@oracle.com>
 <2870e44f41414fd58b58f7831d7386fe@AcuMS.aculab.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <7b50c0ee-5e2b-5cec-a7f6-514abdc5ee18@oracle.com>
Date:   Thu, 20 Feb 2020 10:55:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2870e44f41414fd58b58f7831d7386fe@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=779 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=833 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/20 9:39 AM, David Laight wrote:
> From: chris hyser <chris.hyser@oracle.com>
>> Sent: 19 February 2020 17:17
>>
>> On 2/19/20 6:18 AM, David Laight wrote:
>>> From: chris hyser
>>>> Sent: 18 February 2020 23:00
>>> ...
>>>> All, I was asked to take a look at the original latency_nice patchset.
>>>> First, to clarify objectives, Oracle is not
>>>> interested in trading throughput for latency.
>>>> What we found is that the DB has specific tasks which do very little but
>>>> need to do this as absolutely quickly as possible, ie extreme latency
>>>> sensitivity. Second, the key to latency reduction
>>>> in the task wakeup path seems to be limiting variations of "idle cpu" search.
>>>> The latter particularly interests me as an example of "platform size
>>>> based latency" which I believe to be important given all the varying size
>>>> VMs and containers.
>>>
>>>   From my experiments there are a few things that seem to affect latency
>>> of waking up real time (sched fifo) tasks on a normal kernel:
>>
>> Sorry. I was only ever talking about sched_other as per the original patchset. I realize the term
>> extreme latency
>> sensitivity may have caused confusion. What that means to DB people is no doubt different than audio
>> people. :-)
> 
> Shorter lines.....
> 
> ISTM you are making some already complicated code even more complex.
> Better to make it simpler instead.

The code already exists to set a limit to bail out of what is sometimes a needlessly excessive search. Setting that 
based on an integer doesn't seem particularly complex. Now whether that is actually useful is what I'm currently looking at.

> 
> If you need a thread to run as soon as possible after it is woken
> why not use the RT scheduler (eg SCHED_FIFO) that is what it is for.

Overkill and doesn't play well with cpu cgroup controller.


> 
> If there are delays finding an idle cpu to migrate a process to
> (especially on systems with large numbers of cpu) then that is a
> general problem that can be addressed without extra knobs.

There is no if. It is a brute force search. There are delays proportional to the search domain size. You can optimize 
the hell of out the brute force, or you use obtained knowledge to bail out early. Getting that knowledge from the user 
is a time honored tradition. :-)

-chrish
