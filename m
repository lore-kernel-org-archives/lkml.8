Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A55C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3228D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbgGaJt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:49:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46216 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732134AbgGaJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:49:57 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V9Wx6V120616;
        Fri, 31 Jul 2020 05:49:46 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32md1ywv47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:49:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V9jZRh014321;
        Fri, 31 Jul 2020 09:49:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 32gcy4q3pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 09:49:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V9ngBC28312018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 09:49:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E48F0A405F;
        Fri, 31 Jul 2020 09:49:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79B90A4054;
        Fri, 31 Jul 2020 09:49:39 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 31 Jul 2020 09:49:39 +0000 (GMT)
Date:   Fri, 31 Jul 2020 15:19:38 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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
Subject: Re: [PATCH v4 08/10] powerpc/smp: Allocate cpumask only after
 searching thread group
Message-ID: <20200731094938.GA18776@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com>
 <20200727053230.19753-9-srikar@linux.vnet.ibm.com>
 <87zh7g3yvk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87zh7g3yvk.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_03:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=2
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Ellerman <mpe@ellerman.id.au> [2020-07-31 17:52:15]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > If allocated earlier and the search fails, then cpumask need to be
> > freed. However cpu_l1_cache_map can be allocated after we search thread
> > group.
> 
> It's not freed anywhere AFAICS?
> 

Yes, its never freed. Infact we are never checking if
zalloc_cpumask_var_node fails. Its not just this cpumask, but historically
all the other existing cpumasks in arch/powerpc/kernel/smp.c are never
freed/checked. I did dig into this a bit and it appears that ..
(Please do correct me if I am wrong!! )

Powerpc using cpumask_var_t for all of the percpu variables. And it dont seem
to enable CONFIG_CPUMASK_OFFSTACK even from the MAXSMP config.

So from include/linux/cpumask.h

typedef struct cpumask cpumask_var_t[1];
and
zalloc_cpumask_var_node ends up being cpumask_clear

So I think we are historically we seem to assume we are always
!CPUMASK_OFFSTACK and hence we dont need to check for return as well as
free..

I would look forward to your comments on how we should handle this going
forward. But I would keep this the same for this patchset.

One of the questions that I have is if we most likely are to be in
!CONFIG_CPUMASK_OFFSTACK, then should be migrate to cpumask_t for percpu
variables. 
 
The reason being we end up using NR_CPU cpumask for each percpu cpumask
variable instead of using NR_CPU cpumask_t pointer.

> And even after this change there's still an error path that doesn't free
> it, isn't there?
> 
> cheers
> 
> > Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> > Cc: LKML <linux-kernel@vger.kernel.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Anton Blanchard <anton@ozlabs.org>
> > Cc: Oliver O'Halloran <oohall@gmail.com>
> > Cc: Nathan Lynch <nathanl@linux.ibm.com>
> > Cc: Michael Neuling <mikey@neuling.org>
> > Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Jordan Niethe <jniethe5@gmail.com>
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/smp.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 698000c7f76f..dab96a1203ec 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -797,10 +797,6 @@ static int init_cpu_l1_cache_map(int cpu)
> >  	if (err)
> >  		goto out;
> >  
> > -	zalloc_cpumask_var_node(&per_cpu(cpu_l1_cache_map, cpu),
> > -				GFP_KERNEL,
> > -				cpu_to_node(cpu));
> > -
> >  	cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
> >  
> >  	if (unlikely(cpu_group_start == -1)) {
> > @@ -809,6 +805,9 @@ static int init_cpu_l1_cache_map(int cpu)
> >  		goto out;
> >  	}
> >  
> > +	zalloc_cpumask_var_node(&per_cpu(cpu_l1_cache_map, cpu),
> > +				GFP_KERNEL, cpu_to_node(cpu));
> > +
> >  	for (i = first_thread; i < first_thread + threads_per_core; i++) {
> >  		int i_group_start = get_cpu_thread_group_start(i, &tg);
> >  
> > -- 
> > 2.17.1

-- 
Thanks and Regards
Srikar Dronamraju
