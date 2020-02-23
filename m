Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC79C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 06:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CEF208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 06:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgBWGca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 01:32:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgBWGc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 01:32:29 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01N6T2m1053928
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 01:32:29 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1b61k2s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 01:32:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Sun, 23 Feb 2020 06:32:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 23 Feb 2020 06:32:23 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01N6WMKs45875242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Feb 2020 06:32:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48A0F4C044;
        Sun, 23 Feb 2020 06:32:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F6134C040;
        Sun, 23 Feb 2020 06:32:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.3.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 23 Feb 2020 06:32:15 +0000 (GMT)
Subject: Re: [PATCH v4 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com, hdanton@sina.com
References: <20200221132715.20648-1-vincent.guittot@linaro.org>
 <20200221132715.20648-3-vincent.guittot@linaro.org>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Sun, 23 Feb 2020 12:02:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200221132715.20648-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022306-0012-0000-0000-000003896EDC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022306-0013-0000-0000-000021C60B57
Message-Id: <c595c3be-2fbf-4cd3-5c58-7b5faa055d2f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-22_08:2020-02-21,2020-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002230054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/20 6:57 PM, Vincent Guittot wrote:
> Similarly to what has been done for the normal load balancer, we can
> replace runnable_load_avg by load_avg in numa load balancing and track the
> other statistics like the utilization and the number of running tasks to
> get to better view of the current state of a node.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
> ---
>  kernel/sched/fair.c | 102 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 70 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 27450c4ddc81..637f4eb47889 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1473,38 +1473,35 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
>  	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
>  }
>  
> -static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
> -
> -static unsigned long cpu_runnable_load(struct rq *rq)
> -{
> -	return cfs_rq_runnable_load_avg(&rq->cfs);
> -}
> +/*
> + * 'numa_type' describes the node at the moment of load balancing.
> + */
> +enum numa_type {
> +	/* The node has spare capacity that can be used to run more tasks.  */
> +	node_has_spare = 0,
> +	/*
> +	 * The node is fully used and the tasks don't compete for more CPU
> +	 * cycles. Nevertheless, some tasks might wait before running.
> +	 */
> +	node_fully_busy,
> +	/*
> +	 * The node is overloaded and can't provide expected CPU cycles to all
> +	 * tasks.
> +	 */
> +	node_overloaded
> +};
>  
>  /* Cached statistics for all CPUs within a node */
>  struct numa_stats {
>  	unsigned long load;
> -
> +	unsigned long util;
>  	/* Total compute capacity of CPUs on a node */
>  	unsigned long compute_capacity;
> +	unsigned int nr_running;
> +	unsigned int weight;
> +	enum numa_type node_type;
>  };
>  
> -/*
> - * XXX borrowed from update_sg_lb_stats
> - */
> -static void update_numa_stats(struct numa_stats *ns, int nid)
> -{
> -	int cpu;
> -
> -	memset(ns, 0, sizeof(*ns));
> -	for_each_cpu(cpu, cpumask_of_node(nid)) {
> -		struct rq *rq = cpu_rq(cpu);
> -
> -		ns->load += cpu_runnable_load(rq);
> -		ns->compute_capacity += capacity_of(cpu);
> -	}
> -
> -}
> -
>  struct task_numa_env {
>  	struct task_struct *p;
>  
> @@ -1521,6 +1518,47 @@ struct task_numa_env {
>  	int best_cpu;
>  };
>  
> +static unsigned long cpu_load(struct rq *rq);
> +static unsigned long cpu_util(int cpu);
> +
> +static inline enum
> +numa_type numa_classify(unsigned int imbalance_pct,
> +			 struct numa_stats *ns)
> +{
> +	if ((ns->nr_running > ns->weight) &&
> +	    ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
> +		return node_overloaded;
> +
> +	if ((ns->nr_running < ns->weight) ||
> +	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
> +		return node_has_spare;
> +
> +	return node_fully_busy;
> +}


I was pondering upon the possible cases of returning node_fully_busy here.

It will return fully busy only when scaled util is exactly equal to
capacity && ns->nr_running == ns->weight. From reading the patch-set, I
failed to figure out the implications of it. Ideally, the tasks should
neither be pulled to or pulled from this node. Is this what its use for?

If yes, then should we return false when checking for load_too_imbalanced
and found that env->dst_stats.node_type == node_fully_busy ?

[...]
> @@ -1556,6 +1594,11 @@ static bool load_too_imbalanced(long src_load, long dst_load,
>  	long orig_src_load, orig_dst_load;
>  	long src_capacity, dst_capacity;
>  
> +
> +	/* If dst node has spare capacity, there is no real load imbalance */
> +	if (env->dst_stats.node_type == node_has_spare)
> +		return false;
[...]

- Parth

