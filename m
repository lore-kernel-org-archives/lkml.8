Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D94C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0725F20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgGQEdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:33:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725300AbgGQEdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 00:33:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06H4Wj3E053058;
        Fri, 17 Jul 2020 00:33:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ax78h6b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 00:33:24 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06H4X2k6054144;
        Fri, 17 Jul 2020 00:33:24 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ax78h6as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 00:33:24 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06H4Tqg6028658;
        Fri, 17 Jul 2020 04:33:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 327527xeyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 04:33:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06H4Uf0551577236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 04:30:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C94652054;
        Fri, 17 Jul 2020 04:32:04 +0000 (GMT)
Received: from [9.102.1.129] (unknown [9.102.1.129])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 275C25204E;
        Fri, 17 Jul 2020 04:32:00 +0000 (GMT)
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
From:   Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <0684ed3d-0dde-8dce-f12c-72ef86bc91f9@linux.ibm.com>
Date:   Fri, 17 Jul 2020 10:02:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <874kq98xo4.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_03:2020-07-16,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 bulkscore=0
 adultscore=0 spamscore=100 priorityscore=1501 mlxscore=100
 mlxlogscore=-1000 phishscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/07/20 5:19 am, Thiago Jung Bauermann wrote:
> 
> Hello Hari,
> 
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
>> In kexec case, the kernel to be loaded uses the same memory layout as
>> the running kernel. So, passing on the DT of the running kernel would
>> be good enough.
>>
>> But in case of kdump, different memory ranges are needed to manage
>> loading the kdump kernel, booting into it and exporting the elfcore
>> of the crashing kernel. The ranges are exlude memory ranges, usable
> 
> s/exlude/exclude/
> 
>> memory ranges, reserved memory ranges and crash memory ranges.
>>
>> Exclude memory ranges specify the list of memory ranges to avoid while
>> loading kdump segments. Usable memory ranges list the memory ranges
>> that could be used for booting kdump kernel. Reserved memory ranges
>> list the memory regions for the loading kernel's reserve map. Crash
>> memory ranges list the memory ranges to be exported as the crashing
>> kernel's elfcore.
>>
>> Add helper functions for setting up the above mentioned memory ranges.
>> This helpers facilitate in understanding the subsequent changes better
>> and make it easy to setup the different memory ranges listed above, as
>> and when appropriate.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> Tested-by: Pingfan Liu <piliu@redhat.com>
> 

<snip>

>> +/**
>> + * add_reserved_ranges - Adds "/reserved-ranges" regions exported by f/w
>> + *                       to the given memory ranges list.
>> + * @mem_ranges:          Range list to add the memory ranges to.
>> + *
>> + * Returns 0 on success, negative errno on error.
>> + */
>> +int add_reserved_ranges(struct crash_mem **mem_ranges)
>> +{
>> +	int i, len, ret = 0;
>> +	const __be32 *prop;
>> +
>> +	prop = of_get_property(of_root, "reserved-ranges", &len);
>> +	if (!prop)
>> +		return 0;
>> +
>> +	/*
>> +	 * Each reserved range is an (address,size) pair, 2 cells each,
>> +	 * totalling 4 cells per range.
> 
> Can you assume that, or do you need to check the #address-cells and
> #size-cells properties of the root node?

Taken from early_reserve_mem_dt() which did not seem to care.
Should we be doing any different here?

Thanks
Hari
