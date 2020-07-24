Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1D7C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C96E2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgGXOdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:33:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgGXOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:33:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OEV87K120301;
        Fri, 24 Jul 2020 10:33:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fat2xauf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 10:33:01 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06OEVD4K120896;
        Fri, 24 Jul 2020 10:33:01 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fat2xaru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 10:33:01 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OEUX0I029871;
        Fri, 24 Jul 2020 14:32:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 32brq842uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 14:32:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06OEVR6w34734474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 14:31:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24D80A4053;
        Fri, 24 Jul 2020 14:32:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB2EEA4059;
        Fri, 24 Jul 2020 14:32:51 +0000 (GMT)
Received: from osiris (unknown [9.171.73.247])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Jul 2020 14:32:51 +0000 (GMT)
Date:   Fri, 24 Jul 2020 16:32:50 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 0/9] s390: implement and optimize vmemmap_free()
Message-ID: <20200724143250.GB4063@osiris>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_04:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=906
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:45:49AM +0200, David Hildenbrand wrote:
> This series is based on the latest s390/features branch [1]. It
> consolidates vmem_add_range(), vmem_remove_range(), and vmemmap_populate()
> into a single, recursive page table walker. It then implements
> vmemmap_free() and optimizes it by
> - Freeing empty page tables (also done for vmem_remove_range()).
> - Handling cases where the vmemmap of a section does not fill huge pages
>   completely (e.g., sizeof(struct page) == 56).
> 
> vmemmap_free() is currently never used, unless adiing standby memory fails
> (unlikely). This is relevant for virtio-mem, which adds/removes memory
> in memory block/section granularity (always removes memory in the same
> granularity it added it).
> 
> I gave this a proper test with my virtio-mem prototype (which I will share
> in the near future), both with 56 byte memmap per page and 64 byte memmap
> per page, with and without huge page support. In both cases, removing
> memory (routed through arch_remove_memory()) will result in
> - all populated vmemmap pages to get removed/freed
> - all applicable page tables for the vmemmap getting removed/freed
> - all applicable page tables for the idendity mapping getting removed/freed
> Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
> environments.
> 
> This is the basis for real memory hotunplug support for s390x and should
> complete my journey to s390x vmem/vmemmap code for now
> 
> What needs double-checking is tlb flushing. AFAIKS, as there are no valid
> accesses, doing a single range flush at the end is sufficient, both when
> removing vmemmap pages and the idendity mapping.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features
> 
> v1 -> v2:
> - Convert to a single page table walker named "modify_pagetable()", with
>   two helper functions "add_pagetable()" and "remove_pagetable().
> 
> David Hildenbrand (9):
>   s390/vmem: rename vmem_add_mem() to vmem_add_range()
>   s390/vmem: consolidate vmem_add_range() and vmem_remove_range()
>   s390/vmemmap: extend modify_pagetable() to handle vmemmap
>   s390/vmemmap: cleanup when vmemmap_populate() fails
>   s390/vmemmap: take the vmem_mutex when populating/freeing
>   s390/vmem: cleanup empty page tables
>   s390/vmemmap: fallback to PTEs if mapping large PMD fails
>   s390/vmemmap: remember unused sub-pmd ranges
>   s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive
>     sections
> 
>  arch/s390/mm/vmem.c | 637 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 442 insertions(+), 195 deletions(-)

Series applied, thank you!
