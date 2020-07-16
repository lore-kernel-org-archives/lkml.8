Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC4AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25202078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGPBiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:38:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbgGPBiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:38:23 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G1WGFN145846;
        Wed, 15 Jul 2020 21:38:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792wr5tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 21:38:11 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06G1X3K5151252;
        Wed, 15 Jul 2020 21:38:10 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792wr5th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 21:38:10 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G1a79C027895;
        Thu, 16 Jul 2020 01:38:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 327529ped3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 01:38:09 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G1c5rb58720706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 01:38:05 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 813F27805F;
        Thu, 16 Jul 2020 01:38:07 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E89847805C;
        Thu, 16 Jul 2020 01:38:03 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.73.114])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 01:38:03 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466096898.24747.16701009925943468066.stgit@hbathini.in.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 09/12] ppc64/kexec_file: setup backup region for kdump kernel
In-reply-to: <159466096898.24747.16701009925943468066.stgit@hbathini.in.ibm.com>
Date:   Wed, 15 Jul 2020 22:38:01 -0300
Message-ID: <87y2nk8cjq.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> @@ -968,7 +1040,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>
>  	/*
>  	 * Restrict memory usage for kdump kernel by setting up
> -	 * usable memory ranges.
> +	 * usable memory ranges and memory reserve map.
>  	 */
>  	if (image->type == KEXEC_TYPE_CRASH) {
>  		ret = get_usable_memory_ranges(&umem);
> @@ -980,6 +1052,24 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>  			pr_err("Error setting up usable-memory property for kdump kernel\n");
>  			goto out;
>  		}
> +
> +		ret = fdt_add_mem_rsv(fdt, BACKUP_SRC_START + BACKUP_SRC_SIZE,
> +				      crashk_res.start - BACKUP_SRC_SIZE);

I believe this answers my question from the other email about how the
crashkernel is prevented from stomping in the crashed kernel's memory,
right? I needed to think for a bit to understand what the above
reservation was protecting. I think it's worth adding a comment.

> +		if (ret) {
> +			pr_err("Error reserving crash memory: %s\n",
> +			       fdt_strerror(ret));
> +			goto out;
> +		}
> +	}
> +
> +	if (image->arch.backup_start) {
> +		ret = fdt_add_mem_rsv(fdt, image->arch.backup_start,
> +				      BACKUP_SRC_SIZE);
> +		if (ret) {
> +			pr_err("Error reserving memory for backup: %s\n",
> +			       fdt_strerror(ret));
> +			goto out;
> +		}
>  	}

This is only true for KEXEC_TYPE_CRASH, if I'm following the code
correctly. I think it would be clearer to put the if above inside the if
for KEXEC_TYPE_CRASH to make it clearer.

>
>  	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len,

<snip>

> diff --git a/arch/powerpc/purgatory/purgatory_64.c b/arch/powerpc/purgatory/purgatory_64.c
> new file mode 100644
> index 0000000..1eca74c
> --- /dev/null
> +++ b/arch/powerpc/purgatory/purgatory_64.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * purgatory: Runs between two kernels
> + *
> + * Copyright 2020, Hari Bathini, IBM Corporation.
> + */
> +
> +#include <asm/purgatory.h>
> +#include <asm/crashdump-ppc64.h>
> +
> +extern unsigned long backup_start;
> +
> +static void *__memcpy(void *dest, const void *src, unsigned long n)
> +{
> +	unsigned long i;
> +	unsigned char *d;
> +	const unsigned char *s;
> +
> +	d = dest;
> +	s = src;
> +	for (i = 0; i < n; i++)
> +		d[i] = s[i];
> +
> +	return dest;
> +}
> +
> +void purgatory(void)
> +{
> +	void *dest, *src;
> +
> +	src = (void *)BACKUP_SRC_START;
> +	if (backup_start) {
> +		dest = (void *)backup_start;
> +		__memcpy(dest, src, BACKUP_SRC_SIZE);
> +	}
> +}

In general I'm in favor of using C code over assembly, but having to
bring in that relocation support just for the above makes me wonder if
it's worth it in this case.

--
Thiago Jung Bauermann
IBM Linux Technology Center
