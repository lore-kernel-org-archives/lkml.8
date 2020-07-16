Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BAEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8289E20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgGPV5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:57:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgGPV5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:57:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GL3GIM074078;
        Thu, 16 Jul 2020 17:57:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32aut4dns4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 17:57:23 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GLTWFM139142;
        Thu, 16 Jul 2020 17:57:23 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32aut4dnrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 17:57:23 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GLk9b6016594;
        Thu, 16 Jul 2020 21:57:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 327529xy0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 21:57:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06GLvLTo58786132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 21:57:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 032F9BE051;
        Thu, 16 Jul 2020 21:57:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF126BE04F;
        Thu, 16 Jul 2020 21:57:17 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.8.110])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 21:57:17 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466098739.24747.5860501703617893464.stgit@hbathini.in.ibm.com> <87tuy88ai7.fsf@morokweng.localdomain> <929db6fe-b221-a514-8ea1-93227f8d47b0@linux.ibm.com>
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
Subject: Re: [PATCH v3 10/12] ppc64/kexec_file: prepare elfcore header for crashing kernel
In-reply-to: <929db6fe-b221-a514-8ea1-93227f8d47b0@linux.ibm.com>
Date:   Thu, 16 Jul 2020 18:57:15 -0300
Message-ID: <87a6zzcedg.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=100
 suspectscore=0 impostorscore=0 mlxlogscore=-1000 lowpriorityscore=0
 mlxscore=100 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> On 16/07/20 7:52 am, Thiago Jung Bauermann wrote:
>> 
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>> 
>>>  /**
>>> + * get_crash_memory_ranges - Get crash memory ranges. This list includes
>>> + *                           first/crashing kernel's memory regions that
>>> + *                           would be exported via an elfcore.
>>> + * @mem_ranges:              Range list to add the memory ranges to.
>>> + *
>>> + * Returns 0 on success, negative errno on error.
>>> + */
>>> +static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
>>> +{
>>> +	struct memblock_region *reg;
>>> +	struct crash_mem *tmem;
>>> +	int ret;
>>> +
>>> +	for_each_memblock(memory, reg) {
>>> +		u64 base, size;
>>> +
>>> +		base = (u64)reg->base;
>>> +		size = (u64)reg->size;
>>> +
>>> +		/* Skip backup memory region, which needs a separate entry */
>>> +		if (base == BACKUP_SRC_START) {
>>> +			if (size > BACKUP_SRC_SIZE) {
>>> +				base = BACKUP_SRC_END + 1;
>>> +				size -= BACKUP_SRC_SIZE;
>>> +			} else
>>> +				continue;
>>> +		}
>>> +
>>> +		ret = add_mem_range(mem_ranges, base, size);
>>> +		if (ret)
>>> +			goto out;
>>> +
>>> +		/* Try merging adjacent ranges before reallocation attempt */
>>> +		if ((*mem_ranges)->nr_ranges == (*mem_ranges)->max_nr_ranges)
>>> +			sort_memory_ranges(*mem_ranges, true);
>>> +	}
>>> +
>>> +	/* Reallocate memory ranges if there is no space to split ranges */
>>> +	tmem = *mem_ranges;
>>> +	if (tmem && (tmem->nr_ranges == tmem->max_nr_ranges)) {
>>> +		tmem = realloc_mem_ranges(mem_ranges);
>>> +		if (!tmem)
>>> +			goto out;
>>> +	}
>>> +
>>> +	/* Exclude crashkernel region */
>>> +	ret = crash_exclude_mem_range(tmem, crashk_res.start, crashk_res.end);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	ret = add_rtas_mem_range(mem_ranges);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	ret = add_opal_mem_range(mem_ranges);
>>> +	if (ret)
>>> +		goto out;
>> 
>> Maybe I'm confused, but don't you add the RTAS and OPAL regions as
>> usable memory for the crashkernel? In that case they shouldn't show up
>> in the core file.
>
> kexec-tools does the same thing. I am not endorsing it but I was trying to stay
> in parity to avoid breaking any userspace tools/commands. But as you rightly
> pointed, this is NOT right. The right thing to do, to get the rtas/opal data at
> the time of crash, is to have a backup region for them just like we have for
> the first 64K memory. I was hoping to do that later.
>
> Will check how userspace tools respond to dropping these regions. If that makes
> the tools unhappy, will retain the regions with a FIXME. Sorry about the confusion.

No problem, thanks for the clarification.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
