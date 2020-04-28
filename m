Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A8C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9282064C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1EUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:20:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgD1EUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:20:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S44aiX124128;
        Tue, 28 Apr 2020 00:17:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pd53g8rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 00:17:28 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03S47gjm130005;
        Tue, 28 Apr 2020 00:17:27 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pd53g8pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 00:17:26 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03S45tWP018939;
        Tue, 28 Apr 2020 04:17:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 30mcu58gsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 04:17:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03S4HLNp41943218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 04:17:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79F1911C052;
        Tue, 28 Apr 2020 04:17:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6834611C04A;
        Tue, 28 Apr 2020 04:17:14 +0000 (GMT)
Received: from [9.199.43.234] (unknown [9.199.43.234])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Apr 2020 04:17:14 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch
 independent code
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S.Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-3-mike.kravetz@oracle.com>
 <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
 <5a380060-38db-b690-1003-678ca0f28f07@oracle.com>
 <b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Message-ID: <9c82a0b1-db0e-9b34-88a1-bc810d6b5eec@linux.ibm.com>
Date:   Tue, 28 Apr 2020 09:47:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_17:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 28/04/20 12:39 am, Mike Kravetz wrote:
> On 4/27/20 10:25 AM, Mike Kravetz wrote:
>> On 4/26/20 10:04 PM, Sandipan Das wrote:
>>> On 18/04/20 12:20 am, Mike Kravetz wrote:
>>>> Now that architectures provide arch_hugetlb_valid_size(), parsing
>>>> of "hugepagesz=" can be done in architecture independent code.
>>>
>>> This isn't working as expected on powerpc64.
>>>
>>>   [    0.000000] Kernel command line: root=UUID=dc7b49cf-95a2-4996-8e7d-7c64ddc7a6ff hugepagesz=16G hugepages=2 
>>>   [    0.000000] HugeTLB: huge pages not supported, ignoring hugepagesz = 16G
>>>   [    0.000000] HugeTLB: huge pages not supported, ignoring hugepages = 2
>>>   [    0.284177] HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
>>>   [    0.284182] HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
>>>   [    2.585062]     hugepagesz=16G
>>>   [    2.585063]     hugepages=2
>>>
>>
>> In the new arch independent version of hugepages_setup, I added the following
>> code in patch 4 off this series:
>>
>>> +	if (!hugepages_supported()) {
>>> +		pr_warn("HugeTLB: huge pages not supported, ignoring hugepages = %s\n", s);
>>> +		return 0;
>>> +	}
>>> +
>>
>> The easy solution is to remove all the hugepages_supported() checks from
>> command line parsing routines and rely on the later check in hugetlb_init().
> 
> Here is a patch to address the issue.  Sorry, as my series breaks all hugetlb
> command line processing on powerpc.
> 
> Sandipan, can you test the following patch?
> 

The following patch does fix the issue. Thanks.

Tested-by: Sandipan Das <sandipan@linux.ibm.com>


> From 480fe2847361e2a85aeec1fb39fe643bb7100a07 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Mon, 27 Apr 2020 11:37:30 -0700
> Subject: [PATCH] hugetlbfs: fix changes to command line processing
> 
> Previously, a check for hugepages_supported was added before processing
> hugetlb command line parameters.  On some architectures such as powerpc,
> hugepages_supported() is not set to true until after command line
> processing.  Therefore, no hugetlb command line parameters would be
> accepted.
> 
> Remove the additional checks for hugepages_supported.  In hugetlb_init,
> print a warning if !hugepages_supported and command line parameters were
> specified.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1075abdb5717..5548e8851b93 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3212,8 +3212,11 @@ static int __init hugetlb_init(void)
>  {
>  	int i;
>  
> -	if (!hugepages_supported())
> +	if (!hugepages_supported()) {
> +		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
> +			pr_warn("HugeTLB: huge pages not supported, ignoring associated command-line parameters\n");
>  		return 0;
> +	}
>  
>  	/*
>  	 * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
> @@ -3315,11 +3318,6 @@ static int __init hugepages_setup(char *s)
>  	unsigned long *mhp;
>  	static unsigned long *last_mhp;
>  
> -	if (!hugepages_supported()) {
> -		pr_warn("HugeTLB: huge pages not supported, ignoring hugepages = %s\n", s);
> -		return 0;
> -	}
> -
>  	if (!parsed_valid_hugepagesz) {
>  		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
>  		parsed_valid_hugepagesz = true;
> @@ -3372,11 +3370,6 @@ static int __init hugepagesz_setup(char *s)
>  	struct hstate *h;
>  
>  	parsed_valid_hugepagesz = false;
> -	if (!hugepages_supported()) {
> -		pr_warn("HugeTLB: huge pages not supported, ignoring hugepagesz = %s\n", s);
> -		return 0;
> -	}
> -
>  	size = (unsigned long)memparse(s, NULL);
>  
>  	if (!arch_hugetlb_valid_size(size)) {
> @@ -3424,11 +3417,6 @@ static int __init default_hugepagesz_setup(char *s)
>  	unsigned long size;
>  
>  	parsed_valid_hugepagesz = false;
> -	if (!hugepages_supported()) {
> -		pr_warn("HugeTLB: huge pages not supported, ignoring default_hugepagesz = %s\n", s);
> -		return 0;
> -	}
> -
>  	if (parsed_default_hugepagesz) {
>  		pr_err("HugeTLB: default_hugepagesz previously specified, ignoring %s\n", s);
>  		return 0;
> 
