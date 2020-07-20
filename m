Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4796122B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1wpLkVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgGTSS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:18:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60860 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGTSS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:18:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KIGPwX130251;
        Mon, 20 Jul 2020 18:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tqOn5ouunZazfKbwRP0ZmjENwAJZBiN0o9LArs8Rw/0=;
 b=g1wpLkVYH0InQUSYqloSTjK3lqIvHkHGRHtDNc2eUJwvjKuSv1kahDRzcErtOZV8qB7N
 Dt57NzC6RRLIGodC/Xp1S7vV0LKiN6kJ/6VsRhMQD1Yc7mJc6vTo+BqRxds8pxa/Xbfd
 I8jsTpkd3b2fi4ivYWtxy14bnICSumHub40FrWiCQIHAg70kOjaT9U49hCfbsIVR7P6C
 y5OxN0z51ZJB0WBGUGTqhouK4/d/W5kd3T+yqvT3GoA1qtO8SdeLtXWsv3strptuuPs2
 seKnr7a72jpPWbjc8QumRM/onDPSE1RARIwwZ/3fGFdysC9f7h9mKY4xod4LH2I/JD31 FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32brgr8kpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 18:17:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KI2w1K078704;
        Mon, 20 Jul 2020 18:17:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32da2dftqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 18:17:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KIHXFn011383;
        Mon, 20 Jul 2020 18:17:34 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 18:17:33 +0000
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
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
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
 <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
 <20200716081243.GA6561@willie-the-truck>
 <a867c7a2-e89b-2015-4895-f30f7aeb07cb@oracle.com>
 <81103d30-f4fd-8807-03f9-d131da5097bd@arm.com>
 <1efdfe52-abdb-3931-742c-70e4a170e403@oracle.com>
 <11b03fcd-c210-032c-16d2-79ada41e0349@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c0c9f0a4-ae2c-e3e5-1df8-884f8300066c@oracle.com>
Date:   Mon, 20 Jul 2020 11:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <11b03fcd-c210-032c-16d2-79ada41e0349@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 11:22 PM, Anshuman Khandual wrote:
> 
> 
> On 07/17/2020 10:32 PM, Mike Kravetz wrote:
>> On 7/16/20 10:02 PM, Anshuman Khandual wrote:
>>>
>>>
>>> On 07/16/2020 11:55 PM, Mike Kravetz wrote:
>>>> >From 17c8f37afbf42fe7412e6eebb3619c6e0b7e1c3c Mon Sep 17 00:00:00 2001
>>>> From: Mike Kravetz <mike.kravetz@oracle.com>
>>>> Date: Tue, 14 Jul 2020 15:54:46 -0700
>>>> Subject: [PATCH] hugetlb: move cma reservation to code setting up gigantic
>>>>  hstate
>>>>
>>>> Instead of calling hugetlb_cma_reserve() directly from arch specific
>>>> code, call from hugetlb_add_hstate when adding a gigantic hstate.
>>>> hugetlb_add_hstate is either called from arch specific huge page setup,
>>>> or as the result of hugetlb command line processing.  In either case,
>>>> this is late enough in the init process that all numa memory information
>>>> should be initialized.  And, it is early enough to still use early
>>>> memory allocator.
>>>
>>> This assumes that hugetlb_add_hstate() is called from the arch code at
>>> the right point in time for the generic HugeTLB to do the required CMA
>>> reservation which is not ideal. I guess it must have been a reason why
>>> CMA reservation should always called by the platform code which knows
>>> the boot sequence timing better.
>>
>> Actually, the code does not make the assumption that hugetlb_add_hstate
>> is called from arch specific huge page setup.  It can even be called later
>> at the time of hugetlb command line processing.
> 
> Yes, now that hugetlb_cma_reserve() has been moved into hugetlb_add_hstate().
> But then there is an explicit warning while trying to mix both the command
> line options i.e hugepagesz= and hugetlb_cma=. The proposed code here have
> not changed that behavior and hence the following warning should have been
> triggered here as well.
> 
> 1) hugepagesz_setup()
> 	hugetlb_add_hstate()
> 		 hugetlb_cma_reserve()
> 
> 2) hugepages_setup()
> 	hugetlb_hstate_alloc_pages()	when order >= MAX_ORDER
> 
> 	if (hstate_is_gigantic(h)) {
>         	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
>                 	pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> 			break;
>                 }
> 		if (!alloc_bootmem_huge_page(h))
>                 break;
> 	}
> 
> Nonetheless, it does not make sense to mix both memblock and CMA based huge
> page pre-allocations. But looking at this again, could this warning be ever
> triggered till now ? Unless, a given platform calls hugetlb_cma_reserve()
> before _setup("hugepages=", hugepages_setup). Anyways, there seems to be
> good reasons to keep both memblock and CMA based pre-allocations in place.
> But mixing them together (as done in the proposed code here) does not seem
> to be right.

I'm not sure if I follow the question.

This proposal does not change the trigger for the warning printed when one
tries to both reserve CMA and pre-allocate gigantic pages.  If hugetlb_cma
is specified on the command line, and someone tries to pre-allocate gigantic
pages they will get the warning.  Such a command line on x86 might look like,
hugetlb_cma=4G hugepagesz=1G hugepages=4

You will then see,
[    0.065864] HugeTLB: hugetlb_cma is enabled, skip boot time allocation
[    0.065866] HugeTLB: allocating 4 of page size 1.00 GiB failed.  Only allocated 0 hugepages.

Ideally we could/should eliminate the second message.
This behavior exists in the current code.

>> My 'reasoning' is that gigantic pages can currently be preallocated from
>> bootmem/memblock_alloc at the time of command line processing.  Therefore,
>> we should be able to reserve bootmem for CMA at the same time.  Is there
>> something wrong with this reasoning?  I tested this on x86 by removing the
>> call to hugetlb_add_hstate from arch specific code and instead forced the
>> call at command line processing time.  The ability to reserve CMA was the
>> same.
> 
> There is no problem with that reasoning. __setup() triggered function should
> be able perform CMA reservation. But as pointed out before, it does not make
> sense to mix both CMA reservation and memblock based pre-allocation.

Agree.  I am not proposing we do.  Sorry, if you got that impression.

>> Yes, the CMA reservation interface says it should be called from arch
>> specific code.  However, if we currently depend on the ability to do
>> memblock_alloc at hugetlb command line processing time for gigantic page
>> preallocation, then I think we can do the CMA reservation here as well.
> 
> IIUC, CMA reservation and memblock alloc have some differences in terms of
> how the memory can be used later on, will have to dig deeper on this. But
> the comment section near cma_declare_contiguous_nid() is a concern.
> 
>  * This function reserves memory from early allocator. It should be
>  * called by arch specific code once the early allocator (memblock or bootmem)
>  * has been activated and all other subsystems have already allocated/reserved
>  * memory. This function allows to create custom reserved areas.
> 

Yes, that is the comment I was looking at as well.

However, note that hugetlb pre-allocation of gigantic pages will end up
calling memblock_alloc_range_nid.  This is the same routine used for CMA
reservations/allocations from cma_declare_contiguous_nid.  This is why
there should be no issue with doing CMA reservations at this time.

This may be the confusing part.  I am not saying we would do CMA reservations
and pre-allocations together.  Rather, they both rely on the underlying code so
we can call them at the same time in the init process.

>> Thinking about it some more, I suppose there could be some arch code that
>> could call hugetlb_add_hstate too early in the boot process.  But, I do
>> not think we have an issue with calling it too late.
>>
> 
> Calling it too late might have got the page allocator initialized completely
> and then CMA reservation would not be possible afterwards. Also calling it
> too early would prevent other subsystems which might need memory reservation
> in specific physical ranges.

I thought about it some more and came up with a way to do all this at command
line processing time.  It will take me a day or two to put together.

The patch from Barry which started this thread is indeed needed and is in
Andrew's tree.  I'll start another thread with a patch to move CMA reservations
to command line processing.
-- 
Mike Kravetz
