Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DBCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF232070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGPF6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:58:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbgGPF6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:58:22 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G5WHrT001936;
        Thu, 16 Jul 2020 01:58:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792wvxy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 01:58:15 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06G5WL6S002191;
        Thu, 16 Jul 2020 01:58:15 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792wvxxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 01:58:15 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G5tdPD001596;
        Thu, 16 Jul 2020 05:58:13 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 327529r05p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 05:58:13 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G5wCS117105226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 05:58:12 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC6C5C605B;
        Thu, 16 Jul 2020 05:58:11 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8083C6057;
        Thu, 16 Jul 2020 05:58:08 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.73.114])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 05:58:08 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466088775.24747.1248185448154277951.stgit@hbathini.in.ibm.com> <87365t8pse.fsf@morokweng.localdomain>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Pingfan Liu <piliu@redhat.com>, Nayna Jain <nayna@linux.ibm.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 04/12] ppc64/kexec_file: avoid stomping memory used by special regions
In-reply-to: <87365t8pse.fsf@morokweng.localdomain>
Date:   Thu, 16 Jul 2020 02:58:04 -0300
Message-ID: <87pn8w80ib.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Hari Bathini <hbathini@linux.ibm.com> writes:
>
>> diff --git a/arch/powerpc/include/asm/crashdump-ppc64.h b/arch/powerpc/include/asm/crashdump-ppc64.h
>> new file mode 100644
>> index 0000000..90deb46
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/crashdump-ppc64.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef _ASM_POWERPC_CRASHDUMP_PPC64_H
>> +#define _ASM_POWERPC_CRASHDUMP_PPC64_H
>> +
>> +/* min & max addresses for kdump load segments */
>> +#define KDUMP_BUF_MIN		(crashk_res.start)
>> +#define KDUMP_BUF_MAX		((crashk_res.end < ppc64_rma_size) ? \
>> +				 crashk_res.end : (ppc64_rma_size - 1))
>> +
>> +#endif /* __ASM_POWERPC_CRASHDUMP_PPC64_H */
>> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
>> index 7008ea1..bf47a01 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -100,14 +100,16 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
>>  #ifdef CONFIG_KEXEC_FILE
>>  extern const struct kexec_file_ops kexec_elf64_ops;
>>
>> -#ifdef CONFIG_IMA_KEXEC
>>  #define ARCH_HAS_KIMAGE_ARCH
>>
>>  struct kimage_arch {
>> +	struct crash_mem *exclude_ranges;
>> +
>> +#ifdef CONFIG_IMA_KEXEC
>>  	phys_addr_t ima_buffer_addr;
>>  	size_t ima_buffer_size;
>> -};
>>  #endif
>> +};
>>
>>  int setup_purgatory(struct kimage *image, const void *slave_code,
>>  		    const void *fdt, unsigned long kernel_load_addr,
>> @@ -125,6 +127,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>>  			unsigned long initrd_load_addr,
>>  			unsigned long initrd_len, const char *cmdline);
>>  #endif /* CONFIG_PPC64 */
>> +
>>  #endif /* CONFIG_KEXEC_FILE */
>>
>>  #else /* !CONFIG_KEXEC_CORE */
>> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>> index 23ad04c..c695f94 100644
>> --- a/arch/powerpc/kexec/elf_64.c
>> +++ b/arch/powerpc/kexec/elf_64.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/of_fdt.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>> +#include <asm/crashdump-ppc64.h>
>>
>>  static void *elf64_load(struct kimage *image, char *kernel_buf,
>>  			unsigned long kernel_len, char *initrd,
>> @@ -46,6 +47,12 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>  	if (ret)
>>  		goto out;
>>
>> +	if (image->type == KEXEC_TYPE_CRASH) {
>> +		/* min & max buffer values for kdump case */
>> +		kbuf.buf_min = pbuf.buf_min = KDUMP_BUF_MIN;
>> +		kbuf.buf_max = pbuf.buf_max = KDUMP_BUF_MAX;
>
> This is only my personal opinion and an actual maintainer may disagree,
> but just looking at the lines above, I would assume that KDUMP_BUF_MIN
> and KDUMP_BUF_MAX were constants, when in fact they aren't.
>
> I suggest using static inline macros in <asm/crashdump-ppc64.h>, for
> example:
>
> static inline resource_size_t get_kdump_buf_min(void)
> {
> 	return crashk_res.start;
> }
>
> static inline resource_size_t get_kdump_buf_max(void)
> {
> 	return (crashk_res.end < ppc64_rma_size) ? \
> 		 crashk_res.end : (ppc64_rma_size - 1)
> }

I later noticed that KDUMP_BUF_MIN and KDUMP_BUF_MAX are only used here.
In this case, I think the best option is to avoid the macros and inline
functions and just use the actual expressions in the code.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
