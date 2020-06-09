Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DDCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A0C2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgFIOqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:46:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21630 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728184AbgFIOqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:46:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059Edcph076032;
        Tue, 9 Jun 2020 10:46:17 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31grrj6u94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 10:46:17 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059EjL9X023853;
        Tue, 9 Jun 2020 14:46:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 31g2s82gyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 14:46:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059EkAvu54657206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 14:46:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8450AAE045;
        Tue,  9 Jun 2020 14:46:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36D27AE056;
        Tue,  9 Jun 2020 14:46:10 +0000 (GMT)
Received: from osiris (unknown [9.171.92.221])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Jun 2020 14:46:10 +0000 (GMT)
Date:   Tue, 9 Jun 2020 16:46:08 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v6] s390: Fix vDSO clock_getres()
Message-ID: <20200609144608.GB4575@osiris>
References: <20200324121027.21665-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324121027.21665-1-vincenzo.frascino@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_09:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 cotscore=-2147483648 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincenzo,

sorry it took such a long time to answer!

> clock_getres in the vDSO library has to preserve the same behaviour
> of posix_get_hrtimer_res().
> 
> In particular, posix_get_hrtimer_res() does:
>     sec = 0;
>     ns = hrtimer_resolution;
> and hrtimer_resolution depends on the enablement of the high
> resolution timers that can happen either at compile or at run time.
> 
> Fix the s390 vdso implementation of clock_getres keeping a copy of
> hrtimer_resolution in vdso data and using that directly.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/include/asm/vdso.h           |  1 +
>  arch/s390/kernel/asm-offsets.c         |  2 +-
>  arch/s390/kernel/time.c                |  1 +
>  arch/s390/kernel/vdso64/clock_getres.S | 10 +++++-----
>  4 files changed, 8 insertions(+), 6 deletions(-)
...

> diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
> index 081435398e0a..022b58c980db 100644
> --- a/arch/s390/kernel/vdso64/clock_getres.S
> +++ b/arch/s390/kernel/vdso64/clock_getres.S
> @@ -17,12 +17,14 @@
>  	.type  __kernel_clock_getres,@function
>  __kernel_clock_getres:
>  	CFI_STARTPROC
> -	larl	%r1,4f
> +	larl	%r1,3f
> +	lg	%r0,0(%r1)
>  	cghi	%r2,__CLOCK_REALTIME_COARSE
>  	je	0f
>  	cghi	%r2,__CLOCK_MONOTONIC_COARSE
>  	je	0f
> -	larl	%r1,3f
> +	larl	%r1,_vdso_data
> +	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)

This should be llgf for proper zero extension. The code works anyway,
since the upper lg would clear the high order bits, however this looks
like it works more or less by accident ;)

I changed it and applied your patch. Thanks a lot!
