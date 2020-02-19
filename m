Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C621C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3312424656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iB9qxeif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBSRRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:17:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35620 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgBSRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:17:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JHDBHa103535;
        Wed, 19 Feb 2020 17:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=73kbc7sX76Gr4HjDNq/jj2n23ipbr26ddf0jVYeGy64=;
 b=iB9qxeife3op9zsK+6OpUa/cLVFp+vxDjTP+zUznMV8SUwJbRDQV6NU4jRYczHr5HbDC
 jJyzqoXrpNFjnJWhSaS/KPZ6Nq7TXDqAn3258psvaBJKr9h669/HtERT1gJpLee9rSlA
 KupOWfXl/Zw7d2p0mh+HAz8ZVpamrHr5UE9M/TOX2tyaAQWtueCJOTb9SmlU6R4SaFtK
 15fC9GSAXM2OBe2JU0854Xvrj1DobgdbGKrmTcllIXR7UfCbEMpaggz8iZbeQAuOwvkP
 mjAsQpPBTHmAGcT3Yzykr4O8eXhRl2TbrP3eDOLXonrjggIJOIHg5c7ukNkAaoX5Knlt sQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y8udd4m0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 17:17:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JHCGnB023515;
        Wed, 19 Feb 2020 17:17:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y8udavyhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 17:17:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JHHBYq028822;
        Wed, 19 Feb 2020 17:17:12 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 09:17:11 -0800
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
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <10f42efa-3750-491a-74fe-d84c9c4924e3@oracle.com>
Date:   Wed, 19 Feb 2020 12:16:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3ce2e8940fb14d95b011c8b30892aa62@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 6:18 AM, David Laight wrote:
> From: chris hyser
>> Sent: 18 February 2020 23:00
> ...
>> All, I was asked to take a look at the original latency_nice patchset.
>> First, to clarify objectives, Oracle is not
>> interested in trading throughput for latency.
>> What we found is that the DB has specific tasks which do very little but
>> need to do this as absolutely quickly as possible, ie extreme latency
>> sensitivity. Second, the key to latency reduction
>> in the task wakeup path seems to be limiting variations of "idle cpu" search.
>> The latter particularly interests me as an example of "platform size
>> based latency" which I believe to be important given all the varying size
>> VMs and containers.
> 
>  From my experiments there are a few things that seem to affect latency
> of waking up real time (sched fifo) tasks on a normal kernel:

Sorry. I was only ever talking about sched_other as per the original patchset. I realize the term extreme latency 
sensitivity may have caused confusion. What that means to DB people is no doubt different than audio people. :-)

> 
> 1) The time taken for the (intel x86) cpu to wakeup from monitor/mwait.
>     If the cpu is allowed to enter deeper sleep states this can take 900us.
>     Any changes to this are system-wide not process specific.
> 
> 2) If the cpu an RT process last ran on (ie the one it is woken on) is
>     running in kernel, the process switch won't happen until cond_reshed()
>     is called.
>     On my system the code to flush the display frame buffer takes 3.3ms.
>     Compiling a kernel with CONFIG_PREEMPT=y will reduce this.
> 
> 3) If a hardware interrupt happens just after the process is woken
>     then you have to wait until it finishes and any 'softint' work
>     that is scheduled on the same cpu finishes.
>     The ethernet driver transmit completions an receive ring filling
>     can easily take 1ms.
>     Booting with 'threadirq' might help this.
> 
> 4) If you need to acquire a lock/futex then you need to allow for the
>     process that holds it being delayed by a hardware interrupt (etc).
>     So even if the lock is only held for a few instructions it can take
>     a long time to acquire.
>     (I need to change some linked lists to arrays indexed by an atomically
>     incremented global index.)
> 
> FWIW I can't imagine how a database can have anything that is that
> latency sensitive.
> We are doing lots of channels of audio processing and have a lot of work
> to do within 10ms to avoid audible errors.

There are existing internal numbers that I will ultimately have to duplicate that show that simply short-cutting these 
idle cpu searches has a significant benefit on DB performance on large hardware. However that was for a different 
patchset involving things I don't like so I'm still exploring how to achieve similar results within the latency_nice 
framework.

-chrish
