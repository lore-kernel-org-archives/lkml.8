Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6586D20771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NUQHENon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLFi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 01:38:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgHLFi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 01:38:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07C5WMY8040673;
        Wed, 12 Aug 2020 01:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=UomPFfu1HTDoKDetkMceKR1argz9g58WcBrOknfWkxM=;
 b=NUQHENonin/WL8Ds8lhiirp/x0x0wVdigy0kH1pHIKxAilveJMMbhz7eIOI46j5qzwjx
 j9t/kk1Jbi+2Jiba9fUuTi/FUkI/z+LiDwXOG1BYBXHb3SKNQM4wBTPW4v9JW0Btnq4K
 0gRzTRHfAF/O2X2nHPUO0ggKCD6DlgVZjU77IhgMCjnSu6Bv6UQZKkSYg23SA8RGtAw4
 FnQIMUx9hDBk1OndslHHGYUS0q1HuZ7pdm7w6u+AggskJhi8w6sJi8tPaDldxJBkFaJq
 ZzhRRM2n/dOlABH1JwZOBkaYKFmXglzOsa3wU9c5kRow0/YsPjey4xsQjuklKH3rdPbw wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32v83bjpr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 01:38:06 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07C5WPMA041050;
        Wed, 12 Aug 2020 01:38:05 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32v83bjpqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 01:38:05 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07C5ZEjP024626;
        Wed, 12 Aug 2020 05:38:04 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 32skp96udm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 05:38:04 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07C5c0bJ31654338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Aug 2020 05:38:00 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 577D9C6055;
        Wed, 12 Aug 2020 05:38:03 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82ECDC6059;
        Wed, 12 Aug 2020 05:38:02 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.80.243])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 12 Aug 2020 05:38:02 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 7BBA32E2F09; Wed, 12 Aug 2020 11:07:49 +0530 (IST)
Date:   Wed, 12 Aug 2020 11:07:49 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH v5 06/10] powerpc/smp: Optimize start_secondary
Message-ID: <20200812053749.GA17292@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200810071834.92514-1-srikar@linux.vnet.ibm.com>
 <20200810071834.92514-7-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810071834.92514-7-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_19:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

On Mon, Aug 10, 2020 at 12:48:30PM +0530, Srikar Dronamraju wrote:
> In start_secondary, even if shared_cache was already set, system does a
> redundant match for cpumask. This redundant check can be removed by
> checking if shared_cache is already set.
> 
> While here, localize the sibling_mask variable to within the if
> condition.
> 
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jordan Niethe <jniethe5@gmail.com>
> Cc: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

The change looks good to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
> Changelog v4 ->v5:
> 	Retain cache domain, no need for generalization
> 		 (Michael Ellerman, Peter Zijlstra,
> 		 Valentin Schneider, Gautham R. Shenoy)
> 
> Changelog v1 -> v2:
> 	Moved shared_cache topology fixup to fixup_topology (Gautham)
> 
>  arch/powerpc/kernel/smp.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 0c960ce3be42..91cf5d05e7ec 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -851,7 +851,7 @@ static int powerpc_shared_cache_flags(void)
>   */
>  static const struct cpumask *shared_cache_mask(int cpu)
>  {
> -	return cpu_l2_cache_mask(cpu);
> +	return per_cpu(cpu_l2_cache_map, cpu);
>  }
> 
>  #ifdef CONFIG_SCHED_SMT
> @@ -1305,7 +1305,6 @@ static void add_cpu_to_masks(int cpu)
>  void start_secondary(void *unused)
>  {
>  	unsigned int cpu = smp_processor_id();
> -	struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
> 
>  	mmgrab(&init_mm);
>  	current->active_mm = &init_mm;
> @@ -1331,14 +1330,20 @@ void start_secondary(void *unused)
>  	/* Update topology CPU masks */
>  	add_cpu_to_masks(cpu);
> 
> -	if (has_big_cores)
> -		sibling_mask = cpu_smallcore_mask;
>  	/*
>  	 * Check for any shared caches. Note that this must be done on a
>  	 * per-core basis because one core in the pair might be disabled.
>  	 */
> -	if (!cpumask_equal(cpu_l2_cache_mask(cpu), sibling_mask(cpu)))
> -		shared_caches = true;
> +	if (!shared_caches) {
> +		struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
> +		struct cpumask *mask = cpu_l2_cache_mask(cpu);
> +
> +		if (has_big_cores)
> +			sibling_mask = cpu_smallcore_mask;
> +
> +		if (cpumask_weight(mask) > cpumask_weight(sibling_mask(cpu)))
> +			shared_caches = true;
> +	}
> 
>  	set_numa_node(numa_cpu_lookup_table[cpu]);
>  	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
> -- 
> 2.18.2
> 
