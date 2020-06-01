Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AE4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B36C206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFALnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:43:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgFALnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:43:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 051BXjDI092224;
        Mon, 1 Jun 2020 07:42:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bm06v7ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jun 2020 07:42:55 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 051BXoee092727;
        Mon, 1 Jun 2020 07:42:54 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bm06v7en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jun 2020 07:42:54 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 051BUid6019693;
        Mon, 1 Jun 2020 11:42:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 31bf481ktc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jun 2020 11:42:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 051BgoOp7733510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jun 2020 11:42:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08DEDAE055;
        Mon,  1 Jun 2020 11:42:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A2DEAE045;
        Mon,  1 Jun 2020 11:42:48 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.63.43])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  1 Jun 2020 11:42:48 +0000 (GMT)
Date:   Mon, 1 Jun 2020 14:42:46 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>,
        mgorman@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200601114246.GC8502@linux.ibm.com>
References: <20200521155225.GA20045@MiWiFi-R3L-srv>
 <20200521171836.GU1059226@linux.ibm.com>
 <20200522070114.GE26955@MiWiFi-R3L-srv>
 <20200522072524.GF26955@MiWiFi-R3L-srv>
 <20200522142053.GW1059226@linux.ibm.com>
 <20200526084543.GG26955@MiWiFi-R3L-srv>
 <20200526113244.GH13212@linux.ibm.com>
 <01beec81-565f-d335-5eff-22693fc09c0e@redhat.com>
 <20200528090731.GI20045@MiWiFi-R3L-srv>
 <20200528151510.GA6154@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528151510.GA6154@raspberrypi>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-01_07:2020-06-01,2020-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 cotscore=-2147483648 priorityscore=1501 clxscore=1011 mlxscore=0
 suspectscore=1 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:15:10AM -0500, Steve Wahl wrote:
> On Thu, May 28, 2020 at 05:07:31PM +0800, Baoquan He wrote:
> > On 05/26/20 at 01:49pm, David Hildenbrand wrote:
> > > On 26.05.20 13:32, Mike Rapoport wrote:
> > > > Hello Baoquan,
> > > > 
> > > > I do not object to your original fix with careful check for pfn validity.
> > > > 
> > > > But I still think that the memory reserved by the firmware is still
> > > > memory and it should be added to memblock.memory. This way the memory
> > > 
> > > If it's really memory that could be read/written, I think I agree.
> > 
> > I would say some of them may not be allowed to be read/written, if I
> > understand it correctly. I roughly went through the x86 init code, there
> > are some places where mem region is marked as E820_TYPE_RESERVED so that
> > they are not touched after initialization. E.g:
> > 
> > 1) pfn 0
> > In trim_bios_range(), we set the pfn 0 as E820_TYPE_RESERVED. You can
> > see the code comment, this is a BIOS owned area, but not kernel RAM.
> > 
> > 2)GART reserved region
> > In early_gart_iommu_check(), GART IOMMU firmware will reserve a region
> > in an area, firmware designer won't map system RAM into that area.
> > 
> > And also intel_graphics_stolen(), arch_rmrr_sanity_check(), these
> > regions are not system RAM backed area, reading from or writting into
> > these area may cause error.
> > 
> > Futhermore, there's a KASLR bug found by HPE, its triggering and root
> > cause are written into below commit log. You can see that accessing to
> > firmware reserved region caused BIOS to halt system when cpu doing
> > speculative.
> > 
> > commit 2aa85f246c181b1fa89f27e8e20c5636426be624
> > Author: Steve Wahl <steve.wahl@hpe.com>
> > Date:   Tue Sep 24 16:03:55 2019 -0500
> > 
> >     x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area
> > 
> >     Our hardware (UV aka Superdome Flex) has address ranges marked
> >     reserved by the BIOS. Access to these ranges is caught as an error,
> >     causing the BIOS to halt the system.
> 
> Thank you for CC'ing me.  Coming into the middle of the conversation,
> I am trying to understand the implications of what's being discussed
> here, but not being very successful at it.
> 
> For the HPE UV hardware, the addresses listed in the reserved range
> must never be accessed, or (as we discovered) even be reachable by an
> active page table entry.  Any active page table entry covering the
> region allows the processor to issue speculative accesses to the
> region, resulting in the BIOS halt mentioned.
> 
> I'm not sure if the discussion above about adding the region to
> memblock.memory would result in an active mapping of the region or
> not.  If it did, we'd have problems.

The discussion is whether regions marked as E820_RESERVED should be
considered as RAM or not.

For the hardware that cannot tolerate acceses to these areas like HPE
UV, it should not :)

I still think that keeping them only in memblock.reserved creates more
problems than it solves, but simply adding E820_RESERVED areas to
memblock.memory just won't work.

I'll try to come up with something better Really Soon (c).

> Thanks,
> 
> Steve Wahl, HPE

-- 
Sincerely yours,
Mike.
