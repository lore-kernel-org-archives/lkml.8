Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C56C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB35C2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgG0Oiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:38:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732871AbgG0Oiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:38:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06REWGiC063319;
        Mon, 27 Jul 2020 10:38:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32hrcyfspx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 10:38:01 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06REYfZu074767;
        Mon, 27 Jul 2020 10:38:00 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32hrcyfspf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 10:38:00 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06REZGnr017269;
        Mon, 27 Jul 2020 14:37:59 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 32gcy2x7wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 14:37:59 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06REbwP559441424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 14:37:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0DFDB2064;
        Mon, 27 Jul 2020 14:37:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A07F8B205F;
        Mon, 27 Jul 2020 14:37:53 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.79.210.187])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 14:37:53 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "H.Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        akpm@linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
In-Reply-To: <c0c9f0a4-ae2c-e3e5-1df8-884f8300066c@oracle.com>
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
 <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
 <20200716081243.GA6561@willie-the-truck>
 <a867c7a2-e89b-2015-4895-f30f7aeb07cb@oracle.com>
 <81103d30-f4fd-8807-03f9-d131da5097bd@arm.com>
 <1efdfe52-abdb-3931-742c-70e4a170e403@oracle.com>
 <11b03fcd-c210-032c-16d2-79ada41e0349@arm.com>
 <c0c9f0a4-ae2c-e3e5-1df8-884f8300066c@oracle.com>
Date:   Mon, 27 Jul 2020 20:07:51 +0530
Message-ID: <874kptm3b4.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_08:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1011 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007270103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 7/19/20 11:22 PM, Anshuman Khandual wrote:
>> 
>> 
>> On 07/17/2020 10:32 PM, Mike Kravetz wrote:
>>> On 7/16/20 10:02 PM, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 07/16/2020 11:55 PM, Mike Kravetz wrote:
>>>>> >From 17c8f37afbf42fe7412e6eebb3619c6e0b7e1c3c Mon Sep 17 00:00:00 2001
>>>>> From: Mike Kravetz <mike.kravetz@oracle.com>
>>>>> Date: Tue, 14 Jul 2020 15:54:46 -0700
>>>>> Subject: [PATCH] hugetlb: move cma reservation to code setting up gigantic
>>>>>  hstate
>>>>>
>>>>> Instead of calling hugetlb_cma_reserve() directly from arch specific
>>>>> code, call from hugetlb_add_hstate when adding a gigantic hstate.
>>>>> hugetlb_add_hstate is either called from arch specific huge page setup,
>>>>> or as the result of hugetlb command line processing.  In either case,
>>>>> this is late enough in the init process that all numa memory information
>>>>> should be initialized.  And, it is early enough to still use early
>>>>> memory allocator.
>>>>
>>>> This assumes that hugetlb_add_hstate() is called from the arch code at
>>>> the right point in time for the generic HugeTLB to do the required CMA
>>>> reservation which is not ideal. I guess it must have been a reason why
>>>> CMA reservation should always called by the platform code which knows
>>>> the boot sequence timing better.
>>>
>>> Actually, the code does not make the assumption that hugetlb_add_hstate
>>> is called from arch specific huge page setup.  It can even be called later
>>> at the time of hugetlb command line processing.
>> 
>> Yes, now that hugetlb_cma_reserve() has been moved into hugetlb_add_hstate().
>> But then there is an explicit warning while trying to mix both the command
>> line options i.e hugepagesz= and hugetlb_cma=. The proposed code here have
>> not changed that behavior and hence the following warning should have been
>> triggered here as well.
>> 
>> 1) hugepagesz_setup()
>> 	hugetlb_add_hstate()
>> 		 hugetlb_cma_reserve()
>> 
>> 2) hugepages_setup()
>> 	hugetlb_hstate_alloc_pages()	when order >= MAX_ORDER
>> 
>> 	if (hstate_is_gigantic(h)) {
>>         	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
>>                 	pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
>> 			break;
>>                 }
>> 		if (!alloc_bootmem_huge_page(h))
>>                 break;
>> 	}
>> 
>> Nonetheless, it does not make sense to mix both memblock and CMA based huge
>> page pre-allocations. But looking at this again, could this warning be ever
>> triggered till now ? Unless, a given platform calls hugetlb_cma_reserve()
>> before _setup("hugepages=", hugepages_setup). Anyways, there seems to be
>> good reasons to keep both memblock and CMA based pre-allocations in place.
>> But mixing them together (as done in the proposed code here) does not seem
>> to be right.
>
> I'm not sure if I follow the question.
>
> This proposal does not change the trigger for the warning printed when one
> tries to both reserve CMA and pre-allocate gigantic pages.  If hugetlb_cma
> is specified on the command line, and someone tries to pre-allocate gigantic
> pages they will get the warning.  Such a command line on x86 might look like,
> hugetlb_cma=4G hugepagesz=1G hugepages=4
>
> You will then see,
> [    0.065864] HugeTLB: hugetlb_cma is enabled, skip boot time allocation
> [    0.065866] HugeTLB: allocating 4 of page size 1.00 GiB failed.  Only allocated 0 hugepages.
>
> Ideally we could/should eliminate the second message.
> This behavior exists in the current code.

There is variant of this which is pseries powerpc where there is
hypervisor assistance w.r.t allocating gigantic pages. See the ppc64
enablement patch 

https://lore.kernel.org/linuxppc-dev/20200713150749.25245-1-aneesh.kumar@linux.ibm.com/

-aneesh
