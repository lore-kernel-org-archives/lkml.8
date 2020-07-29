Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21253C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18752083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgG2NBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:01:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgG2NBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:01:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06TCZaTh124587;
        Wed, 29 Jul 2020 09:00:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32hsqgumyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 09:00:39 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06TCbQ1q136668;
        Wed, 29 Jul 2020 09:00:38 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32hsqgumwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 09:00:38 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06TD0an3022946;
        Wed, 29 Jul 2020 13:00:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 32gcq0u44y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 13:00:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06TD0XDB59572686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 13:00:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36118AE099;
        Wed, 29 Jul 2020 13:00:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18FC5AE06E;
        Wed, 29 Jul 2020 13:00:28 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Jul 2020 13:00:27 +0000 (GMT)
Date:   Wed, 29 Jul 2020 16:00:25 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Justin He <Justin.He@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <Steve.Capper@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
Message-ID: <20200729130025.GD3672596@linux.ibm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <20200729093150.GC3672596@linux.ibm.com>
 <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_07:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=5 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=532 adultscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 11:35:20AM +0200, David Hildenbrand wrote:
> On 29.07.20 11:31, Mike Rapoport wrote:
> > Hi Justin,
> > 
> > On Wed, Jul 29, 2020 at 08:27:58AM +0000, Justin He wrote:
> >> Hi David
> >>>>
> >>>> Without this series, if qemu creates a 4G bytes nvdimm device, we can
> >>> only
> >>>> use 2G bytes for dax pmem(kmem) in the worst case.
> >>>> e.g.
> >>>> 240000000-33fdfffff : Persistent Memory
> >>>> We can only use the memblock between [240000000, 2ffffffff] due to the
> >>> hard
> >>>> limitation. It wastes too much memory space.
> >>>>
> >>>> Decreasing the SECTION_SIZE_BITS on arm64 might be an alternative, but
> >>> there
> >>>> are too many concerns from other constraints, e.g. PAGE_SIZE, hugetlb,
> >>>> SPARSEMEM_VMEMMAP, page bits in struct page ...
> >>>>
> >>>> Beside decreasing the SECTION_SIZE_BITS, we can also relax the kmem
> >>> alignment
> >>>> with memory_block_size_bytes().
> >>>>
> >>>> Tested on arm64 guest and x86 guest, qemu creates a 4G pmem device. dax
> >>> pmem
> >>>> can be used as ram with smaller gap. Also the kmem hotplug add/remove
> >>> are both
> >>>> tested on arm64/x86 guest.
> >>>>
> >>>
> >>> Hi,
> >>>
> >>> I am not convinced this use case is worth such hacks (that’s what it is)
> >>> for now. On real machines pmem is big - your example (losing 50% is
> >>> extreme).
> >>>
> >>> I would much rather want to see the section size on arm64 reduced. I
> >>> remember there were patches and that at least with a base page size of 4k
> >>> it can be reduced drastically (64k base pages are more problematic due to
> >>> the ridiculous THP size of 512M). But could be a section size of 512 is
> >>> possible on all configs right now.
> >>
> >> Yes, I once investigated how to reduce section size on arm64 thoughtfully:
> >> There are many constraints for reducing SECTION_SIZE_BITS
> >> 1. Given page->flags bits is limited, SECTION_SIZE_BITS can't be reduced too
> >>    much.
> >> 2. Once CONFIG_SPARSEMEM_VMEMMAP is enabled, section id will not be counted
> >>    into page->flags.
> >> 3. MAX_ORDER depends on SECTION_SIZE_BITS 
> >>  - 3.1 mmzone.h
> >> #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
> >> #error Allocator MAX_ORDER exceeds SECTION_SIZE
> >> #endif
> >>  - 3.2 hugepage_init()
> >> MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >= MAX_ORDER);
> >>
> >> Hence when ARM64_4K_PAGES && CONFIG_SPARSEMEM_VMEMMAP are enabled,
> >> SECTION_SIZE_BITS can be reduced to 27.
> >> But when ARM64_64K_PAGES, given 3.2, MAX_ORDER > 29-16 = 13.
> >> Given 3.1 SECTION_SIZE_BITS >= MAX_ORDER+15 > 28. So SECTION_SIZE_BITS can not
> >> be reduced to 27.
> >>
> >> In one word, if we considered to reduce SECTION_SIZE_BITS on arm64, the Kconfig
> >> might be very complicated,e.g. we still need to consider the case for
> >> ARM64_16K_PAGES.
> > 
> > It is not necessary to pollute Kconfig with that.
> > arch/arm64/include/asm/sparesemem.h can have something like
> > 
> > #ifdef CONFIG_ARM64_64K_PAGES
> > #define SPARSE_SECTION_SIZE 29
> > #elif defined(CONFIG_ARM16K_PAGES)
> > #define SPARSE_SECTION_SIZE 28
> > #elif defined(CONFIG_ARM4K_PAGES)
> > #define SPARSE_SECTION_SIZE 27
> > #else
> > #error
> > #endif
> 
> ack
> 
> >  
> > There is still large gap with ARM64_64K_PAGES, though.
> > 
> > As for SPARSEMEM without VMEMMAP, are there actual benefits to use it?
> 
> I was asking myself the same question a while ago and didn't really find
> a compelling one.

Memory overhead for VMEMMAP is larger, especially for arm64 that knows
how to free empty parts of the memory map with "classic" SPARSEMEM.
 
> I think it's always enabled as default (SPARSEMEM_VMEMMAP_ENABLE) and
> would require config tweaks to even disable it.

Nope, it's right there in menuconfig,

"Memory Management options" -> "Sparse Memory virtual memmap"

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
