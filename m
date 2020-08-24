Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583B8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A78204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jC40hn4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgHXNkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:40:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727859AbgHXNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:38:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ODWAun037927;
        Mon, 24 Aug 2020 09:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=J6snxcYbQgYaI1dLzLSaJ+5USc2AXUnB6IShN2cfXmU=;
 b=jC40hn4mTYC5ra28Pn3LuGL/MNVFMZ3H3vO9T+UpSly+BYV7i/QrGwihLczp09CkrloW
 84DbDqNjdPUBHKoo666FdNfe4TdZu/AxXBbSsxNlPIrURWlFeOVMThj7jH1P7LMCDPZT
 il6Bpep98ZARYgKOHj/4cZqUtw3DVNjhaD/SEirzd5FUIud6QGA3t7+nXm+yCyWa2uj1
 E1KTnE767U9PkUz+16bQouc0lARrQLAebfJz2ghhGQ00Rw1CU8VwvnxHNbS9nXo3Hbfb
 /N5QSPff02znXT7wsGGpIoeG0uTISjyLnaT5OJhgv12x/42Km00ahtmS+6pLYooWfqdc tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334eamgmcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 09:38:27 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07ODWGbi038571;
        Mon, 24 Aug 2020 09:38:27 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334eamgmbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 09:38:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07ODbKH6008980;
        Mon, 24 Aug 2020 13:38:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 332ujjsfj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 13:38:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07ODcMhu25756104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 13:38:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B46194C04A;
        Mon, 24 Aug 2020 13:38:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4376A4C040;
        Mon, 24 Aug 2020 13:38:21 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 24 Aug 2020 13:38:21 +0000 (GMT)
Date:   Mon, 24 Aug 2020 19:08:20 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix wrong cpu selecting from isolated domain
Message-ID: <20200824133820.GA31355@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Xunlei Pang <xlpang@linux.alibaba.com> [2020-08-24 20:30:19]:

> We've met problems that occasionally tasks with full cpumask
> (e.g. by putting it into a cpuset or setting to full affinity)
> were migrated to our isolated cpus in production environment.
> 
> After some analysis, we found that it is due to the current
> select_idle_smt() not considering the sched_domain mask.
> 
> Fix it by checking the valid domain mask in select_idle_smt().
> 
> Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
> Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a05..fa942c4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6075,7 +6075,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>  /*
>   * Scan the local SMT mask for idle CPUs.
>   */
> -static int select_idle_smt(struct task_struct *p, int target)
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	int cpu;
>  
> @@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p, int target)
>  		return -1;
>  
>  	for_each_cpu(cpu, cpu_smt_mask(target)) {
> -		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
>  			continue;

Don't think this is right thing to do.  What if this task had set a cpumask
that doesn't cover all the cpus in this sched_domain_span(sd)

cpu_smt_mask(target) would already limit to the sched_domain_span(sd) so I
am not sure how this can help?


-- 
Thanks and Regards
Srikar Dronamraju
