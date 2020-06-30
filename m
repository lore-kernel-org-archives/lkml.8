Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51ECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BE820722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbgF3QSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:18:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28944 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgF3QSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:18:49 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UGEenL099142;
        Tue, 30 Jun 2020 12:18:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32041e1ghb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 12:18:46 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05UFWgRo069799;
        Tue, 30 Jun 2020 12:18:45 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32041e1gfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 12:18:44 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05UG1UeG013833;
        Tue, 30 Jun 2020 16:18:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 31wwr8bwkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 16:18:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05UGHJJZ58589448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 16:17:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BD194204C;
        Tue, 30 Jun 2020 16:18:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A58B42047;
        Tue, 30 Jun 2020 16:18:39 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.186.119])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Jun 2020 16:18:39 +0000 (GMT)
Date:   Tue, 30 Jun 2020 18:18:37 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/3] perf bench numa: fix incorrect NUMA toplogy
 assumption
Message-ID: <20200630161837.GA27888@oc3871087118.ibm.com>
References: <cover.1593445668.git.agordeev@linux.ibm.com>
 <a53eedd6ad2fb46aec4d59066277aad7ace470b7.1593445668.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53eedd6ad2fb46aec4d59066277aad7ace470b7.1593445668.git.agordeev@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=1 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 cotscore=-2147483648 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 05:50:07PM +0200, Alexander Gordeev wrote:
> The current code assumes that CPUs are evenly spread among
> NUMA nodes. That is generally incorrect and leads to failure
> on systems that have different NUMA topology.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  tools/perf/bench/numa.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 5797253..5497c74 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -247,12 +247,13 @@ static int is_node_present(int node)
>   */
>  static bool node_has_cpus(int node)
>  {
> -	struct bitmask *cpu = numa_allocate_cpumask();
> +	struct bitmask *cpumask = numa_allocate_cpumask();
>  	unsigned int i;
>  
> -	if (cpu && !numa_node_to_cpus(node, cpu)) {
> -		for (i = 0; i < cpu->size; i++) {
> -			if (numa_bitmask_isbitset(cpu, i))
> +	BUG_ON(cpumask);

self-nack - should have been !cpumask,
will send the fixed version

> +	if (!numa_node_to_cpus(node, cpumask)) {
> +		for (i = 0; i < cpumask->size; i++) {
> +			if (numa_bitmask_isbitset(cpumask, i))
>  				return true;
>  		}
>  	}
> @@ -288,14 +289,10 @@ static cpu_set_t bind_to_cpu(int target_cpu)
>  
>  static cpu_set_t bind_to_node(int target_node)
>  {
> -	int cpus_per_node = g->p.nr_cpus / nr_numa_nodes();
>  	cpu_set_t orig_mask, mask;
>  	int cpu;
>  	int ret;
>  
> -	BUG_ON(cpus_per_node * nr_numa_nodes() != g->p.nr_cpus);
> -	BUG_ON(!cpus_per_node);
> -
>  	ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
>  	BUG_ON(ret);
>  
> @@ -305,13 +302,15 @@ static cpu_set_t bind_to_node(int target_node)
>  		for (cpu = 0; cpu < g->p.nr_cpus; cpu++)
>  			CPU_SET(cpu, &mask);
>  	} else {
> -		int cpu_start = (target_node + 0) * cpus_per_node;
> -		int cpu_stop  = (target_node + 1) * cpus_per_node;
> -
> -		BUG_ON(cpu_stop > g->p.nr_cpus);
> +		struct bitmask *cpumask = numa_allocate_cpumask();
>  
> -		for (cpu = cpu_start; cpu < cpu_stop; cpu++)
> -			CPU_SET(cpu, &mask);
> +		BUG_ON(!cpumask);
> +		if (!numa_node_to_cpus(target_node, cpumask)) {
> +			for (cpu = 0; cpu < (int)cpumask->size; cpu++) {
> +				if (numa_bitmask_isbitset(cpumask, cpu))
> +					CPU_SET(cpu, &mask);
> +			}
> +		}
>  	}
>  
>  	ret = sched_setaffinity(0, sizeof(mask), &mask);
> -- 
> 1.8.3.1
> 
