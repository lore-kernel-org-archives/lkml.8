Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8671BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5116F20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGPVKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:10:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgGPVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:10:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GL3B88056822;
        Thu, 16 Jul 2020 17:10:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32auqucwen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 17:10:47 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GL5nPs066215;
        Thu, 16 Jul 2020 17:10:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32auqucwdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 17:10:47 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GLA8UB014886;
        Thu, 16 Jul 2020 21:10:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 329nmyj6xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 21:10:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06GLAf2Q54198436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 21:10:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE184AE051;
        Thu, 16 Jul 2020 21:10:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ECCFAE04D;
        Thu, 16 Jul 2020 21:10:38 +0000 (GMT)
Received: from [9.102.2.181] (unknown [9.102.2.181])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jul 2020 21:10:38 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 09/12] ppc64/kexec_file: setup backup region for kdump
 kernel
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>,
        Nayna Jain <nayna@linux.ibm.com>,
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
 <159466096898.24747.16701009925943468066.stgit@hbathini.in.ibm.com>
 <87y2nk8cjq.fsf@morokweng.localdomain>
Message-ID: <bea19627-c6b7-5d59-e194-03038bb4d9f6@linux.ibm.com>
Date:   Fri, 17 Jul 2020 02:40:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87y2nk8cjq.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=100
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxscore=100 mlxlogscore=-1000 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007160139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/07/20 7:08 am, Thiago Jung Bauermann wrote:
> 
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
>> @@ -968,7 +1040,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>>
>>  	/*
>>  	 * Restrict memory usage for kdump kernel by setting up
>> -	 * usable memory ranges.
>> +	 * usable memory ranges and memory reserve map.
>>  	 */
>>  	if (image->type == KEXEC_TYPE_CRASH) {
>>  		ret = get_usable_memory_ranges(&umem);
>> @@ -980,6 +1052,24 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>>  			pr_err("Error setting up usable-memory property for kdump kernel\n");
>>  			goto out;
>>  		}
>> +
>> +		ret = fdt_add_mem_rsv(fdt, BACKUP_SRC_START + BACKUP_SRC_SIZE,
>> +				      crashk_res.start - BACKUP_SRC_SIZE);
> 
> I believe this answers my question from the other email about how the
> crashkernel is prevented from stomping in the crashed kernel's memory,
> right? I needed to think for a bit to understand what the above
> reservation was protecting. I think it's worth adding a comment.

Right. The reason to add it in the first place is, prom presses the panic button if
it can't find low memory. Marking it reserved seems to keep it quiet though. so..

Will add comment mentioning that..

>> +void purgatory(void)
>> +{
>> +	void *dest, *src;
>> +
>> +	src = (void *)BACKUP_SRC_START;
>> +	if (backup_start) {
>> +		dest = (void *)backup_start;
>> +		__memcpy(dest, src, BACKUP_SRC_SIZE);
>> +	}
>> +}
> 
> In general I'm in favor of using C code over assembly, but having to
> bring in that relocation support just for the above makes me wonder if
> it's worth it in this case.

I am planning to build on purgatory later with "I'm in purgatory" print support
for pseries at least and also, sha256 digest check.

Thanks
Hari
