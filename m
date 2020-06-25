Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2660C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BEE2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbgFYMBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:01:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404285AbgFYMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:01:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PBa7fA164541;
        Thu, 25 Jun 2020 08:01:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vts0hfce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 08:01:25 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PBaUB3170434;
        Thu, 25 Jun 2020 08:01:24 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vts0hfbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 08:01:24 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PBxj3i010065;
        Thu, 25 Jun 2020 12:01:23 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 31uurtbqb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 12:01:23 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PC1MR114156440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 12:01:22 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0804124058;
        Thu, 25 Jun 2020 12:01:22 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFE98124052;
        Thu, 25 Jun 2020 12:01:18 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.115.79])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 12:01:18 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Daniel Silsby <dansilsby@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/huge_memory.c: update tlb entry if pmd is changed
In-Reply-To: <07f78e99-6e59-0bce-8ac0-50d7c7600461@oracle.com>
References: <1592990792-1923-1-git-send-email-maobibo@loongson.cn>
 <1592990792-1923-2-git-send-email-maobibo@loongson.cn>
 <07f78e99-6e59-0bce-8ac0-50d7c7600461@oracle.com>
Date:   Thu, 25 Jun 2020 17:31:16 +0530
Message-ID: <87lfkbl5gz.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_05:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1011 phishscore=0
 suspectscore=8 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 6/24/20 2:26 AM, Bibo Mao wrote:
>> When set_pmd_at is called in function do_huge_pmd_anonymous_page,
>> new tlb entry can be added by software on MIPS platform.
>> 
>> Here add update_mmu_cache_pmd when pmd entry is set, and
>> update_mmu_cache_pmd is defined as empty excepts arc/mips platform.
>> This patch has no negative effect on other platforms except arc/mips
>> system.
>
> I am confused by this comment.  It appears that update_mmu_cache_pmd
> is defined as non-empty on arc, mips, powerpc and sparc architectures.
> Am I missing something?
>
> If those architectures do provide update_mmu_cache_pmd, then the previous
> patch and this one now call update_mmu_cache_pmd with the actual faulting
> address instead of the huge page aligned address.  This was intentional
> for mips.  However, are there any potential issues on the other architectures?
> I am no expert in any of those architectures.  arc looks like it could be
> problematic as update_mmu_cache_pmd calls update_mmu_cache and then
> operates on (address & PAGE_MASK).  That could now be different.
>

Also we added update_mmu_cache_pmd to update a THP entry. That could be
different from a hugetlb entry on some architectures. If we need to do
hugetlb equivalent for update_mmu_cache, we should add a different
function.

-aneesh
