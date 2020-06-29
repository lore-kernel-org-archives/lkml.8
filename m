Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA56BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8BA21941
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbgF2VWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:22:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbgF2Swk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TCaS58133515;
        Mon, 29 Jun 2020 08:44:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31xmxf2cda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 08:44:40 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TCafKU134876;
        Mon, 29 Jun 2020 08:44:40 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31xmxf2cck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 08:44:39 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TCTnpM001503;
        Mon, 29 Jun 2020 12:44:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 31wwr893s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 12:44:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TCiY8U51445968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 12:44:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39F1911C05B;
        Mon, 29 Jun 2020 12:44:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA3911C052;
        Mon, 29 Jun 2020 12:44:33 +0000 (GMT)
Received: from osiris (unknown [9.171.82.53])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Jun 2020 12:44:33 +0000 (GMT)
Date:   Mon, 29 Jun 2020 14:44:32 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Message-ID: <20200629124432.GE4468@osiris>
References: <20200417150151.17239-1-david@redhat.com>
 <20200417150151.17239-3-david@redhat.com>
 <20200626163215.GA4268@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626163215.GA4268@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=813 lowpriorityscore=0 suspectscore=2 bulkscore=0 phishscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006290088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 06:32:15PM +0200, Heiko Carstens wrote:
> On Fri, Apr 17, 2020 at 05:01:51PM +0200, David Hildenbrand wrote:
> > Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
> > 	"The original bootmem allocator is getting replaced by memblock. To
> > 	cover the needs of the s390 kdump implementation the physical
> > 	memory list is used."
> > 
> > zcore was converted to use resources instead of memblocks.
> > memblock_discard() will *not* mess with "physmem", only with "memory" and
> > "reserved" memblocks. So, that data will stay after early boot, to be
> > used in arch/s390/kernel/crash_dump.c to create the ELF header from
> > inside the 2nd (a.k.a. dumping) kernel.
> > 
> > We no longer need ARCH_KEEP_MEMBLOCK.
> > 
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  arch/s390/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Applied, thanks!

Hmm, this triggers:

WARNING: modpost: vmlinux.o(.text+0x1e7c2): Section mismatch in reference from the function elfcorehdr_alloc() to the variable .meminit.data:memblock
The function elfcorehdr_alloc() references
the variable __meminitdata memblock.
This is often because elfcorehdr_alloc lacks a __meminitdata 
annotation or the annotation of memblock is wrong.

WARNING: modpost: vmlinux.o(.text+0x1e800): Section mismatch in reference from the function elfcorehdr_alloc() to the function .meminit.text:__next_mem_range()
The function elfcorehdr_alloc() references
the function __meminit __next_mem_range().
This is often because elfcorehdr_alloc lacks a __meminit 
annotation or the annotation of __next_mem_range is wrong.

WARNING: modpost: vmlinux.o(.text+0x1e844): Section mismatch in reference from the function elfcorehdr_alloc() to the function .meminit.text:__next_mem_range()
The function elfcorehdr_alloc() references
the function __meminit __next_mem_range().
This is often because elfcorehdr_alloc lacks a __meminit 
annotation or the annotation of __next_mem_range is wrong.

So, reverted again ;)
