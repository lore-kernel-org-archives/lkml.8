Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249FA207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T4DauheC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGVS6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:58:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:58:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MIwHeW122789;
        Wed, 22 Jul 2020 18:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sAphwe1RgUuRZsOlJoZzQQ58ZJatquG8fYVT5Tf6m0c=;
 b=T4DauheC2ahVGWcZbpWEnmQYwPqa5T92P2HMNEwtW/1QEX1rz+S8cfmo46n+Lq3sdIdy
 9WwnolhJy68jjmTQF5GJRPoStEYk3HBEshHST4jcjXnMeb3RTR1zb9QjL9VPbZqs/2RT
 CoTxIJGyaTlfhG44MVA5s4w3L+TGKfIYcjPDfibR/M9nYnddShJr7v406cFg803mzBgr
 ryUAXvomWEp8IQOBuIBSoHstYuA0XJ92HaBifvFSo6xy1Pqhf6A/kBIpuNtK8ImJmmHn
 zoujxIcQPeqahqL6uSk3gccYDJ1ln9Q0AmLVEhELinYRkVA7GQctkjSXFT7fcMbPKc9z Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32bs1mn5c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 18:58:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MIiHZJ195270;
        Wed, 22 Jul 2020 18:56:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32erherntw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 18:56:22 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06MIuJPM004457;
        Wed, 22 Jul 2020 18:56:19 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jul 2020 18:56:18 +0000
Subject: Re: [SchedulerWakeupLatency] Skipping Idle Cores and CPU Search
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Parth Shah <parth@linux.ibm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josef Bacik <jbacik@fb.com>
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
 <39cc4666-6355-fb9f-654d-e85e1852bc6f@linux.ibm.com>
 <ffcff197-122f-c5bd-91f4-0ff8600be04d@oracle.com>
 <c1b24dd5-dce9-61ed-baba-a70f08276bf5@arm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <e8ebbc84-bd7a-5d44-6229-a9712f4a1482@oracle.com>
Date:   Wed, 22 Jul 2020 14:56:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c1b24dd5-dce9-61ed-baba-a70f08276bf5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 4:47 AM, Dietmar Eggemann wrote:
> On 10/07/2020 01:08, chris hyser wrote:
> 
> [...]
> 
>>> D) Desired behavior:
>>
>> Reduce the maximum wake-up latency of designated CFS tasks by skipping
>> some or all of the idle CPU and core searches by setting a maximum idle
>> CPU search value (maximum loop iterations).
>>
>> Searching 'ALL' as the maximum would be the default and implies the
>> current code path which may or may not search up to ALL. Searching 0
>> would result in the least latency (shown with experimental results to be
>> included if/when patchset goes up). One of the considerations is that
>> the maximum length of the search is a function of the size of the LLC
>> scheduling domain and this is platform dependent. Whether 'some', i.e. a
>> numerical value limiting the search can be used to "normalize" this
>> latency across differing scheduling domain sizes is under investigation.
>> Clearly differing hardware will have many other significant differences,
>> but in different sized and dynamically sized VMs running on fleets of
>> common HW this may be interesting.
> 
> I assume that this task-specific feature could coexists in
> select_idle_core() and select_idle_cpu() with the already existing
> runtime heuristics (test_idle_cores() and the two sched features
> mentioned under E/F) to reduce the idle CPU search space on a busy system.

Yes, so perhaps a more generalized summary of the feature is that is simply places a per-task maximum number of 
iterations on the various 'for_each_cpu' loops (whose max is platform dependent) in this path. Any other technique to 
short circuit the loop below this max would be fine including the fact that the very first 'idle' check in a loop may 
succeed and that is perfectly ok in terms of minimizing the search latency. This really only kicks in on busy systems 
and while system or scheduling domain wide heuristics can reduce the cost to tasks for not doing something per-task like 
this, they can't drive the loop iteration search to 0 because that is BAD policy when applied to the wrong tasks or too 
many tasks.


> 
>>> E/F) Existing knobs (and limitations):
>>
>> There are existing sched_feat: SIS_AVG_CPU, SIS_PROP that attempt to
>> short circuit the idle cpu search path in select_idle_cpu() based on
>> estimations of the current costs of searching. Neither provides a means
> 
> [...]
> 
>>> H) Range Analysis:
>>
>> The knob is a positive integer representing "max number of CPUs to
>> search". The default would be 'ALL' which could be translated as
>> INT_MAX. '0 searches' translates to 0. Other values represent a max
>> limit on the search, in this case iterations of a for loop.
> 
> IMHO the opposite use case for this feature (favour high throughput over
> short wakeup latency (Facebook) is already cured by the changes
> introduced by commit 10e2f1acd010 ("sched/core: Rewrite and improve
> select_idle_siblings()"), i.e. with the current implementation of sis().
> 
> It seems that they don't need an additional per-task feature on top of
> the default system-wide runtime heuristics.

Agreed and I hope I've clarified how the attribute in question should not affect that as the default for the attribute 
is basically "no short cut because of this", other heuristics may apply.

-chrish
