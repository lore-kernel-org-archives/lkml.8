Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303F7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1B320787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGPCWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:22:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbgGPCWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:22:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G27oP4089244;
        Wed, 15 Jul 2020 22:22:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329cum30m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 22:22:18 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06G2CVpF102652;
        Wed, 15 Jul 2020 22:22:18 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329cum30kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 22:22:18 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G2KZje025773;
        Thu, 16 Jul 2020 02:22:17 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 328ux7gkp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 02:22:17 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G2MFI04850270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 02:22:15 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A318CBE053;
        Thu, 16 Jul 2020 02:22:15 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39B2EBE04F;
        Thu, 16 Jul 2020 02:22:12 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.73.114])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 02:22:11 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466098739.24747.5860501703617893464.stgit@hbathini.in.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v3 10/12] ppc64/kexec_file: prepare elfcore header for crashing kernel
In-reply-to: <159466098739.24747.5860501703617893464.stgit@hbathini.in.ibm.com>
Date:   Wed, 15 Jul 2020 23:22:08 -0300
Message-ID: <87tuy88ai7.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

>  /**
> + * get_crash_memory_ranges - Get crash memory ranges. This list includes
> + *                           first/crashing kernel's memory regions that
> + *                           would be exported via an elfcore.
> + * @mem_ranges:              Range list to add the memory ranges to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
> +{
> +	struct memblock_region *reg;
> +	struct crash_mem *tmem;
> +	int ret;
> +
> +	for_each_memblock(memory, reg) {
> +		u64 base, size;
> +
> +		base = (u64)reg->base;
> +		size = (u64)reg->size;
> +
> +		/* Skip backup memory region, which needs a separate entry */
> +		if (base == BACKUP_SRC_START) {
> +			if (size > BACKUP_SRC_SIZE) {
> +				base = BACKUP_SRC_END + 1;
> +				size -= BACKUP_SRC_SIZE;
> +			} else
> +				continue;
> +		}
> +
> +		ret = add_mem_range(mem_ranges, base, size);
> +		if (ret)
> +			goto out;
> +
> +		/* Try merging adjacent ranges before reallocation attempt */
> +		if ((*mem_ranges)->nr_ranges == (*mem_ranges)->max_nr_ranges)
> +			sort_memory_ranges(*mem_ranges, true);
> +	}
> +
> +	/* Reallocate memory ranges if there is no space to split ranges */
> +	tmem = *mem_ranges;
> +	if (tmem && (tmem->nr_ranges == tmem->max_nr_ranges)) {
> +		tmem = realloc_mem_ranges(mem_ranges);
> +		if (!tmem)
> +			goto out;
> +	}
> +
> +	/* Exclude crashkernel region */
> +	ret = crash_exclude_mem_range(tmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_rtas_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_opal_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;

Maybe I'm confused, but don't you add the RTAS and OPAL regions as
usable memory for the crashkernel? In that case they shouldn't show up
in the core file.

> +
> +	/* create a separate program header for the backup region */
> +	ret = add_mem_range(mem_ranges, BACKUP_SRC_START, BACKUP_SRC_SIZE);
> +	if (ret)
> +		goto out;
> +
> +	sort_memory_ranges(*mem_ranges, false);
> +out:
> +	if (ret)
> +		pr_err("Failed to setup crash memory ranges\n");
> +	return ret;
> +}

<snip>

> +/**
> + * prepare_elf_headers - Prepare headers for the elfcore to be exported as
> + *                       /proc/vmcore by the kdump kernel.
> + * @image:               Kexec image.
> + * @cmem:                Crash memory ranges to be exported via elfcore.
> + * @addr:                Vmalloc'd memory allocated by crash_prepare_elf64_headers
> + *                       to prepare the elf headers.
> + * @sz:                  Size of the vmalloc'd memory allocated.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int prepare_elf_headers(struct kimage *image, struct crash_mem *cmem,
> +			       void **addr, unsigned long *sz)
> +{
> +	int ret;
> +
> +	ret = crash_prepare_elf64_headers(cmem, false, addr, sz);
> +
> +	/* Fix the offset for backup region in the ELF header */
> +	if (!ret)
> +		update_backup_region_phdr(image, *addr);
> +
> +	return ret;
> +}

The code above can be inlined into its caller, I don't see a need to
have a separate function.

> +
> +/**
> + * load_elfcorehdr_segment - Setup crash memory ranges and initialize elfcorehdr
> + *                           segment needed to load kdump kernel.
> + * @image:                   Kexec image.
> + * @kbuf:                    Buffer contents and memory parameters.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
> +{
> +	struct crash_mem *cmem = NULL;
> +	unsigned long headers_sz;
> +	void *headers = NULL;
> +	int ret;
> +
> +	ret = get_crash_memory_ranges(&cmem);
> +	if (ret)
> +		goto out;
> +
> +	/* Setup elfcorehdr segment */
> +	ret = prepare_elf_headers(image, cmem, &headers, &headers_sz);
> +	if (ret) {
> +		pr_err("Failed to prepare elf headers for the core\n");
> +		goto out;
> +	}
> +
> +	kbuf->buffer = headers;
> +	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
> +	kbuf->bufsz = kbuf->memsz = headers_sz;
> +	kbuf->top_down = false;
> +
> +	ret = kexec_add_buffer(kbuf);
> +	if (ret) {
> +		vfree(headers);
> +		goto out;
> +	}
> +
> +	image->arch.elfcorehdr_addr = kbuf->mem;
> +	image->arch.elf_headers_sz = headers_sz;
> +	image->arch.elf_headers = headers;
> +out:
> +	kfree(cmem);
> +	return ret;
> +}

--
Thiago Jung Bauermann
IBM Linux Technology Center
