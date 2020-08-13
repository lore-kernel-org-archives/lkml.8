Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F7FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC7D20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hLNrRfNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHMMIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:08:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10380 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbgHMMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:08:13 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DC35se065153;
        Thu, 13 Aug 2020 08:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=H1onVpNTKi5uEUAnT657XGRVlop7TzeuBfsZS7bhIxU=;
 b=hLNrRfNiKFNvvKmdx4dNN+Qlvjc7gq2ICbiU28yfx6KaG1dHpQ8XwxKfYXjVGqcYbzho
 pIV2/zS6ThbhC2lGdmV/YNoXyhz4QRP6RnCditH0K7R5g1krNYg6teKeUFzlwhTCqeZT
 /EUYbizdhDEGf8UFNuhe4uPiP9XZJiVTShHOZJLFPHZLbq3NEP3E5VWLaFbCdBoFQ/G4
 ipYa7oDMuqaT+XMEi3xNmBMAQVPtGuCUIhs8JVE2aRMOW/fW7bLrWJvDUgiPmyz/Zsyx
 o0isfoz8qwO8voTAWX5PbjWPrXquBRW/A1eJvmLsHFqu/xi4hJi57rCtzbC5iQgL2Qno 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32t93t8871-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 08:08:02 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DC39XW065395;
        Thu, 13 Aug 2020 08:07:55 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32t93t881q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 08:07:54 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DC4ocb008151;
        Thu, 13 Aug 2020 12:07:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 32skp8dgs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 12:07:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DC6Dm4459468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 12:06:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB6411C06E;
        Thu, 13 Aug 2020 12:07:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84F2711C058;
        Thu, 13 Aug 2020 12:07:39 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 13 Aug 2020 12:07:39 +0000 (GMT)
Date:   Thu, 13 Aug 2020 17:37:38 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Balamuruhan S <bala24@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 1/2] perf bench numa: use numa_node_to_cpus() to bind
 tasks to nodes
Message-ID: <20200813120738.GB21578@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
 <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
 <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
 <20200813113247.GA2014@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200813113247.GA2014@oc3871087118.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_10:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Gordeev <agordeev@linux.ibm.com> [2020-08-13 13:32:48]:

> It is currently assumed that each node contains at most
> nr_cpus/nr_nodes CPUs and nodes' CPU ranges do not overlap.
> That assumption is generally incorrect as there are archs
> where a CPU number does not depend on to its node number.
> 
> This update removes the described assumption by simply calling
> numa_node_to_cpus() interface and using the returned mask for
> binding CPUs to nodes.
> 
> Also, variable types and names made consistent in functions
> using cpumask.
> 
> Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
> @@ -310,13 +306,16 @@ static cpu_set_t bind_to_node(int target_node)
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
> +		numa_free_cpumask(cpumask);
>  	}
> 
>  	ret = sched_setaffinity(0, sizeof(mask), &mask);
> -- 
> 1.8.3.1
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
