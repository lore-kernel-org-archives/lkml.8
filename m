Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B95C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8698D207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgEHGcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:32:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgEHGcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:32:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0486VlIB030749;
        Fri, 8 May 2020 02:32:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtw5a9sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 02:32:09 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0486W9Bk031697;
        Fri, 8 May 2020 02:32:09 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtw5a9ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 02:32:09 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0486UYSr026496;
        Fri, 8 May 2020 06:32:08 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 30s0g7bvm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 06:32:08 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0486W7No54854134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 06:32:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C162B2064;
        Fri,  8 May 2020 06:32:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54511B2065;
        Fri,  8 May 2020 06:31:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.106])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 May 2020 06:31:57 +0000 (GMT)
Subject: Re: [PATCH 1/2] perf: Fix POWER9 metric 'lsu_other_stall_cpi'
To:     "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com,
        mpe@ellerman.id.au, irogers@google.com
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-2-git-send-email-pc@us.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <fa59ef0f-50b3-0ca5-adbe-9dcf06627c06@linux.ibm.com>
Date:   Fri, 8 May 2020 12:01:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1588868938-21933-2-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_06:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/20 9:58 PM, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> The metric definition is too long for the current value of EXPR_MAX_OTHER.
> Increase the value EXPR_MAX_OTHER sufficiently to allow
> 'lsu_other_stall_cpi' to build properly.
> 
> Before:
> --
> $ perf list | grep lsu_other
>   lsu_other_stall_cpi
> # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> Cannot find metric or group `lsu_other_stall_cpi'
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -M, --metrics <metric/metric group list>
>                           monitor specified metrics or metric groups (separated by ,)
> --
> 
> After:
> --
> # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        438,086,889      pm_cmplu_stall_lsu        #     1.74 lsu_other_stall_cpi
> [...]
> --
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  tools/perf/util/expr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 87d627bb699b..a0991959cca4 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -2,7 +2,7 @@
>  #ifndef PARSE_CTX_H
>  #define PARSE_CTX_H 1
>  
> -#define EXPR_MAX_OTHER 20
> +#define EXPR_MAX_OTHER 28

Hi Paul,
	Ian already add one patch to increase EXPR_MAX_OTHER value to 68 which is Acked-by: Jiri

Link to the patch: https://lkml.org/lkml/2020/5/1/1023

Thanks,
Kajol Jain

>  #define MAX_PARSE_ID EXPR_MAX_OTHER
>  
>  struct expr_parse_id {
> 
