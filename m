Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7879FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F5222CBB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgHDLrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:47:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728028AbgHDLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:47:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074BX2UW089118;
        Tue, 4 Aug 2020 07:46:56 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32q4wsm246-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 07:46:55 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074BfGB1029221;
        Tue, 4 Aug 2020 11:46:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 32nyyd16sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 11:46:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074BkpnQ23331110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 11:46:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0A8742042;
        Tue,  4 Aug 2020 11:46:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B86D34204D;
        Tue,  4 Aug 2020 11:46:50 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Aug 2020 11:46:50 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com
Subject: Re: [PATCH 1/3] vdso: allow to add architecture-specific vdso data
References: <20200804093607.69841-1-svens@linux.ibm.com>
        <20200804093607.69841-2-svens@linux.ibm.com>
Date:   Tue, 04 Aug 2020 13:46:50 +0200
In-Reply-To: <20200804093607.69841-2-svens@linux.ibm.com> (Sven Schnelle's
        message of "Tue, 4 Aug 2020 11:36:05 +0200")
Message-ID: <yt9dk0yed45x.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sven Schnelle <svens@linux.ibm.com> writes:

> Add the possibility to add architecture specific vDSO
> data to struct vdso_data. This is useful if the arch specific
> user space VDSO code needs additional data during execution.
> If CONFIG_ARCH_HAS_VDSO_DATA is defined, the generic code will
> include asm/vdso/data.h which should contain 'struct arch_vdso_data'.
> This structure will be embedded in the generic vDSO data.
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/Kconfig            | 3 +++
>  include/vdso/datapage.h | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8cc35dc556c7..e1017ce979e2 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -979,6 +979,9 @@ config HAVE_SPARSE_SYSCALL_NR
>  	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
>  	  related optimizations for a given architecture.
>  
> +config ARCH_HAS_VDSO_DATA
> +	bool
> +
>  source "kernel/gcov/Kconfig"
>  
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 7955c56d6b3c..74e730238ce6 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -19,6 +19,10 @@
>  #include <vdso/time32.h>
>  #include <vdso/time64.h>
>  
> +#ifdef CONFIG_ARCH_HAS_VDSO_DATA
> +#include <asm/vdso/data.h>
> +#endif
> +
>  #define VDSO_BASES	(CLOCK_TAI + 1)
>  #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
>  			 BIT(CLOCK_MONOTONIC)		| \
> @@ -97,6 +101,9 @@ struct vdso_data {
>  	s32			tz_dsttime;
>  	u32			hrtimer_res;
>  	u32			__unused;
> +#ifdef CONFIG_ARCH_HAS_VDSO_DATA
> +	struct arch_vdso_data arch;
> +#endif
>  };
>  
>  /*

I've sent the wrong version of this patch. I'll send a revised version
with the requested changes later.
