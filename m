Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549ED2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgG2ONc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:13:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbgG2ON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:13:28 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06TE25Et133130;
        Wed, 29 Jul 2020 10:13:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32jg248neb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 10:13:13 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06TE2IcL134462;
        Wed, 29 Jul 2020 10:13:12 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32jg248nd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 10:13:12 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06TE54n7014351;
        Wed, 29 Jul 2020 14:13:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 32gcqk34qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 14:13:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06TEBgMf62128482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 14:11:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD224AE061;
        Wed, 29 Jul 2020 14:13:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B073AE056;
        Wed, 29 Jul 2020 14:12:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Jul 2020 14:12:57 +0000 (GMT)
Date:   Wed, 29 Jul 2020 17:12:54 +0300
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
Message-ID: <20200729141254.GE3672596@linux.ibm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <20200729093150.GC3672596@linux.ibm.com>
 <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
 <20200729130025.GD3672596@linux.ibm.com>
 <170d7861-4df8-ecaf-dbdd-9e9a4a832f8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170d7861-4df8-ecaf-dbdd-9e9a4a832f8f@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_07:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=550 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:03:04PM +0200, David Hildenbrand wrote:
> On 29.07.20 15:00, Mike Rapoport wrote:
> > On Wed, Jul 29, 2020 at 11:35:20AM +0200, David Hildenbrand wrote:
> >>>  
> >>> There is still large gap with ARM64_64K_PAGES, though.
> >>>
> >>> As for SPARSEMEM without VMEMMAP, are there actual benefits to use it?
> >>
> >> I was asking myself the same question a while ago and didn't really find
> >> a compelling one.
> > 
> > Memory overhead for VMEMMAP is larger, especially for arm64 that knows
> > how to free empty parts of the memory map with "classic" SPARSEMEM.
> 
> You mean the hole punching within section memmap? (which is why their
> pfn_valid() implementation is special)

Yes, arm (both 32 and 64) do this. And for smaller systems with a few
memory banks this is very reasonable to trade slight (if any) slowdown
in pfn_valid() for several megs of memory.
 
> (I do wonder why that shouldn't work with VMEMMAP, or is it simply not
> implemented?)
 
It's not implemented. There was a patch [1] recently to implement this. 

[1] https://lore.kernel.org/lkml/20200721073203.107862-1-liwei213@huawei.com/

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
