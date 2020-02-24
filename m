Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EE1C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20CC20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgBXKFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:05:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgBXKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:05:41 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OA4jlq144248
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 05:05:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yax37eew5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 05:05:40 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 24 Feb 2020 10:05:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 10:05:34 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01OA5XwJ43057346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 10:05:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3699A52050;
        Mon, 24 Feb 2020 10:05:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.160])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 57B3B5204E;
        Mon, 24 Feb 2020 10:05:31 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] sched/pelt: Add a new runnable average signal
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com, hdanton@sina.com
References: <20200221132715.20648-1-vincent.guittot@linaro.org>
 <20200221132715.20648-5-vincent.guittot@linaro.org>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Mon, 24 Feb 2020 15:35:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200221132715.20648-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022410-0020-0000-0000-000003AD0AED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022410-0021-0000-0000-000022051B71
Message-Id: <1bf450ee-a731-794c-452c-654a508365b5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_02:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=793 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/20 6:57 PM, Vincent Guittot wrote:
> Now that runnable_load_avg has been removed, we can replace it by a new
> signal that will highlight the runnable pressure on a cfs_rq. This signal
> track the waiting time of tasks on rq and can help to better define the
> state of rqs.

[...]

> @@ -5389,6 +5444,11 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
>  	return load;
>  }
>  
> +static unsigned long cpu_runnable(struct rq *rq)
> +{
> +	return cfs_rq_runnable_avg(&rq->cfs);
> +}

Why not move cpu-runnable definition to Patch 5? to get rid of
warning: ‘cpu_runnable’ defined but not used [-Wunused-function]
static unsigned long cpu_runnable(struct rq *rq)

[...]

- Parth

