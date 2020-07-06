Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C71C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD9C2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgGFNE0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:04:26 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729173AbgGFNEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:04:24 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D5D78A10EBC0DE971CF6;
        Mon,  6 Jul 2020 14:04:21 +0100 (IST)
Received: from localhost (10.52.123.111) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 6 Jul 2020
 14:04:21 +0100
Date:   Mon, 6 Jul 2020 14:03:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Justin He <Justin.He@arm.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kaly Xin <Kaly.Xin@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is
 fake
Message-ID: <20200706140317.00002f53@Huawei.com>
In-Reply-To: <AM6PR08MB4069BCD0E17BD37CC5591C63F7690@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200706011947.184166-1-justin.he@arm.com>
        <20200706011947.184166-2-justin.he@arm.com>
        <20200706112921.00006f7f@Huawei.com>
        <20200706114605.000050ac@Huawei.com>
        <AM6PR08MB4069BCD0E17BD37CC5591C63F7690@AM6PR08MB4069.eurprd08.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.123.111]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 12:47:51 +0000
Justin He <Justin.He@arm.com> wrote:

> Hi Jonathan, thanks for the comments.
> 
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Monday, July 6, 2020 6:46 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> > <will@kernel.org>; Andrew Morton <akpm@linux-foundation.org>; Mike
> > Rapoport <rppt@linux.ibm.com>; Baoquan He <bhe@redhat.com>; Chuhong Yuan
> > <hslester96@gmail.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-mm@kvack.org; Kaly Xin <Kaly.Xin@arm.com>
> > Subject: Re: [PATCH 1/3] arm64/numa: set numa_off to false when numa node
> > is fake
> > 
> > On Mon, 6 Jul 2020 11:29:21 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Mon, 6 Jul 2020 09:19:45 +0800
> > > Jia He <justin.he@arm.com> wrote:
> > >
> > > Hi,
> > >  
> > > > Previously, numa_off is set to true unconditionally in  
> > dummy_numa_init(),  
> > > > even if there is a fake numa node.
> > > >
> > > > But acpi will translate node id to NUMA_NO_NODE(-1) in  
> > acpi_map_pxm_to_node()  
> > > > because it regards numa_off as turning off the numa node.  
> > >
> > > That is correct.  It is operating exactly as it should, if SRAT hasn't  
> > been parsed  
> > > and you are on ACPI platform there are no nodes.  They cannot be created  
> > at  
> > > some later date.  The dummy code doesn't change this. It just does  
> > enough to carry  
> > > on operating with no specified nodes.
> > >  
> > > >
> > > > Without this patch, pmem can't be probed as a RAM device on arm64 if  
> > SRAT table  
> > > > isn't present.
> > > >
> > > > $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g  
> > -a 64K  
> > > > kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with  
> > invalid node: -1  
> > > > kmem: probe of dax0.0 failed with error -22
> > > >
> > > > This fixes it by setting numa_off to false.  
> > >
> > > Without the SRAT protection patch [1] you may well run into problems  
> 
> Sorry, doesn't quite understand here. Do you mean your [1] can resolve this
> issue? But acpi_map_pxm_to_node() has returned with NUMA_NO_NODE after
> following check:
> 	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS || numa_off)
> 		return NUMA_NO_NODE;

The point of that patch is it will make it safe to remove the numa_off because
any later accidental reference to a non existent node (i.e. one not defined
in SRAT) will not blow up.

It doesn't fix your original problem. What it does do, is fix the new problem case
you introduce by removing numa_off below.  It ensures you still return NUMA_NO_NODE
in cases which should do so (i.e. all of them if you have no SRAT and are using ACPI).

Of course, you could just not remove the numa_off = true bit then you won't hit
that condition anyway. There are plenty of other reasons for the SRAT patch though,
it just happens to close a problem you were introducing here as well.

For reference we had an AMD platform that had no SRAT, but provided _PXM for
a few nodes in its DSDT.   That result in non booting systems.  It only affected
x86 because ARM64 had that numa_off = true being set.  If we change the arm64 case
without the patch to ensure the underlying problem is fixed, you are very likely to hit
the equivalent problem. There may well be platforms out there relying on that quirk
of what the code currently does.

> Seems even with your [1] patch, it is not helpful? Thanks for clarification
> if my understanding is wrong.
> [1] https://patchwork.kernel.org/patch/11632063/
> 
> > > because someone somewhere will have _PXM in a DSDT but will
> > > have a non existent SRAT.   We had this happen on an AMD platform when  
> > we  
> > > tried to introduce working _PXM support for PCI. [2]
> > >
> > > So whilst this seems superficially safe, I'd definitely be crossing your  
> > fingers.  
> > > Note, at that time I proposed putting the numa_off = false into the x86  
> > code  
> > > path precisely to cut out that possibility (was rejected at the time, at  
> > least  
> > > partly because the clarifications to the ACPI spec were not pubilc.)
> > >
> > > The patch in [1] should sort things out however by ensuring we only  
> > create  
> > > new domains where we should actually be doing so. However, in your case
> > > it will return NUMA_NO_NODE anyway so this isn't the right way to fix  
> > things.  
> 
> Okay, let me try to summarize, there might be 3 possible fixing ways:
> 1. this patch, seems it is not satisfied by you and David 😉
> 2. my previous proposal [2], similar as what David suggested

That looks like the correct approach to me as well.

> 3. remove numa_off check in acpi_map_pxm_to_node()

No way to that one.  The only right return value from acpi_map_pxm_to_node
when no node is provided (always the case if you have no SRAT) is
NUMA_NO_NODE.  Do not paper over that - fix the caller to handle
a perfectly valid return value.

Jonathan

> e.g.
> ...
> 	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS /*|| numa_off*/)
> 		return NUMA_NO_NODE;
> 
> [2] https://lkml.org/lkml/2019/8/16/367
> 
> 
> --
> Cheers,
> Justin (Jia He)
> 
> 


