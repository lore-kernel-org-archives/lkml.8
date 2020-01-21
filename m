Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBDCC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCE821734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgAUGNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:13:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725789AbgAUGNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:13:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L67nvk133929
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:13:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmfy1fkwb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:13:18 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Tue, 21 Jan 2020 06:13:15 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Jan 2020 06:13:11 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00L6DAsv53805070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:13:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC80F11C054;
        Tue, 21 Jan 2020 06:13:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57E0211C04A;
        Tue, 21 Jan 2020 06:13:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 06:13:10 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8826CA024B;
        Tue, 21 Jan 2020 17:13:05 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/sysdev: fix compile errors
To:     wangwenhu <wenhu.pku@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, lonehugo@hotmail.com, wenhu.wang@vivo.com
References: <20200121053114.89676-1-wenhu.pku@gmail.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Tue, 21 Jan 2020 17:13:07 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121053114.89676-1-wenhu.pku@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012106-0020-0000-0000-000003A2907D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012106-0021-0000-0000-000021FA1E59
Message-Id: <c5256f34-176c-2e72-b0d4-4d615b96d73a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_01:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=994 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/1/20 4:31 pm, wangwenhu wrote:
> From: wangwenhu <wenhu.wang@vivo.com>
> 
> Include arch/powerpc/include/asm/io.h into fsl_85xx_cache_sram.c to
> fix the implicit declaration compile errors when building Cache-Sram.
> 
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function ‘instantiate_cache_sram’:
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’? [-Werror=implicit-function-declaration]
>    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>                            ^~~~~~~~~~~~~~~~
>                            bitmap_complement
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>                          ^
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration of function ‘iounmap’; did you mean ‘roundup’? [-Werror=implicit-function-declaration]
>    iounmap(cache_sram->base_virt);
>    ^~~~~~~
>    roundup
> cc1: all warnings being treated as errors
> 
> Signed-off-by: wangwenhu <wenhu.wang@vivo.com>

How long has this code been broken for?

> ---
>   arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> index f6c665dac725..29b6868eff7d 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> @@ -17,6 +17,7 @@
>   #include <linux/of_platform.h>
>   #include <asm/pgtable.h>
>   #include <asm/fsl_85xx_cache_sram.h>
> +#include <asm/io.h>
> 
>   #include "fsl_85xx_cache_ctlr.h"
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

