Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF03CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FA220708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGHWL1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:11:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2537 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbgGHWL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:11:27 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id D9DBF9BAF1658D408F63;
        Thu,  9 Jul 2020 06:11:24 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Thu, 9 Jul 2020 06:11:16 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma
 is enable
Thread-Topic: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma
 is enable
Thread-Index: AQHWVBOoulIbQRW0JUWzWUpoYRXjrqj8AzOAgAFtnQCAABEKgIAAvWLg
Date:   Wed, 8 Jul 2020 22:11:15 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2560E41@DGGEMI525-MBS.china.huawei.com>
References: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
 <20200707125641.dbd2ccd63f525aa5870069d8@linux-foundation.org>
 <9066e009-5ed2-1992-d70d-fd27b4bf5871@oracle.com>
 <20200708184615.GA251665@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200708184615.GA251665@carbon.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.83]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Roman Gushchin [mailto:guro@fb.com]
> Sent: Thursday, July 9, 2020 6:46 AM
> To: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Jonathan
> Cameron <jonathan.cameron@huawei.com>
> Subject: Re: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma
> is enable
> 
> On Wed, Jul 08, 2020 at 10:45:16AM -0700, Mike Kravetz wrote:
> > On 7/7/20 12:56 PM, Andrew Morton wrote:
> > > On Tue, 7 Jul 2020 16:02:04 +1200 Barry Song
> <song.bao.hua@hisilicon.com> wrote:
> > >
> > >> hugetlb_cma[0] can be NULL due to various reasons, for example, node0
> has
> > >> no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> > >> enabled. gigantic pages might have been reserved on other nodes.
> > >
> > > I'm trying to figure out whether this should be backported into 5.7.1,
> > > but the changelog doesn't describe any known user-visible effects of
> > > the bug.  Are there any?
> >
> > Barry must have missed this email.  He reported the issue so I was hoping
> > he would reply.

Yep. it should be better to backport it into 5.7. it doesn't cause serious crash or failure,
but could cause double reservation or cma leak.

> >
> > Based on the code changes, I believe the following could happen:
> > - Someone uses 'hugetlb_cma=' kernel command line parameter to reserve
> >   CMA for gigantic pages.
> > - The system topology is such that no memory is on node 0.  Therefore,
> >   no CMA can be reserved for gigantic pages on node 0.  CMA is reserved
> >   on other nodes.
> > - The user also specifies a number of gigantic pages to pre-allocate on
> >   the command line with hugepagesz=<gigantic_page_size> hugepages=<N>
> > - The routine which allocates gigantic pages from the bootmem allocator
> >   will not detect CMA has been reserved as there is no memory on node 0.
> >   Therefore, pages will be pre-allocated from bootmem allocator as well
> >   as reserved in CMA.
> >
> > This double allocation (bootmem and CMA) is the worst case scenario.  Not
> > sure if this is what Barry saw, and I suspect this would rarely happen.
> >
> > After writing this, I started to think that perhaps command line parsing
> > should be changed.  If hugetlb_cma= is specified, it makes no sense to
> > pre-allocate gigantic pages.  Therefore, the hugepages=<N> paramemter
> > should be ignored and flagged with a warning if  hugetlb_cma= is specified.
> > This could be checked at parsing time and there would be no need for such
> > a check in the allocation code (except for sanity cheching).
> >
> > Thoughts?  I just cleaned up the parsing code and could make such a
> change
> > quite easily.
> 
> I agree. Basically, if hugetlb_cma_size > 0, we should not pre-allocate
> gigantic pages. It would be much simpler and more reliable than the existing
> code.

I agree this is a better solution, if hugetlb_cma has higher priority than bootmem gigantic pages,
we should document it.

> 
> Thank you!

Thanks
Barry

