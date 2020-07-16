Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8862C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E162082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGPVI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:08:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725957AbgGPVI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:08:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GL3C5T019388;
        Thu, 16 Jul 2020 17:08:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32aj74s8by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 17:08:21 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GL44oW022538;
        Thu, 16 Jul 2020 17:08:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32aj74s8bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 17:08:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GKp5AH028079;
        Thu, 16 Jul 2020 21:08:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 327527x08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 21:08:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06GL6rlH65077642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 21:06:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F93AE045;
        Thu, 16 Jul 2020 21:08:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80CCAAE055;
        Thu, 16 Jul 2020 21:08:13 +0000 (GMT)
Received: from [9.102.2.181] (unknown [9.102.2.181])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jul 2020 21:08:13 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 03/12] powerpc/kexec_file: add helper functions for
 getting memory ranges
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
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
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466087136.24747.16494497863685481495.stgit@hbathini.in.ibm.com>
 <874kq98xo4.fsf@morokweng.localdomain>
Message-ID: <5bacae70-7a01-7d37-89fe-ea896d6ac63e@linux.ibm.com>
Date:   Fri, 17 Jul 2020 02:38:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <874kq98xo4.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 phishscore=0
 spamscore=100 mlxscore=100 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=-1000 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007160139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/07/20 5:19 am, Thiago Jung Bauermann wrote:
> 

<snip>

> <snip>
> 
>> +/**
>> + * get_mem_rngs_size - Get the allocated size of mrngs based on
>> + *                     max_nr_ranges and chunk size.
>> + * @mrngs:             Memory ranges.
>> + *
>> + * Returns the maximum no. of ranges.
> 
> This isn't correct. It returns the maximum size of @mrngs.

True. Will update..

> <snip>
> 
>> +/**
>> + * add_tce_mem_ranges - Adds tce-table range to the given memory ranges list.
>> + * @mem_ranges:         Range list to add the memory range(s) to.
>> + *
>> + * Returns 0 on success, negative errno on error.
>> + */
>> +int add_tce_mem_ranges(struct crash_mem **mem_ranges)
>> +{
>> +	struct device_node *dn;
>> +	int ret;
>> +
>> +	for_each_node_by_type(dn, "pci") {
>> +		u64 base;
>> +		u32 size;
>> +
>> +		ret = of_property_read_u64(dn, "linux,tce-base", &base);
>> +		ret |= of_property_read_u32(dn, "linux,tce-size", &size);
>> +		if (!ret)
> 
> Shouldn't the condition be `ret` instead of `!ret`?

Oops! Will fix it.

>> +/**
>> + * sort_memory_ranges - Sorts the given memory ranges list.
>> + * @mem_ranges:         Range list to sort.
>> + * @merge:              If true, merge the list after sorting.
>> + *
>> + * Returns nothing.
>> + */
>> +void sort_memory_ranges(struct crash_mem *mrngs, bool merge)
>> +{
>> +	struct crash_mem_range *rngs;
>> +	struct crash_mem_range rng;
>> +	int i, j, idx;
>> +
>> +	if (!mrngs)
>> +		return;
>> +
>> +	/* Sort the ranges in-place */
>> +	rngs = &mrngs->ranges[0];
>> +	for (i = 0; i < mrngs->nr_ranges; i++) {
>> +		idx = i;
>> +		for (j = (i + 1); j < mrngs->nr_ranges; j++) {
>> +			if (rngs[idx].start > rngs[j].start)
>> +				idx = j;
>> +		}
>> +		if (idx != i) {
>> +			rng = rngs[idx];
>> +			rngs[idx] = rngs[i];
>> +			rngs[i] = rng;
>> +		}
>> +	}
> 
> Would it work using sort() from lib/sort.c here?

Yeah. I think we could reuse it with a simple compare callback. Will do that.

Thanks
Hari
