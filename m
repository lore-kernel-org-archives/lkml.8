Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F41EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A7420774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KjWPyd5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:07:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgHMMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:07:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DC3SOo172399;
        Thu, 13 Aug 2020 08:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=LLTLmBewyqkmKqJHV+bmHLRkwhbhcqH5K4GI6AqMyKc=;
 b=KjWPyd5CtwAyA6UcnDIXaE3A4gvVaIupM1W4Yeg4lB6F3eR6qb08kMT1FPmpafmCIebW
 OI2XhtekOto522iVcH+cCVdd6sWFDdn6Y3vEzBTdhudmlu/Z+j+Idb6b2fHMSW2bEtB+
 gBsocRqTXFAx8W0bTixx8LhowN2Pu9o56K6hSqnEkA2SbFHMaBfssnM3K/vlCHXDUKVO
 5kdARjk23ERQPITyXs1SkuLcz/QRQc1g4e3wai5MnLMSo8jod5MfxhLLe7gP6qJq1Vob
 sAw6WjIyvw9kPzi5M9IlNrQUbc8ZIbwc2VR3tzEWlblaHY1+5kAUAJE16zHns207D0OU iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32vqqcwjm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 08:06:57 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DC6obB187753;
        Thu, 13 Aug 2020 08:06:57 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32vqqcwjjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 08:06:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DC6I6P030673;
        Thu, 13 Aug 2020 12:06:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp85h4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 12:06:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DC6qYB42598760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 12:06:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 239EE4204D;
        Thu, 13 Aug 2020 12:06:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 004F042045;
        Thu, 13 Aug 2020 12:06:50 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 13 Aug 2020 12:06:49 +0000 (GMT)
Date:   Thu, 13 Aug 2020 17:36:49 +0530
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
Subject: Re: [PATCH v3 1/2] perf bench numa: fix cpumask memory leak in
 node_has_cpus()
Message-ID: <20200813120649.GA21578@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
 <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
 <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
 <20200813113041.GA1685@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200813113041.GA1685@oc3871087118.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_10:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=2 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Gordeev <agordeev@linux.ibm.com> [2020-08-13 13:30:42]:

> Couple numa_allocate_cpumask() and numa_free_cpumask() functions
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  tools/perf/bench/numa.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 31e2601..9066511 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -248,16 +248,21 @@ static int is_node_present(int node)
>  static bool node_has_cpus(int node)
>  {
>  	struct bitmask *cpu = numa_allocate_cpumask();
> +	bool ret = false; /* fall back to nocpus */
>  	unsigned int i;
> 
> -	if (cpu && !numa_node_to_cpus(node, cpu)) {
> +	BUG_ON(!cpu);
> +	if (!numa_node_to_cpus(node, cpu)) {
>  		for (i = 0; i < cpu->size; i++) {
> -			if (numa_bitmask_isbitset(cpu, i))
> -				return true;
> +			if (numa_bitmask_isbitset(cpu, i)) {
> +				ret = true;
> +				break;
> +			}
>  		}
>  	}
> +	numa_free_cpumask(cpu);
> 
> -	return false; /* lets fall back to nocpus safely */
> +	return ret;
>  }
> 
>  static cpu_set_t bind_to_cpu(int target_cpu)
> -- 
> 1.8.3.1
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
