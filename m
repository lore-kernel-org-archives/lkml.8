Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B432620781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgGAQ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:28:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731672AbgGAQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:28:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061G3RvQ001549;
        Wed, 1 Jul 2020 12:28:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32083fpsfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 12:28:40 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 061GEjEl048292;
        Wed, 1 Jul 2020 12:28:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32083fpsep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 12:28:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061GPcIU016721;
        Wed, 1 Jul 2020 16:28:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31wwr8d4ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 16:28:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 061GSY2m7668066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jul 2020 16:28:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 870DAA405F;
        Wed,  1 Jul 2020 16:28:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5A59A4065;
        Wed,  1 Jul 2020 16:28:33 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.198])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Jul 2020 16:28:33 +0000 (GMT)
Date:   Wed, 1 Jul 2020 19:28:31 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
Message-ID: <20200701162831.GB2999146@linux.ibm.com>
References: <20200701141830.18749-1-david@redhat.com>
 <20200701141830.18749-2-david@redhat.com>
 <20200701150643.GA2999146@linux.ibm.com>
 <20200701153157.GC5008@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701153157.GC5008@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=1 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:31:57PM +0200, Heiko Carstens wrote:
> On Wed, Jul 01, 2020 at 06:06:43PM +0300, Mike Rapoport wrote:
> > Hi David,
> > 
> > On Wed, Jul 01, 2020 at 04:18:29PM +0200, David Hildenbrand wrote:
> > > "physmem" in the memblock allocator is somewhat weird: it's not actually
> > > used for allocation, it's simply information collected during boot, which
> > > describes the unmodified physical memory map at boot time, without any
> > > standby/hotplugged memory. It's only used on s390x and is currently the
> > > only reason s390x keeps using CONFIG_ARCH_KEEP_MEMBLOCK.
> > > 
> > > Physmem isn't numa aware and current users don't specify any flags. Let's
> > > hide it from the user, exposing only for_each_physmem(), and simplify. The
> > > interface for physmem is now really minimalistic:
> > > - memblock_physmem_add() to add ranges
> > > - for_each_physmem() / __next_physmem_range() to walk physmem ranges
> > > 
> > > Don't place it into an __init section and don't discard it without
> > > CONFIG_ARCH_KEEP_MEMBLOCK. As we're reusing __next_mem_range(), remove
> > > the __meminit notifier to avoid section mismatch warnings once
> > > CONFIG_ARCH_KEEP_MEMBLOCK is no longer used with
> > > CONFIG_HAVE_MEMBLOCK_PHYS_MAP.
> > > 
> > > While fixing up the documentation, sneak in some related cleanups. We can
> > > stop setting CONFIG_HAVE_MEMBLOCK_PHYS_MAP for s390x next.
> > 
> > As you noted in the previous version it should have been
> > CONFIG_ARCH_KEEP_MEMBLOCK ;-)
> > 
> > > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > > ---
> > >  arch/s390/kernel/crash_dump.c |  6 ++--
> > >  include/linux/memblock.h      | 28 ++++++++++++++---
> > >  mm/memblock.c                 | 57 ++++++++++++++++++-----------------
> > >  3 files changed, 55 insertions(+), 36 deletions(-)
> 
> So I guess this should go via the s390 tree, since the second patch of
> this series can go only upstream if both this patch and a patch which
> is currently only on our features are merged before.
> 
> Any objections?

Not from my side.

-- 
Sincerely yours,
Mike.
