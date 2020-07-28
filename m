Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C227C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E317D2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgG1Tel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:34:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729646AbgG1Tel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:34:41 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SJX1aO120680;
        Tue, 28 Jul 2020 15:34:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jkw2dfpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 15:34:32 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06SJY200123410;
        Tue, 28 Jul 2020 15:34:32 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jkw2dfnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 15:34:32 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SJOcrn028997;
        Tue, 28 Jul 2020 19:34:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 32gcq0thxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 19:34:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06SJYQfe27001110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 19:34:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA5542045;
        Tue, 28 Jul 2020 19:34:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 930E94203F;
        Tue, 28 Jul 2020 19:34:23 +0000 (GMT)
Received: from [9.85.75.143] (unknown [9.85.75.143])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jul 2020 19:34:23 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 06/11] ppc64/kexec_file: restrict memory usage
 of kdump kernel
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <159579231812.5790.16096865978767385505.stgit@hbathini>
 <875za77o05.fsf@mpe.ellerman.id.au>
From:   Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <23c4e7a2-6fbc-8007-5e9a-35c3a4d3898b@linux.ibm.com>
Date:   Wed, 29 Jul 2020 01:04:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875za77o05.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_16:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/20 7:14 pm, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>> index 2df6f4273ddd..8df085a22fd7 100644
>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -17,9 +17,21 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of_fdt.h>
>>   #include <linux/libfdt.h>
>> +#include <linux/of_device.h>
>>   #include <linux/memblock.h>
>> +#include <linux/slab.h>
>> +#include <asm/drmem.h>
>>   #include <asm/kexec_ranges.h>
>>   
>> +struct umem_info {
>> +	uint64_t *buf; /* data buffer for usable-memory property */
>> +	uint32_t idx;  /* current index */
>> +	uint32_t size; /* size allocated for the data buffer */
> 
> Use kernel types please, u64, u32.
> 
>> +	/* usable memory ranges to look up */
>> +	const struct crash_mem *umrngs;
> 
> "umrngs".
> 
> Given it's part of the umem_info struct could it just be "ranges"?

True. Actually, having crash_mem_range *ranges + u32 nr_ranges and 
populating them seems better. Will do that..

>> +		return NULL;
>> +	}
> 
> 	um_info->size = new_size;
> 
>> +
>> +	memset(tbuf + um_info->idx, 0, MEM_RANGE_CHUNK_SZ);
> 
> Just pass __GFP_ZERO to krealloc?

There are patches submitted to stable fixing a few modules that use 
krealloc with __GFP_ZERO. Also, this zeroing is not really needed.
I will drop the memset instead..

Thanks
Hari
