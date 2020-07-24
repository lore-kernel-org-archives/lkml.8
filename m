Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A168C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C85C2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgGXHI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:08:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbgGXHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:08:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O71mTg160490;
        Fri, 24 Jul 2020 03:08:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fsbktf2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 03:08:13 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06O71q15160922;
        Fri, 24 Jul 2020 03:08:12 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fsbktf2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 03:08:12 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O76Hh9027290;
        Fri, 24 Jul 2020 07:08:12 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 32brqa76cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 07:08:12 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06O789wk60293604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 07:08:09 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05B376E052;
        Fri, 24 Jul 2020 07:08:11 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F0876E050;
        Fri, 24 Jul 2020 07:08:10 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.93.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 07:08:10 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 6DBF82E340E; Fri, 24 Jul 2020 12:38:05 +0530 (IST)
Date:   Fri, 24 Jul 2020 12:38:05 +0530
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
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v3 04/10] powerpc/smp: Move topology fixups into  a new
 function
Message-ID: <20200724070805.GB21415@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200723085116.4731-1-srikar@linux.vnet.ibm.com>
 <20200723085116.4731-5-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723085116.4731-5-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_01:2020-07-24,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 02:21:10PM +0530, Srikar Dronamraju wrote:
> Move topology fixup based on the platform attributes into its own
> function which is called just before set_sched_topology.
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
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>


Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> Changelog v2 -> v3:
> 	Rewrote changelog (Gautham)
> 	Renamed to powerpc/smp: Move topology fixups into  a new function
> 
>  arch/powerpc/kernel/smp.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index a685915e5941..da27f6909be1 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1368,6 +1368,16 @@ int setup_profiling_timer(unsigned int multiplier)
>  	return 0;
>  }
> 
> +static void fixup_topology(void)
> +{
> +#ifdef CONFIG_SCHED_SMT
> +	if (has_big_cores) {
> +		pr_info("Big cores detected but using small core scheduling\n");
> +		powerpc_topology[0].mask = smallcore_smt_mask;
> +	}
> +#endif
> +}
> +
>  void __init smp_cpus_done(unsigned int max_cpus)
>  {
>  	/*
> @@ -1381,12 +1391,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
> 
>  	dump_numa_cpu_topology();
> 
> -#ifdef CONFIG_SCHED_SMT
> -	if (has_big_cores) {
> -		pr_info("Big cores detected but using small core scheduling\n");
> -		powerpc_topology[0].mask = smallcore_smt_mask;
> -	}
> -#endif
> +	fixup_topology();
>  	set_sched_topology(powerpc_topology);
>  }
> 
> -- 
> 2.18.2
> 
