Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9B32072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGNXty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:49:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgGNXtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:49:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ENY9vD110469;
        Tue, 14 Jul 2020 19:49:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3292una1s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 19:49:41 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06ENgMft144656;
        Tue, 14 Jul 2020 19:49:41 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3292una1rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 19:49:41 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06ENe4CJ019012;
        Tue, 14 Jul 2020 23:49:40 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 327529b89e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 23:49:40 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ENnaE328508880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 23:49:36 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ADF6C6057;
        Tue, 14 Jul 2020 23:49:38 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22EE9C6059;
        Tue, 14 Jul 2020 23:49:35 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.66.159])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 14 Jul 2020 23:49:34 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466087136.24747.16494497863685481495.stgit@hbathini.in.ibm.com>
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
Subject: Re: [PATCH v3 03/12] powerpc/kexec_file: add helper functions for getting memory ranges
In-reply-to: <159466087136.24747.16494497863685481495.stgit@hbathini.in.ibm.com>
Date:   Tue, 14 Jul 2020 20:49:31 -0300
Message-ID: <874kq98xo4.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_09:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Hari,

Hari Bathini <hbathini@linux.ibm.com> writes:

> In kexec case, the kernel to be loaded uses the same memory layout as
> the running kernel. So, passing on the DT of the running kernel would
> be good enough.
>
> But in case of kdump, different memory ranges are needed to manage
> loading the kdump kernel, booting into it and exporting the elfcore
> of the crashing kernel. The ranges are exlude memory ranges, usable

s/exlude/exclude/

> memory ranges, reserved memory ranges and crash memory ranges.
>
> Exclude memory ranges specify the list of memory ranges to avoid while
> loading kdump segments. Usable memory ranges list the memory ranges
> that could be used for booting kdump kernel. Reserved memory ranges
> list the memory regions for the loading kernel's reserve map. Crash
> memory ranges list the memory ranges to be exported as the crashing
> kernel's elfcore.
>
> Add helper functions for setting up the above mentioned memory ranges.
> This helpers facilitate in understanding the subsequent changes better
> and make it easy to setup the different memory ranges listed above, as
> and when appropriate.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>

<snip>

> +/**
> + * get_mem_rngs_size - Get the allocated size of mrngs based on
> + *                     max_nr_ranges and chunk size.
> + * @mrngs:             Memory ranges.
> + *
> + * Returns the maximum no. of ranges.

This isn't correct. It returns the maximum size of @mrngs.

> + */
> +static inline size_t get_mem_rngs_size(struct crash_mem *mrngs)
> +{
> +	size_t size;
> +
> +	if (!mrngs)
> +		return 0;
> +
> +	size = (sizeof(struct crash_mem) +
> +		(mrngs->max_nr_ranges * sizeof(struct crash_mem_range)));
> +
> +	/*
> +	 * Memory is allocated in size multiple of MEM_RANGE_CHUNK_SZ.
> +	 * So, align to get the actual length.
> +	 */
> +	return ALIGN(size, MEM_RANGE_CHUNK_SZ);
> +}

<snip>

> +/**
> + * add_tce_mem_ranges - Adds tce-table range to the given memory ranges list.
> + * @mem_ranges:         Range list to add the memory range(s) to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_tce_mem_ranges(struct crash_mem **mem_ranges)
> +{
> +	struct device_node *dn;
> +	int ret;
> +
> +	for_each_node_by_type(dn, "pci") {
> +		u64 base;
> +		u32 size;
> +
> +		ret = of_property_read_u64(dn, "linux,tce-base", &base);
> +		ret |= of_property_read_u32(dn, "linux,tce-size", &size);
> +		if (!ret)

Shouldn't the condition be `ret` instead of `!ret`?

> +			continue;
> +
> +		ret = add_mem_range(mem_ranges, base, size);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * add_initrd_mem_range - Adds initrd range to the given memory ranges list,
> + *                        if the initrd was retained.
> + * @mem_ranges:           Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_initrd_mem_range(struct crash_mem **mem_ranges)
> +{
> +	u64 base, end;
> +	int ret = 0;
> +	char *str;
> +
> +	/* This range means something only if initrd was retained */
> +	str = strstr(saved_command_line, "retain_initrd");
> +	if (!str)
> +		return 0;
> +
> +	ret = of_property_read_u64(of_chosen, "linux,initrd-start", &base);
> +	ret |= of_property_read_u64(of_chosen, "linux,initrd-end", &end);
> +	if (!ret)
> +		ret = add_mem_range(mem_ranges, base, end - base + 1);
> +	return ret;
> +}
> +
> +/**
> + * add_htab_mem_range - Adds htab range to the given memory ranges list,
> + *                      if it exists
> + * @mem_ranges:         Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_htab_mem_range(struct crash_mem **mem_ranges)
> +{
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	int ret;
> +
> +	if (!htab_address)
> +		return 0;
> +
> +	ret = add_mem_range(mem_ranges, __pa(htab_address), htab_size_bytes);
> +	return ret;
> +#else
> +	return 0;
> +#endif
> +}

If I'm not mistaken, this is not the preferred way of having alternative
implementations of a function. The "Conditional Compilation" section of
the coding style document doesn't mention this directly, but does say
that it's better to put the conditionals in a header file.

In this case, I would do this in <asm/kexec_ranges.h>

#ifdef CONFIG_PPC_BOOK3S_64
int add_htab_mem_range(struct crash_mem **mem_ranges);
#else
static inline int add_htab_mem_range(struct crash_mem **mem_ranges)
{
	return 0;
}
#endif

And in ranges.c just surround the add_htab_mem_range() definition with
#ifdef CONFIG_PPC_BOOK3S_64 and #endif

Also, there's no need for the ret variable. You can just
`return add_mem_range(...)` directly.

> +
> +/**
> + * add_kernel_mem_range - Adds kernel text region to the given
> + *                        memory ranges list.
> + * @mem_ranges:           Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_kernel_mem_range(struct crash_mem **mem_ranges)
> +{
> +	int ret;
> +
> +	ret = add_mem_range(mem_ranges, 0, __pa(_end));
> +	return ret;
> +}

No need for the ret variable here, just `return add_mem_range()`
directly.

> +
> +/**
> + * add_rtas_mem_range - Adds RTAS region to the given memory ranges list.
> + * @mem_ranges:         Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_rtas_mem_range(struct crash_mem **mem_ranges)
> +{
> +	struct device_node *dn;
> +	int ret = 0;
> +
> +	dn = of_find_node_by_path("/rtas");
> +	if (dn) {
> +		u32 base, size;
> +
> +		ret = of_property_read_u32(dn, "linux,rtas-base", &base);
> +		ret |= of_property_read_u32(dn, "rtas-size", &size);
> +		if (ret)
> +			return ret;
> +
> +		ret = add_mem_range(mem_ranges, base, size);

You're missing an of_node_put(dn) here (also in the early return in the
line above).

> +	}
> +	return ret;
> +}
> +
> +/**
> + * add_opal_mem_range - Adds OPAL region to the given memory ranges list.
> + * @mem_ranges:         Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_opal_mem_range(struct crash_mem **mem_ranges)
> +{
> +	struct device_node *dn;
> +	int ret = 0;
> +
> +	dn = of_find_node_by_path("/ibm,opal");
> +	if (dn) {
> +		u64 base, size;
> +
> +		ret = of_property_read_u64(dn, "opal-base-address", &base);
> +		ret |= of_property_read_u64(dn, "opal-runtime-size", &size);
> +		if (ret)
> +			return ret;
> +
> +		ret = add_mem_range(mem_ranges, base, size);

You're missing an of_node_put(dn) here (also in the early return in the
line above).

> +	}
> +	return ret;
> +}
> +
> +/**
> + * add_reserved_ranges - Adds "/reserved-ranges" regions exported by f/w
> + *                       to the given memory ranges list.
> + * @mem_ranges:          Range list to add the memory ranges to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_reserved_ranges(struct crash_mem **mem_ranges)
> +{
> +	int i, len, ret = 0;
> +	const __be32 *prop;
> +
> +	prop = of_get_property(of_root, "reserved-ranges", &len);
> +	if (!prop)
> +		return 0;
> +
> +	/*
> +	 * Each reserved range is an (address,size) pair, 2 cells each,
> +	 * totalling 4 cells per range.

Can you assume that, or do you need to check the #address-cells and
#size-cells properties of the root node?

> +	 */
> +	for (i = 0; i < len / (sizeof(*prop) * 4); i++) {
> +		u64 base, size;
> +
> +		base = of_read_number(prop + (i * 4) + 0, 2);
> +		size = of_read_number(prop + (i * 4) + 2, 2);
> +
> +		ret = add_mem_range(mem_ranges, base, size);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * sort_memory_ranges - Sorts the given memory ranges list.
> + * @mem_ranges:         Range list to sort.
> + * @merge:              If true, merge the list after sorting.
> + *
> + * Returns nothing.
> + */
> +void sort_memory_ranges(struct crash_mem *mrngs, bool merge)
> +{
> +	struct crash_mem_range *rngs;
> +	struct crash_mem_range rng;
> +	int i, j, idx;
> +
> +	if (!mrngs)
> +		return;
> +
> +	/* Sort the ranges in-place */
> +	rngs = &mrngs->ranges[0];
> +	for (i = 0; i < mrngs->nr_ranges; i++) {
> +		idx = i;
> +		for (j = (i + 1); j < mrngs->nr_ranges; j++) {
> +			if (rngs[idx].start > rngs[j].start)
> +				idx = j;
> +		}
> +		if (idx != i) {
> +			rng = rngs[idx];
> +			rngs[idx] = rngs[i];
> +			rngs[i] = rng;
> +		}
> +	}

Would it work using sort() from lib/sort.c here?

> +
> +	if (merge)
> +		__merge_memory_ranges(mrngs);
> +}


--
Thiago Jung Bauermann
IBM Linux Technology Center
