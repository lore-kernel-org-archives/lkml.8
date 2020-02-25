Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB97FC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BC62176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgBYIQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:16:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729360AbgBYIQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:16:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P8E7U6014007
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:16:31 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yayb0jy27-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:16:31 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Feb 2020 08:16:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Feb 2020 08:16:24 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01P8GNgE47513644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 08:16:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E38152051;
        Tue, 25 Feb 2020 08:16:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.187])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8DCE75204E;
        Tue, 25 Feb 2020 08:16:20 +0000 (GMT)
Subject: Re: [PATCH v4 2/4] sched/core: Propagate parent task's latency
 requirements to the child task
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-3-parth@linux.ibm.com>
 <20200225063226.GJ28029@codeaurora.org>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Tue, 25 Feb 2020 13:46:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200225063226.GJ28029@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022508-0012-0000-0000-0000038A094B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022508-0013-0000-0000-000021C6AB0C
Message-Id: <a954a83b-ff3c-1fc2-a70e-7d1482502ed6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_02:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/20 12:02 PM, Pavan Kondeti wrote:
> On Mon, Feb 24, 2020 at 02:29:16PM +0530, Parth Shah wrote:
>> Clone parent task's latency_nice attribute to the forked child task.
>>
>> Reset the latency_nice value to default value when the child task is
>> set to sched_reset_on_fork.
>>
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
>> ---
>>  kernel/sched/core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 377ec26e9159..65b6c00d6dac 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2860,6 +2860,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>>  	 */
>>  	p->prio = current->normal_prio;
>>  
>> +	/* Propagate the parent's latency requirements to the child as well */
>> +	p->latency_nice = current->latency_nice;
>> +
>>  	uclamp_fork(p);
>>  
>>  	/*
>> @@ -2876,6 +2879,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>>  		p->prio = p->normal_prio = __normal_prio(p);
>>  		set_load_weight(p, false);
>>  
>> +		p->latency_nice = DEFAULT_LATENCY_NICE;
>>  		/*
>>  		 * We don't need the reset flag anymore after the fork. It has
>>  		 * fulfilled its duty:
>> -- 
>> 2.17.2
>>
> 
> LGTM.
> 
> latency_nice value initialization is missing for the init_task.

good catch. Will add that part too. Thanks for pointing out.

- Parth

> 
> Thanks,
> Pavan
> 

