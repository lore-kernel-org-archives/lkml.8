Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08760C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96832192A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgEKSPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:15:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729673AbgEKSPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:15:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BI5q4g194657;
        Mon, 11 May 2020 14:15:18 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30yaeja9ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 14:15:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04BI1Bq5021203;
        Mon, 11 May 2020 18:15:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30wm55mvve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 18:15:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04BIFDiq56361002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 18:15:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C40F52052;
        Mon, 11 May 2020 18:15:13 +0000 (GMT)
Received: from [9.199.34.77] (unknown [9.199.34.77])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1DE4852063;
        Mon, 11 May 2020 18:15:10 +0000 (GMT)
Subject: Re: [PATCH] perf powerpc: Don't ignore sym-handling.c file
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, acme@kernel.org
Cc:     leo.yan@linaro.org, jolsa@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <20200509112113.174745-1-ravi.bangoria@linux.ibm.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Message-ID: <88066ce0-f586-b88d-75b5-2706684818d7@linux.ibm.com>
Date:   Mon, 11 May 2020 23:45:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509112113.174745-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_08:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/05/20 4:51 pm, Ravi Bangoria wrote:
> Commit 7eec00a74720 ("perf symbols: Consolidate symbol fixup issue")
> removed powerpc specific sym-handling.c file from Build. This wasn't
> caught by build CI because all functions in this file are declared
> as __weak in common code. Fix it.
> 
> Fixes: 7eec00a74720 ("perf symbols: Consolidate symbol fixup issue")
> Reported-by: Sandipan Das <sandipan@linux.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/Build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index e5c9504f8586..e86e210bf514 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -2,6 +2,7 @@ perf-y += header.o
>  perf-y += kvm-stat.o
>  perf-y += perf_regs.o
>  perf-y += mem-events.o
> +perf-y += sym-handling.o
>  
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_DWARF) += skip-callchain-idx.o
> 

Thanks for fixing this!

Acked-by: Sandipan Das <sandipan@linux.ibm.com>
