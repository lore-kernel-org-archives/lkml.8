Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25BCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6C420704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZVR12+8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGQRD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:03:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58858 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgGQRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:03:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HGwCdC051024;
        Fri, 17 Jul 2020 17:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jYNO0+Oailn1mCGSYSTW+k8UQDhh58KKaKRy8a62Dfg=;
 b=ZVR12+8AQ/+x1jr/t5KkspwgFzKWkQX6qlePTN8IAlMPpZbP8wvJ6K+tz5R4IT5IjiOv
 gMlHief6PEjwOcBy9/FeuPThpFvPQ4C9jXIUbx8HbQbRkbc5VI2+wX5BS89vVfvHgCR0
 yM6K24taG6IuBqKQ3CU7wM1Q6N2d6nz5BgxIZqIhIiT4rvY8DTF4JdZ3n1CX5sizaJ78
 AtREaiO0TAG7qcJiRePk2XtKmWNaGxwD16SFKZAM4oMNAfyQzGrZM4sdiOez/qrugUT/
 MTag2/aUxkKB+ARF1XOb0fPPFtDGFr2UiTdhzEfNEAw1T27sMREkX24i06I3DyKZ4xjy DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 327s65xqg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 17:02:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HGwtLl003275;
        Fri, 17 Jul 2020 17:02:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32bf3k4m48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 17:02:26 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06HH2Kav005669;
        Fri, 17 Jul 2020 17:02:22 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 10:02:20 -0700
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1efdfe52-abdb-3931-742c-70e4a170e403@oracle.com>
Date:   Fri, 17 Jul 2020 10:02:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <81103d30-f4fd-8807-03f9-d131da5097bd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 bulkscore=0 phishscore=0 adultscore=0
 spamscore=100 mlxlogscore=-1000 suspectscore=0 malwarescore=0 mlxscore=100
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=100 priorityscore=1501 lowpriorityscore=0
 spamscore=100 clxscore=1015 bulkscore=0 mlxlogscore=-1000 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 10:02 PM, Anshuman Khandual wrote:
> 
> 
> On 07/16/2020 11:55 PM, Mike Kravetz wrote:
>> >From 17c8f37afbf42fe7412e6eebb3619c6e0b7e1c3c Mon Sep 17 00:00:00 2001
>> From: Mike Kravetz <mike.kravetz@oracle.com>
>> Date: Tue, 14 Jul 2020 15:54:46 -0700
>> Subject: [PATCH] hugetlb: move cma reservation to code setting up gigantic
>>  hstate
>>
>> Instead of calling hugetlb_cma_reserve() directly from arch specific
>> code, call from hugetlb_add_hstate when adding a gigantic hstate.
>> hugetlb_add_hstate is either called from arch specific huge page setup,
>> or as the result of hugetlb command line processing.  In either case,
>> this is late enough in the init process that all numa memory information
>> should be initialized.  And, it is early enough to still use early
>> memory allocator.
> 
> This assumes that hugetlb_add_hstate() is called from the arch code at
> the right point in time for the generic HugeTLB to do the required CMA
> reservation which is not ideal. I guess it must have been a reason why
> CMA reservation should always called by the platform code which knows
> the boot sequence timing better.

Actually, the code does not make the assumption that hugetlb_add_hstate
is called from arch specific huge page setup.  It can even be called later
at the time of hugetlb command line processing.

My 'reasoning' is that gigantic pages can currently be preallocated from
bootmem/memblock_alloc at the time of command line processing.  Therefore,
we should be able to reserve bootmem for CMA at the same time.  Is there
something wrong with this reasoning?  I tested this on x86 by removing the
call to hugetlb_add_hstate from arch specific code and instead forced the
call at command line processing time.  The ability to reserve CMA was the
same.

Yes, the CMA reservation interface says it should be called from arch
specific code.  However, if we currently depend on the ability to do
memblock_alloc at hugetlb command line processing time for gigantic page
preallocation, then I think we can do the CMA reservation here as well.

Thinking about it some more, I suppose there could be some arch code that
could call hugetlb_add_hstate too early in the boot process.  But, I do
not think we have an issue with calling it too late.
-- 
Mike Kravetz
