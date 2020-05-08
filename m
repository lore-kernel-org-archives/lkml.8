Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C06DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDD020735
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEHHFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:05:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbgEHHFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:05:13 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04874EDd134993;
        Fri, 8 May 2020 03:05:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtw5b3bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 03:05:07 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048756X8140299;
        Fri, 8 May 2020 03:05:06 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtw5b3au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 03:05:06 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0486soIa025561;
        Fri, 8 May 2020 07:05:05 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 30s0g7m2tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 07:05:05 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048754ov10224004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 07:05:04 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A770BE054;
        Fri,  8 May 2020 07:05:04 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09EA9BE051;
        Fri,  8 May 2020 07:04:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.106])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  8 May 2020 07:04:57 +0000 (GMT)
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
To:     "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com,
        mpe@ellerman.id.au, irogers@google.com
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-3-git-send-email-pc@us.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <0b276c65-9c54-c6eb-0381-f56c4ccf5ec2@linux.ibm.com>
Date:   Fri, 8 May 2020 12:34:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1588868938-21933-3-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_08:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/20 9:58 PM, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> - ict_noslot_br_mpred_cpi
> - ict_noslot_br_mpred_icmiss_cpi
> - ict_noslot_cyc_other_cpi
> - ict_noslot_disp_held_cpi
> - ict_noslot_disp_held_hb_full_cpi
> - ict_noslot_disp_held_issq_cpi
> - ict_noslot_disp_held_other_cpi
> - ict_noslot_disp_held_sync_cpi
> - ict_noslot_disp_held_tbegin_cpi
> - ict_noslot_ic_l2_cpi
> - ict_noslot_ic_l3_cpi
> - ict_noslot_ic_l3miss_cpi
> - ict_noslot_ic_miss_cpi
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Reviewed-by: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain
> ---
>  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
>  1 file changed, 78 insertions(+), 65 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> index 811c2a8c1c9e..6169351a72c8 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> @@ -207,6 +207,84 @@
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "fxu_stall_cpi"
>      },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to branch mispred",
> +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_br_mpred_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> +    },
> +    {
> +        "BriefDescription": "ICT other stalls",
> +        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_cyc_other_cpi"
> +    },
> +    {
> +        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_issq_cpi"
> +    },
> +    {
> +        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> +        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_other_cpi"
> +    },
> +    {
> +        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_sync_cpi"
> +    },
> +    {
> +        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> +    },
> +    {
> +        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> +        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_ic_l2_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_ic_l3_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_ic_l3miss_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> +        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_ic_miss_cpi"
> +    },
>      {
>          "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
> @@ -1819,71 +1897,6 @@
>          "MetricExpr": "PM_FXU_IDLE / PM_CYC",
>          "MetricName": "fxu_all_idle"
>      },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to branch mispred",
> -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_br_mpred_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> -    },
> -    {
> -        "BriefDescription": "ICT other stalls",
> -        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_cyc_other_cpi"
> -    },
> -    {
> -        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_issq_cpi"
> -    },
> -    {
> -        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> -        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_other_cpi"
> -    },
> -    {
> -        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_sync_cpi"
> -    },
> -    {
> -        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> -    },
> -    {
> -        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> -        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_ic_l2_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_ic_l3_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_ic_l3miss_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> -        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_ic_miss_cpi"
> -    },
>      {
>          "BriefDescription": "Rate of IERAT reloads from L2",
>          "MetricExpr": "PM_IPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
> 
